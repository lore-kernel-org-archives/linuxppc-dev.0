Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 02 Jun 2009 17:50:10 +1000
Subject: [PATCH 4/5] powerpc: Separate PACA fields for server CPUs
In-Reply-To: <1243929002.876045.46197476176.qpush@grosgo>
Message-Id: <20090602075027.BE148DDF84@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch has no effect other than re-ordering PACA fields on
current server CPUs. It however is a pre-requisite for future
support of BookE 64-bit processors. Various parts of the PACA
struct are now moved under some ifdef's, either the new
CONFIG_PPC_BOOK3S or CONFIG_PPC_STD_MMU_64, whatever seems more
appropriate.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.craashing.org>
---

 arch/powerpc/include/asm/paca.h   |   12 +++++++++---
 arch/powerpc/kernel/asm-offsets.c |   32 +++++++++++++++++---------------
 arch/powerpc/kernel/paca.c        |   14 +++++++++++++-
 3 files changed, 39 insertions(+), 19 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/paca.h	2009-06-02 17:05:07.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/paca.h	2009-06-02 17:05:09.000000000 +1000
@@ -43,6 +43,7 @@ struct task_struct;
  * processor.
  */
 struct paca_struct {
+#ifdef CONFIG_PPC_BOOK3S
 	/*
 	 * Because hw_cpu_id, unlike other paca fields, is accessed
 	 * routinely from other CPUs (from the IRQ code), we stick to
@@ -51,7 +52,7 @@ struct paca_struct {
 	 */
 
 	struct lppaca *lppaca_ptr;	/* Pointer to LpPaca for PLIC */
-
+#endif /* CONFIG_PPC_BOOK3S */
 	/*
 	 * MAGIC: the spinlock functions in arch/powerpc/lib/locks.c 
 	 * load lock_token and paca_index with a single lwz
@@ -64,13 +65,16 @@ struct paca_struct {
 	u64 kernel_toc;			/* Kernel TOC address */
 	u64 kernelbase;			/* Base address of kernel */
 	u64 kernel_msr;			/* MSR while running in kernel */
+#ifdef CONFIG_PPC_STD_MMU_64
 	u64 stab_real;			/* Absolute address of segment table */
 	u64 stab_addr;			/* Virtual address of segment table */
+#endif /* CONFIG_PPC_STD_MMU_64 */
 	void *emergency_sp;		/* pointer to emergency stack */
 	u64 data_offset;		/* per cpu data offset */
 	s16 hw_cpu_id;			/* Physical processor number */
 	u8 cpu_start;			/* At startup, processor spins until */
 					/* this becomes non-zero. */
+#ifdef CONFIG_PPC_STD_MMU_64
 	struct slb_shadow *slb_shadow_ptr;
 
 	/*
@@ -81,11 +85,13 @@ struct paca_struct {
 	u64 exmc[10];		/* used for machine checks */
 	u64 exslb[10];		/* used for SLB/segment table misses
  				 * on the linear mapping */
-
-	mm_context_t context;
+	/* SLB related definitions */
 	u16 vmalloc_sllp;
 	u16 slb_cache_ptr;
 	u16 slb_cache[SLB_CACHE_ENTRIES];
+#endif /* CONFIG_PPC_STD_MMU_64 */
+
+	mm_context_t context;
 
 	/*
 	 * then miscellaneous read-write fields
Index: linux-work/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/asm-offsets.c	2009-06-02 17:05:07.000000000 +1000
+++ linux-work/arch/powerpc/kernel/asm-offsets.c	2009-06-02 17:05:23.000000000 +1000
@@ -122,8 +122,6 @@ int main(void)
 	DEFINE(PACAKSAVE, offsetof(struct paca_struct, kstack));
 	DEFINE(PACACURRENT, offsetof(struct paca_struct, __current));
 	DEFINE(PACASAVEDMSR, offsetof(struct paca_struct, saved_msr));
-	DEFINE(PACASTABREAL, offsetof(struct paca_struct, stab_real));
-	DEFINE(PACASTABVIRT, offsetof(struct paca_struct, stab_addr));
 	DEFINE(PACASTABRR, offsetof(struct paca_struct, stab_rr));
 	DEFINE(PACAR1, offsetof(struct paca_struct, saved_r1));
 	DEFINE(PACATOC, offsetof(struct paca_struct, kernel_toc));
@@ -131,35 +129,30 @@ int main(void)
 	DEFINE(PACAKMSR, offsetof(struct paca_struct, kernel_msr));
 	DEFINE(PACASOFTIRQEN, offsetof(struct paca_struct, soft_enabled));
 	DEFINE(PACAHARDIRQEN, offsetof(struct paca_struct, hard_enabled));
-	DEFINE(PACASLBCACHE, offsetof(struct paca_struct, slb_cache));
-	DEFINE(PACASLBCACHEPTR, offsetof(struct paca_struct, slb_cache_ptr));
 	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, context.id));
-	DEFINE(PACAVMALLOCSLLP, offsetof(struct paca_struct, vmalloc_sllp));
 #ifdef CONFIG_PPC_MM_SLICES
 	DEFINE(PACALOWSLICESPSIZE, offsetof(struct paca_struct,
 					    context.low_slices_psize));
 	DEFINE(PACAHIGHSLICEPSIZE, offsetof(struct paca_struct,
 					    context.high_slices_psize));
 	DEFINE(MMUPSIZEDEFSIZE, sizeof(struct mmu_psize_def));
+#endif /* CONFIG_PPC_MM_SLICES */
+#ifdef CONFIG_PPC_STD_MMU_64
+	DEFINE(PACASTABREAL, offsetof(struct paca_struct, stab_real));
+	DEFINE(PACASTABVIRT, offsetof(struct paca_struct, stab_addr));
+	DEFINE(PACASLBCACHE, offsetof(struct paca_struct, slb_cache));
+	DEFINE(PACASLBCACHEPTR, offsetof(struct paca_struct, slb_cache_ptr));
+	DEFINE(PACAVMALLOCSLLP, offsetof(struct paca_struct, vmalloc_sllp));
+#ifdef CONFIG_PPC_MM_SLICES
 	DEFINE(MMUPSIZESLLP, offsetof(struct mmu_psize_def, sllp));
 #else
 	DEFINE(PACACONTEXTSLLP, offsetof(struct paca_struct, context.sllp));
-
 #endif /* CONFIG_PPC_MM_SLICES */
 	DEFINE(PACA_EXGEN, offsetof(struct paca_struct, exgen));
 	DEFINE(PACA_EXMC, offsetof(struct paca_struct, exmc));
 	DEFINE(PACA_EXSLB, offsetof(struct paca_struct, exslb));
-	DEFINE(PACAEMERGSP, offsetof(struct paca_struct, emergency_sp));
 	DEFINE(PACALPPACAPTR, offsetof(struct paca_struct, lppaca_ptr));
-	DEFINE(PACAHWCPUID, offsetof(struct paca_struct, hw_cpu_id));
-	DEFINE(PACA_STARTPURR, offsetof(struct paca_struct, startpurr));
-	DEFINE(PACA_STARTSPURR, offsetof(struct paca_struct, startspurr));
-	DEFINE(PACA_USER_TIME, offsetof(struct paca_struct, user_time));
-	DEFINE(PACA_SYSTEM_TIME, offsetof(struct paca_struct, system_time));
 	DEFINE(PACA_SLBSHADOWPTR, offsetof(struct paca_struct, slb_shadow_ptr));
-	DEFINE(PACA_DATA_OFFSET, offsetof(struct paca_struct, data_offset));
-	DEFINE(PACA_TRAP_SAVE, offsetof(struct paca_struct, trap_save));
-
 	DEFINE(SLBSHADOW_STACKVSID,
 	       offsetof(struct slb_shadow, save_area[SLB_NUM_BOLTED - 1].vsid));
 	DEFINE(SLBSHADOW_STACKESID,
@@ -169,6 +162,15 @@ int main(void)
 	DEFINE(LPPACAANYINT, offsetof(struct lppaca, int_dword.any_int));
 	DEFINE(LPPACADECRINT, offsetof(struct lppaca, int_dword.fields.decr_int));
 	DEFINE(SLBSHADOW_SAVEAREA, offsetof(struct slb_shadow, save_area));
+#endif /* CONFIG_PPC_STD_MMU_64 */
+	DEFINE(PACAEMERGSP, offsetof(struct paca_struct, emergency_sp));
+	DEFINE(PACAHWCPUID, offsetof(struct paca_struct, hw_cpu_id));
+	DEFINE(PACA_STARTPURR, offsetof(struct paca_struct, startpurr));
+	DEFINE(PACA_STARTSPURR, offsetof(struct paca_struct, startspurr));
+	DEFINE(PACA_USER_TIME, offsetof(struct paca_struct, user_time));
+	DEFINE(PACA_SYSTEM_TIME, offsetof(struct paca_struct, system_time));
+	DEFINE(PACA_DATA_OFFSET, offsetof(struct paca_struct, data_offset));
+	DEFINE(PACA_TRAP_SAVE, offsetof(struct paca_struct, trap_save));
 #endif /* CONFIG_PPC64 */
 
 	/* RTAS */
Index: linux-work/arch/powerpc/kernel/paca.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/paca.c	2009-06-02 17:05:07.000000000 +1000
+++ linux-work/arch/powerpc/kernel/paca.c	2009-06-02 17:05:09.000000000 +1000
@@ -18,6 +18,8 @@
  * field correctly */
 extern unsigned long __toc_start;
 
+#ifdef CONFIG_PPC_BOOK3S
+
 /*
  * The structure which the hypervisor knows about - this structure
  * should not cross a page boundary.  The vpa_init/register_vpa call
@@ -41,6 +43,10 @@ struct lppaca lppaca[] = {
 	},
 };
 
+#endif /* CONFIG_PPC_BOOK3S */
+
+#ifdef CONFIG_PPC_STD_MMU_64
+
 /*
  * 3 persistent SLBs are registered here.  The buffer will be zero
  * initially, hence will all be invaild until we actually write them.
@@ -52,6 +58,8 @@ struct slb_shadow slb_shadow[] __cacheli
 	},
 };
 
+#endif /* CONFIG_PPC_STD_MMU_64 */
+
 /* The Paca is an array with one entry per processor.  Each contains an
  * lppaca, which contains the information shared between the
  * hypervisor and Linux.
@@ -77,15 +85,19 @@ void __init initialise_pacas(void)
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		struct paca_struct *new_paca = &paca[cpu];
 
+#ifdef CONFIG_PPC_BOOK3S
 		new_paca->lppaca_ptr = &lppaca[cpu];
+#endif
 		new_paca->lock_token = 0x8000;
 		new_paca->paca_index = cpu;
 		new_paca->kernel_toc = kernel_toc;
 		new_paca->kernelbase = (unsigned long) _stext;
 		new_paca->kernel_msr = MSR_KERNEL;
 		new_paca->hw_cpu_id = 0xffff;
-		new_paca->slb_shadow_ptr = &slb_shadow[cpu];
 		new_paca->__current = &init_task;
+#ifdef CONFIG_PPC_STD_MMU_64
+		new_paca->slb_shadow_ptr = &slb_shadow[cpu];
+#endif /* CONFIG_PPC_STD_MMU_64 */
 
 	}
 }
