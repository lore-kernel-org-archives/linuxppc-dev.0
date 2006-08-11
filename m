Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7343D67B69
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 15:09:41 +1000 (EST)
Date: Fri, 11 Aug 2006 00:07:08 -0500
To: paulus@samba.org
Subject: [PATCH 2/2]: powerpc: Cleanup CPU inits
Message-ID: <20060811050708.GC5879@pb15.lixom.net>
References: <20060811050159.GA5879@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060811050159.GA5879@pb15.lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Cleanup CPU inits a bit more, Geoff Levand already did some earlier.

* Move CPU state save to cpu_setup, since cpu_setup is only ever done
  on cpu 0 on 64-bit and save is never done more than once.
* Rename __restore_cpu_setup to __restore_cpu_ppc970 and add
  function pointers to the cputable to use instead. Powermac always
  has 970 so no need to check there.
* Rename __970_cpu_preinit to __cpu_preinit_ppc970 and check PVR before
  calling it instead of in it, it's too early to use cputable.
* Rename pSeries_secondary_smp_init to generic_secondary_smp_init since
  everyone but powermac and iSeries use it.


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: linux-2.6/arch/powerpc/kernel/cpu_setup_ppc970.S
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/cpu_setup_ppc970.S
+++ linux-2.6/arch/powerpc/kernel/cpu_setup_ppc970.S
@@ -16,27 +16,12 @@
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 
-_GLOBAL(__970_cpu_preinit)
-	/*
-	 * Do nothing if not running in HV mode
-	 */
+_GLOBAL(__cpu_preinit_ppc970)
+	/* Do nothing if not running in HV mode */
 	mfmsr	r0
 	rldicl.	r0,r0,4,63
 	beqlr
 
-	/*
-	 * Deal only with PPC970 and PPC970FX.
-	 */
-	mfspr	r0,SPRN_PVR
-	srwi	r0,r0,16
-	cmpwi	r0,0x39
-	beq	1f
-	cmpwi	r0,0x3c
-	beq	1f
-	cmpwi	r0,0x44
-	bnelr
-1:
-
 	/* Make sure HID4:rm_ci is off before MMU is turned off, that large
 	 * pages are enabled with HID4:61 and clear HID5:DCBZ_size and
 	 * HID5:DCBZ32_ill
@@ -72,21 +57,6 @@ _GLOBAL(__970_cpu_preinit)
 	isync
 	blr
 
-_GLOBAL(__setup_cpu_ppc970)
-	mfspr	r0,SPRN_HID0
-	li	r11,5			/* clear DOZE and SLEEP */
-	rldimi	r0,r11,52,8		/* set NAP and DPM */
-	mtspr	SPRN_HID0,r0
-	mfspr	r0,SPRN_HID0
-	mfspr	r0,SPRN_HID0
-	mfspr	r0,SPRN_HID0
-	mfspr	r0,SPRN_HID0
-	mfspr	r0,SPRN_HID0
-	mfspr	r0,SPRN_HID0
-	sync
-	isync
-	blr
-
 /* Definitions for the table use to save CPU states */
 #define CS_HID0		0
 #define CS_HID1		8
@@ -101,33 +71,28 @@ cpu_state_storage:
 	.balign	L1_CACHE_BYTES,0
 	.text
 
-/* Called in normal context to backup CPU 0 state. This
- * does not include cache settings. This function is also
- * called for machine sleep. This does not include the MMU
- * setup, BATs, etc... but rather the "special" registers
- * like HID0, HID1, HID4, etc...
- */
-_GLOBAL(__save_cpu_setup)
-	/* Some CR fields are volatile, we back it up all */
-	mfcr	r7
-
-	/* Get storage ptr */
-	LOAD_REG_IMMEDIATE(r5,cpu_state_storage)
-
-	/* We only deal with 970 for now */
-	mfspr	r0,SPRN_PVR
-	srwi	r0,r0,16
-	cmpwi	r0,0x39
-	beq	1f
-	cmpwi	r0,0x3c
-	beq	1f
-	cmpwi	r0,0x44
-	bne	2f
 
-1:	/* skip if not running in HV mode */
+_GLOBAL(__setup_cpu_ppc970)
+	/* Do nothing if not running in HV mode */
 	mfmsr	r0
 	rldicl.	r0,r0,4,63
-	beq	2f
+	beqlr
+
+	mfspr	r0,SPRN_HID0
+	li	r11,5			/* clear DOZE and SLEEP */
+	rldimi	r0,r11,52,8		/* set NAP and DPM */
+	mtspr	SPRN_HID0,r0
+	mfspr	r0,SPRN_HID0
+	mfspr	r0,SPRN_HID0
+	mfspr	r0,SPRN_HID0
+	mfspr	r0,SPRN_HID0
+	mfspr	r0,SPRN_HID0
+	mfspr	r0,SPRN_HID0
+	sync
+	isync
+
+	/* Save away cpu state */
+	LOAD_REG_IMMEDIATE(r5,cpu_state_storage)
 
 	/* Save HID0,1,4 and 5 */
 	mfspr	r3,SPRN_HID0
