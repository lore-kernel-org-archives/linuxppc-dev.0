Return-Path: <tmarri@amcc.com>
Received: from denmail01.apm.COM (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8B54AB6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Sep 2010 09:26:19 +1000 (EST)
From: tmarri@apm.com
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] APM821xx: Add support for new SoC APM821xx
Date: Mon, 13 Sep 2010 16:26:11 -0700
Message-Id: <1284420371-13519-1-git-send-email-tmarri@apm.com>
Cc: tmarri@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tirumala Marri <tmarri@apm.com>

This patch adds CPU, device tree, defconfig and bluestone board
support for APM821xx SoC.

Signed-off-by: Tirumala R Marri <tmarri@apm.com>
---
V1:
  * CPU name changed to 464.
  * defconfig is created using "make savedefconfig".
V2:
  * CPU name changed back to apm821xx for now.
  * some white space problem in device tree.
---
 arch/powerpc/boot/dts/bluestone.dts          |  254 ++++++++++++++++++++++++++
 arch/powerpc/configs/44x/bluestone_defconfig |   68 +++++++
 arch/powerpc/kernel/cpu_setup_44x.S          |    1 +
 arch/powerpc/kernel/cputable.c               |   15 ++
 arch/powerpc/platforms/44x/Kconfig           |   16 ++
 arch/powerpc/platforms/44x/ppc44x_simple.c   |    1 +
 6 files changed, 355 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/bluestone.dts
 create mode 100644 arch/powerpc/configs/44x/bluestone_defconfig

