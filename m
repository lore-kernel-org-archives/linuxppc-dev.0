Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9A60CDDD09
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 16:54:18 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l5D6s60S027667
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 23:54:07 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l5D6s36v023959
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 01:54:04 -0500 (CDT)
Subject: [PATCH v4]: Fix e500 v2 core reboot bug
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1181717615.9397.40.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 13 Jun 2007 14:53:38 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

Fix the reset bug on 8548CDS board.
>From MPC8548CDS with e500 v2 core, a new reset control register is added.
This register is used for the cpu reset.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
Please ignore all the previous ones :-(
Segher, do you have any comment?
If yes, I will revise again; if No, pick it up!
Thanks!

 arch/powerpc/boot/dts/mpc8548cds.dts |    6 ++++++
 arch/powerpc/platforms/85xx/misc.c   |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

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
index 3e62fcb..8286393 100644
--- a/arch/powerpc/platforms/85xx/misc.c
+++ b/arch/powerpc/platforms/85xx/misc.c
@@ -13,11 +13,43 @@
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
+	} else
+		printk (KERN_INFO "rstcr compatible register does not exist!\n");
+	if (np)
+		of_node_put(np);
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
