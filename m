Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id C9CFADDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Aug 2007 16:52:08 +1000 (EST)
Date: Wed, 1 Aug 2007 08:52:03 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] lite5200b: flash definition in dts
Message-ID: <20070801065203.GK4529@moe.telargo.com>
References: <20070619095408.GK23294@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070619095408.GK23294@moe.telargo.com>
Cc: Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add flash definition for to lite5200b dts, and while at it
fix "ranges" for soc node.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
Hi!

Sylvain, it would be nice to have this merged.

# cat /proc/mtd 
dev:    size   erasesize  name
mtd0: 01000000 00020000 "data0"
mtd1: 00f00000 00020000 "data1"
mtd2: 00100000 00020000 "u-boot"

Some benchmarks:
read:  2.3 MB/s
erase: 168 kB/s
write: 7.3 kB/s


 arch/powerpc/boot/dts/lite5200b.dts |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

Index: work-powerpc.git/arch/powerpc/boot/dts/lite5200b.dts
===================================================================
--- work-powerpc.git.orig/arch/powerpc/boot/dts/lite5200b.dts
+++ work-powerpc.git/arch/powerpc/boot/dts/lite5200b.dts
@@ -52,7 +52,8 @@
 		revision = "";			// from bootloader
 		#interrupt-cells = <3>;
 		device_type = "soc";
-		ranges = <0 f0000000 f0010000>;
+		ranges = <00000000 f0000000 00010000
+			  fe000000 fe000000 02000000>;
 		reg = <f0000000 00010000>;
 		bus-frequency = <0>;		// from bootloader
 		system-frequency = <0>;		// from bootloader
@@ -403,5 +404,26 @@
 			compatible = "mpc5200b-sram\0mpc5200-sram\0sram";
 			reg = <8000 4000>;
 		};
+
+		flash@fe000000 {
+			device_type = "rom";
+			compatible = "direct-mapped";
+			probe-type = "CFI";
+			reg = <fe000000 01000000>;
+			bank-width = <1>;
+			partitions = <00000000 01000000>;
+			partition-names = "data0";
+		};
+
+		flash@ff000000 {
+			device_type = "rom";
+			compatible = "direct-mapped";
+			probe-type = "CFI";
+			reg = <ff000000 01000000>;
+			bank-width = <1>;
+			partitions = <00000000 00f00000
+				      00f00000 00100000>;
+			partition-names = "data1", "u-boot";
+		};
 	};
 };
