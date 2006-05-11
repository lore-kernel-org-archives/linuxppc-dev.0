Return-Path: <jotken@softadvances.com>
Received: from elasmtp-kukur.atl.sa.earthlink.net
	(elasmtp-kukur.atl.sa.earthlink.net [209.86.89.65])
	by ozlabs.org (Postfix) with ESMTP id D19F2679E6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 May 2006 04:25:32 +1000 (EST)
Message-ID: <44638197.1030207@softadvances.com>
Date: Thu, 11 May 2006 13:25:27 -0500
From: John Otken <jotken@softadvances.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 1/2] Support AMCC Taihu 405EP Eval Board
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch adds support for the AMCC Taihu 405EP
evaluation board.

I tested it against the latest Denx git tree
(2.6.17-rc3).

The defconfig file follows.

Comments are welcome.

Signed-off-by: John Otken <jotken@softadvances.com>


  arch/ppc/platforms/4xx/Kconfig    |   15
  arch/ppc/platforms/4xx/Makefile   |    1
  arch/ppc/platforms/4xx/taihu.c    |  260 +++++
  arch/ppc/platforms/4xx/taihu.h    |  105 ++
  drivers/mtd/maps/Kconfig          |    8
  drivers/mtd/maps/Makefile         |    1
  drivers/mtd/maps/taihu.c          |  155 +++
  drivers/usb/gadget/Kconfig        |   11
  drivers/usb/gadget/Makefile       |    1
  drivers/usb/gadget/epautoconf.c   |   15
  drivers/usb/gadget/gadget_chips.h |    8
  drivers/usb/gadget/pd12_udc.c     | 1821 +++++++++++++++++++++++++++++++++++++
  drivers/usb/gadget/pd12_udc.h     |  148 +++
  include/asm-ppc/ibm4xx.h          |    4
  14 files changed, 2548 insertions(+), 5 deletions(-)
  create mode 100644 arch/ppc/platforms/4xx/taihu.c
  create mode 100644 arch/ppc/platforms/4xx/taihu.h
  create mode 100644 drivers/mtd/maps/taihu.c
  create mode 100755 drivers/usb/gadget/pd12_udc.c
  create mode 100644 drivers/usb/gadget/pd12_udc.h



diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index 51414c4..4efba1e 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -66,6 +66,12 @@ config XILINX_ML403
  	bool "Xilinx-ML403"
  	help
  	  This option enables support for the Xilinx ML403 evaluation board.
+
+config TAIHU
+	bool "Taihu"
+	select WANT_EARLY_SERIAL
+	help
+	  This option enables support for the AMCC 405EP evaluation board.
  endchoice

  choice
@@ -120,7 +126,6 @@ config YOSEMITE
         select WANT_EARLY_SERIAL
         help
           This option enables support for the AMCC PPC440EP evaluation board.
-
  endchoice

  config EP405PC
@@ -201,7 +206,7 @@ config BOOKE

  config IBM_OCP
  	bool
-	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || YUCCA || OCOTEA || P3P440 || PPChameleonEVB || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT || YELLOWSTONE || YOSEMITE
+	depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || YUCCA || OCOTEA || P3P440 || PPChameleonEVB || REDWOOD_5 || REDWOOD_6 || SYCAMORE || TAIHU || WALNUT || YELLOWSTONE || YOSEMITE
  	default y

  config IBM_EMAC4
@@ -211,7 +216,7 @@ config IBM_EMAC4

  config BIOS_FIXUP
  	bool
-	depends on BUBINGA || EP405 || SYCAMORE || WALNUT
+	depends on BUBINGA || EP405 || SYCAMORE || TAIHU || WALNUT
  	default y

  # OAK doesn't exist but wanted to keep this around for any future 403GCX boards
@@ -222,7 +227,7 @@ config 403GCX

  config 405EP
  	bool
-	depends on BUBINGA || PPChameleonEVB
+	depends on BUBINGA || PPChameleonEVB || TAIHU
  	default y

  config 405GP
@@ -262,7 +267,7 @@ config EMBEDDEDBOOT

  config IBM_OPENBIOS
  	bool
-	depends on ASH || REDWOOD_5 || REDWOOD_6
+	depends on ASH || REDWOOD_5 || REDWOOD_6 || TAIHU
  	default y

  config PPC4xx_DMA
diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makefile
index d3a7a16..86374ff 100644
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_PPChameleonEVB)	+= ppchamel
  obj-$(CONFIG_REDWOOD_5)		+= redwood5.o
  obj-$(CONFIG_REDWOOD_6)		+= redwood6.o
  obj-$(CONFIG_SYCAMORE)		+= sycamore.o
+obj-$(CONFIG_TAIHU)		+= taihu.o
  obj-$(CONFIG_WALNUT)		+= walnut.o
  obj-$(CONFIG_XILINX_ML300)	+= xilinx_ml300.o
  obj-$(CONFIG_XILINX_ML403)	+= xilinx_ml403.o
