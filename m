Message-ID: <3EDFD0EA.50005@mvista.com>
Date: Thu, 05 Jun 2003 16:23:22 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: linuxppc_2_4_devel patch adding KGDB support to ev64260
References: <3EDFBA82.2010403@mvista.com> <20030605224031.GA14976@ip68-0-152-218.tc.ph.cox.net>
In-Reply-To: <20030605224031.GA14976@ip68-0-152-218.tc.ph.cox.net>
Content-Type: multipart/mixed;
 boundary="------------040604060506020809080706"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------040604060506020809080706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tom Rini wrote:

>On Thu, Jun 05, 2003 at 02:47:46PM -0700, Mark A. Greer wrote:
>
>
>
>>@@ -416,14 +481,10 @@
>> 		ppc_md.progress("ev64260_setup_arch: Enabling L2 cache", 0);
>>
>> 	/* Enable L2 and L3 caches (if 745x) */
>>-	val = _get_L2CR();
>>-	val |= L2CR_L2E;
>>-	_set_L2CR(val);
>>-
>>-	if (PVR_VER(mfspr(PVR)) == PVR_VER(PVR_7450)) {
>>-		val = _get_L3CR();
>>-		val |= L3CR_L3E;
>>-		_set_L3CR(val);
>>+	_set_L2CR(_get_L2CR() | L2CR_L2E);
>>+
>>+	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_L3CR) {
>>+		_set_L3CR(_get_L3CR() | L3CR_L3E);
>> 	}
>>
>> 	if ( ppc_md.progress )
>>
>>
>
>Redundant check.  _{get,set}_L3CR check for the appropriate cpufeature
>flags.
>
Gone.

