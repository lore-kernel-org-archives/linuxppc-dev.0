Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id B6BD567A65
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Mar 2005 11:36:04 +1100 (EST)
Message-ID: <4232395B.20007@mvista.com>
Date: Fri, 11 Mar 2005 17:35:39 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@jdub.homelinux.org>
References: <4232162D.5000100@mvista.com>
	<1110586166.28218.10.camel@jdub.homelinux.org>
In-Reply-To: <1110586166.28218.10.camel@jdub.homelinux.org>
Content-Type: multipart/mixed; boundary="------------020408010507090907040806"
Cc: akpm <akpm@osdl.org>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2.6.12] PPC32: Update chestnut platform files
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.
--------------020408010507090907040806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Josh Boyer wrote:

>On Fri, 2005-03-11 at 15:05 -0700, Mark A. Greer wrote:
>  
>
>>Update Chestnut platform files.
>>
>>- Set up mtd partition from arch-specific platform file and remove 
>>obsoleted mtd map.
>>    
>>
>
>Could you forward this portion of the patch to the MTD maintainer?  That
>way it has less of a chance getting re-added to -mm when Andrew grabs
>the latest MTD bitkeeper tree.
>

Certainly.  Thanks.

Mark
----------------------------------------
Update Chestnut platform files.

- Update default config file (now enables embedded ethernet driver).
- Make some minor fixups.
- General code cleanup.

Please apply.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
-- 

--------------020408010507090907040806
Content-Type: text/plain;
 name="chestnut.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="chestnut.patch"

diff -Nru a/arch/ppc/configs/chestnut_defconfig b/arch/ppc/configs/chestnut_defconfig
--- a/arch/ppc/configs/chestnut_defconfig	2005-03-11 14:51:08 -07:00
+++ b/arch/ppc/configs/chestnut_defconfig	2005-03-11 14:51:08 -07:00
@@ -1,11 +1,12 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc2
-# Tue Dec  7 16:02:09 2004
+# Linux kernel version: 2.6.11
+# Fri Mar 11 14:32:49 2005
 #
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_HAVE_DEC_LOCK=y
 CONFIG_PPC=y
 CONFIG_PPC32=y
@@ -35,6 +36,7 @@
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -44,6 +46,7 @@
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -78,7 +81,9 @@
 #
 # CONFIG_PPC_MULTIPLATFORM is not set
 # CONFIG_APUS is not set
+# CONFIG_KATANA is not set
 # CONFIG_WILLOW is not set
+# CONFIG_CPCI690 is not set
 # CONFIG_PCORE is not set
 # CONFIG_POWERPMC250 is not set
 CONFIG_CHESTNUT=y
@@ -91,6 +96,7 @@
 # CONFIG_PRPMC750 is not set
 # CONFIG_PRPMC800 is not set
 # CONFIG_SANDPOINT is not set
+# CONFIG_RADSTONE_PPC7D is not set
 # CONFIG_ADIR is not set
 # CONFIG_K2 is not set
 # CONFIG_PAL4 is not set
@@ -101,7 +107,9 @@
 # CONFIG_RPX8260 is not set
 # CONFIG_TQM8260 is not set
 # CONFIG_ADS8272 is not set
+# CONFIG_PQ2FADS is not set
 # CONFIG_LITE5200 is not set
+# CONFIG_MPC834x_SYS is not set
 CONFIG_MV64360=y
 CONFIG_MV64X60=y
 
@@ -128,6 +136,15 @@
 CONFIG_PCI_NAMES=y
 
 #
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PC-card bridges
+#
+
+#
 # Advanced setup
 #
 CONFIG_ADVANCED_OPTIONS=y
@@ -154,6 +171,7 @@
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
 
 #
 # Memory Technology Devices (MTD)
@@ -181,6 +199,9 @@
 # CONFIG_MTD_JEDECPROBE is not set
 CONFIG_MTD_GEN_PROBE=y
 # CONFIG_MTD_CFI_ADV_OPTIONS is not set
