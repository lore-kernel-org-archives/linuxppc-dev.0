From: "Stefan Roese" <stefan.roese@esd-electronics.com>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Cc: "Tom Rini" <trini@kernel.crashing.org>
Subject: [PATCH] CPCI405 ide driver fixed
Date: Thu, 23 Jan 2003 17:25:24 +0100
Message-ID: <EFEAIMDCOOOHIEPHDNFJCENAEOAA.stefan.roese@esd-electronics.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0024_01C2C304.6A3E79C0"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_0024_01C2C304.6A3E79C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello

The attached patch moves the CPCI405 ide-driver to the ppc directory and
fixes a problem with additional (CompactPCI) ide controllers.

- move cpci405ide.c to ppc directory
- fix problem with additional (CompactPCI) ide controllers
- update cpci405_defconfig

Please apply this patch to linuxppc_2_4_devel.

Best regards,
Stefan.


------=_NextPart_000_0024_01C2C304.6A3E79C0
Content-Type: application/octet-stream;
	name="linuxppc_2_4_devel_2.4.21pre3.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linuxppc_2_4_devel_2.4.21pre3.patch"

diff -N -u -r --exclude=3DCVS --exclude=3DLOG =
linuxppc_2_4_devel_2.4.21pre3_orig/arch/ppc/configs/cpci405_defconfig =
linuxppc_2_4_devel_2.4.21pre3/arch/ppc/configs/cpci405_defconfig=0A=
--- =
linuxppc_2_4_devel_2.4.21pre3_orig/arch/ppc/configs/cpci405_defconfig	=
Thu Jan 23 16:35:16 2003=0A=
+++ linuxppc_2_4_devel_2.4.21pre3/arch/ppc/configs/cpci405_defconfig	Thu =
Jan 23 16:30:09 2003=0A=
@@ -32,16 +32,21 @@=0A=
 # CONFIG_PPC_ISERIES is not set=0A=
 CONFIG_4xx=3Dy=0A=
 # CONFIG_PPC_STD_MMU is not set=0A=
+# CONFIG_ARCTIC2 is not set=0A=
 # CONFIG_ASH is not set=0A=
 # CONFIG_CEDER is not set=0A=
+# CONFIG_BEECH is not set=0A=
 CONFIG_CPCI405=3Dy=0A=
 # CONFIG_EP405 is not set=0A=
 # CONFIG_OAK is not set=0A=
 # CONFIG_RAINIER is not set=0A=
 # CONFIG_REDWOOD_4 is not set=0A=
 # CONFIG_REDWOOD_5 is not set=0A=
+# CONFIG_REDWOOD_6 is not set=0A=
+# CONFIG_SYCAMORE is not set=0A=
 # CONFIG_TIVO is not set=0A=
 # CONFIG_WALNUT is not set=0A=
+# CONFIG_XILINX_ML300 is not set=0A=
 # CONFIG_ALL_PPC is not set=0A=
 # CONFIG_SMP is not set=0A=
 # CONFIG_MATH_EMULATION is not set=0A=
@@ -51,10 +56,10 @@=0A=
 # CONFIG_PM is not set=0A=
 CONFIG_UART0_TTYS0=3Dy=0A=
 # CONFIG_UART0_TTYS1 is not set=0A=
+CONFIG_GEN550_KGDB=3Dy=0A=
 CONFIG_IBM405_ERR51=3Dy=0A=
 CONFIG_NOT_COHERENT_CACHE=3Dy=0A=
 # CONFIG_PPC4xx_DMA is not set=0A=
-CONFIG_PPC4xx_EDMA=3Dy=0A=
 CONFIG_OCP_PROC=3Dy=0A=
 =0A=
 #=0A=
@@ -113,6 +118,7 @@=0A=
 CONFIG_BLK_DEV_RAM=3Dy=0A=
 CONFIG_BLK_DEV_RAM_SIZE=3D4096=0A=
 CONFIG_BLK_DEV_INITRD=3Dy=0A=