>>@@ -808,7 +789,7 @@
>> {
>> 	extern char cmd_line[];
>>
>>-	cmd_line[0]=0;
>>+	cmd_line[0] = '\0';
>> #ifdef CONFIG_BLK_DEV_INITRD
>> 	initrd_start=initrd_end=0;
>> 	initrd_below_start_ok=0;
>>
>>
>
>Um, is that really needed?  It shouldn't be..
>
Nope.  Somehow, that line got injected into the code to I carried it
forward.  I won't anymore.  Its gone.

Attached is the new patch.

Mark

--------------040604060506020809080706
Content-Type: text/plain;
 name="ev64260.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ev64260.patch"

===== arch/ppc/config.in 1.185 vs edited =====
--- 1.185/arch/ppc/config.in	Fri May 30 12:35:33 2003
+++ edited/arch/ppc/config.in	Thu Jun  5 16:15:38 2003
@@ -212,6 +212,10 @@
    endmenu
 fi

+if [ "$CONFIG_EV64260" = "y" ]; then
+  define_bool CONFIG_GEN550 y
+fi
+
 if [ "$CONFIG_FORCE" = "y" -o "$CONFIG_MENF1" = "y" \
 	-o "$CONFIG_SANDPOINT" = "y" -o "$CONFIG_ZX4500" = "y" ]; then
   bool 'Enable MPC10x store gathering' CONFIG_MPC10X_STORE_GATHERING
===== arch/ppc/configs/ev64260_defconfig 1.12 vs edited =====
--- 1.12/arch/ppc/configs/ev64260_defconfig	Thu Apr 17 22:47:41 2003
+++ edited/arch/ppc/configs/ev64260_defconfig	Thu Jun  5 16:15:38 2003
@@ -34,11 +34,15 @@
 # CONFIG_ALL_PPC is not set
 # CONFIG_APUS is not set
 # CONFIG_WILLOW is not set
+# CONFIG_CPCI690 is not set
 # CONFIG_PCORE is not set
 # CONFIG_POWERPMC250 is not set
+# CONFIG_PPMC260 is not set
 CONFIG_EV64260=y
 # CONFIG_SPRUCE is not set
 # CONFIG_MENF1 is not set
+# CONFIG_PUMA_A is not set
+# CONFIG_HXEB100 is not set
 # CONFIG_LOPEC is not set
 # CONFIG_MCPN765 is not set
 # CONFIG_MVME5100 is not set
@@ -62,6 +66,7 @@
 CONFIG_GT64260_ORIG_REG_BASE=f1000000
 CONFIG_GT64260_NEW_BASE=y
 CONFIG_GT64260_NEW_REG_BASE=fbe00000
+CONFIG_GEN550=y
 # CONFIG_SMP is not set
 CONFIG_ALTIVEC=y
 CONFIG_TAU=y
@@ -94,6 +99,7 @@
 # Parallel port support
 #
 # CONFIG_PARPORT is not set
+# CONFIG_GEN_RTC is not set
 CONFIG_PPC_RTC=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyS0,115200 ip=on gt_mac0=feffff000000 gt_mac1=feffff000001 gt_mac2=feffff000002"
@@ -141,6 +147,9 @@
 CONFIG_MTD_PHYSMAP_START=fc000000
 CONFIG_MTD_PHYSMAP_LEN=02000000
 CONFIG_MTD_PHYSMAP_BUSWIDTH=4
+# CONFIG_MTD_PUMA_A is not set
+# CONFIG_MTD_HXEB100 is not set
+# CONFIG_MTD_PPMC260 is not set
 # CONFIG_MTD_PCI is not set
 # CONFIG_MTD_PCMCIA is not set

@@ -353,6 +362,7 @@
 # CONFIG_DGRS is not set
 # CONFIG_DM9102 is not set
 CONFIG_EEPRO100=y
+# CONFIG_EEPRO100_PIO is not set
 # CONFIG_E100 is not set
 # CONFIG_LNE390 is not set
 # CONFIG_FEALNX is not set
===== arch/ppc/platforms/ev64260.c 1.22 vs edited =====
--- 1.22/arch/ppc/platforms/ev64260.c	Fri Feb 28 10:31:00 2003
+++ edited/arch/ppc/platforms/ev64260.c	Thu Jun  5 16:16:12 2003
@@ -6,7 +6,7 @@
  * Author: Mark A. Greer <mgreer@mvista.com>
  *
  * 2001-2003 (c) MontaVista, Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This programr
+ * the terms of the GNU General Public License version 2.  This program
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
@@ -32,7 +32,7 @@
 #include <linux/fs.h>
 #include <linux/seq_file.h>

-#if     !defined(CONFIG_GT64260_CONSOLE)
+#if !defined(CONFIG_GT64260_CONSOLE)
 #include <linux/serial.h>
 #endif

@@ -55,6 +55,9 @@
 bd_t	ppcboot_bd;
 int	ppcboot_bd_valid=0;

+extern void gen550_progress(char *, unsigned short);
+extern void gen550_init(int, struct serial_struct *);
+

 static const unsigned int cpu_7xx[16] = { /* 7xx & 74xx (but not 745x) */
 	18, 15, 14, 2, 4, 13, 5, 9, 6, 11, 8, 10, 16, 12, 7, 0
@@ -382,25 +385,87 @@
 	return;
 }

-#define IS_PVR_750CX(p) (						\
-	   PVR_REV((p) & 0xFFF0) == 0x0100				\
-	|| PVR_REV((p) & 0xFF00) == 0x2200				\
-	|| PVR_REV((p) & 0xFF00) == 0x3300				\
-	)
-
+#if defined(CONFIG_SERIAL) && !defined(CONFIG_GT64260_CONSOLE)
 static void __init
