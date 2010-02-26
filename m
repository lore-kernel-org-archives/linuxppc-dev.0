Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 70A50B7D4C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Feb 2010 07:32:23 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] 8250: add workaround for MPC8[356]xx UART break IRQ storm
Date: Fri, 26 Feb 2010 14:25:01 -0500
Message-Id: <1267212301-26851-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sending a break on the SOC UARTs found in some MPC83xx/85xx/86xx
chips seems to cause a short lived IRQ storm (/proc/interrupts
typically shows somewhere between 300 and 1500 events).  Unfortunately
this renders SysRQ over the serial console completely inoperable.
Testing with obvious things like ACKing the event doesn't seem to
change anything vs. a completely dumb approach of just ignoring
it and waiting for it to stop, so that is what is implemented here.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

This is a refresh of a patch I'd done earlier -- I've tried to make
the bug support as generic as possible to minimize having board
specific ifdef crap in 8250.c -- any suggestions on how to further
improve it are welcome.

 drivers/serial/8250.c      |    6 ++++++
 drivers/serial/8250.h      |   20 ++++++++++++++++++++
 drivers/serial/Kconfig     |   14 ++++++++++++++
 include/linux/serial_reg.h |    2 ++
 4 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index e9b15c3..850b0e9 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1531,6 +1531,11 @@ static void serial8250_handle_port(struct uart_8250_port *up)
 
 	status = serial_inp(up, UART_LSR);
 
+	if ((up->bugs & UART_BUG_PPC) && (status == UART_LSR_RFE_ERROR_BITS)) {
+		spin_unlock_irqrestore(&up->port.lock, flags);
+		return;
+	}
+
 	DEBUG_INTR("status = %x...", status);
 
 	if (status & (UART_LSR_DR | UART_LSR_BI))
@@ -1948,6 +1953,7 @@ static int serial8250_startup(struct uart_port *port)
 
 	up->capabilities = uart_config[up->port.type].flags;
 	up->mcr = 0;
+	up->bugs |= UART_KNOWN_BUGS;
 
 	if (up->port.iotype != up->cur_iotype)
 		set_io_from_upio(port);
diff --git a/drivers/serial/8250.h b/drivers/serial/8250.h
index 6e19ea3..2074ce1 100644
--- a/drivers/serial/8250.h
+++ b/drivers/serial/8250.h
@@ -49,6 +49,7 @@ struct serial8250_config {
 #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
 #define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
 #define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE reassertion */
+#define UART_BUG_PPC	(1 << 4)	/* UART has buggy PPC break IRQ storm */
 
 #define PROBE_RSA	(1 << 0)
 #define PROBE_ANY	(~0)
@@ -78,3 +79,22 @@ struct serial8250_config {
 #else
 #define ALPHA_KLUDGE_MCR 0
 #endif
+
+/*
+ * The following UART bugs are currently dynamically detected and not
+ * required to be contingent on any particular compile time options.
+ */
+#define HAS_BUG_QUOT	0	/* assign UART_BUG_QUOT to enable */
+#define HAS_BUG_TXEN	0	/* assign UART_BUG_TXEN to enable */
+#define HAS_BUG_NOMSR	0	/* assign UART_BUG_NOMSR to enable */
+#define HAS_BUG_THRE	0	/* assign UART_BUG_THRE to enable */
+
+#ifdef CONFIG_SERIAL_8250_PPC_BUG
+#define HAS_BUG_PPC	UART_BUG_PPC
+#else
+#define HAS_BUG_PPC	0
+#endif
+
+#define UART_KNOWN_BUGS (HAS_BUG_QUOT | HAS_BUG_TXEN | HAS_BUG_NOMSR | \
+			HAS_BUG_THRE | HAS_BUG_PPC)
+
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 9ff47db..e01a411 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -70,6 +70,20 @@ config SERIAL_8250_CONSOLE
 
 	  If unsure, say N.
 
+config SERIAL_8250_PPC_BUG
+	bool "Fix 8250/16550 to handle IRQ storm after receipt of a break"
+	depends on SERIAL_8250 && PPC32
+	---help---
+	  If you say Y here, addional checks will be added in the handling of
+	  interrupts on the serial ports which will prevent ill effects of
+	  an interrupt storm triggered by a break on the serial line. Without
+	  this enabled, a Sysrq via the serial console can be unusable on
+	  some systems.
+
+	  This is commonly observed on PPC32 MPC83xx/85xx/86xx based boards.
+
+	  If unsure, say N.
+
 config FIX_EARLYCON_MEM
 	bool
 	depends on X86
diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index cf9327c..010174f 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -111,6 +111,7 @@
 #define UART_MCR_DTR		0x01 /* DTR complement */
 
 #define UART_LSR	5	/* In:  Line Status Register */
+#define UART_LSR_RFE		0x80 /* Rx FIFO Error (BE, FE, or PE) */
 #define UART_LSR_TEMT		0x40 /* Transmitter empty */
 #define UART_LSR_THRE		0x20 /* Transmit-hold-register empty */
 #define UART_LSR_BI		0x10 /* Break interrupt indicator */
@@ -119,6 +120,7 @@
 #define UART_LSR_OE		0x02 /* Overrun error indicator */
 #define UART_LSR_DR		0x01 /* Receiver data ready */
 #define UART_LSR_BRK_ERROR_BITS	0x1E /* BI, FE, PE, OE bits */
+#define UART_LSR_RFE_ERROR_BITS	0xF1 /* RFE, TEMT, THRE, BI, DR bits */
 
 #define UART_MSR	6	/* In:  Modem Status Register */
 #define UART_MSR_DCD		0x80 /* Data Carrier Detect */
-- 
1.6.5.2
