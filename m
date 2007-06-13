Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 13144DDE02
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 16:17:02 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l5D6GvF8018414
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 23:16:58 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l5D6GuGm004818
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 01:16:57 -0500 (CDT)
Subject: Re: [PATCH v3]: Fix e500 v2 core reboot bug
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <f81c6f149f20c52f547f39ca0cc8d67c@kernel.crashing.org>
References: <1180406209.8139.13.camel@localhost.localdomain>
	<1181639293.8953.7.camel@localhost.localdomain>
	<f81c6f149f20c52f547f39ca0cc8d67c@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1181715391.9397.16.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 13 Jun 2007 14:16:31 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: roy zang <tie-fei.zang@freescale.com>

Fix the reset bug on 8548CDS board.
>From MPC8548CDS with e500 v2 core, a new reset control register is added.
This register is used for the cpu reset.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
Please pick up this one.
Thanks for Segher's comment!

 arch/powerpc/boot/dts/mpc8548cds.dts |    6 ++++++
 arch/powerpc/platforms/85xx/misc.c   |   31 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index ad96381..0550a3c 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -177,6 +177,12 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		global-utilities@e0000 {	//global utilities reg
+			compatible = "fsl,mpc8548-guts";
+			reg = <e0000 1000>;
+			fsl,has-rstcr;
+		};
+
 		pci1: pci@8000 {
 			interrupt-map-mask = <1f800 0 0 7>;
 			interrupt-map = <
diff --git a/arch/powerpc/platforms/85xx/misc.c b/arch/powerpc/platforms/85xx/misc.c
index 3e62fcb..76f66d4 100644
--- a/arch/powerpc/platforms/85xx/misc.c
+++ b/arch/powerpc/platforms/85xx/misc.c
@@ -13,11 +13,42 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <sysdev/fsl_soc.h>
+
+static __be32 __iomem *rstcr;
 
 extern void abort(void);
 
+static int __init mpc85xx_rstcr(void)
+{
+	struct device_node *np;
+	np = of_find_node_by_name(NULL, "global-utilities");
+	if ((np && of_get_property(np, "fsl,has-rstcr", NULL))) {
+		const u32 *prop = of_get_property(np, "reg", NULL);
+		if (prop) {
+			/* map reset control register
+			 * 0xE00B0 is offset of reset control register
+			 */
+			rstcr = ioremap(get_immrbase() + *prop + 0xB0, 0xff);
+			if (!rstcr)
+				printk (KERN_EMERG "Error: reset control \
+					register not mapped, spinning!\n");
+		}
+		of_node_put(np);
+	} else
+		printk (KERN_INFO "rstcr compatible register does not exist!\n");
+	return 0;
+}
+
+arch_initcall(mpc85xx_rstcr);
+
 void mpc85xx_restart(char *cmd)
 {
 	local_irq_disable();
+	if (rstcr)
+		/* set reset control register */
+		out_be32(rstcr, 0x2);	/* HRESET_REQ */
 	abort();
 }
-- 
1.5.1
