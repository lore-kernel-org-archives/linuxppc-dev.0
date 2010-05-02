Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id D9C6EB7D5D
	for <linuxppc-dev@ozlabs.org>; Mon,  3 May 2010 03:27:07 +1000 (EST)
Date: Sun, 2 May 2010 21:27:05 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/83xx: Add MCU LEDs support for MPC837xRDB and
	MPC8315RDB boards
Message-ID: <20100502172705.GA22021@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are two front-panel LEDs on MPC837xRDB and MPC8315RDB boards: PWR
and HDD. After adding appropriate nodes we can program these LEDs from
kernel and user space.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/powerpc/boot/dts/mpc8315erdb.dts     |   14 ++++++++++++++
 arch/powerpc/boot/dts/mpc8377_rdb.dts     |   14 ++++++++++++++
 arch/powerpc/boot/dts/mpc8378_rdb.dts     |   14 ++++++++++++++
 arch/powerpc/boot/dts/mpc8379_rdb.dts     |   14 ++++++++++++++
 arch/powerpc/platforms/83xx/mpc831x_rdb.c |    1 +
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |    1 +
 6 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index 8a3a4f3..2b3fc0b 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -463,4 +463,18 @@
 				  0 0x00800000>;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		pwr {
+			gpios = <&mcu_pio 0 0>;
+			default-state = "on";
+		};
+
+		hdd {
+			gpios = <&mcu_pio 1 0>;
+			linux,default-trigger = "ide-disk";
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 9e2264b..dbc1b98 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -486,4 +486,18 @@
 				  0 0x00800000>;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		pwr {
+			gpios = <&mcu_pio 0 0>;
+			default-state = "on";
+		};
+
+		hdd {
+			gpios = <&mcu_pio 1 0>;
+			linux,default-trigger = "ide-disk";
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 4e6a1a4..3447eb9 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -470,4 +470,18 @@
 				  0 0x00800000>;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		pwr {
+			gpios = <&mcu_pio 0 0>;
+			default-state = "on";
+		};
+
+		hdd {
+			gpios = <&mcu_pio 1 0>;
+			linux,default-trigger = "ide-disk";
+		};
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 72336d5..15560c6 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -436,4 +436,18 @@
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		pwr {
+			gpios = <&mcu_pio 0 0>;
+			default-state = "on";
+		};
+
+		hdd {
+			gpios = <&mcu_pio 1 0>;
+			linux,default-trigger = "ide-disk";
+		};
+	};
 };
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index 0b4f883..ae525e4 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -74,6 +74,7 @@ static int __init mpc831x_rdb_probe(void)
 static struct of_device_id __initdata of_bus_ids[] = {
 	{ .compatible = "simple-bus" },
 	{ .compatible = "gianfar" },
+	{ .compatible = "gpio-leds", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index a1908d2..e00801c 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -72,6 +72,7 @@ static struct of_device_id mpc837x_ids[] = {
 	{ .compatible = "soc", },
 	{ .compatible = "simple-bus", },
 	{ .compatible = "gianfar", },
+	{ .compatible = "gpio-leds", },
 	{},
 };
 
-- 
1.7.0.5
