Message-ID: <3ED56385.8050904@mvista.com>
Date: Wed, 28 May 2003 18:33:57 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: linuxppc_2_4_devel patch for hxeb100
Content-Type: multipart/mixed;
 boundary="------------090809030506080205040901"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------090809030506080205040901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch enables KGDB and does some other minor fixups for the
hxeb100.  Dale Farnsworth has approved the patch.

Mark
--

--------------090809030506080205040901
Content-Type: text/plain;
 name="hxeb100.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hxeb100.patch"

===== arch/ppc/config.in 1.184 vs edited =====
--- 1.184/arch/ppc/config.in	Fri May 23 15:13:21 2003
+++ edited/arch/ppc/config.in	Tue May 27 15:14:30 2003
@@ -217,6 +217,10 @@
   bool 'Enable MPC10x store gathering' CONFIG_MPC10X_STORE_GATHERING
 fi

+if [ "$CONFIG_HXEB100" = "y" ]; then
+  define_bool CONFIG_GEN550 y
+fi
+
 if [ "$CONFIG_K2" = "y" ]; then
   bool 'Enable CPC710 data gathering' CONFIG_CPC710_DATA_GATHERING
 fi
===== arch/ppc/configs/hxeb100_defconfig 1.2 vs edited =====
--- 1.2/arch/ppc/configs/hxeb100_defconfig	Thu Apr 17 22:47:41 2003
+++ edited/arch/ppc/configs/hxeb100_defconfig	Wed May 28 15:17:12 2003
@@ -34,12 +34,15 @@
 # CONFIG_ALL_PPC is not set
 # CONFIG_APUS is not set
 # CONFIG_WILLOW is not set
+# CONFIG_CPCI690 is not set
 # CONFIG_PCORE is not set
 # CONFIG_POWERPMC250 is not set
+# CONFIG_PPMC260 is not set
 # CONFIG_EV64260 is not set
 # CONFIG_SPRUCE is not set
 # CONFIG_MENF1 is not set
 # CONFIG_PUMA_A is not set
+CONFIG_HXEB100=y
 # CONFIG_LOPEC is not set
 # CONFIG_MCPN765 is not set
 # CONFIG_MVME5100 is not set
@@ -51,7 +54,6 @@
 # CONFIG_K2 is not set
 # CONFIG_PAL4 is not set
 # CONFIG_GEMINI is not set
-CONFIG_HXEB100=y
 # CONFIG_ZX4500 is not set
 CONFIG_GT64260=y

@@ -63,6 +65,7 @@
 # CONFIG_USE_PPCBOOT is not set
 CONFIG_GT64260_ORIG_REG_BASE=F1000000
 # CONFIG_GT64260_NEW_BASE is not set
+CONFIG_GEN550=y
 CONFIG_SMP=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_ALTIVEC=y
@@ -98,9 +101,10 @@
 # Parallel port support
 #
 # CONFIG_PARPORT is not set
+# CONFIG_GEN_RTC is not set
 CONFIG_PPC_RTC=y
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyS0,9600 ip=on"
+CONFIG_CMDLINE="ip=on"

 #
 # Memory Technology Devices (MTD)
@@ -145,6 +149,7 @@
 # CONFIG_MTD_PUMA_A is not set
 CONFIG_MTD_HXEB100=y
 # CONFIG_MTD_HXEB100_BANK_B_FLASH is not set
+# CONFIG_MTD_PPMC260 is not set
 # CONFIG_MTD_PCI is not set
 # CONFIG_MTD_PCMCIA is not set

@@ -315,7 +320,7 @@
 # CONFIG_IDEDMA_ONLYDISK is not set
 CONFIG_BLK_DEV_IDEDMA=y
 CONFIG_IDEDMA_PCI_WIP=y
-CONFIG_BLK_DEV_ADMA=y
+# CONFIG_BLK_DEV_ADMA100 is not set
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_WDC_ALI15X3 is not set
@@ -329,7 +334,6 @@
 # CONFIG_HPT34X_AUTODMA is not set
 # CONFIG_BLK_DEV_HPT366 is not set
 # CONFIG_BLK_DEV_PIIX is not set
-# CONFIG_BLK_DEV_NFORCE is not set
 # CONFIG_BLK_DEV_NS87415 is not set
 # CONFIG_BLK_DEV_OPTI621 is not set
 # CONFIG_BLK_DEV_PDC202XX_OLD is not set
@@ -390,6 +394,7 @@
 # CONFIG_SCSI_AHA1740 is not set
 # CONFIG_SCSI_AACRAID is not set
 # CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC79XX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_DPT_I2O is not set
 # CONFIG_SCSI_ADVANSYS is not set
@@ -815,14 +820,5 @@
 #
 # Kernel hacking
 #
