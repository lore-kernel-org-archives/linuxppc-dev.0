Return-Path: <B40534@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F07F72C02B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 19:22:05 +1000 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <benh@kernel.crashing.org>, <scottwood@freescale.com>,
 <galak@kernel.crashing.org>
Subject: [RFC 1/2] fsl/pm: combined the idle(PH&PW) state
Date: Wed, 10 Jul 2013 16:31:50 +0800
Message-ID: <1373445111-7866-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, chenhui.zhao@freescale.com,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

move wait instructions from idle_e500.S to idle_book3e.S

idle_e500.S: rename e500_idle to e500_idle_ph.
idle_book3e.S: rename BOOK3E to E500, this file not only use 64bit
mode.

Next we will modify the current cpu idle running way, and will use
cpuidle framework. Distinguish between PH mode and WAIT mode is to
prepare for subsequent development.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 92386fc..5688c39 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -262,11 +262,11 @@ struct machdep_calls {
 #endif
 };
 
-extern void e500_idle(void);
+extern void e500_idle_ph(void);
 extern void power4_idle(void);
 extern void power7_idle(void);
 extern void ppc6xx_idle(void);
-extern void book3e_idle(void);
+extern void e500_idle_wait(void);
 
 /*
  * ppc_md contains a copy of the machine description structure for the
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index f960a79..047c7e3 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -28,7 +28,7 @@ endif
 
 obj-y				:= cputable.o ptrace.o syscalls.o \
 				   irq.o align.o signal_32.o pmc.o vdso.o \
-				   process.o systbl.o idle.o \
+				   process.o systbl.o idle.o idle_book3e.o \
 				   signal.o sysfs.o cacheinfo.o time.o \
 				   prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o dma.o \
@@ -40,7 +40,7 @@ obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
 obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
-obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
+obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o
 obj-$(CONFIG_PPC_A2)		+= cpu_setup_a2.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o
diff --git a/arch/powerpc/kernel/idle_book3e.S b/arch/powerpc/kernel/idle_book3e.S
index bfb73cc..229f86b 100644
--- a/arch/powerpc/kernel/idle_book3e.S
+++ b/arch/powerpc/kernel/idle_book3e.S
@@ -1,7 +1,7 @@
 /*
  * Copyright 2010 IBM Corp, Benjamin Herrenschmidt <benh@kernel.crashing.org>
  *
- * Generic idle routine for Book3E processors
+ * Generic idle(wait) routine for e500mc, e5500, e6500 processors
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -18,11 +18,9 @@
 #include <asm/thread_info.h>
 #include <asm/epapr_hcalls.h>
 
-/* 64-bit version only for now */
-#ifdef CONFIG_PPC64
-
-.macro BOOK3E_IDLE name loop
+.macro E500_IDLE_WAIT name loop
 _GLOBAL(\name)
+#ifdef CONFIG_PPC64
 	/* Save LR for later */
 	mflr	r0
 	std	r0,16(r1)
@@ -66,6 +64,12 @@ _GLOBAL(\name)
 	ld	r10,TI_LOCAL_FLAGS(r11)
 	ori	r10,r10,_TLF_NAPPING
 	std	r10,TI_LOCAL_FLAGS(r11)
+#else
+	CURRENT_THREAD_INFO(r11, r1)
+	lwz	r4,TI_LOCAL_FLAGS(r11)	/* set napping bit */
+	ori	r4,r4,_TLF_NAPPING	/* so when we take an exception */
+	stw	r4,TI_LOCAL_FLAGS(r11)	/* it will return to our caller */
+#endif
 
 	/* We can now re-enable hard interrupts and go to sleep */
 	wrteei	1
@@ -73,7 +77,7 @@ _GLOBAL(\name)
 
 .endm
 
-.macro BOOK3E_IDLE_LOOP
+.macro E500_IDLE_LOOP
 1:
 	PPC_WAIT(0)
 	b	1b
@@ -94,8 +98,8 @@ epapr_ev_idle_start:
 	b       idle_loop
 .endm
 
