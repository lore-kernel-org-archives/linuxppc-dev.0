Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrmt4n3szDwtR
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:44:30 +1000 (AEST)
Received: from pps.filterd (m0049461.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58Ed4Fh042242
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 10:44:28 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23e9mwth3j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 10:44:27 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 08:44:26 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 16/16] powerpc/mm: Support segment table for Power9
Date: Wed,  8 Jun 2016 20:13:23 +0530
In-Reply-To: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465397003-26812-17-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PowerISA 3.0 adds an in memory table for storing segment translation
information. In this mode, which is enabled by setting both HOST RADIX
and GUEST RADIX bits in partition table to 0 and enabling UPRT to
1, we have a per process segment table. The segment table details
are stored in the process table indexed by PID value.

Segment table mode also requires us to map the process table at the
beginning of a 1TB segment.

On the linux kernel side we enable this model if we find that
the radix is explicitily disabled by setting the ibm,pa-feature radix
bit (byte 40 bit 0) set to 0. If the size of ibm,pa-feature node is less
than 40 bytes, we enable the legacy HPT mode using SLB. If radix bit
is set to 1, we use the radix mode.

With respect to SLB mapping, we bolt mapp the entire kernel range and
and only handle user space segment fault.

We also have access to 4 SLB register in software. So we continue to use
3 of that for bolted kernel SLB entries as we use them currently.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h     |  10 +
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  17 ++
 arch/powerpc/include/asm/book3s/64/mmu.h      |   4 +
 arch/powerpc/include/asm/mmu.h                |   6 +-
 arch/powerpc/include/asm/mmu_context.h        |   5 +-
 arch/powerpc/kernel/prom.c                    |   1 +
 arch/powerpc/mm/hash_utils_64.c               |  86 ++++++-
 arch/powerpc/mm/mmu_context_book3s64.c        |  32 ++-
 arch/powerpc/mm/slb.c                         | 350 +++++++++++++++++++++++++-
 9 files changed, 493 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index f61cad3de4e6..5f0deeda7884 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -58,6 +58,16 @@
 #define H_VMALLOC_END	(H_VMALLOC_START + H_VMALLOC_SIZE)
 
 /*
+ * Process table with ISA 3.0 need to be mapped at the beginning of a 1TB segment
+ * We put that in the top of VMALLOC region. For each region we can go upto 64TB
+ * for now. Hence we have space to put process table there. We should not get
+ * an SLB miss for this address, because the VSID for this is placed in the
+ * partition table.
+ */
+#define H_SEG_PROC_TBL_START	ASM_CONST(0xD000200000000000)
+#define H_SEG_PROC_TBL_END	ASM_CONST(0xD00020ffffffffff)
+
+/*
  * Region IDs
  */
 #define REGION_SHIFT		60UL
diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index b042e5f9a428..5f9ee699da5f 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -102,6 +102,18 @@
 #define HPTE_V_1TB_SEG		ASM_CONST(0x4000000000000000)
 #define HPTE_V_VRMA_MASK	ASM_CONST(0x4001ffffff000000)
 
+/* segment table entry masks/bits */
+/* Upper 64 bit */
+#define STE_VALID	ASM_CONST(0x8000000)
+/*
+ * lower 64 bit
+ * 64th bit become 0 bit
+ */
+/*
+ * Software defined bolted bit
+ */
+#define STE_BOLTED	ASM_CONST(0x1)
+
 /* Values for PP (assumes Ks=0, Kp=1) */
 #define PP_RWXX	0	/* Supervisor read/write, User none */
 #define PP_RWRX 1	/* Supervisor read/write, User read */
@@ -129,6 +141,11 @@ struct hash_pte {
 	__be64 r;
 };
 
+struct seg_entry {
+	__be64 ste_e;
+	__be64 ste_v;
+};
+
 extern struct hash_pte *htab_address;
 extern unsigned long htab_size_bytes;
 extern unsigned long htab_hash_mask;
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 6d8306d9aa7a..b7514f19863f 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -65,6 +65,7 @@ extern struct patb_entry *partition_tb;
  */
 #define PATB_SIZE_SHIFT	16
 