+# CONFIG_MTD_CFI_NOSWAP is not set
+# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
+# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
 CONFIG_MTD_MAP_BANK_WIDTH_1=y
 CONFIG_MTD_MAP_BANK_WIDTH_2=y
 CONFIG_MTD_MAP_BANK_WIDTH_4=y
@@ -198,13 +219,16 @@
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
+# CONFIG_MTD_XIP is not set
 
 #
 # Mapping drivers for chip access
 #
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
-# CONFIG_MTD_PHYSMAP is not set
-CONFIG_MTD_CHESTNUT=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_START=0xfc000000
+CONFIG_MTD_PHYSMAP_LEN=0x02000000
+CONFIG_MTD_PHYSMAP_BANKWIDTH=4
 
 #
 # Self-contained MTD device drivers
@@ -214,6 +238,7 @@
 # CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
 # CONFIG_MTD_BLKMTD is not set
+# CONFIG_MTD_BLOCK2MTD is not set
 
 #
 # Disk-On-Chip Device Drivers
@@ -244,11 +269,13 @@
 # CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
 # CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
@@ -262,6 +289,7 @@
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -404,7 +432,6 @@
 # CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
 CONFIG_E100=y
-# CONFIG_E100_NAPI is not set
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
 # CONFIG_NE2K_PCI is not set
@@ -429,6 +456,10 @@
 # CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
+CONFIG_MV643XX_ETH=y
+CONFIG_MV643XX_ETH_0=y
+CONFIG_MV643XX_ETH_1=y
+# CONFIG_MV643XX_ETH_2 is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -485,14 +516,6 @@
 # CONFIG_INPUT_EVBUG is not set
 
 #
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-# CONFIG_SERIO is not set
-# CONFIG_SERIO_I8042 is not set
-
-#
 # Input Device Drivers
 #
 # CONFIG_INPUT_KEYBOARD is not set
@@ -502,6 +525,13 @@
 # CONFIG_INPUT_MISC is not set
 
 #
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+
+#
 # Character devices
 #
 CONFIG_VT=y
@@ -520,6 +550,7 @@
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_MPSC is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
@@ -550,6 +581,11 @@
 # CONFIG_RAW_DRIVER is not set
 
 #
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+
+#
 # I2C support
 #
 # CONFIG_I2C is not set
@@ -606,6 +642,16 @@
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -614,6 +660,10 @@
 # CONFIG_JBD is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -664,6 +714,7 @@
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=0
 # CONFIG_JFFS2_FS_NAND is not set
+# CONFIG_JFFS2_FS_NOR_ECC is not set
 # CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
 CONFIG_JFFS2_ZLIB=y
 CONFIG_JFFS2_RTIME=y
@@ -686,7 +737,6 @@
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
-# CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
@@ -725,6 +775,7 @@
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
+# CONFIG_PRINTK_TIME is not set
 # CONFIG_SERIAL_TEXT_DEBUG is not set
 
 #
@@ -737,3 +788,7 @@
 # Cryptographic options
 #
 # CONFIG_CRYPTO is not set
+
+#
+# Hardware crypto devices
+#
diff -Nru a/arch/ppc/platforms/chestnut.c b/arch/ppc/platforms/chestnut.c
--- a/arch/ppc/platforms/chestnut.c	2005-03-11 14:51:08 -07:00
+++ b/arch/ppc/platforms/chestnut.c	2005-03-11 14:51:08 -07:00
@@ -28,6 +28,7 @@
 #include <linux/ide.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
+#include <linux/mtd/physmap.h>
 #include <asm/system.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -42,8 +43,8 @@
 #include <asm/mv64x60.h>
 #include <platforms/chestnut.h>
 
-static u32 boot_base; /* Virtual addr of 8bit boot */
-static u32 cpld_base; /* Virtual addr of CPLD Regs */
+static void __iomem *sram_base; /* Virtual addr of Internal SRAM */
+static void __iomem *cpld_base; /* Virtual addr of CPLD Regs */
 
 static mv64x60_handle_t	bh;
 
