Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4E254B6F75
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 10:47:47 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: gregkh@suse.de, alan@linux.intel.com, galak@kernel.crashing.org,
 scottwood@freescale.com
Subject: [PATCH 2/3] serial: allow passing in hardware bug info via platform
 device
Date: Thu,  1 Dec 2011 18:47:37 -0500
Message-Id: <1322783258-20443-3-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com>
References: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The normal arch hook into the 8250 serial world is via passing
in a plat_serial8250_port struct.  However, this struct does
not have a bugs field, so there is no way to have the arch
code pass in info about known uart issues.

Add a bug field to the plat_serial8250_port struct, so that the
arch can pass in this information.  Also don't do a blanket
overwrite of the bugs setting in the 8250.c driver.  Finally,
relocate the known bug #define list to a globally visible header
so that the arch can assign any appropriate values from the list.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/8250.c   |    3 ++-
 drivers/tty/serial/8250.h   |    5 -----
 include/linux/serial_8250.h |    6 ++++++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 7c94dbc..f99f27c 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -1101,7 +1101,6 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 	spin_lock_irqsave(&up->port.lock, flags);
 
 	up->capabilities = 0;
-	up->port.bugs = 0;
 
 	if (!(up->port.flags & UPF_BUGGY_UART)) {
 		/*
@@ -3075,6 +3074,7 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 		port.serial_out		= p->serial_out;
 		port.handle_irq		= p->handle_irq;
 		port.set_termios	= p->set_termios;
+		port.bugs		= p->bugs;
 		port.pm			= p->pm;
 		port.dev		= &dev->dev;
 		port.irqflags		|= irqflag;
@@ -3225,6 +3225,7 @@ int serial8250_register_port(struct uart_port *port)
 		uart->port.regshift     = port->regshift;
 		uart->port.iotype       = port->iotype;
 		uart->port.flags        = port->flags | UPF_BOOT_AUTOCONF;
+		uart->port.bugs         = port->bugs;
 		uart->port.mapbase      = port->mapbase;
 		uart->port.private_data = port->private_data;
 		if (port->dev)
diff --git a/drivers/tty/serial/8250.h b/drivers/tty/serial/8250.h
index 6edf4a6..caefe00 100644
--- a/drivers/tty/serial/8250.h
+++ b/drivers/tty/serial/8250.h
@@ -44,11 +44,6 @@ struct serial8250_config {
 #define UART_CAP_UUE	(1 << 12)	/* UART needs IER bit 6 set (Xscale) */
 #define UART_CAP_RTOIE	(1 << 13)	/* UART needs IER bit 4 set (Xscale, Tegra) */
 
-#define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
-#define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
-#define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
-#define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE reassertion */
-
 #define PROBE_RSA	(1 << 0)
 #define PROBE_ANY	(~0)
 
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 1f05bbe..8c660af 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -14,6 +14,11 @@
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
 
+#define UART_BUG_QUOT	(1 << 0)	/* buggy quot LSB */
+#define UART_BUG_TXEN	(1 << 1)	/* buggy TX IIR status */
+#define UART_BUG_NOMSR	(1 << 2)	/* buggy MSR status bits (Au1x00) */
+#define UART_BUG_THRE	(1 << 3)	/* buggy THRE reassertion */
+
 /*
  * This is the platform device platform_data structure
  */
@@ -30,6 +35,7 @@ struct plat_serial8250_port {
 	unsigned char	hub6;
 	upf_t		flags;		/* UPF_* flags */
 	unsigned int	type;		/* If UPF_FIXED_TYPE */
+	unsigned short	bugs;		/* hardware specific bugs */
 	unsigned int	(*serial_in)(struct uart_port *, int);
 	void		(*serial_out)(struct uart_port *, int, int);
 	void		(*set_termios)(struct uart_port *,
-- 
1.7.7
