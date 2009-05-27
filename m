Return-Path: <Kexin.Hao@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 17332DE03C
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 12:05:26 +1000 (EST)
Subject: [PATCH] powerpc/85xx: add nor flash partitions for mpc8569mds
From: Kevin Hao <kexin.hao@windriver.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 27 May 2009 10:05:05 +0800
Message-Id: <1243389905.13410.6.camel@kevin>
Mime-Version: 1.0
Cc: Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add 4 partitions in nor flash. Also fix nor flash
bank width bug.

Signed-off-by: Kevin Hao <kexin.hao@windriver.com>
---
 arch/powerpc/boot/dts/mpc8569mds.dts |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/mpc8569mds.dts
index 39c2927..1f98990 100644
--- a/arch/powerpc/boot/dts/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/mpc8569mds.dts
@@ -70,8 +70,30 @@
 			#size-cells = <1>;
 			compatible = "cfi-flash";
 			reg = <0x0 0x0 0x02000000>;
-			bank-width = <2>;
+			bank-width = <1>;
 			device-width = <1>;
+			partition@0 {
+				label = "ramdisk";
+				reg = <0x00000000 0x01c00000>;
+			};
+			partition@1c00000 {
+				label = "kernel";
+				reg = <0x01c00000 0x002e0000>;
+			};
+			partiton@1ee0000 {
+				label = "dtb";
+				reg = <0x01ee0000 0x00020000>;
+			};
+			partition@1f00000 {
+				label = "firmware";
+				reg = <0x01f00000 0x00080000>;
+				read-only;
+			};
+			partition@1f80000 {
+				label = "u-boot";
+				reg = <0x01f80000 0x00080000>;
+				read-only;
+			};
 		};
 
 		bcsr@1,0 {
-- 
1.6.0.4.771.gef3b3
