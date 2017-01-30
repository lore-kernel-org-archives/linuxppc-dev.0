Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBvZL4yFMzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 03:13:14 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0UG8xmq123906
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 11:13:12 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28a6t0ej42-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 11:13:12 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 30 Jan 2017 09:13:11 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Update PROTFAULT handling in the page fault path
Date: Mon, 30 Jan 2017 21:42:59 +0530
Message-Id: <20170130161259.25937-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With radix, we can get page fault with DSISR_PROTFAULT value set in case of
PROT_NONE or autonuma mapping. The PROT_NONE case in handled by the vma check
where we consider the access bad. For autonuma we should fall through and fixup
the access mask correctly.

Without this patch we trigger the WARN_ON() on radix. This code moves that
WARN_ON() within a radix_enabled() check. I also moved the WARN_ON() outside
the if condition making it apply for all type of faults (exec/write/read). It
is also conditionalized for book3s, because BOOK3E can also get a PROTFAULT to
handle the D/I cache sync.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/copro_fault.c | 10 ++++++----
 arch/powerpc/mm/fault.c       | 43 +++++++++++++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index aaa7ec6788b9..697b70ad1195 100644
--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -67,11 +67,13 @@ int copro_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
 		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
 			goto out_unlock;
 		/*
-		 * protfault should only happen due to us
-		 * mapping a region readonly temporarily. PROT_NONE
-		 * is also covered by the VMA check above.
+		 * PROT_NONE is covered by the VMA check above.
+		 * and hash should get a NOHPTE fault instead of
+		 * a PROTFAULT in case fixup is needed for things
+		 * like autonuma.
 		 */
-		WARN_ON_ONCE(dsisr & DSISR_PROTFAULT);
+		if (!radix_enabled())
+			WARN_ON_ONCE(dsisr & DSISR_PROTFAULT);
 	}
 
 	ret = 0;
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 6fd30ac7d14a..c636137666c1 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -418,15 +418,6 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
 		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
 			goto bad_area;
-
-#ifdef CONFIG_PPC_STD_MMU
-		/*
-		 * protfault should only happen due to us
-		 * mapping a region readonly temporarily. PROT_NONE
-		 * is also covered by the VMA check above.
-		 */
-		WARN_ON_ONCE(error_code & DSISR_PROTFAULT);
-#endif /* CONFIG_PPC_STD_MMU */
 	/* a write */
 	} else if (is_write) {
 		if (!(vma->vm_flags & VM_WRITE))
@@ -436,8 +427,40 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	} else {
 		if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
 			goto bad_area;
-		WARN_ON_ONCE(error_code & DSISR_PROTFAULT);
 	}
+#ifdef CONFIG_PPC_STD_MMU
+	/*
+	 * For hash translation mode, we should never get a
+	 * PROTFAULT. Any update to pte to reduce access will result in us
+	 * removing the hash page table entry, thus resulting in a DSISR_NOHPTE
+	 * fault instead of DSISR_PROTFAULT.
+	 *
+	 * A pte update to relax the access will not result in a hash page table
+	 * entry invalidate and hence can result in DSISR_PROTFAULT.
+	 * ptep_set_access_flags() doesn't do a hpte flush. This is why we have
+	 * the special !is_write in the below conditional.
+	 *
+	 * For platforms that doesn't supports coherent icache and do support
+	 * per page noexec bit, we do setup things such that we do the
+	 * sync between D/I cache via fault. But that is handled via low level
+	 * hash fault code (hash_page_do_lazy_icache()) and we should not reach
+	 * here in such case.
+	 *
+	 * For wrong access that can result in PROTFAULT, the above vma->vm_flags
+	 * check should handle those and hence we should fall to the bad_area
+	 * handling correctly.
+	 *
+	 * For embedded with per page exec support that doesn't support coherent
+	 * icache we do get PROTFAULT and we handle that D/I cache sync in
+	 * set_pte_at while taking the noexec/prot fault. Hence this is WARN_ON
+	 * is conditional for server MMU.
+	 *
+	 * For radix, we can get prot fault for autonuma case, because radix
+	 * page table will have them marked noaccess for user.
+	 */
+	if (!radix_enabled() && !is_write)
+		WARN_ON_ONCE(error_code & DSISR_PROTFAULT);
+#endif /* CONFIG_PPC_STD_MMU */
 
 	/*
 	 * If for any reason at all we couldn't handle the fault,
-- 
2.10.2
