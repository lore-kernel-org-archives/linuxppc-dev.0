Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id B4B37DDDDF
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 22:59:02 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/4xx: Add L2 cache node to AMCC Canyonlands dts file
Date: Fri,  5 Dec 2008 12:58:49 +0100
Message-Id: <1228478329-30151-1-git-send-email-sr@denx.de>
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
v2:
- Add next-level-cache property to the cpu node as suggested by Josh and Ben

 arch/powerpc/boot/dts/canyonlands.dts |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index 79fe412..36ebdf3 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -40,6 +40,7 @@
 			d-cache-size = <32768>;
 			dcr-controller;
 			dcr-access-method = "native";
+			next-level-cache = <&L2C0>;
 		};
 	};
 
@@ -104,6 +105,16 @@
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
