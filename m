Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id F35E967A80
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 09:29:24 +1100 (EST)
Message-ID: <421277B5.1090908@mvista.com>
Date: Tue, 15 Feb 2005 15:29:09 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------040706070302080304050000"
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH][PPC32] Artesyn Katana platform update
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
--------------040706070302080304050000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

This patch:

- Adds MTD support for the soldered FLASH
- Adds cmdline parsing
- Turns on the Blue LED when the system is halted
- Moves some of the device window left by the firmware to proper alignments
- Handles possibility of different frequencies for TCLK & SysCLK in 64460
- Misc. code clean up

Please apply.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

--------------040706070302080304050000
Content-Type: text/plain;
 name="katana_3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="katana_3.patch"

diff -Nru a/arch/ppc/configs/katana_defconfig b/arch/ppc/configs/katana_defconfig
--- a/arch/ppc/configs/katana_defconfig	2005-02-15 15:11:59 -07:00
+++ b/arch/ppc/configs/katana_defconfig	2005-02-15 15:11:59 -07:00
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc2
-# Tue Jan 25 16:31:13 2005
+# Linux kernel version: 2.6.11-rc4
+# Tue Feb 15 14:27:12 2005
 #
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
@@ -152,8 +152,8 @@
 CONFIG_TASK_SIZE=0x80000000
 CONFIG_CONSISTENT_START_BOOL=y
 CONFIG_CONSISTENT_START=0xf0000000
-# CONFIG_CONSISTENT_SIZE_BOOL is not set
-CONFIG_CONSISTENT_SIZE=0x00200000
+CONFIG_CONSISTENT_SIZE_BOOL=y
+CONFIG_CONSISTENT_SIZE=0x00400000
 # CONFIG_BOOT_LOAD_BOOL is not set
 CONFIG_BOOT_LOAD=0x00800000
 
@@ -171,7 +171,82 @@
 #
 # Memory Technology Devices (MTD)
 #
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_PARTITIONS=y
+CONFIG_MTD_CONCAT=y
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
+# CONFIG_INFTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_NOSWAP=y
+# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
+# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
+CONFIG_MTD_CFI_GEOMETRY=y
+# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+# CONFIG_MTD_CFI_I1 is not set
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+CONFIG_MTD_CFI_INTELEXT=y
+# CONFIG_MTD_CFI_AMDSTD is not set
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+# CONFIG_MTD_XIP is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_START=0xe0000000
+CONFIG_MTD_PHYSMAP_LEN=0x0
+CONFIG_MTD_PHYSMAP_BANKWIDTH=4
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+CONFIG_MTD_PHRAM=y
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLKMTD is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+# CONFIG_MTD_NAND is not set
 
 #
 # Parallel port support
@@ -531,7 +606,6 @@
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -573,6 +647,10 @@
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
@@ -619,6 +697,8 @@
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+# CONFIG_JFFS_FS is not set
+# CONFIG_JFFS2_FS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
@@ -637,7 +717,6 @@
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
-# CONFIG_EXPORTFS is not set
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
diff -Nru a/arch/ppc/platforms/katana.c b/arch/ppc/platforms/katana.c
--- a/arch/ppc/platforms/katana.c	2005-02-15 15:11:59 -07:00
+++ b/arch/ppc/platforms/katana.c	2005-02-15 15:11:59 -07:00
@@ -1,9 +1,10 @@
 /*
  * arch/ppc/platforms/katana.c
  *
- * Board setup routines for the Artesyn Katana 750 based boards.
+ * Board setup routines for the Artesyn Katana cPCI boards.
  *
- * Tim Montgomery <timm@artesyncp.com>
+ * Athor: Tim Montgomery <timm@artesyncp.com>
+ * Maintained by: Mark A. Greer <mgreer@mvista.com>
  *
  * Based on code done by Rabeeh Khoury - rabeeh@galileo.co.il
  * Based on code done by - Mark A. Greer <mgreer@mvista.com>
@@ -26,7 +27,8 @@
 #include <linux/root_dev.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
-#include <linux/smp.h>
+#include <linux/bootmem.h>
+#include <linux/mtd/physmap.h>
 #include <linux/mv643xx.h>
 #ifdef CONFIG_BOOTIMG
 #include <linux/bootimg.h>
@@ -36,13 +38,19 @@
 #include <asm/smp.h>
 #include <asm/todc.h>
 #include <asm/bootinfo.h>
+#include <asm/ppcboot.h>
 #include <asm/mv64x60.h>
 #include <platforms/katana.h>
 
 static struct		mv64x60_handle bh;
 static katana_id_t	katana_id;
-static u32		cpld_base;
-static u32		sram_base;
+static void __iomem	*cpld_base;
+static void __iomem	*sram_base;
+
+static u32		katana_flash_size_0;
+static u32		katana_flash_size_1;
+
+unsigned char	__res[sizeof(bd_t)];
 
 /* PCI Interrupt routing */
 static int __init
