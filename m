Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 903481A0272
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 02:49:04 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Benjamin Krill <ben@codiert.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/6] serial: remove NWP serial support
Date: Mon, 16 Nov 2015 16:48:12 +0100
Message-Id: <1447688894-2936779-5-git-send-email-arnd@arndb.de>
In-Reply-To: <1447688894-2936779-1-git-send-email-arnd@arndb.de>
References: <1447688894-2936779-1-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The NWP serial driver is no longer needed, as the two users of
this hardware have migrated to a much faster generation hardware,
see https://en.wikipedia.org/wiki/QPACE2 for the replacement.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Krill <ben@codiert.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/tty/serial/Kconfig       |  19 +-
 drivers/tty/serial/Makefile      |   1 -
 drivers/tty/serial/nwpserial.c   | 477 ---------------------------------------
 drivers/tty/serial/of_serial.c   |  14 --
 include/linux/nwpserial.h        |  18 --
 include/uapi/linux/serial_core.h |   2 +-
 6 files changed, 2 insertions(+), 529 deletions(-)
 delete mode 100644 drivers/tty/serial/nwpserial.c
 delete mode 100644 include/linux/nwpserial.h

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index dbb8ac6afd40..a9c2200fd528 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1097,7 +1097,7 @@ config SERIAL_NETX_CONSOLE
 config SERIAL_OF_PLATFORM
 	tristate "Serial port on Open Firmware platform bus"
 	depends on OF
-	depends on SERIAL_8250 || SERIAL_OF_PLATFORM_NWPSERIAL
+	depends on SERIAL_8250
 	help
 	  If you have a PowerPC based system that has serial ports
 	  on a platform specific bus, you should enable this option.
@@ -1131,23 +1131,6 @@ config SERIAL_OMAP_CONSOLE
 	  your boot loader about how to pass options to the kernel at
 	  boot time.)
 
-config SERIAL_OF_PLATFORM_NWPSERIAL
-	tristate "NWP serial port driver"
-	depends on PPC_DCR
-	select SERIAL_OF_PLATFORM
-	select SERIAL_CORE_CONSOLE
-	select SERIAL_CORE
-	help
-	  This driver supports the cell network processor nwp serial
-	  device.
-
-config SERIAL_OF_PLATFORM_NWPSERIAL_CONSOLE
-	bool "Console on NWP serial port"
-	depends on SERIAL_OF_PLATFORM_NWPSERIAL=y
-	select SERIAL_CORE_CONSOLE
-	help
-	  Support for Console on the NWP serial ports.
-
 config SERIAL_LANTIQ
 	bool "Lantiq serial driver"
 	depends on LANTIQ
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 5ab41119b3dc..ee8893317433 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -64,7 +64,6 @@ obj-$(CONFIG_SERIAL_UARTLITE) += uartlite.o
 obj-$(CONFIG_SERIAL_MSM) += msm_serial.o
 obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM) += of_serial.o
-obj-$(CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL) += nwpserial.o
 obj-$(CONFIG_SERIAL_KGDB_NMI) += kgdb_nmi.o
 obj-$(CONFIG_SERIAL_KS8695) += serial_ks8695.o
 obj-$(CONFIG_SERIAL_OMAP) += omap-serial.o
