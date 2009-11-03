Return-Path: <fthain@telegraphics.com.au>
Received: from mail.telegraphics.com.au (www.telegraphics.com.au
	[204.15.192.19]) by ozlabs.org (Postfix) with ESMTP id 44923B7BEF
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2009 00:49:38 +1100 (EST)
Date: Wed, 4 Nov 2009 00:40:46 +1100 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4/13] pmac-zilog, mac68k: replace mac68k SCC code with platform
	device
Message-ID: <alpine.OSX.2.00.0911031442360.483@silk.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the old 68k Mac serial port code and a lot of related cruft. Add 
platform driver support to the pmac-zilog driver, putting the powermac- 
specific bits inside #ifdef CONFIG_PPC_PMAC. Add new platform devices to 
mac68k.

Tested on a beige G3 PowerMac and a variety of 68k Macs.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 arch/m68k/Kconfig                 |    6 
 arch/m68k/configs/mac_defconfig   |    7 
 arch/m68k/configs/multi_defconfig |    6 
 arch/m68k/include/asm/machw.h     |   25 --
 arch/m68k/include/asm/macints.h   |   22 --
 arch/m68k/mac/Makefile            |    2 
 arch/m68k/mac/config.c            |   51 +++++
 arch/m68k/mac/debug.c             |  365 --------------------------------------
 arch/m68k/mac/macints.c           |  101 +---------
 arch/m68k/mac/oss.c               |   20 --
 arch/m68k/mac/via.c               |    7 
 drivers/serial/Kconfig            |   12 -
 drivers/serial/pmac_zilog.c       |  159 ++++++++++++++--
 drivers/serial/pmac_zilog.h       |   14 +
 14 files changed, 249 insertions(+), 548 deletions(-)

Index: linux-2.6.31/drivers/serial/Kconfig
===================================================================
--- linux-2.6.31.orig/drivers/serial/Kconfig	2009-11-03 03:23:24.000000000 +1100
+++ linux-2.6.31/drivers/serial/Kconfig	2009-11-03 03:23:41.000000000 +1100
@@ -1079,12 +1079,12 @@ config SERIAL_68360
 	default y
 
 config SERIAL_PMACZILOG
-	tristate "PowerMac z85c30 ESCC support"
-	depends on PPC_OF && PPC_PMAC
+	tristate "Mac or PowerMac z85c30 ESCC support"
+	depends on (M68K && MAC) || (PPC_OF && PPC_PMAC)
 	select SERIAL_CORE
 	help
 	  This driver supports the Zilog z85C30 serial ports found on
-	  PowerMac machines.
+	  (Power)Mac machines.
 	  Say Y or M if you want to be able to these serial ports.
 
 config SERIAL_PMACZILOG_TTYS
@@ -1109,16 +1109,16 @@ config SERIAL_PMACZILOG_TTYS
 	  unable to use the 8250 module for PCMCIA or other 16C550-style
 	  UARTs.
 
-	  Say N unless you need the z85c30 ports on your powermac
+	  Say N unless you need the z85c30 ports on your (Power)Mac
 	  to appear as /dev/ttySn.
 
 config SERIAL_PMACZILOG_CONSOLE
-	bool "Console on PowerMac z85c30 serial port"
+	bool "Console on Mac or PowerMac z85c30 serial port"
 	depends on SERIAL_PMACZILOG=y
 	select SERIAL_CORE_CONSOLE
 	help
 	  If you would like to be able to use the z85c30 serial port
-	  on your PowerMac as the console, you can do so by answering
+	  on your (Power)Mac as the console, you can do so by answering
 	  Y to this option.
 
 config SERIAL_LH7A40X
Index: linux-2.6.31/arch/m68k/Kconfig
===================================================================
--- linux-2.6.31.orig/arch/m68k/Kconfig	2009-11-03 03:23:24.000000000 +1100
+++ linux-2.6.31/arch/m68k/Kconfig	2009-11-03 03:23:41.000000000 +1100
@@ -530,10 +530,6 @@ config GVPIOEXT_PLIP
 	  Say Y to enable doing IP over the parallel port on your GVP
 	  IO-Extender card, N otherwise.
 
-config MAC_SCC
-	tristate "Macintosh serial support"
-	depends on MAC
-
 config MAC_HID
 	bool
 	depends on INPUT_ADBHID
@@ -589,7 +585,7 @@ config DN_SERIAL
 
 config SERIAL_CONSOLE
 	bool "Support for serial port console"