@@ -105,7 +113,7 @@
 void __init
 katana_get_board_id(void)
 {
-	switch (in_8((volatile char *)(cpld_base + KATANA_CPLD_PRODUCT_ID))) {
+	switch (in_8(cpld_base + KATANA_CPLD_PRODUCT_ID)) {
 	case KATANA_PRODUCT_ID_3750:
 		katana_id = KATANA_ID_3750;
 		break;
@@ -170,7 +178,7 @@
 static inline int
 katana_is_monarch(void)
 {
-	return in_8((volatile char *)(cpld_base + KATANA_CPLD_BD_CFG_3)) &
+	return in_8(cpld_base + KATANA_CPLD_BD_CFG_3) &
 		KATANA_CPLD_BD_CFG_3_MONARCH;
 }
 
@@ -180,18 +188,17 @@
 	u8 reset_out;
 
 	/* Enable access to IPMI ctlr by clearing IPMI PORTSEL bit in CPLD */
-	reset_out = in_8((volatile char *)(cpld_base + KATANA_CPLD_RESET_OUT));
+	reset_out = in_8(cpld_base + KATANA_CPLD_RESET_OUT);
 	reset_out &= ~KATANA_CPLD_RESET_OUT_PORTSEL;
-	out_8((volatile void *)(cpld_base + KATANA_CPLD_RESET_OUT), reset_out);
-	return;
+	out_8(cpld_base + KATANA_CPLD_RESET_OUT, reset_out);
 }
 
-static unsigned long
+static u32
 katana_bus_freq(void)
 {
 	u8 bd_cfg_0;
 
-	bd_cfg_0 = in_8((volatile char *)(cpld_base + KATANA_CPLD_BD_CFG_0));
+	bd_cfg_0 = in_8(cpld_base + KATANA_CPLD_BD_CFG_0);
 
 	switch (bd_cfg_0 & KATANA_CPLD_BD_CFG_0_SYSCLK_MASK) {
 	case KATANA_CPLD_BD_CFG_0_SYSCLK_200:
@@ -263,13 +270,12 @@
 	 * BIT25 summarizes GPP interrupts 8-15
 	 */
 	mv64x60_set_bits(&bh, MV64360_IC_CPU0_INTR_MASK_HI, (1<<25));
-	return;
 }
 
 void __init
 katana_setup_peripherals(void)
 {
-	u32 base, size_0, size_1;
+	u32 base;
 
 	/* Set up windows for boot CS, soldered & socketed flash, and CPLD */
 	mv64x60_set_32bit_window(&bh, MV64x60_CPU2BOOT_WIN,
@@ -277,19 +283,22 @@
 	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2BOOT_WIN);
 
 	/* Assume firmware set up window sizes correctly for dev 0 & 1 */
-	mv64x60_get_32bit_window(&bh, MV64x60_CPU2DEV_0_WIN, &base, &size_0);
+	mv64x60_get_32bit_window(&bh, MV64x60_CPU2DEV_0_WIN, &base,
+		&katana_flash_size_0);
 
-	if (size_0 > 0) {
+	if (katana_flash_size_0 > 0) {
 		mv64x60_set_32bit_window(&bh, MV64x60_CPU2DEV_0_WIN,
-			 KATANA_SOLDERED_FLASH_BASE, size_0, 0);
+			 KATANA_SOLDERED_FLASH_BASE, katana_flash_size_0, 0);
 		bh.ci->enable_window_32bit(&bh, MV64x60_CPU2DEV_0_WIN);
 	}
 
-	mv64x60_get_32bit_window(&bh, MV64x60_CPU2DEV_1_WIN, &base, &size_1);
+	mv64x60_get_32bit_window(&bh, MV64x60_CPU2DEV_1_WIN, &base,
+		&katana_flash_size_1);
 
-	if (size_1 > 0) {
+	if (katana_flash_size_1 > 0) {
 		mv64x60_set_32bit_window(&bh, MV64x60_CPU2DEV_1_WIN,
-			 (KATANA_SOLDERED_FLASH_BASE + size_0), size_1, 0);
+			 (KATANA_SOLDERED_FLASH_BASE + katana_flash_size_0),
+			 katana_flash_size_1, 0);
 		bh.ci->enable_window_32bit(&bh, MV64x60_CPU2DEV_1_WIN);
 	}
 
@@ -300,12 +309,12 @@
 	mv64x60_set_32bit_window(&bh, MV64x60_CPU2DEV_3_WIN,
 		 KATANA_CPLD_BASE, KATANA_CPLD_SIZE, 0);
 	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2DEV_3_WIN);
-	cpld_base = (u32)ioremap(KATANA_CPLD_BASE, KATANA_CPLD_SIZE);
+	cpld_base = ioremap(KATANA_CPLD_BASE, KATANA_CPLD_SIZE);
 
 	mv64x60_set_32bit_window(&bh, MV64x60_CPU2SRAM_WIN,
 		 KATANA_INTERNAL_SRAM_BASE, MV64360_SRAM_SIZE, 0);
 	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2SRAM_WIN);
-	sram_base = (u32)ioremap(KATANA_INTERNAL_SRAM_BASE, MV64360_SRAM_SIZE);
+	sram_base = ioremap(KATANA_INTERNAL_SRAM_BASE, MV64360_SRAM_SIZE);
 
 	/* Set up Enet->SRAM window */
 	mv64x60_set_32bit_window(&bh, MV64x60_ENET2MEM_4_WIN,
@@ -339,13 +348,11 @@
 	 * internal data path in SRAM since it's first time accessing it
 	 * while after reset it's not configured.
 	 */
-	memset((void *)sram_base, 0, MV64360_SRAM_SIZE);
+	memset(sram_base, 0, MV64360_SRAM_SIZE);
 
 	/* Only processor zero [on 3750] is an PCI interrupt controller */
 	if (katana_get_proc_num() == 0)
 		katana_intr_setup();
-
-	return;
 }
 
 static void __init
@@ -356,7 +363,7 @@
 
 	memset(&si, 0, sizeof(si));
 
-	si.phys_reg_base = KATANA_BRIDGE_REG_BASE;
+	si.phys_reg_base = CONFIG_MV64X60_NEW_BASE;
 
 	si.pci_1.enable_bus = 1;
 	si.pci_1.pci_io.cpu_base = KATANA_PCI1_IO_START_PROC_ADDR;
@@ -410,10 +417,77 @@
 	mv64x60_set_bus(&bh, 1, 0);
 	bh.hose_b->first_busno = 0;
 	bh.hose_b->last_busno = 0xff;
+}
 
-	return;
+#ifdef CONFIG_MTD_PHYSMAP
+
+#ifndef MB
+#define MB	(1 << 20)
+#endif
+
+/*
+ * MTD Layout depends on amount of soldered FLASH in system. Sizes in MB.
+ *
+ * FLASH Amount:	128	64	32	16 
+ * -------------	---	--	--	--
+ * Monitor:		1	1	1	1
+ * Primary Kernel:	1.5	1.5	1.5	1.5
+ * Primary fs:		30	30	<end>	<end>
+ * Secondary Kernel:	1.5	1.5	N/A	N/A
+ * Secondary fs:	<end>	<end>	N/A	N/A
+ * User: 		<overlays entire FLASH except for "Monitor" section>
+ */
+static int __init
+katana_setup_mtd(void)
+{
+	u32	size;
+	int	ptbl_entries;
+	static struct mtd_partition	*ptbl;
+
+	size = katana_flash_size_0 + katana_flash_size_1;
+	if (!size)
+		return -ENOMEM;
+
+	ptbl_entries = (size >= (64*MB)) ? 6 : 4;
+
+	if ((ptbl = kmalloc(ptbl_entries * sizeof(struct mtd_partition),
+		GFP_KERNEL)) == NULL) {
+
+		printk(KERN_WARNING "Can't alloc MTD partition table\n");
+		return -ENOMEM;
+	}
+	memset(ptbl, 0, ptbl_entries * sizeof(struct mtd_partition));
+
+	ptbl[0].name = "Monitor";
+	ptbl[0].size = KATANA_MTD_MONITOR_SIZE;
+	ptbl[1].name = "Primary Kernel";
+	ptbl[1].offset = MTDPART_OFS_NXTBLK;
+	ptbl[1].size = 0x00180000; /* 1.5 MB */
+	ptbl[2].name = "Primary Filesystem";
+	ptbl[2].offset = MTDPART_OFS_APPEND;
+	ptbl[2].size = MTDPART_SIZ_FULL; /* Correct for 16 & 32 MB */
+	ptbl[ptbl_entries-1].name = "User FLASH";
+	ptbl[ptbl_entries-1].offset = KATANA_MTD_MONITOR_SIZE;
+	ptbl[ptbl_entries-1].size = MTDPART_SIZ_FULL;
+
+	if (size >= (64*MB)) {
+		ptbl[2].size = 30*MB;
+		ptbl[3].name = "Secondary Kernel";
+		ptbl[3].offset = MTDPART_OFS_NXTBLK;
+		ptbl[3].size = 0x00180000; /* 1.5 MB */
+		ptbl[4].name = "Secondary Filesystem";
+		ptbl[4].offset = MTDPART_OFS_APPEND;
+		ptbl[4].size = MTDPART_SIZ_FULL;
+	}
+
+	physmap_map.size = size;
+	physmap_set_partitions(ptbl, ptbl_entries);
+	return 0;
 }
 
+arch_initcall(katana_setup_mtd);
+#endif
+
 static void __init
 katana_setup_arch(void)
 {
@@ -444,8 +518,7 @@
 		printk(KERN_INFO "DD2.0 detected. Setting L2 cache"
 			"to Writethrough mode\n");
 		_set_L2CR(L2CR_L2E | L2CR_L2PE | L2CR_L2WT);
-	}
-	else
+	} else
 		_set_L2CR(L2CR_L2E | L2CR_L2PE);
 
 	if (ppc_md.progress)