+# CONFIG_BLK_STATS is not set=0A=
 =0A=
 #=0A=
 # Multi-device support (RAID and LVM)=0A=
@@ -193,32 +199,64 @@=0A=
 CONFIG_BLK_DEV_IDEDISK=3Dy=0A=
 # CONFIG_IDEDISK_MULTI_MODE is not set=0A=
 # CONFIG_IDEDISK_STROKE is not set=0A=
-# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set=0A=
-# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set=0A=
-# CONFIG_BLK_DEV_IDEDISK_IBM is not set=0A=
-# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set=0A=
-# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set=0A=
-# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set=0A=
-# CONFIG_BLK_DEV_IDEDISK_WD is not set=0A=
-# CONFIG_BLK_DEV_COMMERIAL is not set=0A=
-# CONFIG_BLK_DEV_TIVO is not set=0A=
 # CONFIG_BLK_DEV_IDECS is not set=0A=
 # CONFIG_BLK_DEV_IDECD is not set=0A=
 # CONFIG_BLK_DEV_IDETAPE is not set=0A=
 # CONFIG_BLK_DEV_IDEFLOPPY is not set=0A=
 # CONFIG_BLK_DEV_IDESCSI is not set=0A=
 # CONFIG_IDE_TASK_IOCTL is not set=0A=
+# CONFIG_IDE_TASKFILE_IO is not set=0A=
 # CONFIG_BLK_DEV_CMD640 is not set=0A=
 # CONFIG_BLK_DEV_CMD640_ENHANCED is not set=0A=
 # CONFIG_BLK_DEV_ISAPNP is not set=0A=
+CONFIG_BLK_DEV_IDEPCI=3Dy=0A=
+# CONFIG_BLK_DEV_GENERIC is not set=0A=
+# CONFIG_IDEPCI_SHARE_IRQ is not set=0A=
+CONFIG_BLK_DEV_IDEDMA_PCI=3Dy=0A=
+# CONFIG_BLK_DEV_OFFBOARD is not set=0A=
+# CONFIG_BLK_DEV_IDEDMA_FORCED is not set=0A=
+# CONFIG_IDEDMA_PCI_AUTO is not set=0A=
+# CONFIG_IDEDMA_ONLYDISK is not set=0A=
+CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
+# CONFIG_IDEDMA_PCI_WIP is not set=0A=
+CONFIG_BLK_DEV_ADMA=3Dy=0A=
+# CONFIG_BLK_DEV_AEC62XX is not set=0A=
+# CONFIG_BLK_DEV_ALI15X3 is not set=0A=
+# CONFIG_WDC_ALI15X3 is not set=0A=
+# CONFIG_BLK_DEV_AMD74XX is not set=0A=
+# CONFIG_AMD74XX_OVERRIDE is not set=0A=
+# CONFIG_BLK_DEV_CMD64X is not set=0A=
+# CONFIG_BLK_DEV_TRIFLEX is not set=0A=
+# CONFIG_BLK_DEV_CY82C693 is not set=0A=
+# CONFIG_BLK_DEV_CS5530 is not set=0A=
+# CONFIG_BLK_DEV_HPT34X is not set=0A=
+# CONFIG_HPT34X_AUTODMA is not set=0A=
+CONFIG_BLK_DEV_HPT366=3Dy=0A=
+# CONFIG_BLK_DEV_PIIX is not set=0A=
+# CONFIG_BLK_DEV_NFORCE is not set=0A=
+# CONFIG_BLK_DEV_NS87415 is not set=0A=
+# CONFIG_BLK_DEV_OPTI621 is not set=0A=
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set=0A=
+# CONFIG_PDC202XX_BURST is not set=0A=
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set=0A=
+# CONFIG_PDC202XX_FORCE is not set=0A=
 # CONFIG_BLK_DEV_RZ1000 is not set=0A=
