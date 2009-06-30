Return-Path: <martyn.welch@gefanuc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id ABFCAB70D0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 10:12:34 +1000 (EST)
Received: from exprod5og101.obsmtp.com (exprod5og101.obsmtp.com [64.18.0.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2120DDE45
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2009 00:37:52 +1000 (EST)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH] powerpc/86xx: Enable XMC site on GE Fanuc SBC310
To: galak@kernel.crashing.org
Date: Tue, 30 Jun 2009 15:32:38 +0100
Message-ID: <20090630143238.10798.9863.stgit@ES-J7S4D2J.amer.consind.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables the XMC (PCIe daughter card) site on the SBC310.
STG enter the description for the patch above.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/boot/dts/gef_sbc310.dts |   37 ++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_sbc310.dts b/arch/powerpc/boot/dts/gef_sbc310.dts
index 0f4c9ec..7810ea9 100644
--- a/arch/powerpc/boot/dts/gef_sbc310.dts
+++ b/arch/powerpc/boot/dts/gef_sbc310.dts
@@ -376,4 +376,41 @@
 				  0x0 0x00400000>;
 		};
 	};
+
+	pci1: pcie@fef09000 {
+		compatible = "fsl,mpc8641-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xfef09000 0x1000>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x02000000 0x0 0xc0000000 0xc0000000 0x0 0x20000000
+			  0x01000000 0x0 0x00000000 0xfe400000 0x0 0x00400000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <0x19 0x2>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			0x0000 0x0 0x0 0x1 &mpic 0x4 0x2
+			0x0000 0x0 0x0 0x2 &mpic 0x5 0x2
+			0x0000 0x0 0x0 0x3 &mpic 0x6 0x2
+			0x0000 0x0 0x0 0x4 &mpic 0x7 0x2
+			>;
+
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0xc0000000
+				  0x02000000 0x0 0xc0000000
+				  0x0 0x20000000
+
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x00400000>;
+		};
+	};
+
 };
