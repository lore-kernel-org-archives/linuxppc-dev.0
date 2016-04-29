Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDxt5ZhxzDqBG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:26:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 19/70] powerpc/mm/radix: Add partition table format &
 callback
Date: Fri, 29 Apr 2016 23:25:42 +1000
Message-Id: <1461936393-10131-19-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Add structs and #defines related to the radix MMU partition table
format. We also add a ppc_md callback for updating a partition table
entry.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 31 +++++++++++++++++++++++++++++--
 arch/powerpc/include/asm/machdep.h       |  1 +
 arch/powerpc/include/asm/reg.h           |  1 +
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index aadb0bbc5c71..b86786f2521c 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -21,12 +21,39 @@ struct mmu_psize_def {
 extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 #endif /* __ASSEMBLY__ */
 
-#ifdef CONFIG_PPC_STD_MMU_64
 /* 64-bit classic hash table MMU */
 #include <asm/book3s/64/mmu-hash.h>
-#endif
 
 #ifndef __ASSEMBLY__
+/*
+ * ISA 3.0 partiton and process table entry format
+ */
+struct prtb_entry {
+	__be64 prtb0;
+	__be64 prtb1;
+};
+extern struct prtb_entry *process_tb;
+
+struct patb_entry {
+	__be64 patb0;
+	__be64 patb1;
+};
+extern struct patb_entry *partition_tb;
+
+#define PATB_HR		(1UL << 63)
+#define PATB_GR		(1UL << 63)
+#define RPDB_MASK	0x0ffffffffffff00fUL
+#define RPDB_SHIFT	(1UL << 8)
+/*
+ * Limit process table to PAGE_SIZE table. This
+ * also limit the max pid we can support.
+ * MAX_USER_CONTEXT * 16 bytes of space.
+ */
+#define PRTB_SIZE_SHIFT	(CONTEXT_BITS + 4)
+/*
+ * Power9 currently only support 64K partition table size.
+ */
+#define PATB_SIZE_SHIFT	16
 
 typedef unsigned long mm_context_id_t;
 struct spinlock;
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index fd22442d30a9..6bdcd0da9e21 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -256,6 +256,7 @@ struct machdep_calls {
 #ifdef CONFIG_ARCH_RANDOM
 	int (*get_random_seed)(unsigned long *v);
 #endif
+	int (*update_partition_table)(u64);
 };
 
 extern void e500_idle(void);
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index cf09c6eb5ee7..47082bcbf1e5 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -587,6 +587,7 @@
 #define SPRN_PIR	0x3FF	/* Processor Identification Register */
 #endif
 #define SPRN_TIR	0x1BE	/* Thread Identification Register */
+#define SPRN_PTCR	0x1D0	/* Partition table control Register */
 #define SPRN_PSPB	0x09F	/* Problem State Priority Boost reg */
 #define SPRN_PTEHI	0x3D5	/* 981 7450 PTE HI word (S/W TLB load) */
 #define SPRN_PTELO	0x3D6	/* 982 7450 PTE LO word (S/W TLB load) */
-- 
2.5.0
