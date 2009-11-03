Return-Path: <fthain@telegraphics.com.au>
Received: from mail.telegraphics.com.au (www.telegraphics.com.au
	[204.15.192.19]) by ozlabs.org (Postfix) with ESMTP id 4558EB7BF3
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2009 00:49:38 +1100 (EST)
Date: Wed, 4 Nov 2009 00:40:23 +1100 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/13] pmac-zilog: cleanup
Message-ID: <alpine.OSX.2.00.0911031441280.483@silk.local>
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

Whitespace cleanups and comment typo fix.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 drivers/serial/pmac_zilog.c |   85 +++++++++++++++++++++-----------------------
 drivers/serial/pmac_zilog.h |   20 +++++-----
 2 files changed, 51 insertions(+), 54 deletions(-)

Index: linux-2.6.31/drivers/serial/pmac_zilog.c
===================================================================
--- linux-2.6.31.orig/drivers/serial/pmac_zilog.c	2009-11-03 03:23:24.000000000 +1100
+++ linux-2.6.31/drivers/serial/pmac_zilog.c	2009-11-03 03:23:41.000000000 +1100
@@ -153,8 +153,8 @@ static void pmz_load_zsregs(struct uart_
 	write_zsreg(uap, R10, regs[R10]);
 
 	/* Set TX/RX controls sans the enable bits.  */
-       	write_zsreg(uap, R3, regs[R3] & ~RxENABLE);
-       	write_zsreg(uap, R5, regs[R5] & ~TxENABLE);
+	write_zsreg(uap, R3, regs[R3] & ~RxENABLE);
+	write_zsreg(uap, R5, regs[R5] & ~TxENABLE);
 
 	/* now set R7 "prime" on ESCC */
 	write_zsreg(uap, R15, regs[R15] | EN85C30);
@@ -205,7 +205,7 @@ static void pmz_load_zsregs(struct uart_
  */
 static void pmz_maybe_update_regs(struct uart_pmac_port *uap)
 {
-       	if (!ZS_REGS_HELD(uap)) {
+	if (!ZS_REGS_HELD(uap)) {
 		if (ZS_TX_ACTIVE(uap)) {
 			uap->flags |= PMACZILOG_FLAG_REGS_HELD;
 		} else {
@@ -281,7 +281,7 @@ static struct tty_struct *pmz_receive_ch
 			spin_lock(&uap->port.lock);
 			if (swallow)
 				goto next_char;
- 		}
+		}
 #endif /* CONFIG_MAGIC_SYSRQ && CONFIG_SERIAL_CORE_CONSOLE */
 
 		/* A real serial line, record the character and status.  */
@@ -317,7 +317,7 @@ static struct tty_struct *pmz_receive_ch
 
 		if (uap->port.ignore_status_mask == 0xff ||
 		    (r1 & uap->port.ignore_status_mask) == 0) {
-		    	tty_insert_flip_char(tty, ch, flag);
+			tty_insert_flip_char(tty, ch, flag);
 		}
 		if (r1 & Rx_OVR)
 			tty_insert_flip_char(tty, 0, TTY_OVERRUN);
@@ -459,47 +459,47 @@ static irqreturn_t pmz_interrupt(int irq
 
 	uap_a = pmz_get_port_A(uap);
 	uap_b = uap_a->mate;
-       
-       	spin_lock(&uap_a->port.lock);
+
+	spin_lock(&uap_a->port.lock);
 	r3 = read_zsreg(uap_a, R3);
 
 #ifdef DEBUG_HARD
 	pmz_debug("irq, r3: %x\n", r3);
 #endif
-       	/* Channel A */
+	/* Channel A */
 	tty = NULL;
-       	if (r3 & (CHAEXT | CHATxIP | CHARxIP)) {
+	if (r3 & (CHAEXT | CHATxIP | CHARxIP)) {
 		write_zsreg(uap_a, R0, RES_H_IUS);
 		zssync(uap_a);		
-       		if (r3 & CHAEXT)
-       			pmz_status_handle(uap_a);
+		if (r3 & CHAEXT)
+			pmz_status_handle(uap_a);
 		if (r3 & CHARxIP)
 			tty = pmz_receive_chars(uap_a);
-       		if (r3 & CHATxIP)
-       			pmz_transmit_chars(uap_a);
-	        rc = IRQ_HANDLED;
-       	}
-       	spin_unlock(&uap_a->port.lock);
+		if (r3 & CHATxIP)
+			pmz_transmit_chars(uap_a);
+		rc = IRQ_HANDLED;
+	}
+	spin_unlock(&uap_a->port.lock);
 	if (tty != NULL)
 		tty_flip_buffer_push(tty);
 
 	if (uap_b->node == NULL)
 		goto out;
 
-       	spin_lock(&uap_b->port.lock);
+	spin_lock(&uap_b->port.lock);
 	tty = NULL;
 	if (r3 & (CHBEXT | CHBTxIP | CHBRxIP)) {
 		write_zsreg(uap_b, R0, RES_H_IUS);
 		zssync(uap_b);
-       		if (r3 & CHBEXT)
-       			pmz_status_handle(uap_b);
-       	       	if (r3 & CHBRxIP)
-       			tty = pmz_receive_chars(uap_b);
-       		if (r3 & CHBTxIP)
-       			pmz_transmit_chars(uap_b);
-	       	rc = IRQ_HANDLED;
-       	}
-       	spin_unlock(&uap_b->port.lock);
+		if (r3 & CHBEXT)
+			pmz_status_handle(uap_b);
+		if (r3 & CHBRxIP)
+			tty = pmz_receive_chars(uap_b);
+		if (r3 & CHBTxIP)
+			pmz_transmit_chars(uap_b);
+		rc = IRQ_HANDLED;
+	}
+	spin_unlock(&uap_b->port.lock);
 	if (tty != NULL)
 		tty_flip_buffer_push(tty);
 
@@ -707,7 +707,7 @@ static void pmz_enable_ms(struct uart_po
 
 		if (ZS_IS_ASLEEP(uap))
 			return;
-		/* NOTE: Not subject to 'transmitter active' rule.  */ 
+		/* NOTE: Not subject to 'transmitter active' rule. */
 		write_zsreg(uap, R15, uap->curregs[R15]);
 	}
 }
@@ -737,7 +737,7 @@ static void pmz_break_ctl(struct uart_po
 	if (new_reg != uap->curregs[R5]) {
 		uap->curregs[R5] = new_reg;
 
-		/* NOTE: Not subject to 'transmitter active' rule.  */ 
+		/* NOTE: Not subject to 'transmitter active' rule. */
 		if (ZS_IS_ASLEEP(uap))
 			return;
 		write_zsreg(uap, R5, uap->curregs[R5]);
@@ -897,7 +897,6 @@ static int __pmz_startup(struct uart_pma
 	/* Remember status for DCD/CTS changes */
 	uap->prev_status = read_zsreg(uap, R0);
 
-
 	return pwr_delay;
 }
 
@@ -972,7 +971,7 @@ static int pmz_startup(struct uart_port 
 	if (!ZS_IS_EXTCLK(uap))
 		uap->curregs[R1] |= EXT_INT_ENAB;
 	write_zsreg(uap, R1, uap->curregs[R1]);
-       	spin_unlock_irqrestore(&port->lock, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	pmz_debug("pmz: startup() done.\n");
 
@@ -992,7 +991,7 @@ static void pmz_shutdown(struct uart_por
 	mutex_lock(&pmz_irq_mutex);
 
 	/* Release interrupt handler */
-       	free_irq(uap->port.irq, uap);
+	free_irq(uap->port.irq, uap);
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -1040,7 +1039,6 @@ static void pmz_convert_to_zs(struct uar
 {
 	int brg;
 
-
 	/* Switch to external clocking for IrDA high clock rates. That
 	 * code could be re-used for Midi interfaces with different
 	 * multipliers
@@ -1212,12 +1210,12 @@ static void pmz_irda_setup(struct uart_p
 	uap->curregs[R5] |= DTR;
 	write_zsreg(uap, R5, uap->curregs[R5]);
 	zssync(uap);
-       	mdelay(1);
+	mdelay(1);
 
 	/* Switch SCC to 19200 */
 	pmz_convert_to_zs(uap, CS8, 0, 19200);		
 	pmz_load_zsregs(uap, uap->curregs);
-       	mdelay(1);
+	mdelay(1);
 
 	/* Write get_version command byte */
 	write_zsdata(uap, 1);
@@ -1452,7 +1450,7 @@ static int __init pmz_init_port(struct u
 		return -ENODEV;
 	uap->port.mapbase = r_ports.start;
 	uap->port.membase = ioremap(uap->port.mapbase, 0x1000);
-      
+
 	uap->control_reg = uap->port.membase;
 	uap->data_reg = uap->control_reg + 0x10;
 	
@@ -1579,7 +1577,7 @@ static void pmz_dispose_port(struct uart
 }
 
 /*
- * Called upon match with an escc node in the devive-tree.
+ * Called upon match with an escc node in the device-tree.
  */
 static int pmz_attach(struct macio_dev *mdev, const struct of_device_id *match)
 {
@@ -1801,7 +1799,7 @@ static int __init pmz_probe(void)
 		pmz_ports[count].node		= node_a;
 		pmz_ports[count+1].node		= node_b;
 		pmz_ports[count].port.line	= count;
-		pmz_ports[count+1].port.line   	= count+1;
+		pmz_ports[count+1].port.line	= count+1;
 
 		/*
 		 * Setup the ports for real
@@ -1888,23 +1886,22 @@ err_out:
 static struct of_device_id pmz_match[] = 
 {
 	{
-	.name 		= "ch-a",
+	.name		= "ch-a",
 	},
 	{
-	.name 		= "ch-b",
+	.name		= "ch-b",
 	},
 	{},
 };
 MODULE_DEVICE_TABLE (of, pmz_match);
 
-static struct macio_driver pmz_driver = 
-{
+static struct macio_driver pmz_driver = {
 	.name 		= "pmac_zilog",
 	.match_table	= pmz_match,
 	.probe		= pmz_attach,
 	.remove		= pmz_detach,
 	.suspend	= pmz_suspend,
-       	.resume		= pmz_resume,
+	.resume		= pmz_resume,
 };
 
 static int __init init_pmz(void)
@@ -1941,7 +1938,7 @@ static int __init init_pmz(void)
 			pmz_dispose_port(&pmz_ports[i]);
 		return rc;
 	}
-	
+
 	/*
 	 * Then we register the macio driver itself
 	 */
@@ -2023,7 +2020,7 @@ static int __init pmz_console_setup(stru
 	if (machine_is_compatible("RackMac1,1")
 	    || machine_is_compatible("RackMac1,2")
 	    || machine_is_compatible("MacRISC4"))
-	 	baud = 57600;
+		baud = 57600;
 
 	/*
 	 * Check whether an invalid uart number has been specified, and
Index: linux-2.6.31/drivers/serial/pmac_zilog.h
===================================================================
--- linux-2.6.31.orig/drivers/serial/pmac_zilog.h	2009-11-03 03:23:24.000000000 +1100
+++ linux-2.6.31/drivers/serial/pmac_zilog.h	2009-11-03 03:23:41.000000000 +1100
@@ -1,7 +1,7 @@
 #ifndef __PMAC_ZILOG_H__
 #define __PMAC_ZILOG_H__
 
-#define pmz_debug(fmt,arg...)	dev_dbg(&uap->dev->ofdev.dev, fmt, ## arg)
+#define pmz_debug(fmt, arg...)	dev_dbg(&uap->dev->ofdev.dev, fmt, ## arg)
 
 /*
  * At most 2 ESCCs with 2 ports each
@@ -113,7 +113,7 @@ static inline void zssync(struct uart_pm
 #define BRG_TO_BPS(brg, freq) ((freq) / 2 / ((brg) + 2))
 #define BPS_TO_BRG(bps, freq) ((((freq) + (bps)) / (2 * (bps))) - 2)
 
-#define ZS_CLOCK         3686400 	/* Z8530 RTxC input clock rate */
+#define ZS_CLOCK         3686400	/* Z8530 RTxC input clock rate */
 
 /* The Zilog register set */
 
@@ -171,7 +171,7 @@ static inline void zssync(struct uart_pm
 
 /* Write Register 3 */
 
-#define	RxENABLE       	0x1	/* Rx Enable */
+#define	RxENABLE	0x1	/* Rx Enable */
 #define	SYNC_L_INH	0x2	/* Sync Character Load Inhibit */
 #define	ADD_SM		0x4	/* Address Search Mode (SDLC) */
 #define	RxCRC_ENAB	0x8	/* Rx CRC Enable */
@@ -185,7 +185,7 @@ static inline void zssync(struct uart_pm
 
 /* Write Register 4 */
 
-#define	PAR_ENAB       	0x1	/* Parity Enable */
+#define	PAR_ENAB	0x1	/* Parity Enable */
 #define	PAR_EVEN	0x2	/* Parity Even/Odd* */
 
 #define	SYNC_ENAB	0	/* Sync Modes Enable */
@@ -210,7 +210,7 @@ static inline void zssync(struct uart_pm
 #define	TxCRC_ENAB	0x1	/* Tx CRC Enable */
 #define	RTS		0x2	/* RTS */
 #define	SDLC_CRC	0x4	/* SDLC/CRC-16 */
-#define	TxENABLE       	0x8	/* Tx Enable */
+#define	TxENABLE	0x8	/* Tx Enable */
 #define	SND_BRK		0x10	/* Send Break */
 #define	Tx5		0x0	/* Tx 5 bits (or less)/character */
 #define	Tx7		0x20	/* Tx 7 bits/character */
@@ -372,11 +372,11 @@ static inline void zssync(struct uart_pm
 #define ZS_TX_ACTIVE(UP)		((UP)->flags & PMACZILOG_FLAG_TX_ACTIVE)
 #define ZS_WANTS_MODEM_STATUS(UP)	((UP)->flags & PMACZILOG_FLAG_MODEM_STATUS)
 #define ZS_IS_IRDA(UP)			((UP)->flags & PMACZILOG_FLAG_IS_IRDA)
-#define ZS_IS_INTMODEM(UP)	       	((UP)->flags & PMACZILOG_FLAG_IS_INTMODEM)
+#define ZS_IS_INTMODEM(UP)		((UP)->flags & PMACZILOG_FLAG_IS_INTMODEM)
 #define ZS_HAS_DMA(UP)			((UP)->flags & PMACZILOG_FLAG_HAS_DMA)
-#define ZS_IS_ASLEEP(UP)       		((UP)->flags & PMACZILOG_FLAG_IS_ASLEEP)
-#define ZS_IS_OPEN(UP)       		((UP)->flags & PMACZILOG_FLAG_IS_OPEN)
-#define ZS_IS_IRQ_ON(UP)       		((UP)->flags & PMACZILOG_FLAG_IS_IRQ_ON)
-#define ZS_IS_EXTCLK(UP)       		((UP)->flags & PMACZILOG_FLAG_IS_EXTCLK)
+#define ZS_IS_ASLEEP(UP)		((UP)->flags & PMACZILOG_FLAG_IS_ASLEEP)
+#define ZS_IS_OPEN(UP)			((UP)->flags & PMACZILOG_FLAG_IS_OPEN)
+#define ZS_IS_IRQ_ON(UP)		((UP)->flags & PMACZILOG_FLAG_IS_IRQ_ON)
+#define ZS_IS_EXTCLK(UP)		((UP)->flags & PMACZILOG_FLAG_IS_EXTCLK)
 
 #endif /* __PMAC_ZILOG_H__ */
