Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id A92BE67A76
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Mar 2005 03:08:11 +1100 (EST)
Message-ID: <422887D2.7020203@mvista.com>
Date: Fri, 04 Mar 2005 09:07:46 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------070809050105090705080000"
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: PATCH 2.6.11-rc5] ppc32: add Radstone PPC7D platform support
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
--------------070809050105090705080000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

ppc32: add Radstone PPC7D platform support

Radstone PPC7D are ppc7447A VME boards with Marvell Discovery-II,
dual GigE, dual PMC, 6 serial ports, keyboard/mouse, USB and optional
SCSI/VGA. This patch adds support for the PPC7D platform.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Mark A. Greer <mgreer@mvista.com>
-- 

--------------070809050105090705080000
Content-Type: text/plain;
 name="ppc7d.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc7d.patch"

Index: linux-2.6/arch/ppc/boot/simple/misc-radstone_ppc7d.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/ppc/boot/simple/misc-radstone_ppc7d.c	2005-03-03 21:42:04.000000000 +0000
@@ -0,0 +1,19 @@
+/*
+ * arch/ppc/boot/simple/misc-radstone_ppc7d.c
+ *
+ * Misc data for Radstone PPC7D board.
+ *
+ * Author: James Chapman <jchapman@katalix.com>
+ */
+
+#include <linux/types.h>
+#include <asm/reg.h>
+
+#include "../../platforms/radstone_ppc7d.h"
+
+#if defined(CONFIG_SERIAL_MPSC_CONSOLE)
+long	mv64x60_mpsc_clk_freq = PPC7D_MPSC_CLK_FREQ;;
+long	mv64x60_mpsc_clk_src = PPC7D_MPSC_CLK_SRC;
+long	mv64x60_mpsc_console_baud = PPC7D_DEFAULT_BAUD;
+#endif
+
Index: linux-2.6/arch/ppc/platforms/Makefile
===================================================================
--- linux-2.6.orig/arch/ppc/platforms/Makefile	2005-03-03 21:41:17.000000000 +0000
+++ linux-2.6/arch/ppc/platforms/Makefile	2005-03-03 21:42:04.000000000 +0000
@@ -39,6 +39,7 @@
 obj-$(CONFIG_PPLUS)		+= pplus.o
 obj-$(CONFIG_PRPMC750)		+= prpmc750.o
 obj-$(CONFIG_PRPMC800)		+= prpmc800.o
+obj-$(CONFIG_RADSTONE_PPC7D)	+= radstone_ppc7d.o
 obj-$(CONFIG_SANDPOINT)		+= sandpoint.o
 obj-$(CONFIG_SBC82xx)		+= sbc82xx.o
 obj-$(CONFIG_SPRUCE)		+= spruce.o
