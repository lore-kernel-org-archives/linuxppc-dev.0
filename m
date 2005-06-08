Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.201])
	by ozlabs.org (Postfix) with ESMTP id 6326867A64
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 09:51:58 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so660009wri
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 08 Jun 2005 16:51:56 -0700 (PDT)
Message-ID: <528646bc05060816514c2d5860@mail.gmail.com>
Date: Wed, 8 Jun 2005 17:51:56 -0600
From: Grant Likely <glikely@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: MPC52xx: sysfs failure on adding new device driver
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm working on an MPC52xx SPI device driver using one of the PSC.=20
However, when I call driver_register() I get a failure (-17, EEXISTS)
with a traceback (posted below).

I've tracked it down to failing when trying to create a sysfs entry
for the driver.  It fails because sysfs tries to create a directory
that already exists (mpc52xx_psc).  The directory was already created
when the psc serial port device driver was registered.

>From what I can tell, I should be able to register more than one
driver for a particular device name (mpc52xx_psc).  Otherwise I would
need to change arch/ppc/syslib/mpc52xx_devices.c to have a different
name for each psc.  If I change the sysfs code to ignore the failure
to create a directory then the driver seems to register fine.

I've attached a simple patch that reproduces the problem with stock
linux-2.6.12-rc6.  Am I doing something wrong here or is this a bug in
the sysfs code for the platform bus?

Thanks in advance,
g.
----------------------------------------------------------
Patch follows:
----------------------------------------------------------
diff -ruN linux-2.6.11.orig/.config linux-2.6.11/.config
--- linux-2.6.11.orig/.config   2005-06-08 17:22:48.000000000 -0600
+++ linux-2.6.11/.config        2005-06-08 17:29:56.000000000 -0600
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.12-rc6
-# Wed Jun  8 17:22:48 2005
+# Wed Jun  8 17:29:56 2005
 #
 CONFIG_MMU=3Dy
 CONFIG_GENERIC_HARDIRQS=3Dy
@@ -460,6 +460,12 @@
 # CONFIG_INFINIBAND is not set

 #
+# SPI support
+#
+CONFIG_SPI=3Dy
+CONFIG_SPI_MPC52XX_PSC=3Dy
+
+#
 # File systems
 #
 # CONFIG_EXT2_FS is not set
diff -ruN linux-2.6.11.orig/.config.old linux-2.6.11/.config.old
--- linux-2.6.11.orig/.config.old       2005-06-08 17:22:31.000000000 -0600
+++ linux-2.6.11/.config.old    2005-06-08 17:22:48.000000000 -0600
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-rc2
-# Thu May 19 12:30:43 2005
+# Linux kernel version: 2.6.12-rc6
+# Wed Jun  8 17:22:48 2005
 #
 CONFIG_MMU=3Dy
 CONFIG_GENERIC_HARDIRQS=3Dy
@@ -11,6 +11,7 @@
 CONFIG_PPC=3Dy
 CONFIG_PPC32=3Dy
 CONFIG_GENERIC_NVRAM=3Dy
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=3Dy

 #
 # Code maturity level options
@@ -35,6 +36,8 @@
 CONFIG_KALLSYMS=3Dy
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=3Dy
+CONFIG_BUG=3Dy
 CONFIG_BASE_FULL=3Dy
 CONFIG_FUTEX=3Dy
 CONFIG_EPOLL=3Dy
@@ -62,6 +65,7 @@
 # CONFIG_POWER4 is not set
 # CONFIG_8xx is not set
 # CONFIG_E500 is not set
+CONFIG_PPC_FPU=3Dy
 # CONFIG_ALTIVEC is not set
 # CONFIG_TAU is not set
 # CONFIG_CPU_FREQ is not set
@@ -110,6 +114,7 @@
 CONFIG_BINFMT_ELF=3Dy
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_CMDLINE_BOOL is not set
+CONFIG_ISA_DMA_API=3Dy

 #
 # Bus options
@@ -347,7 +352,6 @@
 # CONFIG_SERIO_LIBPS2 is not set
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=3Dy

 #
 # Character devices
diff -ruN linux-2.6.11.orig/.version linux-2.6.11/.version
--- linux-2.6.11.orig/.version  2005-06-08 17:24:33.000000000 -0600
+++ linux-2.6.11/.version       2005-06-08 17:30:04.000000000 -0600
@@ -1 +1 @@
-1
+2
Files linux-2.6.11.orig/arch/ppc/boot/images/uImage and
linux-2.6.11/arch/ppc/boot/images/uImage differ
Files linux-2.6.11.orig/arch/ppc/boot/images/vmlinux.bin and
linux-2.6.11/arch/ppc/boot/images/vmlinux.bin differ
Files linux-2.6.11.orig/arch/ppc/boot/images/vmlinux.gz and
linux-2.6.11/arch/ppc/boot/images/vmlinux.gz differ
diff -ruN linux-2.6.11.orig/drivers/Kconfig linux-2.6.11/drivers/Kconfig
--- linux-2.6.11.orig/drivers/Kconfig   2005-03-02 00:38:26.000000000 -0700
+++ linux-2.6.11/drivers/Kconfig        2005-06-08 17:27:23.000000000 -0600
@@ -58,4 +58,6 @@

 source "drivers/infiniband/Kconfig"