-# CONFIG_BLK_DEV_IDEPCI is not set=0A=
+# CONFIG_BLK_DEV_SC1200 is not set=0A=
+# CONFIG_BLK_DEV_SVWKS is not set=0A=
+# CONFIG_BLK_DEV_SIIMAGE is not set=0A=
+# CONFIG_BLK_DEV_SIS5513 is not set=0A=
+# CONFIG_BLK_DEV_SLC90E66 is not set=0A=
+# CONFIG_BLK_DEV_TRM290 is not set=0A=
+# CONFIG_BLK_DEV_VIA82CXXX is not set=0A=
+# CONFIG_BLK_DEV_SL82C105 is not set=0A=
 # CONFIG_IBM_OCP_IDE is not set=0A=
+CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
 CONFIG_BLK_DEV_CPCI405_IDE=3Dy=0A=
 # CONFIG_IDE_CHIPSETS is not set=0A=
 # CONFIG_IDEDMA_AUTO is not set=0A=
+# CONFIG_IDEDMA_IVB is not set=0A=
 # CONFIG_DMA_NONPCI is not set=0A=
-# CONFIG_BLK_DEV_IDE_MODES is not set=0A=
+CONFIG_BLK_DEV_IDE_MODES=3Dy=0A=
 # CONFIG_BLK_DEV_ATARAID is not set=0A=
 # CONFIG_BLK_DEV_ATARAID_PDC is not set=0A=
 # CONFIG_BLK_DEV_ATARAID_HPT is not set=0A=
@@ -277,10 +315,12 @@=0A=
 #=0A=
 # CONFIG_ACENIC is not set=0A=
 # CONFIG_DL2K is not set=0A=
+# CONFIG_E1000 is not set=0A=
 # CONFIG_MYRI_SBUS is not set=0A=
 # CONFIG_NS83820 is not set=0A=
 # CONFIG_HAMACHI is not set=0A=
 # CONFIG_YELLOWFIN is not set=0A=
+# CONFIG_R8169 is not set=0A=
 # CONFIG_SK98LIN is not set=0A=
 # CONFIG_TIGON3 is not set=0A=
 =0A=
@@ -381,8 +421,7 @@=0A=
 CONFIG_I2C=3Dy=0A=
 # CONFIG_I2C_ALGOBIT is not set=0A=
 # CONFIG_I2C_ALGOPCF is not set=0A=
-CONFIG_I2C_IBM_OCP_ALGO=3Dy=0A=
-CONFIG_I2C_IBM_OCP_ADAP=3Dy=0A=
+CONFIG_I2C_IBM_OCP=3Dy=0A=
 CONFIG_I2C_CHARDEV=3Dy=0A=
 CONFIG_I2C_PROC=3Dy=0A=
 =0A=
@@ -402,12 +441,14 @@=0A=
 # Watchdog Cards=0A=
 #=0A=
 # CONFIG_WATCHDOG is not set=0A=
+# CONFIG_SCx200_GPIO is not set=0A=
+# CONFIG_AMD_PM768 is not set=0A=
 # CONFIG_NVRAM is not set=0A=
 # CONFIG_RTC is not set=0A=
 # CONFIG_DTLK is not set=0A=
 # CONFIG_R3964 is not set=0A=
 # CONFIG_APPLICOM is not set=0A=
-# CONFIG_IBM_OCP_GPIO is not set=0A=
+CONFIG_IBM_OCP_GPIO=3Dy=0A=
 =0A=
 #=0A=
 # Ftape, the floppy tape device driver=0A=
@@ -434,6 +475,8 @@=0A=
 # CONFIG_ADFS_FS_RW is not set=0A=
 # CONFIG_AFFS_FS is not set=0A=
 # CONFIG_HFS_FS is not set=0A=
+# CONFIG_BEFS_FS is not set=0A=
+# CONFIG_BEFS_DEBUG is not set=0A=
 # CONFIG_BFS_FS is not set=0A=
 # CONFIG_EXT3_FS is not set=0A=
 # CONFIG_JBD is not set=0A=
