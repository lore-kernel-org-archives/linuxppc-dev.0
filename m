Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id F1FC767A6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Mar 2005 03:45:08 +1100 (EST)
Message-ID: <4230797D.8020108@mvista.com>
Date: Thu, 10 Mar 2005 09:44:45 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------050109090406050508080205"
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 2.6.12] PPC32: Add rtc hooks to katana + fw bug workaround
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
--------------050109090406050508080205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Add rtc hooks to katana and workaround firmware bug.

- Now that the mv64xxx i2c and m41t00 i2c rtc drivers are in the source 
base, add hooks to the katana file to use that rtc.
- A recent version of the katana firmware incorrectly changes the 
mv64x60's pci vendor & device id so this patch puts back the proper values.
- Misc. cleanup and update of the default config file.

Please apply.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>

--------------050109090406050508080205
Content-Type: text/plain;
 name="katana_rtc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="katana_rtc.patch"

diff -Nru a/arch/ppc/configs/katana_defconfig b/arch/ppc/configs/katana_defconfig
--- a/arch/ppc/configs/katana_defconfig	2005-03-10 09:34:32 -07:00
+++ b/arch/ppc/configs/katana_defconfig	2005-03-10 09:34:32 -07:00
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc4
-# Tue Feb 15 14:27:12 2005
+# Linux kernel version: 2.6.11
+# Tue Mar  8 17:31:00 2005
 #
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
@@ -36,6 +36,7 @@
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -45,6 +46,7 @@
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -70,6 +72,7 @@
 CONFIG_ALTIVEC=y
 # CONFIG_TAU is not set
 # CONFIG_CPU_FREQ is not set
+# CONFIG_83xx is not set
 CONFIG_PPC_STD_MMU=y
 CONFIG_NOT_COHERENT_CACHE=y
 
@@ -93,6 +96,7 @@
 # CONFIG_PRPMC750 is not set
 # CONFIG_PRPMC800 is not set
 # CONFIG_SANDPOINT is not set
+# CONFIG_RADSTONE_PPC7D is not set
 # CONFIG_ADIR is not set
 # CONFIG_K2 is not set
 # CONFIG_PAL4 is not set
@@ -428,7 +432,6 @@
 # CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
 CONFIG_E100=y
-# CONFIG_E100_NAPI is not set
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
 # CONFIG_NE2K_PCI is not set
@@ -453,6 +456,10 @@
 # CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
+CONFIG_MV643XX_ETH=y
+CONFIG_MV643XX_ETH_0=y
+CONFIG_MV643XX_ETH_1=y
+CONFIG_MV643XX_ETH_2=y
 
 #
 # Ethernet (10000 Mbit)
@@ -575,7 +582,90 @@
 #
 # I2C support
 #
-# CONFIG_I2C is not set
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+
+#
+# I2C Algorithms
+#
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_I810 is not set
+# CONFIG_I2C_ISA is not set
+# CONFIG_I2C_MPC is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PIIX4 is not set
+# CONFIG_I2C_PROSAVAGE is not set
+# CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_SCx200_ACB is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+# CONFIG_I2C_VOODOO3 is not set
+# CONFIG_I2C_PCA_ISA is not set
+CONFIG_I2C_MV64XXX=y
+
+#
+# Hardware Sensors Chip support
+#
+# CONFIG_I2C_SENSOR is not set
+# CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ADM1025 is not set
+# CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ASB100 is not set
+# CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_FSCHER is not set
+# CONFIG_SENSORS_FSCPOS is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM77 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
+# CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM87 is not set
+# CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_SIS5595 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_VIA686A is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83627HF is not set
+
+#
+# Other I2C Chip support
+#
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_RTC8564 is not set
+CONFIG_SENSORS_M41T00=y
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
 
 #
 # Dallas's 1-wire bus
@@ -753,6 +843,7 @@
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
+# CONFIG_PRINTK_TIME is not set
 
 #
 # Security options
