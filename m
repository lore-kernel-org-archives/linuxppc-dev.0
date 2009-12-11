Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A6450B7BC1
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Dec 2009 00:40:06 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linux-raid@vger.kernel.org
Subject: [PATCH 2/2 v4] powerpc/44x: Extend Katmai dts for ADMA and RAID56
	support
Date: Fri, 11 Dec 2009 14:39:53 +0100
Message-Id: <1260538793-6655-2-git-send-email-agust@denx.de>
In-Reply-To: <1260538793-6655-1-git-send-email-agust@denx.de>
References: <1260538793-6655-1-git-send-email-agust@denx.de>
Cc: wd@denx.de, dzu@denx.de, Yuri Tikhonov <yur@emcraft.com>,
	linuxppc-dev@ozlabs.org, dan.j.williams@intel.com,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add nodes for PPC440SPe DMA, I2O, XOR engines and Memory
Queue module which are used in the updated PPC440SPe ADMA
driver. Also extend plb ranges property to specify address
ranges for DMA0/1 and I2O engines.

Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
v3 of the updated PPC440SPe ADMA driver patch [1] was split
as Dan suggested to apply the ADMA driver to his async_tx next branch for
a pull request for 2.6.33 and to send katmai.dts fixups to Josh.
There are to patches now, the actual ADMA driver patch 1/2 v4 and
katmai dts patch marked as 2/2 v4.

[1] http://patchwork.ozlabs.org/patch/40182

 arch/powerpc/boot/dts/katmai.dts |   52 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.dts
index 51eb6ed..8f345de 100644
--- a/arch/powerpc/boot/dts/katmai.dts
+++ b/arch/powerpc/boot/dts/katmai.dts
@@ -108,12 +108,19 @@
 		dcr-reg = <0x00c 0x002>;
 	};
 
+	MQ0: mq {
+		compatible = "ibm,mq-440spe";
+		dcr-reg = <0x040 0x020>;
+	};
+
 	plb {
 		compatible = "ibm,plb-440spe", "ibm,plb-440gp", "ibm,plb4";
 		#address-cells = <2>;
 		#size-cells = <1>;
 		/*        addr-child     addr-parent    size */
-		ranges = <0x4 0xe0000000 0x4 0xe0000000 0x20000000
+		ranges = <0x4 0x00100000 0x4 0x00100000 0x00001000
+			  0x4 0x00200000 0x4 0x00200000 0x00000400
+			  0x4 0xe0000000 0x4 0xe0000000 0x20000000
 			  0xc 0x00000000 0xc 0x00000000 0x20000000
 			  0xd 0x00000000 0xd 0x00000000 0x80000000
 			  0xd 0x80000000 0xd 0x80000000 0x80000000
@@ -400,6 +407,49 @@
 				0x0 0x0 0x0 0x3 &UIC3 0xa 0x4 /* swizzled int C */
 				0x0 0x0 0x0 0x4 &UIC3 0xb 0x4 /* swizzled int D */>;
 		};
+
+		I2O: i2o@400100000 {
+			compatible = "ibm,i2o-440spe";
+			reg = <0x00000004 0x00100000 0x100>;
+			dcr-reg = <0x060 0x020>;
+		};
+
+		DMA0: dma0@400100100 {
+			compatible = "ibm,dma-440spe";
+			cell-index = <0>;
+			reg = <0x00000004 0x00100100 0x100>;
+			dcr-reg = <0x060 0x020>;
+			interrupt-parent = <&DMA0>;
+			interrupts = <0 1>;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = <
+				0 &UIC0 0x14 4
+				1 &UIC1 0x16 4>;
+		};
+
+		DMA1: dma1@400100200 {
+			compatible = "ibm,dma-440spe";
+			cell-index = <1>;
+			reg = <0x00000004 0x00100200 0x100>;
+			dcr-reg = <0x060 0x020>;
+			interrupt-parent = <&DMA1>;
+			interrupts = <0 1>;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = <
+				0 &UIC0 0x16 4
+				1 &UIC1 0x16 4>;
+		};
+
+		xor-accel@400200000 {
+			compatible = "amcc,xor-accelerator";
+			reg = <0x00000004 0x00200000 0x400>;
+			interrupt-parent = <&UIC1>;
+			interrupts = <0x1f 4>;
+		};
 	};
 
 	chosen {
-- 
1.5.6.3
