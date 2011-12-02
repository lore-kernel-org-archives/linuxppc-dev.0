Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1B066B6F18
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 16:35:17 +1100 (EST)
Message-ID: <1322804108.3729.50.camel@pasglop>
Subject: [PATCH] powerpc: Add support for OpenBlockS 600
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 02 Dec 2011 16:35:08 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So I've had one of these for a while and it looks like the vendor never
bothered submitting the support upstream.

This adds it using ppc40x_simple and provides a device-tree.

There are some changes to the boot wrapper because the way u-boot works
on this thing, it seems to expect a multipart image with the kernel,
initrd and dtb in it.

The USB support is missing as it needs the yet unmerged driver for
the DWC OTG part and the GPIOs may need further definition in the dts.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/Makefile                      |    2 +-
 arch/powerpc/boot/Makefile                 |    7 +
 arch/powerpc/boot/dts/obs600.dts           |  314 ++++++++++++++++++++++++++++
 arch/powerpc/boot/wrapper                  |   22 ++-
 arch/powerpc/configs/40x/obs600_defconfig  |   83 ++++++++
 arch/powerpc/platforms/40x/Kconfig         |   10 +
 arch/powerpc/platforms/40x/ppc40x_simple.c |    3 +-
 7 files changed, 438 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/obs600.dts
 create mode 100644 arch/powerpc/configs/40x/obs600_defconfig

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 59f462b..ffe4d88 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -165,7 +165,7 @@ all: zImage
 
 # With make 3.82 we cannot mix normal and wildcard targets
 BOOT_TARGETS1 := zImage zImage.initrd uImage
-BOOT_TARGETS2 := zImage% dtbImage% treeImage.% cuImage.% simpleImage.%
+BOOT_TARGETS2 := zImage% dtbImage% treeImage.% cuImage.% simpleImage.% uImage.%
 
 PHONY += $(BOOT_TARGETS1) $(BOOT_TARGETS2)
 
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 72ee8c1..80c133c 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -199,6 +199,7 @@ image-$(CONFIG_EP405)			+= dtbImage.ep405
 image-$(CONFIG_HOTFOOT)			+= cuImage.hotfoot
 image-$(CONFIG_WALNUT)			+= treeImage.walnut
 image-$(CONFIG_ACADIA)			+= cuImage.acadia
+image-$(CONFIG_OBS600)			+= uImage.obs600
 
 # Board ports in arch/powerpc/platform/44x/Kconfig
 image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
@@ -316,6 +317,12 @@ $(obj)/zImage.iseries: vmlinux
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,uboot)
 
