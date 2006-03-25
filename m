Return-Path: <anton@ozlabs.org>
Date: Sat, 25 Mar 2006 17:25:17 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Allow non zero boot cpuids
Message-ID: <20060325062517.GS30422@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


We currently have a hack to flip the boot cpu and its secondary thread
to logical cpuid 0 and 1. This means the logical - physical mapping will
differ depending on which cpu is boot cpu. This is most apparent on
kexec, where we might kexec on any cpu and therefore change the mapping
from boot to boot.

The patch below does a first pass early on to work out the logical cpuid
of the boot thread. We then fix up some paca structures to match.

Ive also removed the boot_cpuid_phys variable for ppc64, to be
consistent we use get_hard_smp_processor_id(boot_cpuid) everywhere.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/kernel/setup-common.c
===================================================================
--- build.orig/arch/powerpc/kernel/setup-common.c	2006-03-24 15:51:18.000000000 +1100
+++ build/arch/powerpc/kernel/setup-common.c	2006-03-24 16:13:06.000000000 +1100
@@ -352,12 +352,13 @@ void __init check_for_initrd(void)
  * must be called before using this.
  *
  * While we're here, we may as well set the "physical" cpu ids in the paca.
+ *
+ * NOTE: This must match the parsing done in early_init_dt_scan_cpus.
  */
 void __init smp_setup_cpu_maps(void)
 {
 	struct device_node *dn = NULL;
 	int cpu = 0;
-	int swap_cpuid = 0;
 
 	while ((dn = of_find_node_by_type(dn, "cpu")) && cpu < NR_CPUS) {
 		int *intserv;
@@ -376,24 +377,11 @@ void __init smp_setup_cpu_maps(void)
 		for (j = 0; j < nthreads && cpu < NR_CPUS; j++) {
 			cpu_set(cpu, cpu_present_map);
 			set_hard_smp_processor_id(cpu, intserv[j]);
-
-			if (intserv[j] == boot_cpuid_phys)
-				swap_cpuid = cpu;
 			cpu_set(cpu, cpu_possible_map);
 			cpu++;
 		}
 	}
 
-	/* Swap CPU id 0 with boot_cpuid_phys, so we can always assume that
-	 * boot cpu is logical 0.
-	 */
-	if (boot_cpuid_phys != get_hard_smp_processor_id(0)) {
-		u32 tmp;
-		tmp = get_hard_smp_processor_id(0);
-		set_hard_smp_processor_id(0, boot_cpuid_phys);
-		set_hard_smp_processor_id(swap_cpuid, tmp);
-	}
-
 #ifdef CONFIG_PPC64
 	/*
 	 * On pSeries LPAR, we need to know how many cpus
Index: build/arch/powerpc/kernel/setup_64.c
===================================================================
--- build.orig/arch/powerpc/kernel/setup_64.c	2006-03-24 16:12:56.000000000 +1100
+++ build/arch/powerpc/kernel/setup_64.c	2006-03-24 16:13:06.000000000 +1100
@@ -73,7 +73,6 @@
 
 int have_of = 1;
 int boot_cpuid = 0;
-int boot_cpuid_phys = 0;
 dev_t boot_dev;
 u64 ppc64_pft_size;
 
@@ -208,7 +207,6 @@ static struct machdep_calls __initdata *
 
 void __init early_setup(unsigned long dt_ptr)
 {
-	struct paca_struct *lpaca = get_paca();
 	static struct machdep_calls **mach;
 
 	/* Enable early debugging if any specified (see udbg.h) */
@@ -223,6 +221,14 @@ void __init early_setup(unsigned long dt
 	 */
 	early_init_devtree(__va(dt_ptr));
 
+	/* Now we know the logical id of our boot cpu, setup the paca. */
+	setup_boot_paca();
+
+	/* Fix up paca fields required for the boot cpu */
+	get_paca()->cpu_start = 1;
+	get_paca()->stab_real = __pa((u64)&initial_stab);
+	get_paca()->stab_addr = (u64)&initial_stab;
+
 	/*
 	 * Iterate all ppc_md structures until we find the proper
 	 * one for the current machine type
@@ -260,7 +266,7 @@ void __init early_setup(unsigned long dt
 		if (cpu_has_feature(CPU_FTR_SLB))
 			slb_initialize();
 		else
-			stab_initialize(lpaca->stab_real);
+			stab_initialize(get_paca()->stab_real);
 	}
 
 	DBG(" <- early_setup()\n");
Index: build/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- build.orig/arch/powerpc/platforms/pseries/xics.c	2006-03-24 15:51:18.000000000 +1100
+++ build/arch/powerpc/platforms/pseries/xics.c	2006-03-24 16:13:06.000000000 +1100
@@ -500,7 +500,7 @@ nextnode:
 	     np;
 	     np = of_find_node_by_type(np, "cpu")) {
 		ireg = (uint *)get_property(np, "reg", &ilen);
-		if (ireg && ireg[0] == boot_cpuid_phys) {
+		if (ireg && ireg[0] == get_hard_smp_processor_id(boot_cpuid)) {
 			ireg = (uint *)get_property(np, "ibm,ppc-interrupt-gserver#s",
 						    &ilen);
 			i = ilen / sizeof(int);
Index: build/include/asm-powerpc/smp.h
===================================================================
--- build.orig/include/asm-powerpc/smp.h	2006-03-24 15:31:30.000000000 +1100
+++ build/include/asm-powerpc/smp.h	2006-03-24 16:13:06.000000000 +1100
@@ -29,7 +29,6 @@
 #endif
 
 extern int boot_cpuid;
-extern int boot_cpuid_phys;
 
 extern void cpu_die(void);
 
@@ -99,6 +98,7 @@ extern void smp_release_cpus(void);
 #else
 /* 32-bit */
 #ifndef CONFIG_SMP
+extern int boot_cpuid_phys;
 #define get_hard_smp_processor_id(cpu) 	boot_cpuid_phys
 #define set_hard_smp_processor_id(cpu, phys)
 #endif
Index: build/arch/powerpc/kernel/head_64.S
===================================================================
--- build.orig/arch/powerpc/kernel/head_64.S	2006-03-24 15:51:18.000000000 +1100
+++ build/arch/powerpc/kernel/head_64.S	2006-03-24 16:13:06.000000000 +1100
@@ -1847,21 +1847,6 @@ _STATIC(start_here_multiplatform)
 	bl	.__save_cpu_setup
 	sync
 
-	/* Setup a valid physical PACA pointer in SPRG3 for early_setup
-	 * note that boot_cpuid can always be 0 nowadays since there is
-	 * nowhere it can be initialized differently before we reach this
-	 * code
-	 */
-	LOAD_REG_IMMEDIATE(r27, boot_cpuid)
-	add	r27,r27,r26
-	lwz	r27,0(r27)
-
-	LOAD_REG_IMMEDIATE(r24, paca) 	/* Get base vaddr of paca array	 */
-	mulli	r13,r27,PACA_SIZE	/* Calculate vaddr of right paca */
-	add	r13,r13,r24		/* for this processor.		 */
-	add	r13,r13,r26		/* convert to physical addr	 */
-	mtspr	SPRN_SPRG3,r13
-	
 	/* Do very early kernel initializations, including initial hash table,
 	 * stab and slb setup before we turn on relocation.	*/
 
@@ -1930,6 +1915,17 @@ _STATIC(start_here_common)
 	/* Not reached */
 	BUG_OPCODE
 
+/* Put the paca pointer into r13 and SPRG3 */
+_GLOBAL(setup_boot_paca)
+	LOAD_REG_IMMEDIATE(r3, boot_cpuid)
+	lwz	r3,0(r3)
+	LOAD_REG_IMMEDIATE(r4, paca) 	/* Get base vaddr of paca array	 */
+	mulli	r3,r3,PACA_SIZE		/* Calculate vaddr of right paca */
+	add	r13,r3,r4		/* for this processor.		 */
+	mtspr	SPRN_SPRG3,r13
+
+	blr
+
 /*
  * We put a few things here that have to be page-aligned.
  * This stuff goes at the beginning of the bss, which is page-aligned.
Index: build/arch/powerpc/kernel/prom.c
===================================================================
--- build.orig/arch/powerpc/kernel/prom.c	2006-03-24 15:51:18.000000000 +1100
+++ build/arch/powerpc/kernel/prom.c	2006-03-24 16:13:06.000000000 +1100
@@ -854,35 +854,70 @@ void __init unflatten_device_tree(void)
 	DBG(" <- unflatten_device_tree()\n");
 }
 
-
 static int __init early_init_dt_scan_cpus(unsigned long node,
-					  const char *uname, int depth, void *data)
+					  const char *uname, int depth,
+					  void *data)
 {
-	u32 *prop;
-	unsigned long size;
-	char *type = of_get_flat_dt_prop(node, "device_type", &size);
+	static int logical_cpuid = 0;
+	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
+	u32 *prop, *intserv;
+	int i, nthreads;
+	unsigned long len;
+	int found = 0;
 
 	/* We are scanning "cpu" nodes only */
 	if (type == NULL || strcmp(type, "cpu") != 0)
 		return 0;
 
-	boot_cpuid = 0;
-	boot_cpuid_phys = 0;
-	if (initial_boot_params && initial_boot_params->version >= 2) {
-		/* version 2 of the kexec param format adds the phys cpuid
-		 * of booted proc.
-		 */
-		boot_cpuid_phys = initial_boot_params->boot_cpuid_phys;
+	/* Get physical cpuid */
+	intserv = of_get_flat_dt_prop(node, "ibm,ppc-interrupt-server#s", &len);
+	if (intserv) {
+		nthreads = len / sizeof(int);
 	} else {
-		/* Check if it's the boot-cpu, set it's hw index now */
-		if (of_get_flat_dt_prop(node,
+		intserv = of_get_flat_dt_prop(node, "reg", NULL);
+		nthreads = 1;
+	}
+
+	/*
+	 * Now see if any of these threads match our boot cpu.
+	 * NOTE: This must match the parsing done in smp_setup_cpu_maps.
+	 */
+	for (i = 0; i < nthreads; i++) {
+		/*
+		 * version 2 of the kexec param format adds the phys cpuid of
+		 * booted proc.
+		 */
+		if (initial_boot_params && initial_boot_params->version >= 2) {
+			if (intserv[i] ==
+					initial_boot_params->boot_cpuid_phys) {
+				found = 1;
+				break;
+			}
+		} else {
+			/*
+			 * Check if it's the boot-cpu, set it's hw index now,
+			 * unfortunately this format did not support booting
+			 * off secondary threads.
+			 */
+			if (of_get_flat_dt_prop(node,
 					"linux,boot-cpu", NULL) != NULL) {
-			prop = of_get_flat_dt_prop(node, "reg", NULL);
-			if (prop != NULL)
-				boot_cpuid_phys = *prop;
+				found = 1;
+				break;
+			}
 		}
+
+#ifdef CONFIG_SMP
+		/* logical cpu id is always 0 on UP kernels */
+		logical_cpuid++;
+#endif
+	}
+
+	if (found) {
+		DBG("boot cpu: logical %d physical %d\n", logical_cpuid,
+			intserv[i]);
+		boot_cpuid = logical_cpuid;
+		set_hard_smp_processor_id(boot_cpuid, intserv[i]);
 	}
-	set_hard_smp_processor_id(0, boot_cpuid_phys);
 
 #ifdef CONFIG_ALTIVEC
 	/* Check if we have a VMX and eventually update CPU features */
@@ -901,16 +936,10 @@ static int __init early_init_dt_scan_cpu
 #endif /* CONFIG_ALTIVEC */
 
 #ifdef CONFIG_PPC_PSERIES
-	/*
-	 * Check for an SMT capable CPU and set the CPU feature. We do
-	 * this by looking at the size of the ibm,ppc-interrupt-server#s
-	 * property
-	 */
-	prop = (u32 *)of_get_flat_dt_prop(node, "ibm,ppc-interrupt-server#s",
-				       &size);
-	cur_cpu_spec->cpu_features &= ~CPU_FTR_SMT;
-	if (prop && ((size / sizeof(u32)) > 1))
+	if (nthreads > 1)
 		cur_cpu_spec->cpu_features |= CPU_FTR_SMT;
+	else
+		cur_cpu_spec->cpu_features &= ~CPU_FTR_SMT;
 #endif
 
 	return 0;
Index: build/arch/powerpc/kernel/paca.c
===================================================================
--- build.orig/arch/powerpc/kernel/paca.c	2006-03-24 15:31:30.000000000 +1100
+++ build/arch/powerpc/kernel/paca.c	2006-03-24 16:13:06.000000000 +1100
@@ -56,14 +56,11 @@ struct lppaca lppaca[] = {
  * processors.  The processor VPD array needs one entry per physical
  * processor (not thread).
  */
-#define PACA_INIT_COMMON(number, start, asrr, asrv)			    \
+#define PACA_INIT_COMMON(number)					    \
 	.lppaca_ptr = &lppaca[number],					    \
 	.lock_token = 0x8000,						    \
 	.paca_index = (number),		/* Paca Index */		    \
 	.kernel_toc = (unsigned long)(&__toc_start) + 0x8000UL,		    \
-	.stab_real = (asrr), 		/* Real pointer to segment table */ \
-	.stab_addr = (asrv),		/* Virt pointer to segment table */ \
-	.cpu_start = (start),		/* Processor start */		    \
 	.hw_cpu_id = 0xffff,
 
 #ifdef CONFIG_PPC_ISERIES
@@ -72,30 +69,20 @@ struct lppaca lppaca[] = {
 
 #define PACA_INIT(number)						    \
 {									    \
-	PACA_INIT_COMMON(number, 0, 0, 0)				    \
-	PACA_INIT_ISERIES(number)					    \
-}
-
-#define BOOTCPU_PACA_INIT(number)					    \
-{									    \
-	PACA_INIT_COMMON(number, 1, 0, (u64)&initial_stab)		    \
+	PACA_INIT_COMMON(number)					    \
 	PACA_INIT_ISERIES(number)					    \
 }
 
 #else
 #define PACA_INIT(number)						    \
 {									    \
-	PACA_INIT_COMMON(number, 0, 0, 0)				    \
+	PACA_INIT_COMMON(number)					    \
 }
 
-#define BOOTCPU_PACA_INIT(number)					    \
-{									    \
-	PACA_INIT_COMMON(number, 1, STAB0_PHYS_ADDR, (u64)&initial_stab)    \
-}
 #endif
 
 struct paca_struct paca[] = {
-	BOOTCPU_PACA_INIT(0),
+	PACA_INIT(0),
 #if NR_CPUS > 1
 	PACA_INIT(  1), PACA_INIT(  2), PACA_INIT(  3),
 #if NR_CPUS > 4
Index: build/include/asm-powerpc/paca.h
===================================================================
--- build.orig/include/asm-powerpc/paca.h	2006-03-24 15:51:22.000000000 +1100
+++ build/include/asm-powerpc/paca.h	2006-03-24 16:13:06.000000000 +1100
@@ -105,5 +105,7 @@ struct paca_struct {
 
 extern struct paca_struct paca[];
 
+void setup_boot_paca(void);
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_PACA_H */
