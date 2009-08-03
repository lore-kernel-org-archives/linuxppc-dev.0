Return-Path: <hs@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B32B7B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Aug 2009 17:29:48 +1000 (EST)
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id EBDFDDDD1B
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Aug 2009 17:29:46 +1000 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by a.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	EBC1A11A200
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Aug 2009 09:29:42 +0200 (CEST)
Received: from [192.168.1.6] ([82.131.202.159])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KNS00E52I5DJ190@invitel.hu> for
	linuxppc-dev@ozlabs.org; Mon, 03 Aug 2009 09:29:42 +0200 (CEST)
Date: Mon, 03 Aug 2009 09:34:50 +0200
From: Heiko Schocher <hs@denx.de>
Subject: [PATCH v2 1/2] 82xx, mgcoge: updates for 2.6.32
In-reply-to: <20090729103203.GA6369@yookeroo.seuss>
To: linuxppc-dev@ozlabs.org
Message-id: <4A76931A.6@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <4A70091E.7000002@denx.de> <20090729103203.GA6369@yookeroo.seuss>
Cc: david@gibson.dropbear.id.au
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[PATCH v2 1/2] 82xx, mgcoge: updates for 2.6.32

- add I2C support
- add FCC1 and FCC2 support
- fix bogus gpio numbering in plattformcode

Signed-off-by: Heiko Schocher <hs@denx.de>
---
- against git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
  next branch
- checked with checkpatch.pl:
$ ./scripts/checkpatch.pl 0001-82xx-mgcoge-updates-for-2.6.32.patch
total: 0 errors, 0 warnings, 147 lines checked

0001-82xx-mgcoge-updates-for-2.6.32.patch has no obvious style problems and is ready for submission.
$
- changes since v1
  - Add comments from David Gibson
    removed 2 "device_type" entries
  - Add comment from Kumar Gala
    splittet into 2 patches (seperated defconfig patch)

 arch/powerpc/boot/dts/mgcoge.dts     |   53 ++++++++++++++++++++++++++
 arch/powerpc/platforms/82xx/mgcoge.c |   69 +++++++++++++++++++++++++++++----
 2 files changed, 113 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/boot/dts/mgcoge.dts b/arch/powerpc/boot/dts/mgcoge.dts
index 633255a..0ce9664 100644
--- a/arch/powerpc/boot/dts/mgcoge.dts
+++ b/arch/powerpc/boot/dts/mgcoge.dts
@@ -162,6 +162,59 @@
 				fixed-link = <0 0 10 0 0>;
 			};

+			i2c@11860 {
+				compatible = "fsl,mpc8272-i2c",
+					     "fsl,cpm2-i2c";
+				reg = <0x11860 0x20 0x8afc 0x2>;
+				interrupts = <1 8>;
+				interrupt-parent = <&PIC>;
+				fsl,cpm-command = <0x29600000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			mdio@10d40 {
+				compatible = "fsl,cpm2-mdio-bitbang";
+				reg = <0x10d00 0x14>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				fsl,mdio-pin = <12>;
+				fsl,mdc-pin = <13>;
+
+				phy0: ethernet-phy@0 {
+					reg = <0x0>;
+				};
+
+				phy1: ethernet-phy@1 {
+					reg = <0x1>;
+				};
+			};
+
+			/* FCC1 management to switch */
+			ethernet@11300 {
+				device_type = "network";
+				compatible = "fsl,cpm2-fcc-enet";
+				reg = <0x11300 0x20 0x8400 0x100 0x11390 0x1>;
+				local-mac-address = [ 00 01 02 03 04 07 ];
+				interrupts = <32 8>;
+				interrupt-parent = <&PIC>;
+				phy-handle = <&phy0>;
+				linux,network-index = <1>;
+				fsl,cpm-command = <0x12000300>;
+			};
+
+			/* FCC2 to redundant core unit over backplane */
+			ethernet@11320 {
+				device_type = "network";
+				compatible = "fsl,cpm2-fcc-enet";
+				reg = <0x11320 0x20 0x8500 0x100 0x113b0 0x1>;
+				local-mac-address = [ 00 01 02 03 04 08 ];
+				interrupts = <33 8>;
+				interrupt-parent = <&PIC>;
+				phy-handle = <&phy1>;
+				linux,network-index = <2>;
+				fsl,cpm-command = <0x16200300>;
+			};
 		};

 		PIC: interrupt-controller@10c00 {
diff --git a/arch/powerpc/platforms/82xx/mgcoge.c b/arch/powerpc/platforms/82xx/mgcoge.c
index c2af169..7a5de9e 100644
--- a/arch/powerpc/platforms/82xx/mgcoge.c
+++ b/arch/powerpc/platforms/82xx/mgcoge.c
@@ -50,16 +50,63 @@ struct cpm_pin {
 static __initdata struct cpm_pin mgcoge_pins[] = {

 	/* SMC2 */
-	{1, 8, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{1, 9, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 8, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 9, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},

 	/* SCC4 */
-	{3, 25, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{3, 24, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{3,  9, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{3,  8, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{4, 22, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
-	{4, 21, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{2, 25, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 24, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2,  9, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2,  8, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{3, 22, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{3, 21, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+
+	/* FCC1 */
+	{0, 14, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 15, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 18, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 19, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 20, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 21, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 26, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{0, 27, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{0, 28, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{0, 29, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{0, 30, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{0, 31, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+
+	{2, 22, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 23, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* FCC2 */
+	{1, 18, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 19, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 20, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 21, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 22, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 23, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 24, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 25, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 26, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 27, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 28, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 29, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{1, 30, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 31, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+
+	{2, 18, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 19, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* MDC */
+	{0, 13, CPM_PIN_OUTPUT | CPM_PIN_GPIO},
+
+#if defined(CONFIG_I2C_CPM)
+	/* I2C */
+	{3, 14, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_OPENDRAIN},
+	{3, 15, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_OPENDRAIN},
+#endif
 };

 static void __init init_ioports(void)
@@ -68,12 +115,16 @@ static void __init init_ioports(void)

 	for (i = 0; i < ARRAY_SIZE(mgcoge_pins); i++) {
 		const struct cpm_pin *pin = &mgcoge_pins[i];
-		cpm2_set_pin(pin->port - 1, pin->pin, pin->flags);
+		cpm2_set_pin(pin->port, pin->pin, pin->flags);
 	}

 	cpm2_smc_clk_setup(CPM_CLK_SMC2, CPM_BRG8);
 	cpm2_clk_setup(CPM_CLK_SCC4, CPM_CLK7, CPM_CLK_RX);
 	cpm2_clk_setup(CPM_CLK_SCC4, CPM_CLK8, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK10, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK9,  CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK13, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK14, CPM_CLK_TX);
 }

 static void __init mgcoge_setup_arch(void)
-- 
1.6.0.6

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
