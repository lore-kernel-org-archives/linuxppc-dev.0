Return-Path: <tnt@246tNt.com>
Received: from outmx020.isp.belgacom.be (outmx020.isp.belgacom.be
	[195.238.2.201]) by ozlabs.org (Postfix) with ESMTP id 7D4F967A9F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 10:12:11 +1100 (EST)
Received: from outmx020.isp.belgacom.be (localhost [127.0.0.1])
	by outmx020.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2LNC4kb021572
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Mar 2005 00:12:04 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from ayanami.246tNt.com (72.155-200-80.adsl.skynet.be
	[80.200.155.72])
	by outmx020.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2LNC2KT021557
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Mar 2005 00:12:02 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from localhost.localdomain (246tNt-laptop.lan.ayanami.246tNt.com
	[10.0.0.245])
	by ayanami.246tNt.com (Postfix) with ESMTP id 3A5EC110E1F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 00:09:47 +0100 (CET)
Message-ID: <6.20050322_000905.tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <0.20050322_000905.tnt@patchsend.246tNt.com>
References: <0.20050322_000905.tnt@patchsend.246tNt.com>
Date: Tue, 22 Mar 2005 00:09:47 +0100 (CET)
Subject: [PATCH 6/6] ppc32: Adds necessary cpu init to use USB on LITE5200
	Platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppc32: Adds necessary cpu init to use USB on LITE5200 Platform

To use external peripheral on MPC5200, some clocking registers
and port-muxing must be done. Since this is platform specific,
it's placed the platform support file. This particular patch
is for USB support on the LITE5200.


Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
diff -Nru a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
--- a/arch/ppc/platforms/lite5200.c	2005-03-21 20:11:23 +01:00
+++ b/arch/ppc/platforms/lite5200.c	2005-03-21 20:11:23 +01:00
@@ -79,21 +79,47 @@
 static void __init
 lite5200_setup_cpu(void)
 {
+	struct mpc52xx_cdm  __iomem *cdm;
+	struct mpc52xx_gpio __iomem *gpio;
 	struct mpc52xx_intr __iomem *intr;
 	struct mpc52xx_xlb  __iomem *xlb;
 
+	u32 port_config;
 	u32 intr_ctrl;
 
 	/* Map zones */
+	cdm  = ioremap(MPC52xx_PA(MPC52xx_CDM_OFFSET), MPC52xx_CDM_SIZE);
+	gpio = ioremap(MPC52xx_PA(MPC52xx_GPIO_OFFSET), MPC52xx_GPIO_SIZE);
 	xlb  = ioremap(MPC52xx_PA(MPC52xx_XLB_OFFSET), MPC52xx_XLB_SIZE);
 	intr = ioremap(MPC52xx_PA(MPC52xx_INTR_OFFSET), MPC52xx_INTR_SIZE);
 
-	if (!xlb || !intr) {
-		printk("lite5200.c: Error while mapping XLB/INTR during "
+	if (!cdm || !gpio || !xlb || !intr) {
+		printk("lite5200.c: Error while mapping CDM/GPIO/XLB/INTR during"
 				"lite5200_setup_cpu\n");
 		goto unmap_regs;
 	}
 
+	/* Use internal 48 Mhz */
+	out_8(&cdm->ext_48mhz_en, 0x00);
+	out_8(&cdm->fd_enable, 0x01);
+	if (in_be32(&cdm->rstcfg) & 0x40)	/* Assumes 33Mhz clock */
+		out_be16(&cdm->fd_counters, 0x0001);
+	else
+		out_be16(&cdm->fd_counters, 0x5555);
+
+	/* Get port mux config */
+	port_config = in_be32(&gpio->port_config);
+
+	/* 48Mhz internal, pin is GPIO */
+	port_config &= ~0x00800000;
+
+	/* USB port */
+	port_config &= ~0x00007000;	/* Differential mode - USB1 only */
+	port_config |=  0x00001000;
+
+	/* Commit port config */
+	out_be32(&gpio->port_config, port_config);
+
 	/* Configure the XLB Arbiter */
 	out_be32(&xlb->master_pri_enable, 0xff);
 	out_be32(&xlb->master_priority, 0x11111111);
@@ -111,6 +137,8 @@
 
 	/* Unmap reg zone */
 unmap_regs:
+	if (cdm)  iounmap(cdm);
+	if (gpio) iounmap(gpio);
 	if (xlb)  iounmap(xlb);
 	if (intr) iounmap(intr);
 }
@@ -171,7 +199,11 @@
 	isa_mem_base		= 0;
 
 	/* Powersave */
-	powersave_nap = 1;	/* We allow this platform to NAP */
+	/* This is provided as an example on how to do it. But you
+	   need to be aware that NAP disable bus snoop and that may
+	   be required for some devices to work properly, like USB ... */
+	/* powersave_nap = 1; */
+
 
 	/* Setup the ppc_md struct */
 	ppc_md.setup_arch	= lite5200_setup_arch;