diff --git a/drivers/tty/serial/nwpserial.c b/drivers/tty/serial/nwpserial.c
deleted file mode 100644
index 5da7622e88c3..000000000000
--- a/drivers/tty/serial/nwpserial.c
+++ /dev/null
@@ -1,477 +0,0 @@
-/*
- *  Serial Port driver for a NWP uart device
- *
- *    Copyright (C) 2008 IBM Corp., Benjamin Krill <ben@codiert.org>
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- *
- */
-#include <linux/init.h>
-#include <linux/export.h>
-#include <linux/console.h>
-#include <linux/serial.h>
-#include <linux/serial_reg.h>
-#include <linux/serial_core.h>
-#include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/irqreturn.h>
-#include <linux/mutex.h>
-#include <linux/of_platform.h>
-#include <linux/of_device.h>
-#include <linux/nwpserial.h>
-#include <linux/delay.h>
-#include <asm/prom.h>
-#include <asm/dcr.h>
-
-#define NWPSERIAL_NR               2
-
-#define NWPSERIAL_STATUS_RXVALID 0x1
-#define NWPSERIAL_STATUS_TXFULL  0x2
-
-struct nwpserial_port {
-	struct uart_port port;
-	dcr_host_t dcr_host;
-	unsigned int ier;
-	unsigned int mcr;
-};
-
-static DEFINE_MUTEX(nwpserial_mutex);
-static struct nwpserial_port nwpserial_ports[NWPSERIAL_NR];
-
-static void wait_for_bits(struct nwpserial_port *up, int bits)
-{
-	unsigned int status, tmout = 10000;
-
-	/* Wait up to 10ms for the character(s) to be sent. */
-	do {
-		status = dcr_read(up->dcr_host, UART_LSR);
-
-		if (--tmout == 0)
-			break;
-		udelay(1);
-	} while ((status & bits) != bits);
-}
-
-#ifdef CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL_CONSOLE
-static void nwpserial_console_putchar(struct uart_port *port, int c)
-{
-	struct nwpserial_port *up;
-	up = container_of(port, struct nwpserial_port, port);
-	/* check if tx buffer is full */
-	wait_for_bits(up, UART_LSR_THRE);
-	dcr_write(up->dcr_host, UART_TX, c);
-	up->port.icount.tx++;
-}
-
-static void
-nwpserial_console_write(struct console *co, const char *s, unsigned int count)
-{
-	struct nwpserial_port *up = &nwpserial_ports[co->index];
-	unsigned long flags;
-	int locked = 1;
-
-	if (oops_in_progress)
-		locked = spin_trylock_irqsave(&up->port.lock, flags);
-	else
-		spin_lock_irqsave(&up->port.lock, flags);
-
-	/* save and disable interrupt */
-	up->ier = dcr_read(up->dcr_host, UART_IER);
-	dcr_write(up->dcr_host, UART_IER, up->ier & ~UART_IER_RDI);
-
-	uart_console_write(&up->port, s, count, nwpserial_console_putchar);
-
-	/* wait for transmitter to become empty */
-	while ((dcr_read(up->dcr_host, UART_LSR) & UART_LSR_THRE) == 0)
-		cpu_relax();
-
-	/* restore interrupt state */
-	dcr_write(up->dcr_host, UART_IER, up->ier);
-
-	if (locked)
-		spin_unlock_irqrestore(&up->port.lock, flags);
-}
-
-static struct uart_driver nwpserial_reg;
-static struct console nwpserial_console = {
-	.name		= "ttySQ",
-	.write		= nwpserial_console_write,
-	.device		= uart_console_device,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &nwpserial_reg,
-};
-#define NWPSERIAL_CONSOLE	(&nwpserial_console)
-#else
-#define NWPSERIAL_CONSOLE	NULL
-#endif /* CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL_CONSOLE */
-
-/**************************************************************************/
-
-static int nwpserial_request_port(struct uart_port *port)
-{
-	return 0;
-}
-
-static void nwpserial_release_port(struct uart_port *port)
-{
-	/* N/A */
-}
-
-static void nwpserial_config_port(struct uart_port *port, int flags)
-{
-	port->type = PORT_NWPSERIAL;
-}
-
-static irqreturn_t nwpserial_interrupt(int irq, void *dev_id)
-{
-	struct nwpserial_port *up = dev_id;
-	struct tty_port *port = &up->port.state->port;
-	irqreturn_t ret;
-	unsigned int iir;
-	unsigned char ch;
-
-	spin_lock(&up->port.lock);
-
-	/* check if the uart was the interrupt source. */
-	iir = dcr_read(up->dcr_host, UART_IIR);
-	if (!iir) {
-		ret = IRQ_NONE;
-		goto out;
-	}
-
-	do {
-		up->port.icount.rx++;
-		ch = dcr_read(up->dcr_host, UART_RX);
-		if (up->port.ignore_status_mask != NWPSERIAL_STATUS_RXVALID)
-			tty_insert_flip_char(port, ch, TTY_NORMAL);
-	} while (dcr_read(up->dcr_host, UART_LSR) & UART_LSR_DR);
-
-	spin_unlock(&up->port.lock);
-	tty_flip_buffer_push(port);
-	spin_lock(&up->port.lock);
-
-	ret = IRQ_HANDLED;
-
-	/* clear interrupt */
-	dcr_write(up->dcr_host, UART_IIR, 1);
-out:
-	spin_unlock(&up->port.lock);
-	return ret;
-}
-
-static int nwpserial_startup(struct uart_port *port)
-{
-	struct nwpserial_port *up;
-	int err;
-
-	up = container_of(port, struct nwpserial_port, port);
-
-	/* disable flow control by default */
-	up->mcr = dcr_read(up->dcr_host, UART_MCR) & ~UART_MCR_AFE;
-	dcr_write(up->dcr_host, UART_MCR, up->mcr);
-
-	/* register interrupt handler */
-	err = request_irq(up->port.irq, nwpserial_interrupt,
-			IRQF_SHARED, "nwpserial", up);
-	if (err)
-		return err;
-
-	/* enable interrupts */
-	up->ier = UART_IER_RDI;
-	dcr_write(up->dcr_host, UART_IER, up->ier);
-
-	/* enable receiving */
-	up->port.ignore_status_mask &= ~NWPSERIAL_STATUS_RXVALID;
-
-	return 0;
-}
-
-static void nwpserial_shutdown(struct uart_port *port)
-{
-	struct nwpserial_port *up;
-	up = container_of(port, struct nwpserial_port, port);
-
-	/* disable receiving */
-	up->port.ignore_status_mask |= NWPSERIAL_STATUS_RXVALID;
-
-	/* disable interrupts from this port */
-	up->ier = 0;
-	dcr_write(up->dcr_host, UART_IER, up->ier);
-
-	/* free irq */
-	free_irq(up->port.irq, up);
-}
-
-static int nwpserial_verify_port(struct uart_port *port,
-			struct serial_struct *ser)
-{
-	return -EINVAL;
-}
-
-static const char *nwpserial_type(struct uart_port *port)
-{
-	return port->type == PORT_NWPSERIAL ? "nwpserial" : NULL;
-}
-
-static void nwpserial_set_termios(struct uart_port *port,
-			struct ktermios *termios, struct ktermios *old)
-{
-	struct nwpserial_port *up;
-	up = container_of(port, struct nwpserial_port, port);
-
-	up->port.read_status_mask = NWPSERIAL_STATUS_RXVALID
-				| NWPSERIAL_STATUS_TXFULL;
-
-	up->port.ignore_status_mask = 0;
-	/* ignore all characters if CREAD is not set */
-	if ((termios->c_cflag & CREAD) == 0)
-		up->port.ignore_status_mask |= NWPSERIAL_STATUS_RXVALID;
-
-	/* Copy back the old hardware settings */
-	if (old)
-		tty_termios_copy_hw(termios, old);
-}
-
-static void nwpserial_break_ctl(struct uart_port *port, int ctl)
-{
-	/* N/A */
-}
-
-static void nwpserial_stop_rx(struct uart_port *port)
-{
-	struct nwpserial_port *up;
-	up = container_of(port, struct nwpserial_port, port);
-	/* don't forward any more data (like !CREAD) */
-	up->port.ignore_status_mask = NWPSERIAL_STATUS_RXVALID;
-}
-
-static void nwpserial_putchar(struct nwpserial_port *up, unsigned char c)
-{
-	/* check if tx buffer is full */
-	wait_for_bits(up, UART_LSR_THRE);
-	dcr_write(up->dcr_host, UART_TX, c);
-	up->port.icount.tx++;
-}
-
-static void nwpserial_start_tx(struct uart_port *port)
-{
-	struct nwpserial_port *up;
-	struct circ_buf *xmit;
-	up = container_of(port, struct nwpserial_port, port);
-	xmit  = &up->port.state->xmit;
-
-	if (port->x_char) {
-		nwpserial_putchar(up, up->port.x_char);
-		port->x_char = 0;
-	}
-
-	while (!(uart_circ_empty(xmit) || uart_tx_stopped(&up->port))) {
-		nwpserial_putchar(up, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE-1);
-	}
-}
-
-static unsigned int nwpserial_get_mctrl(struct uart_port *port)
-{
-	return 0;
-}
-
-static void nwpserial_set_mctrl(struct uart_port *port, unsigned int mctrl)
-{
-	/* N/A */
-}
-
-static void nwpserial_stop_tx(struct uart_port *port)
-{
-	/* N/A */
-}
-
-static unsigned int nwpserial_tx_empty(struct uart_port *port)
-{
-	struct nwpserial_port *up;
-	unsigned long flags;
-	int ret;
-	up = container_of(port, struct nwpserial_port, port);
-
-	spin_lock_irqsave(&up->port.lock, flags);
-	ret = dcr_read(up->dcr_host, UART_LSR);
-	spin_unlock_irqrestore(&up->port.lock, flags);
-
-	return ret & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
-}
-
-static struct uart_ops nwpserial_pops = {
-	.tx_empty     = nwpserial_tx_empty,
-	.set_mctrl    = nwpserial_set_mctrl,
-	.get_mctrl    = nwpserial_get_mctrl,
-	.stop_tx      = nwpserial_stop_tx,
-	.start_tx     = nwpserial_start_tx,
-	.stop_rx      = nwpserial_stop_rx,
-	.break_ctl    = nwpserial_break_ctl,
-	.startup      = nwpserial_startup,
-	.shutdown     = nwpserial_shutdown,
-	.set_termios  = nwpserial_set_termios,
-	.type         = nwpserial_type,
-	.release_port = nwpserial_release_port,
-	.request_port = nwpserial_request_port,
-	.config_port  = nwpserial_config_port,
-	.verify_port  = nwpserial_verify_port,
-};
-
-static struct uart_driver nwpserial_reg = {
-	.owner       = THIS_MODULE,
-	.driver_name = "nwpserial",
-	.dev_name    = "ttySQ",
-	.major       = TTY_MAJOR,
-	.minor       = 68,
-	.nr          = NWPSERIAL_NR,
-	.cons        = NWPSERIAL_CONSOLE,
-};
-
-int nwpserial_register_port(struct uart_port *port)
-{
-	struct nwpserial_port *up = NULL;
-	int ret = -1;
-	int i;
-	static int first = 1;
-	int dcr_len;
-	int dcr_base;
-	struct device_node *dn;
-
-	mutex_lock(&nwpserial_mutex);
-
-	dn = port->dev->of_node;
-	if (dn == NULL)
-		goto out;
-
-	/* get dcr base. */
-	dcr_base = dcr_resource_start(dn, 0);
-
-	/* find matching entry */
-	for (i = 0; i < NWPSERIAL_NR; i++)
-		if (nwpserial_ports[i].port.iobase == dcr_base) {
-			up = &nwpserial_ports[i];
-			break;
-		}
-
-	/* we didn't find a mtching entry, search for a free port */
-	if (up == NULL)
-		for (i = 0; i < NWPSERIAL_NR; i++)
-			if (nwpserial_ports[i].port.type == PORT_UNKNOWN &&
-				nwpserial_ports[i].port.iobase == 0) {
-				up = &nwpserial_ports[i];
-				break;
-			}
-
-	if (up == NULL) {
-		ret = -EBUSY;
-		goto out;
-	}
-
-	if (first)
-		uart_register_driver(&nwpserial_reg);
-	first = 0;
-
-	up->port.membase      = port->membase;
-	up->port.irq          = port->irq;
-	up->port.uartclk      = port->uartclk;
-	up->port.fifosize     = port->fifosize;
-	up->port.regshift     = port->regshift;
-	up->port.iotype       = port->iotype;
-	up->port.flags        = port->flags;
-	up->port.mapbase      = port->mapbase;
-	up->port.private_data = port->private_data;
-
-	if (port->dev)
-		up->port.dev = port->dev;
-
-	if (up->port.iobase != dcr_base) {
-		up->port.ops          = &nwpserial_pops;
-		up->port.fifosize     = 16;
-
-		spin_lock_init(&up->port.lock);
-
-		up->port.iobase = dcr_base;
-		dcr_len = dcr_resource_len(dn, 0);
-
-		up->dcr_host = dcr_map(dn, dcr_base, dcr_len);
-		if (!DCR_MAP_OK(up->dcr_host)) {
-			printk(KERN_ERR "Cannot map DCR resources for NWPSERIAL");
-			goto out;
-		}
-	}
-
-	ret = uart_add_one_port(&nwpserial_reg, &up->port);
-	if (ret == 0)
-		ret = up->port.line;
-
-out:
-	mutex_unlock(&nwpserial_mutex);
-
-	return ret;
-}
-EXPORT_SYMBOL(nwpserial_register_port);
-
-void nwpserial_unregister_port(int line)
-{
-	struct nwpserial_port *up = &nwpserial_ports[line];
-	mutex_lock(&nwpserial_mutex);
-	uart_remove_one_port(&nwpserial_reg, &up->port);
-
-	up->port.type = PORT_UNKNOWN;
-
-	mutex_unlock(&nwpserial_mutex);
-}
-EXPORT_SYMBOL(nwpserial_unregister_port);
-
-#ifdef CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL_CONSOLE
-static int __init nwpserial_console_init(void)
-{
-	struct nwpserial_port *up = NULL;
-	struct device_node *dn;
-	const char *name;
-	int dcr_base;
-	int dcr_len;
-	int i;
-
-	/* search for a free port */
-	for (i = 0; i < NWPSERIAL_NR; i++)
-		if (nwpserial_ports[i].port.type == PORT_UNKNOWN) {
-			up = &nwpserial_ports[i];
-			break;
-		}
-
-	if (up == NULL)
-		return -1;
-
-	name = of_get_property(of_chosen, "linux,stdout-path", NULL);
-	if (name == NULL)
-		return -1;
-
-	dn = of_find_node_by_path(name);
-	if (!dn)
-		return -1;
-
-	spin_lock_init(&up->port.lock);
-	up->port.ops = &nwpserial_pops;
-	up->port.type = PORT_NWPSERIAL;
-	up->port.fifosize = 16;
-
-	dcr_base = dcr_resource_start(dn, 0);
-	dcr_len = dcr_resource_len(dn, 0);
-	up->port.iobase = dcr_base;
-
-	up->dcr_host = dcr_map(dn, dcr_base, dcr_len);
-	if (!DCR_MAP_OK(up->dcr_host)) {
-		printk("Cannot map DCR resources for SERIAL");
-		return -1;
-	}
-	register_console(&nwpserial_console);
-	return 0;
-}
-console_initcall(nwpserial_console_init);
-#endif /* CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL_CONSOLE */
diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index de5029649795..276c804e7eb4 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -213,11 +213,6 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 		break;
 	}
 #endif
