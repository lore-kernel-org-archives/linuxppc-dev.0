Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406Kw363WmzF1sY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 19:44:03 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2M8fHHg027518
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 04:44:01 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gv5vkfqv4-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 04:44:00 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 22 Mar 2018 02:44:00 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2] powerpc/mm/radix: Update pte fragment count from 16 to 256
 on radix
Date: Thu, 22 Mar 2018 14:13:50 +0530
Message-Id: <20180322084350.21249-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Right now we use only 4K out of the 64k page allocated for the level 4 page
table. W.r.t the performance impact due to lock contention, with ebizzy

256 threads:
without patch (10 runs of ./ebizzy  -m -n 1000 -s 131072 -S 100)
median = 15678.5
stdev = 42.1209

with patch:
median = 15354
stdev = 194.743

This is with THP disabled. With THP enabled the impact of the patch will be less.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h  | 10 ++++------
 arch/powerpc/include/asm/book3s/64/radix-4k.h  |  5 +++++
 arch/powerpc/include/asm/book3s/64/radix-64k.h |  6 ++++++
 arch/powerpc/mm/pgtable-radix.c                |  8 ++------
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 3bcf269f8f55..0aa4f755b3f6 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -24,16 +24,14 @@
 
 /* PTE flags to conserve for HPTE identification */
 #define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE | H_PAGE_COMBO)
-/*
- * we support 16 fragments per PTE page of 64K size.
- */
-#define H_PTE_FRAG_NR	16
 /*
  * We use a 2K PTE page fragment and another 2K for storing
  * real_pte_t hash index
+ * 8 bytes per each pte entry and another 8 bytes for storing
+ * slot details.
  */
-#define H_PTE_FRAG_SIZE_SHIFT  12
-#define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
+#define H_PTE_FRAG_SIZE_SHIFT  (H_PTE_INDEX_SIZE + 3 + 1)
+#define H_PTE_FRAG_NR	(PAGE_SIZE >> H_PTE_FRAG_SIZE_SHIFT)
 
 #ifndef __ASSEMBLY__
 #include <asm/errno.h>
diff --git a/arch/powerpc/include/asm/book3s/64/radix-4k.h b/arch/powerpc/include/asm/book3s/64/radix-4k.h
index a61aa9cd63ec..ca366ec86310 100644
--- a/arch/powerpc/include/asm/book3s/64/radix-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/radix-4k.h
@@ -9,5 +9,10 @@
 #define RADIX_PMD_INDEX_SIZE  9  /* 1G huge page */
 #define RADIX_PUD_INDEX_SIZE	 9
 #define RADIX_PGD_INDEX_SIZE  13
+/*
+ * One fragment per per page
+ */
+#define RADIX_PTE_FRAG_SIZE_SHIFT  (RADIX_PTE_INDEX_SIZE + 3)
+#define RADIX_PTE_FRAG_NR	(PAGE_SIZE >> RADIX_PTE_FRAG_SIZE_SHIFT)
 
 #endif /* _ASM_POWERPC_PGTABLE_RADIX_4K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/radix-64k.h b/arch/powerpc/include/asm/book3s/64/radix-64k.h
index c7e71ba29555..830082496876 100644
--- a/arch/powerpc/include/asm/book3s/64/radix-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/radix-64k.h
@@ -10,4 +10,10 @@
 #define RADIX_PUD_INDEX_SIZE	 9
 #define RADIX_PGD_INDEX_SIZE  13
 
+/*
+ * We use a 256 byte PTE page fragment in radix
+ * 8 bytes per each PTE entry.
+ */
+#define RADIX_PTE_FRAG_SIZE_SHIFT  (RADIX_PTE_INDEX_SIZE + 3)
+#define RADIX_PTE_FRAG_NR	(PAGE_SIZE >> RADIX_PTE_FRAG_SIZE_SHIFT)
 #endif /* _ASM_POWERPC_PGTABLE_RADIX_64K_H */
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 2e10a964e290..7fd51549b9e5 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -575,12 +575,8 @@ void __init radix__early_init_mmu(void)
 #ifdef CONFIG_PCI
 	pci_io_base = ISA_IO_BASE;
 #endif
-
-	/*
-	 * For now radix also use the same frag size
-	 */
-	__pte_frag_nr = H_PTE_FRAG_NR;
-	__pte_frag_size_shift = H_PTE_FRAG_SIZE_SHIFT;
+	__pte_frag_nr = RADIX_PTE_FRAG_NR;
+	__pte_frag_size_shift = RADIX_PTE_FRAG_SIZE_SHIFT;
 
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		radix_init_native();
-- 
2.14.3