diff --git a/arch/ppc/platforms/4xx/taihu.c b/arch/ppc/platforms/4xx/taihu.c
new file mode 100644
index 0000000..94bd72d
--- /dev/null
+++ b/arch/ppc/platforms/4xx/taihu.c
@@ -0,0 +1,260 @@
+/*
+ * Support for IBM PPC 405EP evaluation board (Taihu).
+ *
+ * Author: SAW (IBM), derived from walnut.c.
+ *         Maintained by MontaVista Software <source@mvista.com>
+ *
+ * 2003 (c) MontaVista Softare Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/threads.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/blkdev.h>
+#include <linux/pci.h>
+#include <linux/rtc.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+
+#include <asm/system.h>
+#include <asm/pci-bridge.h>
+#include <asm/processor.h>
+#include <asm/machdep.h>
+#include <asm/page.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/todc.h>
+#include <asm/kgdb.h>
+#include <asm/ocp.h>
+#include <asm/ibm_ocp_pci.h>
+
+#include <platforms/4xx/ibm405ep.h>
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
+extern bd_t __res;
+
+
+/* Some IRQs unique to the board
+ * Used by the generic 405 PCI setup functions in ppc4xx_pci.c
+ */
+int __init
+ppc405_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	static char pci_irq_table[][4] =
+	    /*
+	     *      PCI IDSEL/INTPIN->INTLINE
+	     *      A       B       C       D
+	     */
+	{
+		{25, 26, 27, 28},	/* IDSEL 1 - PCI slot 1 */
+		{26, 27, 28, 25},	/* IDSEL 2 - PCI slot 2 */
+	};
+
+	const long min_idsel = 6, max_idsel = 7, irqs_per_slot = 4;
+	return PCI_IRQ_TABLE_LOOKUP;
+};
+
+/* The serial clock for the chip is an internal clock determined by
+ * different clock speeds/dividers.
+ * Calculate the proper input baud rate and setup the serial driver.
+ */
+static void __init
+taihu_early_serial_map(void)
+{
+	u32 uart_div;
+	int uart_clock;
+	struct uart_port port;
+
+         /* Calculate the serial clock input frequency
+          *
+          * The base baud is the PLL OUTA (provided in the board info
+          * structure) divided by the external UART Divisor, divided
+          * by 16.
+          */
+	uart_div = (mfdcr(DCRN_CPC0_UCR_BASE) & DCRN_CPC0_UCR_U0DIV);
+	uart_clock = __res.bi_pllouta_freq / uart_div;
+
+	/* Setup serial port access */
+	memset(&port, 0, sizeof(port));
+	port.membase = (void*)ACTING_UART0_IO_BASE;
+	port.irq = ACTING_UART0_INT;
+	port.uartclk = uart_clock;
+	port.regshift = 0;
+	port.iotype = SERIAL_IO_MEM;
+	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+	port.line = 0;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 0 failed\n");
+	}
+
+	port.membase = (void*)ACTING_UART1_IO_BASE;
+	port.irq = ACTING_UART1_INT;
+	port.line = 1;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 1 failed\n");
+	}
+}
+
+void __init
+bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
+{
+
+	unsigned int bar_response, bar;
+	/*
+	 * Expected PCI mapping:
+	 *
+	 *  PLB addr             PCI memory addr
+	 *  ---------------------       ---------------------
+	 *  0000'0000 - 7fff'ffff <---  0000'0000 - 7fff'ffff
+	 *  8000'0000 - Bfff'ffff --->  8000'0000 - Bfff'ffff
+	 *
+	 *  PLB addr             PCI io addr
+	 *  ---------------------       ---------------------
+	 *  e800'0000 - e800'ffff --->  0000'0000 - 0001'0000
+	 *
+	 * The following code is simplified by assuming that the bootrom
+	 * has been well behaved in following this mapping.
+	 */
+
+#ifdef DEBUG
+	int i;
+
+	printk("ioremap PCLIO_BASE = 0x%x\n", pcip);
+	printk("PCI bridge regs before fixup \n");
+	for (i = 0; i <= 3; i++) {
+		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].ma)));
+		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].la)));
+		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pcila)));
+		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pciha)));
+	}
+	printk(" ptm1ms\t0x%x\n", in_le32(&(pcip->ptm1ms)));
+	printk(" ptm1la\t0x%x\n", in_le32(&(pcip->ptm1la)));
+	printk(" ptm2ms\t0x%x\n", in_le32(&(pcip->ptm2ms)));
+	printk(" ptm2la\t0x%x\n", in_le32(&(pcip->ptm2la)));
+
+#endif
+
+	/* added for IBM boot rom version 1.15 bios bar changes  -AK */
+
+	/* Disable region first */
+	out_le32((void *) &(pcip->pmm[0].ma), 0x00000000);
+	/* PLB starting addr, PCI: 0x80000000 */
+	out_le32((void *) &(pcip->pmm[0].la), 0x80000000);
+	/* PCI start addr, 0x80000000 */
+	out_le32((void *) &(pcip->pmm[0].pcila), PPC405_PCI_MEM_BASE);
+	/* 512MB range of PLB to PCI */
+	out_le32((void *) &(pcip->pmm[0].pciha), 0x00000000);
+	/* Enable no pre-fetch, enable region */
+	out_le32((void *) &(pcip->pmm[0].ma), ((0xffffffff -
+						(PPC405_PCI_UPPER_MEM -
+						 PPC405_PCI_MEM_BASE)) | 0x01));
+
+	/* Disable region one */
+	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
+	out_le32((void *) &(pcip->pmm[1].la), 0x00000000);
+	out_le32((void *) &(pcip->pmm[1].pcila), 0x00000000);
+	out_le32((void *) &(pcip->pmm[1].pciha), 0x00000000);
+	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
+	out_le32((void *) &(pcip->ptm1ms), 0x00000001);
+
+	/* Disable region two */
+	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
+	out_le32((void *) &(pcip->pmm[2].la), 0x00000000);
+	out_le32((void *) &(pcip->pmm[2].pcila), 0x00000000);
+	out_le32((void *) &(pcip->pmm[2].pciha), 0x00000000);
+	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
+	out_le32((void *) &(pcip->ptm2ms), 0x00000000);
+	out_le32((void *) &(pcip->ptm2la), 0x00000000);
+
+	/* Zero config bars */
+	for (bar = PCI_BASE_ADDRESS_1; bar <= PCI_BASE_ADDRESS_2; bar += 4) {
+		early_write_config_dword(hose, hose->first_busno,
+					 PCI_FUNC(hose->first_busno), bar,
+					 0x00000000);
+		early_read_config_dword(hose, hose->first_busno,
+					PCI_FUNC(hose->first_busno), bar,
+					&bar_response);
+		DBG("BUS %d, device %d, Function %d bar 0x%8.8x is 0x%8.8x\n",
+		    hose->first_busno, PCI_SLOT(hose->first_busno),
+		    PCI_FUNC(hose->first_busno), bar, bar_response);
+	}
+	/* end work arround */
+
+#ifdef DEBUG
+	printk("PCI bridge regs after fixup \n");
+	for (i = 0; i <= 3; i++) {
+		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].ma)));
+		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].la)));
+		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pcila)));
+		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pciha)));
+	}
+	printk(" ptm1ms\t0x%x\n", in_le32(&(pcip->ptm1ms)));
+	printk(" ptm1la\t0x%x\n", in_le32(&(pcip->ptm1la)));
+	printk(" ptm2ms\t0x%x\n", in_le32(&(pcip->ptm2ms)));
+	printk(" ptm2la\t0x%x\n", in_le32(&(pcip->ptm2la)));
+
+#endif
+}
+
+static void __init
+taihu_set_emacdata(void)
+{
+	struct ocp_def *def;
+	struct ocp_func_emac_data *emacdata;
+
+	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
+	emacdata = def->additions;
+	emacdata->phy_map = 0x000fffff;	/* skip 0x00 .. 0x13 */
+}
+
+void __init
+taihu_setup_arch(void)
+{
+	taihu_set_emacdata();
+
+	ppc4xx_setup_arch();
+
+	ibm_ocp_set_emac(0, 1);
+
+        taihu_early_serial_map();
+
+        /* Identify the system */
+        printk("AMCC PowerPC 405EP Taihu Platform\n");
+}
+
+void __init
+taihu_map_io(void)
+{
+	ppc4xx_map_io();
+}
+
+void __init
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+	      unsigned long r6, unsigned long r7)
+{
+	ppc4xx_init(r3, r4, r5, r6, r7);
+
+	ppc_md.setup_arch = taihu_setup_arch;
+	ppc_md.setup_io_mappings = taihu_map_io;
+
+#ifdef CONFIG_KGDB
+	ppc_md.early_serial_map = taihu_early_serial_map;
+#endif
+}
+
diff --git a/arch/ppc/platforms/4xx/taihu.h b/arch/ppc/platforms/4xx/taihu.h
new file mode 100644
index 0000000..eb2aa7a
--- /dev/null
+++ b/arch/ppc/platforms/4xx/taihu.h
@@ -0,0 +1,105 @@
+/*
+ * Support for IBM PPC 405EP evaluation board (Taihu).
+ *
+ * Author: SAW (IBM), derived from walnut.h.
+ *         Maintained by MontaVista Software <source@mvista.com>
+ *
+ * 2003 (c) MontaVista Softare Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifdef __KERNEL__
+#ifndef __TAIHU_H__
+#define __TAIHU_H__
+
+/* 405EP */
+#include <platforms/4xx/ibm405ep.h>
+
+#ifndef __ASSEMBLY__
+/*
+ * Data structure defining board information maintained by the boot
+ * ROM on IBM's evaluation board. An effort has been made to
+ * keep the field names consistent with the 8xx 'bd_t' board info
+ * structures.
+ */
+#define CONFIG_HAS_ETH1 1
+typedef struct board_info {
+	unsigned long	bi_memstart;	/* start of DRAM memory */
+	unsigned long	bi_memsize;	/* size	 of DRAM memory in bytes */
+	unsigned long	bi_flashstart;	/* start of FLASH memory */
+	unsigned long	bi_flashsize;	/* size	 of FLASH memory */
+	unsigned long	bi_flashoffset; /* reserved area for startup monitor */
+	unsigned long	bi_sramstart;	/* start of SRAM memory */
+	unsigned long	bi_sramsize;	/* size	 of SRAM memory */
+	unsigned long	bi_bootflags;	/* boot / reboot flag (for LynxOS) */
+	unsigned long	bi_ip_addr;	/* IP Address */
+	unsigned char	bi_enetaddr[6];	/* Ethernet adress */
+	unsigned short	bi_ethspeed;	/* Ethernet speed in Mbps */
+	unsigned long	bi_intfreq;	/* Internal Freq, in MHz */
+	unsigned long	bi_busfreq;	/* Bus Freq, in MHz */
+	unsigned long	bi_baudrate;	/* Console Baudrate */
+#if defined(CONFIG_405)   || \
+    defined(CONFIG_405GP) || \
+    defined(CONFIG_405CR) || \
+    defined(CONFIG_405EP) || \
+    defined(CONFIG_440)
+	unsigned char	bi_s_version[4];	/* Version of this structure */
+	unsigned char	bi_r_version[32];	/* Version of the ROM (IBM) */
+	unsigned int	bi_pllouta_freq;	/* CPU (Internal) Freq, in Hz */
+	unsigned int	bi_plb_busfreq;	/* PLB Bus speed, in Hz */
+	unsigned int	bi_pci_busfreq;	/* PCI Bus speed, in Hz */
+	unsigned char	bi_pci_enetaddr[6];	/* PCI Ethernet MAC address */
+#endif
+
+#ifdef CONFIG_HAS_ETH1
+	/* second onboard ethernet port */
+	unsigned char   bi_enet1addr[6];
+#endif
+#ifdef CONFIG_HAS_ETH2
+	/* third onboard ethernet port */
+	unsigned char	bi_enet2addr[6];
+#endif
+#ifdef CONFIG_HAS_ETH3
+	unsigned char   bi_enet3addr[6];
+#endif
+
+#if defined(CONFIG_405GP) || defined(CONFIG_405EP) || defined (CONFIG_440GX) || \
+    defined(CONFIG_440EP) || defined(CONFIG_440GR)
+	unsigned int	bi_opbfreq;		/* OPB clock in Hz */
+	int		bi_iic_fast[2];		/* Use fast i2c mode */
+#endif
+#if defined(CONFIG_4xx)
+#if defined(CONFIG_440GX)
+	int 		bi_phynum[4];           /* Determines phy mapping */
+	int 		bi_phymode[4];          /* Determines phy mode */
+#elif defined(CONFIG_405EP) || defined(CONFIG_440)
+	int 		bi_phynum[2];           /* Determines phy mapping */
+	int 		bi_phymode[2];          /* Determines phy mode */
+#else
+	int 		bi_phynum[1];           /* Determines phy mapping */
+	int 		bi_phymode[1];          /* Determines phy mode */
+#endif
+#endif /* defined(CONFIG_4xx) */
+} bd_t;
+
+/* Some 4xx parts use a different timebase frequency from the internal clock.
+*/
+#define bi_tbfreq bi_intfreq
+
+
+/* The UART clock is based off an internal clock -
+ * define BASE_BAUD based on the internal clock and divider(s).
+ * Since BASE_BAUD must be a constant, we will initialize it
+ * using clock/divider values which OpenBIOS initializes
+ * for typical configurations at various CPU speeds.
+ * The base baud is calculated as (FWDA / EXT UART DIV / 16)
+ */
+#define BASE_BAUD      691200
+
+#define PPC4xx_MACHINE_NAME     "AMCC Taihu"
+
+#endif /* !__ASSEMBLY__ */
+#endif /* __TAIHU_H__ */
+#endif /* __KERNEL__ */
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 9848471..41941c7 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -321,6 +321,14 @@ config MTD_ARCTIC
  	  Arctic board. If you have one of these boards and would like to
  	  use the flash chips on it, say 'Y'.

+config MTD_TAIHU
+	tristate "Flash device mapped on AMCC 405EP Taihu"
+	depends on MTD_CFI && PPC32 && 40x && TAIHU
+	help
+	  This enables access routines for the flash chips on the AMCC 405EP
+	  Taihu board. If you have one of these boards and would like to
+	  use the flash chips on it, say 'Y'.
+
  config MTD_WALNUT
  	tristate "Flash device mapped on AMCC 405GP/r/EP Walnut/Sycamore/Bubinga"
  	depends on MTD_JEDECPROBE && (WALNUT || SYCAMORE || BUBINGA)
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index c2cf73a..b2210de 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_MTD_OCOTEA)	+= ocotea.o
  obj-$(CONFIG_MTD_BAMBOO)	+= bamboo.o
  obj-$(CONFIG_MTD_BEECH)		+= beech-mtd.o
  obj-$(CONFIG_MTD_ARCTIC)	+= arctic-mtd.o
+obj-$(CONFIG_MTD_TAIHU)         += taihu.o
  obj-$(CONFIG_MTD_WALNUT)        += walnut.o
  obj-$(CONFIG_MTD_YOSEMITE)      += yosemite.o
  obj-$(CONFIG_MTD_H720X)		+= h720x-flash.o