@@ -139,35 +104,19 @@ _GLOBAL(__save_cpu_setup)
 	mfspr	r3,SPRN_HID5
 	std	r3,CS_HID5(r5)
 
-2:
-	mtcr	r7
 	blr
 
 /* Called with no MMU context (typically MSR:IR/DR off) to
  * restore CPU state as backed up by the previous
  * function. This does not include cache setting
  */
-_GLOBAL(__restore_cpu_setup)
-	/* Get storage ptr (FIXME when using anton reloc as we
-	 * are running with translation disabled here
-	 */
-	LOAD_REG_IMMEDIATE(r5,cpu_state_storage)
-
-	/* We only deal with 970 for now */
-	mfspr	r0,SPRN_PVR
-	srwi	r0,r0,16
-	cmpwi	r0,0x39
-	beq	1f
-	cmpwi	r0,0x3c
-	beq	1f
-	cmpwi	r0,0x44
-	bnelr
-
-1:	/* skip if not running in HV mode */
+_GLOBAL(__restore_cpu_ppc970)
+	/* Do nothing if not running in HV mode */
 	mfmsr	r0
 	rldicl.	r0,r0,4,63
 	beqlr
 
+	LOAD_REG_IMMEDIATE(r5,cpu_state_storage)
 	/* Before accessing memory, we make sure rm_ci is clear */
 	li	r0,0
 	mfspr	r3,SPRN_HID4
Index: linux-2.6/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/head_64.S
+++ linux-2.6/arch/powerpc/kernel/head_64.S
@@ -132,7 +132,7 @@ _GLOBAL(__secondary_hold)
 	bne	100b
 
 #if defined(CONFIG_SMP) || defined(CONFIG_KEXEC)
-	LOAD_REG_IMMEDIATE(r4, .pSeries_secondary_smp_init)
+	LOAD_REG_IMMEDIATE(r4, .generic_secondary_smp_init)
 	mtctr	r4
 	mr	r3,r24
 	bctr
@@ -1484,19 +1484,17 @@ fwnmi_data_area:
         . = 0x8000
 
 /*
- * On pSeries, secondary processors spin in the following code.
+ * On pSeries and most other platforms, secondary processors spin
+ * in the following code.
  * At entry, r3 = this processor's number (physical cpu id)
  */
-_GLOBAL(pSeries_secondary_smp_init)
+_GLOBAL(generic_secondary_smp_init)
 	mr	r24,r3
 	
 	/* turn on 64-bit mode */
 	bl	.enable_64b_mode
 	isync
 
-	/* Copy some CPU settings from CPU 0 */
-	bl	.__restore_cpu_setup
-
 	/* Set up a paca value for this processor. Since we have the
 	 * physical cpu id in r24, we need to search the pacas to find
 	 * which logical id maps to our physical one.
@@ -1522,15 +1520,28 @@ _GLOBAL(pSeries_secondary_smp_init)
 					/* start.			 */
 	sync
 
-	/* Create a temp kernel stack for use before relocation is on.	*/
+#ifndef CONFIG_SMP
+	b	3b			/* Never go on non-SMP		 */
+#else
+	cmpwi	0,r23,0
+	beq	3b			/* Loop until told to go	 */
+
+	/* See if we need to call a cpu state restore handler */
+	LOAD_REG_IMMEDIATE(r23, cur_cpu_spec)
+	ld	r23,0(r23)
+	ld	r23,CPU_SPEC_RESTORE(r23)
+	cmpdi	0,r23,0
+	beq	4f
+	ld	r23,0(r23)
+	mtctr	r23
+	bctrl
+
+4:	/* Create a temp kernel stack for use before relocation is on.	*/
 	ld	r1,PACAEMERGSP(r13)
 	subi	r1,r1,STACK_FRAME_OVERHEAD
 
-	cmpwi	0,r23,0
-#ifdef CONFIG_SMP
-	bne	.__secondary_start
+	b	.__secondary_start
 #endif
-	b 	3b			/* Loop until told to go	 */
 
 #ifdef CONFIG_PPC_ISERIES
 _STATIC(__start_initialization_iSeries)
