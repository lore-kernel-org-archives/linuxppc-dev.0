Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vR2Ww2KHZzDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 21:08:12 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1JA5pD1104091
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 05:08:10 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28pk9p466x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 05:08:10 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 19 Feb 2017 03:08:09 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3 08/10] powerpc/mm/hash: Increase VA range to 128TB
Date: Sun, 19 Feb 2017 15:37:15 +0530
In-Reply-To: <1487498837-12017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1487498837-12017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1487498837-12017-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We update the hash linux page table layout such that we can support 512TB. But
we limit the TASK_SIZE to 128TB. We can switch to 128TB by default without
conditional because that is the max virtual address supported by other
architectures. We will later add a mechanism to on-demand increase the
application's effective address range to 512TB.

Having the page table layout changed to accommodate 512TB  makes testing large
memory configuration easier with less code changes to kernel

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  2 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  2 +-
 arch/powerpc/include/asm/page_64.h            |  2 +-
 arch/powerpc/include/asm/processor.h          | 22 ++++++++++++++++++----
 arch/powerpc/kernel/paca.c                    |  9 ++++++++-
 arch/powerpc/mm/slice.c                       |  2 ++
 6 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 0c4e470571ca..b4b5e6b671ca 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -8,7 +8,7 @@
 #define H_PTE_INDEX_SIZE  9
 #define H_PMD_INDEX_SIZE  7
 #define H_PUD_INDEX_SIZE  9
-#define H_PGD_INDEX_SIZE  9
+#define H_PGD_INDEX_SIZE  12
 
 #ifndef __ASSEMBLY__
 #define H_PTE_TABLE_SIZE	(sizeof(pte_t) << H_PTE_INDEX_SIZE)
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index b39f0b86405e..682c4eb28fa4 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -4,7 +4,7 @@
 #define H_PTE_INDEX_SIZE  8
 #define H_PMD_INDEX_SIZE  5
 #define H_PUD_INDEX_SIZE  5
-#define H_PGD_INDEX_SIZE  12
+#define H_PGD_INDEX_SIZE  15
 
 /*
  * 64k aligned address free up few of the lower bits of RPN for us
diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index 7f72659b7999..9b60e9455c6e 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -107,7 +107,7 @@ extern u64 ppc64_pft_size;
  */
 struct slice_mask {
 	u16 low_slices;
-	DECLARE_BITMAP(high_slices, 64);
+	DECLARE_BITMAP(high_slices, 512);
 };
 
 struct mm_struct;
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 1ba814436c73..1d4e34f9004d 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -102,11 +102,25 @@ void release_thread(struct task_struct *);
 #endif
 
 #ifdef CONFIG_PPC64
-/* 64-bit user address space is 46-bits (64TB user VM) */
-#define TASK_SIZE_USER64 (0x0000400000000000UL)
+/*
+ * 64-bit user address space can have multiple limits
+ * For now supported values are:
+ */
+#define TASK_SIZE_64TB  (0x0000400000000000UL)
+#define TASK_SIZE_128TB (0x0000800000000000UL)
+#define TASK_SIZE_512TB (0x0002000000000000UL)
 
-/* 
- * 32-bit user address space is 4GB - 1 page 
+#ifdef CONFIG_PPC_BOOK3S_64
+/*
+ * MAx value currently used:
+ */
+#define TASK_SIZE_USER64 TASK_SIZE_128TB
+#else
+#define TASK_SIZE_USER64 TASK_SIZE_64TB
+#endif
+
+/*
+ * 32-bit user address space is 4GB - 1 page
  * (this 1 page is needed so referencing of 0xFFFFFFFF generates EFAULT
  */
 #define TASK_SIZE_USER32 (0x0000000100000000UL - (1*PAGE_SIZE))
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index b64daf124fee..c7ca70dc3ba5 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -253,8 +253,15 @@ void copy_mm_to_paca(struct mm_struct *mm)
 	get_paca()->mm_ctx_id = context->id;
 #ifdef CONFIG_PPC_MM_SLICES
 	get_paca()->mm_ctx_low_slices_psize = context->low_slices_psize;
+	/*
+	 * We support upto 128TB for now. Hence copy only 128/2 bytes.
+	 * Later when we support tasks with different max effective
+	 * address, we can optimize this based on mm->task_size.
+	 */
+	BUILD_BUG_ON(TASK_SIZE_USER64 != TASK_SIZE_128TB);
 	memcpy(&get_paca()->mm_ctx_high_slices_psize,
-	       &context->high_slices_psize, SLICE_ARRAY_SIZE);
+	       &context->high_slices_psize, TASK_SIZE_128TB >> 41);
+
 #else /* CONFIG_PPC_MM_SLICES */
 	get_paca()->mm_ctx_user_psize = context->user_psize;
 	get_paca()->mm_ctx_sllp = context->sllp;
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index f286b7839a12..fd2c85e951bd 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -412,6 +412,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	struct mm_struct *mm = current->mm;
 	unsigned long newaddr;
 
+	/* Make sure high_slices bitmap size is same as we expected */
+	BUILD_BUG_ON(512 != SLICE_NUM_HIGH);
 	/*
 	 * init different masks
 	 */
-- 
2.7.4