+extern unsigned long segment_table_initialize(struct prtb_entry *prtb);
 typedef unsigned long mm_context_id_t;
 struct spinlock;
 
@@ -94,6 +95,9 @@ typedef struct {
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	struct list_head iommu_group_mem_list;
 #endif
+	unsigned long seg_table;
+	struct spinlock *seg_tbl_lock;
+
 } mm_context_t;
 
 /*
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 21b71469e66b..97446e8cc101 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -24,6 +24,10 @@
  * Radix page table available
  */
 #define MMU_FTR_TYPE_RADIX		ASM_CONST(0x00000040)
+
+/* Seg table only supported for book3s 64 */
+#define MMU_FTR_TYPE_SEG_TABLE		ASM_CONST(0x00000080)
+
 /*
  * individual features
  */
@@ -130,7 +134,7 @@ enum {
 		MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_CI_LARGE_PAGE |
 		MMU_FTR_1T_SEGMENT | MMU_FTR_TLBIE_CROP_VA |
 #ifdef CONFIG_PPC_RADIX_MMU
-		MMU_FTR_TYPE_RADIX |
+		MMU_FTR_TYPE_RADIX | MMU_FTR_TYPE_SEG_TABLE |
 #endif
 		0,
 };
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 9d2cd0c36ec2..f18a09f1f609 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -38,13 +38,16 @@ extern void set_context(unsigned long id, pgd_t *pgd);
 
 #ifdef CONFIG_PPC_BOOK3S_64
 extern void radix__switch_mmu_context(struct mm_struct *prev,
-				     struct mm_struct *next);
+				      struct mm_struct *next);
 static inline void switch_mmu_context(struct mm_struct *prev,
 				      struct mm_struct *next,
 				      struct task_struct *tsk)
 {
 	if (radix_enabled())
 		return radix__switch_mmu_context(prev, next);
+	/*
+	 * switch the pid before flushing the slb
+	 */
 	return switch_slb(tsk, next);
 }
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 44b4417804db..e17eac9fd484 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -169,6 +169,7 @@ static struct ibm_pa_feature {
 	{CPU_FTR_TM_COMP, 0, 0,
 	 PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
 	{0, MMU_FTR_TYPE_RADIX, 0, 0,		40, 0, 0},
+	{0, MMU_FTR_TYPE_SEG_TABLE, 0, 0,	58, 0, 0},
 };
 
 static void __init scan_features(unsigned long node, const unsigned char *ftrs,
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 7cce2f6169fa..7bab130174b4 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -694,8 +694,8 @@ int remove_section_mapping(unsigned long start, unsigned long end)
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
-static void __init hash_init_partition_table(phys_addr_t hash_table,
-					     unsigned long htab_size)
+static void __init hash_partition_table_initialize(phys_addr_t hash_table,
+						   unsigned long htab_size)
 {
 	unsigned long ps_field;
 	unsigned long patb_size = 1UL << PATB_SIZE_SHIFT;
@@ -714,18 +714,59 @@ static void __init hash_init_partition_table(phys_addr_t hash_table,
 	/* Initialize the Partition Table with no entries */
 	memset((void *)partition_tb, 0, patb_size);
 	partition_tb->patb0 = cpu_to_be64(ps_field | hash_table | htab_size);
-	/*
-	 * FIXME!! This should be done via update_partition table
-	 * For now UPRT is 0 for us.
-	 */
-	partition_tb->patb1 = 0;
+	if (!mmu_has_feature(MMU_FTR_TYPE_SEG_TABLE))
+		partition_tb->patb1 = 0;
 	pr_info("Partition table %p\n", partition_tb);
 	/*
 	 * update partition table control register,
 	 * 64 K size.
 	 */
 	mtspr(SPRN_PTCR, __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
+}
 
+static unsigned long  __init hash_process_table_initialize(void)
+{
+	unsigned long prtb;
+	unsigned long sllp;
+	unsigned long prtps_field;
+	unsigned long process_tb_vsid;
+	unsigned long prtb_align_size;
+	unsigned long prtb_size = 1UL << PRTB_SIZE_SHIFT;
+
+	prtb_align_size = 1UL << mmu_psize_defs[mmu_linear_psize].shift;
+	/*
+	 * Allocate process table
+	 */
+	BUILD_BUG_ON_MSG((PRTB_SIZE_SHIFT > 23), "Process table size too large.");
+	prtb = memblock_alloc_base(prtb_size, prtb_align_size, MEMBLOCK_ALLOC_ANYWHERE);
+	/*
+	 * Map this to start of process table segment.
+	 */
+	process_tb = (void *)H_SEG_PROC_TBL_START;
+	htab_bolt_mapping(H_SEG_PROC_TBL_START,
+			  H_SEG_PROC_TBL_START + prtb_size, prtb,
+			  pgprot_val(PAGE_KERNEL),
+			  mmu_linear_psize, MMU_SEGSIZE_1T);
+
+	/* Initialize the process table with no entries */
+	memset((void *)prtb, 0, prtb_size);
+	/*
+	 * Now fill the partition table. This should be page size
+	 * use to map the segment table.
+	 */
+	sllp = get_sllp_encoding(mmu_linear_psize);
+
+	prtps_field = sllp << 5;
+	process_tb_vsid = get_kernel_vsid((unsigned long)process_tb,
+					  MMU_SEGSIZE_1T);
+	pr_info("Process table %p (%p)  and vsid 0x%lx\n", process_tb,
+		(void *)prtb, process_tb_vsid);
+	process_tb_vsid <<= 25;
+	/*
+	 * Fill in the partition table
+	 */
+	ppc_md.update_partition_table(process_tb_vsid | prtps_field | (PRTB_SIZE_SHIFT - 12));
+	return prtb;
 }
 
 static void __init htab_initialize(void)
@@ -800,7 +841,7 @@ static void __init htab_initialize(void)
 			/* Set SDR1 */
 			mtspr(SPRN_SDR1, _SDR1);
 		else
-			hash_init_partition_table(table, htab_size_bytes);
+			hash_partition_table_initialize(table, htab_size_bytes);
 	}
 
 	prot = pgprot_val(PAGE_KERNEL);
@@ -885,6 +926,7 @@ static void __init htab_initialize(void)
 #undef KB
 #undef MB
 
+static DEFINE_SPINLOCK(init_segtbl_lock);
 void __init hash__early_init_mmu(void)
 {
 	/*
@@ -923,7 +965,22 @@ void __init hash__early_init_mmu(void)
 	 */
 	htab_initialize();
 
-	pr_info("Initializing hash mmu with SLB\n");
+	if (mmu_has_feature(MMU_FTR_TYPE_SEG_TABLE)) {
+		unsigned long prtb;
+		unsigned long lpcr;
+		/*
+		 * setup LPCR UPRT based on mmu_features
+		 */
+		if (!firmware_has_feature(FW_FEATURE_LPAR)) {
+			lpcr = mfspr(SPRN_LPCR);
+			mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
+		}
+		prtb = hash_process_table_initialize();
+		init_mm.context.seg_tbl_lock = &init_segtbl_lock;
+		init_mm.context.seg_table = segment_table_initialize((struct prtb_entry *)prtb);
+		pr_info("Initializing hash mmu with in-memory segment table\n");
+	} else
+		pr_info("Initializing hash mmu with SLB\n");
 	/* Initialize SLB management */
 	slb_initialize();
 }
@@ -931,6 +988,17 @@ void __init hash__early_init_mmu(void)
 #ifdef CONFIG_SMP
 void hash__early_init_mmu_secondary(void)
 {
+	if (mmu_has_feature(MMU_FTR_TYPE_SEG_TABLE)) {
+		unsigned long lpcr;
+		/*
+		 * setup LPCR UPRT based on mmu_features
+		 */
+		if (!firmware_has_feature(FW_FEATURE_LPAR)) {
+			lpcr = mfspr(SPRN_LPCR);
+			mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
+		}
+	}
+
 	/* Initialize hash table for that CPU */
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		if (!cpu_has_feature(CPU_FTR_ARCH_300))
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 37d7fbb7ca06..78ebc3877530 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -102,12 +102,8 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	mm->context.id = index;
 #ifdef CONFIG_PPC_ICSWX
 	mm->context.cop_lockp = kmalloc(sizeof(spinlock_t), GFP_KERNEL);
-	if (!mm->context.cop_lockp) {
-		__destroy_context(index);
-		subpage_prot_free(mm);
-		mm->context.id = MMU_NO_CONTEXT;
-		return -ENOMEM;
-	}
+	if (!mm->context.cop_lockp)
+		goto err_out;
 	spin_lock_init(mm->context.cop_lockp);
 #endif /* CONFIG_PPC_ICSWX */
 
@@ -117,7 +113,31 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	mm_iommu_init(&mm->context);
 #endif
+	/*
+	 * Setup segment table and update process table entry
+	 */
+	if (!radix_enabled() && mmu_has_feature(MMU_FTR_TYPE_SEG_TABLE)) {
+		mm->context.seg_tbl_lock = kmalloc(sizeof(spinlock_t), GFP_KERNEL);
+		if (!mm->context.seg_tbl_lock)
+			goto err_out_free;
+		spin_lock_init(mm->context.seg_tbl_lock);
+		mm->context.seg_table = segment_table_initialize(&process_tb[index]);
+		if (!mm->context.seg_table) {
+			kfree(mm->context.seg_tbl_lock);
+			goto err_out_free;
+		}
+	}
 	return 0;
+
+err_out_free:
+#ifdef CONFIG_PPC_ICSWX
+	kfree(mm->context.cop_lockp);
+err_out:
+#endif
+	__destroy_context(index);
+	subpage_prot_free(mm);
+	mm->context.id = MMU_NO_CONTEXT;
+	return -ENOMEM;
 }
 
 void __destroy_context(int context_id)
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index b18d7df5601d..44412810d1b5 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -26,6 +26,8 @@
 #include <asm/code-patching.h>
 
 #include <linux/context_tracking.h>
+#include <linux/slab.h>
+#include <linux/memblock.h>
 
 enum slb_index {
 	LINEAR_INDEX	= 0, /* Kernel linear map  (0xc000000000000000) */
@@ -199,6 +201,13 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 	unsigned long stack = KSTK_ESP(tsk);
 	unsigned long exec_base;
 
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		mtspr(SPRN_PID, mm->context.id);
+		__slb_flush_and_rebolt();
+		copy_mm_to_paca(&mm->context);
+		return;
+	}
+
 	/*
 	 * We need interrupts hard-disabled here, not just soft-disabled,
 	 * so that a PMU interrupt can't occur, which might try to access
@@ -349,11 +358,350 @@ void slb_initialize(void)
 	asm volatile("isync":::"memory");
 }
 
+static inline bool seg_entry_valid(struct seg_entry *entry)
+{
+	return !!(be64_to_cpu(entry->ste_e) & STE_VALID);
+}
+
+static inline bool seg_entry_bolted(struct seg_entry *entry)
+{
+	return !!(be64_to_cpu(entry->ste_v) & STE_BOLTED);
+}
+
+static inline bool seg_entry_match(struct seg_entry *entry, unsigned long esid,
+				   int ssize)
+{
+	unsigned long ste_ssize;
+	unsigned long ste_esid;
+
+	ste_esid = be64_to_cpu(entry->ste_e) >> 28;
+	ste_ssize = (be64_to_cpu(entry->ste_v) >> 62) & 0x3;
+	if (ste_esid == esid && ste_ssize == ssize)
+		return true;
+	return false;
+}
+
+#define STE_PER_STEG 8
+static inline bool ste_present(unsigned long seg_table, unsigned long ste_group,
+			       unsigned long esid, int ssize)
+{
+	int i;
+	struct seg_entry *entry;
+
+	entry = (struct seg_entry *)(seg_table + (ste_group << 7));
+	for (i = 0; i < STE_PER_STEG; i++) {
+		/* Do we need a smp_rmb() here to make sure we load
+		 * the second half only after the entry is found to be
+		 * valid ?
+		 */
+		if (seg_entry_valid(entry) && seg_entry_match(entry, esid, ssize))
+			return true;
+		entry++;
+	}
+	return false;
+}
+
+static inline struct seg_entry *get_free_ste(unsigned long seg_table,
+					     unsigned long ste_group)
+{
+	int i;
+	struct seg_entry *entry;
+
+	entry = (struct seg_entry *)(seg_table + (ste_group << 7));
+	for (i = 0; i < STE_PER_STEG; i++) {
+		if (!seg_entry_valid(entry))
+			return entry;
+		entry++;
+	}
+	return NULL;
+
+}
+
+static struct seg_entry *get_random_ste(unsigned long seg_table,
+					unsigned long ste_group)
+{
+	int i;
+	struct seg_entry *entry;
+
+again:
+	/* Randomly pick a slot */
+	i = mftb() & 0x7;
+
+	/* randomly pick pimary or secondary */
+	if (mftb() & 0x1)
+		ste_group = ~ste_group;
+
+	entry = (struct seg_entry *)(seg_table + (ste_group << 7));
+	if (seg_entry_bolted(entry + i))
+		goto again;
+
+	return entry + i;
+
+}
+static void do_segment_load(unsigned long seg_table, unsigned long ea,
+			    unsigned long vsid, int ssize, int psize,
+			    unsigned long protection, bool bolted)
+{
+	unsigned long esid;
+	unsigned long ste_group;
+	struct seg_entry *entry;
+	unsigned long ste_e, ste_v;
+	unsigned long steg_group_mask;
+
+	if (ssize == MMU_SEGSIZE_256M) {
+		esid = GET_ESID(ea);
+		/*
+		 * group mask for 256M segment is.
+		 * 35 - segment table size shift - 43
+		 */
+		steg_group_mask = ((1UL << (mmu_psize_defs[mmu_linear_psize].shift  - 7)) - 1);
+		ste_group = esid &  steg_group_mask;
+	} else {
+		esid = GET_ESID_1T(ea);
+		/*
+		 * group mask for 1T segment is.
+		 * 25 - segment table size shift - 31
+		 */
+		steg_group_mask = ((1UL << (mmu_psize_defs[mmu_linear_psize].shift  - 5)) - 1);
+		ste_group = esid &  steg_group_mask;
+	}
+
+	if (ste_present(seg_table, ste_group, esid, ssize))
+		return;
+	/*
+	 * check the secondary
+	 */
+	if (ste_present(seg_table, ~ste_group, esid, ssize))
+		return;
+
+	/*
+	 * search for a free slot in primary
+	 */
+
+	entry = get_free_ste(seg_table, ste_group);
+	if (!entry) {
+		/* search the secondary */
+		entry = get_free_ste(seg_table, ~ste_group);
+		if (!entry) {
+			entry = get_random_ste(seg_table, ste_group);
+			if (!entry)
+				return;
+		}
+	}
+	/*
+	 * update the valid bit to 0, FIXME!! Do we need
+	 * to do a translation cache invalidation for the entry we
+	 * are stealing ? The translation is still valid.
+	 */
+	entry->ste_e &= ~cpu_to_be64(STE_VALID);
+	/*
+	 * Make sure everybody see the valid bit cleared, before they
+	 * see the update to other part of ste.
+	 */
+	smp_mb();
+
+	ste_v = (unsigned long)ssize << 62;
+	ste_v |= (vsid << 12);
+	/*
+	 * The sllp value is an already shifted value with right bit
+	 * positioning.
+	 */
+	ste_v |= mmu_psize_defs[psize].sllp;
+	ste_v |= protection;
+
+	if (bolted)
+		ste_v  |= STE_BOLTED;
+
+
+	ste_e = esid << segment_shift(ssize);
+	ste_e |=  STE_VALID;
+
+	entry->ste_v = cpu_to_be64(ste_v);
+	/*
+	 * Make sure we have rest of values updated before marking the
+	 * ste entry valid
+	 */
+	smp_mb();
+	entry->ste_e = cpu_to_be64(ste_e);
+}
+
+static inline void __segment_load(mm_context_t *context, unsigned long ea,
+				  unsigned long vsid, int ssize, int psize,
+				  unsigned long protection, bool bolted)
+{
+	/*
+	 * Take the lock and check again if somebody else inserted
+	 * segment entry meanwhile. if so return
+	 */
+	spin_lock(context->seg_tbl_lock);
+
+	do_segment_load(context->seg_table, ea, vsid, ssize, psize,
+			protection, bolted);
+	spin_unlock(context->seg_tbl_lock);
+}
+
+static void segment_table_load(unsigned long ea)
+{
+	int ssize, psize;
+	unsigned long vsid;
+	unsigned long protection;
+	struct mm_struct *mm = current->mm;
+
+	if (!mm)
+		mm = &init_mm;
+	/*
+	 * We won't get segment fault for kernel mapping here, because
+	 * we bolt them all during task creation.
+	 */
+	switch (REGION_ID(ea)) {
+	case USER_REGION_ID:
+		psize = get_slice_psize(mm, ea);
+		ssize = user_segment_size(ea);
+		vsid = get_vsid(mm->context.id, ea, ssize);
+		protection = SLB_VSID_USER;
+		break;
+	default:
+		pr_err("We should not get slb fault on EA %lx\n", ea);
+		return;
+	}
+	return __segment_load(&mm->context, ea, vsid, ssize, psize,
+			      protection, false);
+}
+
 void handle_slb_miss(struct pt_regs *regs,
 		     unsigned long address, unsigned long trap)
 {
 	enum ctx_state prev_state = exception_enter();
 
-	slb_allocate(address);
+	if (mmu_has_feature(MMU_FTR_TYPE_SEG_TABLE))
+		segment_table_load(address);
+	else
+		slb_allocate(address);
 	exception_exit(prev_state);
 }
+
+
+static inline void insert_1T_segments(unsigned long seg_table, unsigned long start,
+				      unsigned long psize, int count)
+{
+	int i;
+	unsigned long vsid;
+
+	for (i = 0; i < count; i++) {
+		vsid = get_kernel_vsid(start, MMU_SEGSIZE_1T);
+		do_segment_load(seg_table, start, vsid, MMU_SEGSIZE_1T, psize,
+				SLB_VSID_KERNEL, true);
+		start += 1UL << 40;
+	}
+}
+
+static inline void insert_1T_segments_range(unsigned long seg_table, unsigned long start,
+					    unsigned long end, unsigned long psize)
+{
+	unsigned long vsid;
+
+	while (start < end) {
+		vsid = get_kernel_vsid(start, MMU_SEGSIZE_1T);
+		do_segment_load(seg_table, start, vsid, MMU_SEGSIZE_1T, psize,
+				SLB_VSID_KERNEL, true);
+		start += 1UL << 40;
+	}
+}
+
+static inline void segtbl_insert_kernel_mapping(unsigned long seg_table)
+{
+	/*
+	 * insert mapping for the full kernel. Map the entire kernel with 1TB segments
+	 * and we create mapping for max possible memory supported which at this
+	 * point is 64TB.
+	 */
+	/* We support 64TB address space now */
+	insert_1T_segments(seg_table, 0xC000000000000000UL, mmu_linear_psize, 64);
+	/*
+	 * We don't map the full VMALLOC region, because different part of that
+	 * have different base page size.
+	 */
+	insert_1T_segments_range(seg_table, H_VMALLOC_START,
+				 H_VMALLOC_END, mmu_vmalloc_psize);
+
+	insert_1T_segments_range(seg_table, H_VMALLOC_END,
+				 H_VMALLOC_START + H_KERN_VIRT_SIZE,
+				 mmu_io_psize);
+
+	insert_1T_segments_range(seg_table, H_SEG_PROC_TBL_START,
+				 H_SEG_PROC_TBL_END, mmu_linear_psize);
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	insert_1T_segments(seg_table, H_VMEMMAP_BASE, mmu_vmemmap_psize, 64);
+#endif
+}
+
+#define PGALLOC_GFP (GFP_KERNEL | __GFP_NOTRACK | __GFP_REPEAT | __GFP_ZERO)
+unsigned long __init_refok segment_table_initialize(struct prtb_entry *prtb)
+{
+	unsigned long sllp;
+	unsigned long seg_table;
+	unsigned long seg_tb_vsid;
+	unsigned long seg_tb_vpn;
+	unsigned long prtb0, prtb1;
+	unsigned long segtb_align_size;
+
+	segtb_align_size = 1UL << mmu_psize_defs[mmu_linear_psize].shift;
+	/*
+	 * Fill in the process table.
+	 */
+	if (slab_is_available()) {
+		struct page *page;
+		/*
+		 * memory need to aligned to base page size. We continue to
+		 * use only SEGTB_SIZE part of the below allocated region.
+		 */
+		page = alloc_pages(PGALLOC_GFP,
+				   mmu_psize_defs[mmu_linear_psize].shift - PAGE_SHIFT);
+		if (!page)
+			return -ENOMEM;
+		seg_table = (unsigned long)page_address(page);
+	} else {
+		seg_table = (unsigned long)__va(memblock_alloc_base(segtb_align_size,
+						 segtb_align_size,
+						 MEMBLOCK_ALLOC_ANYWHERE));
+		memset((void *)seg_table, 0, segtb_align_size);
+	}
+	/*
+	 * Now fill with kernel mappings
+	 */
+	segtbl_insert_kernel_mapping(seg_table);
+	seg_tb_vsid = get_kernel_vsid(seg_table, mmu_kernel_ssize);
+	/*
+	 * our vpn shift is 12, so we can use the same function. lucky
+	 */
+	BUILD_BUG_ON_MSG(12 != VPN_SHIFT, "VPN_SHIFT is not 12");
+	seg_tb_vpn = hpt_vpn(seg_table, seg_tb_vsid, mmu_kernel_ssize);
+	/*
+	 * segment size
+	 */
+	prtb0 = (unsigned long)mmu_kernel_ssize << 62;
+	/*
+	 * seg table vpn already ignore the lower 12 bits of the virtual
+	 * address and is exactly STABORGU || STABORGL.
+	 */
+	prtb0 |= seg_tb_vpn >> 4;
+	prtb1 = (seg_tb_vpn & 0xf) << 60;
+	/*
+	 * stps field
+	 */
+	sllp = get_sllp_encoding(mmu_linear_psize);
+	prtb1 |= sllp << 1;
+	/*
+	 * set segment table size and valid bit
+	 */
+	prtb1 |= ((mmu_psize_defs[mmu_linear_psize].shift - 12) << 4 | 0x1);
+	prtb->prtb0 = cpu_to_be64(prtb0);
+	/*
+	 * Make sure we have rest of values updated before marking the
+	 * ste entry valid
+	 */
+	smp_wmb();
+	prtb->prtb1 = cpu_to_be64(prtb1);
+
+	return seg_table;
+}
-- 
2.7.4