-ev64260_setup_arch(void)
+ev64260_early_serial_map(void)
 {
-	uint	val;
-#if     !defined(CONFIG_GT64260_CONSOLE)
 	struct serial_struct    serial_req;
+	static char		first_time = 1;
+
+	if (first_time) {
+		memset(&serial_req, 0, sizeof(serial_req));
+
+		serial_req.line = 0;
+		serial_req.baud_base = BASE_BAUD;
+		serial_req.port = 0;
+		serial_req.irq = EV64260_UART_0_IRQ;
+		serial_req.flags = STD_COM_FLAGS;
+		serial_req.io_type = SERIAL_IO_MEM;
+		serial_req.iomem_base =
+			ioremap(EV64260_SERIAL_0, EV64260_UART_SIZE);
+		serial_req.iomem_reg_shift = 2;
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+		gen550_init(0, &serial_req);
+#endif
+
+		if (early_serial_setup(&serial_req) != 0) {
+			printk("Early serial init of port 0 failed\n");
+		}
+
+		/* Assume early_serial_setup() doesn't modify serial_req */
+		serial_req.line = 1;
+		serial_req.baud_base = BASE_BAUD;
+		serial_req.port = 1;
+		serial_req.irq = EV64260_UART_1_IRQ;
+		serial_req.iomem_base =
+			ioremap(EV64260_SERIAL_1, EV64260_UART_SIZE);
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+		gen550_init(1, &serial_req);
 #endif

+		if (early_serial_setup(&serial_req) != 0) {
+			printk("Early serial init of port 1 failed\n");
+		}
+
+		first_time = 0;
+	}
+
+	return;
+}
+#elif defined(CONFIG_GT64260_CONSOLE)
+static void __init
+ev64260_early_serial_map(void)
+{
+#ifdef	CONFIG_KGDB
+	static char	first_time = 1;
+
+
+#if defined(CONFIG_KGDB_TTYS0)
+#define KGDB_PORT 0
+#elif defined(CONFIG_KGDB_TTYS1)
+#define KGDB_PORT 1
+#else
+#error "Invalid kgdb_tty port"
+#endif
+
+	if (first_time) {
+		gt_early_mpsc_init(KGDB_PORT, B9600|CS8|CREAD|HUPCL|CLOCAL);
+		first_time = 0;
+	}
+
+	return;
+#endif
+}
+#endif
+
+static void __init
+ev64260_setup_arch(void)
+{
 	if ( ppc_md.progress )
 		ppc_md.progress("ev64260_setup_arch: enter", 0);

-	loops_per_jiffy = ev64260_get_cpu_speed() / HZ;
-
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
 		ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
@@ -416,15 +481,8 @@
 		ppc_md.progress("ev64260_setup_arch: Enabling L2 cache", 0);

 	/* Enable L2 and L3 caches (if 745x) */
-	val = _get_L2CR();
-	val |= L2CR_L2E;
-	_set_L2CR(val);
-
-	if (PVR_VER(mfspr(PVR)) == PVR_VER(PVR_7450)) {
-		val = _get_L3CR();
-		val |= L3CR_L3E;
-		_set_L3CR(val);
-	}
+	_set_L2CR(_get_L2CR() | L2CR_L2E);
+	_set_L3CR(_get_L3CR() | L3CR_L3E);

 	if ( ppc_md.progress )
 		ppc_md.progress("ev64260_setup_arch: Initializing bridge", 0);
@@ -438,26 +496,8 @@
 #ifdef	CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #endif
-#if	!defined(CONFIG_GT64260_CONSOLE)
-	memset(&serial_req, 0, sizeof(serial_req));
-	serial_req.line = 0;
-	serial_req.baud_base = BASE_BAUD;
-	serial_req.port = 0;
-	serial_req.irq = EV64260_UART_0_IRQ;
-	serial_req.flags = STD_COM_FLAGS;
-	serial_req.io_type = SERIAL_IO_MEM;
-	serial_req.iomem_base = ioremap(EV64260_SERIAL_0, EV64260_UART_SIZE);
-	serial_req.iomem_reg_shift = 2;
-
-	if (early_serial_setup(&serial_req) != 0) {
-		printk("Early serial init of port 0 failed\n");
-	}
-
-	/* Assume early_serial_setup() doesn't modify serial_req */
-	serial_req.line = 1;
-	serial_req.port = 1;
-	serial_req.irq = EV64260_UART_1_IRQ;
-	serial_req.iomem_base = ioremap(EV64260_SERIAL_1, EV64260_UART_SIZE);
+#if defined(CONFIG_SERIAL) || defined(CONFIG_GT64260_CONSOLE)
+	ev64260_early_serial_map();
 #endif

 	printk(BOARD_VENDOR " " BOARD_MACHINE "\n");
@@ -716,89 +756,27 @@
 }
 #endif