@@ -65,7 +66,8 @@
  *
  ****/
 static void __init
-chestnut_calibrate_decr(void){
+chestnut_calibrate_decr(void)
+{
 	ulong freq;
 
 	freq = CHESTNUT_BUS_SPEED / 4;
@@ -75,8 +77,6 @@
 
 	tb_ticks_per_jiffy = freq / HZ;
 	tb_to_us = mulhwu_scale_factor(freq, 1000000);
-
-	return;
 }
 
 static int
@@ -103,7 +103,7 @@
       		mem_size = mv64x60_get_mem_size(CONFIG_MV64X60_NEW_BASE,
 				MV64x60_TYPE_MV64460);
    	}
-   	return(mem_size);
+   	return mem_size;
 }
 
 #if defined(CONFIG_SERIAL_8250)
@@ -155,7 +155,7 @@
 	};
 	const long min_idsel = 1, max_idsel = 4, irqs_per_slot = 4;
 
-	return (PCI_IRQ_TABLE_LOOKUP);
+	return PCI_IRQ_TABLE_LOOKUP;
 }
 
 
@@ -193,24 +193,30 @@
 	si.pci_0.pci_cmd_bits = 0;
 	si.pci_0.latency_timer = 0x80;
 
-	si.window_preserve_mask_32_lo = CHESTNUT_PRESERVE_MASK;
-
 	for (i=0; i<MV64x60_CPU2MEM_WINDOWS; i++) {
+#if defined(CONFIG_NOT_COHERENT_CACHE)
 		si.cpu_prot_options[i] = 0;
-#ifdef CONFIG_NOT_CACHE_COHERENT
-		si.cpu_snoop_options[i] = MV64360_CPU_SNOOP_NONE;
+		si.enet_options[i] = MV64360_ENET2MEM_SNOOP_NONE;
+		si.mpsc_options[i] = MV64360_MPSC2MEM_SNOOP_NONE;
+		si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_NONE;
+
+		si.pci_1.acc_cntl_options[i] =
+		    MV64360_PCI_ACC_CNTL_SNOOP_NONE |
+		    MV64360_PCI_ACC_CNTL_SWAP_NONE |
+		    MV64360_PCI_ACC_CNTL_MBURST_128_BYTES |
+		    MV64360_PCI_ACC_CNTL_RDSIZE_256_BYTES;
 #else
-		si.cpu_snoop_options[i] = MV64360_CPU_SNOOP_WB; /* risky */
-#endif
-		si.pci_0.acc_cntl_options[i] =
-#ifdef CONFIG_NOT_CACHE_COHERENT
-			MV64360_PCI_ACC_CNTL_SNOOP_NONE |
-#else
-			MV64360_PCI_ACC_CNTL_SNOOP_WB | /* risky */
+		si.cpu_prot_options[i] = 0;
+		si.enet_options[i] = MV64360_ENET2MEM_SNOOP_NONE; /* errata */
+		si.mpsc_options[i] = MV64360_MPSC2MEM_SNOOP_NONE; /* errata */
+		si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_NONE; /* errata */
+
+		si.pci_1.acc_cntl_options[i] =
+		    MV64360_PCI_ACC_CNTL_SNOOP_WB |
+		    MV64360_PCI_ACC_CNTL_SWAP_NONE |
+		    MV64360_PCI_ACC_CNTL_MBURST_32_BYTES |
+		    MV64360_PCI_ACC_CNTL_RDSIZE_32_BYTES;
 #endif
-			MV64360_PCI_ACC_CNTL_SWAP_NONE |
-			MV64360_PCI_ACC_CNTL_MBURST_32_BYTES |
-			MV64360_PCI_ACC_CNTL_RDSIZE_32_BYTES;
 	}
 
    	/* Lookup host bridge - on CPU 0 - no SMP support */
