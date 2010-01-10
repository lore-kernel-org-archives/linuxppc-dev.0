Return-Path: <fthain@telegraphics.com.au>
Received: from mail.telegraphics.com.au (www.telegraphics.com.au
	[204.15.192.19]) by ozlabs.org (Postfix) with ESMTP id D9345B7C15
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2010 03:29:54 +1100 (EST)
Date: Mon, 11 Jan 2010 03:29:53 +1100 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] pmac-zilog: add platform driver, version 3
In-Reply-To: <alpine.LNX.2.00.1001102340340.22574@nippy.intranet>
Message-ID: <alpine.OSX.2.00.1001110325430.620@localhost>
References: <alpine.OSX.2.00.0911171657290.371@silk.local>
	<10f740e81001071312p451de3c0r93d8d9d2782abde8@mail.gmail.com>
	<alpine.LNX.2.00.1001102340340.22574@nippy.intranet>
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

Add platform driver support to the pmac-zilog driver, for m68k macs.
Place the powermac-specific code inside #ifdef CONFIG_PPC_PMAC.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---

This patch should be applied after "[PATCH 3/13] pmac-zilog: cleanup".
It obsoletes "[PATCH 4/13] pmac-zilog, mac68k: replace mac68k SCC code
with platform device" listed in the linux-ppc patchwork.

Version 2 of this patch adopts Geert's suggestions: make better use of
dev_{dbg,err,info} macros, change platform_driver_register() to
platform_driver_probe(), and use __init and __exit attributes.
Version 3 does not #include <macints.h>.

 arch/m68k/configs/mac_defconfig   |    5 +
 arch/m68k/configs/multi_defconfig |    5 +
 drivers/serial/Kconfig            |   12 +-
 drivers/serial/pmac_zilog.c       |  157 +++++++++++++++++++++++++++++++++-----
 drivers/serial/pmac_zilog.h       |   14 +++
 5 files changed, 167 insertions(+), 26 deletions(-)

Index: linux-2.6.31/drivers/serial/Kconfig
===================================================================
--- linux-2.6.31.orig/drivers/serial/Kconfig	2010-01-10 23:38:58.000000000 +1100
+++ linux-2.6.31/drivers/serial/Kconfig	2010-01-10 23:39:02.000000000 +1100
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
Index: linux-2.6.31/arch/m68k/configs/mac_defconfig
===================================================================
--- linux-2.6.31.orig/arch/m68k/configs/mac_defconfig	2010-01-10 23:39:02.000000000 +1100
+++ linux-2.6.31/arch/m68k/configs/mac_defconfig	2010-01-10 23:39:02.000000000 +1100
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
Index: linux-2.6.31/arch/m68k/configs/multi_defconfig
===================================================================
--- linux-2.6.31.orig/arch/m68k/configs/multi_defconfig	2010-01-10 23:39:02.000000000 +1100
+++ linux-2.6.31/arch/m68k/configs/multi_defconfig	2010-01-10 23:39:02.000000000 +1100
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
Index: linux-2.6.31/drivers/serial/pmac_zilog.c
===================================================================
--- linux-2.6.31.orig/drivers/serial/pmac_zilog.c	2010-01-10 23:39:02.000000000 +1100
+++ linux-2.6.31/drivers/serial/pmac_zilog.c	2010-01-11 03:11:55.000000000 +1100
@@ -63,11 +63,17 @@
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
+#define machine_is_compatible(x) (0)
+#endif
 
 #if defined (CONFIG_SERIAL_PMACZILOG_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
@@ -83,11 +89,9 @@
 
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
@@ -341,7 +345,7 @@ static struct tty_struct *pmz_receive_ch
 	uap->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
 	write_zsreg(uap, R1, uap->curregs[R1]);
 	zssync(uap);
-	dev_err(&uap->dev->ofdev.dev, "pmz: rx irq flood !\n");
+	pmz_error("pmz: rx irq flood !\n");
 	return tty;
 }
 
