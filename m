Return-Path: <paul.gortmaker@windriver.com>
Date: Tue, 8 Jan 2008 00:27:44 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Linuxppc-dev@ozlabs.org
Subject: [PATCH/RFC] mpc83xx/85xx SysRQ/brk over 8250 console
Message-ID: <20080108052743.GA18083@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It seems that if a break is rec'd on the serial console (as per SysRQ
or similar) on some 83xx and 85xx processors, then a pulse of IRQs is
generated which makes the use of SysRQ itself about 99% impossible.  I
experimented with trying several ACK strategies, but in the end the
thing which worked best was just to wait for the surge of events to pass
(a fraction of a second).  The number of events can be on the order of
1000 (as reported by /proc/interrupts)

I really dislike seeing board specific ifdefs within what should be
board independent code, so I'm hoping that once the problem is known,
that a more elegant solution will pop into someone's head.  Or at least
this will hopefully save someone the grief of re-investigating the source
and start a discussion.

I've seen this on two different 834x boards and also an 8548 based
board.  At this point, it is not clear to me if the problem extends
beyond these CPU/soc to all with UARTs at 4500/4600.

While less than ideal, the work-around below which simply ignores the
events does allow a person to use SysRQ on such platforms.

The definition of the RFE bit (Rx FIFO error) can be found in pretty
much any of the MPC CPU PDFs (for those with 4500/4600 16550s).

Paul.

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index f94109c..2761c64 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1426,6 +1426,24 @@ serial8250_handle_port(struct uart_8250_port *up)
 
 	status = serial_inp(up, UART_LSR);
 
+#if defined(CONFIG_MPC834x) || defined(CONFIG_MPC8540)
+	/*
+	 * There appears to be a quirk in the implementation on some 8xxx
+	 * where after a break is rec'd (UART_LSR_BI), the UART generates
+	 * a short duration burst of bogus IRQ events with the signature
+	 * of RFE set (along with "normal" bits set) in the LSR.
+	 */
+
+#define RFE_8xxx_ERR_BITS (	UART_LSR_RFE	| UART_LSR_TEMT	| \
+				UART_LSR_THRE	| UART_LSR_BI	| \
+				UART_LSR_DR	)
+
+	if (status == RFE_8xxx_ERR_BITS) {
+		spin_unlock_irqrestore(&up->port.lock, flags);
+		return;
+	}
+#endif
+
 	DEBUG_INTR("status = %x...", status);
 
 	if (status & UART_LSR_DR)
diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index 96c0d93..1ea6436 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -111,6 +111,7 @@
 #define UART_MCR_DTR		0x01 /* DTR complement */
 
 #define UART_LSR	5	/* In:  Line Status Register */
+#define UART_LSR_RFE		0x80 /* Rx FIFO Error (BE, FE, or PE) */
 #define UART_LSR_TEMT		0x40 /* Transmitter empty */
 #define UART_LSR_THRE		0x20 /* Transmit-hold-register empty */
 #define UART_LSR_BI		0x10 /* Break interrupt indicator */
