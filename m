Return-Path: <tmarri@amcc.com>
Received: from denmail01.apm.COM (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 51C3EB70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 11:50:27 +1100 (EST)
From: tmarri@apm.com
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ppc4xx: Add USB DWC DTS entry to Canyonlands board
Date: Wed,  8 Dec 2010 16:50:11 -0800
Message-Id: <1291855811-29594-1-git-send-email-tmarri@apm.com>
Cc: tmarri@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tirumala Marri <tmarri@apm.com>

Add Synopsys Designware DTS entry for 460EX based Canyonlands board.

Signed-off-by: Tirumala R Marri<tmarri@apm.com>
---
 arch/powerpc/boot/dts/canyonlands.dts |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index 5b27a4b..54caec6 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -172,6 +172,19 @@
 			interrupts = <0x1e 4>;
 		};
 
+		USBOTG0: usbotg@bff80000 {
+			compatible = "amcc,dwc-otg";
+			reg = <0x4 0xbff80000 0x10000>;
+			interrupt-parent = <&USBOTG0>;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupts = <0x0 0x1 0x2>;
+			interrupt-map = </* USB-OTG */ 0x0 &UIC2 0x1c 0x4
+					 /* HIGH-POWER */ 0x1 &UIC1 0x1a 0x8
+					 /* DMA */ 0x2 &UIC0 0xc 0x4>;
+		};
+
 		SATA0: sata@bffd1000 {
 			compatible = "amcc,sata-460ex";
 			reg = <4 0xbffd1000 0x800 4 0xbffd0800 0x400>;
-- 
1.6.1.rc3