-CONFIG_DEBUG_KERNEL=y
-# CONFIG_MAGIC_SYSRQ is not set
-# CONFIG_DEBUG_HIGHMEM is not set
-# CONFIG_DEBUG_SLAB is not set
-# CONFIG_DEBUG_IOVIRT is not set
-# CONFIG_DEBUG_SPINLOCK is not set
-# CONFIG_DEBUG_WAITQ is not set
-# CONFIG_KGDB is not set
-# CONFIG_XMON is not set
-# CONFIG_BDI_SWITCH is not set
+# CONFIG_DEBUG_KERNEL is not set
 # CONFIG_SERIAL_TEXT_DEBUG is not set
===== arch/ppc/platforms/hxeb100.c 1.1 vs edited =====
--- 1.1/arch/ppc/platforms/hxeb100.c	Tue Apr  1 12:48:31 2003
+++ edited/arch/ppc/platforms/hxeb100.c	Wed May 28 18:30:57 2003
@@ -52,8 +52,12 @@
 ulong	hxeb100_mem_size = 0;
 bd_t	board_info;

-static const unsigned int cpu_7xx[16] = {
-	0, 15, 14, 0, 4, 13, 5, 9, 6, 11, 8, 10, 16, 12, 7, 0
+extern void gen550_progress(char *, unsigned short);
+extern void gen550_init(int, struct serial_struct *);
+
+static const unsigned int cpu_745x[2][16] = { /* PLL_EXT 0 & 1 */
+	{ 1, 15, 14,  2,  4, 13,  5,  9,  6, 11,  8, 10, 16, 12,  7,  0 },
+	{ 0, 30,  0,  2,  0, 26,  0, 18,  0, 22, 20, 24, 28, 32,  0,  0 }
 };

 TODC_ALLOC();
@@ -83,8 +87,11 @@
 static int
 hxeb100_get_cpu_speed(void)
 {
-	unsigned long hid1 = (mfspr(HID1) >> 13) & 0xf;
-	return hxeb100_get_bus_speed()*cpu_7xx[hid1]/2;
+	unsigned long	hid1, pll_ext;
+
+	hid1 = (mfspr(HID1) & 0x0001e000) >> 13;
+	pll_ext = 0; /* No way to read; must get from schematic */
+	return hxeb100_get_bus_speed() * cpu_745x[pll_ext][hid1]/2;
 }

 unsigned long __init
@@ -402,11 +409,53 @@
 	_set_L3CR(cpu0_l3val);
 }

+#ifdef	CONFIG_SERIAL
 static void __init
-hxeb100_setup_arch(void)
+hxeb100_early_serial_map(void)
 {
-	struct serial_struct serial_req;
+	struct serial_struct	serial_req;
+	static char		first_time = 1;
+
+	if (first_time) {
+		memset(&serial_req, 0, sizeof(serial_req));
+
+		serial_req.line = 0;
+		serial_req.baud_base = BASE_BAUD;
+		serial_req.port = 0;
+		serial_req.irq = HXEB100_UART_0_IRQ;
+		serial_req.flags = STD_COM_FLAGS;
+		serial_req.io_type = SERIAL_IO_MEM;
+		serial_req.iomem_base = ioremap(HXEB100_SERIAL_0,
+							HXEB100_UART_SIZE);
+		serial_req.iomem_reg_shift = 0;
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+		gen550_init(0, &serial_req);
+#endif
+
+		if (early_serial_setup(&serial_req) != 0)
+			printk("Early serial init of port 0 failed\n");
+
+		/* Assume early_serial_setup() doesn't modify serial_req */
+		serial_req.line = 1;
+		serial_req.port = 1;
+		serial_req.irq = HXEB100_UART_1_IRQ;
+		serial_req.iomem_base = ioremap(HXEB100_SERIAL_1,
+							HXEB100_UART_SIZE);
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+		gen550_init(1, &serial_req);
+#endif
+
+		if (early_serial_setup(&serial_req) != 0)
+			printk("Early serial init of port 1 failed\n");
+
+		first_time = 0;
+	}
+}
+#endif

+static void __init
+hxeb100_setup_arch(void)
+{
 	if ( ppc_md.progress )
 		ppc_md.progress("hxeb100_setup_arch: enter", 0);

@@ -440,27 +489,10 @@
 #ifdef	CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #endif
-	memset(&serial_req, 0, sizeof(serial_req));
-	serial_req.line = 0;
-	serial_req.baud_base = BASE_BAUD;
-	serial_req.port = 0;
-	serial_req.irq = HXEB100_UART_0_IRQ;
-	serial_req.flags = STD_COM_FLAGS;
-	serial_req.io_type = SERIAL_IO_MEM;
-	serial_req.iomem_base = ioremap(HXEB100_SERIAL_0, HXEB100_UART_SIZE);
-	serial_req.iomem_reg_shift = 0;
-
-	if (early_serial_setup(&serial_req) != 0)
-		printk("Early serial init of port 0 failed\n");
-
-	/* Assume early_serial_setup() doesn't modify serial_req */
-	serial_req.line = 1;
-	serial_req.port = 1;
-	serial_req.irq = HXEB100_UART_1_IRQ;
-	serial_req.iomem_base = ioremap(HXEB100_SERIAL_1, HXEB100_UART_SIZE);

-	if (early_serial_setup(&serial_req) != 0)
-		printk("Early serial init of port 1 failed\n");
+#ifdef	CONFIG_SERIAL
+	hxeb100_early_serial_map();
+#endif

 	gt64260_set_mac_addr(0, board_info.bi_enetaddr[0]);
 	gt64260_set_mac_addr(1, board_info.bi_enetaddr[1]);
@@ -533,58 +565,15 @@
 	return;
 }