-#ifdef CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL
-	case PORT_NWPSERIAL:
-		ret = nwpserial_register_port(&port);
-		break;
-#endif
 	default:
 		/* need to add code for these */
 	case PORT_UNKNOWN:
@@ -250,11 +245,6 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
 		serial8250_unregister_port(info->line);
 		break;
 #endif
-#ifdef CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL
-	case PORT_NWPSERIAL:
-		nwpserial_unregister_port(info->line);
-		break;
-#endif
 	default:
 		/* need to add code for these */
 		break;
@@ -353,10 +343,6 @@ static const struct of_device_id of_platform_serial_table[] = {
 		.data = (void *)PORT_XSCALE, },
 	{ .compatible = "mrvl,pxa-uart",
 		.data = (void *)PORT_XSCALE, },
-#ifdef CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL
-	{ .compatible = "ibm,qpace-nwp-serial",
-		.data = (void *)PORT_NWPSERIAL, },
-#endif
 	{ /* end of list */ },
 };
 MODULE_DEVICE_TABLE(of, of_platform_serial_table);
diff --git a/include/linux/nwpserial.h b/include/linux/nwpserial.h
deleted file mode 100644
index 9acb21572eaf..000000000000
--- a/include/linux/nwpserial.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- *  Serial Port driver for a NWP uart device
- *
- *    Copyright (C) 2008 IBM Corp., Benjamin Krill <ben@codiert.org>
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- *
- */
-#ifndef _NWPSERIAL_H
-#define _NWPSERIAL_H
-
-int nwpserial_register_port(struct uart_port *port);
-void nwpserial_unregister_port(int line);
-
-#endif /* _NWPSERIAL_H */
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 93ba148f923e..3e5d757407fb 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -176,7 +176,7 @@
 
 #define PORT_S3C6400	84
 
-/* NWPSERIAL */
+/* NWPSERIAL, now removed */
 #define PORT_NWPSERIAL	85
 
 /* MAX3100 */
-- 
2.1.0.rc2