+source "drivers/spi/Kconfig"
+
 endmenu
diff -ruN linux-2.6.11.orig/drivers/Makefile linux-2.6.11/drivers/Makefile
--- linux-2.6.11.orig/drivers/Makefile  2005-06-08 17:22:08.000000000 -0600
+++ linux-2.6.11/drivers/Makefile       2005-06-08 17:27:13.000000000 -0600
@@ -64,3 +64,4 @@
 obj-$(CONFIG_BLK_DEV_SGIIOC4)  +=3D sn/
 obj-y                          +=3D firmware/
 obj-$(CONFIG_CRYPTO)           +=3D crypto/
+obj-$(CONFIG_SPI)              +=3D spi/
diff -ruN linux-2.6.11.orig/drivers/spi/Kconfig
linux-2.6.11/drivers/spi/Kconfig---
linux-2.6.11.orig/drivers/spi/Kconfig       1969-12-31
17:00:00.000000000 -0700
+++ linux-2.6.11/drivers/spi/Kconfig    2005-06-08 17:29:37.000000000 -0600
@@ -0,0 +1,19 @@
+#
+# Character device configuration
+#
+
+menu "SPI support"
+
+config SPI
+       tristate "SPI support"
+       ---help---
+         SPI is a serial bus protocol for connecting between ICs
+
+config SPI_MPC52XX_PSC
+       tristate "SPI bus via MPC5xxx PSC port"
+       depends on SPI
+       help
+         Say Y here if you want SPI via an MPC5xxx PSC port.
+
+endmenu
+
diff -ruN linux-2.6.11.orig/drivers/spi/Makefile
linux-2.6.11/drivers/spi/Makefile
--- linux-2.6.11.orig/drivers/spi/Makefile      1969-12-31
17:00:00.000000000 -0700
+++ linux-2.6.11/drivers/spi/Makefile   2005-06-08 17:29:17.000000000 -0600
@@ -0,0 +1,6 @@
+#
+# Makefile for the spi core.
+#
+
+obj-$(CONFIG_SPI_MPC52XX_PSC)  +=3D spi-mpc5xxx-psc.o
+
diff -ruN linux-2.6.11.orig/drivers/spi/spi-mpc5xxx-psc.c
linux-2.6.11/drivers/spi/spi-mpc5xxx-psc.c
--- linux-2.6.11.orig/drivers/spi/spi-mpc5xxx-psc.c     1969-12-31
17:00:00.000000000 -0700
+++ linux-2.6.11/drivers/spi/spi-mpc5xxx-psc.c  2005-06-08
17:29:07.000000000 -0600
@@ -0,0 +1,60 @@
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+
+#include <asm/mpc52xx.h>
+#include <asm/mpc52xx_psc.h>
+
+MODULE_LICENSE("Dual BSD/GPL");
+
+static int __devinit
+spi_mpc52xx_psc_probe(struct device *dev)
+{
+       struct platform_device *pdev =3D to_platform_device(dev);
+       /*struct resource *res =3D pdev->resource;*/
+       int idx =3D pdev->id;
+
+       printk(KERN_ALERT "spi-mpc52xx-psc: probing idx=3D%i\n", idx);
+
+       if (!mpc52xx_match_psc_function(idx, "spi"))
+       {
+               printk(KERN_ALERT "function not matched!\n");
+               return -ENODEV;
+       }
+
+       return 0;
+}
+
+static int
+spi_mpc52xx_psc_remove(struct device *dev)
+{
+       return 0;
+}
+
+static struct device_driver spi_mpc52xx_psc_platform_driver =3D {
+       .name           =3D "mpc52xx-psc",
+       .bus            =3D &platform_bus_type,
+       .probe          =3D spi_mpc52xx_psc_probe,
+       .remove         =3D spi_mpc52xx_psc_remove,
+};
+
+static int __init spi_mpc52xx_psc_init(void)
+{
+       int ret;
+
+       printk(KERN_ALERT "spi_mpc52xx_psc: initializing\n");
+
+       ret =3D driver_register(&spi_mpc52xx_psc_platform_driver);
+       return ret;
+}
+
+static void __exit spi_mpc52xx_psc_exit(void)
+{
+       driver_unregister(&spi_mpc52xx_psc_platform_driver);
+       printk(KERN_ALERT "spi_mpc52xx_psc: exiting\n");
+}
+
+module_init(spi_mpc52xx_psc_init);
+module_exit(spi_mpc52xx_psc_exit);
diff -ruN linux-2.6.11.orig/include/config/spi/mpc52xx/psc.h
linux-2.6.11/include/config/spi/mpc52xx/psc.h
--- linux-2.6.11.orig/include/config/spi/mpc52xx/psc.h  1969-12-31
17:00:00.000000000 -0700
+++ linux-2.6.11/include/config/spi/mpc52xx/psc.h       2005-06-08
17:29:56.000000000 -0600
@@ -0,0 +1 @@
+#define CONFIG_SPI_MPC52XX_PSC 1
diff -ruN linux-2.6.11.orig/include/config/spi.h
linux-2.6.11/include/config/spi.h
--- linux-2.6.11.orig/include/config/spi.h      1969-12-31
17:00:00.000000000 -0700
+++ linux-2.6.11/include/config/spi.h   2005-06-08 17:29:56.000000000 -0600
@@ -0,0 +1 @@
+#define CONFIG_SPI 1
diff -ruN linux-2.6.11.orig/include/linux/autoconf.h
linux-2.6.11/include/linux/autoconf.h
--- linux-2.6.11.orig/include/linux/autoconf.h  2005-06-08
17:22:48.000000000 -0600
+++ linux-2.6.11/include/linux/autoconf.h       2005-06-08
17:29:56.000000000 -0600
@@ -1,7 +1,7 @@
 /*
  * Automatically generated C config: don't edit
  * Linux kernel version: 2.6.12-rc6
- * Wed Jun  8 17:22:48 2005
+ * Wed Jun  8 17:29:56 2005
  */
 #define AUTOCONF_INCLUDED
 #define CONFIG_MMU 1
