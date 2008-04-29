Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 927E8DDFA5
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 02:41:13 +1000 (EST)
Date: Tue, 29 Apr 2008 20:41:12 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] [POWERPC] 86xx: mpc8610_hpcd: add support for PCI Express
	x8 slot
Message-ID: <20080429164112.GA11425@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds pcie node which is resposible for PCI-E x8 slot
functioning. Though, this was tested using only x1 SKY2 NIC.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8610_hpcd.dts |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 1f2f1e0..fff0572 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -21,6 +21,7 @@
 		serial1 = &serial1;
 		pci0 = &pci0;
 		pci1 = &pci1;
+		pci2 = &pci2;
 	};
 
 	cpus {
@@ -322,4 +323,24 @@
 			};
 		};
 	};
+
+	pci2: pcie@e0009000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8641-pcie";
+		reg = <0xe0009000 0x00001000>;
+		ranges = <0x02000000 0 0x90000000 0x90000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xe2000000 0 0x00100000>;
+		bus-range = <0 255>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0x0000 0 0 1 &mpic 4 1
+				 0x0000 0 0 2 &mpic 5 1
+				 0x0000 0 0 3 &mpic 6 1
+				 0x0000 0 0 4 &mpic 7 1>;
+		interrupt-parent = <&mpic>;
+		interrupts = <25 2>;
+		clock-frequency = <33333333>;
+	};
 };
-- 
1.5.5.1
