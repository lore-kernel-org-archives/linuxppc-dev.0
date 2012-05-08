Return-Path: <holger.brunck@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.1])
 by ozlabs.org (Postfix) with SMTP id F0798B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2012 00:08:34 +1000 (EST)
From: Holger Brunck <holger.brunck@keymile.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] powerpc/82xx: add SPI support for mgcoge
Date: Tue,  8 May 2012 15:57:22 +0200
Message-Id: <1336485442-24190-4-git-send-email-holger.brunck@keymile.com>
In-Reply-To: <1336485442-24190-1-git-send-email-holger.brunck@keymile.com>
References: <1336485442-24190-1-git-send-email-holger.brunck@keymile.com>
Cc: Heiko Schocher <hs@denx.de>, Holger Brunck <holger.brunck@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add spi support for mgcoge into the platform code and the dts
file. Additionaly SPIDEV is switched on in the defconfig and the
updates for the newer kernel version are committed. The SPI
interface is used to drive the Maxim DS3106 clock chip.

Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
cc: Heiko Schocher <hs@denx.de>
cc: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mgcoge.dts      |   23 +++++++++++++++++++++++
 arch/powerpc/configs/mgcoge_defconfig |   12 ++++--------
 arch/powerpc/platforms/82xx/km82xx.c  |    5 +++++
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/dts/mgcoge.dts b/arch/powerpc/boot/dts/mgcoge.dts
index ededaf5..d72fb5e 100644
--- a/arch/powerpc/boot/dts/mgcoge.dts
+++ b/arch/powerpc/boot/dts/mgcoge.dts
@@ -222,6 +222,29 @@
 				interrupt-parent = <&PIC>;
 				usb-clock = <5>;
 			};
+			spi@11aa0 {
+				cell-index = <0>;
+				compatible = "fsl,spi", "fsl,cpm2-spi";
+				reg = <0x11a80 0x40 0x89fc 0x2>;
+				interrupts = <2 8>;
+				interrupt-parent = <&PIC>;
+				gpios = < &cpm2_pio_d 19 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				ds3106@1 {
+					compatible = "gen,spidev";
+					reg = <0>;
+					spi-max-frequency = <8000000>;
+				};
+			};
+
+		};
+
+		cpm2_pio_d: gpio-controller@10d60 {
+			#gpio-cells = <2>;
+			compatible = "fsl,cpm2-pario-bank";
+			reg = <0x10d60 0x14>;
+			gpio-controller;
 		};
 
 		cpm2_pio_c: gpio-controller@10d40 {
diff --git a/arch/powerpc/configs/mgcoge_defconfig b/arch/powerpc/configs/mgcoge_defconfig
index 0d36b0e..8fa84f1 100644
--- a/arch/powerpc/configs/mgcoge_defconfig
+++ b/arch/powerpc/configs/mgcoge_defconfig
@@ -2,7 +2,6 @@ CONFIG_EXPERIMENTAL=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_SPARSE_IRQ=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -12,6 +11,7 @@ CONFIG_KALLSYMS_ALL=y
 # CONFIG_PCSPKR_PLATFORM is not set
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
+CONFIG_PARTITION_ADVANCED=y
 # CONFIG_IOSCHED_CFQ is not set
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_82xx=y
@@ -49,12 +49,9 @@ CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_NETDEVICES=y
-CONFIG_FIXED_PHY=y
-CONFIG_NET_ETHERNET=y
 CONFIG_FS_ENET=y
 CONFIG_FS_ENET_MDIO_FCC=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
+CONFIG_FIXED_PHY=y
 # CONFIG_WLAN is not set
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
@@ -64,6 +61,8 @@ CONFIG_SERIAL_CPM_CONSOLE=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_CPM=y
+CONFIG_SPI=y
+CONFIG_SPI_FSL_SPI=y
 # CONFIG_HWMON is not set
 CONFIG_USB_GADGET=y
 CONFIG_USB_FSL_USB2=y
@@ -80,8 +79,6 @@ CONFIG_SQUASHFS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
@@ -90,7 +87,6 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_INFO=y
-CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_BDI_SWITCH=y
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
diff --git a/arch/powerpc/platforms/82xx/km82xx.c b/arch/powerpc/platforms/82xx/km82xx.c
index 3661bcd..cf964e1 100644
--- a/arch/powerpc/platforms/82xx/km82xx.c
+++ b/arch/powerpc/platforms/82xx/km82xx.c
@@ -128,6 +128,11 @@ static __initdata struct cpm_pin km82xx_pins[] = {
 	{3, 23, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY}, /* TXP */
 	{3, 24, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY}, /* TXN */
 	{3, 25, CPM_PIN_INPUT  | CPM_PIN_PRIMARY}, /* RXD */
+
+	/* SPI */
+	{3, 16, CPM_PIN_INPUT | CPM_PIN_SECONDARY},/* SPI_MISO PD16 */
+	{3, 17, CPM_PIN_INPUT | CPM_PIN_SECONDARY},/* SPI_MOSI PD17 */
+	{3, 18, CPM_PIN_INPUT | CPM_PIN_SECONDARY},/* SPI_CLK PD18 */
 };
 
 static void __init init_ioports(void)
-- 
1.7.1