+$(obj)/uImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
+	$(call if_changed,wrap,uboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+
+$(obj)/uImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
+	$(call if_changed,wrap,uboot-$*,,$(obj)/$*.dtb)
+
 $(obj)/cuImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
 	$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
 
diff --git a/arch/powerpc/boot/dts/obs600.dts b/arch/powerpc/boot/dts/obs600.dts
new file mode 100644
index 0000000..daad350
--- /dev/null
+++ b/arch/powerpc/boot/dts/obs600.dts
@@ -0,0 +1,314 @@
+/*
+ * Device Tree Source for PlatHome OpenBlockS 600 (405EX)
+ *
+ * Copyright 2011 Ben Herrenschmidt, IBM Corp.
+ *
+ * Based on Kilauea by:
+ *
+ * Copyright 2007-2009 DENX Software Engineering, Stefan Roese <sr@denx.de>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	model = "PlatHome,OpenBlockS 600";
+	compatible = "plathome,obs600";
+	dcr-parent = <&{/cpus/cpu@0}>;
+
+	aliases {
+		ethernet0 = &EMAC0;
+		ethernet1 = &EMAC1;
+		serial0 = &UART0;
+		serial1 = &UART1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			model = "PowerPC,405EX";
+			reg = <0x00000000>;
+			clock-frequency = <0>; /* Filled in by U-Boot */
+			timebase-frequency = <0>; /* Filled in by U-Boot */
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <16384>; /* 16 kB */
+			d-cache-size = <16384>; /* 16 kB */
+			dcr-controller;
+			dcr-access-method = "native";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000>; /* Filled in by U-Boot */
+	};
+
+	UIC0: interrupt-controller {
+		compatible = "ibm,uic-405ex", "ibm,uic";
+		interrupt-controller;
+		cell-index = <0>;
+		dcr-reg = <0x0c0 0x009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+	};
+
+	UIC1: interrupt-controller1 {
+		compatible = "ibm,uic-405ex","ibm,uic";
+		interrupt-controller;
+		cell-index = <1>;
+		dcr-reg = <0x0d0 0x009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
+		interrupt-parent = <&UIC0>;
+	};
+
+	UIC2: interrupt-controller2 {
+		compatible = "ibm,uic-405ex","ibm,uic";
+		interrupt-controller;
+		cell-index = <2>;
+		dcr-reg = <0x0e0 0x009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupts = <0x1c 0x4 0x1d 0x4>; /* cascade */
+		interrupt-parent = <&UIC0>;
+	};
+
+	CPM0: cpm {
+		compatible = "ibm,cpm";
+		dcr-access-method = "native";
+		dcr-reg = <0x0b0 0x003>;
+		unused-units = <0x00000000>;
+		idle-doze = <0x02000000>;
+		standby = <0xe3e74800>;
+	};
+
+	plb {
+		compatible = "ibm,plb-405ex", "ibm,plb4";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <0>; /* Filled in by U-Boot */
+
+		SDRAM0: memory-controller {
+			compatible = "ibm,sdram-405ex", "ibm,sdram-4xx-ddr2";
+			dcr-reg = <0x010 0x002>;
+			interrupt-parent = <&UIC2>;
+			interrupts = <0x5 0x4	/* ECC DED Error */ 
+				      0x6 0x4>;	/* ECC SEC Error */ 
+		};
+
+		CRYPTO: crypto@ef700000 {
+			compatible = "amcc,ppc405ex-crypto", "amcc,ppc4xx-crypto";
+			reg = <0xef700000 0x80400>;
+			interrupt-parent = <&UIC0>;
+			interrupts = <0x17 0x2>;
+		};
+
+		MAL0: mcmal {
+			compatible = "ibm,mcmal-405ex", "ibm,mcmal2";
+			dcr-reg = <0x180 0x062>;
+			num-tx-chans = <2>;
+			num-rx-chans = <2>;
+			interrupt-parent = <&MAL0>;
+			interrupts = <0x0 0x1 0x2 0x3 0x4>;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = </*TXEOB*/ 0x0 &UIC0 0xa 0x4
+					/*RXEOB*/ 0x1 &UIC0 0xb 0x4
+					/*SERR*/  0x2 &UIC1 0x0 0x4
+					/*TXDE*/  0x3 &UIC1 0x1 0x4
+					/*RXDE*/  0x4 &UIC1 0x2 0x4>;
+			interrupt-map-mask = <0xffffffff>;
+		};
+
+		POB0: opb {
+			compatible = "ibm,opb-405ex", "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x80000000 0x80000000 0x10000000
+				  0xef600000 0xef600000 0x00a00000
+				  0xf0000000 0xf0000000 0x10000000>;
+			dcr-reg = <0x0a0 0x005>;
+			clock-frequency = <0>; /* Filled in by U-Boot */
+
+			EBC0: ebc {
+				compatible = "ibm,ebc-405ex", "ibm,ebc";
+				dcr-reg = <0x012 0x002>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				clock-frequency = <0>; /* Filled in by U-Boot */
+				/* ranges property is supplied by U-Boot */
+				interrupts = <0x5 0x1>;
+				interrupt-parent = <&UIC1>;
+
+				nor_flash@0,0 {
+					compatible = "amd,s29gl512n", "cfi-flash";
+					bank-width = <2>;
+					reg = <0x00000000 0x00000000 0x08000000>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					partition@0 {
+						label = "kernel + initrd";
+						reg = <0x00000000 0x03de0000>;
+					};
+					partition@3de0000 {
+						label = "user config area";
+						reg = <0x03de0000 0x00080000>;
+					};
+					partition@3e60000 {
+						label = "user program area";
+						reg = <0x03e60000 0x04000000>;
+					};
+					partition@7e60000 {
+						label = "flat device tree";
+						reg = <0x07e60000 0x00080000>;
+					};
+					partition@7ee0000 {
+						label = "test program";
+						reg = <0x07ee0000 0x00080000>;
+					};
+					partition@7f60000 {
+						label = "u-boot env";
+						reg = <0x07f60000 0x00040000>;
+					};
+					partition@7fa0000 {
+						label = "u-boot";
+						reg = <0x07fa0000 0x00060000>;
+					};
+				};
+			};
+
+			UART0: serial@ef600200 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <0xef600200 0x00000008>;
+				virtual-reg = <0xef600200>;
+				clock-frequency = <0>; /* Filled in by U-Boot */
+				current-speed = <0>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x1a 0x4>;
+			};
+
+			UART1: serial@ef600300 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <0xef600300 0x00000008>;
+				virtual-reg = <0xef600300>;
+				clock-frequency = <0>; /* Filled in by U-Boot */
+				current-speed = <0>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x1 0x4>;
+			};
+
+			IIC0: i2c@ef600400 {
+				compatible = "ibm,iic-405ex", "ibm,iic";
+				reg = <0xef600400 0x00000014>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x2 0x4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				rtc@68 {
+					compatible = "dallas,ds1340";
+					reg = <0x68>;
+				};
+			};
+
+			IIC1: i2c@ef600500 {
+				compatible = "ibm,iic-405ex", "ibm,iic";
+				reg = <0xef600500 0x00000014>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x7 0x4>;
+			};
+
+			RGMII0: emac-rgmii@ef600b00 {
+				compatible = "ibm,rgmii-405ex", "ibm,rgmii";
+				reg = <0xef600b00 0x00000104>;
+				has-mdio;
+			};
+
+			EMAC0: ethernet@ef600900 {
+				linux,network-index = <0x0>;
+				device_type = "network";
+				compatible = "ibm,emac-405ex", "ibm,emac4sync";
+				interrupt-parent = <&EMAC0>;
+				interrupts = <0x0 0x1>;
+				#interrupt-cells = <1>;
+				#address-cells = <0>;
+				#size-cells = <0>;
+				interrupt-map = </*Status*/ 0x0 &UIC0 0x18 0x4
+						/*Wake*/  0x1 &UIC1 0x1d 0x4>;
+				reg = <0xef600900 0x000000c4>;
+				local-mac-address = [000000000000]; /* Filled in by U-Boot */
+				mal-device = <&MAL0>;
+				mal-tx-channel = <0>;
+				mal-rx-channel = <0>;
+				cell-index = <0>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
+				tx-fifo-size-gige = <16384>;
+				phy-mode = "rgmii";
+				phy-map = <0x00000000>;
+				rgmii-device = <&RGMII0>;
+				rgmii-channel = <0>;
+				has-inverted-stacr-oc;
+				has-new-stacr-staopc;
+			};
+
+			EMAC1: ethernet@ef600a00 {
+				linux,network-index = <0x1>;
+				device_type = "network";
+				compatible = "ibm,emac-405ex", "ibm,emac4sync";
+				interrupt-parent = <&EMAC1>;
+				interrupts = <0x0 0x1>;
+				#interrupt-cells = <1>;
+				#address-cells = <0>;
+				#size-cells = <0>;
+				interrupt-map = </*Status*/ 0x0 &UIC0 0x19 0x4
+						/*Wake*/  0x1 &UIC1 0x1f 0x4>;
+				reg = <0xef600a00 0x000000c4>;
+				local-mac-address = [000000000000]; /* Filled in by U-Boot */
+				mal-device = <&MAL0>;
+				mal-tx-channel = <1>;
+				mal-rx-channel = <1>;
+				cell-index = <1>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
+				tx-fifo-size-gige = <16384>;
+				phy-mode = "rgmii";
+				phy-map = <0x00000000>;
+				rgmii-device = <&RGMII0>;
+				rgmii-channel = <1>;
+				has-inverted-stacr-oc;
+				has-new-stacr-staopc;
+			};
+
+			GPIO: gpio@ef600800 {
+				device_type = "gpio";	
+				compatible = "ibm,gpio-405ex", "ibm,ppc4xx-gpio";
+				reg = <0xef600800 0x50>;
+			};
+		};
+	};
+        chosen {
+                linux,stdout-path = "/plb/opb/serial@ef600200";
+        };
+};
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index c74531a..14cd4bc 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -163,7 +163,7 @@ coff)
     link_address='0x500000'
     pie=
     ;;
