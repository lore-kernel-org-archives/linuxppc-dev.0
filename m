Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BB3ECDDF88
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 23:46:34 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 3223A8817
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 18:46:33 +0500 (SAMST)
Date: Tue, 2 Oct 2007 17:47:43 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] [POWERPC] MPC8568E-MDS: add support for ds1374 rtc
Message-ID: <20071002134743.GB19476@localhost.localdomain>
References: <20071002134535.GA17913@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071002134535.GA17913@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MPC8568E-MDS have DS1374 chip on the I2C bus, thus let's use it.
This patch also adds #address-cells and #size-cells to the I2C
controllers nodes.

p.s. DS1374 rtc class driver is in the -mm tree, its name is
rtc-rtc-class-driver-for-the-ds1374.patch.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8568mds.dts |    9 +++++++++
 arch/powerpc/sysdev/fsl_soc.c        |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 1d082fb..a177dd0 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -72,15 +72,24 @@
 		};
 
 		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			device_type = "i2c";
 			compatible = "fsl-i2c";
 			reg = <3000 100>;
 			interrupts = <2b 2>;
 			interrupt-parent = <&mpic>;
 			dfsrr;
+
+			rtc@68 {
+				compatible = "dallas,ds1374";
+				reg = <68>;
+			};
 		};
 
 		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
 			device_type = "i2c";
 			compatible = "fsl-i2c";
 			reg = <3100 100>;
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 91987e0..c765d7a 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -337,6 +337,7 @@ static struct i2c_driver_device i2c_devices[] __initdata = {
 	{"dallas,ds1339",  "rtc-ds1307",  "ds1339",},
 	{"dallas,ds1340",  "rtc-ds1307",  "ds1340",},
 	{"stm,m41t00",     "rtc-ds1307",  "m41t00"},
+	{"dallas,ds1374",  "rtc-ds1374",  "rtc-ds1374",},
 };
 
 static int __init of_find_i2c_driver(struct device_node *node,
-- 
1.5.0.6