@@ -458,7 +531,6 @@
 	printk(KERN_INFO "Artesyn Communication Products, LLC - Katana(TM)\n");
 	if (ppc_md.progress)
 		ppc_md.progress("katana_setup_arch: exit", 0);
-	return;
 }
 
 /* Platform device data fixup routines. */
@@ -473,9 +545,12 @@
 	pdata->max_idle = 40;
 	pdata->default_baud = KATANA_DEFAULT_BAUD;
 	pdata->brg_clk_src = KATANA_MPSC_CLK_SRC;
-	pdata->brg_clk_freq = KATANA_MPSC_CLK_FREQ;
-
-	return;
+	/*
+	 * TCLK (not SysCLk) is routed to BRG, then to the MPSC.  On most parts,
+	 * TCLK == SysCLK but on 64460, they are separate pins.
+	 * SysCLK can go up to 200 MHz but TCLK can only go up to 133 MHz.
+	 */
+	pdata->brg_clk_freq = min(katana_bus_freq(), MV64x60_TCLK_FREQ_MAX);
 }
 #endif
 
@@ -548,11 +623,10 @@
 static void
 katana_restart(char *cmd)
 {
-	volatile ulong i = 10000000;
+	ulong	i = 10000000;
 
 	/* issue hard reset to the reset command register */
-	out_8((volatile char *)(cpld_base + KATANA_CPLD_RST_CMD),
-		KATANA_CPLD_RST_CMD_HR);
+	out_8(cpld_base + KATANA_CPLD_RST_CMD, KATANA_CPLD_RST_CMD_HR);
 
 	while (i-- > 0) ;
 	panic("restart failed\n");
@@ -561,6 +635,14 @@
 static void
 katana_halt(void)
 {
+	u8	v;
+
+	if (katana_id == KATANA_ID_752I) {
+		   v = in_8(cpld_base + HSL_PLD_BASE + HSL_PLD_HOT_SWAP_OFF);
+		   v |= HSL_PLD_HOT_SWAP_LED_BIT;
+		   out_8(cpld_base + HSL_PLD_BASE + HSL_PLD_HOT_SWAP_OFF, v);
+	}
+
 	while (1) ;
 	/* NOTREACHED */
 }
@@ -598,12 +680,13 @@
 	}
 
 	seq_printf(m, "product ID\t: 0x%x\n",
-		   in_8((volatile char *)(cpld_base + KATANA_CPLD_PRODUCT_ID)));
+		   in_8(cpld_base + KATANA_CPLD_PRODUCT_ID));
 	seq_printf(m, "hardware rev\t: 0x%x\n",
-		   in_8((volatile char *)(cpld_base+KATANA_CPLD_HARDWARE_VER)));
+		   in_8(cpld_base+KATANA_CPLD_HARDWARE_VER));
 	seq_printf(m, "PLD rev\t\t: 0x%x\n",
-		   in_8((volatile char *)(cpld_base + KATANA_CPLD_PLD_VER)));
-	seq_printf(m, "PLB freq\t: %ldMhz\n", katana_bus_freq() / 1000000);
+		   in_8(cpld_base + KATANA_CPLD_PLD_VER));
+	seq_printf(m, "PLB freq\t: %ldMhz\n",
+		(long)katana_bus_freq() / 1000000);
 	seq_printf(m, "PCI\t\t: %sMonarch\n", katana_is_monarch()? "" : "Non-");
 
 	return 0;