diff --git a/drivers/mtd/maps/taihu.c b/drivers/mtd/maps/taihu.c
new file mode 100644
index 0000000..432e07d
--- /dev/null
+++ b/drivers/mtd/maps/taihu.c
@@ -0,0 +1,155 @@
+/*
+ *
+ * drivers/mtd/maps/taihu.c
+ *
+ * FLASH map for the AMCC Taihu boards.
+ *
+ * 2005 UDTech, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+
+#include <asm/io.h>
+
+#define BOOTWINDOW_ADDR 0xffe00000
+#define BOOTWINDOW_SIZE 0x00200000
+
+#define APPWINDOW_ADDR 	0xfc000000
+#define APPWINDOW_SIZE 	0x02000000
+
+
+static struct mtd_partition taihu_bootflash_partitions[] = {
+        {
+		.name = "kozio diags",
+		.offset = 0,
+		.size = 0x001a0000,
+		.mask_flags = MTD_WRITEABLE      /* force read-only */
+	},
+	{
+		.name = "u-boot env",
+		.offset = 0x001a0000,
+		.size = 0x00020000
+	},
+	{
+		.name = "u-boot",
+		.offset = 0x001c0000,
+		.size = 0x00040000,
+		.mask_flags = MTD_WRITEABLE     /* force read-only */
+	}
+};
+
+struct map_info taihu_bootflash_map = {
+	.name = "AMCC Taihu Boot Flash",
+	.size = BOOTWINDOW_SIZE,
+	.bankwidth = 2,
+	.phys = BOOTWINDOW_ADDR,
+};
+
+static struct mtd_partition taihu_appflash_partitions[] = {
+	{
+		.name = "kernel",
+		.offset = 0,
+		.size = 0x00300000,
+		.mask_flags = MTD_WRITEABLE	/* force read-only */
+	},
+	{
+		.name = "initrd",
+		.offset = 0x00300000,
+		.size = 0x01a00000,
+		.mask_flags = MTD_WRITEABLE    /* force read-only */
+	},
+	{
+		.name = "jffs2",
+		.offset = 0x01D00000,
+		.size = 0x00300000
+	}
+};
+
+
+struct map_info taihu_appflash_map = {
+	.name = "AMCC Taihu Application Flash",
+	.size = APPWINDOW_SIZE,
+	.bankwidth = 2,
+	.phys = APPWINDOW_ADDR,
+};
+
+
+#define NUM_TAIHU_FLASH_PARTITIONS(parts) \
+	(sizeof(parts)/sizeof(parts[0]))
+
+static struct mtd_info *taihu_mtd;
+
+int __init init_taihu_flash(void)
+{
+
+	printk(KERN_NOTICE "taihu: bootflash mapping: %x at %x\n",
+			BOOTWINDOW_SIZE, BOOTWINDOW_ADDR);
+	taihu_bootflash_map.virt = ioremap(BOOTWINDOW_ADDR, BOOTWINDOW_SIZE);
+	if (!taihu_bootflash_map.virt) {
+		printk("init_taihu_flash: failed to ioremap for bootflash\n");
+		return -EIO;
+	}
+	simple_map_init(&taihu_bootflash_map);
+	taihu_mtd = do_map_probe("cfi_probe", &taihu_bootflash_map);
+	if (taihu_mtd) {
+		taihu_mtd->owner = THIS_MODULE;
+		add_mtd_partitions(taihu_mtd,
+				taihu_bootflash_partitions,
+				ARRAY_SIZE(taihu_bootflash_partitions));
+	} else {
+		printk("map probe failed (bootflash)\n");
+		return -ENXIO;
+	}
+
+	printk(KERN_NOTICE "taihu: appflash mapping: %x at %x\n",
+			APPWINDOW_SIZE, APPWINDOW_ADDR);
+	taihu_appflash_map.virt = ioremap(APPWINDOW_ADDR, APPWINDOW_SIZE);
+	if (!taihu_appflash_map.virt) {
+		printk("init_taihu_flash: failed to ioremap for appflash\n");
+		return -EIO;
+	}
+	simple_map_init(&taihu_appflash_map);
+	taihu_mtd = do_map_probe("cfi_probe", &taihu_appflash_map);
+	if (taihu_mtd) {
+		taihu_mtd->owner = THIS_MODULE;
+		add_mtd_partitions(taihu_mtd,
+				taihu_appflash_partitions,
+				ARRAY_SIZE(taihu_appflash_partitions));
+	} else {
+		printk("map probe failed (appflash)\n");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static void __exit cleanup_taihu_flash(void)
+{
+	if (taihu_mtd) {
+		del_mtd_partitions(taihu_mtd);
+		/* moved iounmap after map_destroy - armin */
+		map_destroy(taihu_mtd);
+	}
+
+	if (taihu_bootflash_map.virt)
+		iounmap((void *)taihu_bootflash_map.virt);
+	if (taihu_appflash_map.virt)
+		iounmap((void *)taihu_appflash_map.virt);
+}
+
+module_init(init_taihu_flash);
+module_exit(cleanup_taihu_flash);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MTD map driver for the AMCC Taihu board");
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 363b2ad..c541e12 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -154,6 +154,17 @@ config USB_LH7A40X
  	default USB_GADGET
  	select USB_GADGET_SELECTED

+config USB_GADGET_PD12
+	boolean "PD12 UDC"
+	depends on TAIHU
+	help
+    This driver provides USB Device Controller driver for PD12 UDC
+
+config USB_PD12
+	tristate
+	depends on USB_GADGET_PD12
+	default USB_GADGET
+	select USB_GADGET_SELECTED

  config USB_GADGET_OMAP
  	boolean "OMAP USB Device Controller"
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index 5a28e61..4422f49 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_USB_GOKU)		+= goku_udc.o
  obj-$(CONFIG_USB_OMAP)		+= omap_udc.o
  obj-$(CONFIG_USB_LH7A40X)	+= lh7a40x_udc.o
  obj-$(CONFIG_USB_AT91)		+= at91_udc.o
+obj-$(CONFIG_USB_PD12)	+= pd12_udc.o

  #
  # USB gadget drivers
diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index f7c6d75..9c32fa8 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -274,6 +274,21 @@ struct usb_ep * __init usb_ep_autoconfig
  		ep = find_ep (gadget, "ep1-bulk");
  		if (ep && ep_matches (gadget, ep, desc))
  			return ep;
+
+	} else if (gadget_is_pd12 (gadget)) {
+		if (USB_ENDPOINT_XFER_BULK == type
+				&& (USB_DIR_IN & desc->bEndpointAddress)) {
+			/* single buffering is enough */
+			ep = find_ep (gadget, "ep2in-bulk");
+			if (ep && ep_matches (gadget, ep, desc))
+				return ep;
+		} else if (USB_ENDPOINT_XFER_BULK == type
+				&& (USB_DIR_OUT & desc->bEndpointAddress)) {
+			/* DMA may be available */
+			ep = find_ep (gadget, "ep1out-bulk");
+			if (ep && ep_matches (gadget, ep, desc))
+				return ep;
+		}
  	}

  	/* Second, look at endpoints until an unclaimed one looks usable */
diff --git a/drivers/usb/gadget/gadget_chips.h b/drivers/usb/gadget/gadget_chips.h
index aa80f09..af3767c 100644
--- a/drivers/usb/gadget/gadget_chips.h
+++ b/drivers/usb/gadget/gadget_chips.h
@@ -87,6 +87,12 @@
  #define gadget_is_at91(g)	0
  #endif

+#ifdef CONFIG_USB_GADGET_PD12
+#define gadget_is_pd12(g)	!strcmp("pd12_udc", (g)->name)
+#else
+#define gadget_is_pd12(g)	0
+#endif
+
  #ifdef CONFIG_USB_GADGET_IMX
  #define gadget_is_imx(g)	!strcmp("imx_udc", (g)->name)
  #else
@@ -169,5 +175,7 @@ static inline int usb_gadget_controller_
  		return 0x16;
  	else if (gadget_is_mpc8272(gadget))
  		return 0x17;
+	else if (gadget_is_pd12(gadget))
+		return 0x18;
  	return -ENOENT;
  }