diff -Nru a/arch/ppc/platforms/katana.c b/arch/ppc/platforms/katana.c
--- a/arch/ppc/platforms/katana.c	2005-03-10 09:34:32 -07:00
+++ b/arch/ppc/platforms/katana.c	2005-03-10 09:34:32 -07:00
@@ -3,7 +3,7 @@
  *
  * Board setup routines for the Artesyn Katana cPCI boards.
  *
- * Athor: Tim Montgomery <timm@artesyncp.com>
+ * Author: Tim Montgomery <timm@artesyncp.com>
  * Maintained by: Mark A. Greer <mgreer@mvista.com>
  *
  * Based on code done by Rabeeh Khoury - rabeeh@galileo.co.il
@@ -50,6 +50,8 @@
 static u32		katana_flash_size_0;
 static u32		katana_flash_size_1;
 
+static u32		katana_bus_frequency;
+
 unsigned char	__res[sizeof(bd_t)];
 
 /* PCI Interrupt routing */
@@ -183,44 +185,102 @@
 }
 
 static void __init
-katana_enable_ipmi(void)
+katana_setup_bridge(void)
 {
-	u8 reset_out;
+	struct pci_controller hose;
+	struct mv64x60_setup_info si;
+	void __iomem *vaddr;
+	int i;
+	u16 val;
+	u8 save_exclude;
 
-	/* Enable access to IPMI ctlr by clearing IPMI PORTSEL bit in CPLD */
-	reset_out = in_8(cpld_base + KATANA_CPLD_RESET_OUT);
-	reset_out &= ~KATANA_CPLD_RESET_OUT_PORTSEL;
-	out_8(cpld_base + KATANA_CPLD_RESET_OUT, reset_out);
-}
+	/*
+	 * Some versions of the Katana firmware mistakenly change the vendor
+	 * & device id fields in the bridge's pci device (visible via pci
+	 * config accesses).  This breaks mv64x60_init() because those values
+	 * are used to identify the type of bridge that's there.  Artesyn
+	 * claims that the subsystem vendor/device id's will have the correct
+	 * Marvell values so this code puts back the correct values from there.
+	 */
+	memset(&hose, 0, sizeof(hose));
+	vaddr = ioremap(CONFIG_MV64X60_NEW_BASE, MV64x60_INTERNAL_SPACE_SIZE);
+	setup_indirect_pci_nomap(&hose, vaddr + MV64x60_PCI0_CONFIG_ADDR,
+		vaddr + MV64x60_PCI0_CONFIG_DATA);
+	save_exclude = mv64x60_pci_exclude_bridge;
+	mv64x60_pci_exclude_bridge = 0;
+
+	early_read_config_word(&hose, 0, PCI_DEVFN(0, 0), PCI_VENDOR_ID, &val);
+
+	if (val != PCI_VENDOR_ID_MARVELL) {
+		early_read_config_word(&hose, 0, PCI_DEVFN(0, 0),
+			PCI_SUBSYSTEM_VENDOR_ID, &val);
+		early_write_config_word(&hose, 0, PCI_DEVFN(0, 0),
+			PCI_VENDOR_ID, val);
+		early_read_config_word(&hose, 0, PCI_DEVFN(0, 0),
+			PCI_SUBSYSTEM_ID, &val);
+		early_write_config_word(&hose, 0, PCI_DEVFN(0, 0),
+			PCI_DEVICE_ID, val);
+	}
 
