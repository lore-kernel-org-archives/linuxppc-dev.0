Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxF732n1PzF1Zj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 00:37:03 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w27DZgxR128549
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Mar 2018 08:37:00 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gjdpq8v7u-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2018 08:37:00 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 7 Mar 2018 08:36:59 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxram@us.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/mm/keys: Update documentation in key fault
 handling
Date: Wed,  7 Mar 2018 19:06:45 +0530
In-Reply-To: <20180307133645.29290-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180307133645.29290-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180307133645.29290-2-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No functionality change in this patch. Adds more code comments. We also remove
an unnecessary pkey check after we check for pkey error in this patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/fault.c | 28 ++++++++++++----------------
 arch/powerpc/mm/pkeys.c | 11 ++++-------
 2 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 866446cf2d9a..c01d627e687a 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -297,7 +297,12 @@ static bool access_error(bool is_write, bool is_exec,
 
 	if (unlikely(!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE))))
 		return true;
-
+	/*
+	 * We should ideally do the vma pkey access check here. But in the
+	 * fault path, handle_mm_fault() also does the same check. To avoid
+	 * these multiple checks, we skip it here and handle access error due
+	 * to pkeys later.
+	 */
 	return false;
 }
 
@@ -518,25 +523,16 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 
 #ifdef CONFIG_PPC_MEM_KEYS
 	/*
-	 * if the HPTE is not hashed, hardware will not detect
-	 * a key fault. Lets check if we failed because of a
-	 * software detected key fault.
+	 * we skipped checking for access error due to key earlier.
+	 * Check that using handle_mm_fault error return.
 	 */
 	if (unlikely(fault & VM_FAULT_SIGSEGV) &&
-		!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
-			is_exec, 0)) {
-		/*
-		 * The PGD-PDT...PMD-PTE tree may not have been fully setup.
-		 * Hence we cannot walk the tree to locate the PTE, to locate
-		 * the key. Hence let's use vma_pkey() to get the key; instead
-		 * of get_mm_addr_key().
-		 */
+		!arch_vma_access_permitted(vma, is_write, is_exec, 0)) {
+
 		int pkey = vma_pkey(vma);
 
-		if (likely(pkey)) {
-			up_read(&mm->mmap_sem);
-			return bad_key_fault_exception(regs, address, pkey);
-		}
+		up_read(&mm->mmap_sem);
+		return bad_key_fault_exception(regs, address, pkey);
 	}
 #endif /* CONFIG_PPC_MEM_KEYS */
 
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index ba71c5481f42..56d33056a559 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -119,18 +119,15 @@ int pkey_initialize(void)
 #else
 	os_reserved = 0;
 #endif
+	initial_allocation_mask = ~0x0;
+	pkey_amr_uamor_mask = ~0x0ul;
+	pkey_iamr_mask = ~0x0ul;
 	/*
-	 * Bits are in LE format. NOTE: 1, 0 are reserved.
+	 * key 0, 1 are reserved.
 	 * key 0 is the default key, which allows read/write/execute.
 	 * key 1 is recommended not to be used. PowerISA(3.0) page 1015,
 	 * programming note.
 	 */
-	initial_allocation_mask = ~0x0;
-
-	/* register mask is in BE format */
-	pkey_amr_uamor_mask = ~0x0ul;
-	pkey_iamr_mask = ~0x0ul;
-
 	for (i = 2; i < (pkeys_total - os_reserved); i++) {
 		initial_allocation_mask &= ~(0x1 << i);
 		pkey_amr_uamor_mask &= ~(0x3ul << pkeyshift(i));
-- 
2.14.3