-#ifdef CONFIG_SERIAL_TEXT_DEBUG
-#include <linux/serialP.h>
-#include <linux/serial_reg.h>
-#include <asm/serial.h>
-
-static struct serial_state rs_table[RS_TABLE_SIZE] = {
-	SERIAL_PORT_DFNS	/* Defined in <asm/serial.h> */
-};
-
-static void
-hxeb100_16550_progress(char *s, unsigned short hex)
-{
-	volatile char c;
-	volatile unsigned long com_port;
-	u16 shift;
-
-	com_port = rs_table[0].port;
-	shift = rs_table[0].iomem_reg_shift;
-
-	while ((c = *s++) != 0) {
-		while ((*((volatile unsigned char *)com_port +
-				(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-				;
-		*(volatile unsigned char *)com_port = c;
-
-		if (c == '\n') {
-			while ((*((volatile unsigned char *)com_port +
-				(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-					;
-			*(volatile unsigned char *)com_port = '\r';
-		}
-	}
-
-	/* Move to next line on */
-	while ((*((volatile unsigned char *)com_port +
-		(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-			;
-	*(volatile unsigned char *)com_port = '\n';
-	while ((*((volatile unsigned char *)com_port +
-		(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-			;
-	*(volatile unsigned char *)com_port = '\r';
-
-	return;
-}
-
+#ifdef	CONFIG_SERIAL
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
 static void __init
 hxeb100_map_io(void)
 {
 	io_block_mapping(0xf0000000, 0xf0000000, 0x10000000, _PAGE_IO);
 }
-#endif	/* CONFIG_SERIAL_TEXT_DEBUG */
+#endif
+#endif

 /*
  * Set BAT 3 to map 0xf0000000 to end of physical memory space.
@@ -592,17 +581,12 @@
 static __inline__ void
 hxeb100_set_bat(void)
 {
-	unsigned long   bat3u, bat3l;
+	mb();
+	mtspr(DBAT1U, 0xf0001ffe);
+	mtspr(DBAT1L, 0xf000002a);
+	mb();

-	__asm__ __volatile__(
-	" lis %0,0xf000\n \
-	  ori %1,%0,0x002a\n \
-	  ori %0,%0,0x1ffe\n \
-	  mtspr 0x21e,%0\n \
-	  mtspr 0x21f,%1\n \
-	  isync\n \
-	  sync "
-	: "=r" (bat3u), "=r" (bat3l));
+	return;
 }

 #ifdef DISABLE_USB_INTERRUPTS
@@ -934,6 +918,7 @@
 {
 	extern char cmd_line[];

+	cmd_line[0] = '\0';
 #ifdef CONFIG_BLK_DEV_INITRD
 	initrd_start=initrd_end=0;
 	initrd_below_start_ok=0;
@@ -959,10 +944,6 @@
 	ppc_md.halt = hxeb100_halt;

 	ppc_md.find_end_of_memory = hxeb100_find_end_of_memory;
-
-#ifdef	CONFIG_SERIAL_TEXT_DEBUG
-	ppc_md.setup_io_mappings = hxeb100_map_io;
-#endif
 	ppc_md.init = NULL;

 	ppc_md.time_init = todc_time_init;
@@ -995,10 +976,18 @@
 		printk("Bridge's Base Address (0x%x) should be >= 0xf0000000\n",
 			gt64260_base);
 	}
+
 	hxeb100_set_bat();

-#ifdef	CONFIG_SERIAL_TEXT_DEBUG
-	ppc_md.progress = hxeb100_16550_progress; /* Dev module DUART */
+#ifdef	CONFIG_SERIAL
+#if defined(CONFIG_SERIAL_TEXT_DEBUG)
+	ppc_md.setup_io_mappings = hxeb100_map_io;
+	ppc_md.progress = gen550_progress;
+#endif
+#if defined(CONFIG_KGDB)
+	ppc_md.setup_io_mappings = hxeb100_map_io;
+	ppc_md.early_serial_map = hxeb100_early_serial_map;
+#endif
 #endif

 	return;

--------------090809030506080205040901--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