-BOOK3E_IDLE epapr_ev_idle EPAPR_EV_IDLE_LOOP
-
-BOOK3E_IDLE book3e_idle BOOK3E_IDLE_LOOP
+#ifdef CONFIG_PPC64
+E500_IDLE_WAIT epapr_ev_idle EPAPR_EV_IDLE_LOOP
+#endif
 
-#endif /* CONFIG_PPC64 */
+E500_IDLE_WAIT e500_idle_wait E500_IDLE_LOOP
diff --git a/arch/powerpc/kernel/idle_e500.S b/arch/powerpc/kernel/idle_e500.S
index 1544866..8b9ccaa 100644
--- a/arch/powerpc/kernel/idle_e500.S
+++ b/arch/powerpc/kernel/idle_e500.S
@@ -20,23 +20,12 @@
 
 	.text
 
-_GLOBAL(e500_idle)
+_GLOBAL(e500_idle_ph)
 	CURRENT_THREAD_INFO(r3, r1)
 	lwz	r4,TI_LOCAL_FLAGS(r3)	/* set napping bit */
 	ori	r4,r4,_TLF_NAPPING	/* so when we take an exception */
 	stw	r4,TI_LOCAL_FLAGS(r3)	/* it will return to our caller */
 
-#ifdef CONFIG_PPC_E500MC
-	wrteei	1
-1:	wait
-
-	/*
-	 * Guard against spurious wakeups (e.g. from a hypervisor) --
-	 * any real interrupt will cause us to return to LR due to
-	 * _TLF_NAPPING.
-	 */
-	b	1b
-#else
 	/* Check if we can nap or doze, put HID0 mask in r3 */
 	lis	r3,0
 BEGIN_FTR_SECTION
@@ -83,7 +72,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_L2CSR|CPU_FTR_CAN_NAP)
 	mtmsr	r7
 	isync
 2:	b	2b
-#endif /* !E500MC */
 
 /*
  * Return from NAP/DOZE mode, restore some CPU specific registers,
@@ -92,7 +80,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_L2CSR|CPU_FTR_CAN_NAP)
  * We have to preserve r10.
  */
 _GLOBAL(power_save_ppc32_restore)
-	lwz	r9,_LINK(r11)		/* interrupted in e500_idle */
+	lwz	r9,_LINK(r11)		/* interrupted in e500_idle_ph */
 	stw	r9,_NIP(r11)		/* make it do a blr */
 
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index a8f54ec..27c260f 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -143,7 +143,7 @@ notrace void __init machine_init(u64 dt_ptr)
 #ifdef CONFIG_E500
 	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
 	    cpu_has_feature(CPU_FTR_CAN_NAP))
-		ppc_md.power_save = e500_idle;
+		ppc_md.power_save = e500_idle_ph;
 #endif
 	if (ppc_md.progress)
 		ppc_md.progress("id mach(): done", 0x200);