@@ -1611,7 +1622,16 @@ _GLOBAL(__start_initialization_multiplat
 	bl	.enable_64b_mode
 
 	/* Setup some critical 970 SPRs before switching MMU off */
-	bl	.__970_cpu_preinit
+	mfspr	r0,SPRN_PVR
+	srwi	r0,r0,16
+	cmpwi	r0,0x39		/* 970 */
+	beq	1f
+	cmpwi	r0,0x3c		/* 970FX */
+	beq	1f
+	cmpwi	r0,0x44		/* 970MP */
+	bne	2f
+1:	bl	.__cpu_preinit_ppc970
+2:
 
 	/* Switch off MMU if not already */
 	LOAD_REG_IMMEDIATE(r4, .__after_prom_start - KERNELBASE)
@@ -1782,7 +1802,7 @@ _GLOBAL(pmac_secondary_start)
 	isync
 
 	/* Copy some CPU settings from CPU 0 */
-	bl	.__restore_cpu_setup
+	bl	.__restore_cpu_ppc970
 
 	/* pSeries do that early though I don't think we really need it */
 	mfmsr	r3
@@ -1932,12 +1952,6 @@ _STATIC(start_here_multiplatform)
 	mr	r5,r26
 	bl	.identify_cpu
 
-	/* Save some low level config HIDs of CPU0 to be copied to
-	 * other CPUs later on, or used for suspend/resume
-	 */
-	bl	.__save_cpu_setup
-	sync
-
 	/* Do very early kernel initializations, including initial hash table,
 	 * stab and slb setup before we turn on relocation.	*/
 
Index: linux-2.6/arch/powerpc/platforms/cell/smp.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/smp.c
+++ linux-2.6/arch/powerpc/platforms/cell/smp.c
@@ -57,7 +57,7 @@
  */
 static cpumask_t of_spin_map;
 
-extern void pSeries_secondary_smp_init(unsigned long);
+extern void generic_secondary_smp_init(unsigned long);
 
 /**
  * smp_startup_cpu() - start the given cpu
@@ -74,7 +74,7 @@ static inline int __devinit smp_startup_
 {
 	int status;
 	unsigned long start_here = __pa((u32)*((unsigned long *)
-					       pSeries_secondary_smp_init));
+					       generic_secondary_smp_init));
 	unsigned int pcpu;
 	int start_cpu;
 
Index: linux-2.6/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/smp.c
+++ linux-2.6/arch/powerpc/platforms/pseries/smp.c
@@ -62,7 +62,7 @@
  */
 static cpumask_t of_spin_map;
 
-extern void pSeries_secondary_smp_init(unsigned long);
+extern void generic_secondary_smp_init(unsigned long);
 
 #ifdef CONFIG_HOTPLUG_CPU
 
@@ -270,7 +270,7 @@ static inline int __devinit smp_startup_
 {
 	int status;
 	unsigned long start_here = __pa((u32)*((unsigned long *)
-					       pSeries_secondary_smp_init));
+					       generic_secondary_smp_init));
 	unsigned int pcpu;
 	int start_cpu;
 
Index: linux-2.6/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/asm-offsets.c
+++ linux-2.6/arch/powerpc/kernel/asm-offsets.c
@@ -241,6 +241,7 @@ int main(void)
 	DEFINE(CPU_SPEC_PVR_VALUE, offsetof(struct cpu_spec, pvr_value));
 	DEFINE(CPU_SPEC_FEATURES, offsetof(struct cpu_spec, cpu_features));
 	DEFINE(CPU_SPEC_SETUP, offsetof(struct cpu_spec, cpu_setup));
+	DEFINE(CPU_SPEC_RESTORE, offsetof(struct cpu_spec, cpu_restore));
 
 #ifndef CONFIG_PPC64
 	DEFINE(pbe_address, offsetof(struct pbe, address));
Index: linux-2.6/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/cputable.c
+++ linux-2.6/arch/powerpc/kernel/cputable.c
@@ -39,7 +39,10 @@ extern void __setup_cpu_7400(unsigned lo
 extern void __setup_cpu_7410(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_745x(unsigned long offset, struct cpu_spec* spec);
 #endif /* CONFIG_PPC32 */
+#ifdef CONFIG_PPC64
 extern void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec* spec);
+extern void __restore_cpu_ppc970(void);
+#endif /* CONFIG_PPC64 */
 
 /* This table only contains "desktop" CPUs, it need to be filled with embedded
  * ones as well...
@@ -184,6 +187,7 @@ struct cpu_spec	cpu_specs[] = {
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
 		.cpu_setup		= __setup_cpu_ppc970,
+		.cpu_restore		= __restore_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "ppc970",
@@ -199,6 +203,7 @@ struct cpu_spec	cpu_specs[] = {
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
 		.cpu_setup		= __setup_cpu_ppc970,
+		.cpu_restore		= __restore_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "ppc970",
@@ -214,6 +219,7 @@ struct cpu_spec	cpu_specs[] = {
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
 		.cpu_setup		= __setup_cpu_ppc970,
+		.cpu_restore		= __restore_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "ppc970",
Index: linux-2.6/include/asm-powerpc/cputable.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/cputable.h
+++ linux-2.6/include/asm-powerpc/cputable.h
@@ -36,6 +36,7 @@
 struct cpu_spec;
 
 typedef	void (*cpu_setup_t)(unsigned long offset, struct cpu_spec* spec);
+typedef	void (*cpu_restore_t)(void);
 
 enum powerpc_oprofile_type {
 	PPC_OPROFILE_INVALID = 0,
@@ -65,6 +66,8 @@ struct cpu_spec {
 	 * BHT, SPD, etc... from head.S before branching to identify_machine
 	 */
 	cpu_setup_t	cpu_setup;
+	/* Used to restore cpu setup on secondary processors and at resume */
+	cpu_restore_t	cpu_restore;
 
 	/* Used by oprofile userspace to select the right counters */
 	char		*oprofile_cpu_type;