@@ -441,7 +484,7 @@=0A=
 CONFIG_FAT_FS=3Dy=0A=
 CONFIG_MSDOS_FS=3Dy=0A=
 # CONFIG_UMSDOS_FS is not set=0A=
-# CONFIG_VFAT_FS is not set=0A=
+CONFIG_VFAT_FS=3Dy=0A=
 # CONFIG_EFS_FS is not set=0A=
 # CONFIG_JFFS_FS is not set=0A=
 # CONFIG_JFFS2_FS is not set=0A=
@@ -451,6 +494,9 @@=0A=
 # CONFIG_ISO9660_FS is not set=0A=
 # CONFIG_JOLIET is not set=0A=
 # CONFIG_ZISOFS is not set=0A=
+# CONFIG_JFS_FS is not set=0A=
+# CONFIG_JFS_DEBUG is not set=0A=
+# CONFIG_JFS_STATISTICS is not set=0A=
 # CONFIG_MINIX_FS is not set=0A=
 # CONFIG_VXFS_FS is not set=0A=
 # CONFIG_NTFS_FS is not set=0A=
@@ -481,6 +527,7 @@=0A=
 CONFIG_ROOT_NFS=3Dy=0A=
 # CONFIG_NFSD is not set=0A=
 # CONFIG_NFSD_V3 is not set=0A=
+# CONFIG_NFSD_TCP is not set=0A=
 CONFIG_SUNRPC=3Dy=0A=
 CONFIG_LOCKD=3Dy=0A=
 CONFIG_LOCKD_V4=3Dy=0A=
@@ -495,7 +542,6 @@=0A=
 # CONFIG_NCPFS_NLS is not set=0A=
 # CONFIG_NCPFS_EXTRAS is not set=0A=
 # CONFIG_ZISOFS_FS is not set=0A=
-# CONFIG_ZLIB_FS_INFLATE is not set=0A=
 =0A=
 #=0A=
 # Partition Types=0A=
@@ -553,7 +599,7 @@=0A=
 # CONFIG_SOUND is not set=0A=
 =0A=
 #=0A=
-# MPC4xx Driver Options=0A=
+# IBM 4xx options=0A=
 #=0A=
 =0A=
 #=0A=
@@ -562,114 +608,18 @@=0A=
 # CONFIG_USB is not set=0A=
 =0A=
 #=0A=
