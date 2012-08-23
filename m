Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D62172C0084
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2012 01:52:30 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: dts: 52xx: drop critical IRQ from dts files
Date: Thu, 23 Aug 2012 17:31:06 +0200
Message-Id: <1345735866-10001-1-git-send-email-w.sang@pengutronix.de>
Cc: John Bonesio <bones@secretlab.ca>, Anatolij Gustschin <agust@denx.de>,
 Wolfram Sang <w.sang@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The wakeup-gpios have been assigned a critical IRQ in current
devicetrees. The PIC driver does not support critical IRQs, though, which
leads to the following error when booting (a PCM030 in this case):

	mpc52xx_irqhost_map: invalid irq: virq=16, l1=0, l2=3
	irq: irq-16==>hwirq-0x3 mapping failed: -22
	[WARNing skipped]

Remove these entries until they are supported, if ever.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: John Bonesio <bones@secretlab.ca>
Cc: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/boot/dts/lite5200.dts  |    2 +-
 arch/powerpc/boot/dts/mpc5200b.dtsi |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index 179a178..25adace 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -141,7 +141,7 @@
 		gpio@c00 {
 			compatible = "fsl,mpc5200-gpio-wkup";
 			reg = <0xc00 0x40>;
-			interrupts = <1 8 0 0 3 0>;
+			interrupts = <1 8 0>;
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
diff --git a/arch/powerpc/boot/dts/mpc5200b.dtsi b/arch/powerpc/boot/dts/mpc5200b.dtsi
index 7ab286a..e610d68 100644
--- a/arch/powerpc/boot/dts/mpc5200b.dtsi
+++ b/arch/powerpc/boot/dts/mpc5200b.dtsi
@@ -141,7 +141,7 @@
 		gpio_wkup: gpio@c00 {
 			compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
 			reg = <0xc00 0x40>;
-			interrupts = <1 8 0 0 3 0>;
+			interrupts = <1 8 0>;
 			gpio-controller;
 			#gpio-cells = <2>;
 		};
-- 
1.7.10.4