@@ -227,55 +233,44 @@
 	bh.hose_a->first_busno = 0;
 	bh.hose_a->last_busno = 0xff;
 	bh.hose_a->last_busno = pciauto_bus_scan(bh.hose_a, 0);
-
 }
 
 void __init
 chestnut_setup_peripherals(void)
 {
-
    	mv64x60_set_32bit_window(&bh, MV64x60_CPU2BOOT_WIN,
 			CHESTNUT_BOOT_8BIT_BASE, CHESTNUT_BOOT_8BIT_SIZE, 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2BOOT_WIN);
 
 	mv64x60_set_32bit_window(&bh, MV64x60_CPU2DEV_0_WIN,
 			CHESTNUT_32BIT_BASE, CHESTNUT_32BIT_SIZE, 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2DEV_0_WIN);
+
 	mv64x60_set_32bit_window(&bh, MV64x60_CPU2DEV_1_WIN,
 			CHESTNUT_CPLD_BASE, CHESTNUT_CPLD_SIZE, 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2DEV_1_WIN);
+	cpld_base = ioremap(CHESTNUT_CPLD_BASE, CHESTNUT_CPLD_SIZE);
 
 	mv64x60_set_32bit_window(&bh, MV64x60_CPU2DEV_2_WIN,
 			CHESTNUT_UART_BASE, CHESTNUT_UART_SIZE, 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2DEV_2_WIN);
+
 	mv64x60_set_32bit_window(&bh, MV64x60_CPU2DEV_3_WIN,
 			CHESTNUT_FRAM_BASE, CHESTNUT_FRAM_SIZE, 0);
-   	/* Set up window for internal sram (256KByte insize) */
-   	mv64x60_set_32bit_window(&bh, MV64x60_CPU2SRAM_WIN,
-			CHESTNUT_INTERNAL_SRAM_BASE,
-			CHESTNUT_INTERNAL_SRAM_SIZE, 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2DEV_3_WIN);
 
-	boot_base = (u32)ioremap(CHESTNUT_BOOT_8BIT_BASE,
-				CHESTNUT_BOOT_8BIT_SIZE);
-	cpld_base = (u32)ioremap(CHESTNUT_CPLD_BASE, CHESTNUT_CPLD_SIZE);
+   	mv64x60_set_32bit_window(&bh, MV64x60_CPU2SRAM_WIN,
+			CHESTNUT_INTERNAL_SRAM_BASE, MV64360_SRAM_SIZE, 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2SRAM_WIN);
 
-   	/*
-    	 * Configure internal SRAM -
-    	 * Cache coherent write back, incase
-	 *      CONFIG_MV64360_SRAM_CACHE_COHERENT set
-    	 * Parity enabled.
-    	 * Parity error propagation
-    	 * Arbitration not parked for CPU only
-    	 * Other bits are reserved.
-    	 */
-#ifdef CONFIG_MV64360_SRAM_CACHE_COHERENT
-   	mv64x60_write(&bh, MV64360_SRAM_CONFIG, 0x001600b2);
-#else
+#ifdef CONFIG_NOT_COHERENT_CACHE
    	mv64x60_write(&bh, MV64360_SRAM_CONFIG, 0x001600b0);
+#else
+   	mv64x60_write(&bh, MV64360_SRAM_CONFIG, 0x001600b2);
 #endif
+	sram_base = ioremap(CHESTNUT_INTERNAL_SRAM_BASE, MV64360_SRAM_SIZE);
+   	memset(sram_base, 0, MV64360_SRAM_SIZE);
 
-   	/*
-    	 * Setting the SRAM to 0. Note that this generates parity errors on
-	 * internal data path in SRAM since it's first time accessing it
-	 * while after reset it's not configured
-    	*/
-   	memset((void *)CHESTNUT_INTERNAL_SRAM_BASE, 0, CHESTNUT_INTERNAL_SRAM_SIZE);
 	/*
 	 * Configure MPP pins for PCI DMA
 	 *
@@ -312,9 +307,9 @@
 			(0xf << 20) |	/* MPPSel13 GPIO[13] */
 			(0xf << 24) |	/* MPPSel14 GPIO[14] */
 			(0xf << 28));	/* MPPSel15 GPIO[15] */
