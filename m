Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4XC5rp8zDrTh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:57:31 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 17/24] powerpc/mm: Move the DSISR_PROTFAULT sanity check
Date: Wed, 19 Jul 2017 14:49:39 +1000
Message-Id: <20170719044946.22030-17-benh@kernel.crashing.org>
In-Reply-To: <20170719044946.22030-1-benh@kernel.crashing.org>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This has a page of comment explaining what's going on right in
the middle of do_page_fault() which makes things a bit hard to
follow. Move it to a helper instead. Also do the test earlier
as there's no point waiting until after we found the VMA.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/fault.c | 75 +++++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index bd5d668b47ff..6f3a2437008a 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -239,6 +239,45 @@ static inline void cmo_account_page_fault(void)
 static inline void cmo_account_page_fault(void) { }
 #endif /* CONFIG_PPC_SMLPAR */
 
+#ifdef CONFIG_PPC_STD_MMU
+static void sanity_check_fault(bool is_write, unsigned long error_code)
+{
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
+}
+#else
+static void sanity_check_fault(bool is_write, unsigned long error_code) { }
+#endif /* CONFIG_PPC_STD_MMU */
+
 /*
  * Define the correct "is_write" bit in error_code based
  * on the processor family
@@ -306,6 +345,9 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		return SIGBUS;
 	}
 
+	/* Additional sanity check(s) */
+	sanity_check_fault(is_write, error_code);
+
 	/*
 	 * The kernel should never take an execute fault nor should it
 	 * take a page fault to a kernel address.
@@ -441,39 +483,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
 			return bad_area(regs, address);
 	}
-#ifdef CONFIG_PPC_STD_MMU
-	/*
-	 * For hash translation mode, we should never get a
-	 * PROTFAULT. Any update to pte to reduce access will result in us
-	 * removing the hash page table entry, thus resulting in a DSISR_NOHPTE
-	 * fault instead of DSISR_PROTFAULT.
-	 *
-	 * A pte update to relax the access will not result in a hash page table
-	 * entry invalidate and hence can result in DSISR_PROTFAULT.
-	 * ptep_set_access_flags() doesn't do a hpte flush. This is why we have
-	 * the special !is_write in the below conditional.
-	 *
-	 * For platforms that doesn't supports coherent icache and do support
-	 * per page noexec bit, we do setup things such that we do the
-	 * sync between D/I cache via fault. But that is handled via low level
-	 * hash fault code (hash_page_do_lazy_icache()) and we should not reach
-	 * here in such case.
-	 *
-	 * For wrong access that can result in PROTFAULT, the above vma->vm_flags
-	 * check should handle those and hence we should fall to the bad_area
-	 * handling correctly.
-	 *
-	 * For embedded with per page exec support that doesn't support coherent
-	 * icache we do get PROTFAULT and we handle that D/I cache sync in
-	 * set_pte_at while taking the noexec/prot fault. Hence this is WARN_ON
-	 * is conditional for server MMU.
-	 *
-	 * For radix, we can get prot fault for autonuma case, because radix
-	 * page table will have them marked noaccess for user.
-	 */
-	if (!radix_enabled() && !is_write)
-		WARN_ON_ONCE(error_code & DSISR_PROTFAULT);
-#endif /* CONFIG_PPC_STD_MMU */
 
 	/*
 	 * If for any reason at all we couldn't handle the fault,
-- 
2.13.3
