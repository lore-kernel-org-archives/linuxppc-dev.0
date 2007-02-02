Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 40FFCDDDFD
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 16:04:20 +1100 (EST)
Message-Id: <20070202045508.643066000@lixom.net>>
References: <20070202045448.145851000@lixom.net>>
Date: Thu, 01 Feb 2007 22:54:53 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [5/9] pasemi: Implement restart
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
@@ -42,19 +42,13 @@
 
 static void pas_restart(char *cmd)
 {
-	printk("restart unimplemented, looping...\n");
-	for (;;) ;
-}
-
-static void pas_power_off(void)
-{
-	printk("power off unimplemented, looping...\n");
-	for (;;) ;
-}
-
-static void pas_halt(void)
-{
-	pas_power_off();
+	void __iomem *sdcreg;
+	printk("Restarting...\n");
+	/* XXXOJN This should maybe come out of the device tree */
+	sdcreg = ioremap(0xfc101100, 4);
+	while (1)
+		out_le32(sdcreg, 0x6000000);
+	/* No need to iounmap; never coming back */
 }
 
 #ifdef CONFIG_SMP
@@ -220,8 +214,6 @@ define_machine(pas) {
 	.init_IRQ		= pas_init_IRQ,
 	.get_irq		= mpic_get_irq,
 	.restart		= pas_restart,
-	.power_off		= pas_power_off,
-	.halt			= pas_halt,
 	.get_boot_time		= pas_get_boot_time,
 	.calibrate_decr		= generic_calibrate_decr,
 	.check_legacy_ioport    = pas_check_legacy_ioport,

--
