Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>,
	<cbe-oss-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 20 Feb 2007 18:44:13 +1100
Subject: [PATCH 1/5] powerpc: Fix spu SLB invalidations
In-Reply-To: <1171957452.861958.803775545202.qpush@grosgo>
Message-Id: <20070220074432.5726EDDD0D@ozlabs.org>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The SPU code doesn't properly invalidate SPUs SLBs when necessary, for example
when changing a segment size from the hugetlbfs code. In addition, it saves
and restores the SLB content on context switches which makes it harder to
properly handle those invalidations.

This patch removes the saving & restoring for now, something more efficient
might be found later on. It also adds a spu_flush_all_slbs(mm) that can be
used by the core mm code to flush the SLBs of all SPEs that are running a
given mm at the time of the flush.

In order to do that, it adds a spinlock to the list of all SPEs and move
some bits & pieces from spufs to spu_base.c

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/mm/hash_utils_64.c            |    6 ++
 arch/powerpc/mm/hugetlbpage.c              |    4 +
 arch/powerpc/platforms/cell/spu_base.c     |   81 ++++++++++++++++++++++++-----
 arch/powerpc/platforms/cell/spufs/sched.c  |   13 ----
 arch/powerpc/platforms/cell/spufs/switch.c |   62 +---------------------
 include/asm-powerpc/spu.h                  |    7 ++
 include/asm-powerpc/spu_csa.h              |    4 -
 7 files changed, 91 insertions(+), 86 deletions(-)

Index: linux-cell/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/hugetlbpage.c	2007-02-20 14:33:23.000000000 +1100
+++ linux-cell/arch/powerpc/mm/hugetlbpage.c	2007-02-20 18:03:15.000000000 +1100
@@ -24,6 +24,7 @@
 #include <asm/machdep.h>
 #include <asm/cputable.h>
 #include <asm/tlb.h>
+#include <asm/spu.h>
 
 #include <linux/sysctl.h>
 
