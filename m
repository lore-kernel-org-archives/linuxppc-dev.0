Return-Path: <mikey@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] SLB shadow buffer 
From: Michael Neuling <mikey@neuling.org>
Date: Mon, 07 Aug 2006 16:19:19 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060807061920.3E2B7679E9@ozlabs.org>
Cc: paulus@samba.org, anton@samba.org, miltonm@bga.com
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a shadow buffer for the SLBs and regsiters it with PHYP.
Only the bolted SLB entries (top 3) are shadowed.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Updated with comments from Milton.

 arch/powerpc/kernel/asm-offsets.c               |    2 +
 arch/powerpc/kernel/entry_64.S                  |   13 ++++++++
 arch/powerpc/kernel/paca.c                      |   15 +++++++++
 arch/powerpc/mm/slb.c                           |   37 +++++++++++++++++++++---
 arch/powerpc/platforms/pseries/lpar.c           |   24 ++++++++++++---
 arch/powerpc/platforms/pseries/plpar_wrappers.h |   10 ++++++
 arch/powerpc/platforms/pseries/setup.c          |   12 ++++++-
 include/asm-powerpc/lppaca.h                    |   19 ++++++++++++
 include/asm-powerpc/paca.h                      |    3 +
 9 files changed, 124 insertions(+), 11 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/asm-offsets.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/asm-offsets.c
@@ -135,11 +135,13 @@ int main(void)
 	DEFINE(PACA_STARTPURR, offsetof(struct paca_struct, startpurr));
 	DEFINE(PACA_USER_TIME, offsetof(struct paca_struct, user_time));
 	DEFINE(PACA_SYSTEM_TIME, offsetof(struct paca_struct, system_time));
+	DEFINE(PACA_SLBSHADOWPTR, offsetof(struct paca_struct, slb_shadow_ptr));
 
 	DEFINE(LPPACASRR0, offsetof(struct lppaca, saved_srr0));
 	DEFINE(LPPACASRR1, offsetof(struct lppaca, saved_srr1));
 	DEFINE(LPPACAANYINT, offsetof(struct lppaca, int_dword.any_int));
 	DEFINE(LPPACADECRINT, offsetof(struct lppaca, int_dword.fields.decr_int));
+	DEFINE(SLBSHADOW_SAVEAREA, offsetof(struct slb_shadow, save_area));
 #endif /* CONFIG_PPC64 */
 
 	/* RTAS */
Index: linux-2.6-ozlabs/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/entry_64.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/entry_64.S
@@ -323,6 +323,11 @@ _GLOBAL(ret_from_fork)
  * The code which creates the new task context is in 'copy_thread'
  * in arch/powerpc/kernel/process.c 
  */
+#define SHADOW_SLB_BOLTED_STACK_ESID \
+		(SLBSHADOW_SAVEAREA + 0x10*(SLB_NUM_BOLTED-1))
+#define SHADOW_SLB_BOLTED_STACK_VSID \
+		(SLBSHADOW_SAVEAREA + 0x10*(SLB_NUM_BOLTED-1) + 8)
+
 	.align	7
 _GLOBAL(_switch)
 	mflr	r0
@@ -375,6 +380,14 @@ BEGIN_FTR_SECTION
 	ld	r7,KSP_VSID(r4)	/* Get new stack's VSID */
 	oris	r0,r6,(SLB_ESID_V)@h
 	ori	r0,r0,(SLB_NUM_BOLTED-1)@l
+
+	/* Update the last bolted SLB */
+	ld	r9,PACA_SLBSHADOWPTR(r13)
+ 	li	r12,0
+  	std	r12,SHADOW_SLB_BOLTED_STACK_ESID(r9) /* Clear ESID */
+	std	r7,SHADOW_SLB_BOLTED_STACK_VSID(r9)  /* Save VSID */
+ 	std	r0,SHADOW_SLB_BOLTED_STACK_ESID(r9)  /* Save ESID */
+
 	slbie	r6
 	slbie	r6		/* Workaround POWER5 < DD2.1 issue */
 	slbmte	r7,r0
Index: linux-2.6-ozlabs/arch/powerpc/kernel/paca.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/paca.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/paca.c
@@ -17,6 +17,7 @@
 #include <asm/lppaca.h>
 #include <asm/iseries/it_lp_reg_save.h>
 #include <asm/paca.h>
