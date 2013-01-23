Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (unknown [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 12E0D2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 07:14:03 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] powerpc: update sbc8548 flash information to match recent
 u-boot
Date: Wed, 23 Jan 2013 15:13:31 -0500
Message-Id: <1358972013-5271-3-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1358972013-5271-1-git-send-email-paul.gortmaker@windriver.com>
References: <1358972013-5271-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The original memory map for the sbc8548 had the 64MB SODIMM flash
device misaligned by 8MB to allow a window of address space for
the soldered on 8MB device -- i.e.

 start           end             CS<n>   width   Desc.
 ----------------------------------------------------------
 fb80_0000       ff7f_ffff       CS6     32      SODIMM flash (64MB)
 ff80_0000       ffff_ffff       CS0     8       Boot flash (8MB)

However, if we want to change the configuration so that it boots
off the 64MB flash, it is in turn then aligned with a 64MB boundary,
starting at fc00_0000 (and the 8MB @ fb80_0000 -> fbff_ffff).

This makes for complicated updates, since what is the beginning
of the physical device is 8MB into its address space in the default
configuration shown above.

This issue was fixed as of u-boot commit 3fd673cf363bc86ed42eff713d4
("sbc8548: relocate 64MB user flash to sane boundary") -- in which
the SODIMM was mapped to ec00_0000 (natively aligned under efff_ffff)
and so when JP12/SW2.8 are switched, it will be a a simple 0xec --> 0xfc
mapping between the two instances.

Here we make the associated changes in the localbus flash memory
map in the dts file:  indicating the 64MB device starts at ec00_0000
and that the tail end of the 64MB device (last 2 sectors) can contain
a bootloader image.

The partitions for both flash devices get a clean-up; there were
non-meaningful assignments in there that probably originated from
the MPC8548CDS on which the file was based on.  Now there is just
the categorization of free space and bootloader images.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/sbc8548.dts | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
index ad8dc68..1df2a09 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -28,23 +28,25 @@
 			  0x3 0x0 0xf0000000 0x04000000		/*64MB SDRAM*/
 			  0x4 0x0 0xf4000000 0x04000000 	/*64MB SDRAM*/
 			  0x5 0x0 0xf8000000 0x00b10000		/* EPLD */
-			  0x6 0x0 0xfb800000 0x04000000>;	/*64MB Flash*/
+			  0x6 0x0 0xec000000 0x04000000>;	/*64MB Flash*/
 
 
 		flash@0,0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "cfi-flash";
+			compatible = "intel,JS28F640", "cfi-flash";
 			reg = <0x0 0x0 0x800000>;
 			bank-width = <1>;
 			device-width = <1>;
 			partition@0x0 {
 				label = "space";
-				reg = <0x00000000 0x00100000>;
+				/* FF800000 -> FFF9FFFF */
+				reg = <0x00000000 0x007a0000>;
 			};
-			partition@0x100000 {
+			partition@0x7a0000 {
 				label = "bootloader";
-				reg = <0x00100000 0x00700000>;
+				/* FFFA0000 -> FFFFFFFF */
+				reg = <0x007a0000 0x00060000>;
 				read-only;
 			};
 		};
@@ -87,26 +89,20 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			reg = <0x6 0x0 0x04000000>;
-			compatible = "cfi-flash";
+			compatible = "intel,JS28F128", "cfi-flash";
 			bank-width = <4>;
 			device-width = <1>;
 			partition@0x0 {
+				label = "space";
+				/* EC000000 -> EFEFFFFF */
+				reg = <0x00000000 0x03f00000>;
+			};
+			partition@0x03f00000 {
 				label = "bootloader";
-				reg = <0x00000000 0x00100000>;
+				/* EFF00000 -> EFFFFFFF */
+				reg = <0x03f00000 0x00100000>;
 				read-only;
 			};
-			partition@0x00100000 {
-				label = "file-system";
-				reg = <0x00100000 0x01f00000>;
-			};
-			partition@0x02000000 {
-				label = "boot-config";
-				reg = <0x02000000 0x00100000>;
-			};
-			partition@0x02100000 {
-				label = "space";
-				reg = <0x02100000 0x01f00000>;
-			};
                 };
         };
 };
-- 
1.8.1