-	depends on (AMIGA || ATARI || MAC || SUN3 || SUN3X || VME || APOLLO) && (ATARI_MFPSER=y || ATARI_MIDI=y || MAC_SCC=y || AMIGA_BUILTIN_SERIAL=y || GVPIOEXT=y || MULTIFACE_III_TTY=y || SERIAL=y || MVME147_SCC || SERIAL167 || MVME162_SCC || BVME6000_SCC || DN_SERIAL)
+	depends on (AMIGA || ATARI || MAC || SUN3 || SUN3X || VME || APOLLO) && (ATARI_MFPSER=y || ATARI_MIDI=y || AMIGA_BUILTIN_SERIAL=y || GVPIOEXT=y || MULTIFACE_III_TTY=y || SERIAL=y || MVME147_SCC || SERIAL167 || MVME162_SCC || BVME6000_SCC || DN_SERIAL)
 	---help---
 	  If you say Y here, it will be possible to use a serial port as the
 	  system console (the system console is the device which receives all
Index: linux-2.6.31/arch/m68k/configs/mac_defconfig
===================================================================
--- linux-2.6.31.orig/arch/m68k/configs/mac_defconfig	2009-11-03 03:23:24.000000000 +1100
+++ linux-2.6.31/arch/m68k/configs/mac_defconfig	2009-11-03 03:23:41.000000000 +1100
@@ -701,6 +701,11 @@ CONFIG_VT_HW_CONSOLE_BINDING=y
 #
 # Non-8250 serial port support
 #
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_PMACZILOG=y
+CONFIG_SERIAL_PMACZILOG_TTYS=y
+CONFIG_SERIAL_PMACZILOG_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 CONFIG_LEGACY_PTYS=y
@@ -834,9 +839,7 @@ CONFIG_HIDRAW=y
 #
 # Character devices
 #
-CONFIG_MAC_SCC=y
 CONFIG_MAC_HID=y
-CONFIG_SERIAL_CONSOLE=y
 
 #
 # File systems
Index: linux-2.6.31/arch/m68k/configs/multi_defconfig
===================================================================
--- linux-2.6.31.orig/arch/m68k/configs/multi_defconfig	2009-11-03 03:23:24.000000000 +1100
+++ linux-2.6.31/arch/m68k/configs/multi_defconfig	2009-11-03 03:23:41.000000000 +1100
@@ -822,6 +822,11 @@ CONFIG_A2232=y
 #
 # Non-8250 serial port support
 #
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_PMACZILOG=y
+CONFIG_SERIAL_PMACZILOG_TTYS=y
+CONFIG_SERIAL_PMACZILOG_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 CONFIG_LEGACY_PTYS=y
@@ -982,7 +987,6 @@ CONFIG_ATARI_MIDI=y
 CONFIG_ATARI_DSP56K=m
 CONFIG_AMIGA_BUILTIN_SERIAL=y
 CONFIG_MULTIFACE_III_TTY=m
-CONFIG_MAC_SCC=y
 CONFIG_MAC_HID=y
 CONFIG_MVME147_SCC=y
 CONFIG_SERIAL167=y
Index: linux-2.6.31/drivers/serial/pmac_zilog.c
===================================================================
--- linux-2.6.31.orig/drivers/serial/pmac_zilog.c	2009-11-03 03:23:41.000000000 +1100
+++ linux-2.6.31/drivers/serial/pmac_zilog.c	2009-11-03 03:23:41.000000000 +1100
@@ -63,11 +63,18 @@
 #include <asm/sections.h>
 #include <asm/io.h>
 #include <asm/irq.h>
+
+#ifdef CONFIG_PPC_PMAC
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
 #include <asm/dbdma.h>
 #include <asm/macio.h>
+#else
+#include <linux/platform_device.h>
+#include <asm/macints.h>
+#define machine_is_compatible(x) (0)
+#endif
 
 #if defined (CONFIG_SERIAL_PMACZILOG_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
@@ -83,11 +90,9 @@
 
 static char version[] __initdata = "pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)";
 MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
-MODULE_DESCRIPTION("Driver for the PowerMac serial ports.");
+MODULE_DESCRIPTION("Driver for the Mac and PowerMac serial ports.");
 MODULE_LICENSE("GPL");
 
-#define PWRDBG(fmt, arg...)	printk(KERN_DEBUG fmt , ## arg)
-
 #ifdef CONFIG_SERIAL_PMACZILOG_TTYS
 #define PMACZILOG_MAJOR		TTY_MAJOR
 #define PMACZILOG_MINOR		64
@@ -341,7 +346,7 @@ static struct tty_struct *pmz_receive_ch
 	uap->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
 	write_zsreg(uap, R1, uap->curregs[R1]);
 	zssync(uap);
-	dev_err(&uap->dev->ofdev.dev, "pmz: rx irq flood !\n");
+	pmz_error("pmz: rx irq flood !\n");
 	return tty;
 }
 