+#include <asm/mmu.h>
 
 
 /* This symbol is provided by the linker - let it fill in the paca
@@ -45,6 +46,17 @@ struct lppaca lppaca[] = {
 	},
 };
 
+/*
+ * 3 persistent SLBs are registered here.  The buffer will be zero
+ * initially, hence will all be invaild until we actually write them.
+ */
+struct slb_shadow slb_shadow[] __cacheline_aligned = {
+	[0 ... (NR_CPUS-1)] = {
+		.persistent = SLB_NUM_BOLTED,
+		.buffer_length = sizeof(struct slb_shadow),
+	},
+};
+
 /* The Paca is an array with one entry per processor.  Each contains an
  * lppaca, which contains the information shared between the
  * hypervisor and Linux.
@@ -59,7 +71,8 @@ struct lppaca lppaca[] = {
 	.lock_token = 0x8000,						    \
 	.paca_index = (number),		/* Paca Index */		    \
 	.kernel_toc = (unsigned long)(&__toc_start) + 0x8000UL,		    \
-	.hw_cpu_id = 0xffff,
+	.hw_cpu_id = 0xffff,						    \
+	.slb_shadow_ptr = &slb_shadow[number],
 
 #ifdef CONFIG_PPC_ISERIES
 #define PACA_INIT_ISERIES(number)					    \
Index: linux-2.6-ozlabs/arch/powerpc/mm/slb.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/mm/slb.c
+++ linux-2.6-ozlabs/arch/powerpc/mm/slb.c
@@ -22,6 +22,8 @@
 #include <asm/paca.h>
 #include <asm/cputable.h>
 #include <asm/cacheflush.h>
+#include <asm/smp.h>
+#include <linux/compiler.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -50,9 +52,32 @@ static inline unsigned long mk_vsid_data
 	return (get_kernel_vsid(ea) << SLB_VSID_SHIFT) | flags;
 }
 
