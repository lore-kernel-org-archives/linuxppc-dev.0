Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id BC828DDDCA
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 17:09:10 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/4xx: Add L2 cache node to AMCC Canyonlands dts file
Date: Fri,  5 Dec 2008 07:08:52 +0100
Message-Id: <1228457332-523-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With this patch the L2 cache is enabled on Canyonlands to increase the
overall performance. There is a known cache coherency issue with the L2
cache, but this is related to the high bandwidth (HB) PLB segment where
the memory address is 0x8.xxxx.xxxx (low bandwidth PLB segment is mapped
to 0x0.xxxx.xxxx). Since this HB address is currently unused it is safe
to enable the L2 cache.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/canyonlands.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index 79fe412..0d77482 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -104,6 +104,16 @@
 		dcr-reg = <0x00c 0x002>;
 	};
 
+	L2C0: l2c {
+		compatible = "ibm,l2-cache-460ex", "ibm,l2-cache";
+		dcr-reg = <0x020 0x008		/* Internal SRAM DCR's */
+			   0x030 0x008>;	/* L2 cache DCR's */
+		cache-line-size = <32>;		/* 32 bytes */
+		cache-size = <262144>;		/* L2, 256K */
+		interrupt-parent = <&UIC1>;
+		interrupts = <11 1>;
+	};
+
 	plb {
 		compatible = "ibm,plb-460ex", "ibm,plb4";
 		#address-cells = <2>;
-- 
1.6.0.4
