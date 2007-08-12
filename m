Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 2C38EDDE3A
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 08:27:29 +1000 (EST)
Date: Mon, 13 Aug 2007 00:27:30 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-serial@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH, RFC] wake up from a serial port
Message-ID: <Pine.LNX.4.60.0708130015430.3895@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A number of Linkstation models from Buffalo Technology with PPC, ARM, and 
also MIPS (I think) CPUs have a power-management controller connected to a 
UART. Among other things that chip controlls power and reset buttons. 
Working on a standby support for one of these systems (ppc mpc8241 based), 
the only suitable wakeup source there is the power button, which means, I 
have to configure one of the two system UARTs to not be suspendsd. Using 
the device_*_wakeup API doesn't quite work because both serial ports share 
one device. The below patch proposes a new port flag UPF_MAY_WAKEUP to 
configure such UARTs. It also adds support for a new "can-wakeup" serial 
node property to the legacy_serial driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index cea8045..888d9bb 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -51,6 +51,9 @@ static int __init add_legacy_port(struct device_node *np, int want_index,
 	/* get default speed if present */
 	spd = of_get_property(np, "current-speed", NULL);
 
+	if (of_find_property(np, "can-wakeup", NULL))
+		flags |= UPF_MAY_WAKEUP;
+
 	/* If we have a location index, then try to use it */
 	if (want_index >= 0 && want_index < MAX_LEGACY_SERIAL_PORTS)
 		index = want_index;
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 0b3ec38..77dd552 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -130,6 +130,7 @@ struct uart_8250_port {
 	unsigned char		mcr_mask;	/* mask of user bits */
 	unsigned char		mcr_force;	/* mask of forced bits */
 	unsigned char		lsr_break_flag;
+	char			suspended;
 
 	/*
 	 * We provide a per-port pm hook.
@@ -2680,8 +2681,14 @@ static int serial8250_suspend(struct platform_device *dev, pm_message_t state)
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
-		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev)
-			uart_suspend_port(&serial8250_reg, &up->port);
+		if (up->port.type != PORT_UNKNOWN && up->port.dev == &dev->dev) {
+			if (up->port.flags & UPF_MAY_WAKEUP)
+				enable_irq_wake(up->port.irq);
+			else {
+				uart_suspend_port(&serial8250_reg, &up->port);
+				up->suspended = 1;
+			}
+		}
 	}
 
 	return 0;
@@ -2694,8 +2701,13 @@ static int serial8250_resume(struct platform_device *dev)
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
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 773d8d8..d585967 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -272,6 +272,7 @@ struct uart_port {
 #define UPF_LOW_LATENCY		((__force upf_t) (1 << 13))
 #define UPF_BUGGY_UART		((__force upf_t) (1 << 14))
 #define UPF_MAGIC_MULTIPLIER	((__force upf_t) (1 << 16))
+#define UPF_MAY_WAKEUP		((__force upf_t) (1 << 17))
 #define UPF_CONS_FLOW		((__force upf_t) (1 << 23))
 #define UPF_SHARE_IRQ		((__force upf_t) (1 << 24))
 #define UPF_BOOT_AUTOCONF	((__force upf_t) (1 << 28))