-static u32
-katana_bus_freq(void)
-{
-	u8 bd_cfg_0;
+	mv64x60_pci_exclude_bridge = save_exclude;
+	iounmap(vaddr);
 
-	bd_cfg_0 = in_8(cpld_base + KATANA_CPLD_BD_CFG_0);
+	memset(&si, 0, sizeof(si));
 
-	switch (bd_cfg_0 & KATANA_CPLD_BD_CFG_0_SYSCLK_MASK) {
-	case KATANA_CPLD_BD_CFG_0_SYSCLK_200:
-		return 200000000;
-		break;
+	si.phys_reg_base = CONFIG_MV64X60_NEW_BASE;
 
-	case KATANA_CPLD_BD_CFG_0_SYSCLK_166:
-		return 166666666;
-		break;
+	si.pci_1.enable_bus = 1;
+	si.pci_1.pci_io.cpu_base = KATANA_PCI1_IO_START_PROC_ADDR;
+	si.pci_1.pci_io.pci_base_hi = 0;
+	si.pci_1.pci_io.pci_base_lo = KATANA_PCI1_IO_START_PCI_ADDR;
+	si.pci_1.pci_io.size = KATANA_PCI1_IO_SIZE;
+	si.pci_1.pci_io.swap = MV64x60_CPU2PCI_SWAP_NONE;
+	si.pci_1.pci_mem[0].cpu_base = KATANA_PCI1_MEM_START_PROC_ADDR;
+	si.pci_1.pci_mem[0].pci_base_hi = KATANA_PCI1_MEM_START_PCI_HI_ADDR;
+	si.pci_1.pci_mem[0].pci_base_lo = KATANA_PCI1_MEM_START_PCI_LO_ADDR;
+	si.pci_1.pci_mem[0].size = KATANA_PCI1_MEM_SIZE;
+	si.pci_1.pci_mem[0].swap = MV64x60_CPU2PCI_SWAP_NONE;
+	si.pci_1.pci_cmd_bits = 0;
+	si.pci_1.latency_timer = 0x80;
 
-	case KATANA_CPLD_BD_CFG_0_SYSCLK_133:
-		return 133333333;
-		break;
+	for (i = 0; i < MV64x60_CPU2MEM_WINDOWS; i++) {
+#if defined(CONFIG_NOT_COHERENT_CACHE)
+		si.cpu_prot_options[i] = 0;
+		si.enet_options[i] = MV64360_ENET2MEM_SNOOP_NONE;
+		si.mpsc_options[i] = MV64360_MPSC2MEM_SNOOP_NONE;
+		si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_NONE;
 
-	case KATANA_CPLD_BD_CFG_0_SYSCLK_100:
-		return 100000000;
-		break;
+		si.pci_1.acc_cntl_options[i] =
+		    MV64360_PCI_ACC_CNTL_SNOOP_NONE |
+		    MV64360_PCI_ACC_CNTL_SWAP_NONE |
+		    MV64360_PCI_ACC_CNTL_MBURST_128_BYTES |
+		    MV64360_PCI_ACC_CNTL_RDSIZE_256_BYTES;
+#else
+		si.cpu_prot_options[i] = 0;
+		si.enet_options[i] = MV64360_ENET2MEM_SNOOP_NONE; /* errata */
+		si.mpsc_options[i] = MV64360_MPSC2MEM_SNOOP_NONE; /* errata */
+		si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_NONE; /* errata */
 
-	default:
-		return 133333333;
-		break;
+		si.pci_1.acc_cntl_options[i] =
+		    MV64360_PCI_ACC_CNTL_SNOOP_WB |
+		    MV64360_PCI_ACC_CNTL_SWAP_NONE |
+		    MV64360_PCI_ACC_CNTL_MBURST_32_BYTES |
+		    MV64360_PCI_ACC_CNTL_RDSIZE_32_BYTES;
+#endif
 	}
+
+	/* Lookup PCI host bridges */
+	if (mv64x60_init(&bh, &si))
+		printk(KERN_WARNING "Bridge initialization failed.\n");
+
+	pci_dram_offset = 0; /* sys mem at same addr on PCI & cpu bus */
+	ppc_md.pci_swizzle = common_swizzle;
+	ppc_md.pci_map_irq = katana_map_irq;
+	ppc_md.pci_exclude_device = mv64x60_pci_exclude_device;
+
+	mv64x60_set_bus(&bh, 1, 0);
+	bh.hose_b->first_busno = 0;
+	bh.hose_b->last_busno = 0xff;
 }
 
 /* Bridge & platform setup routines */
@@ -356,138 +416,16 @@
 }
 
 static void __init