@@ -746,6 +750,8 @@ static void pmz_break_ctl(struct uart_po
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
+#ifdef CONFIG_PPC_PMAC
+
 /*
  * Turn power on or off to the SCC and associated stuff
  * (port drivers, modem, IR port, etc.)
@@ -781,6 +787,15 @@ static int pmz_set_scc_power(struct uart
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
@@ -943,9 +958,9 @@ static int pmz_startup(struct uart_port 
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
@@ -1185,7 +1200,7 @@ static void pmz_irda_setup(struct uart_p
 	while ((read_zsreg(uap, R0) & Tx_BUF_EMP) == 0
 	       || (read_zsreg(uap, R1) & ALL_SNT) == 0) {
 		if (--t <= 0) {
-			dev_err(&uap->dev->ofdev.dev, "transmitter didn't drain\n");
+			pmz_error("transmitter didn't drain\n");
 			return;
 		}
 		udelay(10);
@@ -1201,7 +1216,7 @@ static void pmz_irda_setup(struct uart_p
 		read_zsdata(uap);
 		mdelay(10);
 		if (--t <= 0) {
-			dev_err(&uap->dev->ofdev.dev, "receiver didn't drain\n");
+			pmz_error("receiver didn't drain\n");
 			return;
 		}
 	}
@@ -1222,8 +1237,7 @@ static void pmz_irda_setup(struct uart_p
 	t = 5000;
 	while ((read_zsreg(uap, R0) & Rx_CH_AV) == 0) {
 		if (--t <= 0) {
-			dev_err(&uap->dev->ofdev.dev,
-				"irda_setup timed out on get_version byte\n");
+			pmz_error("irda_setup timed out on get_version byte\n");
 			goto out;
 		}
 		udelay(10);
@@ -1231,8 +1245,7 @@ static void pmz_irda_setup(struct uart_p
 	version = read_zsdata(uap);
 
 	if (version < 4) {
-		dev_info(&uap->dev->ofdev.dev, "IrDA: dongle version %d not supported\n",
-			 version);
+		pmz_info("IrDA: dongle version %d not supported\n", version);
 		goto out;
 	}
 
@@ -1241,19 +1254,17 @@ static void pmz_irda_setup(struct uart_p
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
@@ -1402,7 +1413,7 @@ static void pmz_poll_put_char(struct uar
 	write_zsdata(uap, c);
 }
 
-#endif
+#endif /* CONFIG_CONSOLE_POLL */
 
 static struct uart_ops pmz_pops = {
 	.tx_empty	=	pmz_tx_empty,
@@ -1427,6 +1438,8 @@ static struct uart_ops pmz_pops = {
 #endif
 };
 
+#ifdef CONFIG_PPC_PMAC
+
 /*
  * Setup one port structure after probing, HW is down at this point,
  * Unlike sunzilog, we don't need to pre-init the spinlock as we don't
@@ -1823,6 +1836,88 @@ next:
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
+static int __init pmz_attach(struct platform_device *pdev)
+{
+	int i;
+
+	for (i = 0; i < pmz_ports_count; i++)
+		if (pmz_ports[i].node == pdev)
+			return 0;
+	return -ENODEV;
+}
+
+static int __exit pmz_detach(struct platform_device *pdev)
+{
+	return 0;
+}
+
+#endif /* !CONFIG_PPC_PMAC */
+
 #ifdef CONFIG_SERIAL_PMACZILOG_CONSOLE
 
 static void pmz_console_write(struct console *con, const char *s, unsigned int count);
@@ -1883,6 +1978,8 @@ err_out:
 	return rc;
 }
 
+#ifdef CONFIG_PPC_PMAC
+
 static struct of_device_id pmz_match[] = 
 {
 	{
@@ -1904,6 +2001,18 @@ static struct macio_driver pmz_driver = 
 	.resume		= pmz_resume,
 };
 
+#else
+
+static struct platform_driver pmz_driver = {
+	.remove		= __exit_p(pmz_detach),
+	.driver		= {
+		.name		= "scc",
+		.owner		= THIS_MODULE,
+	},
+};
+
+#endif /* !CONFIG_PPC_PMAC */
+
 static int __init init_pmz(void)
 {
 	int rc, i;
@@ -1942,15 +2051,23 @@ static int __init init_pmz(void)
 	/*
 	 * Then we register the macio driver itself
 	 */
+#ifdef CONFIG_PPC_PMAC
 	return macio_register_driver(&pmz_driver);
+#else
+	return platform_driver_probe(&pmz_driver, pmz_attach);
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
--- linux-2.6.31.orig/drivers/serial/pmac_zilog.h	2010-01-10 23:39:02.000000000 +1100
+++ linux-2.6.31/drivers/serial/pmac_zilog.h	2010-01-10 23:39:02.000000000 +1100
@@ -1,7 +1,15 @@
 #ifndef __PMAC_ZILOG_H__
 #define __PMAC_ZILOG_H__
 
+#ifdef CONFIG_PPC_PMAC
 #define pmz_debug(fmt, arg...)	dev_dbg(&uap->dev->ofdev.dev, fmt, ## arg)
+#define pmz_error(fmt, arg...)	dev_err(&uap->dev->ofdev.dev, fmt, ## arg)
+#define pmz_info(fmt, arg...)	dev_info(&uap->dev->ofdev.dev, fmt, ## arg)
+#else
+#define pmz_debug(fmt, arg...)	dev_dbg(&uap->node->dev, fmt, ## arg)
+#define pmz_error(fmt, arg...)	dev_err(&uap->node->dev, fmt, ## arg)
+#define pmz_info(fmt, arg...)	dev_info(&uap->node->dev, fmt, ## arg)
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