-miboot|uboot)
+miboot|uboot*)
     # miboot and U-boot want just the bare bits, not an ELF binary
     ext=bin
     objflags="-O binary"
@@ -291,6 +291,26 @@ uboot)
     fi
     exit 0
     ;;
+uboot-obs600)
+    rm -f "$ofile"
+    # obs600 wants a multi image with an initrd, so we need to put a fake
+    # one in even when building a "normal" image.
+    if [ -n "$initrd" ]; then
+	real_rd="$initrd"
+    else
+	real_rd=`mktemp`
+	echo "\0" >>"$real_rd"
+    fi
+    ${MKIMAGE} -A ppc -O linux -T multi -C gzip -a $membase -e $membase \
+	$uboot_version -d "$vmz":"$real_rd":"$dtb" "$ofile"
+    if [ -z "$initrd" ]; then
+	rm -f "$real_rd"
+    fi
+    if [ -z "$cacheit" ]; then
+	rm -f "$vmz"
+    fi
+    exit 0
+    ;;
 esac
 
 addsec() {
diff --git a/arch/powerpc/configs/40x/obs600_defconfig b/arch/powerpc/configs/40x/obs600_defconfig
new file mode 100644
index 0000000..91c110d
--- /dev/null
+++ b/arch/powerpc/configs/40x/obs600_defconfig
@@ -0,0 +1,83 @@
+CONFIG_40x=y
+CONFIG_EXPERIMENTAL=y
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_EXPERT=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_WALNUT is not set
+CONFIG_OBS600=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_MATH_EMULATION=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_IPV6 is not set
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_CONNECTOR=y
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_OF_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_NDFC=y
+CONFIG_PROC_DEVICETREE=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=35000
+CONFIG_NETDEVICES=y
+CONFIG_IBM_EMAC=y
+CONFIG_IBM_EMAC_RXB=256
+CONFIG_IBM_EMAC_TXB=256
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_IBM_IIC=y
+CONFIG_SENSORS_LM75=y
+CONFIG_THERMAL=y
+# CONFIG_USB_SUPPORT is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
+CONFIG_EXT2_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_CRAMFS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_ROOT_NFS=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_SYSCTL_SYSCALL_CHECK=y
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_PCBC=y
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index 1530229..bac24a0 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -100,6 +100,16 @@ config XILINX_VIRTEX_GENERIC_BOARD
 	  Most Virtex designs should use this unless it needs to do some
 	  special configuration at board probe time.
 
+config OBS600
+	bool "OpenBlockS 600"
+	depends on 40x
+	default n
+	select 405EX
+	select PPC40x_SIMPLE
+	help
+	  This option enables support for PlatHome OpenBlockS 600 server
+
+
 config PPC40x_SIMPLE
 	bool "Simple PowerPC 40x board support"
 	depends on 40x
diff --git a/arch/powerpc/platforms/40x/ppc40x_simple.c b/arch/powerpc/platforms/40x/ppc40x_simple.c
index e8dd5c5..ecac237 100644
--- a/arch/powerpc/platforms/40x/ppc40x_simple.c
+++ b/arch/powerpc/platforms/40x/ppc40x_simple.c
@@ -55,7 +55,8 @@ static const char *board[] __initdata = {
 	"amcc,haleakala",
 	"amcc,kilauea",
 	"amcc,makalu",
-	"est,hotfoot"
+	"est,hotfoot",
+	"plathome,obs600"
 };
 
 static int __init ppc40x_probe(void)
