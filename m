Return-Path: <Priyanka.Jain@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 351491A0889
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 17:23:02 +1000 (EST)
From: Priyanka Jain <Priyanka.Jain@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
 <scottwood@freescale.com>
Subject: [PATCH 2/2][v3] powerpc/fsl-booke: Add initial T1042RDB_PI board
 support
Date: Mon, 11 Aug 2014 12:49:18 +0530
Message-ID: <1407741558-2695-1-git-send-email-Priyanka.Jain@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Priyanka Jain <Priyanka.Jain@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

T1042RDB_PI is Freescale Reference Design Board supporting the T1042
QorIQ Power Architecture™ processor. T1042 is a reduced personality
of T1040 SoC without Integrated 8-port Gigabit. The board is designed
with low power features targeted for Printing Image Market.

T1042RDB_PI is  similar to T1040RDB board with few differences like
it has video interface, supports T1042 personality only

T1042RDB_PI board Overview
-----------------------
- SERDES Connections, 8 lanes supporting:
    	- PCI
    	- SATA 2.0
- DDR Controller
    	- Supports rates of up to 1600 MHz data-rate
    	- Supports one DDR3LP UDIMM
-IFC/Local Bus
    	- NAND flash: 1GB 8-bit NAND flash
    	- NOR: 128MB 16-bit NOR Flash
- Ethernet
    	- Two on-board RGMII 10/100/1G ethernet ports.
    	- PHY #0 remains powered up during deep-sleep
- CPLD
- Clocks
    	- System and DDR clock (SYSCLK, “DDRCLK”)
    	- SERDES clocks
- Power Supplies
- USB
    	- Supports two USB 2.0 ports with integrated PHYs
    	- Two type A ports with 5V@1.5A per port.
- SDHC
    	- SDHC/SDXC connector
- SPI
    	- On-board 64MB SPI flash
- I2C
    	- Device connected: EEPROM, thermal monitor, VID controller, RTC
- Other IO
    	- Two Serial ports
    	- ProfiBus port

Add support for T1042RDB_PI board:
    -add device tree
    -Add entry in corenet_generic.c, as it is similar to other corenet platforms

Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
---
changes for v3: Incorporated Scott comments on moving cpld compatible
 field to board specific file as cpld binaries are different

changes for v2: Incorporated Scott comments on using common name
 for compatible string for cpld as register set is same

 arch/powerpc/boot/dts/t1042rdb_pi.dts         |   57 +++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/corenet_generic.c |    1 +
 2 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/t1042rdb_pi.dts

diff --git a/arch/powerpc/boot/dts/t1042rdb_pi.dts b/arch/powerpc/boot/dts/t1042rdb_pi.dts
new file mode 100644
index 0000000..b9d0877
--- /dev/null
+++ b/arch/powerpc/boot/dts/t1042rdb_pi.dts
@@ -0,0 +1,57 @@
+/*
+ * T1042RDB_PI Device Tree Source
+ *
+ * Copyright 2014 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/include/ "fsl/t104xsi-pre.dtsi"
+/include/ "t104xrdb.dtsi"
+
+/ {
+	model = "fsl,T1042RDB_PI";
+	compatible = "fsl,T1042RDB_PI";
+	ifc: localbus@ffe124000 {
+		cpld@3,0 {
+			compatible = "fsl,t1040rdb-cpld";
+		};
+	};
+	soc: soc@ffe000000 {
+		i2c@118000 {
+			rtc@68 {
+				compatible = "dallas,ds1337";
+				reg = <0x68>;
+				interrupts = <0x2 0x1 0 0>;
+			};
+		};
+	};
+};
+
+/include/ "fsl/t1042si-post.dtsi"
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index c268f89..100e80d 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -130,6 +130,7 @@ static const char * const boards[] __initconst = {
 	"fsl,T1042QDS",
 	"fsl,T1040RDB",
 	"fsl,T1042RDB",
+	"fsl,T1042RDB_PI",
 	"keymile,kmcoge4",
 	NULL
 };
-- 
1.7.4.1
