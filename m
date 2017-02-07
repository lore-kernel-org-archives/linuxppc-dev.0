Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHVhb71dBzDqGX
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 14:49:35 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v173mdE7058401
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 22:49:33 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28f1rm8v8d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Feb 2017 22:49:33 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 6 Feb 2017 20:49:32 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 5/5] powerpc/mm/hash: Increase VA range to 256TB
Date: Tue,  7 Feb 2017 09:18:53 +0530
In-Reply-To: <1486439333-22162-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1486439333-22162-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1486439333-22162-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Not-Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  2 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  2 +-
 arch/powerpc/include/asm/page_64.h            |  2 +-
 arch/powerpc/include/asm/processor.h          | 12 +++++++-----
 arch/powerpc/mm/slice.c                       |  2 ++
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 0c4e470571ca..5b5410ca2bd0 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -6,7 +6,7 @@
  * each entry by assuming that each entry is page aligned.
  */
 #define H_PTE_INDEX_SIZE  9
-#define H_PMD_INDEX_SIZE  7
+#define H_PMD_INDEX_SIZE  9
 #define H_PUD_INDEX_SIZE  9
 #define H_PGD_INDEX_SIZE  9
 
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index f3dd21efa2ea..37810b0792a5 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -4,7 +4,7 @@
 #define H_PTE_INDEX_SIZE  8
 #define H_PMD_INDEX_SIZE  5
 #define H_PUD_INDEX_SIZE  5
-#define H_PGD_INDEX_SIZE  12
+#define H_PGD_INDEX_SIZE  14
 
 #define H_PAGE_COMBO	0x00001000 /* this is a combo 4k page */
 #define H_PAGE_4K_PFN	0x00002000 /* PFN is for a single 4k page */
diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index 7f72659b7999..d85ac61e2394 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -107,7 +107,7 @@ extern u64 ppc64_pft_size;
  */
 struct slice_mask {
 	u16 low_slices;
-	DECLARE_BITMAP(high_slices, 64);
+	DECLARE_BITMAP(high_slices, 256);
 };
 
 struct mm_struct;
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 1ba814436c73..37e0f3124dee 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -102,11 +102,13 @@ void release_thread(struct task_struct *);
 #endif
 
 #ifdef CONFIG_PPC64
-/* 64-bit user address space is 46-bits (64TB user VM) */
-#define TASK_SIZE_USER64 (0x0000400000000000UL)
-
-/* 
- * 32-bit user address space is 4GB - 1 page 
+/*
+ * 64-bit user address space is 48-bits (256TB user VM).
+ * Derived out of PGTABLE_RANGE
+ */
+#define TASK_SIZE_USER64 (0x0001000000000000UL)
+/*
+ * 32-bit user address space is 4GB - 1 page
  * (this 1 page is needed so referencing of 0xFFFFFFFF generates EFAULT
  */
 #define TASK_SIZE_USER32 (0x0000000100000000UL - (1*PAGE_SIZE))
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 0ec750adbe7f..f194afbaf423 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -407,6 +407,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	struct mm_struct *mm = current->mm;
 	unsigned long newaddr;
 
+	/* Make sure high_slices bitmap size is same as we expected */
+	BUILD_BUG_ON(256 != SLICE_NUM_HIGH);
 	/*
 	 * init different masks
 	 */
-- 
2.7.4
