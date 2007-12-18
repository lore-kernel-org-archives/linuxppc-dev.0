Return-Path: <arnd@arndb.de>
Message-Id: <20071218175106.303146000@arndb.de>
References: <20071218174852.112644000@arndb.de>
Date: Tue, 18 Dec 2007 18:49:06 +0100
From: arnd@arndb.de
To: paulus@samba.org
Subject: [POWERPC 14/18] cell: handle kernel SLB setup in spu_base.c
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, the SPU context switch code (spufs/switch.c) sets up the
SPU's SLBs directly, which requires some low-level mm stuff.

This change moves the kernel SLB setup to spu_base.c, by exposing
a function spu_setup_kernel_slbs() to do this setup. This allows us
to remove the low-level mm code from switch.c, making it possible
to later move switch.c to the spufs module.

Also, add a struct spu_slb for the cases where we need to deal with
SLB entries.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/spu_base.c     |   49 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/cell/spufs/switch.c |   33 +------------------
 include/asm-powerpc/spu.h                  |    4 ++
 3 files changed, 54 insertions(+), 32 deletions(-)

Index: linux-2.6-new/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/spu_base.c
@@ -34,6 +34,7 @@
 #include <linux/linux_logo.h>
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
+#include <asm/spu_csa.h>
 #include <asm/xmon.h>
 #include <asm/prom.h>
 
@@ -73,6 +74,10 @@ static LIST_HEAD(spu_full_list);
 static DEFINE_SPINLOCK(spu_full_list_lock);
 static DEFINE_MUTEX(spu_full_list_mutex);
 
+struct spu_slb {
+	u64 esid, vsid;
+};
+
 void spu_invalidate_slbs(struct spu *spu)
 {
 	struct spu_priv2 __iomem *priv2 = spu->priv2;
@@ -150,6 +155,18 @@ static void spu_restart_dma(struct spu *
 		out_be64(&priv2->mfc_control_RW, MFC_CNTL_RESTART_DMA_COMMAND);
 }
 
+static inline void spu_load_slb(struct spu *spu, int slbe, struct spu_slb *slb)
+{
+	struct spu_priv2 __iomem *priv2 = spu->priv2;
+
+	pr_debug("%s: adding SLB[%d] 0x%016lx 0x%016lx\n",
+			__func__, slbe, slb->vsid, slb->esid);
+
+	out_be64(&priv2->slb_index_W, slbe);
+	out_be64(&priv2->slb_vsid_RW, slb->vsid);
+	out_be64(&priv2->slb_esid_RW, slb->esid);
+}
+
 static int __spu_trap_data_seg(struct spu *spu, unsigned long ea)
 {
 	struct spu_priv2 __iomem *priv2 = spu->priv2;
@@ -239,6 +256,38 @@ static int __spu_trap_data_map(struct sp
 	return 0;
 }
 
+static void __spu_kernel_slb(void *addr, struct spu_slb *slb)
+{
+	unsigned long ea = (unsigned long)addr;
+	u64 llp;
+
+	if (REGION_ID(ea) == KERNEL_REGION_ID)
+		llp = mmu_psize_defs[mmu_linear_psize].sllp;
+	else
+		llp = mmu_psize_defs[mmu_virtual_psize].sllp;
+
+	slb->vsid = (get_kernel_vsid(ea, MMU_SEGSIZE_256M) << SLB_VSID_SHIFT) |
+		SLB_VSID_KERNEL | llp;
+	slb->esid = (ea & ESID_MASK) | SLB_ESID_V;
+}
+
+/**
+ * Setup the SPU kernel SLBs, in preparation for a context save/restore. We
+ * need to map both the context save area, and the save/restore code.
+ */
+void spu_setup_kernel_slbs(struct spu *spu, struct spu_lscsa *lscsa, void *code)
+{
+	struct spu_slb code_slb, lscsa_slb;
+
+	__spu_kernel_slb(lscsa, &lscsa_slb);
+	__spu_kernel_slb(code, &code_slb);
+
+	spu_load_slb(spu, 0, &lscsa_slb);
+	if (lscsa_slb.esid != code_slb.esid)
+		spu_load_slb(spu, 1, &code_slb);
+}
+EXPORT_SYMBOL_GPL(spu_setup_kernel_slbs);
+
 static irqreturn_t
 spu_irq_class_0(int irq, void *data)
 {
Index: linux-2.6-new/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/spufs/switch.c
@@ -691,35 +691,8 @@ static inline void resume_mfc_queue(stru
 	out_be64(&priv2->mfc_control_RW, MFC_CNTL_RESUME_DMA_QUEUE);
 }
 
-static inline void get_kernel_slb(u64 ea, u64 slb[2])
-{
-	u64 llp;
-
-	if (REGION_ID(ea) == KERNEL_REGION_ID)
-		llp = mmu_psize_defs[mmu_linear_psize].sllp;
-	else
-		llp = mmu_psize_defs[mmu_virtual_psize].sllp;
-	slb[0] = (get_kernel_vsid(ea, MMU_SEGSIZE_256M) << SLB_VSID_SHIFT) |
-		SLB_VSID_KERNEL | llp;
-	slb[1] = (ea & ESID_MASK) | SLB_ESID_V;
-}
-
-static inline void load_mfc_slb(struct spu *spu, u64 slb[2], int slbe)
-{
-	struct spu_priv2 __iomem *priv2 = spu->priv2;
-
-	out_be64(&priv2->slb_index_W, slbe);
-	eieio();
-	out_be64(&priv2->slb_vsid_RW, slb[0]);
-	out_be64(&priv2->slb_esid_RW, slb[1]);
-	eieio();
-}
-
 static inline void setup_mfc_slbs(struct spu_state *csa, struct spu *spu)
 {
-	u64 code_slb[2];
-	u64 lscsa_slb[2];
-
 	/* Save, Step 47:
 	 * Restore, Step 30.
 	 *     If MFC_SR1[R]=1, write 0 to SLB_Invalidate_All
@@ -735,11 +708,7 @@ static inline void setup_mfc_slbs(struct
 	 *     translation is desired by OS environment).
 	 */
 	spu_invalidate_slbs(spu);
-	get_kernel_slb((unsigned long)&spu_save_code[0], code_slb);
-	get_kernel_slb((unsigned long)csa->lscsa, lscsa_slb);
-	load_mfc_slb(spu, code_slb, 0);
-	if ((lscsa_slb[0] != code_slb[0]) || (lscsa_slb[1] != code_slb[1]))
-		load_mfc_slb(spu, lscsa_slb, 1);
+	spu_setup_kernel_slbs(spu, csa->lscsa, &spu_save_code);
 }
 
 static inline void set_switch_active(struct spu_state *csa, struct spu *spu)
Index: linux-2.6-new/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6-new.orig/include/asm-powerpc/spu.h
+++ linux-2.6-new/include/asm-powerpc/spu.h
@@ -104,6 +104,7 @@
 
 struct spu_context;
 struct spu_runqueue;
+struct spu_lscsa;
 struct device_node;
 
 enum spu_utilization_state {
@@ -200,6 +201,9 @@ int spu_irq_class_0_bottom(struct spu *s
 int spu_irq_class_1_bottom(struct spu *spu);
 void spu_irq_setaffinity(struct spu *spu, int cpu);
 
+void spu_setup_kernel_slbs(struct spu *spu,
+		struct spu_lscsa *lscsa, void *code);
+
 #ifdef CONFIG_KEXEC
 void crash_register_spus(struct list_head *list);
 #else

-- 