-	mv64x60_set_bits(&bh, MV64x60_GPP_IO_CNTL,
+	mv64x60_set_bits(&bh, MV64x60_GPP_IO_CNTL, /* Output */
 			BIT(1)  | BIT(2)  | BIT(4)  | BIT(5)  | BIT(6)  |
-			BIT(9)  | BIT(10) | BIT(13) | BIT(14) | BIT(15)); /* Output */
+			BIT(9)  | BIT(10) | BIT(13) | BIT(14) | BIT(15));
 
    	/*
     	 * Configure the following MPP pins to indicate a level
@@ -364,7 +359,7 @@
    	/*
     	 * Dismiss and then enable interrupt on CPU #0 high cause register
     	 * BIT27 summarizes GPP interrupts 24-31
-    	*/
+    	 */
    	mv64x60_set_bits(&bh, MV64360_IC_CPU0_INTR_MASK_HI, BIT(27));
 
    	if (ppc_md.progress)
@@ -423,14 +418,32 @@
 
 	/* Identify the system */
 	printk(KERN_INFO "System Identification: IBM 750FX/GX Eval Board\n");
-	printk(KERN_INFO "IBM 750FX/GX port (C) 2004 MontaVista Software, Inc. (source@mvista.com)\n");
+	printk(KERN_INFO "IBM 750FX/GX port (C) 2004 MontaVista Software, Inc."
+		" (source@mvista.com)\n");
 
 	if (ppc_md.progress)
       		ppc_md.progress("chestnut_setup_arch: exit", 0);
+}
+
+#ifdef CONFIG_MTD_PHYSMAP
+static struct mtd_partition ptbl;
+
+static int __init
+chestnut_setup_mtd(void)
+{
+	memset(&ptbl, 0, sizeof(ptbl));
 
-	return;
+	ptbl.name = "User FS";
+	ptbl.size = CHESTNUT_32BIT_SIZE;
+
+	physmap_map.size = CHESTNUT_32BIT_SIZE;
+	physmap_set_partitions(&ptbl, 1);
+	return 0;
 }
 
+arch_initcall(chestnut_setup_mtd);
+#endif
+
 /**************************************************************************
  * FUNCTION: chestnut_restart
  *
@@ -450,7 +463,7 @@
          *
          * MPP24 - board reset
          */
-   	writeb(0x1, (void __iomem *)(cpld_base+3));
+   	writeb(0x1, cpld_base + 3);
 
 	/* GPP pin tied to MPP earlier */
         mv64x60_set_bits(&bh, MV64x60_GPP_VALUE_SET, BIT(24));
@@ -474,37 +487,6 @@
 	/* NOTREACHED */
 }
 