@@ -746,6 +751,8 @@ static void pmz_break_ctl(struct uart_po
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
+#ifdef CONFIG_PPC_PMAC
+
 /*
  * Turn power on or off to the SCC and associated stuff
  * (port drivers, modem, IR port, etc.)
@@ -781,6 +788,15 @@ static int pmz_set_scc_power(struct uart
 	return delay;
 }
 
+#else
+
+static int pmz_set_scc_power(struct uart_pmac_port *uap, int state)
+{
+	return 0;
+}
+
+#endif /* !CONFIG_PPC_PMAC */
+
 /*
  * FixZeroBug....Works around a bug in the SCC receving channel.
  * Inspired from Darwin code, 15 Sept. 2000  -DanM
@@ -943,9 +959,9 @@ static int pmz_startup(struct uart_port 
 	}	
 
 	pmz_get_port_A(uap)->flags |= PMACZILOG_FLAG_IS_IRQ_ON;
-	if (request_irq(uap->port.irq, pmz_interrupt, IRQF_SHARED, "PowerMac Zilog", uap)) {
-		dev_err(&uap->dev->ofdev.dev,
-			"Unable to register zs interrupt handler.\n");
+	if (request_irq(uap->port.irq, pmz_interrupt, IRQF_SHARED,
+	                "SCC", uap)) {
+		pmz_error("Unable to register zs interrupt handler.\n");
 		pmz_set_scc_power(uap, 0);
 		mutex_unlock(&pmz_irq_mutex);
 		return -ENXIO;
@@ -1185,7 +1201,7 @@ static void pmz_irda_setup(struct uart_p
 	while ((read_zsreg(uap, R0) & Tx_BUF_EMP) == 0
 	       || (read_zsreg(uap, R1) & ALL_SNT) == 0) {
 		if (--t <= 0) {
-			dev_err(&uap->dev->ofdev.dev, "transmitter didn't drain\n");
+			pmz_error("transmitter didn't drain\n");
 			return;
 		}
 		udelay(10);
@@ -1201,7 +1217,7 @@ static void pmz_irda_setup(struct uart_p
 		read_zsdata(uap);
 		mdelay(10);
 		if (--t <= 0) {
-			dev_err(&uap->dev->ofdev.dev, "receiver didn't drain\n");
+			pmz_error("receiver didn't drain\n");
 			return;
 		}
 	}
@@ -1222,8 +1238,7 @@ static void pmz_irda_setup(struct uart_p
 	t = 5000;
 	while ((read_zsreg(uap, R0) & Rx_CH_AV) == 0) {
 		if (--t <= 0) {
-			dev_err(&uap->dev->ofdev.dev,
-				"irda_setup timed out on get_version byte\n");
+			pmz_error("irda_setup timed out on get_version byte\n");
 			goto out;
 		}
 		udelay(10);
@@ -1231,8 +1246,7 @@ static void pmz_irda_setup(struct uart_p
 	version = read_zsdata(uap);
 
 	if (version < 4) {
-		dev_info(&uap->dev->ofdev.dev, "IrDA: dongle version %d not supported\n",
-			 version);
+		pmz_info("IrDA: dongle version %d not supported\n", version);
 		goto out;
 	}
 
@@ -1241,19 +1255,17 @@ static void pmz_irda_setup(struct uart_p
 	t = 5000;
 	while ((read_zsreg(uap, R0) & Rx_CH_AV) == 0) {
 		if (--t <= 0) {
-			dev_err(&uap->dev->ofdev.dev,
-				"irda_setup timed out on speed mode byte\n");
+			pmz_error("irda_setup timed out on speed mode byte\n");
 			goto out;
 		}
 		udelay(10);
 	}
 	t = read_zsdata(uap);
 	if (t != cmdbyte)
-		dev_err(&uap->dev->ofdev.dev,
-			"irda_setup speed mode byte = %x (%x)\n", t, cmdbyte);
+		pmz_error("irda_setup speed mode byte = %x (%x)\n", t, cmdbyte);
 
-	dev_info(&uap->dev->ofdev.dev, "IrDA setup for %ld bps, dongle version: %d\n",
-		 *baud, version);
+	pmz_info("IrDA setup for %ld bps, dongle version: %d\n",
+	         *baud, version);
 
 	(void)read_zsdata(uap);
 	(void)read_zsdata(uap);
@@ -1402,7 +1414,7 @@ static void pmz_poll_put_char(struct uar
 	write_zsdata(uap, c);
 }
 
-#endif
+#endif /* CONFIG_CONSOLE_POLL */
 
 static struct uart_ops pmz_pops = {
 	.tx_empty	=	pmz_tx_empty,
@@ -1427,6 +1439,8 @@ static struct uart_ops pmz_pops = {
 #endif
 };
 
+#ifdef CONFIG_PPC_PMAC
+
 /*
  * Setup one port structure after probing, HW is down at this point,
  * Unlike sunzilog, we don't need to pre-init the spinlock as we don't
@@ -1823,6 +1837,88 @@ next:
 	return 0;
 }
 
+#else
+
+extern struct platform_device scc_a_pdev, scc_b_pdev;
+
+static int __init pmz_init_port(struct uart_pmac_port *uap)
+{
+	struct resource *r_ports;
+	int irq;
+
+	r_ports = platform_get_resource(uap->node, IORESOURCE_MEM, 0);
+	irq = platform_get_irq(uap->node, 0);
+	if (!r_ports || !irq)
+		return -ENODEV;
+
+	uap->port.mapbase  = r_ports->start;
+	uap->port.membase  = (unsigned char __iomem *) r_ports->start;
+	uap->port.iotype   = UPIO_MEM;
+	uap->port.irq      = irq;
+	uap->port.uartclk  = ZS_CLOCK;
+	uap->port.fifosize = 1;
+	uap->port.ops      = &pmz_pops;
+	uap->port.type     = PORT_PMAC_ZILOG;
+	uap->port.flags    = 0;
+
+	uap->control_reg   = uap->port.membase;
+	uap->data_reg      = uap->control_reg + 4;
+	uap->port_type     = 0;
+
+	pmz_convert_to_zs(uap, CS8, 0, 9600);
+
+	return 0;
+}
+
+static int __init pmz_probe(void)
+{
+	int err;
+
+	pmz_ports_count = 0;
+
+	pmz_ports[0].mate      = &pmz_ports[1];
+	pmz_ports[0].port.line = 0;
+	pmz_ports[0].flags     = PMACZILOG_FLAG_IS_CHANNEL_A;
+	pmz_ports[0].node      = &scc_a_pdev;
+	err = pmz_init_port(&pmz_ports[0]);
+	if (err)
+		return err;
+	pmz_ports_count++;
+
+	pmz_ports[1].mate      = &pmz_ports[0];
+	pmz_ports[1].port.line = 1;
+	pmz_ports[1].flags     = 0;
+	pmz_ports[1].node      = &scc_b_pdev;
+	err = pmz_init_port(&pmz_ports[1]);
+	if (err)
+		return err;
+	pmz_ports_count++;
+
+	return 0;
+}
+
+static void pmz_dispose_port(struct uart_pmac_port *uap)
+{
+	memset(uap, 0, sizeof(struct uart_pmac_port));
+}
+
+static int pmz_attach(struct platform_device *pdev)
+{
+	int i;
+
+	for (i = 0; i < pmz_ports_count; i++)
+		if (pmz_ports[i].node == pdev)
+			return 0;
+	return -ENODEV;
+}
+
+static int pmz_detach(struct platform_device *pdev)
+{
+	return 0;
+}
+
+#endif /* !CONFIG_PPC_PMAC */
+
 #ifdef CONFIG_SERIAL_PMACZILOG_CONSOLE
 
 static void pmz_console_write(struct console *con, const char *s, unsigned int count);
@@ -1883,6 +1979,8 @@ err_out:
 	return rc;
 }
 
+#ifdef CONFIG_PPC_PMAC
+
 static struct of_device_id pmz_match[] = 
 {
 	{
@@ -1904,6 +2002,19 @@ static struct macio_driver pmz_driver = 
 	.resume		= pmz_resume,
 };
 
+#else
+
+static struct platform_driver pmz_driver = {
+	.probe          = pmz_attach,
+	.remove         = __devexit_p(pmz_detach),
+	.driver         = {
+		.name           = "scc",
+		.owner          = THIS_MODULE,
+	},
+};
+
+#endif /* !CONFIG_PPC_PMAC */
+
 static int __init init_pmz(void)
 {
 	int rc, i;
@@ -1942,15 +2053,23 @@ static int __init init_pmz(void)
 	/*
 	 * Then we register the macio driver itself
 	 */
+#ifdef CONFIG_PPC_PMAC
 	return macio_register_driver(&pmz_driver);
+#else
+	return platform_driver_register(&pmz_driver);
+#endif
 }
 
 static void __exit exit_pmz(void)
 {
 	int i;
 
+#ifdef CONFIG_PPC_PMAC
 	/* Get rid of macio-driver (detach from macio) */
 	macio_unregister_driver(&pmz_driver);
+#else
+	platform_driver_unregister(&pmz_driver);
+#endif
 
 	for (i = 0; i < pmz_ports_count; i++) {
 		struct uart_pmac_port *uport = &pmz_ports[i];
Index: linux-2.6.31/drivers/serial/pmac_zilog.h
===================================================================
--- linux-2.6.31.orig/drivers/serial/pmac_zilog.h	2009-11-03 03:23:41.000000000 +1100
+++ linux-2.6.31/drivers/serial/pmac_zilog.h	2009-11-03 03:23:41.000000000 +1100
@@ -1,7 +1,15 @@
 #ifndef __PMAC_ZILOG_H__
 #define __PMAC_ZILOG_H__
 
+#ifdef CONFIG_PPC_PMAC
 #define pmz_debug(fmt, arg...)	dev_dbg(&uap->dev->ofdev.dev, fmt, ## arg)
+#define pmz_error(fmt, arg...)	dev_err(&uap->dev->ofdev.dev, fmt, ## arg)
+#define pmz_info(fmt, arg...)	dev_info(&uap->dev->ofdev.dev, fmt, ## arg)
+#else
+#define pmz_debug(fmt, arg...)	do { } while (0)
+#define pmz_error(fmt, arg...)	printk(KERN_ERR fmt, ## arg)
+#define pmz_info(fmt, arg...)	printk(KERN_INFO fmt, ## arg)
+#endif
 
 /*
  * At most 2 ESCCs with 2 ports each
@@ -17,6 +25,7 @@ struct uart_pmac_port {
 	struct uart_port		port;
 	struct uart_pmac_port		*mate;
 
+#ifdef CONFIG_PPC_PMAC
 	/* macio_dev for the escc holding this port (maybe be null on
 	 * early inited port)
 	 */
@@ -25,6 +34,9 @@ struct uart_pmac_port {
 	 * of "escc" node (ie. ch-a or ch-b)
 	 */
 	struct device_node		*node;
+#else
+	struct platform_device		*node;
+#endif
 
 	/* Port type as obtained from device tree (IRDA, modem, ...) */
 	int				port_type;
@@ -55,10 +67,12 @@ struct uart_pmac_port {
 	volatile u8			__iomem *control_reg;
 	volatile u8			__iomem *data_reg;
 
+#ifdef CONFIG_PPC_PMAC
 	unsigned int			tx_dma_irq;
 	unsigned int			rx_dma_irq;
 	volatile struct dbdma_regs	__iomem *tx_dma_regs;
 	volatile struct dbdma_regs	__iomem *rx_dma_regs;
+#endif
 
 	struct ktermios			termios_cache;
 };
Index: linux-2.6.31/arch/m68k/mac/Makefile
===================================================================
--- linux-2.6.31.orig/arch/m68k/mac/Makefile	2009-11-03 03:23:24.000000000 +1100
+++ linux-2.6.31/arch/m68k/mac/Makefile	2009-11-03 03:23:41.000000000 +1100
@@ -3,4 +3,4 @@
 #
 
 obj-y		:= config.o macints.o iop.o via.o oss.o psc.o \
-			baboon.o macboing.o debug.o misc.o
+			baboon.o macboing.o misc.o
Index: linux-2.6.31/arch/m68k/mac/debug.c
===================================================================
--- linux-2.6.31.orig/arch/m68k/mac/debug.c	2009-11-03 03:23:24.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,365 +0,0 @@
-/*
- * linux/arch/m68k/mac/debug.c
- *
- * Shamelessly stolen (SCC code and general framework) from:
- *
- * linux/arch/m68k/atari/debug.c
- *
- * Atari debugging and serial console stuff
- *
- * Assembled of parts of former atari/config.c 97-12-18 by Roman Hodek
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of this archive
- * for more details.
- */
-
-#include <linux/types.h>
-#include <linux/sched.h>
-#include <linux/tty.h>
-#include <linux/console.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-
-#define BOOTINFO_COMPAT_1_0
-#include <asm/setup.h>
-#include <asm/bootinfo.h>
-#include <asm/macints.h>
-
-extern unsigned long mac_videobase;
-extern unsigned long mac_rowbytes;
-
-extern void mac_serial_print(const char *);
-
-#define DEBUG_HEADS
-#undef DEBUG_SCREEN
-#define DEBUG_SERIAL
-
-/*
- * These two auxiliary debug functions should go away ASAP. Only usage:
- * before the console output is up (after head.S come some other crucial
- * setup routines :-) it permits writing 'data' to the screen as bit patterns
- * (good luck reading those). Helped to figure that the bootinfo contained
- * garbage data on the amount and size of memory chunks ...
- *
- * The 'pos' argument now simply means 'linefeed after print' ...
- */
-
-#ifdef DEBUG_SCREEN
-static int peng, line;
-#endif
-
-#if 0
-
-void mac_debugging_short(int pos, short num)
-{
-#ifdef DEBUG_SCREEN
-	unsigned char *pengoffset;
-	unsigned char *pptr;
-	int i;
-#endif
-
-#ifdef DEBUG_SERIAL
-	printk("debug: %d !\n", num);
-#endif
-
-#ifdef DEBUG_SCREEN
-	if (!MACH_IS_MAC) {
-		/* printk("debug: %d !\n", num); */
-		return;
-	}
-
-	/* calculate current offset */
-	pengoffset = (unsigned char *)mac_videobase +
-		(150+line*2) * mac_rowbytes + 80 * peng;
-
-	pptr = pengoffset;
-
-	for (i = 0; i < 8 * sizeof(short); i++) { /* # of bits */
-		/*        value        mask for bit i, reverse order */
-		*pptr++ = (num & (1 << (8*sizeof(short)-i-1)) ? 0xFF : 0x00);
-	}
-
-	peng++;
-
-	if (pos) {
-		line++;
-		peng = 0;
-	}
-#endif
-}
-
-void mac_debugging_long(int pos, long addr)
-{
-#ifdef DEBUG_SCREEN
-	unsigned char *pengoffset;
-	unsigned char *pptr;
-	int i;
-#endif
-
-#ifdef DEBUG_SERIAL
-	printk("debug: #%ld !\n", addr);
-#endif
-
-#ifdef DEBUG_SCREEN
-	if (!MACH_IS_MAC) {
-		/* printk("debug: #%ld !\n", addr); */
-		return;
-	}
-
-	pengoffset=(unsigned char *)(mac_videobase+(150+line*2)*mac_rowbytes)
-		    +80*peng;
-
-	pptr = pengoffset;
-
-	for (i = 0; i < 8 * sizeof(long); i++) { /* # of bits */
-		*pptr++ = (addr & (1 << (8*sizeof(long)-i-1)) ? 0xFF : 0x00);
-	}
-
-	peng++;
-
-	if (pos) {
-		line++;
-		peng = 0;
-	}
-#endif
-}
-
-#endif  /*  0  */
-
-#ifdef DEBUG_SERIAL
-/*
- * TODO: serial debug code
- */
-
-struct mac_SCC {
-	u_char cha_b_ctrl;
-	u_char char_dummy1;
-	u_char cha_a_ctrl;
-	u_char char_dummy2;
-	u_char cha_b_data;
-	u_char char_dummy3;
-	u_char cha_a_data;
-};
-
-# define scc (*((volatile struct mac_SCC*)mac_bi_data.sccbase))
-
-static int scc_port = -1;
-
-static struct console mac_console_driver = {
-	.name	= "debug",
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1,
-};
-
-/*
- * Crude hack to get console output to the screen before the framebuffer
- * is initialized (happens a lot later in 2.1!).
- * We just use the console routines declared in head.S, this will interfere
- * with regular framebuffer console output and should be used exclusively
- * to debug kernel problems manifesting before framebuffer init (aka WSOD)
- *
- * To keep this hack from interfering with the regular console driver, either
- * deregister this driver before/on framebuffer console init, or silence this
- * function after the fbcon driver is running (will lose console messages!?).
- * To debug real early bugs, need to write a 'mac_register_console_hack()'
- * that is called from start_kernel() before setup_arch() and just registers
- * this driver if Mac.
- */
-
-static void mac_debug_console_write(struct console *co, const char *str,
-				    unsigned int count)
-{
-	mac_serial_print(str);
-}
-
-
-
-/* Mac: loops_per_jiffy min. 19000 ^= .5 us; MFPDELAY was 0.6 us*/
-
-#define uSEC 1
-
-static inline void mac_sccb_out(char c)
-{
-	int i;
-
-	do {
-		for (i = uSEC; i > 0; --i)
-			barrier();
-	} while (!(scc.cha_b_ctrl & 0x04)); /* wait for tx buf empty */
-	for (i = uSEC; i > 0; --i)
-		barrier();
-	scc.cha_b_data = c;
-}
-
-static inline void mac_scca_out(char c)
-{
-	int i;
-
-	do {
-		for (i = uSEC; i > 0; --i)
-			barrier();
-	} while (!(scc.cha_a_ctrl & 0x04)); /* wait for tx buf empty */
-	for (i = uSEC; i > 0; --i)
-		barrier();
-	scc.cha_a_data = c;
-}
-
-static void mac_sccb_console_write(struct console *co, const char *str,
-				   unsigned int count)
-{
-	while (count--) {
-		if (*str == '\n')
-			mac_sccb_out('\r');
-		mac_sccb_out(*str++);
-	}
-}
-
-static void mac_scca_console_write(struct console *co, const char *str,
-				   unsigned int count)
-{
-	while (count--) {
-		if (*str == '\n')
-			mac_scca_out('\r');
-		mac_scca_out(*str++);
-	}
-}
-
-
-/* The following two functions do a quick'n'dirty initialization of the MFP or
- * SCC serial ports. They're used by the debugging interface, kgdb, and the
- * serial console code. */
-#define SCCB_WRITE(reg,val)				\
-	do {						\
-		int i;					\
-		scc.cha_b_ctrl = (reg);			\
-		for (i = uSEC; i > 0; --i)		\
-			barrier();			\
-		scc.cha_b_ctrl = (val);			\
-		for (i = uSEC; i > 0; --i)		\
-			barrier();			\
-	} while(0)
-
-#define SCCA_WRITE(reg,val)				\
-	do {						\
-		int i;					\
-		scc.cha_a_ctrl = (reg);			\
-		for (i = uSEC; i > 0; --i)		\
-			barrier();			\
-		scc.cha_a_ctrl = (val);			\
-		for (i = uSEC; i > 0; --i)		\
-			barrier();			\
-	} while(0)
-
-/* loops_per_jiffy isn't initialized yet, so we can't use udelay(). This does a
- * delay of ~ 60us. */
-/* Mac: loops_per_jiffy min. 19000 ^= .5 us; MFPDELAY was 0.6 us*/
-#define LONG_DELAY()					\
-	do {						\
-		int i;					\
-		for (i = 60*uSEC; i > 0; --i)		\
-		    barrier();				\
-	} while(0)
-
-static void __init mac_init_scc_port(int cflag, int port)
-{
-	/*
-	 * baud rates: 1200, 1800, 2400, 4800, 9600, 19.2k, 38.4k, 57.6k, 115.2k
-	 */
-
-	static int clksrc_table[9] =
-		/* reg 11: 0x50 = BRG, 0x00 = RTxC, 0x28 = TRxC */
-		{ 0x50, 0x50, 0x50, 0x50, 0x50, 0x50, 0x50, 0x00, 0x00 };
-	static int clkmode_table[9] =
-		/* reg 4: 0x40 = x16, 0x80 = x32, 0xc0 = x64 */
-		{ 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0xc0, 0x80 };
-	static int div_table[9] =
-		/* reg12 (BRG low) */
-		{ 94, 62, 46, 22, 10, 4, 1, 0, 0 };
-
-	int baud = cflag & CBAUD;
-	int clksrc, clkmode, div, reg3, reg5;
-
-	if (cflag & CBAUDEX)
-		baud += B38400;
-	if (baud < B1200 || baud > B38400+2)
-		baud = B9600; /* use default 9600bps for non-implemented rates */
-	baud -= B1200; /* tables starts at 1200bps */
-
-	clksrc  = clksrc_table[baud];
-	clkmode = clkmode_table[baud];
-	div     = div_table[baud];
-
-	reg3 = (((cflag & CSIZE) == CS8) ? 0xc0 : 0x40);
-	reg5 = (((cflag & CSIZE) == CS8) ? 0x60 : 0x20) | 0x82 /* assert DTR/RTS */;
-
-	if (port == 1) {
-		(void)scc.cha_b_ctrl;	/* reset reg pointer */
-		SCCB_WRITE(9, 0xc0);	/* reset */
-		LONG_DELAY();		/* extra delay after WR9 access */
-		SCCB_WRITE(4, (cflag & PARENB) ? ((cflag & PARODD) ? 0x01 : 0x03) : 0 |
-			   0x04 /* 1 stopbit */ |
-			   clkmode);
-		SCCB_WRITE(3, reg3);
-		SCCB_WRITE(5, reg5);
-		SCCB_WRITE(9, 0);	/* no interrupts */
-		LONG_DELAY();		/* extra delay after WR9 access */
-		SCCB_WRITE(10, 0);	/* NRZ mode */
-		SCCB_WRITE(11, clksrc);	/* main clock source */
-		SCCB_WRITE(12, div);	/* BRG value */
-		SCCB_WRITE(13, 0);	/* BRG high byte */
-		SCCB_WRITE(14, 1);
-		SCCB_WRITE(3, reg3 | 1);
-		SCCB_WRITE(5, reg5 | 8);
-	} else if (port == 0) {
-		(void)scc.cha_a_ctrl;	/* reset reg pointer */
-		SCCA_WRITE(9, 0xc0);	/* reset */
-		LONG_DELAY();		/* extra delay after WR9 access */
-		SCCA_WRITE(4, (cflag & PARENB) ? ((cflag & PARODD) ? 0x01 : 0x03) : 0 |
-			  0x04 /* 1 stopbit */ |
-			  clkmode);
-		SCCA_WRITE(3, reg3);
-		SCCA_WRITE(5, reg5);
-		SCCA_WRITE(9, 0);	/* no interrupts */
-		LONG_DELAY();		/* extra delay after WR9 access */
-		SCCA_WRITE(10, 0);	/* NRZ mode */
-		SCCA_WRITE(11, clksrc);	/* main clock source */
-		SCCA_WRITE(12, div);	/* BRG value */
-		SCCA_WRITE(13, 0);	/* BRG high byte */
-		SCCA_WRITE(14, 1);
-		SCCA_WRITE(3, reg3 | 1);
-		SCCA_WRITE(5, reg5 | 8);
-	}
-}
-#endif /* DEBUG_SERIAL */
-
-static int __init mac_debug_setup(char *arg)
-{
-	if (!MACH_IS_MAC)
-		return 0;
-
-#ifdef DEBUG_SERIAL
-	if (!strcmp(arg, "ser") || !strcmp(arg, "ser1")) {
-		/* Mac modem port */
-		mac_init_scc_port(B9600|CS8, 0);
-		mac_console_driver.write = mac_scca_console_write;
-		scc_port = 0;
-	} else if (!strcmp(arg, "ser2")) {
-		/* Mac printer port */
-		mac_init_scc_port(B9600|CS8, 1);
-		mac_console_driver.write = mac_sccb_console_write;
-		scc_port = 1;
-	}
-#endif
-#ifdef DEBUG_HEADS
-	if (!strcmp(arg, "scn") || !strcmp(arg, "con")) {
-		/* display, using head.S console routines */
-		mac_console_driver.write = mac_debug_console_write;
-	}
-#endif
-	if (mac_console_driver.write)
-		register_console(&mac_console_driver);
-	return 0;
-}
-
-early_param("debug", mac_debug_setup);
Index: linux-2.6.31/arch/m68k/include/asm/machw.h
===================================================================
--- linux-2.6.31.orig/arch/m68k/include/asm/machw.h	2009-11-03 03:23:24.000000000 +1100
+++ linux-2.6.31/arch/m68k/include/asm/machw.h	2009-11-03 03:23:41.000000000 +1100
@@ -21,29 +21,4 @@
 #define VIDEOMEMSIZE	(4096*1024)
 #define VIDEOMEMMASK	(-4096*1024)
 
-#ifndef __ASSEMBLY__
-
-#include <linux/types.h>
-
-#if 0
-/*
-** SCC Z8530
-*/
-
-#define MAC_SCC_BAS (0x50F04000)
-struct MAC_SCC
- {
-  u_char cha_a_ctrl;
-  u_char char_dummy1;
-  u_char cha_a_data;
-  u_char char_dummy2;
-  u_char cha_b_ctrl;
-  u_char char_dummy3;
-  u_char cha_b_data;
- };
-# define mac_scc ((*(volatile struct SCC*)MAC_SCC_BAS))
-#endif
-
-#endif /* __ASSEMBLY__ */
-
 #endif /* linux/machw.h */
Index: linux-2.6.31/arch/m68k/include/asm/macints.h
===================================================================
--- linux-2.6.31.orig/arch/m68k/include/asm/macints.h	2009-11-03 03:23:24.000000000 +1100
+++ linux-2.6.31/arch/m68k/include/asm/macints.h	2009-11-03 03:23:41.000000000 +1100
@@ -37,7 +37,6 @@
 
 #define VIA1_SOURCE_BASE	8
 #define VIA2_SOURCE_BASE	16
-#define MAC_SCC_SOURCE_BASE	24
 #define PSC3_SOURCE_BASE	24
 #define PSC4_SOURCE_BASE	32
 #define PSC5_SOURCE_BASE	40
@@ -96,26 +95,12 @@
 #define IRQ_PSC3_2	  (26)
 #define IRQ_PSC3_3	  (27)
 
-/* Level 4 (SCC) interrupts */
-#define IRQ_SCC		     (32)
-#define IRQ_SCCA	     (33)
-#define IRQ_SCCB	     (34)
-#if 0 /* FIXME: are there multiple interrupt conditions on the SCC ?? */
-/* SCC interrupts */
-#define IRQ_SCCB_TX	     (32)
-#define IRQ_SCCB_STAT	     (33)
-#define IRQ_SCCB_RX	     (34)
-#define IRQ_SCCB_SPCOND	     (35)
-#define IRQ_SCCA_TX	     (36)
-#define IRQ_SCCA_STAT	     (37)
-#define IRQ_SCCA_RX	     (38)
-#define IRQ_SCCA_SPCOND	     (39)
-#endif
-
 /* Level 4 (PSC, AV Macs only) interrupts */
 #define IRQ_PSC4_0	  (32)
 #define IRQ_PSC4_1	  (33)
+#define IRQ_MAC_SCC_A	  IRQ_PSC4_1
 #define IRQ_PSC4_2	  (34)
+#define IRQ_MAC_SCC_B	  IRQ_PSC4_2
 #define IRQ_PSC4_3	  (35)
 #define IRQ_MAC_MACE_DMA  IRQ_PSC4_3
 
@@ -146,6 +131,9 @@
 #define IRQ_BABOON_2	  (66)
 #define IRQ_BABOON_3	  (67)
 
+/* On non-PSC machines, the serial ports share an IRQ */
+#define IRQ_MAC_SCC	  IRQ_AUTO_4
+
 #define SLOT2IRQ(x)	  (x + 47)
 #define IRQ2SLOT(x)	  (x - 47)
 
Index: linux-2.6.31/arch/m68k/mac/macints.c
===================================================================
--- linux-2.6.31.orig/arch/m68k/mac/macints.c	2009-11-03 03:23:24.000000000 +1100
+++ linux-2.6.31/arch/m68k/mac/macints.c	2009-11-03 03:23:41.000000000 +1100
@@ -34,9 +34,7 @@
  *
  *	3	- unused (?)
  *
- *	4	- SCC (slot number determined by reading RR3 on the SSC itself)
- *		  - slot 1: SCC channel A
- *		  - slot 2: SCC channel B
+ *	4	- SCC
  *
  *	5	- unused (?)
  *		  [serial errors or special conditions seem to raise level 6
@@ -55,8 +53,6 @@
  *		  - slot 5: Slot $E
  *
  *	4	- SCC IOP
- *		  - slot 1: SCC channel A
- *		  - slot 2: SCC channel B
  *
  *	5	- ISM IOP (ADB?)
  *
@@ -136,13 +132,8 @@
 #include <asm/irq_regs.h>
 #include <asm/mac_oss.h>
 
-#define DEBUG_SPURIOUS
 #define SHUTUP_SONIC
 
-/* SCC interrupt mask */
-
-static int scc_mask;
-
 /*
  * VIA/RBV hooks
  */
@@ -191,13 +182,6 @@ extern void baboon_irq_disable(int);
 extern void baboon_irq_clear(int);
 
 /*
- * SCC interrupt routines
- */
-
-static void scc_irq_enable(unsigned int);
-static void scc_irq_disable(unsigned int);
-
-/*
  * console_loglevel determines NMI handler function
  */
 
@@ -221,8 +205,6 @@ void __init mac_init_IRQ(void)
 #ifdef DEBUG_MACINTS
 	printk("mac_init_IRQ(): Setting things up...\n");
 #endif
-	scc_mask = 0;
-
 	m68k_setup_irq_controller(&mac_irq_controller, IRQ_USER,
 				  NUM_MAC_SOURCES - IRQ_USER);
 	/* Make sure the SONIC interrupt is cleared or things get ugly */
@@ -283,15 +265,16 @@ void mac_enable_irq(unsigned int irq)
 			via_irq_enable(irq);
 		break;
 	case 3:
-	case 4:
 	case 5:
 	case 6:
 		if (psc_present)
 			psc_irq_enable(irq);
 		else if (oss_present)
 			oss_irq_enable(irq);
-		else if (irq_src == 4)
-			scc_irq_enable(irq);
+		break;
+	case 4:
+		if (psc_present)
+			psc_irq_enable(irq);
 		break;
 	case 8:
 		if (baboon_present)
@@ -316,15 +299,16 @@ void mac_disable_irq(unsigned int irq)
 			via_irq_disable(irq);
 		break;
 	case 3:
-	case 4:
 	case 5:
 	case 6:
 		if (psc_present)
 			psc_irq_disable(irq);
 		else if (oss_present)
 			oss_irq_disable(irq);
-		else if (irq_src == 4)
-			scc_irq_disable(irq);
+		break;
+	case 4:
+		if (psc_present)
+			psc_irq_disable(irq);
 		break;
 	case 8:
 		if (baboon_present)
@@ -347,7 +331,6 @@ void mac_clear_irq(unsigned int irq)
 			via_irq_clear(irq);
 		break;
 	case 3:
-	case 4:
 	case 5:
 	case 6:
 		if (psc_present)
@@ -355,6 +338,10 @@ void mac_clear_irq(unsigned int irq)
 		else if (oss_present)
 			oss_irq_clear(irq);
 		break;
+	case 4:
+		if (psc_present)
+			psc_irq_clear(irq);
+		break;
 	case 8:
 		if (baboon_present)
 			baboon_irq_clear(irq);
@@ -374,13 +361,17 @@ int mac_irq_pending(unsigned int irq)
 		else
 			return via_irq_pending(irq);
 	case 3:
-	case 4:
 	case 5:
 	case 6:
 		if (psc_present)
 			return psc_irq_pending(irq);
 		else if (oss_present)
 			return oss_irq_pending(irq);
+		break;
+	case 4:
+		if (psc_present)
+			psc_irq_pending(irq);
+		break;
 	}
 	return 0;
 }
@@ -448,59 +439,3 @@ irqreturn_t mac_nmi_handler(int irq, voi
 	in_nmi--;
 	return IRQ_HANDLED;
 }
-
-/*
- * Simple routines for masking and unmasking
- * SCC interrupts in cases where this can't be
- * done in hardware (only the PSC can do that.)
- */
-
-static void scc_irq_enable(unsigned int irq)
-{
-	int irq_idx = IRQ_IDX(irq);
-
-	scc_mask |= (1 << irq_idx);
-}
-
-static void scc_irq_disable(unsigned int irq)
-{
-	int irq_idx = IRQ_IDX(irq);
-
-	scc_mask &= ~(1 << irq_idx);
-}
-
-/*
- * SCC master interrupt handler. We have to do a bit of magic here
- * to figure out what channel gave us the interrupt; putting this
- * here is cleaner than hacking it into drivers/char/macserial.c.
- */
-
-void mac_scc_dispatch(int irq, void *dev_id)
-{
-	volatile unsigned char *scc = (unsigned char *) mac_bi_data.sccbase + 2;
-	unsigned char reg;
-	unsigned long flags;
-
-	/* Read RR3 from the chip. Always do this on channel A */
-	/* This must be an atomic operation so disable irqs.   */
-
-	local_irq_save(flags);
-	*scc = 3;
-	reg = *scc;
-	local_irq_restore(flags);
-
-	/* Now dispatch. Bits 0-2 are for channel B and */
-	/* bits 3-5 are for channel A. We can safely    */
-	/* ignore the remaining bits here.              */
-	/*                                              */
-	/* Note that we're ignoring scc_mask for now.   */
-	/* If we actually mask the ints then we tend to */
-	/* get hammered by very persistent SCC irqs,    */
-	/* and since they're autovector interrupts they */
-	/* pretty much kill the system.                 */
-
-	if (reg & 0x38)
-		m68k_handle_int(IRQ_SCCA);
-	if (reg & 0x07)
-		m68k_handle_int(IRQ_SCCB);
-}
Index: linux-2.6.31/arch/m68k/mac/oss.c
===================================================================
--- linux-2.6.31.orig/arch/m68k/mac/oss.c	2009-11-03 03:23:24.000000000 +1100
+++ linux-2.6.31/arch/m68k/mac/oss.c	2009-11-03 03:23:41.000000000 +1100
@@ -33,7 +33,6 @@ static irqreturn_t oss_irq(int, void *);
 static irqreturn_t oss_nubus_irq(int, void *);
 
 extern irqreturn_t via1_irq(int, void *);
-extern irqreturn_t mac_scc_dispatch(int, void *);
 
 /*
  * Initialize the OSS
@@ -69,9 +68,6 @@ void __init oss_register_interrupts(void
 	if (request_irq(OSS_IRQLEV_SCSI, oss_irq, IRQ_FLG_LOCK,
 			"scsi", (void *) oss))
 		pr_err("Couldn't register %s interrupt\n", "scsi");
-	if (request_irq(OSS_IRQLEV_IOPSCC, mac_scc_dispatch, IRQ_FLG_LOCK,
-			"scc", mac_scc_dispatch))
-		pr_err("Couldn't register %s interrupt\n", "scc");
 	if (request_irq(OSS_IRQLEV_NUBUS, oss_nubus_irq, IRQ_FLG_LOCK,
 			"nubus", (void *) oss))
 		pr_err("Couldn't register %s interrupt\n", "nubus");
@@ -172,9 +168,7 @@ void oss_irq_enable(int irq) {
 	printk("oss_irq_enable(%d)\n", irq);
 #endif
 	switch(irq) {
-		case IRQ_SCC:
-		case IRQ_SCCA:
-		case IRQ_SCCB:
+		case IRQ_MAC_SCC:
 			oss->irq_level[OSS_IOPSCC] = OSS_IRQLEV_IOPSCC;
 			break;
 		case IRQ_MAC_ADB:
@@ -212,9 +206,7 @@ void oss_irq_disable(int irq) {
 	printk("oss_irq_disable(%d)\n", irq);
 #endif
 	switch(irq) {
-		case IRQ_SCC:
-		case IRQ_SCCA:
-		case IRQ_SCCB:
+		case IRQ_MAC_SCC:
 			oss->irq_level[OSS_IOPSCC] = OSS_IRQLEV_DISABLED;
 			break;
 		case IRQ_MAC_ADB:
@@ -250,9 +242,7 @@ void oss_irq_disable(int irq) {
 void oss_irq_clear(int irq) {
 	/* FIXME: how to do this on OSS? */
 	switch(irq) {
-		case IRQ_SCC:
-		case IRQ_SCCA:
-		case IRQ_SCCB:
+		case IRQ_MAC_SCC:
 			oss->irq_pending &= ~OSS_IP_IOPSCC;
 			break;
 		case IRQ_MAC_ADB:
@@ -280,9 +270,7 @@ void oss_irq_clear(int irq) {
 int oss_irq_pending(int irq)
 {
 	switch(irq) {
-		case IRQ_SCC:
-		case IRQ_SCCA:
-		case IRQ_SCCB:
+		case IRQ_MAC_SCC:
 			return oss->irq_pending & OSS_IP_IOPSCC;
 			break;
 		case IRQ_MAC_ADB:
Index: linux-2.6.31/arch/m68k/mac/via.c
===================================================================
--- linux-2.6.31.orig/arch/m68k/mac/via.c	2009-11-03 03:23:24.000000000 +1100
+++ linux-2.6.31/arch/m68k/mac/via.c	2009-11-03 03:23:41.000000000 +1100
@@ -84,8 +84,6 @@ void via_irq_enable(int irq);
 void via_irq_disable(int irq);
 void via_irq_clear(int irq);
 
-extern irqreturn_t mac_scc_dispatch(int, void *);
-
 /*
  * Initialize the VIAs
  *
@@ -311,11 +309,6 @@ void __init via_register_interrupts(void
 	if (request_irq(IRQ_AUTO_2, via2_irq, IRQ_FLG_LOCK|IRQ_FLG_FAST,
 			"via2", (void *) via2))
 		pr_err("Couldn't register %s interrupt\n", "via2");
-	if (!psc_present) {
-		if (request_irq(IRQ_AUTO_4, mac_scc_dispatch, IRQ_FLG_LOCK,
-				"scc", mac_scc_dispatch))
-			pr_err("Couldn't register %s interrupt\n", "scc");
-	}
 	if (request_irq(IRQ_MAC_NUBUS, via_nubus_irq,
 			IRQ_FLG_LOCK|IRQ_FLG_FAST, "nubus", (void *) via2))
 		pr_err("Couldn't register %s interrupt\n", "nubus");
Index: linux-2.6.31/arch/m68k/mac/config.c
===================================================================
--- linux-2.6.31.orig/arch/m68k/mac/config.c	2009-11-03 03:23:41.000000000 +1100
+++ linux-2.6.31/arch/m68k/mac/config.c	2009-11-03 03:23:41.000000000 +1100
@@ -792,6 +792,32 @@ static struct mac_model mac_data_table[]
 	}
 };
 
+static struct resource scc_a_rsrcs[] = {
+	{ .flags = IORESOURCE_MEM },
+	{ .flags = IORESOURCE_IRQ },
+};
+
+static struct resource scc_b_rsrcs[] = {
+	{ .flags = IORESOURCE_MEM },
+	{ .flags = IORESOURCE_IRQ },
+};
+
+struct platform_device scc_a_pdev = {
+	.name           = "scc",
+	.id             = 0,
+	.num_resources  = ARRAY_SIZE(scc_a_rsrcs),
+	.resource       = scc_a_rsrcs,
+};
+EXPORT_SYMBOL(scc_a_pdev);
+
+struct platform_device scc_b_pdev = {
+	.name           = "scc",
+	.id             = 1,
+	.num_resources  = ARRAY_SIZE(scc_b_rsrcs),
+	.resource       = scc_b_rsrcs,
+};
+EXPORT_SYMBOL(scc_b_pdev);
+
 static void __init mac_identify(void)
 {
 	struct mac_model *m;
@@ -814,6 +840,24 @@ static void __init mac_identify(void)
 		}
 	}
 
+	/* Set up serial port resources for the console initcall. */
+
+	scc_a_rsrcs[0].start = (resource_size_t) mac_bi_data.sccbase + 2;
+	scc_a_rsrcs[0].end   = scc_a_rsrcs[0].start;
+	scc_b_rsrcs[0].start = (resource_size_t) mac_bi_data.sccbase;
+	scc_b_rsrcs[0].end   = scc_b_rsrcs[0].start;
+
+	switch (macintosh_config->scc_type) {
+	case MAC_SCC_PSC:
+		scc_a_rsrcs[1].start = scc_a_rsrcs[1].end = IRQ_MAC_SCC_A;
+		scc_b_rsrcs[1].start = scc_b_rsrcs[1].end = IRQ_MAC_SCC_B;
+		break;
+	default:
+		scc_a_rsrcs[1].start = scc_a_rsrcs[1].end = IRQ_MAC_SCC;
+		scc_b_rsrcs[1].start = scc_b_rsrcs[1].end = IRQ_MAC_SCC;
+		break;
+	}
+
 	/*
 	 * We need to pre-init the IOPs, if any. Otherwise
 	 * the serial console won't work if the user had
@@ -872,6 +916,13 @@ int __init mac_platform_init(void)
 	u8 *swim_base;
 
 	/*
+	 * Serial devices
+	 */
+
+	platform_device_register(&scc_a_pdev);
+	platform_device_register(&scc_b_pdev);
+
+	/*
 	 * Floppy device
 	 */
 
