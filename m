Return-Path: <tnt@246tNt.com>
Received: from outmx002.isp.belgacom.be (outmx002.isp.belgacom.be
	[195.238.3.52]) by ozlabs.org (Postfix) with ESMTP id DA71367A79
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Mar 2005 09:48:16 +1000 (EST)
Received: from outmx002.isp.belgacom.be (localhost [127.0.0.1])
	by outmx002.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2QNmB4E013693
	for <linuxppc-embedded@ozlabs.org>; Sun, 27 Mar 2005 00:48:12 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <2.20050327_004704.tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
In-Reply-To: <0.20050327_004704.tnt@patchsend.246tNt.com>
References: <0.20050327_004704.tnt@patchsend.246tNt.com>
Date: Sun, 27 Mar 2005 00:45:43 +0100 (CET)
Cc: Sylvain Munaut <tnt@246tNt.com>,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 2/6] ppc32: Remove the OCP system from the Freescale MPC52xx
	support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppc32: Remove the OCP system from the Freescale MPC52xx support

We remove all usage of the OCP system as preparation to switch
to the platform bus model / ppc_sys model.
This is only for 'generic' support, drivers are adapted separatly,
afterwards.


Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
---
diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2005-03-26 19:56:03 +01:00
+++ b/arch/ppc/Kconfig	2005-03-26 19:56:03 +01:00
@@ -822,7 +822,7 @@
 
 config FSL_OCP
 	bool
-	depends on MPC10X_BRIDGE || PPC_MPC52xx
+	depends on MPC10X_BRIDGE
 	default y
 
 config MPC10X_OPENPIC
diff -Nru a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
--- a/arch/ppc/platforms/Makefile	2005-03-26 19:56:03 +01:00
+++ b/arch/ppc/platforms/Makefile	2005-03-26 19:56:03 +01:00
@@ -45,7 +45,7 @@
 obj-$(CONFIG_SANDPOINT)		+= sandpoint.o
 obj-$(CONFIG_SBC82xx)		+= sbc82xx.o
 obj-$(CONFIG_SPRUCE)		+= spruce.o
-obj-$(CONFIG_LITE5200)		+= lite5200.o mpc5200.o
+obj-$(CONFIG_LITE5200)		+= lite5200.o
 
 ifeq ($(CONFIG_SMP),y)
 obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o
diff -Nru a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
--- a/arch/ppc/platforms/lite5200.c	2005-03-26 19:56:03 +01:00
+++ b/arch/ppc/platforms/lite5200.c	2005-03-26 19:56:03 +01:00
@@ -13,7 +13,7 @@
  * Dale Farnsworth <dale.farnsworth@mvista.com> and
  * Wolfgang Denk <wd@denx.de>
  * 
- * Copyright 2004 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright 2004-2005 Sylvain Munaut <tnt@246tNt.com>
  * Copyright 2003 Motorola Inc.
  * Copyright 2003 MontaVista Software Inc.
  * Copyright 2003 DENX Software Engineering (wd@denx.de)
@@ -29,10 +29,10 @@
 #include <linux/kdev_t.h>
 #include <linux/root_dev.h>
 #include <linux/console.h>
+#include <linux/module.h>
 
 #include <asm/bootinfo.h>
 #include <asm/io.h>
-#include <asm/ocp.h>
 #include <asm/mpc52xx.h>
 
 #include <syslib/mpc52xx_pci.h>
@@ -46,31 +46,6 @@
 
 
 /* ======================================================================== */
-/* OCP device definition                                                    */
-/* For board/shared resources like PSCs                                     */
-/* ======================================================================== */
-/* Be sure not to load conficting devices : e.g. loading the UART drivers for
- * PSC1 and then also loading a AC97 for this same PSC.
- * For details about how to create an entry, look in the doc of the concerned
- * driver ( eg drivers/serial/mpc52xx_uart.c for the PSC in uart mode )
- */
-
-static struct ocp_def board_ocp[] = {
-	{
-		.vendor		= OCP_VENDOR_FREESCALE,
-		.function	= OCP_FUNC_PSC_UART,
-		.index		= 0,
-		.paddr		= MPC52xx_PSC1,
-		.irq		= MPC52xx_PSC1_IRQ,
-		.pm		= OCP_CPM_NA,
-	},
-	{	/* Terminating entry */
-		.vendor		= OCP_VENDOR_INVALID
-	}
-};
-
-
-/* ======================================================================== */
 /* Platform specific code                                                   */
 /* ======================================================================== */
 
@@ -131,9 +106,6 @@
 static void __init
 lite5200_setup_arch(void)
 {
-	/* Add board OCP definitions */
-	mpc52xx_add_board_devices(board_ocp);
-
 	/* CPU & Port mux setup */
 	lite5200_setup_cpu();
 
diff -Nru a/arch/ppc/syslib/mpc52xx_setup.c b/arch/ppc/syslib/mpc52xx_setup.c
--- a/arch/ppc/syslib/mpc52xx_setup.c	2005-03-26 19:56:03 +01:00
+++ b/arch/ppc/syslib/mpc52xx_setup.c	2005-03-26 19:56:03 +01:00
@@ -23,7 +23,6 @@
 #include <asm/time.h>
 #include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>
-#include <asm/ocp.h>
 #include <asm/pgtable.h>
 #include <asm/ppcboot.h>
 
@@ -218,12 +217,3 @@
 	tb_ticks_per_jiffy = xlbfreq / HZ / divisor;
 	tb_to_us = mulhwu_scale_factor(xlbfreq / divisor, 1000000);
 }
-
-
-void __init
-mpc52xx_add_board_devices(struct ocp_def board_ocp[]) {
-	while (board_ocp->vendor != OCP_VENDOR_INVALID)
-		if(ocp_add_one_device(board_ocp++))
-			printk("mpc5200-ocp: Failed to add board device !\n");
-}
-
diff -Nru a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
--- a/include/asm-ppc/mpc52xx.h	2005-03-26 19:56:03 +01:00
+++ b/include/asm-ppc/mpc52xx.h	2005-03-26 19:56:03 +01:00
@@ -26,7 +26,6 @@
 #include <asm/types.h>
 
 struct pt_regs;
-struct ocp_def;
 #endif /* __ASSEMBLY__ */
 
 
@@ -391,7 +390,6 @@
 extern void mpc52xx_power_off(void);
 extern void mpc52xx_progress(char *s, unsigned short hex);
 extern void mpc52xx_calibrate_decr(void);
-extern void mpc52xx_add_board_devices(struct ocp_def board_ocp[]);
 
 extern void mpc52xx_find_bridges(void);