-# USB Controllers=0A=
-#=0A=
-# CONFIG_USB_UHCI is not set=0A=
-# CONFIG_USB_UHCI_ALT is not set=0A=
-# CONFIG_USB_OHCI is not set=0A=
-=0A=
-#=0A=
-# USB Device Class drivers=0A=
-#=0A=
-# CONFIG_USB_AUDIO is not set=0A=
-# CONFIG_USB_BLUETOOTH is not set=0A=
-# CONFIG_USB_STORAGE is not set=0A=
-# CONFIG_USB_STORAGE_DEBUG is not set=0A=
-# CONFIG_USB_STORAGE_DATAFAB is not set=0A=
-# CONFIG_USB_STORAGE_FREECOM is not set=0A=
-# CONFIG_USB_STORAGE_ISD200 is not set=0A=
-# CONFIG_USB_STORAGE_DPCM is not set=0A=
-# CONFIG_USB_STORAGE_HP8200e is not set=0A=
-# CONFIG_USB_STORAGE_SDDR09 is not set=0A=
-# CONFIG_USB_STORAGE_JUMPSHOT is not set=0A=
-# CONFIG_USB_ACM is not set=0A=
-# CONFIG_USB_PRINTER is not set=0A=
-=0A=
-#=0A=
-# USB Human Interface Devices (HID)=0A=
-#=0A=
-=0A=
-#=0A=
-#   Input core support is needed for USB HID=0A=
-#=0A=
-=0A=
-#=0A=
-# USB Imaging devices=0A=
-#=0A=
-# CONFIG_USB_DC2XX is not set=0A=
-# CONFIG_USB_MDC800 is not set=0A=
-# CONFIG_USB_SCANNER is not set=0A=
-# CONFIG_USB_MICROTEK is not set=0A=
-# CONFIG_USB_HPUSBSCSI is not set=0A=
-=0A=
-#=0A=
-# USB Multimedia devices=0A=
-#=0A=
-=0A=
-#=0A=
-#   Video4Linux support is needed for USB Multimedia device support=0A=
-#=0A=
-=0A=
-#=0A=
-# USB Network adaptors=0A=
-#=0A=
-# CONFIG_USB_PEGASUS is not set=0A=
-# CONFIG_USB_KAWETH is not set=0A=
-# CONFIG_USB_CATC is not set=0A=
-# CONFIG_USB_CDCETHER is not set=0A=
-# CONFIG_USB_USBNET is not set=0A=
-=0A=
-#=0A=
-# USB port drivers=0A=
-#=0A=
-# CONFIG_USB_USS720 is not set=0A=
-=0A=
-#=0A=
-# USB Serial Converter support=0A=
-#=0A=
-# CONFIG_USB_SERIAL is not set=0A=
-# CONFIG_USB_SERIAL_GENERIC is not set=0A=
-# CONFIG_USB_SERIAL_BELKIN is not set=0A=
-# CONFIG_USB_SERIAL_WHITEHEAT is not set=0A=
-# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set=0A=
-# CONFIG_USB_SERIAL_EMPEG is not set=0A=
-# CONFIG_USB_SERIAL_FTDI_SIO is not set=0A=
-# CONFIG_USB_SERIAL_VISOR is not set=0A=
-# CONFIG_USB_SERIAL_IPAQ is not set=0A=
-# CONFIG_USB_SERIAL_IR is not set=0A=
-# CONFIG_USB_SERIAL_EDGEPORT is not set=0A=
-# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set=0A=
-# CONFIG_USB_SERIAL_KEYSPAN is not set=0A=
-# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set=0A=
-# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set=0A=
-# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set=0A=
-# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set=0A=
-# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set=0A=
-# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set=0A=
-# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set=0A=
-# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set=0A=
-# CONFIG_USB_SERIAL_MCT_U232 is not set=0A=
-# CONFIG_USB_SERIAL_KLSI is not set=0A=
-# CONFIG_USB_SERIAL_PL2303 is not set=0A=
-# CONFIG_USB_SERIAL_CYBERJACK is not set=0A=
-# CONFIG_USB_SERIAL_XIRCOM is not set=0A=
-# CONFIG_USB_SERIAL_OMNINET is not set=0A=
-=0A=
-#=0A=
-# USB Miscellaneous drivers=0A=
+# Bluetooth support=0A=
 #=0A=
-# CONFIG_USB_RIO500 is not set=0A=
+# CONFIG_BLUEZ is not set=0A=
 =0A=
 #=0A=
-# Bluetooth support=0A=
+# Library routines=0A=
 #=0A=
-# CONFIG_BLUEZ is not set=0A=
+# CONFIG_ZLIB_INFLATE is not set=0A=
+# CONFIG_ZLIB_DEFLATE is not set=0A=
 =0A=
 #=0A=
 # Kernel hacking=0A=
 #=0A=
-# CONFIG_MAGIC_SYSRQ is not set=0A=
-# CONFIG_KGDB is not set=0A=
-# CONFIG_XMON is not set=0A=
-# CONFIG_BDI_SWITCH is not set=0A=
+# CONFIG_DEBUG_KERNEL is not set=0A=
 # CONFIG_SERIAL_TEXT_DEBUG is not set=0A=
diff -N -u -r --exclude=3DCVS --exclude=3DLOG =
linuxppc_2_4_devel_2.4.21pre3_orig/drivers/ide/Makefile =
linuxppc_2_4_devel_2.4.21pre3/drivers/ide/Makefile=0A=
--- linuxppc_2_4_devel_2.4.21pre3_orig/drivers/ide/Makefile	Thu Jan 23 =
16:37:26 2003=0A=
+++ linuxppc_2_4_devel_2.4.21pre3/drivers/ide/Makefile	Thu Jan 23 =
16:20:44 2003=0A=
@@ -19,7 +19,6 @@=0A=
 obj-m		:=3D=0A=
 ide-obj-y	:=3D=0A=
 =0A=