@@ -612,23 +695,21 @@
 static void __init
 katana_calibrate_decr(void)
 {
-	ulong freq;
+	u32 freq;
 
 	freq = katana_bus_freq() / 4;
 
 	printk(KERN_INFO "time_init: decrementer frequency = %lu.%.6lu MHz\n",
-	       freq / 1000000, freq % 1000000);
+	       (long)freq / 1000000, (long)freq % 1000000);
 
 	tb_ticks_per_jiffy = freq / HZ;
 	tb_to_us = mulhwu_scale_factor(freq, 1000000);
-
-	return;
 }
 
 unsigned long __init
 katana_find_end_of_memory(void)
 {
-	return mv64x60_get_mem_size(KATANA_BRIDGE_REG_BASE,
+	return mv64x60_get_mem_size(CONFIG_MV64X60_NEW_BASE,
 		MV64x60_TYPE_MV64360);
 }
 
@@ -639,8 +720,6 @@
 	mtspr(DBAT2U, 0xf0001ffe);
 	mtspr(DBAT2L, 0xf000002a);
 	mb();
-
-	return;
 }
 
 #if defined(CONFIG_SERIAL_TEXT_DEBUG) && defined(CONFIG_SERIAL_MPSC_CONSOLE)
@@ -657,6 +736,23 @@
 {
 	parse_bootinfo(find_bootinfo());
 
+	/* ASSUMPTION:  If both r3 (bd_t pointer) and r6 (cmdline pointer)
+	 * are non-zero, then we should use the board info from the bd_t
+	 * structure and the cmdline pointed to by r6 instead of the
+	 * information from birecs, if any.  Otherwise, use the information
+	 * from birecs as discovered by the preceeding call to
+	 * parse_bootinfo().  This rule should work with both PPCBoot, which
+	 * uses a bd_t board info structure, and the kernel boot wrapper,
+	 * which uses birecs.
+	 */
+	if (r3 && r6) {
+		/* copy board info structure */
+		memcpy( (void *)__res,(void *)(r3+KERNELBASE), sizeof(bd_t) );
+		/* copy command line */
+		*(char *)(r7+KERNELBASE) = 0;
+		strcpy(cmd_line, (char *)(r6+KERNELBASE));
+	}
+
 	isa_mem_base = 0;
 
 	ppc_md.setup_arch = katana_setup_arch;
@@ -672,7 +768,7 @@
 #if defined(CONFIG_SERIAL_TEXT_DEBUG) && defined(CONFIG_SERIAL_MPSC_CONSOLE)
 	ppc_md.setup_io_mappings = katana_map_io;
 	ppc_md.progress = mv64x60_mpsc_progress;
-	mv64x60_progress_init(KATANA_BRIDGE_REG_BASE);
+	mv64x60_progress_init(CONFIG_MV64X60_NEW_BASE);
 #endif
 
 #if defined(CONFIG_SERIAL_MPSC) || defined(CONFIG_MV643XX_ETH)
@@ -680,5 +776,4 @@
 #endif
 
 	katana_set_bat(); /* Need for katana_find_end_of_memory and progress */
-	return;
 }
