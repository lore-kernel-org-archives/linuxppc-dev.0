From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 3 Dec 2003 17:35:53 -0700
To: Wolfgang Denk <wd@denx.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5200 Patches
Message-ID: <20031204003552.GA27528@zenos.farnsworth.org>
References: <20031203182803.GA10936@zenos.farnsworth.org> <20031203185310.19A48C5F5F@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031203185310.19A48C5F5F@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Dec 03, 2003 at 07:53:05PM +0100, Wolfgang Denk wrote:
> Can you please resend the patch as unified (or context)  diff?

Oops.

Thanks,
-Dale

===== arch/ppc/5xxx_io/bestcomm/Makefile 1.1 vs edited =====
--- 1.1/arch/ppc/5xxx_io/bestcomm/Makefile	Wed Nov 26 07:41:36 2003
+++ edited/arch/ppc/5xxx_io/bestcomm/Makefile	Tue Dec  2 12:17:32 2003
@@ -7,7 +7,7 @@
 #
 # Note 2! The CFLAGS definition is now in the main makefile...

-EXTRA_CFLAGS = -I$(TOPDIR)/arch/$(ARCH)/5xxx_io/include -I$(TOPDIR)/arch/$(ARCH)/5xxx_io/capi -I$(TOPDIR)/arch/$(ARCH)/5xxx_io/capi/task_api -I$(TOPDIR)/arch/$(ARCH)/5xxx_io/code_dma/image_rtos1
+EXTRA_CFLAGS = -I$(TOPDIR)/arch/$(ARCH)/5xxx_io/bestcomm/include -I$(TOPDIR)/arch/$(ARCH)/5xxx_io/bestcomm/capi -I$(TOPDIR)/arch/$(ARCH)/5xxx_io/bestcomm/capi/task_api -I$(TOPDIR)/arch/$(ARCH)/5xxx_io/bestcomm/code_dma/image_rtos1

 O_TARGET := bestcomm.o

===== arch/ppc/boot/simple/Makefile 1.12 vs edited =====
--- 1.12/arch/ppc/boot/simple/Makefile	Wed Nov 26 07:41:35 2003
+++ edited/arch/ppc/boot/simple/Makefile	Wed Dec  3 08:44:36 2003
@@ -135,8 +135,8 @@
 obj-$(CONFIG_8xx)		+= m8xx_tty.o
 obj-$(CONFIG_8260)		+= m8260_tty.o
 obj-$(CONFIG_SERIAL)		+= ../common/ns16550.o
-obj-$(CONFIG_GLACIER)		:= mpc7xxx_tty.o
-obj-$(CONFIG_ICECUBE)		:= mpc5xxx_tty.o
+obj-$(CONFIG_GLACIER)		+= mpc5xxx_tty.o
+obj-$(CONFIG_ICECUBE)		+= mpc5xxx_tty.o
 endif

 LIBS				:= ../lib/zlib.a
===== arch/ppc/configs/icecube_defconfig 1.1 vs edited =====
--- 1.1/arch/ppc/configs/icecube_defconfig	Wed Nov 26 07:41:41 2003
+++ edited/arch/ppc/configs/icecube_defconfig	Wed Dec  3 11:24:30 2003
@@ -33,8 +33,8 @@
 # CONFIG_ALL_PPC is not set
 # CONFIG_APUS is not set
 # CONFIG_SPRUCE is not set
-CONFIG_GLACIER=y
-# CONFIG_ICECUBE is not set
+# CONFIG_GLACIER is not set
+CONFIG_ICECUBE=y
 # CONFIG_LOPEC is not set
 # CONFIG_PPLUS is not set
 # CONFIG_PAL4 is not set
@@ -48,9 +48,11 @@
 CONFIG_MPC5200=y
 CONFIG_PPC_5xxx_PSC_CONSOLE_BAUD=115200
 # CONFIG_UBOOT is not set
-CONFIG_PPC_5xxx_PSC_CONSOLE_PORT=2
-CONFIG_PPC_5xxx_PROCFREQ=231000000
+CONFIG_PPC_5xxx_PSC_CONSOLE_PORT=0
+CONFIG_PPC_5xxx_PROCFREQ=396000000
 CONFIG_PPC_5xxx_IPBFREQ=66000000
+CONFIG_PPC_5xxx_FLASH_ADDR=ff800000
+CONFIG_PPC_5xxx_FLASH_SIZE=800000

 #
 # General setup
@@ -92,7 +94,73 @@
 #
 # Memory Technology Devices (MTD)
 #
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_CONCAT is not set
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+# CONFIG_MTD_OBSOLETE_CHIPS is not set
+# CONFIG_MTD_AMDSTD is not set
+# CONFIG_MTD_SHARP is not set
+# CONFIG_MTD_JEDEC is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_PHYSMAP is not set
+# CONFIG_MTD_TQM8XXL is not set
+# CONFIG_MTD_RPXLITE is not set
+# CONFIG_MTD_MBX860 is not set
+# CONFIG_MTD_DBOX2 is not set
+# CONFIG_MTD_CFI_FLAGADM is not set
+# CONFIG_MTD_REDWOOD is not set
+CONFIG_MTD_ICECUBE=y
+# CONFIG_MTD_PCI is not set
+# CONFIG_MTD_PCMCIA is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLKMTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC1000 is not set
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOCPROBE is not set
+
+#
+# NAND Flash Device Drivers
+#
+# CONFIG_MTD_NAND is not set

 #
 # Plug and Play configuration
@@ -526,9 +594,9 @@
 # MPC5xxx I/O Options
 #
 CONFIG_PPC_5xxx_FEC=y
-# CONFIG_USE_MDIO is not set
+CONFIG_USE_MDIO=y
 # CONFIG_FEC_GENERIC_PHY is not set
-# CONFIG_FEC_LXT971 is not set
+CONFIG_FEC_LXT971=y
 CONFIG_PPC_5xxx_PSC=y
 CONFIG_PPC_5xxx_PSC_CONSOLE=y
 CONFIG_SERIAL_CONSOLE=y
@@ -556,7 +624,7 @@
 #
 # Library routines
 #
-# CONFIG_CRC32 is not set
+CONFIG_CRC32=y
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y

@@ -572,4 +640,5 @@
 # CONFIG_XMON is not set
 CONFIG_BDI_SWITCH=y
 # CONFIG_MORE_COMPILE_OPTIONS is not set
+# CONFIG_SERIAL_TEXT_DEBUG is not set
 CONFIG_LOG_BUF_SHIFT=0
===== arch/ppc/platforms/icecube.h 1.1 vs edited =====
--- 1.1/arch/ppc/platforms/icecube.h	Wed Nov 26 07:41:42 2003
+++ edited/arch/ppc/platforms/icecube.h	Tue Dec  2 15:22:51 2003
@@ -58,7 +58,7 @@
 	.baud_base = MPC5xxx_INIT_BAUD_BASE,		\
 	.irq = MPC5xxx_PSC##num##_IRQ,			\
 	.flags = ASYNC_BOOT_AUTOCONF|ASYNC_SKIP_TEST, 	\
-	.iomem_base = (void *)MPC5xxx_PSC##num##,	\
+	.iomem_base = (void *)MPC5xxx_PSC##num,		\
 	.io_type = SERIAL_IO_MEM,			\
 },


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