diff --git a/arch/powerpc/boot/dts/bluestone.dts b/arch/powerpc/boot/dts/bluestone.dts
new file mode 100644
index 0000000..9bb3d72
--- /dev/null
+++ b/arch/powerpc/boot/dts/bluestone.dts
@@ -0,0 +1,254 @@
+/*
+ * Device Tree for Bluestone (APM821xx) board.
+ *
+ * Copyright (c) 2010, Applied Micro Circuits Corporation
+ * Author: Tirumala R Marri <tmarri@apm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ *
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	model = "apm,bluestone";
+	compatible = "apm,bluestone";
+	dcr-parent = <&{/cpus/cpu@0}>;
+
+	aliases {
+		ethernet0 = &EMAC0;
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
+			model = "PowerPC,apm821xx";
+			reg = <0x00000000>;
+			clock-frequency = <0>; /* Filled in by U-Boot */
+			timebase-frequency = <0>; /* Filled in by U-Boot */
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+			dcr-controller;
+			dcr-access-method = "native";
+			next-level-cache = <&L2C0>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000>; /* Filled in by U-Boot */
+	};
+
+	UIC0: interrupt-controller0 {
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <0>;
+		dcr-reg = <0x0c0 0x009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+	};
+
+	UIC1: interrupt-controller1 {
+		compatible = "ibm,uic";
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
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <2>;
+		dcr-reg = <0x0e0 0x009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupts = <0xa 0x4 0xb 0x4>; /* cascade */
+		interrupt-parent = <&UIC0>;
+	};
+
+	UIC3: interrupt-controller3 {
+		compatible = "ibm,uic";
+		interrupt-controller;
+		cell-index = <3>;
+		dcr-reg = <0x0f0 0x009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupts = <0x10 0x4 0x11 0x4>; /* cascade */
+		interrupt-parent = <&UIC0>;
+	};
+
+	SDR0: sdr {
+		compatible = "ibm,sdr-apm821xx";
+		dcr-reg = <0x00e 0x002>;
+	};
+
+	CPR0: cpr {
+		compatible = "ibm,cpr-apm821xx";
+		dcr-reg = <0x00c 0x002>;
+	};
+
+	plb {
+		compatible = "ibm,plb4";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <0>; /* Filled in by U-Boot */
+
+		SDRAM0: sdram {
+			compatible = "ibm,sdram-apm821xx";
+			dcr-reg = <0x010 0x002>;
+		};
+
+		MAL0: mcmal {
+			compatible = "ibm,mcmal2";
+			descriptor-memory = "ocm";
+			dcr-reg = <0x180 0x062>;
+			num-tx-chans = <1>;
+			num-rx-chans = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-parent = <&UIC2>;
+			interrupts = <	/*TXEOB*/ 0x6 0x4
+					/*RXEOB*/ 0x7 0x4
+					/*SERR*/  0x3 0x4
+					/*TXDE*/  0x4 0x4
+					/*RXDE*/  0x5 0x4
+		};
+
+		POB0: opb {
+			compatible = "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xb0000000 0x00000004 0xb0000000 0x50000000>;
+			clock-frequency = <0>; /* Filled in by U-Boot */
+
+			EBC0: ebc {
+				compatible = "ibm,ebc";
+				dcr-reg = <0x012 0x002>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				clock-frequency = <0>; /* Filled in by U-Boot */
+				/* ranges property is supplied by U-Boot */
+				ranges = < 0x00000003 0x00000000 0xe0000000 0x8000000>;
+				interrupts = <0x6 0x4>;
+				interrupt-parent = <&UIC1>;
+
+				nor_flash@0,0 {
+					compatible = "amd,s29gl512n", "cfi-flash";
+					bank-width = <2>;
+					reg = <0x00000000 0x00000000 0x00400000>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					partition@0 {
+						label = "kernel";
+						reg = <0x00000000 0x00180000>;
+					};
+					partition@180000 {
+						label = "env";
+						reg = <0x00180000 0x00020000>;
+					};
+					partition@1a0000 {
+						label = "u-boot";
+						reg = <0x001a0000 0x00060000>;
+					};
+				};
+			}
+
+			UART0: serial@ef600300 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <0xef600300 0x00000008>;
+				virtual-reg = <0xef600300>;
+				clock-frequency = <0>; /* Filled in by U-Boot */
+				current-speed = <0>; /* Filled in by U-Boot */
+				interrupt-parent = <&UIC1>;
+				interrupts = <0x1 0x4>;
+			};
+
+			IIC0: i2c@ef600700 {
+				compatible = "ibm,iic";
+				reg = <0xef600700 0x00000014>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x2 0x4>;
+			};
+
+			IIC1: i2c@ef600800 {
+				compatible = "ibm,iic";
+				reg = <0xef600800 0x00000014>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x3 0x4>;
+			};
+
+			RGMII0: emac-rgmii@ef601500 {
+				compatible = "ibm,rgmii";
+				reg = <0xef601500 0x00000008>;
+				has-mdio;
+			};
+
+			TAH0: emac-tah@ef601350 {
+				compatible = "ibm,tah";
+				reg = <0xef601350 0x00000030>;
+			};
+
+			EMAC0: ethernet@ef600c00 {
+				device_type = "network";
+				compatible = "ibm,emac4sync";
+				interrupt-parent = <&EMAC0>;
+				interrupts = <0x0 0x1>;
+				#interrupt-cells = <1>;
+				#address-cells = <0>;
+				#size-cells = <0>;
+				interrupt-map = </*Status*/ 0x0 &UIC2 0x10 0x4
+						 /*Wake*/   0x1 &UIC2 0x14 0x4>;
+				reg = <0xef600c00 0x000000c4>;
+				local-mac-address = [000000000000]; /* Filled in by U-Boot */
+				mal-device = <&MAL0>;
+				mal-tx-channel = <0>;
+				mal-rx-channel = <0>;
+				cell-index = <0>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <16384>;
+				tx-fifo-size = <2048>;
+				phy-mode = "rgmii";
+				phy-map = <0x00000000>;
+				rgmii-device = <&RGMII0>;
+				rgmii-channel = <0>;
+				tah-device = <&TAH0>;
+				tah-channel = <0>;
+				has-inverted-stacr-oc;
+				has-new-stacr-staopc;
+			};
+		};
+
+	};
+};
diff --git a/arch/powerpc/configs/44x/bluestone_defconfig b/arch/powerpc/configs/44x/bluestone_defconfig
new file mode 100644
index 0000000..ac65b48
--- /dev/null
+++ b/arch/powerpc/configs/44x/bluestone_defconfig
@@ -0,0 +1,68 @@
+CONFIG_44x=y
+CONFIG_EXPERIMENTAL=y
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_PCI_QUIRKS is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_BLUESTONE=y
+# CONFIG_EBONY is not set
+# CONFIG_KVM_GUEST is not set
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_SPARSE_IRQ=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE=""
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_CONNECTOR=y
+CONFIG_MTD=y
+CONFIG_MTD_PARTITIONS=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_OF_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_PROC_DEVICETREE=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=35000
+CONFIG_NETDEVICES=y
+CONFIG_NET_ETHERNET=y
+CONFIG_IBM_NEW_EMAC=y
+CONFIG_IBM_NEW_EMAC_RXB=256
+CONFIG_IBM_NEW_EMAC_TXB=256
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_IBM_IIC=y
+CONFIG_SENSORS_AD7414=y
+# CONFIG_HID_SUPPORT is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_M41T80=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_CRAMFS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_ROOT_NFS=y
+CONFIG_NLS=y
diff --git a/arch/powerpc/kernel/cpu_setup_44x.S b/arch/powerpc/kernel/cpu_setup_44x.S
index 7d606f8..e32b4a9 100644
--- a/arch/powerpc/kernel/cpu_setup_44x.S
+++ b/arch/powerpc/kernel/cpu_setup_44x.S
@@ -35,6 +35,7 @@ _GLOBAL(__setup_cpu_440grx)
 _GLOBAL(__setup_cpu_460ex)
 _GLOBAL(__setup_cpu_460gt)
 _GLOBAL(__setup_cpu_460sx)