Index: linux-2.6/arch/ppc/platforms/radstone_ppc7d.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/ppc/platforms/radstone_ppc7d.c	2005-03-03 21:48:07.000000000 +0000
@@ -0,0 +1,1408 @@
+/*
+ * arch/ppc/platforms/radstone_ppc7d.c
+ *
+ * Board setup routines for the Radstone PPC7D boards.
+ *
+ * Author: James Chapman <jchapman@katalix.com>
+ *
+ * Based on code done by Rabeeh Khoury - rabeeh@galileo.co.il
+ * Based on code done by - Mark A. Greer <mgreer@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+/* Radstone PPC7D boards are rugged VME boards with PPC 7447A CPUs,
+ * Discovery-II, dual gigabit ethernet, dual PMC, USB, keyboard/mouse,
+ * 4 serial ports, 2 high speed serial ports (MPSCs) and optional
+ * SCSI / VGA.
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/major.h>
+#include <linux/initrd.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/ide.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/serial.h>
+#include <linux/tty.h>		/* for linux/serial_core.h */
+#include <linux/serial_core.h>
+#include <linux/mv643xx.h>
+#include <linux/netdevice.h>
+
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/time.h>
+#include <asm/dma.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/smp.h>
+#include <asm/vga.h>
+#include <asm/open_pic.h>
+#include <asm/i8259.h>
+#include <asm/todc.h>
+#include <asm/bootinfo.h>
+#include <asm/mpc10x.h>
+#include <asm/pci-bridge.h>
+#include <asm/mv64x60.h>
+#include <asm/i8259.h>
+
+#include "radstone_ppc7d.h"
+
+#undef DEBUG
+
+#define PPC7D_RST_PIN			17 	/* GPP17 */
+
+extern u32 mv64360_irq_base;
+
+static struct mv64x60_handle bh;
+static int ppc7d_has_alma;
+
+extern void gen550_progress(char *, unsigned short);
+extern void gen550_init(int, struct uart_port *);
+
+/* residual data */
+unsigned char __res[sizeof(bd_t)];
+
+/*****************************************************************************
+ * Serial port code
+ *****************************************************************************/
+
+#if defined(CONFIG_KGDB) || defined(CONFIG_SERIAL_TEXT_DEBUG)
+static void __init ppc7d_early_serial_map(void)
+{
+#if defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	mv64x60_progress_init(CONFIG_MV64X60_NEW_BASE);
+#elif defined(CONFIG_SERIAL_8250)
+	struct uart_port serial_req;
+
+	/* Setup serial port access */
+	memset(&serial_req, 0, sizeof(serial_req));
+	serial_req.uartclk = UART_CLK;
+	serial_req.irq = 4;
+	serial_req.flags = STD_COM_FLAGS;
+	serial_req.iotype = SERIAL_IO_MEM;
+	serial_req.membase = (u_char *) PPC7D_SERIAL_0;
+
+	gen550_init(0, &serial_req);
+	if (early_serial_setup(&serial_req) != 0)
+		printk(KERN_ERR "Early serial init of port 0 failed\n");
+
+	/* Assume early_serial_setup() doesn't modify serial_req */
+	serial_req.line = 1;
+	serial_req.irq = 3;
+	serial_req.membase = (u_char *) PPC7D_SERIAL_1;
+
+	gen550_init(1, &serial_req);
+	if (early_serial_setup(&serial_req) != 0)
+		printk(KERN_ERR "Early serial init of port 1 failed\n");
+#else
+#error CONFIG_KGDB || CONFIG_SERIAL_TEXT_DEBUG has no supported CONFIG_SERIAL_XXX
+#endif
+}
+#endif /* CONFIG_KGDB || CONFIG_SERIAL_TEXT_DEBUG */
+
+/*****************************************************************************
+ * Low-level board support code
+ *****************************************************************************/
+
+static unsigned long __init ppc7d_find_end_of_memory(void)
+{
+	bd_t *bp = (bd_t *) __res;
+
+	if (bp->bi_memsize)
+		return bp->bi_memsize;
+
+	return (256 * 1024 * 1024);
+}
+
+static void __init ppc7d_map_io(void)
+{
+	/* remove temporary mapping */
+	mtspr(SPRN_DBAT3U, 0x00000000);
+	mtspr(SPRN_DBAT3L, 0x00000000);
+
+	io_block_mapping(0xe8000000, 0xe8000000, 0x08000000, _PAGE_IO);
+	io_block_mapping(0xfe000000, 0xfe000000, 0x02000000, _PAGE_IO);
+}
+
+static void ppc7d_restart(char *cmd)
+{
+	u32 data;
+
+	/* Disable GPP17 interrupt */
+	data = mv64x60_read(&bh, MV64x60_GPP_INTR_MASK);
+	data &= ~(1 << PPC7D_RST_PIN);
+	mv64x60_write(&bh, MV64x60_GPP_INTR_MASK, data);
+
+	/* Configure MPP17 as GPP */
+	data = mv64x60_read(&bh, MV64x60_MPP_CNTL_2);
+	data &= ~(0x0000000f << 4);
+	mv64x60_write(&bh, MV64x60_MPP_CNTL_2, data);
+
+	/* Enable pin GPP17 for output */
+	data = mv64x60_read(&bh, MV64x60_GPP_IO_CNTL);
+	data |= (1 << PPC7D_RST_PIN);
+	mv64x60_write(&bh, MV64x60_GPP_IO_CNTL, data);
+
+	/* Toggle GPP9 pin to reset the board */
+	mv64x60_write(&bh, MV64x60_GPP_VALUE_CLR, 1 << PPC7D_RST_PIN);
+	mv64x60_write(&bh, MV64x60_GPP_VALUE_SET, 1 << PPC7D_RST_PIN);
+
+	for (;;) ;		/* Spin until reset happens */
+	/* NOTREACHED */
+}
+
+static void ppc7d_power_off(void)
+{
+	u32 data;
+
+	local_irq_disable();
+
+	/* Ensure that internal MV643XX watchdog is disabled.
+	 * The Disco watchdog uses MPP17 on this hardware.
+	 */
+	data = mv64x60_read(&bh, MV64x60_MPP_CNTL_2);
+	data &= ~(0x0000000f << 4);
+	mv64x60_write(&bh, MV64x60_MPP_CNTL_2, data);
+
+	data = mv64x60_read(&bh, MV64x60_WDT_WDC);
+	if (data & 0x80000000) {
+		mv64x60_write(&bh, MV64x60_WDT_WDC, 1 << 24);
+		mv64x60_write(&bh, MV64x60_WDT_WDC, 2 << 24);
+	}
+
+	for (;;) ;		/* No way to shut power off with software */
+	/* NOTREACHED */
+}
+
+static void ppc7d_halt(void)
+{
+	ppc7d_power_off();
+	/* NOTREACHED */
+}
+
+static unsigned long ppc7d_led_no_pulse;
+
+static int __init ppc7d_led_pulse_disable(char *str)
+{
+	ppc7d_led_no_pulse = 1;
+	return 1;
+}
+
+/* This kernel option disables the heartbeat pulsing of a board LED */
+__setup("ledoff", ppc7d_led_pulse_disable);
+
+static void ppc7d_heartbeat(void)
+{
+	u32 data32;
+	u8 data8;
+	static int max706_wdog = 0;
+
+	/* Unfortunately we can't access the LED control registers
+	 * during early init because they're on the CPLD which is the
+	 * other side of a PCI bridge which goes unreachable during
+	 * PCI scan. So write the LEDs only if the MV64360 watchdog is
+	 * enabled (i.e. userspace apps are running so kernel is up)..
+	 */
+	data32 = mv64x60_read(&bh, MV64x60_WDT_WDC);
+	if (data32 & 0x80000000) {
+		/* Enable MAX706 watchdog if not done already */
+		if (!max706_wdog) {
+			outb(3, PPC7D_CPLD_RESET);
+			max706_wdog = 1;
+		}
+
+		/* Hit the MAX706 watchdog */
+		outb(0, PPC7D_CPLD_WATCHDOG_TRIG);
+
+		/* Pulse LED DS219 if not disabled */
+		if (!ppc7d_led_no_pulse) {
+			static int led_on = 0;
+
+			data8 = inb(PPC7D_CPLD_LEDS);
+			if (led_on)
+				data8 &= ~PPC7D_CPLD_LEDS_DS219_MASK;
+			else
+				data8 |= PPC7D_CPLD_LEDS_DS219_MASK;
+
+			outb(data8, PPC7D_CPLD_LEDS);
+			led_on = !led_on;
+		}
+	}
+	ppc_md.heartbeat_count = ppc_md.heartbeat_reset;
+}
+
+static int ppc7d_show_cpuinfo(struct seq_file *m)
+{
+	u8 val;
+	u8 val1, val2;
+	static int flash_sizes[4] = { 64, 32, 0, 16 };
+	static int flash_banks[4] = { 4, 3, 2, 1 };
+	static char *pci_modes[] = { "PCI33", "PCI66",
+		"Unknown", "Unknown",
+		"PCIX33", "PCIX66",
+		"PCIX100", "PCIX133"
+	};
+
+	seq_printf(m, "vendor\t\t: Radstone Technology\n");
+	seq_printf(m, "machine\t\t: PPC7D\n");
+
+	val = inb(PPC7D_CPLD_BOARD_REVISION);
+	val1 = (val & PPC7D_CPLD_BOARD_REVISION_NUMBER_MASK) >> 5;
+	val2 = (val & PPC7D_CPLD_BOARD_REVISION_LETTER_MASK);
+	seq_printf(m, "revision\t: %hd%c%c\n",
+		   val1,
+		   (val2 <= 0x18) ? 'A' + val2 : 'Y',
+		   (val2 > 0x18) ? 'A' + (val2 - 0x19) : ' ');
+
+	val = inb(PPC7D_CPLD_MOTHERBOARD_TYPE);
+	val1 = val & PPC7D_CPLD_MB_TYPE_PLL_MASK;
+	val2 = val & (PPC7D_CPLD_MB_TYPE_ECC_FITTED_MASK |
+		      PPC7D_CPLD_MB_TYPE_ECC_ENABLE_MASK);
+	seq_printf(m, "bus speed\t: %dMHz\n",
+		   (val1 == PPC7D_CPLD_MB_TYPE_PLL_133) ? 133 :
+		   (val1 == PPC7D_CPLD_MB_TYPE_PLL_100) ? 100 :
+		   (val1 == PPC7D_CPLD_MB_TYPE_PLL_64) ? 64 : 0);
+
+	val = inb(PPC7D_CPLD_MEM_CONFIG_EXTEND);
+	val1 = val & PPC7D_CPLD_SDRAM_BANK_SIZE_MASK;
+	seq_printf(m, "SDRAM\t\t: %d%c",
+		   (val1 == PPC7D_CPLD_SDRAM_BANK_SIZE_128M) ? 128 :
+		   (val1 == PPC7D_CPLD_SDRAM_BANK_SIZE_256M) ? 256 :
+		   (val1 == PPC7D_CPLD_SDRAM_BANK_SIZE_512M) ? 512 : 1,
+		   (val1 == PPC7D_CPLD_SDRAM_BANK_SIZE_1G) ? 'G' : 'M');
+	if (val2 & PPC7D_CPLD_MB_TYPE_ECC_FITTED_MASK) {
+		seq_printf(m, " [ECC %sabled]",
+			   (val2 & PPC7D_CPLD_MB_TYPE_ECC_ENABLE_MASK) ? "en" :
+			   "dis");
+	}
+	seq_printf(m, "\n");
+
+	val1 = (val & PPC7D_CPLD_FLASH_DEV_SIZE_MASK);
+	val2 = (val & PPC7D_CPLD_FLASH_BANK_NUM_MASK) >> 2;
+	seq_printf(m, "FLASH\t\t: %d banks of %dM, total %dM\n",
+		   flash_banks[val2], flash_sizes[val1],
+		   flash_banks[val2] * flash_sizes[val1]);
+
+	val = inb(PPC7D_CPLD_FLASH_WRITE_CNTL);
+	val1 = inb(PPC7D_CPLD_SW_FLASH_WRITE_PROTECT);
+	seq_printf(m, "  write links\t: %s%s%s%s\n",
+		   (val & PPD7D_CPLD_FLASH_CNTL_WR_LINK_MASK) ? "WRITE " : "",
+		   (val & PPD7D_CPLD_FLASH_CNTL_BOOT_LINK_MASK) ? "BOOT " : "",
+		   (val & PPD7D_CPLD_FLASH_CNTL_USER_LINK_MASK) ? "USER " : "",
+		   (val & (PPD7D_CPLD_FLASH_CNTL_WR_LINK_MASK |
+			   PPD7D_CPLD_FLASH_CNTL_BOOT_LINK_MASK |
+			   PPD7D_CPLD_FLASH_CNTL_USER_LINK_MASK)) ==
+		   0 ? "NONE" : "");
+	seq_printf(m, "  write sector h/w enables: %s%s%s%s%s\n",
+		   (val & PPD7D_CPLD_FLASH_CNTL_RECO_WR_MASK) ? "RECOVERY " :
+		   "",
+		   (val & PPD7D_CPLD_FLASH_CNTL_BOOT_WR_MASK) ? "BOOT " : "",
+		   (val & PPD7D_CPLD_FLASH_CNTL_USER_WR_MASK) ? "USER " : "",
+		   (val1 & PPC7D_CPLD_FLASH_CNTL_NVRAM_PROT_MASK) ? "NVRAM " :
+		   "",
+		   (((val &
+		      (PPD7D_CPLD_FLASH_CNTL_RECO_WR_MASK |
+		       PPD7D_CPLD_FLASH_CNTL_BOOT_WR_MASK |
+		       PPD7D_CPLD_FLASH_CNTL_BOOT_WR_MASK)) == 0)
+		    && ((val1 & PPC7D_CPLD_FLASH_CNTL_NVRAM_PROT_MASK) ==
+			0)) ? "NONE" : "");
+	val1 =
+	    inb(PPC7D_CPLD_SW_FLASH_WRITE_PROTECT) &
+	    (PPC7D_CPLD_SW_FLASH_WRPROT_SYSBOOT_MASK |
+	     PPC7D_CPLD_SW_FLASH_WRPROT_USER_MASK);
+	seq_printf(m, "  software sector enables: %s%s%s\n",
+		   (val1 & PPC7D_CPLD_SW_FLASH_WRPROT_SYSBOOT_MASK) ? "SYSBOOT "
+		   : "",
+		   (val1 & PPC7D_CPLD_SW_FLASH_WRPROT_USER_MASK) ? "USER " : "",
+		   (val1 == 0) ? "NONE " : "");
+
+	seq_printf(m, "Boot options\t: %s%s%s%s\n",
+		   (val & PPC7D_CPLD_FLASH_CNTL_ALTBOOT_LINK_MASK) ?
+		   "ALTERNATE " : "",
+		   (val & PPC7D_CPLD_FLASH_CNTL_VMEBOOT_LINK_MASK) ? "VME " :
+		   "",
+		   (val & PPC7D_CPLD_FLASH_CNTL_RECBOOT_LINK_MASK) ? "RECOVERY "
+		   : "",
+		   ((val &
+		     (PPC7D_CPLD_FLASH_CNTL_ALTBOOT_LINK_MASK |
+		      PPC7D_CPLD_FLASH_CNTL_VMEBOOT_LINK_MASK |
+		      PPC7D_CPLD_FLASH_CNTL_RECBOOT_LINK_MASK)) ==
+		    0) ? "NONE" : "");
+
+	val = inb(PPC7D_CPLD_EQUIPMENT_PRESENT_1);
+	seq_printf(m, "Fitted modules\t: %s%s%s%s\n",
+		   (val & PPC7D_CPLD_EQPT_PRES_1_PMC1_MASK) ? "" : "PMC1 ",
+		   (val & PPC7D_CPLD_EQPT_PRES_1_PMC2_MASK) ? "" : "PMC2 ",
+		   (val & PPC7D_CPLD_EQPT_PRES_1_AFIX_MASK) ? "AFIX " : "",
+		   ((val & (PPC7D_CPLD_EQPT_PRES_1_PMC1_MASK |
+			    PPC7D_CPLD_EQPT_PRES_1_PMC2_MASK |
+			    PPC7D_CPLD_EQPT_PRES_1_AFIX_MASK)) ==
+		    (PPC7D_CPLD_EQPT_PRES_1_PMC1_MASK |
+		     PPC7D_CPLD_EQPT_PRES_1_PMC2_MASK)) ? "NONE" : "");
+
+	if (val & PPC7D_CPLD_EQPT_PRES_1_AFIX_MASK) {
+		static const char *ids[] = {
+			"unknown",
+			"1553 (Dual Channel)",
+			"1553 (Single Channel)",
+			"8-bit SCSI + VGA",
+			"16-bit SCSI + VGA",
+			"1553 (Single Channel with sideband)",
+			"1553 (Dual Channel with sideband)",
+			NULL
+		};
+		u8 id = __raw_readb((void *)PPC7D_AFIX_REG_BASE + 0x03);
+		seq_printf(m, "AFIX module\t: 0x%hx [%s]\n", id,
+			   id < 7 ? ids[id] : "unknown");
+	}
+
+	val = inb(PPC7D_CPLD_PCI_CONFIG);
+	val1 = (val & PPC7D_CPLD_PCI_CONFIG_PCI0_MASK) >> 4;
+	val2 = (val & PPC7D_CPLD_PCI_CONFIG_PCI1_MASK);
+	seq_printf(m, "PCI#0\t\t: %s\nPCI#1\t\t: %s\n",
+		   pci_modes[val1], pci_modes[val2]);
+
+	val = inb(PPC7D_CPLD_EQUIPMENT_PRESENT_2);
+	seq_printf(m, "PMC1\t\t: %s\nPMC2\t\t: %s\n",
+		   (val & PPC7D_CPLD_EQPT_PRES_3_PMC1_V_MASK) ? "3.3v" : "5v",
+		   (val & PPC7D_CPLD_EQPT_PRES_3_PMC2_V_MASK) ? "3.3v" : "5v");
+	seq_printf(m, "PMC power source: %s\n",
+		   (val & PPC7D_CPLD_EQPT_PRES_3_PMC_POWER_MASK) ? "VME" :
+		   "internal");
+
+	val = inb(PPC7D_CPLD_EQUIPMENT_PRESENT_4);
+	val2 = inb(PPC7D_CPLD_EQUIPMENT_PRESENT_2);
+	seq_printf(m, "Fit options\t: %s%s%s%s%s%s%s\n",
+		   (val & PPC7D_CPLD_EQPT_PRES_4_LPT_MASK) ? "LPT " : "",
+		   (val & PPC7D_CPLD_EQPT_PRES_4_PS2_FITTED) ? "PS2 " : "",
+		   (val & PPC7D_CPLD_EQPT_PRES_4_USB2_FITTED) ? "USB2 " : "",
+		   (val2 & PPC7D_CPLD_EQPT_PRES_2_UNIVERSE_MASK) ? "VME " : "",
+		   (val2 & PPC7D_CPLD_EQPT_PRES_2_COM36_MASK) ? "COM3-6 " : "",
+		   (val2 & PPC7D_CPLD_EQPT_PRES_2_GIGE_MASK) ? "eth0 " : "",
+		   (val2 & PPC7D_CPLD_EQPT_PRES_2_DUALGIGE_MASK) ? "eth1 " :
+		   "");
+
+	val = inb(PPC7D_CPLD_ID_LINK);
+	val1 = val & (PPC7D_CPLD_ID_LINK_E6_MASK |
+		      PPC7D_CPLD_ID_LINK_E7_MASK |
+		      PPC7D_CPLD_ID_LINK_E12_MASK |
+		      PPC7D_CPLD_ID_LINK_E13_MASK);
+
+	val = inb(PPC7D_CPLD_FLASH_WRITE_CNTL) &
+	    (PPD7D_CPLD_FLASH_CNTL_WR_LINK_MASK |
+	     PPD7D_CPLD_FLASH_CNTL_BOOT_LINK_MASK |
+	     PPD7D_CPLD_FLASH_CNTL_USER_LINK_MASK);
+
+	seq_printf(m, "Board links present: %s%s%s%s%s%s%s%s\n",
+		   (val1 & PPC7D_CPLD_ID_LINK_E6_MASK) ? "E6 " : "",
+		   (val1 & PPC7D_CPLD_ID_LINK_E7_MASK) ? "E7 " : "",
+		   (val & PPD7D_CPLD_FLASH_CNTL_WR_LINK_MASK) ? "E9 " : "",
+		   (val & PPD7D_CPLD_FLASH_CNTL_BOOT_LINK_MASK) ? "E10 " : "",
+		   (val & PPD7D_CPLD_FLASH_CNTL_USER_LINK_MASK) ? "E11 " : "",
+		   (val1 & PPC7D_CPLD_ID_LINK_E12_MASK) ? "E12 " : "",
+		   (val1 & PPC7D_CPLD_ID_LINK_E13_MASK) ? "E13 " : "",
+		   ((val == 0) && (val1 == 0)) ? "NONE" : "");
+
+	val = inb(PPC7D_CPLD_WDOG_RESETSW_MASK);
+	seq_printf(m, "Front panel reset switch: %sabled\n",
+		   (val & PPC7D_CPLD_WDOG_RESETSW_MASK) ? "dis" : "en");
+
+	return 0;
+}
+
+static void __init ppc7d_calibrate_decr(void)
+{
+	ulong freq;
+
+	freq = 100000000 / 4;
+
+	pr_debug("time_init: decrementer frequency = %lu.%.6lu MHz\n",
+		 freq / 1000000, freq % 1000000);
+
+	tb_ticks_per_jiffy = freq / HZ;
+	tb_to_us = mulhwu_scale_factor(freq, 1000000);
+}
+
+/*****************************************************************************
+ * Interrupt stuff
+ *****************************************************************************/
+
+static irqreturn_t ppc7d_i8259_intr(int irq, void *dev_id, struct pt_regs *regs)
+{
+	u32 temp = mv64x60_read(&bh, MV64x60_GPP_INTR_CAUSE);
+	if (temp & (1 << 28)) {
+		i8259_irq(regs);
+		mv64x60_write(&bh, MV64x60_GPP_INTR_CAUSE, temp & (~(1 << 28)));
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+/*
+ * Each interrupt cause is assigned an IRQ number.
+ * Southbridge has 16*2 (two 8259's) interrupts.
+ * Discovery-II has 96 interrupts (cause-hi, cause-lo, gpp x 32).
+ * If multiple interrupts are pending, get_irq() returns the
+ * lowest pending irq number first.
+ *
+ *
+ * IRQ #   Source                              Trig   Active 
+ * =============================================================
+ * 
+ * Southbridge
+ * -----------
+ * IRQ #   Source                              Trig   
+ * =============================================================
+ * 0       ISA High Resolution Counter         Edge
+ * 1       Keyboard                            Edge
+ * 2       Cascade From (IRQ 8-15)             Edge
+ * 3       Com 2 (Uart 2)                      Edge
+ * 4       Com 1 (Uart 1)                      Edge
+ * 5       PCI Int D/AFIX IRQZ ID4 (2,7)       Level
+ * 6       GPIO                                Level
+ * 7       LPT                                 Edge 
+ * 8       RTC Alarm                           Edge 
+ * 9       PCI Int A/PMC 2/AFIX IRQW ID1 (2,0) Level
+ * 10      PCI Int B/PMC 1/AFIX IRQX ID2 (2,1) Level
+ * 11      USB2                                Level
+ * 12      Mouse                               Edge
+ * 13      Reserved internally by Ali M1535+
+ * 14      PCI Int C/VME/AFIX IRQY ID3 (2,6)   Level
+ * 15      COM 5/6                             Level
+ *
+ * 16..112 Discovery-II...
+ *
+ * MPP28   Southbridge                         Edge   High	
+ *
+ *
+ * Interrupts are cascaded through to the Discovery-II.
+ *
+ *  PCI ---
+ *         \
+ * CPLD --> ALI1535 -------> DISCOVERY-II
+ *        INTF           MPP28
+ */
+static void __init ppc7d_init_irq(void)
+{
+	int irq;
+
+	pr_debug("%s\n", __FUNCTION__);
+	i8259_init(0);
+	mv64360_init_irq();
+
+	/* IRQ 0..15 are handled by the cascaded 8259's of the Ali1535 */
+	for (irq = 0; irq < 16; irq++) {
+		irq_desc[irq].handler = &i8259_pic;
+	}
+	/* IRQs 5,6,9,10,11,14,15 are level sensitive */
+	irq_desc[5].status |= IRQ_LEVEL;
+	irq_desc[6].status |= IRQ_LEVEL;
+	irq_desc[9].status |= IRQ_LEVEL;
+	irq_desc[10].status |= IRQ_LEVEL;
+	irq_desc[11].status |= IRQ_LEVEL;
+	irq_desc[14].status |= IRQ_LEVEL;
+	irq_desc[15].status |= IRQ_LEVEL;
+
+	/* GPP28 is edge triggered */
+	irq_desc[mv64360_irq_base + MV64x60_IRQ_GPP28].status &= ~IRQ_LEVEL;
+}
+
+static u32 ppc7d_irq_canonicalize(u32 irq)
+{
+	if ((irq >= 16) && (irq < (16 + 96)))
+		irq -= 16;
+
+	return irq;
+}
+
+static int ppc7d_get_irq(struct pt_regs *regs)
+{
+	int irq;
+
+	irq = mv64360_get_irq(regs);
+	if (irq == (mv64360_irq_base + MV64x60_IRQ_GPP28))
+		irq = i8259_irq(regs);
+	return irq;
+}
+
+/* 
+ * 9       PCI Int A/PMC 2/AFIX IRQW ID1 (2,0) Level
+ * 10      PCI Int B/PMC 1/AFIX IRQX ID2 (2,1) Level
+ * 14      PCI Int C/VME/AFIX IRQY ID3 (2,6)   Level
+ * 5       PCI Int D/AFIX IRQZ ID4 (2,7)       Level
+ */
+static int __init ppc7d_map_irq(struct pci_dev *dev, unsigned char idsel,
+				unsigned char pin)
+{
+	static const char pci_irq_table[][4] =
+	    /*
+	     *      PCI IDSEL/INTPIN->INTLINE 
+	     *         A   B   C   D
+	     */
+	{
+		{10, 14, 5, 9},	/* IDSEL 10 - PMC2 / AFIX IRQW */
+		{9, 10, 14, 5},	/* IDSEL 11 - PMC1 / AFIX IRQX */
+		{5, 9, 10, 14},	/* IDSEL 12 - AFIX IRQY */
+		{14, 5, 9, 10},	/* IDSEL 13 - AFIX IRQZ */
+	};
+	const long min_idsel = 10, max_idsel = 14, irqs_per_slot = 4;
+
+	pr_debug("%s: %04x/%04x/%x: idsel=%hx pin=%hu\n", __FUNCTION__,
+		 dev->vendor, dev->device, PCI_FUNC(dev->devfn), idsel, pin);
+
+	return PCI_IRQ_TABLE_LOOKUP;
+}
+
+void __init ppc7d_intr_setup(void)
+{
+	u32 data;
+
+	/*
+	 * Define GPP 28 interrupt polarity as active high
+	 * input signal and level triggered
+	 */
+	data = mv64x60_read(&bh, MV64x60_GPP_LEVEL_CNTL);
+	data &= ~(1 << 28);
+	mv64x60_write(&bh, MV64x60_GPP_LEVEL_CNTL, data);
+	data = mv64x60_read(&bh, MV64x60_GPP_IO_CNTL);
+	data &= ~(1 << 28);
+	mv64x60_write(&bh, MV64x60_GPP_IO_CNTL, data);
+
+	/* Config GPP intr ctlr to respond to level trigger */
+	data = mv64x60_read(&bh, MV64x60_COMM_ARBITER_CNTL);
+	data |= (1 << 10);
+	mv64x60_write(&bh, MV64x60_COMM_ARBITER_CNTL, data);
+
+	/* XXXX Erranum FEr PCI-#8 */
+	data = mv64x60_read(&bh, MV64x60_PCI0_CMD);
+	data &= ~((1 << 5) | (1 << 9));
+	mv64x60_write(&bh, MV64x60_PCI0_CMD, data);
+	data = mv64x60_read(&bh, MV64x60_PCI1_CMD);
+	data &= ~((1 << 5) | (1 << 9));
+	mv64x60_write(&bh, MV64x60_PCI1_CMD, data);
+
+	/*
+	 * Dismiss and then enable interrupt on GPP interrupt cause
+	 * for CPU #0
+	 */
+	mv64x60_write(&bh, MV64x60_GPP_INTR_CAUSE, ~(1 << 28));
+	data = mv64x60_read(&bh, MV64x60_GPP_INTR_MASK);
+	data |= (1 << 28);
+	mv64x60_write(&bh, MV64x60_GPP_INTR_MASK, data);
+
+	/*
+	 * Dismiss and then enable interrupt on CPU #0 high cause reg
+	 * BIT27 summarizes GPP interrupts 23-31
+	 */
+	mv64x60_write(&bh, MV64360_IC_MAIN_CAUSE_HI, ~(1 << 27));
+	data = mv64x60_read(&bh, MV64360_IC_CPU0_INTR_MASK_HI);
+	data |= (1 << 27);
+	mv64x60_write(&bh, MV64360_IC_CPU0_INTR_MASK_HI, data);
+}
+
+/*****************************************************************************
+ * Platform device data fixup routines. 
+ *****************************************************************************/
+
+#if defined(CONFIG_SERIAL_MPSC)
+static void __init ppc7d_fixup_mpsc_pdata(struct platform_device *pdev)
+{
+	struct mpsc_pdata *pdata;
+
+	pdata = (struct mpsc_pdata *)pdev->dev.platform_data;
+
+	pdata->max_idle = 40;
+	pdata->default_baud = PPC7D_DEFAULT_BAUD;
+	pdata->brg_clk_src = PPC7D_MPSC_CLK_SRC;
+	pdata->brg_clk_freq = PPC7D_MPSC_CLK_FREQ;
+
+	return;
+}
+#endif
+
+#if defined(CONFIG_MV643XX_ETH)
+static void __init ppc7d_fixup_eth_pdata(struct platform_device *pdev)
+{
+	struct mv643xx_eth_platform_data *eth_pd;
+	static u16 phy_addr[] = {
+		PPC7D_ETH0_PHY_ADDR,
+		PPC7D_ETH1_PHY_ADDR,
+		PPC7D_ETH2_PHY_ADDR,
+	};
+	int i;
+
+	eth_pd = pdev->dev.platform_data;
+	eth_pd->force_phy_addr = 1;
+	eth_pd->phy_addr = phy_addr[pdev->id];
+	eth_pd->tx_queue_size = PPC7D_ETH_TX_QUEUE_SIZE;
+	eth_pd->rx_queue_size = PPC7D_ETH_RX_QUEUE_SIZE;
+
+	/* Adjust IRQ by mv64360_irq_base */
+	for (i = 0; i < pdev->num_resources; i++) {
+		struct resource *r = &pdev->resource[i];
+
+		if (r->flags & IORESOURCE_IRQ) {
+			r->start += mv64360_irq_base;
+			r->end += mv64360_irq_base;
+			pr_debug("%s, uses IRQ %d\n", pdev->name,
+				 (int)r->start);
+		}
+	}
+
+}
+#endif
+
+static int __init ppc7d_platform_notify(struct device *dev)
+{
+	static struct {
+		char *bus_id;
+		void ((*rtn) (struct platform_device * pdev));
+	} dev_map[] = {
+#if defined(CONFIG_SERIAL_MPSC)
+		{ MPSC_CTLR_NAME "0", ppc7d_fixup_mpsc_pdata }, 
+		{ MPSC_CTLR_NAME "1", ppc7d_fixup_mpsc_pdata },
+#endif
+#if defined(CONFIG_MV643XX_ETH)
+		{ MV643XX_ETH_NAME "0", ppc7d_fixup_eth_pdata },
+		{ MV643XX_ETH_NAME "1", ppc7d_fixup_eth_pdata }, 
+		{ MV643XX_ETH_NAME "2", ppc7d_fixup_eth_pdata },
+#endif
+	};
+	struct platform_device *pdev;
+	int i;
+
+	if (dev && dev->bus_id)
+		for (i = 0; i < ARRAY_SIZE(dev_map); i++)
+			if (!strncmp(dev->bus_id, dev_map[i].bus_id,
+				     BUS_ID_SIZE)) {
+
+				pdev = container_of(dev,
+						    struct platform_device,
+						    dev);
+				dev_map[i].rtn(pdev);
+			}
+
+	return 0;
+}
+
+/*****************************************************************************
+ * PCI device fixups.
+ * These aren't really fixups per se. They are used to init devices as they
+ * are found during PCI scan. 
+ *
+ * The PPC7D has an HB8 PCI-X bridge which must be set up during a PCI
+ * scan in order to find other devices on its secondary side.
+ *****************************************************************************/
+
+static void __init ppc7d_fixup_hb8(struct pci_dev *dev)
+{
+	u16 val16;
+
+	if (dev->bus->number == 0) {
+		pr_debug("PCI: HB8 init\n");
+
+		pci_write_config_byte(dev, 0x1c,
+				      ((PPC7D_PCI0_IO_START_PCI_ADDR & 0xf000)
+				       >> 8) | 0x01);
+		pci_write_config_byte(dev, 0x1d,
+				      (((PPC7D_PCI0_IO_START_PCI_ADDR +
+					 PPC7D_PCI0_IO_SIZE -
+					 1) & 0xf000) >> 8) | 0x01);
+		pci_write_config_word(dev, 0x30,
+				      PPC7D_PCI0_IO_START_PCI_ADDR >> 16);
+		pci_write_config_word(dev, 0x32,
+				      ((PPC7D_PCI0_IO_START_PCI_ADDR +
+					PPC7D_PCI0_IO_SIZE -
+					1) >> 16) & 0xffff);
+
+		pci_write_config_word(dev, 0x20,
+				      PPC7D_PCI0_MEM0_START_PCI_LO_ADDR >> 16);
+		pci_write_config_word(dev, 0x22,
+				      ((PPC7D_PCI0_MEM0_START_PCI_LO_ADDR +
+					PPC7D_PCI0_MEM0_SIZE -
+					1) >> 16) & 0xffff);
+		pci_write_config_word(dev, 0x24, 0);
+		pci_write_config_word(dev, 0x26, 0);
+		pci_write_config_dword(dev, 0x28, 0);
+		pci_write_config_dword(dev, 0x2c, 0);
+
+		pci_read_config_word(dev, 0x3e, &val16);
+		val16 |= ((1 << 5) | (1 << 1));	/* signal master aborts and 
+						 * SERR to primary 
+						 */
+		val16 &= ~(1 << 2);		/* ISA disable, so all ISA 
+						 * ports forwarded to secondary
+						 */
+		pci_write_config_word(dev, 0x3e, val16);
+	}
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0028, ppc7d_fixup_hb8);
+
+/* This should perhaps be a separate driver as we're actually initializing
+ * the chip for this board here. It's hardly a fixup...
+ */
+static void __init ppc7d_fixup_ali1535(struct pci_dev *dev)
+{
+	pr_debug("PCI: ALI1535 init\n");
+
+	if (dev->bus->number == 1) {
+		/* Configure the ISA Port Settings */
+		pci_write_config_byte(dev, 0x43, 0x00);
+
+		/* Disable PCI Interrupt polling mode */
+		pci_write_config_byte(dev, 0x45, 0x00);
+
+		/* Multifunction pin select INTFJ -> INTF */
+		pci_write_config_byte(dev, 0x78, 0x00);
+
+		/* Set PCI INT -> IRQ Routing control in for external 
+		 * pins south bridge. 
+		 */
+		pci_write_config_byte(dev, 0x48, 0x31);	/* [7-4] INT B -> IRQ10
+							 * [3-0] INT A -> IRQ9 
+							 */
+		pci_write_config_byte(dev, 0x49, 0x5D);	/* [7-4] INT D -> IRQ5
+							 * [3-0] INT C -> IRQ14 
+							 */
+
+		/* PPC7D setup */
+		/* NEC USB device on IRQ 11 (INTE) - INTF disabled */
+		pci_write_config_byte(dev, 0x4A, 0x09);
+
+		/* GPIO on IRQ 6 */
+		pci_write_config_byte(dev, 0x76, 0x07);
+
+		/* SIRQ I (COMS 5/6) use IRQ line 15.
+		 * Positive (not subtractive) address decode.
+		 */
+		pci_write_config_byte(dev, 0x44, 0x0f);
+
+		/* SIRQ II disabled */
+		pci_write_config_byte(dev, 0x75, 0x0);
+
+		/* On board USB and RTC disabled */
+		pci_write_config_word(dev, 0x52, (1 << 14));
+		pci_write_config_byte(dev, 0x74, 0x00);
+
+		/* On board IDE disabled */
+		pci_write_config_byte(dev, 0x58, 0x00);
+
+		/* Decode 32-bit addresses */
+		pci_write_config_byte(dev, 0x5b, 0);
+
+		/* Disable docking IO */
+		pci_write_config_word(dev, 0x5c, 0x0000);
+
+		/* Disable modem, enable sound */
+		pci_write_config_byte(dev, 0x77, (1 << 6));
+
+		/* Disable hot-docking mode */
+		pci_write_config_byte(dev, 0x7d, 0x00);
+	}
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1533, ppc7d_fixup_ali1535);
+
+static int ppc7d_pci_exclude_device(u8 bus, u8 devfn)
+{
+	/* Early versions of this board were fitted with IBM ALMA
+	 * PCI-VME bridge chips. The PCI config space of these devices
+	 * was not set up correctly and causes PCI scan problems.
+	 */
+	if ((bus == 1) && (PCI_SLOT(devfn) == 4) && ppc7d_has_alma)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return mv64x60_pci_exclude_device(bus, devfn);
+}
+
+/* This hook is called when each PCI bus is probed.
+ */
+static void ppc7d_pci_fixup_bus(struct pci_bus *bus)
+{
+	pr_debug("PCI BUS %hu: %lx/%lx %lx/%lx %lx/%lx %lx/%lx\n",
+		 bus->number,
+		 bus->resource[0] ? bus->resource[0]->start : 0,
+		 bus->resource[0] ? bus->resource[0]->end : 0,
+		 bus->resource[1] ? bus->resource[1]->start : 0,
+		 bus->resource[1] ? bus->resource[1]->end : 0,
+		 bus->resource[2] ? bus->resource[2]->start : 0,
+		 bus->resource[2] ? bus->resource[2]->end : 0,
+		 bus->resource[3] ? bus->resource[3]->start : 0,
+		 bus->resource[3] ? bus->resource[3]->end : 0);
+
+	if ((bus->number == 1) && (bus->resource[2] != NULL)) {
+		/* Hide PCI window 2 of Bus 1 which is used only to
+		 * map legacy ISA memory space.
+		 */
+		bus->resource[2]->start = 0;
+		bus->resource[2]->end = 0;
+		bus->resource[2]->flags = 0;
+	}
+}
+
+/*****************************************************************************
+ * Board device setup code
+ *****************************************************************************/
+
+void __init ppc7d_setup_peripherals(void)
+{
+	u32 val32;
+
+	/* Set up windows for boot CS */
+	mv64x60_set_32bit_window(&bh, MV64x60_CPU2BOOT_WIN,
+				 PPC7D_BOOT_WINDOW_BASE, PPC7D_BOOT_WINDOW_SIZE,
+				 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2BOOT_WIN);
+
+	/* Boot firmware configures the following DevCS addresses.
+	 * DevCS0 - board control/status
+	 * DevCS1 - test registers
+	 * DevCS2 - AFIX port/address registers (for identifying)
+	 * DevCS3 - FLASH
+	 *
+	 * We don't use DevCS0, DevCS1.
+	 */
+	val32 = mv64x60_read(&bh, MV64360_CPU_BAR_ENABLE);
+	val32 |= ((1 << 4) | (1 << 5));
+	mv64x60_write(&bh, MV64360_CPU_BAR_ENABLE, val32);
+	mv64x60_write(&bh, MV64x60_CPU2DEV_0_BASE, 0);
+	mv64x60_write(&bh, MV64x60_CPU2DEV_0_SIZE, 0);
+	mv64x60_write(&bh, MV64x60_CPU2DEV_1_BASE, 0);
+	mv64x60_write(&bh, MV64x60_CPU2DEV_1_SIZE, 0);
+
+	mv64x60_set_32bit_window(&bh, MV64x60_CPU2DEV_2_WIN,
+				 PPC7D_AFIX_REG_BASE, PPC7D_AFIX_REG_SIZE, 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2DEV_2_WIN);
+
+	mv64x60_set_32bit_window(&bh, MV64x60_CPU2DEV_3_WIN,
+				 PPC7D_FLASH_BASE, PPC7D_FLASH_SIZE_ACTUAL, 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2DEV_3_WIN);
+
+	mv64x60_set_32bit_window(&bh, MV64x60_CPU2SRAM_WIN,
+				 PPC7D_INTERNAL_SRAM_BASE, MV64360_SRAM_SIZE,
+				 0);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2SRAM_WIN);
+
+	/* Set up Enet->SRAM window */
+	mv64x60_set_32bit_window(&bh, MV64x60_ENET2MEM_4_WIN,
+				 PPC7D_INTERNAL_SRAM_BASE, MV64360_SRAM_SIZE,
+				 0x2);
+	bh.ci->enable_window_32bit(&bh, MV64x60_ENET2MEM_4_WIN);
+
+	/* Give enet r/w access to memory region */
+	val32 = mv64x60_read(&bh, MV64360_ENET2MEM_ACC_PROT_0);
+	val32 |= (0x3 << (4 << 1));
+	mv64x60_write(&bh, MV64360_ENET2MEM_ACC_PROT_0, val32);
+	val32 = mv64x60_read(&bh, MV64360_ENET2MEM_ACC_PROT_1);
+	val32 |= (0x3 << (4 << 1));
+	mv64x60_write(&bh, MV64360_ENET2MEM_ACC_PROT_1, val32);
+	val32 = mv64x60_read(&bh, MV64360_ENET2MEM_ACC_PROT_2);
+	val32 |= (0x3 << (4 << 1));
+	mv64x60_write(&bh, MV64360_ENET2MEM_ACC_PROT_2, val32);
+
+	val32 = mv64x60_read(&bh, MV64x60_TIMR_CNTR_0_3_CNTL);
+	val32 &= ~((1 << 0) | (1 << 8) | (1 << 16) | (1 << 24));
+	mv64x60_write(&bh, MV64x60_TIMR_CNTR_0_3_CNTL, val32);
+
+	/* Enumerate pci bus.
+	 *
+	 * We scan PCI#0 first (the bus with the HB8 and other
+	 * on-board peripherals). We must configure the 64360 before
+	 * each scan, according to the bus number assignments.  Busses
+	 * are assigned incrementally, starting at 0.  PCI#0 is
+	 * usually assigned bus#0, the secondary side of the HB8 gets
+	 * bus#1 and PCI#1 (second PMC site) gets bus#2.  However, if
+	 * any PMC card has a PCI bridge, these bus assignments will
+	 * change.
+	 */
+
+	/* Turn off PCI retries */
+	val32 = mv64x60_read(&bh, MV64x60_CPU_CONFIG);
+	val32 |= (1 << 17);
+	mv64x60_write(&bh, MV64x60_CPU_CONFIG, val32);
+
+	/* Scan PCI#0 */
+	mv64x60_set_bus(&bh, 0, 0);
+	bh.hose_a->first_busno = 0;
+	bh.hose_a->last_busno = 0xff;
+	bh.hose_a->last_busno = pciauto_bus_scan(bh.hose_a, 0);
+	printk(KERN_INFO "PCI#0: first=%d last=%d\n", 
+	       bh.hose_a->first_busno, bh.hose_a->last_busno);
+
+	/* Scan PCI#1 */
+	bh.hose_b->first_busno = bh.hose_a->last_busno + 1;
+	mv64x60_set_bus(&bh, 1, bh.hose_b->first_busno);
+	bh.hose_b->last_busno = 0xff;
+	bh.hose_b->last_busno = pciauto_bus_scan(bh.hose_b,
+		bh.hose_b->first_busno);
+	printk(KERN_INFO "PCI#1: first=%d last=%d\n", 
+	       bh.hose_b->first_busno, bh.hose_b->last_busno);
+
+	/* Turn on PCI retries */
+	val32 = mv64x60_read(&bh, MV64x60_CPU_CONFIG);
+	val32 &= ~(1 << 17);
+	mv64x60_write(&bh, MV64x60_CPU_CONFIG, val32);
+
+	/* Setup interrupts */
+	ppc7d_intr_setup();
+}
+
+static void __init ppc7d_setup_bridge(void)
+{
+	struct mv64x60_setup_info si;
+	int i;
+	u32 temp;
+
+	mv64360_irq_base = 16;	/* first 16 intrs are 2 x 8259's */
+
+	memset(&si, 0, sizeof(si));
+
+	si.phys_reg_base = CONFIG_MV64X60_NEW_BASE;
+
+	si.pci_0.enable_bus = 1;
+	si.pci_0.pci_io.cpu_base = PPC7D_PCI0_IO_START_PROC_ADDR;
+	si.pci_0.pci_io.pci_base_hi = 0;
+	si.pci_0.pci_io.pci_base_lo = PPC7D_PCI0_IO_START_PCI_ADDR;
+	si.pci_0.pci_io.size = PPC7D_PCI0_IO_SIZE;
+	si.pci_0.pci_io.swap = MV64x60_CPU2PCI_SWAP_NONE;
+	si.pci_0.pci_mem[0].cpu_base = PPC7D_PCI0_MEM0_START_PROC_ADDR;
+	si.pci_0.pci_mem[0].pci_base_hi = PPC7D_PCI0_MEM0_START_PCI_HI_ADDR;
+	si.pci_0.pci_mem[0].pci_base_lo = PPC7D_PCI0_MEM0_START_PCI_LO_ADDR;
+	si.pci_0.pci_mem[0].size = PPC7D_PCI0_MEM0_SIZE;
+	si.pci_0.pci_mem[0].swap = MV64x60_CPU2PCI_SWAP_NONE;
+	si.pci_0.pci_mem[1].cpu_base = PPC7D_PCI0_MEM1_START_PROC_ADDR;
+	si.pci_0.pci_mem[1].pci_base_hi = PPC7D_PCI0_MEM1_START_PCI_HI_ADDR;
+	si.pci_0.pci_mem[1].pci_base_lo = PPC7D_PCI0_MEM1_START_PCI_LO_ADDR;
+	si.pci_0.pci_mem[1].size = PPC7D_PCI0_MEM1_SIZE;
+	si.pci_0.pci_mem[1].swap = MV64x60_CPU2PCI_SWAP_NONE;
+	si.pci_0.pci_cmd_bits = 0;
+	si.pci_0.latency_timer = 0x80;
+
+	si.pci_1.enable_bus = 1;
+	si.pci_1.pci_io.cpu_base = PPC7D_PCI1_IO_START_PROC_ADDR;
+	si.pci_1.pci_io.pci_base_hi = 0;
+	si.pci_1.pci_io.pci_base_lo = PPC7D_PCI1_IO_START_PCI_ADDR;
+	si.pci_1.pci_io.size = PPC7D_PCI1_IO_SIZE;
+	si.pci_1.pci_io.swap = MV64x60_CPU2PCI_SWAP_NONE;
+	si.pci_1.pci_mem[0].cpu_base = PPC7D_PCI1_MEM0_START_PROC_ADDR;
+	si.pci_1.pci_mem[0].pci_base_hi = PPC7D_PCI1_MEM0_START_PCI_HI_ADDR;
+	si.pci_1.pci_mem[0].pci_base_lo = PPC7D_PCI1_MEM0_START_PCI_LO_ADDR;
+	si.pci_1.pci_mem[0].size = PPC7D_PCI1_MEM0_SIZE;
+	si.pci_1.pci_mem[0].swap = MV64x60_CPU2PCI_SWAP_NONE;
+	si.pci_1.pci_mem[1].cpu_base = PPC7D_PCI1_MEM1_START_PROC_ADDR;
+	si.pci_1.pci_mem[1].pci_base_hi = PPC7D_PCI1_MEM1_START_PCI_HI_ADDR;
+	si.pci_1.pci_mem[1].pci_base_lo = PPC7D_PCI1_MEM1_START_PCI_LO_ADDR;
+	si.pci_1.pci_mem[1].size = PPC7D_PCI1_MEM1_SIZE;
+	si.pci_1.pci_mem[1].swap = MV64x60_CPU2PCI_SWAP_NONE;
+	si.pci_1.pci_cmd_bits = 0;
+	si.pci_1.latency_timer = 0x80;
+
+	/* Don't clear the SRAM window since we use it for debug */
+	si.window_preserve_mask_32_lo = (1 << MV64x60_CPU2SRAM_WIN);
+
+	printk(KERN_INFO "PCI: MV64360 PCI#0 IO at %x, size %x\n",
+	       si.pci_0.pci_io.cpu_base, si.pci_0.pci_io.size);
+	printk(KERN_INFO "PCI: MV64360 PCI#1 IO at %x, size %x\n",
+	       si.pci_1.pci_io.cpu_base, si.pci_1.pci_io.size);
+
+	for (i = 0; i < MV64x60_CPU2MEM_WINDOWS; i++) {
+#if defined(CONFIG_NOT_COHERENT_CACHE)
+		si.cpu_prot_options[i] = 0;
+		si.enet_options[i] = MV64360_ENET2MEM_SNOOP_NONE;
+		si.mpsc_options[i] = MV64360_MPSC2MEM_SNOOP_NONE;
+		si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_NONE;
+
+		si.pci_0.acc_cntl_options[i] =
+		    MV64360_PCI_ACC_CNTL_SNOOP_NONE |
+		    MV64360_PCI_ACC_CNTL_SWAP_NONE |
+		    MV64360_PCI_ACC_CNTL_MBURST_128_BYTES |
+		    MV64360_PCI_ACC_CNTL_RDSIZE_256_BYTES;
+
+		si.pci_1.acc_cntl_options[i] =
+		    MV64360_PCI_ACC_CNTL_SNOOP_NONE |
+		    MV64360_PCI_ACC_CNTL_SWAP_NONE |
+		    MV64360_PCI_ACC_CNTL_MBURST_128_BYTES |
+		    MV64360_PCI_ACC_CNTL_RDSIZE_256_BYTES;
+#else
+		si.cpu_prot_options[i] = 0;
+		/* All PPC7D hardware uses B0 or newer MV64360 silicon which 
+		 * does not have snoop bugs.
+		 */
+		si.enet_options[i] = MV64360_ENET2MEM_SNOOP_WB;
+		si.mpsc_options[i] = MV64360_MPSC2MEM_SNOOP_WB;
+		si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_WB;
+
+		si.pci_0.acc_cntl_options[i] =
+		    MV64360_PCI_ACC_CNTL_SNOOP_WB |
+		    MV64360_PCI_ACC_CNTL_SWAP_NONE |
+		    MV64360_PCI_ACC_CNTL_MBURST_32_BYTES |
+		    MV64360_PCI_ACC_CNTL_RDSIZE_32_BYTES;
+
+		si.pci_1.acc_cntl_options[i] =
+		    MV64360_PCI_ACC_CNTL_SNOOP_WB |
+		    MV64360_PCI_ACC_CNTL_SWAP_NONE |
+		    MV64360_PCI_ACC_CNTL_MBURST_32_BYTES |
+		    MV64360_PCI_ACC_CNTL_RDSIZE_32_BYTES;
+#endif
+	}
+
+	/* Lookup PCI host bridges */
+	if (mv64x60_init(&bh, &si))
+		printk(KERN_ERR "MV64360 initialization failed.\n");
+
+	pr_debug("MV64360 regs @ %lx/%p\n", bh.p_base, bh.v_base);
+
+	/* Enable WB Cache coherency on SRAM */
+	temp = mv64x60_read(&bh, MV64360_SRAM_CONFIG);
+	pr_debug("SRAM_CONFIG: %x\n", temp);
+#if defined(CONFIG_NOT_COHERENT_CACHE)
+	mv64x60_write(&bh, MV64360_SRAM_CONFIG, temp & ~0x2);
+#else
+	mv64x60_write(&bh, MV64360_SRAM_CONFIG, temp | 0x2);
+#endif
+	/* If system operates with internal bus arbiter (CPU master
+	 * control bit8) clear AACK Delay bit [25] in CPU
+	 * configuration register.
+	 */
+	temp = mv64x60_read(&bh, MV64x60_CPU_MASTER_CNTL);
+	if (temp & (1 << 8)) {
+		temp = mv64x60_read(&bh, MV64x60_CPU_CONFIG);
+		mv64x60_write(&bh, MV64x60_CPU_CONFIG, (temp & ~(1 << 25)));
+	}
+
+	/* Data and address parity is enabled */
+	temp = mv64x60_read(&bh, MV64x60_CPU_CONFIG);
+	mv64x60_write(&bh, MV64x60_CPU_CONFIG,
+		      (temp | (1 << 26) | (1 << 19)));
+
+	pci_dram_offset = 0;	/* sys mem at same addr on PCI & cpu bus */
+	ppc_md.pci_swizzle = common_swizzle;
+	ppc_md.pci_map_irq = ppc7d_map_irq;
+	ppc_md.pci_exclude_device = ppc7d_pci_exclude_device;
+
+	mv64x60_set_bus(&bh, 0, 0);
+	bh.hose_a->first_busno = 0;
+	bh.hose_a->last_busno = 0xff;
+	bh.hose_a->mem_space.start = PPC7D_PCI0_MEM0_START_PCI_LO_ADDR;
+	bh.hose_a->mem_space.end =
+	    PPC7D_PCI0_MEM0_START_PCI_LO_ADDR + PPC7D_PCI0_MEM0_SIZE;
+
+	/* These will be set later, as a result of PCI0 scan */
+	bh.hose_b->first_busno = 0;
+	bh.hose_b->last_busno = 0xff;
+	bh.hose_b->mem_space.start = PPC7D_PCI1_MEM0_START_PCI_LO_ADDR;
+	bh.hose_b->mem_space.end =
+	    PPC7D_PCI1_MEM0_START_PCI_LO_ADDR + PPC7D_PCI1_MEM0_SIZE;
+
+	pr_debug("MV64360: PCI#0 IO decode %08x/%08x IO remap %08x\n",
+		 mv64x60_read(&bh, 0x48), mv64x60_read(&bh, 0x50),
+		 mv64x60_read(&bh, 0xf0));
+}
+
+static void __init ppc7d_setup_arch(void)
+{
+	int port;
+
+	loops_per_jiffy = 100000000 / HZ;
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+	else
+#endif
+#ifdef	CONFIG_ROOT_NFS
+		ROOT_DEV = Root_NFS;
+#else
+		ROOT_DEV = Root_HDA1;
+#endif
+
+	if ((cur_cpu_spec[0]->cpu_features & CPU_FTR_SPEC7450) ||
+	    (cur_cpu_spec[0]->cpu_features & CPU_FTR_L3CR))
+		/* 745x is different.  We only want to pass along enable. */
+		_set_L2CR(L2CR_L2E);
+	else if (cur_cpu_spec[0]->cpu_features & CPU_FTR_L2CR)
+		/* All modules have 1MB of L2.  We also assume that an
+		 * L2 divisor of 3 will work.
+		 */
+		_set_L2CR(L2CR_L2E | L2CR_L2SIZ_1MB | L2CR_L2CLK_DIV3
+			  | L2CR_L2RAM_PIPE | L2CR_L2OH_1_0 | L2CR_L2DF);
+
+	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_L3CR)
+		/* No L3 cache */
+		_set_L3CR(0);
+
+#ifdef CONFIG_DUMMY_CONSOLE
+	conswitchp = &dummy_con;
+#endif
+
+	/* Lookup PCI host bridges */
+	if (ppc_md.progress)
+		ppc_md.progress("ppc7d_setup_arch: calling setup_bridge", 0);
+
+	ppc7d_setup_bridge();
+	ppc7d_setup_peripherals();
+
+	/* Disable ethernet. It might have been setup by the bootrom */
+	for (port = 0; port < 3; port++)
+		mv64x60_write(&bh, MV64340_ETH_RECEIVE_QUEUE_COMMAND_REG(port),
+			      0x0000ff00);
+
+	/* Clear queue pointers to ensure they are all initialized,
+	 * otherwise since queues 1-7 are unused, they have random
+	 * pointers which look strange in register dumps. Don't bother
+	 * with queue 0 since it will be initialized later.
+	 */
+	for (port = 0; port < 3; port++) {
+		mv64x60_write(&bh,
+			      MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_1(port),
+			      0x00000000);
+		mv64x60_write(&bh,
+			      MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_2(port),
+			      0x00000000);
+		mv64x60_write(&bh,
+			      MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_3(port),
+			      0x00000000);
+		mv64x60_write(&bh,
+			      MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_4(port),
+			      0x00000000);
+		mv64x60_write(&bh,
+			      MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_5(port),
+			      0x00000000);
+		mv64x60_write(&bh,
+			      MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_6(port),
+			      0x00000000);
+		mv64x60_write(&bh,
+			      MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_7(port),
+			      0x00000000);
+	}
+
+	printk(KERN_INFO "Radstone Technology PPC7D\n");
+	if (ppc_md.progress)
+		ppc_md.progress("ppc7d_setup_arch: exit", 0);
+}
+
+/* This kernel command line parameter can be used to have the target
+ * wait for a JTAG debugger to attach. Of course, a JTAG debugger
+ * with hardware breakpoint support can have the target stop at any
+ * location during init, but this is a convenience feature that makes
+ * it easier in the common case of loading the code using the ppcboot
+ * bootloader..
+ */
+static unsigned long ppc7d_wait_debugger;
+
+static int __init ppc7d_waitdbg(char *str)
+{
+	ppc7d_wait_debugger = 1;
+	return 1;
+}
+
+__setup("waitdbg", ppc7d_waitdbg);
+
+/* Second phase board init, called after other (architecture common)
+ * low-level services have been initialized.
+ */
+static void ppc7d_init2(void)
+{
+	unsigned long flags;
+	u32 data;
+	u8 data8;
+
+	pr_debug("%s: enter\n", __FUNCTION__);
+
+	/* Wait for debugger? */
+	if (ppc7d_wait_debugger) {
+		printk("Waiting for debugger...\n");
+
+		while (readl(&ppc7d_wait_debugger)) ;
+	}
+
+	/* Hook up i8259 interrupt which is connected to GPP28 */
+	request_irq(mv64360_irq_base + MV64x60_IRQ_GPP28, ppc7d_i8259_intr,
+		    SA_INTERRUPT, "I8259 (GPP28) interrupt", (void *)0);
+
+	/* Configure MPP16 as watchdog NMI, MPP17 as watchdog WDE */
+	spin_lock_irqsave(&mv64x60_lock, flags);
+	data = mv64x60_read(&bh, MV64x60_MPP_CNTL_2);
+	data &= ~(0x0000000f << 0);
+	data |= (0x00000004 << 0);
+	data &= ~(0x0000000f << 4);
+	data |= (0x00000004 << 4);
+	mv64x60_write(&bh, MV64x60_MPP_CNTL_2, data);
+	spin_unlock_irqrestore(&mv64x60_lock, flags);
+
+	/* All LEDs off */
+	data8 = inb(PPC7D_CPLD_LEDS);
+	data8 &= ~0x08;
+	data8 |= 0x07;
+	outb(data8, PPC7D_CPLD_LEDS);
+
+	pr_debug("%s: exit\n", __FUNCTION__);
+}
+
+/* Called from machine_init(), early, before any of the __init functions
+ * have run. We must init software-configurable pins before other functions
+ * such as interrupt controllers are initialised.
+ */
+void __init platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+			  unsigned long r6, unsigned long r7)
+{
+	u8 val8;
+	u8 rev_num;
+
+	/* Map 0xe0000000-0xffffffff early because we need access to SRAM
+	 * and the ISA memory space (for serial port) here. This mapping
+	 * is redone properly in ppc7d_map_io() later.
+	 */
+	mtspr(SPRN_DBAT3U, 0xe0003fff);
+	mtspr(SPRN_DBAT3L, 0xe000002a);
+
+	/* 
+	 * Zero SRAM. Note that this generates parity errors on
+	 * internal data path in SRAM if it's first time accessing it
+	 * after reset.
+	 *
+	 * We do this ASAP to avoid parity errors when reading
+	 * uninitialized SRAM.
+	 */
+	memset((void *)PPC7D_INTERNAL_SRAM_BASE, 0, MV64360_SRAM_SIZE);
+
+	pr_debug("platform_init: r3-r7: %lx %lx %lx %lx %lx\n", 
+		 r3, r4, r5, r6, r7);
+
+	parse_bootinfo(find_bootinfo());
+
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
+		bd_t *bp = (bd_t *) __res;
+
+		/* copy board info structure */
+		memcpy((void *)__res, (void *)(r3 + KERNELBASE), sizeof(bd_t));
+		/* copy command line */
+		*(char *)(r7 + KERNELBASE) = 0;
+		strcpy(cmd_line, (char *)(r6 + KERNELBASE));
+
+		printk(KERN_INFO "Board info data:-\n");
+		printk(KERN_INFO "  Internal freq: %lu MHz, bus freq: %lu MHz\n",
+		       bp->bi_intfreq, bp->bi_busfreq);
+		printk(KERN_INFO "  Memory: %lx, size %lx\n", bp->bi_memstart,
+		       bp->bi_memsize);
+		printk(KERN_INFO "  Console baudrate: %lu\n", bp->bi_baudrate);
+		printk(KERN_INFO "  Ethernet address: "
+		       "%02x:%02x:%02x:%02x:%02x:%02x\n",
+		       bp->bi_enetaddr[0], bp->bi_enetaddr[1],
+		       bp->bi_enetaddr[2], bp->bi_enetaddr[3],
+		       bp->bi_enetaddr[4], bp->bi_enetaddr[5]);
+	}
+#ifdef CONFIG_BLK_DEV_INITRD
+	/* take care of initrd if we have one */
+	if (r4) {
+		initrd_start = r4 + KERNELBASE;
+		initrd_end = r5 + KERNELBASE;
+		printk(KERN_INFO "INITRD @ %lx/%lx\n", initrd_start, initrd_end);
+	}
+#endif /* CONFIG_BLK_DEV_INITRD */
+
+	/* Map in board regs, etc. */
+	isa_io_base = 0xe8000000;
+	isa_mem_base = 0xe8000000;
+	pci_dram_offset = 0x00000000;
+	ISA_DMA_THRESHOLD = 0x00ffffff;
+	DMA_MODE_READ = 0x44;
+	DMA_MODE_WRITE = 0x48;
+
+	ppc_md.setup_arch = ppc7d_setup_arch;
+	ppc_md.init = ppc7d_init2;
+	ppc_md.show_cpuinfo = ppc7d_show_cpuinfo;
+	ppc_md.irq_canonicalize = ppc7d_irq_canonicalize;
+	ppc_md.init_IRQ = ppc7d_init_irq;
+	ppc_md.get_irq = ppc7d_get_irq;
+
+	ppc_md.restart = ppc7d_restart;
+	ppc_md.power_off = ppc7d_power_off;
+	ppc_md.halt = ppc7d_halt;
+
+	ppc_md.find_end_of_memory = ppc7d_find_end_of_memory;
+	ppc_md.setup_io_mappings = ppc7d_map_io;
+
+	ppc_md.time_init = NULL;
+	ppc_md.set_rtc_time = NULL;
+	ppc_md.get_rtc_time = NULL;
+	ppc_md.calibrate_decr = ppc7d_calibrate_decr;
+	ppc_md.nvram_read_val = NULL;
+	ppc_md.nvram_write_val = NULL;
+
+	ppc_md.heartbeat = ppc7d_heartbeat;
+	ppc_md.heartbeat_reset = HZ;
+	ppc_md.heartbeat_count = ppc_md.heartbeat_reset;
+
+	ppc_md.pcibios_fixup_bus = ppc7d_pci_fixup_bus;
+
+#if defined(CONFIG_SERIAL_MPSC) || defined(CONFIG_MV643XX_ETH)
+	platform_notify = ppc7d_platform_notify;
+#endif
+
+#ifdef CONFIG_SERIAL_MPSC
+	/* On PPC7D, we must configure MPSC support via CPLD control
+	 * registers. 
+	 */
+	outb(PPC7D_CPLD_RTS_COM4_SCLK |
+	     PPC7D_CPLD_RTS_COM56_ENABLED, PPC7D_CPLD_RTS);
+	outb(PPC7D_CPLD_COMS_COM3_TCLKEN |
+	     PPC7D_CPLD_COMS_COM3_TXEN |
+	     PPC7D_CPLD_COMS_COM4_TCLKEN |
+	     PPC7D_CPLD_COMS_COM4_TXEN, PPC7D_CPLD_COMS);
+#endif /* CONFIG_SERIAL_MPSC */
+
+#if defined(CONFIG_KGDB) || defined(CONFIG_SERIAL_TEXT_DEBUG)
+	ppc7d_early_serial_map();
+#ifdef  CONFIG_SERIAL_TEXT_DEBUG
+#if defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	ppc_md.progress = mv64x60_mpsc_progress;
+#elif defined(CONFIG_SERIAL_8250)
+	ppc_md.progress = gen550_progress;
+#else
+#error CONFIG_KGDB || CONFIG_SERIAL_TEXT_DEBUG has no supported CONFIG_SERIAL_XXX
+#endif /* CONFIG_SERIAL_8250 */
+#endif /* CONFIG_SERIAL_TEXT_DEBUG */
+#endif /* CONFIG_KGDB || CONFIG_SERIAL_TEXT_DEBUG */
+
+	/* Enable write access to user flash.  This is necessary for
+	 * flash probe.
+	 */
+	val8 = readb((void *)isa_io_base + PPC7D_CPLD_SW_FLASH_WRITE_PROTECT);
+	writeb(val8 | (PPC7D_CPLD_SW_FLASH_WRPROT_ENABLED &
+		       PPC7D_CPLD_SW_FLASH_WRPROT_USER_MASK),
+	       (void *)isa_io_base + PPC7D_CPLD_SW_FLASH_WRITE_PROTECT);
+
+	/* Determine if this board has IBM ALMA VME devices */
+	val8 = readb((void *)isa_io_base + PPC7D_CPLD_BOARD_REVISION);
+	rev_num = (val8 & PPC7D_CPLD_BOARD_REVISION_NUMBER_MASK) >> 5;
+	if (rev_num <= 1)
+		ppc7d_has_alma = 1;
+}
Index: linux-2.6/arch/ppc/boot/simple/Makefile
===================================================================
--- linux-2.6.orig/arch/ppc/boot/simple/Makefile	2005-03-03 21:41:17.000000000 +0000
+++ linux-2.6/arch/ppc/boot/simple/Makefile	2005-03-03 21:42:04.000000000 +0000
@@ -97,6 +97,10 @@
          end-$(CONFIG_KATANA)		:= katana
    cacheflag-$(CONFIG_KATANA)		:= -include $(clear_L2_L3)
 