diff --git a/arch/powerpc/platforms/85xx/b4_qds.c b/arch/powerpc/platforms/85xx/b4_qds.c
index 0c6702f..057a763 100644
--- a/arch/powerpc/platforms/85xx/b4_qds.c
+++ b/arch/powerpc/platforms/85xx/b4_qds.c
@@ -88,11 +88,7 @@ define_machine(b4_qds) {
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
-#ifdef CONFIG_PPC64
-	.power_save		= book3e_idle,
-#else
-	.power_save		= e500_idle,
-#endif
+	.power_save		= e500_idle_wait,
 };
 
 machine_arch_initcall(b4_qds, corenet_ds_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/p2041_rdb.c b/arch/powerpc/platforms/85xx/p2041_rdb.c
index 000c089..28202d3 100644
--- a/arch/powerpc/platforms/85xx/p2041_rdb.c
+++ b/arch/powerpc/platforms/85xx/p2041_rdb.c
@@ -77,7 +77,7 @@ define_machine(p2041_rdb) {
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
-	.power_save		= e500_idle,
+	.power_save		= e500_idle_wait,
 };
 
 machine_arch_initcall(p2041_rdb, corenet_ds_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/p3041_ds.c b/arch/powerpc/platforms/85xx/p3041_ds.c
index b3edc20..83acd8f 100644
--- a/arch/powerpc/platforms/85xx/p3041_ds.c
+++ b/arch/powerpc/platforms/85xx/p3041_ds.c
@@ -79,7 +79,7 @@ define_machine(p3041_ds) {
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
-	.power_save		= e500_idle,
+	.power_save		= e500_idle_wait,
 };
 
 machine_arch_initcall(p3041_ds, corenet_ds_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/p4080_ds.c b/arch/powerpc/platforms/85xx/p4080_ds.c
index 54df106..e3a4467 100644
--- a/arch/powerpc/platforms/85xx/p4080_ds.c
+++ b/arch/powerpc/platforms/85xx/p4080_ds.c
@@ -78,7 +78,7 @@ define_machine(p4080_ds) {
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
-	.power_save		= e500_idle,
+	.power_save		= e500_idle_wait,
 };
 
 machine_arch_initcall(p4080_ds, corenet_ds_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/p5020_ds.c b/arch/powerpc/platforms/85xx/p5020_ds.c
index 753a42c..e93e773 100644
--- a/arch/powerpc/platforms/85xx/p5020_ds.c
+++ b/arch/powerpc/platforms/85xx/p5020_ds.c
@@ -84,11 +84,7 @@ define_machine(p5020_ds) {
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
-#ifdef CONFIG_PPC64
-	.power_save		= book3e_idle,
-#else
-	.power_save		= e500_idle,
-#endif
+	.power_save		= e500_idle_wait,
 };
 
 machine_arch_initcall(p5020_ds, corenet_ds_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/p5040_ds.c b/arch/powerpc/platforms/85xx/p5040_ds.c
index 1138185..d9a1a16 100644
--- a/arch/powerpc/platforms/85xx/p5040_ds.c
+++ b/arch/powerpc/platforms/85xx/p5040_ds.c
@@ -75,11 +75,7 @@ define_machine(p5040_ds) {
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
-#ifdef CONFIG_PPC64
-	.power_save		= book3e_idle,
-#else
-	.power_save		= e500_idle,
-#endif
+	.power_save		= e500_idle_wait,
 };
 
 machine_arch_initcall(p5040_ds, corenet_ds_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/t4240_qds.c b/arch/powerpc/platforms/85xx/t4240_qds.c
index 5998e9f..b4c6420 100644
--- a/arch/powerpc/platforms/85xx/t4240_qds.c
+++ b/arch/powerpc/platforms/85xx/t4240_qds.c
@@ -84,11 +84,7 @@ define_machine(t4240_qds) {
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
-#ifdef CONFIG_PPC64
-	.power_save		= book3e_idle,
-#else
-	.power_save		= e500_idle,
-#endif
+	.power_save		= e500_idle_wait,
 };
 
 machine_arch_initcall(t4240_qds, corenet_ds_publish_devices);
diff --git a/arch/powerpc/platforms/wsp/chroma.c b/arch/powerpc/platforms/wsp/chroma.c
index 8ef53bc..203caa1 100644
--- a/arch/powerpc/platforms/wsp/chroma.c
+++ b/arch/powerpc/platforms/wsp/chroma.c
@@ -49,7 +49,7 @@ define_machine(chroma_md) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.init_IRQ		= wsp_setup_irq,
 	.progress		= udbg_progress,
-	.power_save		= book3e_idle,
+	.power_save		= e500_idle_wait,
 };
 
 machine_arch_initcall(chroma_md, wsp_probe_devices);
diff --git a/arch/powerpc/platforms/wsp/psr2.c b/arch/powerpc/platforms/wsp/psr2.c
index 508ec82..86b8662 100644
--- a/arch/powerpc/platforms/wsp/psr2.c
+++ b/arch/powerpc/platforms/wsp/psr2.c
@@ -60,7 +60,7 @@ define_machine(psr2_md) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.init_IRQ		= wsp_setup_irq,
 	.progress		= udbg_progress,
-	.power_save		= book3e_idle,
+	.power_save		= e500_idle_wait,
 };
 
 machine_arch_initcall(psr2_md, wsp_probe_devices);
-- 
1.8.0