@@ -461,6 +461,12 @@
 #undef CONFIG_INFINIBAND

 /*
+ * SPI support
+ */
+#define CONFIG_SPI 1
+#define CONFIG_SPI_MPC52XX_PSC 1
+
+/*
  * File systems
  */
 #undef CONFIG_EXT2_FS


----------------------------------------------------------
Boot log follows:
----------------------------------------------------------

## Booting image at 00100000 ...
   Image Name:   Linux-2.6.12-rc6-lite5200
   Created:      2005-06-08  23:30:09 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    571225 Bytes =3D 557.8 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
arch: exit
Linux version 2.6.12-rc6-lite5200 (glikely@trillian) (gcc version 3.4.3) #2=
 Wed
Jun 8 17:30:04 MDT 2005
Built 1 zonelists
Kernel command line: console=3DttyS0,115200
mtdparts=3Dphys_mapped_flash:14M(jffs2),1M(kernel),1M(boot)
root=3D/dev/mtdblock0 rootfstype=3Djffs2 rw
PID hash table entries: 512 (order: 9, 8192 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 63616k available (908k kernel code, 256k data, 72k init, 0k highmem=
)
Mount-cache hash table entries: 512
Linux NoNET1.0 for Linux 2.6

PCI: Probing PCI hardware
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
Serial: MPC52xx PSC driver
ttyS0 at MMIO 0xf0002000 (irq =3D 39) is a MPC52xx PSC
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
physmap flash device: 1000000 at ff000000
phys_mapped_flash: Found 1 x8 devices at 0x0 in 8-bit bank
phys_mapped_flash: Found 1 x8 devices at 0x800000 in 8-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
phys_mapped_flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 2
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
3 cmdlinepart partitions found on MTD device phys_mapped_flash
Creating 3 MTD partitions on "phys_mapped_flash":
0x00000000-0x00e00000 : "jffs2"
0x00e00000-0x00f00000 : "kernel"
0x00f00000-0x01000000 : "boot"
mice: PS/2 mouse device common for all mice
spi_mpc52xx_psc: initializing
kobject_register failed for mpc52xx-psc (-17)
Call trace:
 [c0099128] kobject_register+0x60/0x78
 [c00bc5ac] bus_add_driver+0x78/0x178
 [c00bccc8] driver_register+0x30/0x40
 [c0125b90] spi_mpc52xx_psc_init+0x24/0x34
 [c0003944] init+0x7c/0x22c
 [c0006a04] kernel_thread+0x44/0x60
VFS: Mounted root (jffs2 filesystem).
Freeing unused kernel memory: 72k init
ifconfig: socket: Function not implemented
route: socket: Function not implemented
/etc/rcS: 7: /usr/sbin/telnetd: not f\uffff

BusyBox v1.00 (2005.05.19-06:22+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

/ #