+     extra.o-$(CONFIG_RADSTONE_PPC7D)	:= misc-radstone_ppc7d.o mv64x60_stub.o
+         end-$(CONFIG_RADSTONE_PPC7D)	:= radstone_ppc7d
+   cacheflag-$(CONFIG_RADSTONE_PPC7D)	:= -include $(clear_L2_L3)
+
 # kconfig 'feature', only one of these will ever be 'y' at a time.
 # The rest will be unset.
 motorola := $(CONFIG_MCPN765)$(CONFIG_MVME5100)$(CONFIG_PRPMC750) \
Index: linux-2.6/arch/ppc/Kconfig
===================================================================
--- linux-2.6.orig/arch/ppc/Kconfig	2005-03-03 21:41:17.000000000 +0000
+++ linux-2.6/arch/ppc/Kconfig	2005-03-03 21:42:04.000000000 +0000
@@ -568,6 +568,10 @@
 	  Select SANDPOINT if configuring for a Motorola Sandpoint X3
 	  (any flavor).
 
+config RADSTONE_PPC7D
+	bool "Radstone Technology PPC7D board"
+	select MV64360
+
 config ADIR
 	bool "SBS-Adirondack"
 
@@ -715,7 +719,7 @@
 	bool
 	depends on SANDPOINT || MCPN765 || SPRUCE || PPLUS || PCORE || \
 		PRPMC750 || K2 || PRPMC800 || LOPEC || \