+_GLOBAL(__setup_cpu_apm821xx)
 	mflr	r4
 	bl	__init_fpu_44x
 	bl	__fixup_440A_mcheck
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 1f9123f..b7ac795 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -48,6 +48,7 @@ extern void __setup_cpu_440x5(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_460ex(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_460gt(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_460sx(unsigned long offset, struct cpu_spec *spec);
+extern void __setup_cpu_apm821xx(unsigned long offset, struct cpu_spec *spec);
 extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_750(unsigned long offset, struct cpu_spec* spec);
@@ -1805,6 +1806,20 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
+	{ /* 464 in APM821xx */
+		.pvr_mask		= 0xffffff00,
+		.pvr_value		= 0x12C41C80,
+		.cpu_name		= "APM821XX",
+		.cpu_features		= CPU_FTRS_44X,
+		.cpu_user_features	= COMMON_USER_BOOKE |
+			PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_44x,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_apm821xx,
+		.machine_check		= machine_check_440A,
+		.platform		= "ppc440",
+	},
 	{ /* 476 core */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x11a50000,
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 69d668c..0f979c5 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -17,6 +17,16 @@ config BAMBOO
 	help
 	  This option enables support for the IBM PPC440EP evaluation board.
 
+config BLUESTONE
+	bool "Bluestone"
+	depends on 44x
+	default n
+	select PPC44x_SIMPLE
+	select APM821xx
+	select IBM_NEW_EMAC_RGMII
+	help
+	  This option enables support for the APM APM821xx Evaluation board.
+
 config EBONY
 	bool "Ebony"
 	depends on 44x
@@ -293,6 +303,12 @@ config 460SX
 	select IBM_NEW_EMAC_ZMII
 	select IBM_NEW_EMAC_TAH
 
+config APM821xx
+	bool
+	select PPC_FPU
+	select IBM_NEW_EMAC_EMAC4
+	select IBM_NEW_EMAC_TAH
+
 # 44x errata/workaround config symbols, selected by the CPU models above
 config IBM440EP_ERR42
 	bool
diff --git a/arch/powerpc/platforms/44x/ppc44x_simple.c b/arch/powerpc/platforms/44x/ppc44x_simple.c
index 5f7a29d..7ddcba3 100644
--- a/arch/powerpc/platforms/44x/ppc44x_simple.c
+++ b/arch/powerpc/platforms/44x/ppc44x_simple.c
@@ -52,6 +52,7 @@ machine_device_initcall(ppc44x_simple, ppc44x_device_probe);
 static char *board[] __initdata = {
 	"amcc,arches",
 	"amcc,bamboo",
+	"amcc,bluestone",
 	"amcc,canyonlands",
 	"amcc,glacier",
 	"ibm,ebony",
-- 
1.6.1.rc3