-static inline void create_slbe(unsigned long ea, unsigned long flags,
-			       unsigned long entry)
+static inline void slb_shadow_update(unsigned long esid, unsigned long vsid,
+				     unsigned long entry)
 {
+	/*
+	 * Clear the ESID first so the entry is not valid while we are
+	 * updating it.
+	 */
+	get_slb_shadow()->save_area[entry].esid = 0;
+	barrier();
+	get_slb_shadow()->save_area[entry].vsid = vsid;
+	barrier();
+	get_slb_shadow()->save_area[entry].esid = esid;
+
+}
+
+static inline void create_shadowed_slbe(unsigned long ea, unsigned long flags,
+					unsigned long entry)
+{
+	/*
+	 * Updating the shadow buffer before writing the SLB ensures
+	 * we don't get a stale entry here if we get preempted by PHYP
+	 * between these two statements.
+	 */
+	slb_shadow_update(mk_esid_data(ea, entry), mk_vsid_data(ea, flags),
+			  entry);
+
 	asm volatile("slbmte  %0,%1" :
 		     : "r" (mk_vsid_data(ea, flags)),
 		       "r" (mk_esid_data(ea, entry))
@@ -77,6 +102,10 @@ void slb_flush_and_rebolt(void)
 	if ((ksp_esid_data & ESID_MASK) == PAGE_OFFSET)
 		ksp_esid_data &= ~SLB_ESID_V;
 
+	/* Only third entry (stack) may change here so only resave that */
+	slb_shadow_update(ksp_esid_data,
+			  mk_vsid_data(ksp_esid_data, lflags), 2);
+
 	/* We need to do this all in asm, so we're sure we don't touch
 	 * the stack between the slbia and rebolting it. */
 	asm volatile("isync\n"
@@ -209,9 +238,9 @@ void slb_initialize(void)
 	asm volatile("isync":::"memory");
 	asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
 	asm volatile("isync; slbia; isync":::"memory");
-	create_slbe(PAGE_OFFSET, lflags, 0);
+	create_shadowed_slbe(PAGE_OFFSET, lflags, 0);
 
-	create_slbe(VMALLOC_START, vflags, 1);
+	create_shadowed_slbe(VMALLOC_START, vflags, 1);
 
 	/* We don't bolt the stack for the time being - we're in boot,
 	 * so the stack is in the bolted segment.  By the time it goes
Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/lpar.c
+++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/lpar.c
@@ -254,18 +254,34 @@ out:
 void vpa_init(int cpu)
 {
 	int hwcpu = get_hard_smp_processor_id(cpu);
-	unsigned long vpa = __pa(&lppaca[cpu]);
+	unsigned long addr;
 	long ret;
 
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		lppaca[cpu].vmxregs_in_use = 1;
 
-	ret = register_vpa(hwcpu, vpa);
+	addr = __pa(&lppaca[cpu]);
+	ret = register_vpa(hwcpu, addr);
 
-	if (ret)
+	if (ret) {
 		printk(KERN_ERR "WARNING: vpa_init: VPA registration for "
 				"cpu %d (hw %d) of area %lx returns %ld\n",
-				cpu, hwcpu, vpa, ret);
+				cpu, hwcpu, addr, ret);
+		return;
+	}
+	/*
+	 * PAPR says this feature is SLB-Buffer but firmware never
+	 * reports that.  All SPLPAR support SLB shadow buffer.
+	 */
+	addr = __pa(&slb_shadow[cpu]);
+	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
+		ret = register_slb_shadow(hwcpu, addr);
+		if (ret)
+			printk(KERN_ERR
+			       "WARNING: vpa_init: SLB shadow buffer "
+			       "registration for cpu %d (hw %d) of area %lx "
+			       "returns %ld\n", cpu, hwcpu, addr, ret);
+	}
 }
 
 long pSeries_lpar_hpte_insert(unsigned long hpte_group,
Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/plpar_wrappers.h
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/plpar_wrappers.h
+++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/plpar_wrappers.h
@@ -40,6 +40,16 @@ static inline long register_vpa(unsigned
 	return vpa_call(0x1, cpu, vpa);
 }
 
+static inline long unregister_slb_shadow(unsigned long cpu, unsigned long vpa)
+{
+	return vpa_call(0x7, cpu, vpa);
+}
+
+static inline long register_slb_shadow(unsigned long cpu, unsigned long vpa)
+{
+	return vpa_call(0x3, cpu, vpa);
+}
+
 extern void vpa_init(int cpu);
 
 static inline long plpar_pte_remove(unsigned long flags, unsigned long ptex,
Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/setup.c
+++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/setup.c
@@ -234,9 +234,17 @@ static void pseries_kexec_cpu_down_xics(
 {
 	/* Don't risk a hypervisor call if we're crashing */
 	if (firmware_has_feature(FW_FEATURE_SPLPAR) && !crash_shutdown) {
-		unsigned long vpa = __pa(get_lppaca());
+		unsigned long addr;
 
-		if (unregister_vpa(hard_smp_processor_id(), vpa)) {
+		addr = __pa(get_slb_shadow());
+		if (unregister_slb_shadow(hard_smp_processor_id(), addr))
+			printk("SLB shadow buffer deregistration of "
+			       "cpu %u (hw_cpu_id %d) failed\n",
+			       smp_processor_id(),
+			       hard_smp_processor_id());
+
+		addr = __pa(get_lppaca());
+		if (unregister_vpa(hard_smp_processor_id(), addr)) {
 			printk("VPA deregistration of cpu %u (hw_cpu_id %d) "
 					"failed\n", smp_processor_id(),
 					hard_smp_processor_id());
Index: linux-2.6-ozlabs/include/asm-powerpc/lppaca.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/lppaca.h
+++ linux-2.6-ozlabs/include/asm-powerpc/lppaca.h
@@ -27,7 +27,9 @@
 //
 //
 //----------------------------------------------------------------------------
+#include <linux/cache.h>
 #include <asm/types.h>
+#include <asm/mmu.h>
 
 /* The Hypervisor barfs if the lppaca crosses a page boundary.  A 1k
  * alignment is sufficient to prevent this */
@@ -133,5 +135,22 @@ struct lppaca {
 
 extern struct lppaca lppaca[];
 
+/*
+ * SLB shadow buffer structure as defined in the PAPR.  The save_area
+ * contains adjacent ESID and VSID pairs for each shadowed SLB.  The
+ * ESID is stored in the lower 64bits, then the VSID.
+ */
+struct slb_shadow {
+	u32	persistent;		// Number of persistent SLBs	x00-x03
+	u32	buffer_length;		// Total shadow buffer length	x04-x07
+	u64	reserved;		// Alignment			x08-x0f
+	struct	{
+		u64     esid;
+		u64	vsid;
+	} save_area[SLB_NUM_BOLTED];	//				x10-x40
+} ____cacheline_aligned;
+
+extern struct slb_shadow slb_shadow[];
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_LPPACA_H */
Index: linux-2.6-ozlabs/include/asm-powerpc/paca.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/paca.h
+++ linux-2.6-ozlabs/include/asm-powerpc/paca.h
@@ -23,6 +23,7 @@
 register struct paca_struct *local_paca asm("r13");
 #define get_paca()	local_paca
 #define get_lppaca()	(get_paca()->lppaca_ptr)
+#define get_slb_shadow()	(get_paca()->slb_shadow_ptr)
 
 struct task_struct;
 
@@ -98,6 +99,8 @@ struct paca_struct {
 	u64 user_time;			/* accumulated usermode TB ticks */
 	u64 system_time;		/* accumulated system TB ticks */
 	u64 startpurr;			/* PURR/TB value snapshot */
+
+	struct slb_shadow *slb_shadow_ptr;
 };
 
 extern struct paca_struct paca[];