-katana_setup_bridge(void)
-{
-	struct mv64x60_setup_info si;
-	int i;
-
-	memset(&si, 0, sizeof(si));
-
-	si.phys_reg_base = CONFIG_MV64X60_NEW_BASE;
-
-	si.pci_1.enable_bus = 1;
-	si.pci_1.pci_io.cpu_base = KATANA_PCI1_IO_START_PROC_ADDR;
-	si.pci_1.pci_io.pci_base_hi = 0;
-	si.pci_1.pci_io.pci_base_lo = KATANA_PCI1_IO_START_PCI_ADDR;
-	si.pci_1.pci_io.size = KATANA_PCI1_IO_SIZE;
-	si.pci_1.pci_io.swap = MV64x60_CPU2PCI_SWAP_NONE;
-	si.pci_1.pci_mem[0].cpu_base = KATANA_PCI1_MEM_START_PROC_ADDR;
-	si.pci_1.pci_mem[0].pci_base_hi = KATANA_PCI1_MEM_START_PCI_HI_ADDR;
-	si.pci_1.pci_mem[0].pci_base_lo = KATANA_PCI1_MEM_START_PCI_LO_ADDR;
-	si.pci_1.pci_mem[0].size = KATANA_PCI1_MEM_SIZE;
-	si.pci_1.pci_mem[0].swap = MV64x60_CPU2PCI_SWAP_NONE;
-	si.pci_1.pci_cmd_bits = 0;
-	si.pci_1.latency_timer = 0x80;
-
-	for (i = 0; i < MV64x60_CPU2MEM_WINDOWS; i++) {
-#if defined(CONFIG_NOT_COHERENT_CACHE)
-		si.cpu_prot_options[i] = 0;
-		si.enet_options[i] = MV64360_ENET2MEM_SNOOP_NONE;
-		si.mpsc_options[i] = MV64360_MPSC2MEM_SNOOP_NONE;
-		si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_NONE;
-
-		si.pci_1.acc_cntl_options[i] =
-		    MV64360_PCI_ACC_CNTL_SNOOP_NONE |
-		    MV64360_PCI_ACC_CNTL_SWAP_NONE |
-		    MV64360_PCI_ACC_CNTL_MBURST_128_BYTES |
-		    MV64360_PCI_ACC_CNTL_RDSIZE_256_BYTES;
-#else
-		si.cpu_prot_options[i] = 0;
-		si.enet_options[i] = MV64360_ENET2MEM_SNOOP_NONE; /* errata */
-		si.mpsc_options[i] = MV64360_MPSC2MEM_SNOOP_NONE; /* errata */
-		si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_NONE; /* errata */
-
-		si.pci_1.acc_cntl_options[i] =
-		    MV64360_PCI_ACC_CNTL_SNOOP_WB |
-		    MV64360_PCI_ACC_CNTL_SWAP_NONE |
-		    MV64360_PCI_ACC_CNTL_MBURST_32_BYTES |
-		    MV64360_PCI_ACC_CNTL_RDSIZE_32_BYTES;
-#endif
-	}
-
-	/* Lookup PCI host bridges */
-	if (mv64x60_init(&bh, &si))
-		printk(KERN_WARNING "Bridge initialization failed.\n");
-
-	pci_dram_offset = 0; /* sys mem at same addr on PCI & cpu bus */
-	ppc_md.pci_swizzle = common_swizzle;
-	ppc_md.pci_map_irq = katana_map_irq;
-	ppc_md.pci_exclude_device = mv64x60_pci_exclude_device;
-
-	mv64x60_set_bus(&bh, 1, 0);
-	bh.hose_b->first_busno = 0;
-	bh.hose_b->last_busno = 0xff;
-}
-
-#ifdef CONFIG_MTD_PHYSMAP
-
-#ifndef MB
-#define MB	(1 << 20)
-#endif
-
-/*
- * MTD Layout depends on amount of soldered FLASH in system. Sizes in MB.
- *
- * FLASH Amount:	128	64	32	16
- * -------------	---	--	--	--
- * Monitor:		1	1	1	1
- * Primary Kernel:	1.5	1.5	1.5	1.5
- * Primary fs:		30	30	<end>	<end>
- * Secondary Kernel:	1.5	1.5	N/A	N/A
- * Secondary fs:	<end>	<end>	N/A	N/A
- * User: 		<overlays entire FLASH except for "Monitor" section>
- */
-static int __init
-katana_setup_mtd(void)
+katana_enable_ipmi(void)
 {
-	u32	size;
-	int	ptbl_entries;
-	static struct mtd_partition	*ptbl;
-
-	size = katana_flash_size_0 + katana_flash_size_1;
-	if (!size)
-		return -ENOMEM;
-
-	ptbl_entries = (size >= (64*MB)) ? 6 : 4;
-
-	if ((ptbl = kmalloc(ptbl_entries * sizeof(struct mtd_partition),
-		GFP_KERNEL)) == NULL) {
-
-		printk(KERN_WARNING "Can't alloc MTD partition table\n");
-		return -ENOMEM;
-	}
-	memset(ptbl, 0, ptbl_entries * sizeof(struct mtd_partition));
-
-	ptbl[0].name = "Monitor";
-	ptbl[0].size = KATANA_MTD_MONITOR_SIZE;
-	ptbl[1].name = "Primary Kernel";
-	ptbl[1].offset = MTDPART_OFS_NXTBLK;
-	ptbl[1].size = 0x00180000; /* 1.5 MB */
-	ptbl[2].name = "Primary Filesystem";
-	ptbl[2].offset = MTDPART_OFS_APPEND;
-	ptbl[2].size = MTDPART_SIZ_FULL; /* Correct for 16 & 32 MB */
-	ptbl[ptbl_entries-1].name = "User FLASH";
-	ptbl[ptbl_entries-1].offset = KATANA_MTD_MONITOR_SIZE;
-	ptbl[ptbl_entries-1].size = MTDPART_SIZ_FULL;
-
-	if (size >= (64*MB)) {
-		ptbl[2].size = 30*MB;
-		ptbl[3].name = "Secondary Kernel";
-		ptbl[3].offset = MTDPART_OFS_NXTBLK;
-		ptbl[3].size = 0x00180000; /* 1.5 MB */
-		ptbl[4].name = "Secondary Filesystem";
-		ptbl[4].offset = MTDPART_OFS_APPEND;
-		ptbl[4].size = MTDPART_SIZ_FULL;
-	}
+	u8 reset_out;
 
-	physmap_map.size = size;
-	physmap_set_partitions(ptbl, ptbl_entries);
-	return 0;
+	/* Enable access to IPMI ctlr by clearing IPMI PORTSEL bit in CPLD */
+	reset_out = in_8(cpld_base + KATANA_CPLD_RESET_OUT);
+	reset_out &= ~KATANA_CPLD_RESET_OUT_PORTSEL;
+	out_8(cpld_base + KATANA_CPLD_RESET_OUT, reset_out);
 }
 
