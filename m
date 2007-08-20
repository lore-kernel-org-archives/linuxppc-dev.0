Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id ED1BDDDDFB
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 07:53:49 +1000 (EST)
Date: Mon, 20 Aug 2007 23:53:36 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH, RFC] wake up from a serial port
In-Reply-To: <20070813222858.GA16748@kroah.com>
Message-ID: <Pine.LNX.4.60.0708202342060.4694@poirot.grange>
References: <Pine.LNX.4.60.0708130015430.3895@poirot.grange>
	<20070813155734.GB17535@ld0162-tx32.am.freescale.net>
	<Pine.LNX.4.60.0708132207530.5643@poirot.grange>
	<46C0C419.6060009@freescale.com>
	<Pine.LNX.4.60.0708132307200.5643@poirot.grange>
	<20070813222858.GA16748@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Enable wakeup from serial ports, make it run-time configurable over sysfs, 
e.g.,

echo enabled > /sys/devices/platform/serial8250.0/tty/ttyS0/power/wakeup

Requires

# CONFIG_SYSFS_DEPRECATED is not set

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

---

(I still find it strange having to put a formal patch description above 
and its discussion below, anyway)

On Mon, 13 Aug 2007, Greg KH wrote:

> So, the serial8250 device is the "bridge" for the 4 different serial
> ports in my machine.  You have the tty:ttyS? symlinks in that directory
> as you have CONFIG_SYSFS_DEPRECATED still enabled, but the directory
> structure should all still be the same for you.
> 
> So, if you want to put things into the tty device's directory, you can,
> they will just show up in the proper place, under
> /sys/devices/platform/serial8250/tty/ttyS0 for the first serial port.
> 
> Does that make sense?

I think it does... Following this, and a suggestion from Scott to switch 
wakeup-enable on and off at run-time over sysfs, here's another attempt... 
Well, easy to see I'm out in the wild here in this area (pm/sysfs/tty), 
so, this might well be way off... Please, comment.

Thanks
Guennadi

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 0b3ec38..5118914 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -130,6 +130,7 @@ struct uart_8250_port {
 	unsigned char		mcr_mask;	/* mask of user bits */
 	unsigned char		mcr_force;	/* mask of forced bits */
 	unsigned char		lsr_break_flag;
+	char			suspended;
 
 	/*
 	 * We provide a per-port pm hook.
@@ -2673,6 +2674,14 @@ static int __devexit serial8250_remove(struct platform_device *dev)
 	return 0;
 }
 
+static int serial8250_match_port(struct device *dev, void *data)
+{
+	struct uart_port *port = data;
+	dev_t devt = MKDEV(serial8250_reg.major, serial8250_reg.minor) + port->line;
+
+	return dev->devt == devt; /* Actually, only one tty per port */
+}
+
 static int serial8250_suspend(struct platform_device *dev, pm_message_t state)
 {
 	int i;
@@ -2680,8 +2689,16 @@ static int serial8250_suspend(struct platform_device *dev, pm_message_t state)
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
-		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
-			uart_suspend_port(&serial8250_reg, &up->port);
+		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev) {
+			struct device *tty_dev = device_find_child(up->port.dev, &up->port,
+								   serial8250_match_port);
+			if (device_may_wakeup(tty_dev))
+				enable_irq_wake(up->port.irq);
+			else {
+				uart_suspend_port(&serial8250_reg, &up->port);
+				up->suspended = 1;
+			}
+		}
 	}
 
 	return 0;
@@ -2694,8 +2711,13 @@ static int serial8250_resume(struct platform_device *dev)
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
-		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
-			serial8250_resume_port(i);
+		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev) {
+			if (up->suspended) {
+				serial8250_resume_port(i);
+				up->suspended = 0;
+			} else
+				disable_irq_wake(up->port.irq);
+		}
 	}
 
 	return 0;
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 9c57486..716fbe2 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2266,6 +2266,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *port)
 {
 	struct uart_state *state;
 	int ret = 0;
+	struct device *tty_dev;
 
 	BUG_ON(in_interrupt());
 
@@ -2301,7 +2302,13 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *port)
 	 * Register the port whether it's detected or not.  This allows
 	 * setserial to be used to alter this ports parameters.
 	 */
-	tty_register_device(drv->tty_driver, port->line, port->dev);
+	tty_dev = tty_register_device(drv->tty_driver, port->line, port->dev);
+	if (likely(!IS_ERR(tty_dev))) {
+		device_can_wakeup(tty_dev) = 1;
+		device_set_wakeup_enable(tty_dev, 0);
+	} else
+		printk(KERN_ERR "Cannot register tty device on line %d\n",
+		       port->line);
 
 	/*
 	 * If this driver supports console, and it hasn't been
