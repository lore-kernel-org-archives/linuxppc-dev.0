Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/6] Only legacy ports should allow addr/irq changes via
	setserial
In-Reply-To: <20070504055455.GA25922@localhost.localdomain>
Message-Id: <20070504055733.54EA2DDFF7@ozlabs.org>
Date: Fri,  4 May 2007 15:57:33 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At present, the serial core always allows setserial in userspace to
change the port address, irq and base clock of any serial port.  That
makes sense for legacy ISA ports, but not for PCI serial ports or
(say) embedded ns16550 compatible serial ports at peculiar addresses.
In these cases, the kernel code configuring the ports must know
exactly where they are, and their clocking arrangements (which can be
unusual on embedded boards).  It doesn't make sense for userspace to
change these settings.

Therefore, this patch alters uart_set_info() to ignore attempts to
change a port's type, io address irq or base clock with setserial,
unless that port has a new UPF_SETSERIAL_MOVABLE flag set.  That flag
is set only on the ports associated with the serial8250_isa_devs
platform_device defined within 8250.c itself.

Signed-off-by: David Gibson <dwg@au1.ibm.com>
---

 drivers/serial/8250.c        |    3 ++-
 drivers/serial/serial_core.c |   22 +++++++++++++---------
 include/linux/serial_core.h  |    1 +
 3 files changed, 16 insertions(+), 10 deletions(-)

Index: working-2.6/drivers/serial/serial_core.c
===================================================================
--- working-2.6.orig/drivers/serial/serial_core.c	2007-02-19 11:05:32.000000000 +1100
+++ working-2.6/drivers/serial/serial_core.c	2007-05-03 15:04:12.000000000 +1000
@@ -646,6 +646,7 @@ static int uart_set_info(struct uart_sta
 	struct serial_struct new_serial;
 	struct uart_port *port = state->port;
 	unsigned long new_port;
+	int allow_hw_change = port->flags & UPF_SETSERIAL_MOVABLE;
 	unsigned int change_irq, change_port, closing_wait;
 	unsigned int old_custom_divisor, close_delay;
 	upf_t old_flags, new_flags;
@@ -672,19 +673,20 @@ static int uart_set_info(struct uart_sta
 	 */
 	mutex_lock(&state->mutex);
 
-	change_irq  = new_serial.irq != port->irq;
+	change_irq  = allow_hw_change && (new_serial.irq != port->irq);
 
 	/*
 	 * Since changing the 'type' of the port changes its resource
 	 * allocations, we should treat type changes the same as
 	 * IO port changes.
 	 */
-	change_port = new_port != port->iobase ||
-		      (unsigned long)new_serial.iomem_base != port->mapbase ||
-		      new_serial.hub6 != port->hub6 ||
-		      new_serial.io_type != port->iotype ||
-		      new_serial.iomem_reg_shift != port->regshift ||
-		      new_serial.type != port->type;
+	change_port = allow_hw_change &&
+		(new_port != port->iobase ||
+		 (unsigned long)new_serial.iomem_base != port->mapbase ||
+		 new_serial.hub6 != port->hub6 ||
+		 new_serial.io_type != port->iotype ||
+		 new_serial.iomem_reg_shift != port->regshift ||
+		 new_serial.type != port->type);
 
 	old_flags = port->flags;
 	new_flags = new_serial.flags;
@@ -796,8 +798,10 @@ static int uart_set_info(struct uart_sta
 		}
 	}
 
-	port->irq              = new_serial.irq;
-	port->uartclk          = new_serial.baud_base * 16;
+	if (change_irq)
+		port->irq      = new_serial.irq;
+	if (allow_hw_change)
+		port->uartclk  = new_serial.baud_base * 16;
 	port->flags            = (port->flags & ~UPF_CHANGE_MASK) |
 				 (new_flags & UPF_CHANGE_MASK);
 	port->custom_divisor   = new_serial.custom_divisor;
Index: working-2.6/include/linux/serial_core.h
===================================================================
--- working-2.6.orig/include/linux/serial_core.h	2007-02-19 11:05:32.000000000 +1100
+++ working-2.6/include/linux/serial_core.h	2007-05-03 15:04:08.000000000 +1000
@@ -260,6 +260,7 @@ struct uart_port {
 #define UPF_CONS_FLOW		((__force upf_t) (1 << 23))
 #define UPF_SHARE_IRQ		((__force upf_t) (1 << 24))
 #define UPF_BOOT_AUTOCONF	((__force upf_t) (1 << 28))
+#define UPF_SETSERIAL_MOVABLE	((__force upf_t) (1 << 29))
 #define UPF_DEAD		((__force upf_t) (1 << 30))
 #define UPF_IOREMAP		((__force upf_t) (1 << 31))
 
Index: working-2.6/drivers/serial/8250.c
===================================================================
--- working-2.6.orig/drivers/serial/8250.c	2007-04-30 10:57:48.000000000 +1000
+++ working-2.6/drivers/serial/8250.c	2007-05-03 15:04:08.000000000 +1000
@@ -2308,7 +2308,8 @@ static void __init serial8250_isa_init_p
 		up->port.iobase   = old_serial_port[i].port;
 		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
 		up->port.uartclk  = old_serial_port[i].baud_base * 16;
-		up->port.flags    = old_serial_port[i].flags;
+		up->port.flags    = old_serial_port[i].flags
+			| UPF_SETSERIAL_MOVABLE;
 		up->port.hub6     = old_serial_port[i].hub6;
 		up->port.membase  = old_serial_port[i].iomem_base;
 		up->port.iotype   = old_serial_port[i].io_type;