@@ -513,6 +514,9 @@ int prepare_hugepage_range(unsigned long
 	if ((addr + len) > 0x100000000UL)
 		err = open_high_hpage_areas(current->mm,
 					    HTLB_AREA_MASK(addr, len));
+#ifdef CONFIG_SPE_BASE
+	spu_flush_all_slbs(current->mm);
+#endif
 	if (err) {
 		printk(KERN_DEBUG "prepare_hugepage_range(%lx, %lx)"
 		       " failed (lowmask: 0x%04hx, highmask: 0x%04hx)\n",
Index: linux-cell/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spu_base.c	2007-02-20 14:32:31.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/cell/spu_base.c	2007-02-20 18:03:15.000000000 +1100
@@ -38,8 +38,61 @@
 const struct spu_management_ops *spu_management_ops;
 const struct spu_priv1_ops *spu_priv1_ops;
 
+static struct list_head spu_list[MAX_NUMNODES];
+static LIST_HEAD(spu_full_list);
+static DEFINE_MUTEX(spu_mutex);
+static spinlock_t spu_list_lock = SPIN_LOCK_UNLOCKED;
+
 EXPORT_SYMBOL_GPL(spu_priv1_ops);
 
+void spu_invalidate_slbs(struct spu *spu)
+{
+	struct spu_priv2 __iomem *priv2 = spu->priv2;
+
+	if (spu_mfc_sr1_get(spu) & MFC_STATE1_RELOCATE_MASK)
+		out_be64(&priv2->slb_invalidate_all_W, 0UL);
+}
+EXPORT_SYMBOL_GPL(spu_invalidate_slbs);
+
+/* This is called by the MM core when a segment size is changed, to
+ * request a flush of all the SPEs using a given mm
+ */
+void spu_flush_all_slbs(struct mm_struct *mm)
+{
+	struct spu *spu;
+	unsigned long flags;
+
+	spin_lock_irqsave(&spu_list_lock, flags);
+	list_for_each_entry(spu, &spu_full_list, full_list) {
+		if (spu->mm == mm)
+			spu_invalidate_slbs(spu);
+	}
+	spin_unlock_irqrestore(&spu_list_lock, flags);
+}
+
+/* The hack below stinks... try to do something better one of
+ * these days... Does it even work properly with NR_CPUS == 1 ?
+ */
+static inline void mm_needs_global_tlbie(struct mm_struct *mm)
+{
+	int nr = (NR_CPUS > 1) ? NR_CPUS : NR_CPUS + 1;
+
+	/* Global TLBIE broadcast required with SPEs. */
+	__cpus_setall(&mm->cpu_vm_mask, nr);
+}
+
+void spu_associate_mm(struct spu *spu, struct mm_struct *mm)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&spu_list_lock, flags);
+	spu->mm = mm;
+	spin_unlock_irqrestore(&spu_list_lock, flags);
+	if (mm)
+		mm_needs_global_tlbie(mm);
+}
+EXPORT_SYMBOL_GPL(spu_associate_mm);
+
 static int __spu_trap_invalid_dma(struct spu *spu)
 {
 	pr_debug("%s\n", __FUNCTION__);
@@ -74,6 +127,7 @@ static int __spu_trap_data_seg(struct sp
 	struct spu_priv2 __iomem *priv2 = spu->priv2;
 	struct mm_struct *mm = spu->mm;
 	u64 esid, vsid, llp;
+	int psize;
 
 	pr_debug("%s\n", __FUNCTION__);
 
@@ -90,22 +144,25 @@ static int __spu_trap_data_seg(struct sp
 	case USER_REGION_ID:
 #ifdef CONFIG_HUGETLB_PAGE
 		if (in_hugepage_area(mm->context, ea))
-			llp = mmu_psize_defs[mmu_huge_psize].sllp;
+			psize = mmu_huge_psize;
 		else
 #endif
-			llp = mmu_psize_defs[mmu_virtual_psize].sllp;
+			psize = mm->context.user_psize;
 		vsid = (get_vsid(mm->context.id, ea) << SLB_VSID_SHIFT) |
-				SLB_VSID_USER | llp;
+				SLB_VSID_USER;
 		break;
 	case VMALLOC_REGION_ID:
-		llp = mmu_psize_defs[mmu_virtual_psize].sllp;
+		if (ea < VMALLOC_END)
+			psize = mmu_vmalloc_psize;
+		else
+			psize = mmu_io_psize;
 		vsid = (get_kernel_vsid(ea) << SLB_VSID_SHIFT) |
-			SLB_VSID_KERNEL | llp;
+			SLB_VSID_KERNEL;
 		break;
 	case KERNEL_REGION_ID:
-		llp = mmu_psize_defs[mmu_linear_psize].sllp;
+		psize = mmu_linear_psize;
 		vsid = (get_kernel_vsid(ea) << SLB_VSID_SHIFT) |
-			SLB_VSID_KERNEL | llp;
+			SLB_VSID_KERNEL;
 		break;
 	default:
 		/* Future: support kernel segments so that drivers
@@ -114,9 +171,10 @@ static int __spu_trap_data_seg(struct sp
 		pr_debug("invalid region access at %016lx\n", ea);
 		return 1;
 	}
+	llp = mmu_psize_defs[psize].sllp;
 
 	out_be64(&priv2->slb_index_W, spu->slb_replace);
-	out_be64(&priv2->slb_vsid_RW, vsid);
+	out_be64(&priv2->slb_vsid_RW, vsid | llp);
 	out_be64(&priv2->slb_esid_RW, esid);
 
 	spu->slb_replace++;
@@ -330,10 +388,6 @@ static void spu_free_irqs(struct spu *sp
 		free_irq(spu->irqs[2], spu);
 }
 
-static struct list_head spu_list[MAX_NUMNODES];
-static LIST_HEAD(spu_full_list);
-static DEFINE_MUTEX(spu_mutex);
-
 static void spu_init_channels(struct spu *spu)
 {
 	static const struct {
@@ -593,6 +647,7 @@ static int __init create_spu(void *data)
 	struct spu *spu;
 	int ret;
 	static int number;
+	unsigned long flags;
 
 	ret = -ENOMEM;
 	spu = kzalloc(sizeof (*spu), GFP_KERNEL);
@@ -620,8 +675,10 @@ static int __init create_spu(void *data)
 		goto out_free_irqs;
 
 	mutex_lock(&spu_mutex);
+	spin_lock_irqsave(&spu_list_lock, flags);
 	list_add(&spu->list, &spu_list[spu->node]);
 	list_add(&spu->full_list, &spu_full_list);
+	spin_unlock_irqrestore(&spu_list_lock, flags);
 	mutex_unlock(&spu_mutex);
 
 	goto out;
Index: linux-cell/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spufs/switch.c	2007-02-20 14:35:26.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/cell/spufs/switch.c	2007-02-20 18:03:13.000000000 +1100
@@ -468,26 +468,6 @@ static inline void wait_purge_complete(s
 			 MFC_CNTL_PURGE_DMA_COMPLETE);
 }
 
-static inline void save_mfc_slbs(struct spu_state *csa, struct spu *spu)
-{
-	struct spu_priv2 __iomem *priv2 = spu->priv2;
-	int i;
-
-	/* Save, Step 29:
-	 *     If MFC_SR1[R]='1', save SLBs in CSA.
-	 */
-	if (spu_mfc_sr1_get(spu) & MFC_STATE1_RELOCATE_MASK) {
-		csa->priv2.slb_index_W = in_be64(&priv2->slb_index_W);
-		for (i = 0; i < 8; i++) {
-			out_be64(&priv2->slb_index_W, i);
-			eieio();
-			csa->slb_esid_RW[i] = in_be64(&priv2->slb_esid_RW);
-			csa->slb_vsid_RW[i] = in_be64(&priv2->slb_vsid_RW);
-			eieio();
-		}
-	}
-}
-
 static inline void setup_mfc_sr1(struct spu_state *csa, struct spu *spu)
 {
 	/* Save, Step 30:
@@ -708,20 +688,6 @@ static inline void resume_mfc_queue(stru
 	out_be64(&priv2->mfc_control_RW, MFC_CNTL_RESUME_DMA_QUEUE);
 }
 
-static inline void invalidate_slbs(struct spu_state *csa, struct spu *spu)
-{
-	struct spu_priv2 __iomem *priv2 = spu->priv2;
-
-	/* Save, Step 45:
-	 * Restore, Step 19:
-	 *     If MFC_SR1[R]=1, write 0 to SLB_Invalidate_All.
-	 */
-	if (spu_mfc_sr1_get(spu) & MFC_STATE1_RELOCATE_MASK) {
-		out_be64(&priv2->slb_invalidate_all_W, 0UL);
-		eieio();
-	}
-}
-
 static inline void get_kernel_slb(u64 ea, u64 slb[2])
 {
 	u64 llp;
@@ -765,7 +731,7 @@ static inline void setup_mfc_slbs(struct
 	 *     MFC_SR1[R]=1 (in other words, assume that
 	 *     translation is desired by OS environment).
 	 */
-	invalidate_slbs(csa, spu);
+	spu_invalidate_slbs(spu);
 	get_kernel_slb((unsigned long)&spu_save_code[0], code_slb);
 	get_kernel_slb((unsigned long)csa->lscsa, lscsa_slb);
 	load_mfc_slb(spu, code_slb, 0);
@@ -1718,27 +1684,6 @@ static inline void check_ppuint_mb_stat(
 	}
 }
 
-static inline void restore_mfc_slbs(struct spu_state *csa, struct spu *spu)
-{
-	struct spu_priv2 __iomem *priv2 = spu->priv2;
-	int i;
-
-	/* Restore, Step 68:
-	 *     If MFC_SR1[R]='1', restore SLBs from CSA.
-	 */
-	if (csa->priv1.mfc_sr1_RW & MFC_STATE1_RELOCATE_MASK) {
-		for (i = 0; i < 8; i++) {
-			out_be64(&priv2->slb_index_W, i);
-			eieio();
-			out_be64(&priv2->slb_esid_RW, csa->slb_esid_RW[i]);
-			out_be64(&priv2->slb_vsid_RW, csa->slb_vsid_RW[i]);
-			eieio();
-		}
-		out_be64(&priv2->slb_index_W, csa->priv2.slb_index_W);
-		eieio();
-	}
-}
-
 static inline void restore_mfc_sr1(struct spu_state *csa, struct spu *spu)
 {
 	/* Restore, Step 69:
@@ -1875,7 +1820,6 @@ static void save_csa(struct spu_state *p
 	set_mfc_tclass_id(prev, spu);	/* Step 26. */
 	purge_mfc_queue(prev, spu);	/* Step 27. */
 	wait_purge_complete(prev, spu);	/* Step 28. */
-	save_mfc_slbs(prev, spu);	/* Step 29. */
 	setup_mfc_sr1(prev, spu);	/* Step 30. */
 	save_spu_npc(prev, spu);	/* Step 31. */
 	save_spu_privcntl(prev, spu);	/* Step 32. */
@@ -1987,7 +1931,7 @@ static void harvest(struct spu_state *pr
 	reset_spu_privcntl(prev, spu);	        /* Step 16. */
 	reset_spu_lslr(prev, spu);              /* Step 17. */
 	setup_mfc_sr1(prev, spu);	        /* Step 18. */
-	invalidate_slbs(prev, spu);	        /* Step 19. */
+	spu_invalidate_slbs(spu);        	/* Step 19. */
 	reset_ch_part1(prev, spu);	        /* Step 20. */
 	reset_ch_part2(prev, spu);	        /* Step 21. */
 	enable_interrupts(prev, spu);	        /* Step 22. */
@@ -2055,7 +1999,7 @@ static void restore_csa(struct spu_state
 	restore_spu_mb(next, spu);	        /* Step 65. */
 	check_ppu_mb_stat(next, spu);	        /* Step 66. */
 	check_ppuint_mb_stat(next, spu);	/* Step 67. */
-	restore_mfc_slbs(next, spu);	        /* Step 68. */
+	spu_invalidate_slbs(spu);		/* Modified Step 68. */
 	restore_mfc_sr1(next, spu);	        /* Step 69. */
 	restore_other_spu_access(next, spu);	/* Step 70. */
 	restore_spu_runcntl(next, spu);	        /* Step 71. */
Index: linux-cell/include/asm-powerpc/spu.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/spu.h	2007-02-20 14:34:20.000000000 +1100
+++ linux-cell/include/asm-powerpc/spu.h	2007-02-20 15:22:27.000000000 +1100
@@ -165,6 +165,13 @@ int spu_irq_class_0_bottom(struct spu *s
 int spu_irq_class_1_bottom(struct spu *spu);
 void spu_irq_setaffinity(struct spu *spu, int cpu);
 
+extern void spu_invalidate_slbs(struct spu *spu);
+extern void spu_associate_mm(struct spu *spu, struct mm_struct *mm);
+
+/* Calls from the memory management to the SPU */
+struct mm_struct;
+extern void spu_flush_all_slbs(struct mm_struct *mm);
+
 /* system callbacks from the SPU */
 struct spu_syscall_block {
 	u64 nr_ret;
Index: linux-cell/include/asm-powerpc/spu_csa.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/spu_csa.h	2007-02-20 14:35:02.000000000 +1100
+++ linux-cell/include/asm-powerpc/spu_csa.h	2007-02-20 18:03:14.000000000 +1100
@@ -221,8 +221,6 @@ struct spu_priv2_collapsed {
  * @spu_chnlcnt_RW: Array of saved channel counts.
  * @spu_chnldata_RW: Array of saved channel data.
  * @suspend_time: Time stamp when decrementer disabled.
- * @slb_esid_RW: Array of saved SLB esid entries.
- * @slb_vsid_RW: Array of saved SLB vsid entries.
  *
  * Structure representing the whole of the SPU
  * context save area (CSA).  This struct contains
@@ -245,8 +243,6 @@ struct spu_state {
 	u32 spu_mailbox_data[4];
 	u32 pu_mailbox_data[1];
 	unsigned long suspend_time;
-	u64 slb_esid_RW[8];
-	u64 slb_vsid_RW[8];
 	spinlock_t register_lock;
 };
 
Index: linux-cell/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/hash_utils_64.c	2007-02-20 14:44:10.000000000 +1100
+++ linux-cell/arch/powerpc/mm/hash_utils_64.c	2007-02-20 18:03:15.000000000 +1100
@@ -685,6 +685,9 @@ int hash_page(unsigned long ea, unsigned
 				       "non-cacheable mapping\n");
 				psize = mmu_vmalloc_psize = MMU_PAGE_4K;
 			}
+#ifdef CONFIG_SPE_BASE
+			spu_flush_all_slbs(mm);
+#endif
 		}
 		if (user_region) {
 			if (psize != get_paca()->context.user_psize) {
@@ -759,6 +762,9 @@ void hash_preload(struct mm_struct *mm, 
 				mmu_psize_defs[MMU_PAGE_4K].sllp;
 			get_paca()->context = mm->context;
 			slb_flush_and_rebolt();
+#ifdef CONFIG_SPE_BASE
+			spu_flush_all_slbs(mm);
+#endif
 		}
 	}
 	if (mm->context.user_psize == MMU_PAGE_64K)
Index: linux-cell/arch/powerpc/platforms/cell/spufs/sched.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spufs/sched.c	2007-02-20 15:23:02.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/cell/spufs/sched.c	2007-02-20 15:25:07.000000000 +1100
@@ -127,14 +127,6 @@ static void spu_remove_from_active_list(
 	mutex_unlock(&spu_prio->active_mutex[node]);
 }
 
-static inline void mm_needs_global_tlbie(struct mm_struct *mm)
-{
-	int nr = (NR_CPUS > 1) ? NR_CPUS : NR_CPUS + 1;
-
-	/* Global TLBIE broadcast required with SPEs. */
-	__cpus_setall(&mm->cpu_vm_mask, nr);
-}
-
 static BLOCKING_NOTIFIER_HEAD(spu_switch_notifier);
 
 static void spu_switch_notify(struct spu *spu, struct spu_context *ctx)
@@ -167,8 +159,7 @@ static void spu_bind_context(struct spu 
 	ctx->spu = spu;
 	ctx->ops = &spu_hw_ops;
 	spu->pid = current->pid;
-	spu->mm = ctx->owner;
-	mm_needs_global_tlbie(spu->mm);
+	spu_associate_mm(spu, ctx->owner);
 	spu->ibox_callback = spufs_ibox_callback;
 	spu->wbox_callback = spufs_wbox_callback;
 	spu->stop_callback = spufs_stop_callback;
@@ -205,7 +196,7 @@ static void spu_unbind_context(struct sp
 	spu->stop_callback = NULL;
 	spu->mfc_callback = NULL;
 	spu->dma_callback = NULL;
-	spu->mm = NULL;
+	spu_associate_mm(spu, NULL);
 	spu->pid = 0;
 	ctx->ops = &spu_backing_ops;
 	ctx->spu = NULL;
