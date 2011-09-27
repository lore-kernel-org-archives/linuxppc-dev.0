Return-Path: <holger.brunck@keymile.com>
Received: from mail.de.keymile.com (mail.de.keymile.com [195.8.104.1])
	by ozlabs.org (Postfix) with SMTP id 33A3BB6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Sep 2011 17:55:25 +1000 (EST)
From: Holger Brunck <holger.brunck@keymile.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/82xx: updates for mgcoge
Date: Tue, 27 Sep 2011 09:44:50 +0200
Message-Id: <1317109490-4449-1-git-send-email-holger.brunck@keymile.com>
Cc: Holger Brunck <holger.brunck@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add:
 - Setup dts node for USB
 - pin description and setup for SMC1 (serial interface)

Update and cleanup mgcoge_defconfig:
- enable: TIPC, UBIFS, USB_GADGET driver, SQUASHFS, HIGHRES timers
          POSIX_MQUEUE, EMBEDDED
- disable: EXT3, PPC_PMAC

Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
Acked-by: Heiko Schocher <hs@denx.de>
cc: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mgcoge.dts      |    9 +++++++++
 arch/powerpc/configs/mgcoge_defconfig |   27 ++++++++++++++++-----------
 arch/powerpc/platforms/82xx/km82xx.c  |    4 ++++
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/boot/dts/mgcoge.dts b/arch/powerpc/boot/dts/mgcoge.dts
index 1360d2f..ededaf5 100644
--- a/arch/powerpc/boot/dts/mgcoge.dts
+++ b/arch/powerpc/boot/dts/mgcoge.dts
@@ -213,6 +213,15 @@
 				linux,network-index = <2>;
 				fsl,cpm-command = <0x16200300>;
 			};
+
+			usb@11b60 {
+				compatible = "fsl,mpc8272-cpm-usb";
+				mode = "peripheral";
+				reg = <0x11b60 0x40 0x8b00 0x100>;
+				interrupts = <11 8>;
+				interrupt-parent = <&PIC>;
+				usb-clock = <5>;
+			};
 		};
 
 		cpm2_pio_c: gpio-controller@10d40 {
diff --git a/arch/powerpc/configs/mgcoge_defconfig b/arch/powerpc/configs/mgcoge_defconfig
index 6cb588a..0d36b0e 100644
--- a/arch/powerpc/configs/mgcoge_defconfig
+++ b/arch/powerpc/configs/mgcoge_defconfig
@@ -1,15 +1,22 @@
+CONFIG_EXPERIMENTAL=y
+# CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
 CONFIG_SPARSE_IRQ=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_EXPERT=y
+# CONFIG_RD_GZIP is not set
 CONFIG_KALLSYMS_ALL=y
+# CONFIG_PCSPKR_PLATFORM is not set
+CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
 # CONFIG_IOSCHED_CFQ is not set
+# CONFIG_PPC_PMAC is not set
 CONFIG_PPC_82xx=y
 CONFIG_MGCOGE=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BINFMT_MISC=y
 # CONFIG_SECCOMP is not set
 CONFIG_NET=y
@@ -24,11 +31,10 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
+CONFIG_TIPC=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
-CONFIG_MTD_CONCAT=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLKDEVS=y
@@ -42,7 +48,6 @@ CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
-# CONFIG_MACINTOSH_DRIVERS is not set
 CONFIG_NETDEVICES=y
 CONFIG_FIXED_PHY=y
 CONFIG_NET_ETHERNET=y
@@ -50,6 +55,7 @@ CONFIG_FS_ENET=y
 CONFIG_FS_ENET_MDIO_FCC=y
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
+# CONFIG_WLAN is not set
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
@@ -57,24 +63,24 @@ CONFIG_SERIAL_CPM=y
 CONFIG_SERIAL_CPM_CONSOLE=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
-# CONFIG_I2C_POWERMAC is not set
 CONFIG_I2C_CPM=y
 # CONFIG_HWMON is not set
-# CONFIG_USB_SUPPORT is not set
+CONFIG_USB_GADGET=y
+CONFIG_USB_FSL_USB2=y
+CONFIG_USB_G_SERIAL=y
+CONFIG_UIO=y
+CONFIG_UIO_PDRV=y
 CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-# CONFIG_EXT3_FS_XATTR is not set
 CONFIG_AUTOFS4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=y
+CONFIG_SQUASHFS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_PARTITION_ADVANCED=y
-# CONFIG_MAC_PARTITION is not set
 CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
@@ -82,7 +88,6 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_INFO=y
 CONFIG_SYSCTL_SYSCALL_CHECK=y
diff --git a/arch/powerpc/platforms/82xx/km82xx.c b/arch/powerpc/platforms/82xx/km82xx.c
index 428c5e0..3661bcd 100644
--- a/arch/powerpc/platforms/82xx/km82xx.c
+++ b/arch/powerpc/platforms/82xx/km82xx.c
@@ -49,6 +49,9 @@ struct cpm_pin {
 };
 
 static __initdata struct cpm_pin km82xx_pins[] = {
+	/* SMC1 */
+	{2, 4, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 5, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
 
 	/* SMC2 */
 	{0, 8, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
@@ -137,6 +140,7 @@ static void __init init_ioports(void)
 	}
 
 	cpm2_smc_clk_setup(CPM_CLK_SMC2, CPM_BRG8);
+	cpm2_smc_clk_setup(CPM_CLK_SMC1, CPM_BRG7);
 	cpm2_clk_setup(CPM_CLK_SCC1, CPM_CLK11, CPM_CLK_RX);
 	cpm2_clk_setup(CPM_CLK_SCC1, CPM_CLK11, CPM_CLK_TX);
 	cpm2_clk_setup(CPM_CLK_SCC3, CPM_CLK5, CPM_CLK_RTX);
-- 
1.7.1