diff -Nru a/arch/ppc/platforms/katana.h b/arch/ppc/platforms/katana.h
--- a/arch/ppc/platforms/katana.h	2005-02-15 15:11:59 -07:00
+++ b/arch/ppc/platforms/katana.h	2005-02-15 15:11:59 -07:00
@@ -19,18 +19,17 @@
  * PCI I/O space and 4 windows from the CPU bus to PCI MEM space.
  * We'll only use one PCI MEM window on each PCI bus.
  *
- * This is the CPU physical memory map (windows must be at least 1MB and start
+ * This is the CPU physical memory map (windows must be at least 64 KB and start
  * on a boundary that is a multiple of the window size):
  *
  *    0xff800000-0xffffffff      - Boot window
  *    0xf8400000-0xf85fffff      - Internal SRAM
- *    0xf8200000-0xf823ffff      - CPLD
- *    0xf8100000-0xf810ffff      - MV64360 Registers
- *    0xf8000000-0xf80fffff      - PLCC socket
- *    0xf0000000-0xf01fffff	 - Consistent memory pool
- *    0xe8000000-0xefffffff      - soldered flash
- *    0xc0000000-0xc0ffffff      - PCI I/O
- *    0x80000000-0xbfffffff      - PCI MEM
+ *    0xf8200000-0xf83fffff      - CPLD
+ *    0xf8100000-0xf810ffff      - MV64360 Registers (CONFIG_MV64X60_NEW_BASE)
+ *    0xf8000000-0xf80fffff      - Socketed FLASH
+ *    0xe0000000-0xefffffff      - Soldered FLASH
+ *    0xc0000000-0xc3ffffff      - PCI I/O (second hose)
+ *    0x80000000-0xbfffffff      - PCI MEM (second hose)
  */
 
 #ifndef __PPC_PLATFORMS_KATANA_H
@@ -38,33 +37,22 @@
 
 /* CPU Physical Memory Map setup. */
 #define KATANA_BOOT_WINDOW_BASE			0xff800000
+#define KATANA_BOOT_WINDOW_SIZE			0x00800000 /* 8 MB */
 #define KATANA_INTERNAL_SRAM_BASE		0xf8400000
 #define KATANA_CPLD_BASE			0xf8200000
-#define KATANA_BRIDGE_REG_BASE			0xf8100000
+#define KATANA_CPLD_SIZE			0x00200000 /* 2 MB */
 #define KATANA_SOCKET_BASE			0xf8000000
-#define KATANA_SOLDERED_FLASH_BASE		0xe8000000
-
-#define KATANA_BOOT_WINDOW_SIZE_ACTUAL		0x00800000 /* 8MB */
-#define KATANA_CPLD_SIZE_ACTUAL			0x00020000 /* 128KB */
-#define KATANA_SOCKETED_FLASH_SIZE_ACTUAL	0x00080000 /* 512KB */
-#define KATANA_SOLDERED_FLASH_SIZE_ACTUAL	0x02000000 /* 32MB */
-
-#define KATANA_BOOT_WINDOW_SIZE		max(MV64360_WINDOW_SIZE_MIN,	\
-		KATANA_BOOT_WINDOW_SIZE_ACTUAL)
-#define KATANA_CPLD_SIZE		max(MV64360_WINDOW_SIZE_MIN,	\
-		KATANA_CPLD_SIZE_ACTUAL)
-#define KATANA_SOCKETED_FLASH_SIZE	max(MV64360_WINDOW_SIZE_MIN,	\
-		KATANA_SOCKETED_FLASH_SIZE_ACTUAL)
-#define KATANA_SOLDERED_FLASH_SIZE	max(MV64360_WINDOW_SIZE_MIN,	\
-		KATANA_SOLDERED_FLASH_SIZE_ACTUAL)
+#define KATANA_SOCKETED_FLASH_SIZE		0x00100000 /* 1 MB */
+#define KATANA_SOLDERED_FLASH_BASE		0xe0000000
+#define KATANA_SOLDERED_FLASH_SIZE		0x10000000 /* 256 MB */
 
 #define KATANA_PCI1_MEM_START_PROC_ADDR         0x80000000
 #define KATANA_PCI1_MEM_START_PCI_HI_ADDR       0x00000000
 #define KATANA_PCI1_MEM_START_PCI_LO_ADDR       0x80000000