-# ide-obj-$(CONFIG_BLK_DEV_CPCI405_IDE)	+=3D cpci405ide.o=0A=
 obj-$(CONFIG_IBM_OCP_IDE)	+=3D ibm_ocp_ide.o=0A=
 obj-$(CONFIG_BLK_DEV_REDWOOD_IDE)	+=3D ocp_stbxxxxx.o=0A=
 =0A=
diff -N -u -r --exclude=3DCVS --exclude=3DLOG =
linuxppc_2_4_devel_2.4.21pre3_orig/drivers/ide/cpci405ide.c =
linuxppc_2_4_devel_2.4.21pre3/drivers/ide/cpci405ide.c=0A=
--- linuxppc_2_4_devel_2.4.21pre3_orig/drivers/ide/cpci405ide.c	Thu Jan =
23 16:36:38 2003=0A=
+++ linuxppc_2_4_devel_2.4.21pre3/drivers/ide/cpci405ide.c	Thu Jan  1 =
01:00:00 1970=0A=
@@ -1,92 +0,0 @@=0A=
-/*=0A=
- *  linux/drivers/ide/cpci405.c -- CPCI405 IDE Driver=0A=
- *=0A=
- *     Copyright (C) 2001 by Stefan Roese=0A=
- *=0A=
- *  This driver was written based on information obtained from the =
MacOS IDE=0A=
- *  driver binary by Mikael Forselius=0A=
- *=0A=
- *  This file is subject to the terms and conditions of the GNU General =
Public=0A=
- *  License.  See the file COPYING in the main directory of this =
archive for=0A=
- *  more details.=0A=
- */=0A=
-=0A=
-#include <linux/types.h>=0A=
-#include <linux/mm.h>=0A=
-#include <linux/interrupt.h>=0A=
-#include <linux/blkdev.h>=0A=
-#include <linux/hdreg.h>=0A=
-#include <linux/delay.h>=0A=
-#include <linux/ide.h>=0A=
-#include <linux/init.h>=0A=
-=0A=
-=0A=
-/*=0A=
- *  Base of the IDE interface=0A=
- */=0A=
-=0A=
-#define CPCI405_HD_BASE	0xf0100000=0A=
-=0A=
-/*=0A=
- *  Offsets from the above base (scaling 4)=0A=
- */=0A=
-=0A=
-#define CPCI405_HD_DATA	        0x00=0A=
-#define CPCI405_HD_ERROR	0x01		/* see err-bits */=0A=
-#define CPCI405_HD_NSECTOR	0x02		/* nr of sectors to read/write */=0A=
-#define CPCI405_HD_SECTOR	0x03		/* starting sector */=0A=
-#define CPCI405_HD_LCYL	        0x04		/* starting cylinder */=0A=
-#define CPCI405_HD_HCYL	        0x05		/* high byte of starting cyl */=0A=
-#define CPCI405_HD_SELECT	0x06		/* 101dhhhh , d=3Ddrive, hhhh=3Dhead */=0A=
-#define CPCI405_HD_STATUS	0x07		/* see status-bits */=0A=
-#define CPCI405_HD_CONTROL	0x0e		/* control/altstatus */=0A=
-=0A=
-#define CPCI405_IRQ_IDE         0x1f=0A=
-=0A=
-static int cpci405ide_offsets[IDE_NR_PORTS] __initdata =3D {=0A=
-  CPCI405_HD_DATA, CPCI405_HD_ERROR, CPCI405_HD_NSECTOR, =
CPCI405_HD_SECTOR,=0A=
-  CPCI405_HD_LCYL, CPCI405_HD_HCYL, CPCI405_HD_SELECT, =
CPCI405_HD_STATUS,=0A=
-  CPCI405_HD_CONTROL=0A=
-};=0A=
-=0A=
-static void *cpci405_ide_base_mapped;=0A=
-=0A=
-=0A=
-static int cpci405ide_check_region(ide_ioreg_t start, unsigned int len)=0A=
-{=0A=
-  if (((unsigned long)start >=3D (unsigned =
long)cpci405_ide_base_mapped) && =0A=
-      (((unsigned long)start+len) <=3D (unsigned =
long)cpci405_ide_base_mapped+0x200))=0A=
-    return 0;=0A=
-  else=0A=
-    return -1;=0A=
-}=0A=
-=0A=
-=0A=
-/*=0A=
- *  Probe for a CPCI405 IDE interface=0A=
- */=0A=
-=0A=
-void __init cpci405ide_init(void)=0A=
-{=0A=
-	hw_regs_t hw;=0A=
-	int index =3D -1;=0A=
-=0A=
-        ppc_ide_md.ide_check_region =3D cpci405ide_check_region;=0A=
-=0A=
-#if 0=0A=
-        printk("cpci405ide: physical address=3D%08lx\n",=0A=
-               (unsigned long)CPCI405_HD_BASE);              /* =
test-only */=0A=
-#endif=0A=
-	cpci405_ide_base_mapped =3D=0A=
-          ioremap((unsigned long) CPCI405_HD_BASE, 0x200) - _IO_BASE;=0A=
-#if 0=0A=
-        printk("cpci405ide: mapped address=3D%08lx\n",=0A=
-               (unsigned long)cpci405_ide_base_mapped);      /* =
test-only */=0A=
-#endif=0A=
-        ide_setup_ports(&hw, (ide_ioreg_t)cpci405_ide_base_mapped,=0A=
-                        cpci405ide_offsets, 0, 0, NULL, =
CPCI405_IRQ_IDE);=0A=
-        index =3D ide_register_hw(&hw, NULL);=0A=
-        if (index !=3D -1)=0A=
-          printk("ide%d: CPCI405 IDE interface\n", index);=0A=
-=0A=
-}=0A=
diff -N -u -r --exclude=3DCVS --exclude=3DLOG =
linuxppc_2_4_devel_2.4.21pre3_orig/drivers/ide/ppc/Makefile =
linuxppc_2_4_devel_2.4.21pre3/drivers/ide/ppc/Makefile=0A=
--- linuxppc_2_4_devel_2.4.21pre3_orig/drivers/ide/ppc/Makefile	Thu Jan =
23 16:37:13 2003=0A=
+++ linuxppc_2_4_devel_2.4.21pre3/drivers/ide/ppc/Makefile	Thu Jan 23 =
16:18:14 2003=0A=
@@ -4,6 +4,7 @@=0A=
 obj-y		:=3D=0A=
 obj-m		:=3D=0A=
 =0A=
