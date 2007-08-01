Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3342CDDDE9
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 22:35:06 +1000 (EST)
Date: Wed, 1 Aug 2007 16:34:00 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi, register
	mmc_spi stub
Message-ID: <20070801123400.GA20200@localhost.localdomain>
References: <20070726135738.GB5643@localhost.localdomain>
	<692e6dabbfb62dc6d6ace3ea7552ef68@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <692e6dabbfb62dc6d6ace3ea7552ef68@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 01, 2007 at 12:10:28AM +0200, Segher Boessenkool wrote:
>> +			spi1pio:spi_pin@01 {
>
> There should be whitespace after the label.  @01 should be
> spelled @1.  Except there is no "reg" property.

Hm. I've just tried to keep original style in this particular dts.
Want to ack patch below?

What is prefered style of <&label> vs. < &label > usage, btw?

arch/powerpc/boot/dts$ grep "<&" -r . | wc -l
327
arch/powerpc/boot/dts$ grep "< &" -r . | wc -l
92

I can only guess - the first?

> What is this
> stuff, anyway?

Which one? pio-map for spi? This is GPIO pins configuration, to use
dedicated functions (SPI) for these pins, otherwise SPI will not work.

>> +				pio-map = <
>> +			/* port  pin  dir  open_drain  assignment  has_irq    */
>> +					3  0  3  0  1  0	/* SPI1 MOSI, I/O */
>> +					3  1  3  0  1  0	/* SPI1 MISO, I/O */
>> +					3  2  3  0  1  0	/* SPI1 CLK,  I/O */
>> +					3  3  2  0  1  0>;	/* SPI1 SEL,  I   */
>> +			};


p.s. mpc8272ads.dts is broken wrt spaces/tabs, very.

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [POWERPC] boot/dts/*: cleanup labels usage

There should be whitespace after labels.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8272ads.dts  |    6 +++---
 arch/powerpc/boot/dts/mpc832x_rdb.dts |   12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 1934b80..97c5d4e 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -66,14 +66,14 @@
                        reg = <0 0>;
                        #address-cells = <1>;
                        #size-cells = <0>;
-			phy0:ethernet-phy@0 {
+			phy0: ethernet-phy@0 {
 				interrupt-parent = <&Cpm_pic>;
                                interrupts = <17 4>;
                                reg = <0>;
                                bitbang = [ 12 12 13 02 02 01 ];
                                device_type = "ethernet-phy";
                        };
-			phy1:ethernet-phy@1 {
+			phy1: ethernet-phy@1 {
 				interrupt-parent = <&Cpm_pic>;
                                interrupts = <17 4>;
                                bitbang = [ 12 12 13 02 02 01 ];
@@ -153,7 +153,7 @@
                        };
 
                };
-			cpm_pic:interrupt-controller@10c00 {
+			cpm_pic: interrupt-controller@10c00 {
                        #address-cells = <0>;
                        #interrupt-cells = <2>;
                        interrupt-controller;
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 7c4beff..e9c332f 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -127,7 +127,7 @@
 			device_type = "pci";
 		};
 
-		pic:pic@700 {
+		pic: pic@700 {
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
@@ -141,7 +141,7 @@
 			device_type = "par_io";
 			num-ports = <7>;
 
-			ucc2pio:ucc_pin@02 {
+			ucc2pio: ucc_pin@02 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					3  4  3  0  2  0 	/* MDIO */
@@ -163,7 +163,7 @@
 					0 1e  1  0  1  0 	/* TX_EN */
 					0 1f  2  0  1  0>;      /* CRS */
 			};
-			ucc3pio:ucc_pin@03 {
+			ucc3pio: ucc_pin@03 {
 				pio-map = <
 			/* port  pin  dir  open_drain  assignment  has_irq */
 					0  d  2  0  1  0 	/* RX_CLK (CLK9) */
@@ -272,13 +272,13 @@
 			device_type = "mdio";
 			compatible = "ucc_geth_phy";
 
-			phy00:ethernet-phy@00 {
+			phy00: ethernet-phy@00 {
 				interrupt-parent = <&pic>;
 				interrupts = <0>;
 				reg = <0>;
 				device_type = "ethernet-phy";
 			};
-			phy04:ethernet-phy@04 {
+			phy04: ethernet-phy@04 {
 				interrupt-parent = <&pic>;
 				interrupts = <0>;
 				reg = <4>;
@@ -286,7 +286,7 @@
 			};
 		};
 
-		qeic:qeic@80 {
+		qeic: qeic@80 {
 			interrupt-controller;
 			device_type = "qeic";
 			#address-cells = <0>;
-- 
1.5.0.6