diff --git a/drivers/usb/gadget/pd12_udc.c b/drivers/usb/gadget/pd12_udc.c
new file mode 100755
index 0000000..6c52353
--- /dev/null
+++ b/drivers/usb/gadget/pd12_udc.c
@@ -0,0 +1,1821 @@
+/*
+ * linux/drivers/usb/gadget/pd12_udc.c
+ * Taihu pd12-udc full speed USB device controllers
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include "pd12_udc.h"
+
+/*#define DEBUG_PD12 printk*/
+/*#define DEBUG_PD12_EP0 printk*/
+/*#define DEBUG_PD12_SETUP printk*/
+
+#ifndef DEBUG_PD12_EP0
+# define DEBUG_PD12_EP0(fmt,args...)
+#endif
+#ifndef DEBUG_PD12_SETUP
+# define DEBUG_PD12_SETUP(fmt,args...)
+#endif
+#ifndef DEBUG_PD12
+# define NO_STATES
+# define DEBUG_PD12(fmt,args...)
+#endif
+
+#define	DRIVER_DESC			"PD12 USB Device Controller"
+#define	DRIVER_VERSION		__DATE__
+
+
+static const char driver_name[] = "pd12_udc";
+static const char driver_desc[] = DRIVER_DESC;
+static const char ep0name[] = "ep0-control";
+static void __iomem *th_pd12_virt;
+static void __iomem *th_cpld_virt;
+static u8 first_tran = 1;
+
+#define DEV_CMD_ADDR  ((ulong)th_pd12_virt+1)
+#define DEV_DATA_ADDR (th_pd12_virt)
+
+#define CPLD_REG0_ADDR (th_cpld_virt)
+#define CPLD_REG1_ADDR ((ulong)th_cpld_virt+1)
+/*
+  Local definintions.
+*/
+
+#ifndef NO_STATES
+static char *state_names[] = {
+	"WAIT_FOR_SETUP",
+	"DATA_STATE_XMIT",
+	"DATA_STATE_NEED_ZLP",
+	"WAIT_FOR_OUT_STATUS",
+	"DATA_STATE_RECV"
+};
+#endif
+
+/*
+  Local declarations.
+*/
+static int pd12_ep_enable(struct usb_ep *ep,
+			     const struct usb_endpoint_descriptor *);
+static int pd12_ep_disable(struct usb_ep *ep);
+static struct usb_request *pd12_alloc_request(struct usb_ep *ep, unsigned);
+static void pd12_free_request(struct usb_ep *ep, struct usb_request *);
+static void *pd12_alloc_buffer(struct usb_ep *ep, unsigned, dma_addr_t *,
+				  unsigned);
+static void pd12_free_buffer(struct usb_ep *ep, void *, dma_addr_t,
+				unsigned);
+static int pd12_queue(struct usb_ep *ep, struct usb_request *, unsigned);
+static int pd12_dequeue(struct usb_ep *ep, struct usb_request *);
+static int pd12_set_halt(struct usb_ep *ep, int);
+static void pd12_ep0_kick(struct pd12_udc *dev, struct pd12_ep *ep);
+static void pd12_handle_ep0(struct pd12_udc *dev);
+
+static void done(struct pd12_ep *ep, struct pd12_request *req,
+		 int status);
+static void stop_activity(struct pd12_udc *dev,
+			  struct usb_gadget_driver *driver);
+static void flush(struct pd12_ep *ep);
+static void udc_enable(struct pd12_udc *dev);
+static void udc_set_address(struct pd12_udc *dev, unsigned char address);
+
+static struct usb_ep_ops pd12_ep_ops = {
+	.enable = pd12_ep_enable,
+	.disable = pd12_ep_disable,
+
+	.alloc_request = pd12_alloc_request,
+	.free_request = pd12_free_request,
+
+	.alloc_buffer = pd12_alloc_buffer,
+	.free_buffer = pd12_free_buffer,
+
+	.queue = pd12_queue,
+	.dequeue = pd12_dequeue,
+
+	.set_halt = pd12_set_halt,
+};
+
+
+static __inline__ void read_data(volatile u8 *val)
+{
+	*val = *(volatile u8 *)DEV_DATA_ADDR;
+	udelay(5);
+}
+
+static __inline__ void write_data(u8 val)
+{
+	*(volatile u8 *)DEV_DATA_ADDR = val;
+	udelay(5);
+}
+
+static __inline__ void write_cmd(u8 val)
+{
+	*(volatile u8 *)DEV_CMD_ADDR = val;
+	udelay(5);
+}
+
+static __inline__ void usb_set_index(u8 ep)
+{
+	if(ep != 0)
+		ep += 1;
+	write_cmd(ep);
+}
+
+static void pd12_set_ack(u8 index)
+{
+	
+	write_cmd(index);
+	write_cmd(PD12_ACK_SETUP);
+	if(index  == 0)
+		write_cmd(PD12_CLEAR_BUF);
+		
+}
+
+static int write_fifo(struct pd12_ep *ep, struct pd12_request *req)
+{
+	u8 *buf;
+	unsigned count;
+	unsigned length;
+	int is_last;
+	u8 ep_sts;
+	
+	buf = req->req.buf + req->req.actual;
+	prefetch(buf);
+	
+	count = ep->ep.maxpacket;	
+	length = req->req.length - req->req.actual;
+	length = min(length, count);
+	req->req.actual += length;
+
+	DEBUG_PD12("Write %d (max %d), fifo %p\n", length, count, buf);
+	write_cmd(1);
+	read_data(&ep_sts);
+/*	write_cmd(PD12_ACK_SETUP); */
+	write_cmd(PD12_WRITE_BUF);
+	write_data(0x0);
+	write_data(length);
+	if(length == 0)
+		write_data(0x0);
+	while(length--)
+		write_data(*buf++);
+	write_cmd(PD12_VALIDATE_BUF);
+	if(length != ep->ep.maxpacket)
+		is_last = 1;
+	else if(req->req.length == req->req.actual
+			&& !req->req.zero)
+		is_last = 1;
+	else
+		is_last = 0;
+
+	if(is_last)
+		done(ep,req,0);
+	return is_last;
+
+}
+/*-------------------------------------------------------------------------*/
+
+#ifdef CONFIG_USB_GADGET_DEBUG_PD12_FILES
+
+static const char proc_node_name[] = "driver/udc";
+
+static int
+udc_proc_read(char *page, char **start, off_t off, int count,
+	      int *eof, void *_dev)
+{
+	char *buf = page;
+	struct pd12_udc *dev = _dev;
+	char *next = buf;
+	unsigned size = count;
+	unsigned long flags;
+	int t;
+	u8 ep_status[6];
+
+	if (off != 0)
+		return 0;
+
+	local_irq_save(flags);
+
+	/* basic device status */
+	t = scnprintf(next, size,
+		      DRIVER_DESC "\n"
+		      "%s version: %s\n"
+		      "Gadget driver: %s\n"
+		      "Host: %s\n\n",
+		      driver_name, DRIVER_VERSION,
+		      dev->driver ? dev->driver->driver.name : "(none)");
+	size -= t;
+	next += t;
+
+	for(i=0;i<PD12_MAX_ENDPOINTS;i++)
+	{
+		write_cmd(PD12_READ_LAST_STATUS+i);
+		read_data(&ep_status[i]);
+	}
+	t = scnprintf(next, size,
+		      "Endpoints last status:\n"
+			  " ep0: 0x%x, ep1: 0x%x, ep2: 0x%x\n"
+			  " ep3: 0x%x, ep4: 0x%x, ep5: 0x%x\n\n",
+		      ep_status[0], ep_status[1], ep_status[2],
+		      ep_status[3], ep_status[4], ep_status[5]
+	    );
+	size -= t;
+	next += t;
+
+	local_irq_restore(flags);
+	*eof = 1;
+	return count - size;
+}
+
+#define create_proc_files() 	create_proc_read_entry(proc_node_name, 0, NULL, udc_proc_read, dev)
+#define remove_proc_files() 	remove_proc_entry(proc_node_name, NULL)
+
+#else	/* !CONFIG_USB_GADGET_DEBUG_FILES */
+
+#define create_proc_files() do {} while (0)
+#define remove_proc_files() do {} while (0)
+
+#endif	/* CONFIG_USB_GADGET_DEBUG_FILES */
+
+static void pd12_set_mode(u8 val)
+{
+	write_cmd(PD12_SET_MODE);
+	write_data(val);
+	write_data(0x3);/*maybe 0x43*/
+}
+static void pd12_read_int(u16* val)
+{
+	write_cmd(PD12_READ_INT);
+	read_data((u8*)val);
+}
+
+static void pd12_read_lstatus(u8 index, u8* val)
+{
+	write_cmd(PD12_READ_LAST_STATUS + index);
+	read_data(val);
+}
+/*
+ * 	udc_disable - disable USB device controller
+ */
+static void udc_disable(struct pd12_udc *dev)
+{
+	DEBUG_PD12("%s, %p\n", __FUNCTION__, dev);
+
+	udc_set_address(dev, 0);
+	pd12_set_mode(0x06); /*disconnect soft connect pullup resior */
+	
+	dev->ep0state = WAIT_FOR_SETUP;
+	dev->gadget.speed = USB_SPEED_UNKNOWN;
+	dev->usb_address = 0;
+}
+
+
+/*
+ * 	udc_reinit - initialize software state
+ */
+static void udc_reinit(struct pd12_udc *dev)
+{
+	u8 i;
+	u16 tmp;
+	
+	DEBUG_PD12("%s, %p\n", __FUNCTION__, dev);
+
+	udc_set_address(dev, 0);
+	pd12_set_mode(0x06); /*disconnect soft connect pullup resior */
+	mdelay(1500);
+	pd12_set_mode(0x16); /*soft connnect*/
+	pd12_read_int(&tmp);
+	for(i= 0; i< 5; i++)
+		pd12_read_lstatus(i,(u8 *)(&tmp));
+
+	/* device/ep0 records init */
+	INIT_LIST_HEAD(&dev->gadget.ep_list);
+	INIT_LIST_HEAD(&dev->gadget.ep0->ep_list);
+	dev->ep0state = WAIT_FOR_SETUP;
+	dev->gadget.speed = USB_SPEED_UNKNOWN;
+	dev->usb_address = 0;
+
+	/* basic endpoint records init */
+	for (i = 0; i < PD12_MAX_ENDPOINTS; i++) {
+		struct pd12_ep *ep = &dev->ep[i];
+
+		if (i != 0)
+			list_add_tail(&ep->ep.ep_list, &dev->gadget.ep_list);
+
+		ep->desc = 0;
+		ep->stopped = 0;
+		INIT_LIST_HEAD(&ep->queue);
+	}
+
+	/* the rest was statically initialized, and is read-only */
+}
+
+/* until it's enabled, this UDC should be completely invisible
+ * to any USB host.
+ */
+static void udc_enable(struct pd12_udc *dev)
+{
+
+	u8 i;
+	u16 tmp;
+	
+	DEBUG_PD12("%s, %p\n", __FUNCTION__, dev);
+
+	pd12_set_mode(0x06); /*disconnect soft connect pullup resior */
+	mdelay(1500);
+	pd12_set_mode(0x16); /*soft connnect*/
+	pd12_read_int(&tmp);
+	for(i= 0; i< 5; i++)
+		pd12_read_lstatus(i,(u8 *)(&tmp));
+	dev->gadget.speed = USB_SPEED_FULL;
+
+}
+
+/*
+  Register entry point for the peripheral controller driver.
+*/
+int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+{
+	struct pd12_udc *dev = the_controller;
+	int retval;
+
+	DEBUG_PD12("%s: %s\n", __FUNCTION__, driver->driver.name);
+	if (!driver
+	    || driver->speed != USB_SPEED_FULL
+	    || !driver->bind
+	    || !driver->unbind || !driver->disconnect || !driver->setup)
+		return -EINVAL;
+	if (!dev)
+		return -ENODEV;
+	if (dev->driver)
+		return -EBUSY;
+	/* first hook up the driver ... */
+	dev->driver = driver;
+	dev->gadget.dev.driver = &driver->driver;
+
+	device_add(&dev->gadget.dev);
+	retval = driver->bind(&dev->gadget);
+	if (retval) {
+		printk("%s: bind to driver %s --> error %d\n", dev->gadget.name,
+		       driver->driver.name, retval);
+		device_del(&dev->gadget.dev);
+
+		dev->driver = 0;
+		dev->gadget.dev.driver = 0;
+		return retval;
+	}
+
+	/* ... then enable host detection and ep0; and we're ready
+	 * for set_configuration as well as eventual disconnect.
+	 * NOTE:  this shouldn't power up until later.
+	 */
+	printk("%s: registered gadget driver '%s'\n", dev->gadget.name,
+	       driver->driver.name);
+
+	udc_enable(dev);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(usb_gadget_register_driver);
+
+/*
+  Unregister entry point for the peripheral controller driver.
+*/
+int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
+{
+	struct pd12_udc *dev = the_controller;
+	unsigned long flags;
+
+	if (!dev)
+		return -ENODEV;
+	if (!driver || driver != dev->driver)
+		return -EINVAL;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	dev->driver = 0;
+	stop_activity(dev, driver);
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	driver->unbind(&dev->gadget);
+	device_del(&dev->gadget.dev);
+
+	udc_disable(dev);
+
+	DEBUG_PD12("unregistered gadget driver '%s'\n", driver->driver.name);
+	return 0;
+}
+
+EXPORT_SYMBOL(usb_gadget_unregister_driver);
+
+/*-------------------------------------------------------------------------*/
+
+/** Read to request from FIFO (max read == bytes in fifo)
+ *  Return:  0 = still running, 1 = completed, negative = errno
+ *  NOTE: INDEX register must be set for EP
+ */
+static int read_fifo(struct pd12_ep *ep, struct pd12_request *req)
+{
+	u8 count;
+	u8 ep_sts;
+	u8 *buf;
+	unsigned bufferspace, is_short;
+
+	/* make sure there's a packet in the FIFO. */
+	usb_set_index(ep_index(ep));
+	read_data(&ep_sts);
+	if ((ep_sts & UDC_FIFO_UNREADABLE) == UDC_FIFO_UNREADABLE) {
+		DEBUG_PD12("%s: Packet NOT ready!\n", __FUNCTION__);
+		return -EINVAL;
+	}
+
+	buf = req->req.buf + req->req.actual;
+	prefetchw(buf);
+	bufferspace = req->req.length - req->req.actual;
+
+	/* read all bytes from this packet */
+	write_cmd(PD12_READ_BUF);
+	read_data(&count);
+	read_data(&count);
+	req->req.actual += min((unsigned)count, bufferspace);
+
+	is_short = (count < ep->ep.maxpacket);
+	DEBUG_PD12("read %s %02x, %d bytes%s req %p %d/%d\n",
+	      ep->ep.name, ep_sts, count,
+	      is_short ? "/S" : "", req, req->req.actual, req->req.length);
+
+	while (count-- != 0) {
+
+		if (bufferspace == 0) {
+			/* this happens when the driver's buffer
+			 * is smaller than what the host sent.
+			 * discard the extra data.
+			 */
+			if (req->req.status != -EOVERFLOW)
+				printk("%s overflow %d\n", ep->ep.name, count);
+			req->req.status = -EOVERFLOW;
+		} else {
+			read_data(buf++);
+			bufferspace--;
+		}
+	}
+
+	write_cmd(PD12_CLEAR_BUF);
+
+	/* completion */
+	if (is_short || req->req.actual == req->req.length) {
+		done(ep, req, 0);
+
+		return 1;
+	}
+
+	/* finished that packet.  the next one may be waiting... */
+	return 0;
+}
+
+
+/*
+ *	done - retire a request; caller blocked irqs
+ *  INDEX register is preserved to keep same
+ */
+static void done(struct pd12_ep *ep, struct pd12_request *req, int status)
+{
+	unsigned int stopped = ep->stopped;
+
+	DEBUG_PD12("%s, %p\n", __FUNCTION__, ep);
+	list_del_init(&req->queue);
+
+	if (req->req.status == -EINPROGRESS)
+		req->req.status = status;
+	else
+		status = req->req.status;
+
+	if (status && status != -ESHUTDOWN)
+		DEBUG_PD12("complete %s req %p stat %d len %u/%u\n",
+		      ep->ep.name, &req->req, status,
+		      req->req.actual, req->req.length);
+
+	/* don't modify queue heads during completion callback */
+	ep->stopped = 1;
+
+	spin_unlock(&ep->dev->lock);
+	req->req.complete(&ep->ep, &req->req);
+	spin_lock(&ep->dev->lock);
+	ep->stopped = stopped;
+}
+
+
+/*
+ * 	nuke - dequeue ALL requests
+ */
+void nuke(struct pd12_ep *ep, int status)
+{
+	struct pd12_request *req;
+
+	DEBUG_PD12("%s, %p\n", __FUNCTION__, ep);
+
+	/* Flush FIFO */
+	flush(ep);
+
+	/* called with irqs blocked */
+	while (!list_empty(&ep->queue)) {
+		req = list_entry(ep->queue.next, struct pd12_request, queue);
+		done(ep, req, status);
+	}
+
+}
+
+/** Flush EP
+ * NOTE: INDEX register must be set before this call
+ */
+static void flush(struct pd12_ep *ep)
+{
+}
+
+/**
+ *  handle IN interrupt
+ */
+static void pd12_in_epn(struct pd12_udc *dev, u8 ep_idx)
+{
+	u8 ep_sts;
+	struct pd12_ep *ep = &dev->ep[ep_idx];
+	struct pd12_request *req;
+
+	usb_set_index(ep_idx);
+	read_data(&ep_sts);
+	DEBUG_PD12("%s: %d, status %x\n", __FUNCTION__, ep_idx, ep_sts);
+
+	if (ep_sts & UDC_EP_STALL) {
+		DEBUG_PD12("USB_EP_STALL\n");
+		return;
+	}
+
+	if (!ep->desc) {
+		DEBUG_PD12("%s: NO EP DESC\n", __FUNCTION__);
+		return;
+	}
+
+	if (list_empty(&ep->queue))
+		req = 0;
+	else
+		req = list_entry(ep->queue.next, struct pd12_request, queue);
+
+	DEBUG_PD12("req: %p\n", req);
+
+	if (!req)
+		return;
+
+	write_fifo(ep, req);
+}
+
+/*
+* handle OUT interrupt(recv)
+ */
+
+static void pd12_out_epn(struct pd12_udc *dev, u8 ep_idx)
+{
+	u8 ep_sts;
+	struct pd12_ep *ep = &dev->ep[ep_idx];
+	struct pd12_request *req;
+
+	DEBUG_PD12("%s: %d\n", __FUNCTION__, ep_idx);
+
+	usb_set_index(ep_idx);
+	read_data(&ep_sts);
+	DEBUG_PD12("%s: %d, status %x\n", __FUNCTION__, ep_idx, ep_sts);
+
+	if (ep_sts & UDC_EP_STALL) {
+		DEBUG_PD12("USB_EP_STALL\n");
+		flush(ep);
+		return;
+	}
+
+	if (ep->desc) {
+
+		if (list_empty(&ep->queue))
+			req = 0;
+		else
+			req = list_entry(ep->queue.next,
+					   struct pd12_request,
+					   queue);
+
+		if (!req) {
+			printk("%s: NULL REQ %d\n",
+				   __FUNCTION__, ep_idx);
+			flush(ep);
+		} else {
+			read_fifo(ep, req);
+		}
+
+	} else {
+		/* Throw packet away.. */
+		printk("%s: No descriptor?!?\n", __FUNCTION__);
+		flush(ep);
+	}
+}
+
+static void stop_activity(struct pd12_udc *dev,
+			  struct usb_gadget_driver *driver)
+{
+	int i;
+
+	/* don't disconnect drivers more than once */
+	if (dev->gadget.speed == USB_SPEED_UNKNOWN)
+		driver = 0;
+	dev->gadget.speed = USB_SPEED_UNKNOWN;
+
+	/* prevent new request submissions, kill any outstanding requests  */
+	for (i = 0; i < PD12_MAX_ENDPOINTS - 1; i++) {
+		struct pd12_ep *ep = &dev->ep[i];
+		ep->stopped = 1;
+
+		usb_set_index(i);
+		write_cmd(PD12_SET_STATUS);
+		write_data(0x1);
+		nuke(ep, -ESHUTDOWN);
+	}
+		
+	write_cmd(1);
+	write_cmd(PD12_SET_STATUS);
+	write_data(0x1);
+
+	/* report disconnect; the driver is already quiesced */
+	if (driver) {
+		spin_unlock(&dev->lock);
+		driver->disconnect(&dev->gadget);
+		spin_lock(&dev->lock);
+	}
+
+	/* re-init driver-visible data structures */
+	udc_reinit(dev);
+}
+
+/** Handle USB RESET interrupt
+ */
+static void pd12_reset_intr(struct pd12_udc *dev)
+{
+
+	struct pd12_request *req;
+	struct pd12_ep *ep = &dev->ep[0];
+
+	DEBUG_PD12_EP0("%s: \n", __FUNCTION__);
+
+	if (list_empty(&ep->queue))
+		req = 0;
+	else
+		req = list_entry(ep->queue.next, struct pd12_request, queue);
+
+	if (req){
+		done(ep,req,0);
+	} else {
+		DEBUG_PD12_EP0("%s: NULL REQ\n", __FUNCTION__);
+	}
+
+	udc_set_address(dev, 0);
+	pd12_set_ack(0);
+	pd12_set_ack(1);
+	dev->ep0state = WAIT_FOR_SETUP;
+	first_tran = 1;
+}
+
+/*
+ *	pd12 usb client interrupt handler.
+ */
+static irqreturn_t pd12_udc_irq(int irq, void *_dev, struct pt_regs *r)
+{
+	struct pd12_udc *dev = _dev;
+	volatile u8 int_status;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->lock,flags);
+
+	DEBUG_PD12("%s (on state %s)\n", __FUNCTION__,
+		  state_names[dev->ep0state]);
+	write_cmd(PD12_READ_INT);
+	read_data(&int_status);
+	if (int_status & (PD12_CNTL_IN | PD12_CNTL_OUT))
+	{
+		if((int_status & PD12_CNTL_OUT) == PD12_CNTL_OUT)
+			dev->ep0state = WAIT_FOR_SETUP;
+		int_status &= ~(PD12_CNTL_IN | PD12_CNTL_OUT);
+		DEBUG_PD12("PD12_EP0 (control)\n");
+		pd12_handle_ep0(dev);
+		
+	}
+	if (int_status & PD12_SUSPEND_CHG)
+	{
+		u8 tmp;
+		tmp = *(volatile char *)CPLD_REG0_ADDR;
+		int_status &= ~PD12_SUSPEND_CHG;
+		if(tmp & USB_SUSPEND)
+		{
+		/*	write_cmd(PD12_SND_RESUME); */
+			if (dev->gadget.speed != USB_SPEED_UNKNOWN
+				&& dev->driver
+				&& dev->driver->resume)
+				dev->driver->resume(&dev->gadget);
+		}
+		else
+		{	
+			if (dev->gadget.speed !=
+				   USB_SPEED_FULL && dev->driver
+				   && dev->driver->suspend)
+				dev->driver->suspend(&dev->gadget);
+		}
+	}
+	if (int_status & PD12_BUS_RST)
+	{
+		int_status &= ~PD12_BUS_RST;
+		pd12_reset_intr(dev);
+	}
+	if (int_status & PD12_EP1_IN)
+	{
+		int_status &= ~PD12_EP1_IN;
+		DEBUG_PD12("PD12_EP1_IN\n");
+		pd12_in_epn(dev, 2);
+	}
+	if (int_status & PD12_MAIN_IN)
+	{
+		int_status &= ~PD12_MAIN_IN;
+		DEBUG_PD12("PD12_MAIN_IN\n");
+		pd12_in_epn(dev, 4);
+	}
+	if (int_status & PD12_EP1_OUT)
+	{
+		int_status &= ~PD12_EP1_OUT;
+		DEBUG_PD12("PD12_EP1_OUT\n");
+		pd12_out_epn(dev, 1);
+	}
+	if (int_status & PD12_MAIN_OUT)
+	{
+		int_status &= ~PD12_MAIN_OUT;
+		DEBUG_PD12("PD12_MAIN_OUT\n");
+		pd12_out_epn(dev, 3);
+	}
+			
+	spin_unlock_irqrestore(&dev->lock,flags);
+	return IRQ_HANDLED;
+}
+
+static int pd12_ep_enable(struct usb_ep *_ep,
+			     const struct usb_endpoint_descriptor *desc)
+{
+	struct pd12_ep *ep;
+	struct pd12_udc *dev;
+	unsigned long flags;
+
+	DEBUG_PD12("%s, %p\n", __FUNCTION__, _ep);
+
+	ep = container_of(_ep, struct pd12_ep, ep);
+	if (!_ep || !desc || ep->desc || _ep->name == ep0name
+	    || desc->bDescriptorType != USB_DT_ENDPOINT
+	    || ep->bEndpointAddress != desc->bEndpointAddress
+	    || ep_maxpacket(ep) < le16_to_cpu(desc->wMaxPacketSize)) {
+		DEBUG_PD12("%s, bad ep or descriptor\n", __FUNCTION__);
+		return -EINVAL;
+	}
+
+	/* xfer types must match, except that interrupt ~= bulk */
+	if (ep->bmAttributes != desc->bmAttributes ) {
+		DEBUG_PD12("%s, %s type mismatch\n", __FUNCTION__, _ep->name);
+		return -EINVAL;
+	}
+
+	/* hardware _could_ do smaller, but driver doesn't */
+	if ((desc->bmAttributes == USB_ENDPOINT_XFER_BULK
+	     && le16_to_cpu(desc->wMaxPacketSize) != ep_maxpacket(ep))
+	    || !desc->wMaxPacketSize) {
+		DEBUG_PD12("%s, bad %s maxpacket\n", __FUNCTION__, _ep->name);
+		return -ERANGE;
+	}
+
+	dev = ep->dev;
+	if (!dev->driver || dev->gadget.speed == USB_SPEED_UNKNOWN) {
+		DEBUG_PD12("%s, bogus device state\n", __FUNCTION__);
+		return -ESHUTDOWN;
+	}
+
+	spin_lock_irqsave(&ep->dev->lock, flags);
+
+	ep->stopped = 0;
+	ep->desc = desc;
+	ep->ep.maxpacket = le16_to_cpu(desc->wMaxPacketSize);
+
+	/* Reset halt state (does flush) */
+	pd12_set_halt(_ep, 0);
+
+	spin_unlock_irqrestore(&ep->dev->lock, flags);
+
+	DEBUG_PD12("%s: enabled %s\n", __FUNCTION__, _ep->name);
+	return 0;
+}
+
+/** Disable EP
+ *  NOTE: Sets INDEX register
+ */
+static int pd12_ep_disable(struct usb_ep *_ep)
+{
+	struct pd12_ep *ep;
+	unsigned long flags;
+
+	DEBUG_PD12("%s, %p\n", __FUNCTION__, _ep);
+
+	ep = container_of(_ep, struct pd12_ep, ep);
+	if (!_ep || !ep->desc) {
+		DEBUG_PD12("%s, %s not enabled\n", __FUNCTION__,
+		      _ep ? ep->ep.name : NULL);
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&ep->dev->lock, flags);
+
+	usb_set_index(ep_index(ep));
+
+	/* Nuke all pending requests (does flush) */
+	nuke(ep, -ESHUTDOWN);
+
+	/* Disable ep  */
+	write_cmd(PD12_SET_EP_EN);
+	write_data(0x0);
+
+	ep->desc = 0;
+	ep->stopped = 1;
+
+	spin_unlock_irqrestore(&ep->dev->lock, flags);
+
+	DEBUG_PD12("%s: disabled %s\n", __FUNCTION__, _ep->name);
+	return 0;
+}
+
+static struct usb_request *pd12_alloc_request(struct usb_ep *ep,
+						 unsigned gfp_flags)
+{
+	struct pd12_request *req;
+
+	DEBUG_PD12("%s, %p\n", __FUNCTION__, ep);
+
+	req = kmalloc(sizeof *req, gfp_flags);
+	if (!req)
+		return 0;
+
+	memset(req, 0, sizeof *req);
+	INIT_LIST_HEAD(&req->queue);
+
+	return &req->req;
+}
+
+static void pd12_free_request(struct usb_ep *ep, struct usb_request *_req)
+{
+	struct pd12_request *req;
+
+	DEBUG_PD12("%s, %p\n", __FUNCTION__, ep);
+
+	req = container_of(_req, struct pd12_request, req);
+	WARN_ON(!list_empty(&req->queue));
+	kfree(req);
+}
+
+static void *pd12_alloc_buffer(struct usb_ep *ep, unsigned bytes,
+				  dma_addr_t * dma, unsigned gfp_flags)
+{
+	char *retval;
+
+	DEBUG_PD12("%s (%p, %d, %d)\n", __FUNCTION__, ep, bytes, gfp_flags);
+
+	retval = kmalloc(bytes, gfp_flags & ~(__GFP_DMA | __GFP_HIGHMEM));
+	if (retval)
+		*dma = virt_to_bus(retval);
+	return retval;
+}
+
+static void pd12_free_buffer(struct usb_ep *ep, void *buf, dma_addr_t dma,
+				unsigned bytes)
+{
+	DEBUG_PD12("%s, %p\n", __FUNCTION__, ep);
+	kfree(buf);
+}
+
+/** Queue one request
+ *  Kickstart transfer if needed
+ *  NOTE: Sets INDEX register
+ */
+static int pd12_queue(struct usb_ep *_ep, struct usb_request *_req,
+			 unsigned gfp_flags)
+{
+	struct pd12_request *req;
+	struct pd12_ep *ep;
+	struct pd12_udc *dev;
+	unsigned long flags;
+	u8 ep_status;
+
+	DEBUG_PD12("\n\n\n%s, %p\n", __FUNCTION__, _ep);
+
+	req = container_of(_req, struct pd12_request, req);
+	if (!_req || !_req->complete || !_req->buf
+	     || !list_empty(&req->queue)) {
+		DEBUG_PD12("%s, bad params\n", __FUNCTION__);
+		return -EINVAL;
+	}
+
+	ep = container_of(_ep, struct pd12_ep, ep);
+	if (!_ep || (!ep->desc && (ep->ep.name != ep0name))) {
+		DEBUG_PD12("%s, bad ep\n", __FUNCTION__);
+		return -EINVAL;
+	}
+
+	dev = ep->dev;
+	if (!dev->driver || dev->gadget.speed == USB_SPEED_UNKNOWN) {
+		DEBUG_PD12("%s, bogus device state %p\n", __FUNCTION__, dev->driver);
+		return -ESHUTDOWN;
+	}
+
+	DEBUG_PD12("%s queue req %p, len %d buf %p\n", _ep->name, _req, _req->length,
+	      _req->buf);
+
+	spin_lock_irqsave(&dev->lock, flags);
+
+	_req->status = -EINPROGRESS;
+	_req->actual = 0;
+
+	/* kickstart this i/o queue? */
+	DEBUG_PD12("Add to %d Q %d %d\n", ep_index(ep), list_empty(&ep->queue),
+	      ep->stopped);
+	if (list_empty(&ep->queue) && !ep->stopped) {
+
+		if (ep_index(ep) == 0) {
+			/* EP0 */
+			list_add_tail(&req->queue, &ep->queue);
+			pd12_ep0_kick(dev, ep);
+			req = 0;
+		} else if (ep_is_in(ep)) {
+			/* EP2 & EP4 */
+			usb_set_index(ep_index(ep));
+			read_data(&ep_status);
+			if ((ep_status & 0x0) == 0x0) {
+				if (write_fifo(ep, req) == 1)
+					req = 0;
+			}
+		} else {
+			/* EP1  & EP3 */
+			usb_set_index(ep_index(ep));
+			read_data(&ep_status);
+			if ((ep_status & 0x01) == 0x01) {
+				if (read_fifo(ep, req) == 1)
+					req = 0;
+			}
+		}
+	}
+
+	/* pio or dma irq handler advances the queue. */
+	if (req != 0)
+		list_add_tail(&req->queue, &ep->queue);
+
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	return 0;
+}
+
+/* dequeue JUST ONE request */
+static int pd12_dequeue(struct usb_ep *_ep, struct usb_request *_req)
+{
+	struct pd12_ep *ep;
+	struct pd12_request *req;
+	unsigned long flags;
+
+	DEBUG_PD12("%s, %p\n", __FUNCTION__, _ep);
+
+	ep = container_of(_ep, struct pd12_ep, ep);
+	if (!_ep || ep->ep.name == ep0name )
+		return -EINVAL;
+
+	spin_lock_irqsave(&ep->dev->lock, flags);
+
+	/* make sure it's actually queued on this endpoint */
+	list_for_each_entry(req, &ep->queue, queue) {
+		if (&req->req == _req)
+			break;
+	}
+	if (&req->req != _req) {
+		spin_unlock_irqrestore(&ep->dev->lock, flags);
+		return -EINVAL;
+	}
+
+	done(ep, req, -ECONNRESET);
+
+	spin_unlock_irqrestore(&ep->dev->lock, flags);
+	return 0;
+}
+
+/** Halt specific EP
+ *  Return 0 if success
+ *  NOTE: Sets INDEX register to EP !
+ */
+static int pd12_set_halt(struct usb_ep *_ep, int value)
+{
+	struct pd12_ep *ep;
+	unsigned long flags;
+	u8 ep_status;
+
+	ep = container_of(_ep, struct pd12_ep, ep);
+	if (!_ep || (!ep->desc && ep->ep.name != ep0name)) {
+		DEBUG_PD12("%s, bad ep\n", __FUNCTION__);
+		return -EINVAL;
+	}
+
+	usb_set_index(ep_index(ep));
+
+	DEBUG_PD12("%s, ep %d, val %d\n", __FUNCTION__, ep_index(ep), value);
+
+	spin_lock_irqsave(&ep->dev->lock, flags);
+
+	if (ep_index(ep) == 0) {
+		/* EP0 */
+		write_cmd(PD12_SET_STATUS | ep_index(ep));
+		write_data(0x01);
+	} else if (ep_is_in(ep)) {
+		write_cmd(PD12_READ_EP_STATUS);
+		read_data(&ep_status);
+		if (value && ((ep_status & 0x60) /*buffer 0 or 1 full*/
+			      || !list_empty(&ep->queue))) {
+			/*
+			 * Attempts to halt IN endpoints will fail (returning -EAGAIN)
+			 * if any transfer requests are still queued, or if the controller
+			 * FIFO still holds bytes that the host hasn't collected.
+			 */
+			spin_unlock_irqrestore(&ep->dev->lock, flags);
+			DEBUG_PD12
+			    ("Attempt to halt IN endpoint failed (returning -EAGAIN) %d %d\n",
+			     (ep_status & 0x60),
+			     !list_empty(&ep->queue));
+			return -EAGAIN;
+		}
+		flush(ep);
+		if (value)
+		{
+			write_cmd(PD12_SET_STATUS | ep_index(ep));
+			write_data(0x01);
+		} else {
+			write_cmd(PD12_SET_STATUS | ep_index(ep));
+			write_data(0x00);
+		}
+
+	} else {
+
+		flush(ep);
+		if (value)
+		{
+			write_cmd(PD12_SET_STATUS | ep_index(ep));
+			write_data(0x01);
+		} else {
+			write_cmd(PD12_SET_STATUS | ep_index(ep));
+			write_data(0x00);
+		}
+	}
+
+	if (value) {
+		ep->stopped = 1;
+	} else {
+		ep->stopped = 0;
+	}
+
+	spin_unlock_irqrestore(&ep->dev->lock, flags);
+
+	DEBUG_PD12("%s %s halted\n", _ep->name, value == 0 ? "NOT" : "IS");
+
+	return 0;
+}
+
+
+/****************************************************************/
+/* End Point 0 related functions                                */
+/****************************************************************/
+
+/* return:  0 = still running, 1 = completed, negative = errno */
+static int write_fifo_ep0(struct pd12_ep *ep, struct pd12_request *req)
+{
+	u8 max;
+	unsigned count;
+	int is_last;
+	unsigned length;
+	u8* buf;
+	u8 ep_sts;
+
+	write_cmd(1); /* index 1*/
+	read_data(&ep_sts);
+/*	pd12_set_ack(1); */
+	max = ep_maxpacket(ep);
+	buf = req->req.buf + req->req.actual;
+	prefetch(buf);
+
+	DEBUG_PD12_EP0("%s\n", __FUNCTION__);
+
+	length = req->req.length - req->req.actual;
+	length = min(length, (unsigned)max);
+	req->req.actual += length;
+
+	DEBUG_PD12("Write %d (max %d), fifo %p\n", length, max, buf);
+
+	count = length;
+	write_cmd(PD12_WRITE_BUF);
+	write_data(0x0);
+	write_data(count);
+	while (length--) {
+		write_data(*buf++);
+	}
+	
+	write_cmd(PD12_VALIDATE_BUF);
+	/* last packet is usually short (or a zlp) */
+	if (unlikely(count != max))
+		is_last = 1;
+	else {
+		if (likely(req->req.length != req->req.actual) || req->req.zero)
+			is_last = 0;
+		else
+			is_last = 1;
+	}
+
+	DEBUG_PD12_EP0("%s: wrote %s %d bytes%s %d left %p\n", __FUNCTION__,
+		  ep->ep.name, count,
+		  is_last ? "/L" : "", req->req.length - req->req.actual, req);
+
+	/* requests complete when all IN data is in the FIFO */
+	if (is_last) {
+		done(ep, req, 0);
+		return 1;
+	}
+
+	return 0;
+}
+
+static __inline__ void pd12_fifo_read(struct pd12_ep *ep,
+					unsigned char *cp, u8 max)
+{
+	u8 count;
+
+	usb_set_index(0);
+	write_cmd(PD12_READ_BUF);
+	read_data(&count);
+	read_data(&count);
+	if (count > max)
+		count = max;
+	while (count--){
+		read_data(cp++);
+	}
+	write_cmd(PD12_CLEAR_BUF);
+}
+
+static __inline__ void pd12_fifo_write(struct pd12_ep *ep,
+					  unsigned char *cp, u8 count)
+{
+	write_cmd(1); /* index 1 */
+	write_cmd(PD12_WRITE_BUF);
+	write_data(0x0);
+	write_data(count);
+	DEBUG_PD12_EP0("fifo_write: %d %d\n", ep_index(ep), count);
+	while (count--)
+		write_data(*cp++);
+	write_cmd(PD12_VALIDATE_BUF);
+}
+static int read_fifo_ep0(struct pd12_ep *ep, struct pd12_request *req)
+{
+	u8 ep_status;
+	u8 len;
+	u8 *buf;
+	unsigned bufferspace, count, is_short;
+
+	DEBUG_PD12_EP0("%s\n", __FUNCTION__);
+
+	usb_set_index(0); /* index 0*/
+	read_data(&ep_status);
+	if ((ep_status & UDC_FIFO_UNREADABLE) == UDC_FIFO_UNREADABLE)
+		return 0;
+
+	buf = req->req.buf + req->req.actual;
+	prefetchw(buf);
+	bufferspace = req->req.length - req->req.actual;
+
+	write_cmd(PD12_READ_BUF);
+	read_data(&len);
+	read_data(&len);
+	count = (unsigned)len;
+
+	is_short = (count < ep->ep.maxpacket);
+	DEBUG_PD12_EP0("read %s, %d bytes%s req %p %d/%d\n",
+		  ep->ep.name, count,
+		  is_short ? "/S" : "", req, req->req.actual, req->req.length);
+
+	while (count--) {
+		u8 byte;
+		read_data(&byte);
+		if (unlikely(bufferspace == 0)) {
+			/* this happens when the driver's buffer
+			 * is smaller than what the host sent.
+			 * discard the extra data.
+			 */
+			if (req->req.status != -EOVERFLOW)
+				DEBUG_PD12_EP0("%s overflow %d\n", ep->ep.name,
+					  count);
+			req->req.status = -EOVERFLOW;
+		} else {
+			*buf++ = byte;
+			bufferspace--;
+		}
+	}
+
+	/* completion */
+	if (is_short || req->req.actual == req->req.length) {
+		done(ep, req, 0);
+		return 1;
+	}
+
+	/* finished that packet.  the next one may be waiting... */
+	return 0;
+}
+
+/**
+ * udc_set_address - set the USB address for this device
+ * @address:
+ *
+ * Called from control endpoint function after it decodes a set address setup packet.
+ */
+static void udc_set_address(struct pd12_udc *dev, unsigned char address)
+{
+	DEBUG_PD12_EP0("%s: %d\n", __FUNCTION__, address);
+
+	dev->usb_address = address;
+	write_cmd(PD12_SET_ADDR_EN);
+	write_data(0x80 | address);
+}
+
+/*
+ * DATA_STATE_RECV (OUT_PKT_RDY)
+ *      - if error
+ *              set EP0_CLR_OUT | EP0_DATA_END | EP0_SEND_STALL bits
+ *      - else
+ *              set EP0_CLR_OUT bit
+ 				if last set EP0_DATA_END bit
+ */
+static void pd12_ep0_out(struct pd12_udc *dev)
+{
+	struct pd12_request *req;
+	struct pd12_ep *ep = &dev->ep[0];
+	int ret;
+
+	DEBUG_PD12_EP0("%s: \n", __FUNCTION__);
+
+	if (list_empty(&ep->queue))
+		req = 0;
+	else
+		req = list_entry(ep->queue.next, struct pd12_request, queue);
+
+	if (req) {
+
+		if (req->req.length == 0) {
+			DEBUG_PD12_EP0("ZERO LENGTH OUT!\n");
+			dev->ep0state = WAIT_FOR_SETUP;
+			return;
+		}
+		ret = read_fifo_ep0(ep, req);
+		if (ret) {
+			/* Done! */
+			DEBUG_PD12_EP0("%s: finished, waiting for status\n",
+				  __FUNCTION__);
+			/* read last status here ?*/
+			dev->ep0state = WAIT_FOR_SETUP;
+		} else {
+			/* Not done yet.. */
+			DEBUG_PD12_EP0("%s: not finished\n", __FUNCTION__);
+			/* usb_set(EP0_CLR_OUT, USB_EP0_CSR); */
+		}
+	} else {
+		DEBUG_PD12_EP0("NO REQ??!\n");
+	}
+}
+
+/*
+ * DATA_STATE_XMIT
+ */
+static int pd12_ep0_in(struct pd12_udc *dev)
+{
+	struct pd12_request *req;
+	struct pd12_ep *ep = &dev->ep[0];
+	int ret, need_zlp = 0;
+	u8 val;
+	
+	DEBUG_PD12_EP0("%s: \n", __FUNCTION__);
+
+
+	pd12_read_lstatus(1,&val);
+	pd12_set_ack(1);
+	if(((val & 0x1) != 0x1) && !first_tran){
+	/*	printk("return from ep0_in\n"); */
+		return 0;
+	}
+	if (list_empty(&ep->queue))
+		req = 0;
+	else
+		req = list_entry(ep->queue.next, struct pd12_request, queue);
+
+	if (!req) {
+		dev->ep0state = WAIT_FOR_SETUP;
+		DEBUG_PD12_EP0("%s: NULL REQ\n", __FUNCTION__);
+		return 0;
+	}
+
+	if (req->req.length == 0) {
+		dev->ep0state = WAIT_FOR_SETUP;
+		return 1;
+	}
+
+	ret = write_fifo_ep0(ep, req);
+	first_tran = 0;
+	if (ret == 1 && !need_zlp) {
+		/* Last packet */
+		DEBUG_PD12_EP0("%s: finished, waiting for status\n", __FUNCTION__);
+		dev->ep0state = WAIT_FOR_SETUP;
+	} else {
+		DEBUG_PD12_EP0("%s: not finished\n", __FUNCTION__);
+	}
+
+	return 1;
+}
+
+static int pd12_handle_get_status(struct pd12_udc *dev,
+				     struct usb_ctrlrequest *ctrl)
+{
+	struct pd12_ep *ep0 = &dev->ep[0];
+	struct pd12_ep *qep;
+	int reqtype = (ctrl->bRequestType & USB_RECIP_MASK);
+	u16 val = 0;
+	u8 ep_sts;
+
+	if (reqtype == USB_RECIP_INTERFACE) {
+		/* This is not supported.
+		 * And according to the USB spec, this one does nothing..
+		 * Just return 0
+		 */
+		DEBUG_PD12_SETUP("GET_STATUS: USB_RECIP_INTERFACE\n");
+	} else if (reqtype == USB_RECIP_DEVICE) {
+		DEBUG_PD12_SETUP("GET_STATUS: USB_RECIP_DEVICE\n");
+		val |= (1 << 0);	/* Self powered */
+		/*val |= (1<<1); */	/* Remote wakeup */
+	} else if (reqtype == USB_RECIP_ENDPOINT) {
+		int ep_num = (ctrl->wIndex & ~USB_DIR_IN);
+
+		DEBUG_PD12_SETUP
+		    ("GET_STATUS: USB_RECIP_ENDPOINT (%d), ctrl->wLength = %d\n",
+		     ep_num, ctrl->wLength);
+
+		if (ctrl->wLength > 2 || ep_num > 3) /* ep_num cannt abouve maxenpoint?*/
+			return -EOPNOTSUPP;
+
+		qep = &dev->ep[ep_num];
+		if (ep_is_in(qep) != ((ctrl->wIndex & USB_DIR_IN) ? 1 : 0)
+		    && ep_index(qep) != 0) {
+			return -EOPNOTSUPP;
+		}
+
+		usb_set_index(ep_index(qep));
+		read_data(&ep_sts);
+		val = (u16)ep_sts;
+
+		/* Back to EP0 index */
+		usb_set_index(0);
+
+		DEBUG_PD12_SETUP("GET_STATUS, ep: %d (%x), val = %d\n", ep_num,
+			    ctrl->wIndex, val);
+	} else {
+		DEBUG_PD12_SETUP("Unknown REQ TYPE: %d\n", reqtype);
+		return -EOPNOTSUPP;
+	}
+
+	/* Put status to FIFO */
+	pd12_fifo_write(ep0, (u8 *) & val, sizeof(val));
+
+	return 0;
+}
+
+/*
+ * WAIT_FOR_SETUP
+ *      - read data packet from EP0 FIFO
+ *      - decode command
+ *      - if error
+ *              set EP0_CLR_OUT | EP0_DATA_END | EP0_SEND_STALL bits
+ *      - else
+ *              set EP0_CLR_OUT | EP0_DATA_END bits
+ */
+static void pd12_ep0_setup(struct pd12_udc *dev)
+{
+	struct pd12_ep *ep = &dev->ep[0];
+	struct usb_ctrlrequest ctrl;
+	int i;
+	u8 stat;
+	u8 inbuf[16];
+	
+	DEBUG_PD12_SETUP("%s: \n", __FUNCTION__);
+
+	/* Nuke all previous transfers */
+	nuke(ep, -EPROTO);
+	pd12_read_lstatus(0,&stat);
+	pd12_set_ack(0);
+	pd12_set_ack(1);
+	if((stat & 0x01) != 0x01){
+		return ;
+	}
+	pd12_fifo_read(ep, (u8 *)&ctrl, 8);
+
+	DEBUG_PD12_SETUP("CTRL.bRequestType = 0x%x (is_in 0x%x)\n", ctrl.bRequestType,
+		    ctrl.bRequestType == USB_DIR_IN);
+	DEBUG_PD12_SETUP("CTRL.bRequest = 0x%x\n", ctrl.bRequest);
+	DEBUG_PD12_SETUP("CTRL.wLength = 0x%x\n", ctrl.wLength);
+	DEBUG_PD12_SETUP("CTRL.wValue = 0x%x (%d)\n", ctrl.wValue, ctrl.wValue >> 8);
+	DEBUG_PD12_SETUP("CTRL.wIndex = 0x%x\n", ctrl.wIndex);
+
+	/* Set direction of EP0 */
+	if (ctrl.bRequestType & USB_DIR_IN) {
+		ep->bEndpointAddress |= USB_DIR_IN;
+	} else {
+		ep->bEndpointAddress &= ~USB_DIR_IN;
+	}
+
+
+	/* Handle some SETUP packets ourselves */
+	switch (ctrl.bRequest) {
+	case USB_REQ_SET_ADDRESS:
+		if (ctrl.bRequestType != (USB_TYPE_STANDARD | USB_RECIP_DEVICE))
+			break;
+
+		DEBUG_PD12_SETUP("USB_REQ_SET_ADDRESS (%d)\n", ctrl.wValue);
+		udc_set_address(dev, le16_to_cpu(ctrl.wValue));
+		pd12_fifo_write(ep,inbuf,0);
+		return;
+
+	case USB_REQ_GET_STATUS:{
+			if (pd12_handle_get_status(dev, &ctrl) == 0)
+				return;
+
+	case USB_REQ_CLEAR_FEATURE:
+	case USB_REQ_SET_FEATURE:
+			if (ctrl.bRequestType == USB_RECIP_ENDPOINT) {
+				struct pd12_ep *qep;
+				int ep_num = (ctrl.wIndex & 0x0f);
+
+				/* Support only HALT feature */
+				if (ctrl.wValue != 0 || ctrl.wLength != 0
+				    || ep_num > 4 || ep_num < 1)
+					break;
+
+				qep = &dev->ep[ep_num];
+				if (ctrl.bRequest == USB_REQ_SET_FEATURE) {
+					DEBUG_PD12_SETUP("SET_FEATURE (%d)\n",
+						    ep_num);
+					pd12_set_halt(&qep->ep, 1);
+				} else {
+					DEBUG_PD12_SETUP("CLR_FEATURE (%d)\n",
+						    ep_num);
+					pd12_set_halt(&qep->ep, 0);
+				}
+				usb_set_index(0);
+
+				return;
+			}
+			break;
+		}
+
+	default:
+		break;
+	}
+
+	if (dev->driver) {
+		/* device-2-host (IN) or no data setup command, process immediately */
+		spin_unlock(&dev->lock);
+		i = dev->driver->setup(&dev->gadget, &ctrl);
+		spin_lock(&dev->lock);
+
+		if (i < 0) {
+			pd12_ep0_in(dev);
+			/* setup processing failed, force stall */
+			DEBUG_PD12_SETUP
+			    ("  --> ERROR: gadget setup FAILED (stalling), setup returned %d\n",
+			     i);
+		/*	usb_set_index(0); */
+			write_cmd(PD12_SET_STATUS);
+			write_data(0x1);
+			write_cmd(PD12_SET_STATUS + 0x1);
+			write_data(0x1);
+			/* ep->stopped = 1; */
+			dev->ep0state = WAIT_FOR_SETUP;
+		}
+	}
+}
+
+/*
+ * handle ep0 in interrupt
+ */
+static void pd12_handle_ep0(struct pd12_udc *dev)
+{
+	struct pd12_ep *ep = &dev->ep[0];
+	u8 ep0in_sts,ep0out_sts/*,int_sts*/;
+	
+	/* Set index 0 */
+	write_cmd(0x0);
+	read_data(&ep0out_sts);
+	
+	write_cmd(0x1);
+	read_data(&ep0in_sts);
+	
+
+	/*
+	 * if STALL is set, clear STALL bit
+	 */
+	if (ep0out_sts & UDC_EP_STALL ) {
+/*		DEBUG_PD12_EP0("%s: EP0_SENT_STALL is set: %x\n", __FUNCTION__, status); */
+		write_cmd(PD12_SET_STATUS);
+		write_data(0x0);
+		nuke(ep, -ECONNABORTED);
+		dev->ep0state = WAIT_FOR_SETUP;
+		return;
+	}
+
+	if (ep0in_sts & UDC_EP_STALL ) {
+/*		DEBUG_PD12_EP0("%s: EP0_SENT_STALL is set: %x\n", __FUNCTION__, status); */
+		write_cmd(PD12_SET_STATUS + 0x1);
+		write_data(0x0);
+		nuke(ep, -ECONNABORTED);
+		dev->ep0state = WAIT_FOR_SETUP;
+		return;
+	}
+
+	switch (dev->ep0state) {
+		case WAIT_FOR_SETUP:
+			DEBUG_PD12_EP0("WAIT_FOR_SETUP\n");
+			pd12_ep0_setup(dev);
+			break;
+		case DATA_STATE_RECV:
+			DEBUG_PD12_EP0("DATA_STATE_RECV\n");
+			pd12_ep0_out(dev);
+			break;
+		case DATA_STATE_XMIT:
+			DEBUG_PD12_EP0("continue with DATA_STATE_XMIT\n");
+			pd12_ep0_in(dev);
+			return;
+		default:
+			/* Stall? */
+			DEBUG_PD12_EP0("Odd state!! state = %s\n",
+				  state_names[dev->ep0state]);
+			dev->ep0state = WAIT_FOR_SETUP;
+			/* nuke(ep, 0); */
+			/* usb_set(EP0_SEND_STALL, ep->csr1); */
+			break;
+	}
+
+}
+
+static void pd12_ep0_kick(struct pd12_udc *dev, struct pd12_ep *ep)
+{
+
+	if (ep_is_in(ep)) {
+		dev->ep0state = DATA_STATE_XMIT;
+		pd12_ep0_in(dev);
+	} else {
+		dev->ep0state = DATA_STATE_RECV;
+		pd12_ep0_out(dev);
+	}
+}
+
+/* ---------------------------------------------------------------------------
+ * 	device-scoped parts of the api to the usb controller hardware
+ * ---------------------------------------------------------------------------
+ */
+
+static int pd12_udc_get_frame(struct usb_gadget *_gadget)
+{
+	u16 frame1,frame2;
+	write_cmd(PD12_RD_CUR_FRAME_NUM);
+	read_data((u8 *)&frame1);/* Least significant 8 bits */
+	read_data((u8 *)&frame2);/* Most significant 3 bits */
+	DEBUG_PD12("%s, %p\n", __FUNCTION__, _gadget);
+	return ((frame2 & 0x07) << 8) | (frame1 & 0xff);
+}
+
+static int pd12_udc_wakeup(struct usb_gadget *_gadget)
+{
+	/* host may not have enabled remote wakeup */
+	/*if ((UDCCS0 & UDCCS0_DRWF) == 0)
+	   return -EHOSTUNREACH;
+	   udc_set_mask_UDCCR(UDCCR_RSM); */
+	return -ENOTSUPP;
+}
+
+static const struct usb_gadget_ops pd12_udc_ops = {
+	.get_frame = pd12_udc_get_frame,
+	.wakeup = pd12_udc_wakeup,
+	/* current versions must always be self-powered */
+};
+
+static void nop_release(struct device *dev)
+{
+	DEBUG_PD12("%s %s\n", __FUNCTION__, dev->bus_id);
+}
+
+static struct pd12_udc usb_memory = {
+	.usb_address = 0,
+
+	.gadget = {
+		   .ops = &pd12_udc_ops,
+		   .ep0 = &usb_memory.ep[0].ep,
+		   .name = driver_name,
+		   .dev = {
+			   .bus_id = "gadget",
+			   .release = nop_release,
+			   },
+		   },
+
+	/* control endpoint */
+	.ep[0] = {
+		  .ep = {
+			 .name = ep0name,
+			 .ops = &pd12_ep_ops,
+			 .maxpacket = 16,
+			 },
+		  .dev = &usb_memory,
+
+		  .bEndpointAddress = 0,
+		  .bmAttributes = USB_ENDPOINT_XFER_CONTROL,
+		  },
+
+	/* first group of endpoints */
+	.ep[1] = {
+		  .ep = {
+			 .name = "ep1out-bulk",
+			 .ops = &pd12_ep_ops,
+			 .maxpacket = 16,
+			 },
+		  .dev = &usb_memory,
+
+		  .bEndpointAddress = 1,
+		  .bmAttributes = USB_ENDPOINT_XFER_BULK,
+
+		  },
+
+	.ep[2] = {
+		  .ep = {
+			 .name = "ep2in-bulk",
+			 .ops = &pd12_ep_ops,
+			 .maxpacket = 16,
+			 },
+		  .dev = &usb_memory,
+
+		  .bEndpointAddress = 2 | USB_DIR_IN,
+		  .bmAttributes = USB_ENDPOINT_XFER_BULK,
+
+		  },
+	.ep[3] = {
+		  .ep = {
+			 .name = "ep3out-int",
+			 .ops = &pd12_ep_ops,
+			 .maxpacket = 64,
+			 },
+		  .dev = &usb_memory,
+
+		  .bEndpointAddress = 3,
+		  .bmAttributes = USB_ENDPOINT_XFER_INT,
+
+		  },
+	.ep[4] = {
+		  .ep = {
+			 .name = "ep3in-int",
+			 .ops = &pd12_ep_ops,
+			 .maxpacket = 64,
+			 },
+		  .dev = &usb_memory,
+
+		  .bEndpointAddress = 4 | USB_DIR_IN,
+		  .bmAttributes = USB_ENDPOINT_XFER_INT,
+
+		  },
+};
+
+/*
+ * 	probe - binds to the platform device
+ */
+static int __devinit pd12_udc_probe(struct device *_dev)
+{
+	struct pd12_udc *dev = &usb_memory;
+	int retval;
+
+	DEBUG_PD12("%s: %p\n", __FUNCTION__, _dev);
+	spin_lock_init(&dev->lock);
+	dev->dev = _dev;
+	
+	device_initialize(&dev->gadget.dev);
+	dev->gadget.dev.parent = _dev;
+
+	the_controller = dev;
+	dev_set_drvdata(_dev, dev);
+
+	udc_reinit(dev);
+
+	dev->gadget.speed = USB_SPEED_FULL;
+	/* irq setup after old hardware state is cleaned up */
+	retval =
+	    request_irq(IRQ_USBINTR, pd12_udc_irq, /*SA_INTERRUPT*/SA_SAMPLE_RANDOM, driver_name,
+			dev);
+	if (retval != 0) {
+		DEBUG_PD12(KERN_ERR "%s: can't get irq %i, err %d\n", driver_name,
+		      IRQ_USBINTR, retval);
+		return -EBUSY;
+	}
+
+	create_proc_files();
+
+	return retval;
+}
+
+static int __devexit pd12_udc_remove(struct device *_dev)
+{
+	struct pd12_udc *dev = _dev->driver_data;
+
+	DEBUG_PD12("%s: %p\n", __FUNCTION__, dev);
+
+	udc_disable(dev);
+	remove_proc_files();
+	usb_gadget_unregister_driver(dev->driver);
+
+	free_irq(IRQ_USBINTR, dev);
+
+	dev_set_drvdata(_dev, 0);
+
+	the_controller = 0;
+
+	return 0;
+}
+static struct platform_device	pd12_pdev = {
+	.name	= (char *) driver_name,
+	.id		= -1,
+};
+
+/*-------------------------------------------------------------------------*/
+
+static struct device_driver udc_driver = {
+	.name = (char *)driver_name,
+	.bus = &platform_bus_type,
+	.probe = pd12_udc_probe,
+	.remove = pd12_udc_remove
+	    /* FIXME power management support */
+	    /* .suspend = ... disable UDC */
+	    /* .resume = ... re-enable UDC */
+};
+
+static int __init udc_init(void)
+{
+	int retval;
+	
+	DEBUG_PD12("%s: %s version %s\n", __FUNCTION__, driver_name, DRIVER_VERSION);
+	th_pd12_virt = ioremap((ulong)TH_PD12_ADDR,0x10);
+	if(!th_pd12_virt){
+		printk("%s: ioremap fail\n",__FUNCTION__);
+		return -EIO;
+	}
+	th_cpld_virt = ioremap((ulong)TH_CPLD_ADDR,0x10);
+	if(!th_cpld_virt){
+		printk("%s: ioremap fail\n",__FUNCTION__);
+		return -EIO;
+	}
+	retval = platform_device_register (&pd12_pdev);
+	if (retval < 0){
+		platform_device_unregister (&pd12_pdev);
+		return retval;
+	}
+	return driver_register(&udc_driver);
+}
+
+static void __exit udc_exit(void)
+{
+	if(th_pd12_virt){
+		iounmap((void*)th_pd12_virt);
+		th_pd12_virt = NULL;
+	}
+	if(th_cpld_virt){
+		iounmap((void*)th_cpld_virt);
+		th_cpld_virt = NULL;
+	}
+	driver_unregister(&udc_driver);
+}
+
+module_init(udc_init);
+module_exit(udc_exit);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
diff --git a/drivers/usb/gadget/pd12_udc.h b/drivers/usb/gadget/pd12_udc.h
new file mode 100644
index 0000000..3ffd07e
--- /dev/null
+++ b/drivers/usb/gadget/pd12_udc.h
@@ -0,0 +1,148 @@
+/*
+ * linux/drivers/usb/gadget/pd12_udc.h
+ * Taihu pd12 full speed USB device controllers
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#ifndef __PD12_UDC_H_
+#define __PD12_UDC_H_
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/proc_fs.h>
+#include <linux/mm.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/byteorder.h>
+#include <asm/dma.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/system.h>
+#include <asm/unaligned.h>
+#include <asm/ibm4xx.h>
+
+#include <linux/usb_ch9.h>
+#include <linux/usb_gadget.h>
+
+#define TH_PD12_ADDR  0x50000000
+#define TH_CPLD_ADDR  0x50100000
+
+#define IRQ_USBINTR 29
+#define USB_SUSPEND 0x20
+
+#define UDC_FIFO_EMPTY 0x0
+#define UDC_FIFO_FULL 0x01
+#define UDC_EP_STALL 0x02
+#define UDC_FIFO_UNWRITABLE (UDC_EP_STALL | UDC_FIFO_FULL)
+#define UDC_FIFO_UNREADABLE (UDC_FIFO_EMPTY | UDC_EP_STALL)
+
+/* pd12 udc command */
+#define PD12_SET_ADDR_EN		0xd0
+#define PD12_SET_EP_EN			0xd8
+#define PD12_SET_MODE 			0xf3
+#define PD12_SET_DMA 			0xfb
+#define PD12_READ_INT			0xf4
+#define PD12_READ_LAST_STATUS 	0x40
+#define PD12_SET_STATUS			0x40
+#define PD12_READ_EP_STATUS 	0x80
+#define PD12_READ_BUF			0xf0
+#define PD12_WRITE_BUF			0xf0
+#define PD12_SET_EP_STATUS		0x40
+#define PD12_ACK_SETUP			0xf1
+#define PD12_CLEAR_BUF			0xf2
+#define PD12_VALIDATE_BUF		0xfa
+#define PD12_SND_RESUME			0xf6
+#define PD12_RD_CUR_FRAME_NUM	0xf5
+
+
+#define WAIT_FOR_SETUP          0
+#define DATA_STATE_XMIT         1
+#define WAIT_FOR_OUT_STATUS     2
+#define DATA_STATE_RECV         3
+
+#define PD12_SUSPEND_CHG 		0x80
+#define PD12_BUS_RST 			0x40
+#define PD12_MAIN_IN 			0x20
+#define PD12_MAIN_OUT 			0x10
+#define PD12_EP1_IN 			0x08
+#define PD12_EP1_OUT 			0x04
+#define PD12_CNTL_IN 			0x02
+#define PD12_CNTL_OUT 			0x01
+
+
+#define PD12_MAX_ENDPOINTS       6
+
+/* ********************************************************************************************* */
+/* IO
+ */
+
+struct pd12_ep {
+	struct usb_ep ep;
+	struct pd12_udc *dev;
+
+	const struct usb_endpoint_descriptor *desc;
+	struct list_head queue;
+	unsigned long pio_irqs;
+	unsigned long dma_irqs;
+	short		  dma;
+
+	u8 stopped;
+	u8 bEndpointAddress;
+	u8 bmAttributes;
+
+};
+
+struct pd12_request {
+	struct usb_request req;
+	struct list_head queue;
+};
+
+struct pd12_udc {
+	struct usb_gadget gadget;
+	struct usb_gadget_driver *driver;
+	struct device *dev;
+	spinlock_t lock;
+
+	int ep0state;
+	struct pd12_ep ep[PD12_MAX_ENDPOINTS];
+
+	unsigned char usb_address;
+
+	unsigned req_pending:1, req_std:1, req_config:1;
+};
+
+static struct pd12_udc *the_controller;
+
+#define ep_is_in(EP) 		(((EP)->bEndpointAddress&USB_DIR_IN)==USB_DIR_IN)
+#define ep_index(EP) 		((EP)->bEndpointAddress&0xF)
+#define ep_maxpacket(EP) 	((EP)->ep.maxpacket)
+
+#endif
diff --git a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
index b67db19..da0de26 100644
--- a/include/asm-ppc/ibm4xx.h
+++ b/include/asm-ppc/ibm4xx.h
@@ -47,6 +47,10 @@
  #include <platforms/4xx/sycamore.h>
  #endif

+#if defined(CONFIG_TAIHU)
+#include <platforms/4xx/taihu.h>
+#endif
+
  #if defined(CONFIG_WALNUT)
  #include <platforms/4xx/walnut.h>
  #endif