+obj-$(CONFIG_BLK_DEV_CPCI405_IDE)	+=3D cpci405ide.o=0A=
 obj-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+=3D mpc8xx.o=0A=
 obj-$(CONFIG_BLK_DEV_IDE_PMAC)		+=3D pmac.o=0A=
 obj-$(CONFIG_BLK_DEV_IDE_SWARM)		+=3D swarm.o=0A=
diff -N -u -r --exclude=3DCVS --exclude=3DLOG =
linuxppc_2_4_devel_2.4.21pre3_orig/drivers/ide/ppc/cpci405ide.c =
linuxppc_2_4_devel_2.4.21pre3/drivers/ide/ppc/cpci405ide.c=0A=
--- linuxppc_2_4_devel_2.4.21pre3_orig/drivers/ide/ppc/cpci405ide.c	Thu =
Jan  1 01:00:00 1970=0A=
+++ linuxppc_2_4_devel_2.4.21pre3/drivers/ide/ppc/cpci405ide.c	Thu Jan =
23 16:44:15 2003=0A=
@@ -0,0 +1,72 @@=0A=
+/*=0A=
+ *  linux/drivers/ide/ppc/cpci405ide.c -- CPCI405 IDE Driver=0A=
+ *=0A=
+ *  Copyright (C) 2001-2003 Stefan Roese, =
stefan.roese@esd-electronics.de=0A=
+ *=0A=
+ *  This driver was written based on information obtained from the =
MacOS IDE=0A=
+ *  driver binary by Mikael Forselius=0A=
+ *=0A=
+ *  This file is subject to the terms and conditions of the GNU General =
Public=0A=
+ *  License.  See the file COPYING in the main directory of this =
archive for=0A=
+ *  more details.=0A=
+ */=0A=
+=0A=
+#include <linux/types.h>=0A=
+#include <linux/mm.h>=0A=
+#include <linux/interrupt.h>=0A=
+#include <linux/blkdev.h>=0A=
+#include <linux/hdreg.h>=0A=
+#include <linux/delay.h>=0A=
+#include <linux/ide.h>=0A=
+#include <linux/init.h>=0A=
+=0A=
+=0A=
+/*=0A=
+ *  Base of the IDE interface=0A=
+ */=0A=
+=0A=
+#define CPCI405_HD_BASE	0xf0100000=0A=
+=0A=
+/*=0A=
+ *  Offsets from the above base (scaling 4)=0A=
+ */=0A=
+=0A=
+#define CPCI405_HD_DATA	        0x00=0A=
+#define CPCI405_HD_ERROR	0x01		/* see err-bits */=0A=
+#define CPCI405_HD_NSECTOR	0x02		/* nr of sectors to read/write */=0A=
+#define CPCI405_HD_SECTOR	0x03		/* starting sector */=0A=
+#define CPCI405_HD_LCYL	        0x04		/* starting cylinder */=0A=
+#define CPCI405_HD_HCYL	        0x05		/* high byte of starting cyl */=0A=
+#define CPCI405_HD_SELECT	0x06		/* 101dhhhh , d=3Ddrive, hhhh=3Dhead */=0A=
+#define CPCI405_HD_STATUS	0x07		/* see status-bits */=0A=
+#define CPCI405_HD_CONTROL	0x0e		/* control/altstatus */=0A=
+=0A=
+#define CPCI405_IRQ_IDE         0x1f=0A=
+=0A=
+static int cpci405ide_offsets[IDE_NR_PORTS] __initdata =3D {=0A=
+	CPCI405_HD_DATA, CPCI405_HD_ERROR, CPCI405_HD_NSECTOR, =
CPCI405_HD_SECTOR,=0A=
+	CPCI405_HD_LCYL, CPCI405_HD_HCYL, CPCI405_HD_SELECT, CPCI405_HD_STATUS,=0A=
+	CPCI405_HD_CONTROL=0A=
+};=0A=
+=0A=
+static void *cpci405_ide_base_mapped;=0A=
+=0A=
+=0A=
+/*=0A=
+ *  Probe for a CPCI405 IDE interface=0A=
+ */=0A=
+=0A=
+void __init cpci405ide_init(void)=0A=
+{=0A=
+	hw_regs_t hw;=0A=
+	int index =3D -1;=0A=
+=0A=
+	cpci405_ide_base_mapped =3D=0A=
+		ioremap((unsigned long) CPCI405_HD_BASE, 0x200) - _IO_BASE;=0A=
+        ide_setup_ports(&hw, (ide_ioreg_t)cpci405_ide_base_mapped,=0A=
+                        cpci405ide_offsets, 0, 0, NULL, =
CPCI405_IRQ_IDE);=0A=
+        index =3D ide_register_hw(&hw, NULL);=0A=
+        if (index !=3D -1)=0A=
+		printk("ide%d: CPCI405 IDE interface\n", index);=0A=
+=0A=
+}=0A=

------=_NextPart_000_0024_01C2C304.6A3E79C0--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
