Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9A5B3DDF07
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 09:04:38 +1000 (EST)
Date: Thu, 12 Jun 2008 03:04:37 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 4/4] powerpc/86xx: mpc8610_hpcd: add support for ULI RTC
Message-ID: <20080611230437.GD21351@polina.dev.rtsoft.ru>
References: <20080611230250.GA13412@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080611230250.GA13412@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ULI "Super South Bridge" contains ISA bridge to the legacy
devices, such as Super IO mouse/keyboard/floppy disk controllers,
parallel port, i8259 interrupt controller and so on.

i8259 is disabled on the MPC8610HPCD, and other peripherals are not
traced out. So we use only RTC.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8610_hpcd.dts      |   14 +++++++
 arch/powerpc/configs/mpc8610_hpcd_defconfig |   51 ++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 65a5f64..c4507cd 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -388,6 +388,20 @@
 					  0x01000000 0x0 0x00000000
 					  0x01000000 0x0 0x00000000
 					  0x0 0x00100000>;
+
+				isa@1e {
+					device_type = "isa";
+					#size-cells = <1>;
+					#address-cells = <2>;
+					reg = <0xf000 0 0 0 0>;
+					ranges = <1 0 0x01000000 0 0
+						  0x00001000>;
+
+					rtc@70 {
+						compatible = "pnpPNP,b00";
+						reg = <1 0x70 2>;
+					};
+				};
 			};
 		};
 	};
diff --git a/arch/powerpc/configs/mpc8610_hpcd_defconfig b/arch/powerpc/configs/mpc8610_hpcd_defconfig
index 7e5b9ce..5885597 100644
--- a/arch/powerpc/configs/mpc8610_hpcd_defconfig
+++ b/arch/powerpc/configs/mpc8610_hpcd_defconfig
@@ -813,7 +813,6 @@ CONFIG_UNIX98_PTYS=y
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_NVRAM is not set
-# CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -1065,12 +1064,56 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_NEW_LEDS is not set
 # CONFIG_INFINIBAND is not set
 # CONFIG_EDAC is not set
-# CONFIG_RTC_CLASS is not set
-# CONFIG_DMADEVICES is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
+# CONFIG_RTC_DRV_DS1307 is not set
+# CONFIG_RTC_DRV_DS1374 is not set
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+# CONFIG_RTC_DRV_RS5C372 is not set
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+# CONFIG_RTC_DRV_PCF8563 is not set
+# CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
+# CONFIG_RTC_DRV_S35390A is not set
 
 #
-# Userspace I/O
+# SPI RTC drivers
 #
+
+#
+# Platform RTC drivers
+#
+CONFIG_RTC_DRV_CMOS=y
+# CONFIG_RTC_DRV_DS1511 is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
+# CONFIG_DMADEVICES is not set
 # CONFIG_UIO is not set
 
 #
-- 
1.5.5.4
