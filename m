Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 04AA2DDDF8
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2008 15:33:16 +1100 (EST)
Date: Mon, 24 Nov 2008 15:33:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] powerpc: update ppc44x_defconfig
Message-Id: <20081124153305.4750234d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This removes CONFIG_PCI_LEGACY (which is not needed) and consequently
several compiler warnings.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/configs/ppc44x_defconfig |   31 +++++++++++++++++++++----------
 1 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/ppc44x_defconfig
index 55edbd5..5c02c8d 100644
--- a/arch/powerpc/configs/ppc44x_defconfig
+++ b/arch/powerpc/configs/ppc44x_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.28-rc2
-# Tue Oct 28 09:28:58 2008
+# Linux kernel version: 2.6.28-rc5
+# Mon Nov 17 17:25:24 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -267,7 +267,7 @@ CONFIG_PCI_SYSCALL=y
 # CONFIG_PCIEPORTBUS is not set
 CONFIG_ARCH_SUPPORTS_MSI=y
 # CONFIG_PCI_MSI is not set
-CONFIG_PCI_LEGACY=y
+# CONFIG_PCI_LEGACY is not set
 # CONFIG_PCI_DEBUG is not set
 # CONFIG_PCCARD is not set
 # CONFIG_HOTPLUG_PCI is not set
@@ -513,8 +513,10 @@ CONFIG_MISC_DEVICES=y
 # CONFIG_EEPROM_93CX6 is not set
 # CONFIG_SGI_IOC4 is not set
 # CONFIG_TIFM_CORE is not set
+# CONFIG_ICS932S401 is not set
 # CONFIG_ENCLOSURE_SERVICES is not set
 # CONFIG_HP_ILO is not set
+# CONFIG_C2PORT is not set
 CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
 
@@ -806,6 +808,11 @@ CONFIG_GPIOLIB=y
 # CONFIG_GPIO_SYSFS is not set
 
 #
+# Memory mapped GPIO expanders:
+#
+# CONFIG_GPIO_XILINX is not set
+
+#
 # I2C GPIO expanders:
 #
 # CONFIG_GPIO_MAX732X is not set
@@ -826,11 +833,11 @@ CONFIG_GPIOLIB=y
 # CONFIG_THERMAL is not set
 # CONFIG_THERMAL_HWMON is not set
 # CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
 # Sonics Silicon Backplane
 #
-CONFIG_SSB_POSSIBLE=y
 # CONFIG_SSB is not set
 
 #
@@ -842,6 +849,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_TMIO is not set
 # CONFIG_MFD_WM8400 is not set
 # CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_REGULATOR is not set
 
 #
 # Multimedia devices
@@ -934,11 +942,11 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_TMC is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may also be needed;
 #
 
 #
-# may also be needed; see USB_STORAGE Help for more information
+# see USB_STORAGE Help for more information
 #
 CONFIG_USB_STORAGE=m
 # CONFIG_USB_STORAGE_DEBUG is not set
@@ -1002,6 +1010,7 @@ CONFIG_USB_STORAGE=m
 # CONFIG_DMADEVICES is not set
 # CONFIG_UIO is not set
 # CONFIG_STAGING is not set
+CONFIG_STAGING_EXCLUDE_BUILD=y
 
 #
 # File systems
@@ -1227,10 +1236,12 @@ CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_LATENCYTOP is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
-CONFIG_NOP_TRACER=y
-CONFIG_HAVE_FTRACE=y
-CONFIG_HAVE_DYNAMIC_FTRACE=y
-# CONFIG_FTRACE is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+
+#
+# Tracers
+#
+# CONFIG_FUNCTION_TRACER is not set
 # CONFIG_SCHED_TRACER is not set
 # CONFIG_CONTEXT_SWITCH_TRACER is not set
 # CONFIG_BOOT_TRACER is not set
-- 
1.5.6.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