-#define SET_PCI_COMMAND_INVALIDATE
-#ifdef SET_PCI_COMMAND_INVALIDATE
-/*
- * Dave Wilhardt found that PCI_COMMAND_INVALIDATE must
- * be set for each device if you are using cache coherency.
- */
-static void __init
-set_pci_command_invalidate(void)
-{
-	struct pci_dev *dev = NULL;
-	u16 val;
-
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-		pci_read_config_word(dev, PCI_COMMAND, &val);
-		val |= PCI_COMMAND_INVALIDATE;
-		pci_write_config_word(dev, PCI_COMMAND, val);
-
-		pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE,
-				      L1_CACHE_LINE_SIZE >> 2);
-	}
-}
-#endif
-
-static void __init
-chestnut_pci_fixups(void)
-{
-#ifdef SET_PCI_COMMAND_INVALIDATE
-	set_pci_command_invalidate();
-#endif
-}
-
 /**************************************************************************
  * FUNCTION: chestnut_map_io
  *
@@ -514,27 +496,9 @@
 static void __init
 chestnut_map_io(void)
 {
-#ifdef CONFIG_MV64360_SRAM_CACHEABLE
-   	io_block_mapping(CHESTNUT_INTERNAL_SRAM_BASE,
-       			CHESTNUT_INTERNAL_SRAM_BASE,
-       			CHESTNUT_INTERNAL_SRAM_SIZE,
-       			_PAGE_KERNEL | _PAGE_GUARDED);
-#else
-#ifdef CONFIG_MV64360_SRAM_CACHE_COHERENT
-   	io_block_mapping(CHESTNUT_INTERNAL_SRAM_BASE,
-       			CHESTNUT_INTERNAL_SRAM_BASE,
-       			CHESTNUT_INTERNAL_SRAM_SIZE,
-       			_PAGE_KERNEL | _PAGE_GUARDED | _PAGE_COHERENT);
-#else
-   	io_block_mapping(CHESTNUT_INTERNAL_SRAM_BASE,
-       			CHESTNUT_INTERNAL_SRAM_BASE,
-       			CHESTNUT_INTERNAL_SRAM_SIZE,
-       			_PAGE_IO);
-#endif /* !CONFIG_MV64360_SRAM_CACHE_COHERENT */
-#endif /* !CONFIG_MV64360_SRAM_CACHEABLE */
-
 #if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
-	io_block_mapping(CHESTNUT_UART_BASE, CHESTNUT_UART_BASE, 0x100000, _PAGE_IO);
+	io_block_mapping(CHESTNUT_UART_BASE, CHESTNUT_UART_BASE, 0x100000,
+		_PAGE_IO);
 #endif
 }
 
@@ -552,8 +516,6 @@
         mtspr(DBAT3U, 0xf0001ffe);
         mtspr(DBAT3L, 0xf000002a);
         mb();
-
-	return;
 }
 
 /**************************************************************************
@@ -587,7 +549,6 @@
 
 	ppc_md.find_end_of_memory = chestnut_find_end_of_memory;
 	ppc_md.setup_io_mappings  = chestnut_map_io;
-	ppc_md.pcibios_fixup = chestnut_pci_fixups;
 
 	ppc_md.restart = chestnut_restart;
    	ppc_md.power_off = chestnut_power_off;
@@ -603,8 +564,6 @@
 
 	ppc_md.heartbeat = NULL;
 
-	ppc_md.pcibios_fixup = chestnut_pci_fixups;
-
 	bh.p_base = CONFIG_MV64X60_NEW_BASE;
 
 	chestnut_set_bat();
@@ -618,6 +577,4 @@
 
 	if (ppc_md.progress)
                 ppc_md.progress("chestnut_init(): exit", 0);
-
-        return;
 }
diff -Nru a/arch/ppc/platforms/chestnut.h b/arch/ppc/platforms/chestnut.h
--- a/arch/ppc/platforms/chestnut.h	2005-03-11 14:51:08 -07:00
+++ b/arch/ppc/platforms/chestnut.h	2005-03-11 14:51:08 -07:00
@@ -24,11 +24,12 @@
  * implement at 0xf1000000 only at this time
  *
  *    0xfff00000-0xffffffff      - 8 Flash
+ *    0xffe00000-0xffefffff      - BOOT SRAM
  *    0xffd00000-0xffd00004      - CPLD
  *    0xffc00000-0xffc0000f      - UART
  *    0xffb00000-0xffb07fff      - FRAM
  *    0xffa00000-0xffafffff      - *** HOLE ***
- *    0xff900000-0xff9fffff      - MV64460 Integrated SRAM
+ *    0xff800000-0xff9fffff      - MV64460 Integrated SRAM
  *    0xfe000000-0xff8fffff      - *** HOLE ***
  *    0xfc000000-0xfdffffff      - 32bit Flash
  *    0xf1010000-0xfbffffff      - *** HOLE ***
@@ -49,9 +50,7 @@
 #define CHESTNUT_UART_SIZE_ACTUAL		16
 #define CHESTNUT_FRAM_BASE			0xffb00000
 #define CHESTNUT_FRAM_SIZE_ACTUAL		(32*1024)
-#define CHESTNUT_BRIDGE_REG_BASE		0xf1000000
-#define CHESTNUT_INTERNAL_SRAM_BASE		0xff900000
-#define CHESTNUT_INTERNAL_SRAM_SIZE_ACTUAL	(256*1024)
+#define CHESTNUT_INTERNAL_SRAM_BASE		0xff800000
 #define CHESTNUT_32BIT_BASE			0xfc000000
 #define CHESTNUT_32BIT_SIZE			(32*1024*1024)
 
@@ -65,14 +64,16 @@
 					CHESTNUT_UART_SIZE_ACTUAL)
 #define CHESTNUT_FRAM_SIZE		max(MV64360_WINDOW_SIZE_MIN, \
 					CHESTNUT_FRAM_SIZE_ACTUAL)
-#define CHESTNUT_INTERNAL_SRAM_SIZE	max(MV64360_WINDOW_SIZE_MIN, \
-					CHESTNUT_INTERNAL_SRAM_SIZE_ACTUAL)
 
 #define CHESTNUT_BUS_SPEED		200000000
 #define CHESTNUT_PIBS_DATABASE		0xf0000 /* from PIBS src code */
 