-#define KATANA_PCI1_MEM_SIZE                    0x40000000
+#define KATANA_PCI1_MEM_SIZE                    0x40000000 /* 1 GB */
 #define KATANA_PCI1_IO_START_PROC_ADDR          0xc0000000
 #define KATANA_PCI1_IO_START_PCI_ADDR           0x00000000
-#define KATANA_PCI1_IO_SIZE                     0x01000000
+#define KATANA_PCI1_IO_SIZE                     0x04000000 /* 64 MB */
 
 /* Board-specific IRQ info */
 #define  KATANA_PCI_INTA_IRQ_3750		64+8
@@ -138,6 +126,8 @@
 #define HSL_PLD_J4SGA_REG_OFF			0
 #define HSL_PLD_J4GA_REG_OFF			1
 #define HSL_PLD_J2GA_REG_OFF			2
+#define HSL_PLD_HOT_SWAP_OFF			6
+#define HSL_PLD_HOT_SWAP_LED_BIT		0x1
 #define GA_MASK					0x1f
 #define HSL_PLD_SIZE				0x1000
 #define K3750_GPP_GEO_ADDR_PINS			0xf8000000
@@ -162,7 +152,8 @@
 
 #define	KATANA_DEFAULT_BAUD			9600
 #define	KATANA_MPSC_CLK_SRC			8	  /* TCLK */
