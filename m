Return-Path: <r58472@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A864EB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Dec 2010 22:41:24 +1100 (EST)
Received: from mail114-va3 (localhost.localdomain [127.0.0.1])	by
	mail114-va3-R.bigfish.com (Postfix) with ESMTP id E327CB702C5	for
	<linuxppc-dev@lists.ozlabs.org>; Fri,  3 Dec 2010 11:41:21 +0000 (UTC)
Received: from VA3EHSMHS015.bigfish.com (unknown [10.7.14.250])	by
	mail114-va3.bigfish.com (Postfix) with ESMTP id 94577D9804D	for
	<linuxppc-dev@lists.ozlabs.org>; Fri,  3 Dec 2010 11:41:21 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	oB3BhLdo027227	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 3 Dec 2010 04:43:21 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	oB3BxAdl018881	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 3 Dec 2010 05:59:23 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 7/7] P2020ds: add event button handler
Date: Fri, 3 Dec 2010 20:34:11 +0800
Message-ID: <1291379651-8822-7-git-send-email-leoli@freescale.com>
In-Reply-To: <1291379651-8822-6-git-send-email-leoli@freescale.com>
References: <1291379651-8822-1-git-send-email-leoli@freescale.com>
	<1291379651-8822-2-git-send-email-leoli@freescale.com>
	<1291379651-8822-3-git-send-email-leoli@freescale.com>
	<1291379651-8822-4-git-send-email-leoli@freescale.com>
	<1291379651-8822-5-git-send-email-leoli@freescale.com>
	<1291379651-8822-6-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This can be used as a wakeup source for power management.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/p2020ds.dts        |    9 ++++++++-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c |   26 +++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/p2020ds.dts b/arch/powerpc/boot/dts/p2020ds.dts
index 1101914..f4c6520 100644
--- a/arch/powerpc/boot/dts/p2020ds.dts
+++ b/arch/powerpc/boot/dts/p2020ds.dts
@@ -1,7 +1,7 @@
 /*
  * P2020 DS Device Tree Source
  *
- * Copyright 2009 Freescale Semiconductor Inc.
+ * Copyright 2009-2010 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -155,6 +155,13 @@
 			compatible = "fsl,elbc-fcm-nand";
 			reg = <0x6 0x0 0x40000>;
 		};
+
+		ngpixis@3,0 {
+			compatible = "fsl,p2020ds-fpga";
+			reg = <0x3 0 0x30>;
+			interrupt-parent = <&mpic>;
+			interrupts = <0 0>;
+		};
 	};
 
 	soc@ffe00000 {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 8190bc2..a8807fe 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -4,7 +4,7 @@
  * Author Xianghua Xiao (x.xiao@freescale.com)
  * Roy Zang <tie-fei.zang@freescale.com>
  * 	- Add PCI/PCI Exprees support
- * Copyright 2007 Freescale Semiconductor Inc.
+ * Copyright 2007-2010 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -200,6 +200,30 @@ static void __init mpc85xx_ds_setup_arch(void)
 	printk("MPC85xx DS board from Freescale Semiconductor\n");
 }
 
+static irqreturn_t event_isr(int irq, void *dev_id)
+{
+
+	printk(KERN_INFO "MPC85xxDS: Event button been pushed.\n");
+	return IRQ_HANDLED;
+}
+
+static int __init p2020ds_ngpixis_init(void)
+{
+	int event_irq, ret;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,p2020ds-fpga");
+	if (np) {
+		event_irq = irq_of_parse_and_map(np, 0);
+		ret = request_irq(event_irq, event_isr, 0, "event", NULL);
+		if (ret)
+			printk(KERN_ERR "Can't request board event int\n");
+		of_node_put(np);
+	}
+	return 0;
+}
+machine_device_initcall(p2020_ds, p2020ds_ngpixis_init);
+
 /*
  * Called very early, device-tree isn't unflattened
  */
-- 
1.6.6-rc1.GIT
