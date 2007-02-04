Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B2238DDEC5
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 09:41:51 +1100 (EST)
Message-Id: <20070204223752.761620000@lixom.net>>
References: <20070204223648.767950000@lixom.net>>
Date: Sun, 04 Feb 2007 16:36:52 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [v2] [4/8] pasemi: Implement restart
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Implement reset on platforms/pasemi. Default is just to reset the
cpu using the SDC registers.

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: merge/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- merge.orig/arch/powerpc/platforms/pasemi/setup.c
+++ merge/arch/powerpc/platforms/pasemi/setup.c
@@ -38,21 +38,13 @@
 
 #include "pasemi.h"
 
-static void pas_restart(char *cmd)
-{
-	printk("restart unimplemented, looping...\n");
-	for (;;) ;
-}
-
-static void pas_power_off(void)
-{
-	printk("power off unimplemented, looping...\n");
-	for (;;) ;
-}
+static void __iomem *reset_reg;
 
-static void pas_halt(void)
+static void pas_restart(char *cmd)
 {
-	pas_power_off();
+	printk("Restarting...\n");
+	while (1)
+		out_le32(reset_reg, 0x6000000);
 }
 
 #ifdef CONFIG_SMP
@@ -82,6 +74,10 @@ void __init pas_setup_arch(void)
 	conswitchp = &dummy_con;
 #endif
 
+	/* Remap SDC register for doing reset */
+	/* XXXOJN This should maybe come out of the device tree */
+	reset_reg = ioremap(0xfc101100, 4);
+
 	pasemi_idle_init();
 }
 
@@ -210,8 +206,6 @@ define_machine(pas) {
 	.init_IRQ		= pas_init_IRQ,
 	.get_irq		= mpic_get_irq,
 	.restart		= pas_restart,
-	.power_off		= pas_power_off,
-	.halt			= pas_halt,
 	.get_boot_time		= pas_get_boot_time,
 	.calibrate_decr		= generic_calibrate_decr,
 	.check_legacy_ioport    = pas_check_legacy_ioport,

--