-#if defined(CONFIG_SERIAL_TEXT_DEBUG)
-#if !defined(CONFIG_GT64260_CONSOLE)
-#include <linux/serialP.h>
-#include <linux/serial_reg.h>
-#include <asm/serial.h>
-
-static struct serial_state rs_table[RS_TABLE_SIZE] = {
-	SERIAL_PORT_DFNS	/* Defined in <asm/serial.h> */
-};
-
-static void
-ev64260_16550_progress(char *s, unsigned short hex)
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
-		                ;
-	        *(volatile unsigned char *)com_port = c;
-
-		if (c == '\n') {
-			while ((*((volatile unsigned char *)com_port +
-				(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-					;
-	        	*(volatile unsigned char *)com_port = '\r';
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
-#endif	/* !CONFIG_GT64260_CONSOLE */
-#endif	/* CONFIG_SERIAL_TEXT_DEBUG */
-
-#if !defined(CONFIG_USE_PPCBOOT) || defined(CONFIG_SERIAL_TEXT_DEBUG)
+#if !defined(CONFIG_USE_PPCBOOT)
 /*
- * Set BAT 3 to map 0xf0000000 to end of physical memory space.
+ * Set BAT 3 to map 0xfb000000 to 0xfc000000 of physical memory space.
  */
 static __inline__ void
 ev64260_set_bat(void)
 {
-	unsigned long   bat3u, bat3l;
-	static int	mapping_set = 0;
-
-	if (!mapping_set) {
-
-		__asm__ __volatile__
-		("lis %0,0xf000\n\t"
-		 "ori %1,%0,0x002a\n\t"
-		 "ori %0,%0,0x1ffe\n\t"
-		 "mtspr 0x21e,%0\n\t"
-		 "mtspr 0x21f,%1\n\t"
-		 "isync\n\t"
-		 "sync\n\t"
-		 : "=r" (bat3u), "=r" (bat3l));
-
-		mapping_set = 1;
-	}
+	mb();
+	mtspr(DBAT1U, 0xfb0001fe);
+	mtspr(DBAT1L, 0xfb00002a);
+	mb();

 	return;
 }
 #endif

-#ifdef	CONFIG_SERIAL_TEXT_DEBUG
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
 static void __init
 ev64260_map_io(void)
 {
-	io_block_mapping(0xf8000000, 0xf8000000, 0x08000000, _PAGE_IO);
+	io_block_mapping(0xfb000000, 0xfb000000, 0x01000000, _PAGE_IO);
 }
 #endif

@@ -808,7 +786,6 @@
 {
 	extern char cmd_line[];

-	cmd_line[0]=0;
 #ifdef CONFIG_BLK_DEV_INITRD
 	initrd_start=initrd_end=0;
 	initrd_below_start_ok=0;
@@ -827,6 +804,8 @@
 	isa_io_base = GT64260_PCI_0_IO_START_PROC;
 	pci_dram_offset = GT64260_PCI_0_MEM_START_PROC;

+	loops_per_jiffy = ev64260_get_cpu_speed() / HZ;
+
 	ppc_md.setup_arch = ev64260_setup_arch;
 	ppc_md.show_cpuinfo = ev64260_show_cpuinfo;
 	ppc_md.irq_cannonicalize = NULL;
@@ -841,10 +820,6 @@

 	ppc_md.find_end_of_memory = ev64260_find_end_of_memory;

-#ifdef	CONFIG_SERIAL_TEXT_DEBUG
-	ppc_md.setup_io_mappings = ev64260_map_io;
-#endif
-
 	ppc_md.init = NULL;

 	ppc_md.time_init = todc_time_init;
@@ -855,39 +830,37 @@
 	ppc_md.nvram_write_val = todc_direct_write_val;

 	ppc_md.calibrate_decr = ev64260_calibrate_decr;
+
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
+        ppc_ide_md.ide_init_hwif = ev64260_ide_pci_init_hwif_ports;
+#endif
+
 #ifdef	CONFIG_GT64260_NEW_BASE
 	gt64260_base = CONFIG_GT64260_NEW_REG_BASE;
 #else
 	gt64260_base = CONFIG_GT64260_ORIG_REG_BASE;
 #endif
-
-#if !defined(CONFIG_USE_PPCBOOT) || defined(CONFIG_SERIAL_TEXT_DEBUG)
-	/*
-	 * If we're not using ppcboot as the firmware, then we need to map
-	 * in the mem ctlr's regs so we can determine the amount of memory
-	 * in the system.
-	 * Also, if progress msgs are being used, have to map in either the
-	 * UART's regs or the MPSC's regs.
-	 * All of this is done by ev64260_set_bat() and ev64260_map_io().
-	 */
-	/* Sanity check so ev64260_set_bat(), etc. work */
-	if (gt64260_base < 0xf8000000) {
-		printk("Bridge's Base Address (0x%x) should be >= 0xf8000000\n",
-			gt64260_base);
-	}
 	ev64260_set_bat();
-#endif

-#ifdef	CONFIG_SERIAL_TEXT_DEBUG
-#ifdef	CONFIG_GT64260_CONSOLE
-	ppc_md.progress = gt64260_mpsc_progress; /* embedded UART */
-#else
-	ppc_md.progress = ev64260_16550_progress; /* Dev module DUART */
+#ifdef	CONFIG_SERIAL
+#if defined(CONFIG_SERIAL_TEXT_DEBUG)
+	ppc_md.setup_io_mappings = ev64260_map_io;
+	ppc_md.progress = gen550_progress;
 #endif
-#endif /* CONFIG_SERIAL_TEXT_DEBUG */
+#if defined(CONFIG_KGDB)
+	ppc_md.setup_io_mappings = ev64260_map_io;
+	ppc_md.early_serial_map = ev64260_early_serial_map;
+#endif
+#elif defined(CONFIG_GT64260_CONSOLE)
+#ifdef	CONFIG_SERIAL_TEXT_DEBUG
+	ppc_md.setup_io_mappings = ev64260_map_io;
+	ppc_md.progress = gt64260_mpsc_progress;
+#endif	/* CONFIG_SERIAL_TEXT_DEBUG */
+#ifdef	CONFIG_KGDB
+	ppc_md.setup_io_mappings = ev64260_map_io;
+	ppc_md.early_serial_map = ev64260_early_serial_map;
+#endif	/* CONFIG_KGDB */

-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-        ppc_ide_md.ide_init_hwif = ev64260_ide_pci_init_hwif_ports;
 #endif

 	return;
===== arch/ppc/platforms/ev64260.h 1.13 vs edited =====
--- 1.13/arch/ppc/platforms/ev64260.h	Fri Feb 28 10:31:00 2003
+++ edited/arch/ppc/platforms/ev64260.h	Thu Jun  5 16:15:38 2003
@@ -77,6 +77,15 @@
 #define	EV64260_UART_END		((EV64260_UART_BASE +		\
 					EV64260_UART_SIZE - 1) & 0xfff00000)

+/*
+ * Board-specific IRQ info
+ */
+#define	EV64260_UART_0_IRQ		85
+#define	EV64260_UART_1_IRQ		86
+
+#define	EV64260_PCI_0_IRQ		91
+#define	EV64260_PCI_1_IRQ		93
+
 #if	!defined(CONFIG_GT64260_CONSOLE)
 /*
  * Serial driver setup.
@@ -84,7 +93,7 @@
 #define EV64260_SERIAL_0		(EV64260_UART_BASE + 0x20)
 #define EV64260_SERIAL_1		EV64260_UART_BASE

-#define BASE_BAUD ( 3686400 / 16 )
+#define BASE_BAUD	( 3686400 / 16 )	/* 115200 */

 #ifdef CONFIG_SERIAL_MANY_PORTS
 #define RS_TABLE_SIZE	64
@@ -100,8 +109,12 @@

 /* Required for bootloader's ns16550.c code */
 #define STD_SERIAL_PORT_DFNS 						\
-        { 0, BASE_BAUD, EV64260_SERIAL_0, 85, STD_COM_FLAGS, /* ttyS0 */\
-	iomem_base: (u8 *)EV64260_SERIAL_0,				\
+        { 0, BASE_BAUD, EV64260_SERIAL_0, EV64260_UART_0_IRQ, STD_COM_FLAGS, \
+	iomem_base: (u8 *)EV64260_SERIAL_0,	/* ttyS0 */		\
+	iomem_reg_shift: 2,						\
+	io_type: SERIAL_IO_MEM },					\
+        { 0, BASE_BAUD, EV64260_SERIAL_1, EV64260_UART_1_IRQ, STD_COM_FLAGS, \
+	iomem_base: (u8 *)EV64260_SERIAL_1,	/* ttyS1 */		\
 	iomem_reg_shift: 2,						\
 	io_type: SERIAL_IO_MEM },

@@ -110,15 +123,6 @@
 #else /* if defined(CONFIG_GT64260_CONSOLE) */
 #define SERIAL_PORT_DFNS
 #endif /* !defined(CONFIG_GT64260_CONSOLE) */
-
-/*
- * Board-specific IRQ info
- */
-#define	EV64260_UART_0_IRQ		85
-#define	EV64260_UART_1_IRQ		86
-
-#define	EV64260_PCI_0_IRQ		91
-#define	EV64260_PCI_1_IRQ		93

 #endif /* CONFIG_EV64260 */


--------------040604060506020809080706--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
