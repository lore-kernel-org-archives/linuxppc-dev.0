Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D624E1A0392
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 00:40:19 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 7 Mar 2016 06:40:17 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 8870719D8051
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 06:28:11 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u27DeFQQ34603190
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 06:40:15 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u27DeFSg016109
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 06:40:15 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 13/14] powerpc/mm/power9: Add partition table format
Date: Mon,  7 Mar 2016 19:09:33 +0530
Message-Id: <1457357974-20839-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1457357974-20839-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1457357974-20839-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We also add mach dep call back for updating partition table entry.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
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
index 52ed654d01ba..257251ada3a3 100644
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
