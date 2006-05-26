Return-Path: <ntl@pobox.com>
Received: from gretel.pobox.com (gretel.pobox.com [208.58.1.197])
	by ozlabs.org (Postfix) with ESMTP id 4E48867A77
	for <linuxppc-dev@ozlabs.org>; Sat, 27 May 2006 00:15:59 +1000 (EST)
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by gretel.pobox.com (Postfix) with ESMTP id 3CC612AC909E
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 10:03:05 -0400 (EDT)
Date: Fri, 26 May 2006 09:02:27 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC/PATCH] powersave_nap cleanup
Message-ID: <20060526140227.GE8934@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[ Please consider for 2.6.18. ]

Instead of having the machdep_calls.power_save routines (such as
ppc6xx_idle and power4_idle) individually check the value of the
powersave_nap sysctl variable, we can have the newly-consolidated idle
loop check the value of powersave_nap when deciding whether to call
machdep_calls.power_save.  In this way, a platform can implement a
machdep_calls.power_save method but still have threads go low-priority
when idle if the user has set powersave_nap to 0.

Rename machdep_calls.power_save to machdep_calls.powersave_nap to make
more apparent the connection with the powersave_nap sysctl.

Add some documentation to machdep_calls.powersave_nap to more
completely describe its intended use.

Change cpu_idle to call ppc_md.powersave_nap only when the
powersave_nap sysctl is set.

Remove tests of the powersave_nap variable from the ppc6xx_idle and
power4_idle routines.

Set powersave_nap to 1 by default on pSeries when the shared processor
firmware feature is present, preserving current behavior.

Remove a superfluous declaration of powersave_nap from
platforms/powermac/feature.c.


Signed-off-by: Nathan Lynch <ntl@pobox.com>


diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index d491052..09bd0cf 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -53,7 +53,7 @@ void cpu_idle(void)
 		while (!need_resched() && !cpu_should_die()) {
 			ppc64_runlatch_off();
 
-			if (ppc_md.power_save) {
+			if (ppc_md.powersave_nap && powersave_nap) {
 				clear_thread_flag(TIF_POLLING_NRFLAG);
 				/*
 				 * smp_mb is so clearing of TIF_POLLING_NRFLAG
@@ -64,7 +64,7 @@ void cpu_idle(void)
 
 				/* check again after disabling irqs */
 				if (!need_resched() && !cpu_should_die())
-					ppc_md.power_save();
+					ppc_md.powersave_nap();
 
 				local_irq_enable();
 				set_thread_flag(TIF_POLLING_NRFLAG);
diff --git a/arch/powerpc/kernel/idle_6xx.S b/arch/powerpc/kernel/idle_6xx.S
index b45fa0e..c685a8d 100644
--- a/arch/powerpc/kernel/idle_6xx.S
+++ b/arch/powerpc/kernel/idle_6xx.S
@@ -1,5 +1,5 @@
 /*
- *  This file contains the power_save function for 6xx & 7xxx CPUs
+ *  This file contains the powersave_nap function for 6xx & 7xxx CPUs
  *  rewritten in assembler
  *
  *  Warning ! This code assumes that if your machine has a 750fx
@@ -74,11 +74,6 @@ BEGIN_FTR_SECTION
 	lwz	r4,CPU_SPEC_FEATURES(r4)
 	andi.	r0,r4,CPU_FTR_CAN_NAP
 	beq	1f
-	/* Now check if user or arch enabled NAP mode */
-	lis	r4,powersave_nap@ha
-	lwz	r4,powersave_nap@l(r4)
-	cmpwi	0,r4,0
-	beq	1f
 	lis	r3,HID0_NAP@h
 1:	
 END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index d85c7c9..14e3c18 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -1,5 +1,5 @@
 /*
- *  This file contains the power_save function for 970-family CPUs.
+ *  This file contains the powersave_nap function for 970-family CPUs.
  *
  *  This program is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU General Public License
@@ -24,12 +24,6 @@ _GLOBAL(power4_idle)
 BEGIN_FTR_SECTION
 	blr
 END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
-	/* Now check if user or arch enabled NAP mode */
-	LOAD_REG_ADDRBASE(r3,powersave_nap)
-	lwz	r4,ADDROFF(powersave_nap)(r3)
-	cmpwi	0,r4,0
-	beqlr
-
 	/* Go to NAP now */
 BEGIN_FTR_SECTION
 	DSSALL
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 69ac257..57af9c4 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -142,7 +142,7 @@ void __init machine_init(unsigned long d
 #ifdef CONFIG_6xx
 	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
 	    cpu_has_feature(CPU_FTR_CAN_NAP))
-		ppc_md.power_save = ppc6xx_idle;
+		ppc_md.powersave_nap = ppc6xx_idle;
 #endif
 
 	if (ppc_md.progress)
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 24c0aef..eaa4c65 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -292,7 +292,7 @@ define_machine(maple_md) {
        	.get_rtc_time		= maple_get_rtc_time,
       	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= maple_progress,
-	.power_save		= power4_idle,
+	.powersave_nap		= power4_idle,
 #ifdef CONFIG_KEXEC
 	.machine_kexec		= default_machine_kexec,
 	.machine_kexec_prepare	= default_machine_kexec_prepare,
diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index a5063cd..b9a45df 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -53,7 +53,6 @@
 extern int powersave_lowspeed;
 #endif
 
-extern int powersave_nap;
 extern struct device_node *k2_skiplist[2];
 
 /*
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 4d15e39..66e6a21 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -740,7 +740,7 @@ define_machine(powermac) {
 	.progress		= udbg_progress,
 #ifdef CONFIG_PPC64
 	.pci_probe_mode		= pmac_pci_probe_mode,
-	.power_save		= power4_idle,
+	.powersave_nap		= power4_idle,
 	.enable_pmcs		= power4_enable_pmcs,
 #ifdef CONFIG_KEXEC
 	.machine_kexec		= default_machine_kexec,
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 5f79f01..d094e9d 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -236,11 +236,13 @@ static void __init pSeries_setup_arch(vo
 		vpa_init(boot_cpuid);
 		if (get_lppaca()->shared_proc) {
 			printk(KERN_INFO "Using shared processor idle loop\n");
-			ppc_md.power_save = pseries_shared_idle_sleep;
+			ppc_md.powersave_nap = pseries_shared_idle_sleep;
 		} else {
 			printk(KERN_INFO "Using dedicated idle loop\n");
-			ppc_md.power_save = pseries_dedicated_idle_sleep;
+			ppc_md.powersave_nap = pseries_dedicated_idle_sleep;
 		}
+		/* We want this on by default. */
+		powersave_nap = 1;
 	} else {
 		printk(KERN_INFO "Using default idle loop\n");
 	}
diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
index 0f9254c..721fbe2 100644
--- a/include/asm-powerpc/machdep.h
+++ b/include/asm-powerpc/machdep.h
@@ -160,10 +160,11 @@ struct machdep_calls {
 	void		(*idle_loop)(void);
 
 	/*
-	 * Function for waiting for work with reduced power in idle loop;
-	 * called with interrupts disabled.
+	 * Function for waiting for work with reduced power and/or cpu
+	 * utilization in idle loop; called with interrupts disabled.
+	 * Can be overriden by the powersave_nap sysctl.
 	 */
-	void		(*power_save)(void);
+	void		(*powersave_nap)(void);
 
 	/* Function to enable performance monitor counters for this
 	   platform, called once per cpu. */
