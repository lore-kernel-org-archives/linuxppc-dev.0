Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id BB880DE702
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 04:56:09 +1000 (EST)
Date: Mon, 5 May 2008 22:56:07 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/2] [POWERPC] 86xx: mpc8610_hpcd: add support for ULI RTC
Message-ID: <20080505185607.GB4906@polina.dev.rtsoft.ru>
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

The ULI "Super South Bridge" contains ISA bridge to the legacy
devices, such as Super IO mouse/keyboard/floppy disk controllers,
parallel port, i8259 interrupt controller and so on.

On the MPC8610HPCD, i8259 seems to be disabled (mpc8610_hpcd.c
confirms this), and other peripherals are not traced out.
So we use only RTC.

This patch also adds ULI quirk to make RTC actually work (this
quirk differs a bit from the one in the fsl_uli1575.c).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8610_hpcd.dts      |   14 +++++++
 arch/powerpc/configs/mpc8610_hpcd_defconfig |   51 ++++++++++++++++++++++++--
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c  |   27 ++++++++++++++
 3 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 5030533..92cd3bf 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -386,6 +386,20 @@
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
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index e415353..ff6f08a 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -275,6 +275,32 @@ static void __devinit quirk_uli5229(struct pci_dev *dev)
 	pci_write_config_byte(dev, 0x4b, c);
 }
 
+/* We have to do a dummy read on the P2P for the RTC to work, WTF */
+static void __devinit final_uli5249(struct pci_dev *dev)
+{
+	int i;
+	u8 __iomem *dummy;
+	struct pci_bus *bus = dev->bus;
+
+	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
+		if ((bus->resource[i]) &&
+			(bus->resource[i]->flags & IORESOURCE_MEM)) {
+			/*
+			 * fsl_uli1575.c reads at ->start, but I got the RTC
+			 * working only when reading at 0xa0100000-0xafffffff,
+			 * i.e. anything but outside of behind-the-bridge
+			 * devices' assigned regions. Weird, but works here.
+			 */
+			dummy = ioremap(bus->resource[i]->end - 3, 4);
+			if (dummy) {
+				in_8(dummy);
+				iounmap(dummy);
+			}
+			break;
+		}
+	}
+}
+
 /*
  * SATA interrupt pin bug fix
  * There's a chip bug for 5288, The interrupt pin should be 2,
@@ -307,6 +333,7 @@ static void __devinit final_uli5288(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x5249, final_uli5249);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x5288, final_uli5288);
 #endif /* CONFIG_PCI */
 
-- 
1.5.5.1