-		(EV64260 && !SERIAL_MPSC) || CHESTNUT
+		(EV64260 && !SERIAL_MPSC) || CHESTNUT || RADSTONE_PPC7D
 	default y
 
 config FORCE
@@ -730,7 +734,7 @@
 
 config MV64360
 	bool
-	depends on KATANA
+	depends on KATANA || RADSTONE_PPC7D
 	default y
 
 config MV64360
Index: linux-2.6/arch/ppc/syslib/Makefile
===================================================================
--- linux-2.6.orig/arch/ppc/syslib/Makefile	2005-03-03 21:41:17.000000000 +0000
+++ linux-2.6/arch/ppc/syslib/Makefile	2005-03-03 21:42:04.000000000 +0000
@@ -74,6 +74,7 @@
 					hawk_common.o
 obj-$(CONFIG_HARRIER)		+= harrier.o
 obj-$(CONFIG_PRPMC800)		+= open_pic.o indirect_pci.o pci_auto.o
+obj-$(CONFIG_RADSTONE_PPC7D)	+= i8259.o pci_auto.o
 obj-$(CONFIG_SANDPOINT)		+= i8259.o pci_auto.o todc_time.o
 obj-$(CONFIG_SBC82xx)		+= todc_time.o
 obj-$(CONFIG_SPRUCE)		+= cpc700_pic.o indirect_pci.o pci_auto.o \
