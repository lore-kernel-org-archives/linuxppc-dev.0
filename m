Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33501B7D67
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 20:08:40 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/44x: Update Arches dts
Date: Wed, 10 Feb 2010 10:08:34 +0100
Message-Id: <1265792914-26363-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sync Arches dts with latest Canyonlands version:

- Add 16k FIFO size to supported EMAC nodes
- Add next-level-cache property
- Add Crypto device node

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/boot/dts/arches.dts |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/arches.dts b/arch/powerpc/boot/dts/arches.dts
index 414ef8b..30f4120 100644
--- a/arch/powerpc/boot/dts/arches.dts
+++ b/arch/powerpc/boot/dts/arches.dts
@@ -60,6 +60,7 @@
 			d-cache-size = <32768>;
 			dcr-controller;
 			dcr-access-method = "native";
+			next-level-cache = <&L2C0>;
 		};
 	};
 
@@ -146,6 +147,13 @@
 			dcr-reg = <0x010 0x002>;
 		};
 
+		CRYPTO: crypto@180000 {
+			compatible = "amcc,ppc460gt-crypto", "amcc,ppc4xx-crypto";
+			reg = <4 0x00180000 0x80400>;
+			interrupt-parent = <&UIC0>;
+			interrupts = <0x1d 0x4>;
+		};
+
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-460gt", "ibm,mcmal2";
 			dcr-reg = <0x180 0x062>;
@@ -274,6 +282,7 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
 				phy-mode = "sgmii";
 				phy-map = <0xffffffff>;
 				gpcs-address = <0x0000000a>;
@@ -302,6 +311,7 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
 				phy-mode = "sgmii";
 				phy-map = <0x00000000>;
 				gpcs-address = <0x0000000b>;
@@ -331,6 +341,8 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
+				tx-fifo-size-gige = <16384>; /* emac2&3 only */
 				phy-mode = "sgmii";
 				phy-map = <0x00000001>;
 				gpcs-address = <0x0000000C>;
-- 
1.6.6.1
