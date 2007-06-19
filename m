Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 7B8D7DDFBD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jun 2007 19:54:15 +1000 (EST)
Date: Tue, 19 Jun 2007 11:54:08 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] lite5200b: flash definition in dts
Message-ID: <20070619095408.GK23294@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add flash definition for flash on lite5200b, and while at it
fix "ranges" for soc node.

Kernel now writes:
[   11.159134] fe000000.flash: Found 2 x8 devices at 0x0 in 16-bit bank
[   11.165696]  Amd/Fujitsu Extended Query Table at 0x0040
[   11.171109] fe000000.flash: CFI does not contain boot bank location. Assuming top.
[   11.178911] number of CFI chips: 1
[   11.182427] cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
[   11.190402] RedBoot partition parsing not available
[   11.195449] physmap-flash fe000000.flash: Using OF partition information
[   11.202359] Creating 2 MTD partitions on "fe000000.flash":
[   11.208023] 0x00000000-0x01f00000 : "data"
[   11.213712] 0x01f00000-0x02000000 : "u-boot"


I have not managed to write anything to flash from Linux, ideas?
JEDEC probe does not succeed.
CFI does (cfi_ident struct is filled and "looks" OK),
but mfr and id are 0xffff.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 arch/powerpc/boot/dts/lite5200b.dts |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

Index: work-powerpc.git/arch/powerpc/boot/dts/lite5200b.dts
===================================================================
--- work-powerpc.git.orig/arch/powerpc/boot/dts/lite5200b.dts
+++ work-powerpc.git/arch/powerpc/boot/dts/lite5200b.dts
@@ -52,11 +52,23 @@
 		revision = "";			// from bootloader
 		#interrupt-cells = <3>;
 		device_type = "soc";
-		ranges = <0 f0000000 f0010000>;
+		ranges = <00000000 f0000000 00010000
+			  fe000000 fe000000 02000000>;
 		reg = <f0000000 00010000>;
 		bus-frequency = <0>;		// from bootloader
 		system-frequency = <0>;		// from bootloader
 
+		flash@fe000000 {
+			device_type = "rom";
+			compatible = "direct-mapped";
+			probe-type = "CFI";
+			reg = <fe000000 02000000>;
+			bank-width = <2>;
+			partitions = <00000000 01f00000
+				      01f00000 00100000>;
+			partition-names = "data", "u-boot";
+		};
+
 		cdm@200 {
 			compatible = "mpc5200b-cdm\0mpc5200-cdm";
 			reg = <200 38>;
