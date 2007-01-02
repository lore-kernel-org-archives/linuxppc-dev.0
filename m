Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 03EA9DDF44
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 09:45:01 +1100 (EST)
From: grant.likely@secretlab.ca
To: tnt@246tnt.com,
	paulus@samba.org,
	linuxppc-dev@ozlabs.org
Subject: [POWERPC] Fix mpc52xx fdt to use correct device_type for sound devices
Date: Tue,  2 Jan 2007 15:44:44 -0700
Message-Id: <11677778841167-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

While technically this is not a bug fix as it doesn't touch any C code;
However, it does affect the documented interface for mpc52xx device trees.
Sound devices should be using 'sound' for the device_type field; not the
type of sound interface.  I'd like to fix this issue before 2.6.20 to avoid
any confusion between .20 and .21

Cheers,
g.

 .../powerpc/mpc52xx-device-tree-bindings.txt       |    4 ++--
 arch/powerpc/boot/dts/lite5200.dts                 |    4 ++--
 arch/powerpc/boot/dts/lite5200b.dts                |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/powerpc/mpc52xx-device-tree-bindings.txt b/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
index d077d76..7fb3b8a 100644
--- a/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
+++ b/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
@@ -157,8 +157,8 @@ rtc@<addr>	rtc		*-rtc		Real time clock
 mscan@<addr>	mscan		*-mscan		CAN bus controller
 pci@<addr>	pci		*-pci		PCI bridge
 serial@<addr>	serial		*-psc-uart	PSC in serial mode
-i2s@<addr>	i2s		*-psc-i2s	PSC in i2s mode
-ac97@<addr>	ac97		*-psc-ac97	PSC in ac97 mode
+i2s@<addr>	sound		*-psc-i2s	PSC in i2s mode
+ac97@<addr>	sound		*-psc-ac97	PSC in ac97 mode
 spi@<addr>	spi		*-psc-spi	PSC in spi mode
 irda@<addr>	irda		*-psc-irda	PSC in IrDA mode
 spi@<addr>	spi		*-spi		MPC52xx spi device
diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index 8bc0d25..a8efb59 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -238,7 +238,7 @@
 
 		// PSC3 in CODEC mode example
 		i2s@2400 {		// PSC3
-			device_type = "i2s";
+			device_type = "sound";
 			compatible = "mpc5200-psc-i2s\0mpc52xx-psc-i2s";
 			reg = <2400 100>;
 			interrupts = <2 3 0>;
@@ -265,7 +265,7 @@
 
 		// PSC6 in AC97 mode example
 		ac97@2c00 {		// PSC6
-			device_type = "ac97";
+			device_type = "sound";
 			compatible = "mpc5200-psc-ac97\0mpc52xx-psc-ac97";
 			reg = <2c00 100>;
 			interrupts = <2 4 0>;
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 81cb764..1aabee4 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -243,7 +243,7 @@
 
 		// PSC3 in CODEC mode example
 		i2s@2400 {		// PSC3
-			device_type = "i2s";
+			device_type = "sound";
 			compatible = "mpc5200b-psc-i2s\0mpc52xx-psc-i2s";
 			reg = <2400 100>;
 			interrupts = <2 3 0>;
@@ -270,7 +270,7 @@
 
 		// PSC6 in AC97 mode example
 		ac97@2c00 {		// PSC6
-			device_type = "ac97";
+			device_type = "sound";
 			compatible = "mpc5200b-psc-ac97\0mpc52xx-psc-ac97";
 			reg = <2c00 100>;
 			interrupts = <2 4 0>;
-- 
1.4.3.rc2.g0503