-arch_initcall(katana_setup_mtd);
-#endif
-
 static void __init
 katana_setup_arch(void)
 {
@@ -528,6 +466,8 @@
 	katana_setup_peripherals();
 	katana_enable_ipmi();
 
+	katana_bus_frequency = katana_bus_freq(cpld_base);
+
 	printk(KERN_INFO "Artesyn Communication Products, LLC - Katana(TM)\n");
 	if (ppc_md.progress)
 		ppc_md.progress("katana_setup_arch: exit", 0);
@@ -550,7 +490,7 @@
 	 * TCLK == SysCLK but on 64460, they are separate pins.
 	 * SysCLK can go up to 200 MHz but TCLK can only go up to 133 MHz.
 	 */
-	pdata->brg_clk_freq = min(katana_bus_freq(), MV64x60_TCLK_FREQ_MAX);
+	pdata->brg_clk_freq = min(katana_bus_frequency, MV64x60_TCLK_FREQ_MAX);
 }
 #endif
 
@@ -606,6 +546,75 @@
 	return 0;
 }
 
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
+}
+
+arch_initcall(katana_setup_mtd);
+#endif
+
 static void
 katana_restart(char *cmd)
 {
@@ -672,7 +681,7 @@
 	seq_printf(m, "PLD rev\t\t: 0x%x\n",
 		   in_8(cpld_base + KATANA_CPLD_PLD_VER));
 	seq_printf(m, "PLB freq\t: %ldMhz\n",
-		(long)katana_bus_freq() / 1000000);
+		(long)katana_bus_frequency / 1000000);
 	seq_printf(m, "PCI\t\t: %sMonarch\n", katana_is_monarch()? "" : "Non-");
 
 	return 0;
