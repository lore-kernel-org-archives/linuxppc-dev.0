Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 09C97DDEC4
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 23:57:17 +1100 (EST)
Received: from leda.ptxnet.pengutronix.de ([10.1.0.71])
	by metis.extern.pengutronix.de with esmtp (Exim 3.36 #1 (Debian))
	id 1H4z3D-0001ph-00
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 13:28:59 +0100
Received: from sha by leda.ptxnet.pengutronix.de with local (Exim 4.63)
	(envelope-from <sha@localhost.localdomain>) id 1H4z39-00048N-KV
	for linuxppc-dev@ozlabs.org; Thu, 11 Jan 2007 13:28:55 +0100
Date: Thu, 11 Jan 2007 13:28:55 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] add restart function for mpc52xx
Message-ID: <20070111122855.GF11226@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds restart support for mpx52xx systems.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

---
 arch/powerpc/platforms/52xx/lite5200.c       |    1 +
 arch/powerpc/platforms/52xx/mpc52xx_common.c |   15 +++++++++++++++
 include/asm-powerpc/mpc52xx.h                |    2 ++
 3 files changed, 18 insertions(+)

Index: linux-2.6/arch/powerpc/platforms/52xx/lite5200.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/52xx/lite5200.c
+++ linux-2.6/arch/powerpc/platforms/52xx/lite5200.c
@@ -153,6 +153,7 @@ define_machine(lite52xx) {
 	.name 		= "lite52xx",
 	.probe 		= lite52xx_probe,
 	.setup_arch 	= lite52xx_setup_arch,
+	.restart	= mpc52xx_restart,
 	.init		= mpc52xx_declare_of_platform_devices,
 	.init_IRQ 	= mpc52xx_init_irq,
 	.get_irq 	= mpc52xx_get_irq,
Index: linux-2.6/arch/powerpc/platforms/52xx/mpc52xx_common.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ linux-2.6/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -75,6 +75,21 @@ mpc52xx_find_ipb_freq(struct device_node
 }
 EXPORT_SYMBOL(mpc52xx_find_ipb_freq);
 
+void
+mpc52xx_restart(char *cmd)
+{
+	struct mpc52xx_gpt *gpt = mpc52xx_find_and_map("mpc52xx-gpt");
+
+	local_irq_disable();
+
+	/* Turn on the watchdog and wait for it to expire. It effectively
+	  does a reset */
+	out_be32(&gpt->mode, 0x00000000);
+	out_be32(&gpt->count, 0x0000000ff);
+	out_be32(&gpt->mode, 0x00009004);
+
+	while (1);
+}
 
 void __init
 mpc52xx_setup_cpu(void)
Index: linux-2.6/include/asm-powerpc/mpc52xx.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/mpc52xx.h
+++ linux-2.6/include/asm-powerpc/mpc52xx.h
@@ -249,6 +249,8 @@ extern void mpc52xx_declare_of_platform_
 extern void mpc52xx_init_irq(void);
 extern unsigned int mpc52xx_get_irq(void);
 
+extern void mpc52xx_restart(char *cmd);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __ASM_POWERPC_MPC52xx_H__ */


-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