-#define	KATANA_MPSC_CLK_FREQ			133333333 /* 133.3333... MHz */
+
+#define	KATANA_MTD_MONITOR_SIZE			(1 << 20) /* 1 MB */
 
 #define	KATANA_ETH0_PHY_ADDR			12
 #define	KATANA_ETH1_PHY_ADDR			11
diff -Nru a/include/asm-ppc/mv64x60_defs.h b/include/asm-ppc/mv64x60_defs.h
--- a/include/asm-ppc/mv64x60_defs.h	2005-02-15 15:11:59 -07:00
+++ b/include/asm-ppc/mv64x60_defs.h	2005-02-15 15:11:59 -07:00
@@ -36,6 +36,8 @@
 #define GT64260_WINDOW_SIZE_MIN			0x00100000
 #define MV64360_WINDOW_SIZE_MIN			0x00010000
 
+#define	MV64x60_TCLK_FREQ_MAX			133333333U
+
 /* IRQ's for embedded controllers */
 #define	MV64x60_IRQ_DEV				1
 #define	MV64x60_IRQ_CPU_ERR			3
@@ -303,7 +305,7 @@
 #define	MV64360_SRAM_ERR_DATA_HI		0x03a0
 #define	MV64360_SRAM_ERR_PARITY			0x03a8
 
-#define	MV64360_SRAM_SIZE			0x00040000 /* 256 KB of SRAM */
+#define	MV64360_SRAM_SIZE			0x00200000 /* 2 MB of SRAM */
 
 /*
  *****************************************************************************

--------------040706070302080304050000--