-#define MV64360_ETH_PORT_SERIAL_CONTROL_REG_PORT0 	0x243c
-#define MV64360_ETH_PORT_SERIAL_CONTROL_REG_PORT1 	0x283c
+#define	KATANA_ETH0_PHY_ADDR			12
+#define	KATANA_ETH1_PHY_ADDR			11
+#define	KATANA_ETH2_PHY_ADDR			4
+
+#define CHESTNUT_ETH_TX_QUEUE_SIZE		800
+#define CHESTNUT_ETH_RX_QUEUE_SIZE		400
 
 /*
  * PCI windows
@@ -89,17 +90,17 @@
 /*
  * Board-specific IRQ info
  */
-#define CHESTNUT_PCI_SLOT0_IRQ	64+31
-#define CHESTNUT_PCI_SLOT1_IRQ	64+30
-#define CHESTNUT_PCI_SLOT2_IRQ	64+29
-#define CHESTNUT_PCI_SLOT3_IRQ	64+28
+#define CHESTNUT_PCI_SLOT0_IRQ	(64 + 31)
+#define CHESTNUT_PCI_SLOT1_IRQ	(64 + 30)
+#define CHESTNUT_PCI_SLOT2_IRQ	(64 + 29)
+#define CHESTNUT_PCI_SLOT3_IRQ	(64 + 28)
 
 /* serial port definitions */
-#define CHESTNUT_UART0_IO_BASE  CHESTNUT_UART_BASE+8
+#define CHESTNUT_UART0_IO_BASE  (CHESTNUT_UART_BASE + 8)
 #define CHESTNUT_UART1_IO_BASE  CHESTNUT_UART_BASE
 
-#define UART0_INT           	64+25
-#define UART1_INT        	64+26
+#define UART0_INT           	(64 + 25)
+#define UART1_INT        	(64 + 26)
 
 #ifdef CONFIG_SERIAL_MANY_PORTS
 #define RS_TABLE_SIZE  64
@@ -108,7 +109,7 @@
 #endif
 
 /* Rate for the 3.6864 Mhz clock for the onboard serial chip */
-#define BASE_BAUD 		( 3686400 / 16 )
+#define BASE_BAUD 		(3686400 / 16)
 
 #ifdef CONFIG_SERIAL_DETECT_IRQ
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF|ASYNC_SKIP_TEST|ASYNC_AUTO_IRQ)

--------------020408010507090907040806--