Index: linux-2.6/arch/ppc/platforms/radstone_ppc7d.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/ppc/platforms/radstone_ppc7d.h	2005-03-03 21:42:04.000000000 +0000
@@ -0,0 +1,434 @@
+/*
+ * arch/ppc/platforms/radstone_ppc7d.h
+ *
+ * Board definitions for the Radstone PPC7D boards.
+ *
+ * Author: James Chapman <jchapman@katalix.com>
+ *
+ * Based on code done by Rabeeh Khoury - rabeeh@galileo.co.il
+ * Based on code done by - Mark A. Greer <mgreer@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+/*
+ * The MV64360 has 2 PCI buses each with 1 window from the CPU bus to
+ * PCI I/O space and 4 windows from the CPU bus to PCI MEM space.
+ * We'll only use one PCI MEM window on each PCI bus.
+ *
+ * This is the CPU physical memory map (windows must be at least 1MB
+ * and start on a boundary that is a multiple of the window size):
+ *
+ *    0xff800000-0xffffffff      - Boot window
+ *    0xff000000-0xff000fff	 - AFIX registers (DevCS2)
+ *    0xfef00000-0xfef0ffff      - Internal MV64x60 registers
+ *    0xfef40000-0xfef7ffff      - Internal SRAM
+ *    0xfef00000-0xfef0ffff      - MV64360 Registers
+ *    0x70000000-0x7fffffff      - soldered flash (DevCS3)
+ *    0xe8000000-0xe9ffffff      - PCI I/O
+ *    0x80000000-0xbfffffff      - PCI MEM
+ */
+
+#ifndef __PPC_PLATFORMS_PPC7D_H
+#define __PPC_PLATFORMS_PPC7D_H
+
+#include <asm/ppcboot.h>
+
+/*****************************************************************************
+ * CPU Physical Memory Map setup.
+ *****************************************************************************/
+
+#define PPC7D_BOOT_WINDOW_BASE			0xff800000
+#define PPC7D_AFIX_REG_BASE			0xff000000
+#define PPC7D_INTERNAL_SRAM_BASE		0xfef40000
+#define PPC7D_FLASH_BASE			0x70000000
+
+#define PPC7D_BOOT_WINDOW_SIZE_ACTUAL		0x00800000 /* 8MB */
+#define PPC7D_FLASH_SIZE_ACTUAL			0x10000000 /* 256MB */
+
+#define PPC7D_BOOT_WINDOW_SIZE		max(MV64360_WINDOW_SIZE_MIN,	\
+		PPC7D_BOOT_WINDOW_SIZE_ACTUAL)
+#define PPC7D_FLASH_SIZE		max(MV64360_WINDOW_SIZE_MIN,	\
+		PPC7D_FLASH_SIZE_ACTUAL)
+#define PPC7D_AFIX_REG_SIZE		max(MV64360_WINDOW_SIZE_MIN, 0xff)
+
+
+#define PPC7D_PCI0_MEM0_START_PROC_ADDR        0x80000000UL
+#define PPC7D_PCI0_MEM0_START_PCI_HI_ADDR      0x00000000UL
+#define PPC7D_PCI0_MEM0_START_PCI_LO_ADDR      0x80000000UL
+#define PPC7D_PCI0_MEM0_SIZE                   0x20000000UL
+#define PPC7D_PCI0_MEM1_START_PROC_ADDR        0xe8010000UL
+#define PPC7D_PCI0_MEM1_START_PCI_HI_ADDR      0x00000000UL
+#define PPC7D_PCI0_MEM1_START_PCI_LO_ADDR      0x00000000UL
+#define PPC7D_PCI0_MEM1_SIZE                   0x000f0000UL
+#define PPC7D_PCI0_IO_START_PROC_ADDR          0xe8000000UL
+#define PPC7D_PCI0_IO_START_PCI_ADDR           0x00000000UL
+#define PPC7D_PCI0_IO_SIZE                     0x00010000UL
+
+#define PPC7D_PCI1_MEM0_START_PROC_ADDR        0xa0000000UL
+#define PPC7D_PCI1_MEM0_START_PCI_HI_ADDR      0x00000000UL
+#define PPC7D_PCI1_MEM0_START_PCI_LO_ADDR      0xa0000000UL
+#define PPC7D_PCI1_MEM0_SIZE                   0x20000000UL
+#define PPC7D_PCI1_MEM1_START_PROC_ADDR        0xe9800000UL
+#define PPC7D_PCI1_MEM1_START_PCI_HI_ADDR      0x00000000UL
+#define PPC7D_PCI1_MEM1_START_PCI_LO_ADDR      0x00000000UL
+#define PPC7D_PCI1_MEM1_SIZE                   0x00800000UL
+#define PPC7D_PCI1_IO_START_PROC_ADDR          0xe9000000UL
+#define PPC7D_PCI1_IO_START_PCI_ADDR           0x00000000UL
+#define PPC7D_PCI1_IO_SIZE                     0x00010000UL
+
+#define	PPC7D_DEFAULT_BAUD			9600
+#define	PPC7D_MPSC_CLK_SRC			8	  /* TCLK */
+#define	PPC7D_MPSC_CLK_FREQ			133333333 /* 133.3333... MHz */
+
+#define	PPC7D_ETH0_PHY_ADDR			8
+#define	PPC7D_ETH1_PHY_ADDR			9
+#define	PPC7D_ETH2_PHY_ADDR			0
+
+#define PPC7D_ETH_TX_QUEUE_SIZE			400
+#define PPC7D_ETH_RX_QUEUE_SIZE			400
+
+#define	PPC7D_ETH_PORT_CONFIG_VALUE			\
+	MV64340_ETH_UNICAST_NORMAL_MODE			|	\
+	MV64340_ETH_DEFAULT_RX_QUEUE_0			|	\
+	MV64340_ETH_DEFAULT_RX_ARP_QUEUE_0		|	\
+	MV64340_ETH_RECEIVE_BC_IF_NOT_IP_OR_ARP		|	\
+	MV64340_ETH_RECEIVE_BC_IF_IP			|	\
+	MV64340_ETH_RECEIVE_BC_IF_ARP			|	\
+	MV64340_ETH_CAPTURE_TCP_FRAMES_DIS		|	\
+	MV64340_ETH_CAPTURE_UDP_FRAMES_DIS		|	\
+	MV64340_ETH_DEFAULT_RX_TCP_QUEUE_0		|	\
+	MV64340_ETH_DEFAULT_RX_UDP_QUEUE_0		|	\
+	MV64340_ETH_DEFAULT_RX_BPDU_QUEUE_0
+
+#define	PPC7D_ETH_PORT_CONFIG_EXTEND_VALUE		\
+	MV64340_ETH_SPAN_BPDU_PACKETS_AS_NORMAL		|	\
+	MV64340_ETH_PARTITION_DISABLE
+
+#define	GT_ETH_IPG_INT_RX(value)			\
+	((value & 0x3fff) << 8)
+
+#define	PPC7D_ETH_PORT_SDMA_CONFIG_VALUE		\
+	MV64340_ETH_RX_BURST_SIZE_4_64BIT		|	\
+	GT_ETH_IPG_INT_RX(0)			|	\
+	MV64340_ETH_TX_BURST_SIZE_4_64BIT
+
+#define	PPC7D_ETH_PORT_SERIAL_CONTROL_VALUE		\
+	MV64340_ETH_ENABLE_AUTO_NEG_FOR_DUPLX		|	\
+	MV64340_ETH_DISABLE_AUTO_NEG_FOR_FLOW_CTRL	|	\
+	MV64340_ETH_ADV_SYMMETRIC_FLOW_CTRL		|	\
+	MV64340_ETH_FORCE_FC_MODE_NO_PAUSE_DIS_TX	|	\
+	MV64340_ETH_FORCE_BP_MODE_NO_JAM		|	\
+	(1 << 9)					|	\
+	MV64340_ETH_DO_NOT_FORCE_LINK_FAIL		|	\
+	MV64340_ETH_RETRANSMIT_16_ATTEMPTS		|	\
+	MV64340_ETH_ENABLE_AUTO_NEG_SPEED_GMII		|	\
+	MV64340_ETH_DTE_ADV_0				|	\
+	MV64340_ETH_DISABLE_AUTO_NEG_BYPASS		|	\
+	MV64340_ETH_AUTO_NEG_NO_CHANGE			|	\
+	MV64340_ETH_MAX_RX_PACKET_9700BYTE		|	\
+	MV64340_ETH_CLR_EXT_LOOPBACK			|	\
+	MV64340_ETH_SET_FULL_DUPLEX_MODE		|	\
+	MV64340_ETH_ENABLE_FLOW_CTRL_TX_RX_IN_FULL_DUPLEX
+
+/*****************************************************************************
+ * Serial defines.
+ *****************************************************************************/
+
+#define PPC7D_SERIAL_0		0xe80003f8
+#define PPC7D_SERIAL_1		0xe80002f8
+
+#define RS_TABLE_SIZE  2
+
+/* Rate for the 1.8432 Mhz clock for the onboard serial chip */
+#define UART_CLK			1843200
+#define BASE_BAUD			( UART_CLK / 16 )
+
+#ifdef CONFIG_SERIAL_DETECT_IRQ
+#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF|ASYNC_AUTO_IRQ)
+#else
+#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF)
+#endif
+
+#define STD_SERIAL_PORT_DFNS \
+        { 0, BASE_BAUD, PPC7D_SERIAL_0, 4, STD_COM_FLAGS, /* ttyS0 */ \
+		iomem_base: (u8 *)PPC7D_SERIAL_0,			  \
+		io_type: SERIAL_IO_MEM, },				  \
+        { 0, BASE_BAUD, PPC7D_SERIAL_1, 3, STD_COM_FLAGS, /* ttyS1 */ \
+		iomem_base: (u8 *)PPC7D_SERIAL_1,			  \
+		io_type: SERIAL_IO_MEM },
+
+#define SERIAL_PORT_DFNS \
+        STD_SERIAL_PORT_DFNS
+
+/*****************************************************************************
+ * CPLD defines.
+ *
+ * Register map:-
+ *
+ * 0000 to 000F 	South Bridge DMA 1 Control
+ * 0020 and 0021 	South Bridge Interrupt 1 Control
+ * 0040 to 0043 	South Bridge Counter Control
+ * 0060 		Keyboard
+ * 0061 		South Bridge NMI Status and Control
+ * 0064 		Keyboard
+ * 0071 and 0072 	RTC R/W
+ * 0078 to 007B 	South Bridge BIOS Timer
+ * 0080 to 0090 	South Bridge DMA Pages
+ * 00A0 and 00A1 	South Bridge Interrupt 2 Control
+ * 00C0 to 00DE 	South Bridge DMA 2 Control
+ * 02E8 to 02EF 	COM6 R/W
+ * 02F8 to 02FF 	South Bridge COM2 R/W
+ * 03E8 to 03EF 	COM5 R/W
+ * 03F8 to 03FF 	South Bridge COM1 R/W
+ * 040A 		South Bridge DMA Scatter/Gather RO
+ * 040B 		DMA 1 Extended Mode WO
+ * 0410 to 043F 	South Bridge DMA Scatter/Gather
+ * 0481 to 048B 	South Bridge DMA High Pages
+ * 04D0 and 04D1 	South Bridge Edge/Level Control
+ * 04D6 		DMA 2 Extended Mode WO
+ * 0804 		Memory Configuration RO
+ * 0806 		Memory Configuration Extend RO
+ * 0808 		SCSI Activity LED R/W
+ * 080C 		Equipment Present 1 RO
+ * 080E 		Equipment Present 2 RO
+ * 0810 		Equipment Present 3 RO
+ * 0812 		Equipment Present 4 RO
+ * 0818 		Key Lock RO
+ * 0820 		LEDS R/W
+ * 0824 		COMs R/W
+ * 0826 		RTS R/W
+ * 0828 		Reset R/W
+ * 082C 		Watchdog Trig R/W
+ * 082E 		Interrupt R/W
+ * 0830 		Interrupt Status RO
+ * 0832 		PCI configuration RO
+ * 0854 		Board Revision RO
+ * 0858 		Extended ID RO
+ * 0864 		ID Link RO
+ * 0866 		Motherboard Type RO
+ * 0868 		FLASH Write control RO
+ * 086A 		Software FLASH write protect R/W
+ * 086E 		FLASH Control R/W
+ *****************************************************************************/
+
+#define PPC7D_CPLD_MEM_CONFIG			0x0804
+#define PPC7D_CPLD_MEM_CONFIG_EXTEND		0x0806
+#define PPC7D_CPLD_SCSI_ACTIVITY_LED		0x0808
+#define PPC7D_CPLD_EQUIPMENT_PRESENT_1		0x080C
+#define PPC7D_CPLD_EQUIPMENT_PRESENT_2		0x080E
+#define PPC7D_CPLD_EQUIPMENT_PRESENT_3		0x0810
+#define PPC7D_CPLD_EQUIPMENT_PRESENT_4		0x0812
+#define PPC7D_CPLD_KEY_LOCK			0x0818
+#define PPC7D_CPLD_LEDS				0x0820
+#define PPC7D_CPLD_COMS				0x0824
+#define PPC7D_CPLD_RTS				0x0826
+#define PPC7D_CPLD_RESET			0x0828
+#define PPC7D_CPLD_WATCHDOG_TRIG		0x082C
+#define PPC7D_CPLD_INTR				0x082E
+#define PPC7D_CPLD_INTR_STATUS			0x0830
+#define PPC7D_CPLD_PCI_CONFIG			0x0832
+#define PPC7D_CPLD_BOARD_REVISION		0x0854
+#define PPC7D_CPLD_EXTENDED_ID			0x0858
+#define PPC7D_CPLD_ID_LINK			0x0864
+#define PPC7D_CPLD_MOTHERBOARD_TYPE		0x0866
+#define PPC7D_CPLD_FLASH_WRITE_CNTL		0x0868
+#define PPC7D_CPLD_SW_FLASH_WRITE_PROTECT	0x086A
+#define PPC7D_CPLD_FLASH_CNTL			0x086E
+
+/* MEMORY_CONFIG_EXTEND */
+#define PPC7D_CPLD_SDRAM_BANK_SIZE_MASK		0xc0
+#define PPC7D_CPLD_SDRAM_BANK_SIZE_128M		0
+#define PPC7D_CPLD_SDRAM_BANK_SIZE_256M		0x40
+#define PPC7D_CPLD_SDRAM_BANK_SIZE_512M		0x80
+#define PPC7D_CPLD_SDRAM_BANK_SIZE_1G		0xc0
+#define PPC7D_CPLD_FLASH_DEV_SIZE_MASK		0x03
+#define PPC7D_CPLD_FLASH_BANK_NUM_MASK		0x0c
+#define PPC7D_CPLD_FLASH_DEV_SIZE_64M		0
+#define PPC7D_CPLD_FLASH_DEV_SIZE_32M		1
+#define PPC7D_CPLD_FLASH_DEV_SIZE_16M		3
+#define PPC7D_CPLD_FLASH_BANK_NUM_4		0x00
+#define PPC7D_CPLD_FLASH_BANK_NUM_3		0x04
+#define PPC7D_CPLD_FLASH_BANK_NUM_2		0x08
+#define PPC7D_CPLD_FLASH_BANK_NUM_1		0x0c
+
+/* SCSI_LED */
+#define PPC7D_CPLD_SCSI_ACTIVITY_LED_OFF	0
+#define PPC7D_CPLD_SCSI_ACTIVITY_LED_ON		1
+
+/* EQUIPMENT_PRESENT_1 */
+#define PPC7D_CPLD_EQPT_PRES_1_FITTED		0
+#define PPC7D_CPLD_EQPT_PRES_1_PMC2_MASK	(0x80 >> 2)
+#define PPC7D_CPLD_EQPT_PRES_1_PMC1_MASK	(0x80 >> 3)
+#define PPC7D_CPLD_EQPT_PRES_1_AFIX_MASK	(0x80 >> 4)
+
+/* EQUIPMENT_PRESENT_2 */
+#define PPC7D_CPLD_EQPT_PRES_2_FITTED		!0
+#define PPC7D_CPLD_EQPT_PRES_2_UNIVERSE_MASK	(0x80 >> 0)
+#define PPC7D_CPLD_EQPT_PRES_2_COM36_MASK	(0x80 >> 2)
+#define PPC7D_CPLD_EQPT_PRES_2_GIGE_MASK	(0x80 >> 3)
+#define PPC7D_CPLD_EQPT_PRES_2_DUALGIGE_MASK	(0x80 >> 4)
+
+/* EQUIPMENT_PRESENT_3 */
+#define PPC7D_CPLD_EQPT_PRES_3_PMC2_V_MASK	(0x80 >> 3)
+#define PPC7D_CPLD_EQPT_PRES_3_PMC2_5V		(0 >> 3)
+#define PPC7D_CPLD_EQPT_PRES_3_PMC2_3V		(0x80 >> 3)
+#define PPC7D_CPLD_EQPT_PRES_3_PMC1_V_MASK	(0x80 >> 4)
+#define PPC7D_CPLD_EQPT_PRES_3_PMC1_5V		(0 >> 4)
+#define PPC7D_CPLD_EQPT_PRES_3_PMC1_3V		(0x80 >> 4)
+#define PPC7D_CPLD_EQPT_PRES_3_PMC_POWER_MASK	(0x80 >> 5)
+#define PPC7D_CPLD_EQPT_PRES_3_PMC_POWER_INTER	(0 >> 5)
+#define PPC7D_CPLD_EQPT_PRES_3_PMC_POWER_VME	(0x80 >> 5)
+
+/* EQUIPMENT_PRESENT_4 */
+#define PPC7D_CPLD_EQPT_PRES_4_LPT_MASK		(0x80 >> 2)
+#define PPC7D_CPLD_EQPT_PRES_4_LPT_FITTED	(0x80 >> 2)
+#define PPC7D_CPLD_EQPT_PRES_4_PS2_USB2_MASK	(0xc0 >> 6)
+#define PPC7D_CPLD_EQPT_PRES_4_PS2_FITTED	(0x40 >> 6)
+#define PPC7D_CPLD_EQPT_PRES_4_USB2_FITTED	(0x80 >> 6)
+
+/* CPLD_LEDS */
+#define PPC7D_CPLD_LEDS_ON			(!0)
+#define PPC7D_CPLD_LEDS_OFF			(0)
+#define PPC7D_CPLD_LEDS_NVRAM_PAGE_MASK		(0xc0 >> 2)
+#define PPC7D_CPLD_LEDS_DS201_MASK		(0x80 >> 4)
+#define PPC7D_CPLD_LEDS_DS219_MASK		(0x80 >> 5)
+#define PPC7D_CPLD_LEDS_DS220_MASK		(0x80 >> 6)
+#define PPC7D_CPLD_LEDS_DS221_MASK		(0x80 >> 7)
+
+/* CPLD_COMS */
+#define PPC7D_CPLD_COMS_COM3_TCLKEN		(0x80 >> 0)
+#define PPC7D_CPLD_COMS_COM3_RTCLKEN		(0x80 >> 1)
+#define PPC7D_CPLD_COMS_COM3_MODE_MASK		(0x80 >> 2)
+#define PPC7D_CPLD_COMS_COM3_MODE_RS232		(0)
+#define PPC7D_CPLD_COMS_COM3_MODE_RS422		(0x80 >> 2)
+#define PPC7D_CPLD_COMS_COM3_TXEN		(0x80 >> 3)
+#define PPC7D_CPLD_COMS_COM4_TCLKEN		(0x80 >> 4)
+#define PPC7D_CPLD_COMS_COM4_RTCLKEN		(0x80 >> 5)
+#define PPC7D_CPLD_COMS_COM4_MODE_MASK		(0x80 >> 6)
+#define PPC7D_CPLD_COMS_COM4_MODE_RS232		(0)
+#define PPC7D_CPLD_COMS_COM4_MODE_RS422		(0x80 >> 6)
+#define PPC7D_CPLD_COMS_COM4_TXEN		(0x80 >> 7)
+
+/* CPLD_RTS */
+#define PPC7D_CPLD_RTS_COM36_LOOPBACK		(0x80 >> 0)
+#define PPC7D_CPLD_RTS_COM4_SCLK		(0x80 >> 1)
+#define PPC7D_CPLD_RTS_COM3_TXFUNC_MASK		(0xc0 >> 2)
+#define PPC7D_CPLD_RTS_COM3_TXFUNC_DISABLED	(0 >> 2)
+#define PPC7D_CPLD_RTS_COM3_TXFUNC_ENABLED	(0x80 >> 2)
+#define PPC7D_CPLD_RTS_COM3_TXFUNC_ENABLED_RTG3	(0xc0 >> 2)
+#define PPC7D_CPLD_RTS_COM3_TXFUNC_ENABLED_RTG3S (0xc0 >> 2)
+#define PPC7D_CPLD_RTS_COM56_MODE_MASK		(0x80 >> 4)
+#define PPC7D_CPLD_RTS_COM56_MODE_RS232		(0)
+#define PPC7D_CPLD_RTS_COM56_MODE_RS422		(0x80 >> 4)
+#define PPC7D_CPLD_RTS_COM56_ENABLE_MASK	(0x80 >> 5)
+#define PPC7D_CPLD_RTS_COM56_DISABLED		(0)
+#define PPC7D_CPLD_RTS_COM56_ENABLED		(0x80 >> 5)
+#define PPC7D_CPLD_RTS_COM4_TXFUNC_MASK		(0xc0 >> 6)
+#define PPC7D_CPLD_RTS_COM4_TXFUNC_DISABLED	(0 >> 6)
+#define PPC7D_CPLD_RTS_COM4_TXFUNC_ENABLED	(0x80 >> 6)
+#define PPC7D_CPLD_RTS_COM4_TXFUNC_ENABLED_RTG3	(0x40 >> 6)
+#define PPC7D_CPLD_RTS_COM4_TXFUNC_ENABLED_RTG3S (0x40 >> 6)
+
+/* WATCHDOG_TRIG */
+#define PPC7D_CPLD_WDOG_CAUSE_MASK		(0x80 >> 0)
+#define PPC7D_CPLD_WDOG_CAUSE_NORMAL_RESET	(0 >> 0)
+#define PPC7D_CPLD_WDOG_CAUSE_WATCHDOG		(0x80 >> 0)
+#define PPC7D_CPLD_WDOG_ENABLE_MASK		(0x80 >> 6)
+#define PPC7D_CPLD_WDOG_ENABLE_OFF		(0 >> 6)
+#define PPC7D_CPLD_WDOG_ENABLE_ON		(0x80 >> 6)
+#define PPC7D_CPLD_WDOG_RESETSW_MASK		(0x80 >> 7)
+#define PPC7D_CPLD_WDOG_RESETSW_OFF		(0 >> 7)
+#define PPC7D_CPLD_WDOG_RESETSW_ON		(0x80 >> 7)
+
+/* Interrupt mask and status bits */
+#define PPC7D_CPLD_INTR_TEMP_MASK		(0x80 >> 0)
+#define PPC7D_CPLD_INTR_HB8_MASK		(0x80 >> 1)
+#define PPC7D_CPLD_INTR_PHY1_MASK		(0x80 >> 2)
+#define PPC7D_CPLD_INTR_PHY0_MASK		(0x80 >> 3)
+#define PPC7D_CPLD_INTR_ISANMI_MASK		(0x80 >> 5)
+#define PPC7D_CPLD_INTR_CRITTEMP_MASK		(0x80 >> 6)
+
+/* CPLD_INTR */
+#define PPC7D_CPLD_INTR_ENABLE_OFF		(0)
+#define PPC7D_CPLD_INTR_ENABLE_ON		(!0)
+
+/* CPLD_INTR_STATUS */
+#define PPC7D_CPLD_INTR_STATUS_OFF		(0)
+#define PPC7D_CPLD_INTR_STATUS_ON		(!0)
+
+/* CPLD_PCI_CONFIG */
+#define PPC7D_CPLD_PCI_CONFIG_PCI0_MASK		0x70
+#define PPC7D_CPLD_PCI_CONFIG_PCI0_PCI33	0x00
+#define PPC7D_CPLD_PCI_CONFIG_PCI0_PCI66	0x10
+#define PPC7D_CPLD_PCI_CONFIG_PCI0_PCIX33	0x40
+#define PPC7D_CPLD_PCI_CONFIG_PCI0_PCIX66	0x50
+#define PPC7D_CPLD_PCI_CONFIG_PCI0_PCIX100      0x60
+#define PPC7D_CPLD_PCI_CONFIG_PCI0_PCIX133	0x70
+#define PPC7D_CPLD_PCI_CONFIG_PCI1_MASK		0x07
+#define PPC7D_CPLD_PCI_CONFIG_PCI1_PCI33	0x00
+#define PPC7D_CPLD_PCI_CONFIG_PCI1_PCI66	0x01
+#define PPC7D_CPLD_PCI_CONFIG_PCI1_PCIX33	0x04
+#define PPC7D_CPLD_PCI_CONFIG_PCI1_PCIX66	0x05
+#define PPC7D_CPLD_PCI_CONFIG_PCI1_PCIX100	0x06
+#define PPC7D_CPLD_PCI_CONFIG_PCI1_PCIX133	0x07
+
+/* CPLD_BOARD_REVISION */
+#define PPC7D_CPLD_BOARD_REVISION_NUMBER_MASK	0xe0
+#define PPC7D_CPLD_BOARD_REVISION_LETTER_MASK	0x1f
+
+/* CPLD_EXTENDED_ID */
+#define PPC7D_CPLD_EXTENDED_ID_PPC7D		0x18
+
+/* CPLD_ID_LINK */
+#define PPC7D_CPLD_ID_LINK_VME64_GAP_MASK	(0x80 >> 2)
+#define PPC7D_CPLD_ID_LINK_VME64_GA4_MASK	(0x80 >> 3)
+#define PPC7D_CPLD_ID_LINK_E13_MASK		(0x80 >> 4)
+#define PPC7D_CPLD_ID_LINK_E12_MASK		(0x80 >> 5)
+#define PPC7D_CPLD_ID_LINK_E7_MASK		(0x80 >> 6)
+#define PPC7D_CPLD_ID_LINK_E6_MASK		(0x80 >> 7)
+
+/* CPLD_MOTHERBOARD_TYPE */
+#define PPC7D_CPLD_MB_TYPE_ECC_ENABLE_MASK	(0x80 >> 0)
+#define PPC7D_CPLD_MB_TYPE_ECC_ENABLED		(0x80 >> 0)
+#define PPC7D_CPLD_MB_TYPE_ECC_DISABLED		(0 >> 0)
+#define PPC7D_CPLD_MB_TYPE_ECC_FITTED_MASK	(0x80 >> 3)
+#define PPC7D_CPLD_MB_TYPE_PLL_MASK		0x0c
+#define PPC7D_CPLD_MB_TYPE_PLL_133		0x00
+#define PPC7D_CPLD_MB_TYPE_PLL_100		0x08
+#define PPC7D_CPLD_MB_TYPE_PLL_64		0x04
+#define PPC7D_CPLD_MB_TYPE_HW_ID_MASK		0x03
+
+/* CPLD_FLASH_WRITE_CNTL */
+#define PPD7D_CPLD_FLASH_CNTL_WR_LINK_MASK	(0x80 >> 0)
+#define PPD7D_CPLD_FLASH_CNTL_WR_LINK_FITTED	(0x80 >> 0)
+#define PPD7D_CPLD_FLASH_CNTL_BOOT_LINK_MASK	(0x80 >> 2)
+#define PPD7D_CPLD_FLASH_CNTL_BOOT_LINK_FITTED	(0x80 >> 2)
+#define PPD7D_CPLD_FLASH_CNTL_USER_LINK_MASK	(0x80 >> 3)
+#define PPD7D_CPLD_FLASH_CNTL_USER_LINK_FITTED	(0x80 >> 3)
+#define PPD7D_CPLD_FLASH_CNTL_RECO_WR_MASK	(0x80 >> 5)
+#define PPD7D_CPLD_FLASH_CNTL_RECO_WR_ENABLED	(0x80 >> 5)
+#define PPD7D_CPLD_FLASH_CNTL_BOOT_WR_MASK	(0x80 >> 6)
+#define PPD7D_CPLD_FLASH_CNTL_BOOT_WR_ENABLED	(0x80 >> 6)
+#define PPD7D_CPLD_FLASH_CNTL_USER_WR_MASK	(0x80 >> 7)
+#define PPD7D_CPLD_FLASH_CNTL_USER_WR_ENABLED	(0x80 >> 7)
+
+/* CPLD_SW_FLASH_WRITE_PROTECT */
+#define PPC7D_CPLD_SW_FLASH_WRPROT_ENABLED	(!0)
+#define PPC7D_CPLD_SW_FLASH_WRPROT_DISABLED	(0)
+#define PPC7D_CPLD_SW_FLASH_WRPROT_SYSBOOT_MASK	(0x80 >> 6)
+#define PPC7D_CPLD_SW_FLASH_WRPROT_USER_MASK	(0x80 >> 7)
+
+/* CPLD_FLASH_WRITE_CNTL */
+#define PPC7D_CPLD_FLASH_CNTL_NVRAM_PROT_MASK	(0x80 >> 0)
+#define PPC7D_CPLD_FLASH_CNTL_NVRAM_DISABLED	(0 >> 0)
+#define PPC7D_CPLD_FLASH_CNTL_NVRAM_ENABLED	(0x80 >> 0)
+#define PPC7D_CPLD_FLASH_CNTL_ALTBOOT_LINK_MASK	(0x80 >> 1)
+#define PPC7D_CPLD_FLASH_CNTL_VMEBOOT_LINK_MASK	(0x80 >> 2)
+#define PPC7D_CPLD_FLASH_CNTL_RECBOOT_LINK_MASK	(0x80 >> 3)
+
+
+#endif /* __PPC_PLATFORMS_PPC7D_H */
Index: linux-2.6/arch/ppc/configs/radstone_ppc7d_defconfig
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/ppc/configs/radstone_ppc7d_defconfig	2005-03-03 21:42:04.000000000 +0000
@@ -0,0 +1,870 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.11-rc4
+# Thu Feb 24 21:26:04 2005
+#
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_HAVE_DEC_LOCK=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_HOTPLUG is not set
+CONFIG_KOBJECT_UEVENT=y
+# CONFIG_IKCONFIG is not set
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Processor
+#
+CONFIG_6xx=y
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
+# CONFIG_8xx is not set
+# CONFIG_E500 is not set
+CONFIG_ALTIVEC=y
+# CONFIG_TAU is not set
+# CONFIG_CPU_FREQ is not set
+CONFIG_PPC_GEN550=y
+CONFIG_PPC_STD_MMU=y
+# CONFIG_NOT_COHERENT_CACHE is not set
+
+#
+# Platform options
+#
+# CONFIG_PPC_MULTIPLATFORM is not set
+# CONFIG_APUS is not set
+# CONFIG_KATANA is not set
+# CONFIG_WILLOW is not set
+# CONFIG_CPCI690 is not set
+# CONFIG_PCORE is not set
+# CONFIG_POWERPMC250 is not set
+# CONFIG_CHESTNUT is not set
+# CONFIG_SPRUCE is not set
+# CONFIG_EV64260 is not set
+# CONFIG_LOPEC is not set
+# CONFIG_MCPN765 is not set
+# CONFIG_MVME5100 is not set
+# CONFIG_PPLUS is not set
+# CONFIG_PRPMC750 is not set
+# CONFIG_PRPMC800 is not set
+# CONFIG_SANDPOINT is not set
+CONFIG_RADSTONE_PPC7D=y
+# CONFIG_ADIR is not set
+# CONFIG_K2 is not set
+# CONFIG_PAL4 is not set
+# CONFIG_GEMINI is not set
+# CONFIG_EST8260 is not set
+# CONFIG_SBC82xx is not set
+# CONFIG_SBS8260 is not set
+# CONFIG_RPX8260 is not set
+# CONFIG_TQM8260 is not set
+# CONFIG_ADS8272 is not set
+# CONFIG_PQ2FADS is not set
+# CONFIG_LITE5200 is not set
+CONFIG_MV64360=y
+CONFIG_MV64X60=y
+
+#
+# Set bridge options
+#
+CONFIG_MV64X60_BASE=0xfef00000
+CONFIG_MV64X60_NEW_BASE=0xfef00000
+# CONFIG_SMP is not set
+# CONFIG_PREEMPT is not set
+# CONFIG_HIGHMEM is not set
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_MISC=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttyS0,9600"
+
+#
+# Bus options
+#
+CONFIG_GENERIC_ISA_DMA=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_LEGACY_PROC=y
+CONFIG_PCI_NAMES=y
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PC-card bridges
+#
+
+#
+# Advanced setup
+#
+CONFIG_ADVANCED_OPTIONS=y
+CONFIG_HIGHMEM_START=0xfe000000
+# CONFIG_LOWMEM_SIZE_BOOL is not set
+CONFIG_LOWMEM_SIZE=0x30000000
+# CONFIG_KERNEL_START_BOOL is not set
+CONFIG_KERNEL_START=0xc0000000
+# CONFIG_TASK_SIZE_BOOL is not set
+CONFIG_TASK_SIZE=0x80000000
+# CONFIG_BOOT_LOAD_BOOL is not set
+CONFIG_BOOT_LOAD=0x00800000
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_PARTITIONS is not set
+# CONFIG_MTD_CONCAT is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_FTL=y
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
+# CONFIG_MTD_CFI_GEOMETRY is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
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
+# CONFIG_MTD_PHYSMAP is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
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
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_LBD is not set
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+CONFIG_SCSI=y
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+CONFIG_BLK_DEV_SR=y
+CONFIG_BLK_DEV_SR_VENDOR=y
+CONFIG_CHR_DEV_SG=y
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+CONFIG_SCSI_MULTI_LUN=y
+CONFIG_SCSI_CONSTANTS=y
+CONFIG_SCSI_LOGGING=y
+
+#
+# SCSI Transport Attributes
+#
+CONFIG_SCSI_SPI_ATTRS=y
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_SCSI_SATA is not set
+# CONFIG_SCSI_BUSLOGIC is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_EATA_PIO is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+CONFIG_SCSI_SYM53C8XX_2=y
+CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
+CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
+CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
+# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
+# CONFIG_SCSI_IPR is not set
+# CONFIG_SCSI_QLOGIC_ISP is not set
+# CONFIG_SCSI_QLOGIC_FC is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+CONFIG_SCSI_QLA2XXX=y
+# CONFIG_SCSI_QLA21XX is not set
+# CONFIG_SCSI_QLA22XX is not set
+# CONFIG_SCSI_QLA2300 is not set
+# CONFIG_SCSI_QLA2322 is not set
+# CONFIG_SCSI_QLA6312 is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_NSP32 is not set
+# CONFIG_SCSI_DEBUG is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Macintosh device drivers
+#
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+# CONFIG_NETLINK_DEV is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+CONFIG_BRIDGE=y
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+CONFIG_NET_TULIP=y
+# CONFIG_DE2104X is not set
+CONFIG_TULIP=y
+# CONFIG_TULIP_MWI is not set
+# CONFIG_TULIP_MMIO is not set
+# CONFIG_TULIP_NAPI is not set
+# CONFIG_DE4X5 is not set
+# CONFIG_WINBOND_840 is not set
+# CONFIG_DM9102 is not set
+# CONFIG_HP100 is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+# CONFIG_DGRS is not set
+# CONFIG_EEPRO100 is not set
+CONFIG_E100=y
+# CONFIG_E100_NAPI is not set
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139CP is not set
+# CONFIG_8139TOO is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+CONFIG_R8169=y
+CONFIG_R8169_NAPI=y
+CONFIG_SK98LIN=y
+# CONFIG_VIA_VELOCITY is not set
+CONFIG_TIGON3=y
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input I/O drivers
+#
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PCIPS2 is not set
+CONFIG_SERIO_LIBPS2=y
+# CONFIG_SERIO_RAW is not set
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_ATKBD=y
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+CONFIG_KEYBOARD_XTKBD=y
+# CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+# CONFIG_VT_CONSOLE is not set
+CONFIG_HW_CONSOLE=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_MPSC=y
+# CONFIG_SERIAL_MPSC_CONSOLE is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+CONFIG_WATCHDOG=y
+CONFIG_WATCHDOG_NOWAYOUT=y
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+CONFIG_MV64X60_WDT=y
+
+#
+# PCI-based Watchdog Cards
+#
+# CONFIG_PCIPCWATCHDOG is not set
+# CONFIG_WDTPCI is not set
+# CONFIG_NVRAM is not set
+CONFIG_GEN_RTC=y
+# CONFIG_GEN_RTC_X is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB is not set
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
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
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+CONFIG_ISO9660_FS=y
+# CONFIG_JOLIET is not set
+# CONFIG_ZISOFS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+# CONFIG_DEVFS_FS is not set
+# CONFIG_DEVPTS_FS_XATTR is not set
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_JFFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+# CONFIG_JFFS2_FS_NAND is not set
+# CONFIG_JFFS2_FS_NOR_ECC is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+
+#
+# Library routines
+#
+CONFIG_CRC_CCITT=y
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_DEBUG_KERNEL is not set
+# CONFIG_SERIAL_TEXT_DEBUG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Hardware crypto devices
+#
Index: linux-2.6/include/asm-ppc/serial.h
===================================================================
--- linux-2.6.orig/include/asm-ppc/serial.h	2005-03-03 21:41:17.000000000 +0000
+++ linux-2.6/include/asm-ppc/serial.h	2005-03-03 21:42:04.000000000 +0000
@@ -34,6 +34,8 @@
 #include <asm/ibm4xx.h>
 #elif defined(CONFIG_85xx)
 #include <asm/mpc85xx.h>
+#elif defined(CONFIG_RADSTONE_PPC7D)
+#include <platforms/radstone_ppc7d.h>
 #else
 
 /*

--------------070809050105090705080000--