@@ -683,7 +692,7 @@
 {
 	u32 freq;
 
-	freq = katana_bus_freq() / 4;
+	freq = katana_bus_frequency / 4;
 
 	printk(KERN_INFO "time_init: decrementer frequency = %lu.%.6lu MHz\n",
 	       (long)freq / 1000000, (long)freq % 1000000);
@@ -698,6 +707,27 @@
 	return mv64x60_get_mem_size(CONFIG_MV64X60_NEW_BASE,
 		MV64x60_TYPE_MV64360);
 }
+
+#if defined(CONFIG_I2C_MV64XXX) && defined(CONFIG_SENSORS_M41T00)
+extern ulong	m41t00_get_rtc_time(void);
+extern int	m41t00_set_rtc_time(ulong);
+
+static int __init
+katana_rtc_hookup(void)
+{
+	struct timespec	tv;
+
+	ppc_md.get_rtc_time = m41t00_get_rtc_time;
+	ppc_md.set_rtc_time = m41t00_set_rtc_time;
+
+	tv.tv_nsec = 0;
+	tv.tv_sec = (ppc_md.get_rtc_time)();
+	do_settimeofday(&tv);
+
+	return 0;
+}
+late_initcall(katana_rtc_hookup);
+#endif
 
 static inline void
 katana_set_bat(void)
diff -Nru a/arch/ppc/platforms/katana.h b/arch/ppc/platforms/katana.h
--- a/arch/ppc/platforms/katana.h	2005-03-10 09:34:32 -07:00
+++ b/arch/ppc/platforms/katana.h	2005-03-10 09:34:32 -07:00
@@ -3,7 +3,8 @@
  *
  * Definitions for Artesyn Katana750i/3750 board.
  *
- * Tim Montgomery <timm@artesyncp.com>
+ * Author: Tim Montgomery <timm@artesyncp.com>
+ * Maintained by: Mark A. Greer <mgreer@mvista.com>
  *
  * Based on code done by Rabeeh Khoury - rabeeh@galileo.co.il
  * Based on code done by Mark A. Greer <mgreer@mvista.com>
@@ -221,4 +222,34 @@
 
 #endif
 
-#endif				/* __PPC_PLATFORMS_KATANA_H */
+static inline u32
+katana_bus_freq(void __iomem *cpld_base)
+{
+	u8 bd_cfg_0;
+
+	bd_cfg_0 = in_8(cpld_base + KATANA_CPLD_BD_CFG_0);
+
+	switch (bd_cfg_0 & KATANA_CPLD_BD_CFG_0_SYSCLK_MASK) {
+	case KATANA_CPLD_BD_CFG_0_SYSCLK_200:
+		return 200000000;
+		break;
+
+	case KATANA_CPLD_BD_CFG_0_SYSCLK_166:
+		return 166666666;
+		break;
+
+	case KATANA_CPLD_BD_CFG_0_SYSCLK_133:
+		return 133333333;
+		break;
+
+	case KATANA_CPLD_BD_CFG_0_SYSCLK_100:
+		return 100000000;
+		break;
+
+	default:
+		return 133333333;
+		break;
+	}
+}
+
+#endif	/* __PPC_PLATFORMS_KATANA_H */

--------------050109090406050508080205--
