Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7BA88B6FD7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2011 10:48:50 +1100 (EST)
Message-ID: <1323647315.19891.10.camel@pasglop>
Subject: Re: [PATCH 01/16 v3] pmac_zilog: fix unexpected irq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Finn Thain <fthain@telegraphics.com.au>
Date: Mon, 12 Dec 2011 10:48:35 +1100
In-Reply-To: <alpine.LNX.2.00.1112082128330.2357@nippy.intranet>
References: <20111023141108.856998818@telegraphics.com.au>
 <20111023141115.208699274@telegraphics.com.au>
 <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
 <alpine.LNX.2.00.1112071427280.28552@nippy.intranet>
 <1323318004.12793.21.camel@pasglop> <1323318638.12793.23.camel@pasglop>
 <alpine.LNX.2.00.1112082128330.2357@nippy.intranet>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-m68k@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Any chance you can test this patch ? I would not be surprised if it
broke m68k since I had to do some of the changes in there "blind",
so let me know... with this, I can again suspend/resume properly on
a Pismo while using the internal modem among other things.

>From c2dbe7117bb94c59a4b2a215fc87fe7eabb7658d Mon Sep 17 00:00:00 2001
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 12 Dec 2011 10:44:08 +1100
Subject: [PATCH 2/2] tty/serial/pmac_zilog: Fix suspend & resume

This patch reworks & simplifies pmac_zilog handling of suspend/resume,
essentially removing all the specific code in there and using the
generic uart helpers.

This required properly registering the tty as a child of the macio (or platform)
device, so I had to delay the registration a bit (we used to register the ports
very very early). We still register the kernel console early though.

I removed a couple of unused or useless flags as well, relying on the
core to not call us when asleep. I also removed the essentially useless
interrupt mutex, simplifying the locking a bit.

I removed some code for handling unexpected interrupt which should never
be hit and could potentially be harmful (causing us to access a register
on a powered off SCC). We diable port interrupts on close always so there
should be no need to drain data on a closed port.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/tty/serial/pmac_zilog.c |  350 ++++++++++-----------------------------
 drivers/tty/serial/pmac_zilog.h |   18 +-
 2 files changed, 99 insertions(+), 269 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index 51941f0..46cb39b 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -106,7 +106,6 @@ MODULE_LICENSE("GPL");
  */
 static struct uart_pmac_port	pmz_ports[MAX_ZS_PORTS];
 static int			pmz_ports_count;
-static DEFINE_MUTEX(pmz_irq_mutex);
 
 static struct uart_driver pmz_uart_reg = {
 	.owner		=	THIS_MODULE,
@@ -126,9 +125,6 @@ static void pmz_load_zsregs(struct uart_pmac_port *uap, u8 *regs)
 {
 	int i;
 
-	if (ZS_IS_ASLEEP(uap))
-		return;
-
 	/* Let pending transmits finish.  */
 	for (i = 0; i < 1000; i++) {
 		unsigned char stat = read_zsreg(uap, R1);
@@ -234,26 +230,6 @@ static struct tty_struct *pmz_receive_chars(struct uart_pmac_port *uap)
 	unsigned char ch, r1, drop, error, flag;
 	int loops = 0;
 
-	/* The interrupt can be enabled when the port isn't open, typically
-	 * that happens when using one port is open and the other closed (stale
-	 * interrupt) or when one port is used as a console.
-	 */
-	if (!ZS_IS_OPEN(uap)) {
-		pmz_debug("pmz: draining input\n");
-		/* Port is closed, drain input data */
-		for (;;) {
-			if ((++loops) > 1000)
-				goto flood;
-			(void)read_zsreg(uap, R1);
-			write_zsreg(uap, R0, ERR_RES);
-			(void)read_zsdata(uap);
-			ch = read_zsreg(uap, R0);
-			if (!(ch & Rx_CH_AV))
-				break;
-		}
-		return NULL;
-	}
-
 	/* Sanity check, make sure the old bug is no longer happening */
 	if (uap->port.state == NULL || uap->port.state->port.tty == NULL) {
 		WARN_ON(1);
@@ -393,8 +369,6 @@ static void pmz_transmit_chars(struct uart_pmac_port *uap)
 {
 	struct circ_buf *xmit;
 
-	if (ZS_IS_ASLEEP(uap))
-		return;
 	if (ZS_IS_CONS(uap)) {
 		unsigned char status = read_zsreg(uap, R0);
 
@@ -485,12 +459,16 @@ static irqreturn_t pmz_interrupt(int irq, void *dev_id)
 	spin_lock(&uap_a->port.lock);
 	r3 = read_zsreg(uap_a, R3);
 
-#ifdef DEBUG_HARD
+#ifde DEBUG_HARD
 	pmz_debug("irq, r3: %x\n", r3);
 #endif
 	/* Channel A */
 	tty = NULL;
 	if (r3 & (CHAEXT | CHATxIP | CHARxIP)) {
+		if (!ZS_IS_OPEN(uap_a)) {
+			pmz_debug("ChanA interrupt while open !\n");
+			goto skip_a;
+		}
 		write_zsreg(uap_a, R0, RES_H_IUS);
 		zssync(uap_a);		
 		if (r3 & CHAEXT)
@@ -501,16 +479,21 @@ static irqreturn_t pmz_interrupt(int irq, void *dev_id)
 			pmz_transmit_chars(uap_a);
 		rc = IRQ_HANDLED;
 	}
+ skip_a:
 	spin_unlock(&uap_a->port.lock);
 	if (tty != NULL)
 		tty_flip_buffer_push(tty);
 
-	if (uap_b->node == NULL)
+	if (!uap_b)
 		goto out;
 
 	spin_lock(&uap_b->port.lock);
 	tty = NULL;
 	if (r3 & (CHBEXT | CHBTxIP | CHBRxIP)) {
+		if (!ZS_IS_OPEN(uap_a)) {
+			pmz_debug("ChanB interrupt while open !\n");
+			goto skip_b;
+		}
 		write_zsreg(uap_b, R0, RES_H_IUS);
 		zssync(uap_b);
 		if (r3 & CHBEXT)
@@ -521,14 +504,12 @@ static irqreturn_t pmz_interrupt(int irq, void *dev_id)
 			pmz_transmit_chars(uap_b);
 		rc = IRQ_HANDLED;
 	}
+ skip_b:
 	spin_unlock(&uap_b->port.lock);
 	if (tty != NULL)
 		tty_flip_buffer_push(tty);
 
  out:
-#ifdef DEBUG_HARD
-	pmz_debug("irq done.\n");
-#endif
 	return rc;
 }
 
@@ -553,12 +534,8 @@ static inline u8 pmz_peek_status(struct uart_pmac_port *uap)
  */
 static unsigned int pmz_tx_empty(struct uart_port *port)
 {
-	struct uart_pmac_port *uap = to_pmz(port);
 	unsigned char status;
 
-	if (ZS_IS_ASLEEP(uap) || uap->node == NULL)
-		return TIOCSER_TEMT;
-
 	status = pmz_peek_status(to_pmz(port));
 	if (status & Tx_BUF_EMP)
 		return TIOCSER_TEMT;
@@ -580,8 +557,7 @@ static void pmz_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	if (ZS_IS_IRDA(uap))
 		return;
 	/* We get called during boot with a port not up yet */
-	if (ZS_IS_ASLEEP(uap) ||
-	    !(ZS_IS_OPEN(uap) || ZS_IS_CONS(uap)))
+	if (!(ZS_IS_OPEN(uap) || ZS_IS_CONS(uap)))
 		return;
 
 	set_bits = clear_bits = 0;
@@ -600,8 +576,7 @@ static void pmz_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	/* NOTE: Not subject to 'transmitter active' rule.  */ 
 	uap->curregs[R5] |= set_bits;
 	uap->curregs[R5] &= ~clear_bits;
-	if (ZS_IS_ASLEEP(uap))
-		return;
+
 	write_zsreg(uap, R5, uap->curregs[R5]);
 	pmz_debug("pmz_set_mctrl: set bits: %x, clear bits: %x -> %x\n",
 		  set_bits, clear_bits, uap->curregs[R5]);
@@ -619,9 +594,6 @@ static unsigned int pmz_get_mctrl(struct uart_port *port)
 	unsigned char status;
 	unsigned int ret;
 
-	if (ZS_IS_ASLEEP(uap) || uap->node == NULL)
-		return 0;
-
 	status = read_zsreg(uap, R0);
 
 	ret = 0;
@@ -659,9 +631,6 @@ static void pmz_start_tx(struct uart_port *port)
 	uap->flags |= PMACZILOG_FLAG_TX_ACTIVE;
 	uap->flags &= ~PMACZILOG_FLAG_TX_STOPPED;
 
-	if (ZS_IS_ASLEEP(uap) || uap->node == NULL)
-		return;
-
 	status = read_zsreg(uap, R0);
 
 	/* TX busy?  Just wait for the TX done interrupt.  */
@@ -700,9 +669,6 @@ static void pmz_stop_rx(struct uart_port *port)
 {
 	struct uart_pmac_port *uap = to_pmz(port);
 
-	if (ZS_IS_ASLEEP(uap) || uap->node == NULL)
-		return;
-
 	pmz_debug("pmz: stop_rx()()\n");
 
 	/* Disable all RX interrupts.  */
@@ -721,14 +687,12 @@ static void pmz_enable_ms(struct uart_port *port)
 	struct uart_pmac_port *uap = to_pmz(port);
 	unsigned char new_reg;
 
-	if (ZS_IS_IRDA(uap) || uap->node == NULL)
+	if (ZS_IS_IRDA(uap))
 		return;
 	new_reg = uap->curregs[R15] | (DCDIE | SYNCIE | CTSIE);
 	if (new_reg != uap->curregs[R15]) {
 		uap->curregs[R15] = new_reg;
 
-		if (ZS_IS_ASLEEP(uap))
-			return;
 		/* NOTE: Not subject to 'transmitter active' rule. */
 		write_zsreg(uap, R15, uap->curregs[R15]);
 	}
@@ -744,8 +708,6 @@ static void pmz_break_ctl(struct uart_port *port, int break_state)
 	unsigned char set_bits, clear_bits, new_reg;
 	unsigned long flags;
 
-	if (uap->node == NULL)
-		return;
 	set_bits = clear_bits = 0;
 
 	if (break_state)
@@ -758,12 +720,6 @@ static void pmz_break_ctl(struct uart_port *port, int break_state)
 	new_reg = (uap->curregs[R5] | set_bits) & ~clear_bits;
 	if (new_reg != uap->curregs[R5]) {
 		uap->curregs[R5] = new_reg;
-
-		/* NOTE: Not subject to 'transmitter active' rule. */
-		if (ZS_IS_ASLEEP(uap)) {
-			spin_unlock_irqrestore(&port->lock, flags);
-			return;
-		}
 		write_zsreg(uap, R5, uap->curregs[R5]);
 	}
 
@@ -937,14 +893,21 @@ static int __pmz_startup(struct uart_pmac_port *uap)
 
 static void pmz_irda_reset(struct uart_pmac_port *uap)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&uap->port.lock, flags);
 	uap->curregs[R5] |= DTR;
 	write_zsreg(uap, R5, uap->curregs[R5]);
 	zssync(uap);
-	mdelay(110);
+	spin_unlock_irqrestore(&uap->port.lock, flags);
+	msleep(110);
+
+	spin_lock_irqsave(&uap->port.lock, flags);
 	uap->curregs[R5] &= ~DTR;
 	write_zsreg(uap, R5, uap->curregs[R5]);
 	zssync(uap);
-	mdelay(10);
+	spin_unlock_irqrestore(&uap->port.lock, flags);
+	msleep(10);
 }
 
 /*
@@ -959,13 +922,6 @@ static int pmz_startup(struct uart_port *port)
 
 	pmz_debug("pmz: startup()\n");
 
-	if (ZS_IS_ASLEEP(uap))
-		return -EAGAIN;
-	if (uap->node == NULL)
-		return -ENODEV;
-
-	mutex_lock(&pmz_irq_mutex);
-
 	uap->flags |= PMACZILOG_FLAG_IS_OPEN;
 
 	/* A console is never powered down. Else, power up and
@@ -976,18 +932,14 @@ static int pmz_startup(struct uart_port *port)
 		pwr_delay = __pmz_startup(uap);
 		spin_unlock_irqrestore(&port->lock, flags);
 	}	
-
-	pmz_get_port_A(uap)->flags |= PMACZILOG_FLAG_IS_IRQ_ON;
+	sprintf(uap->irq_name, PMACZILOG_NAME"%d", uap->port.line);
 	if (request_irq(uap->port.irq, pmz_interrupt, IRQF_SHARED,
-			"SCC", uap)) {
+			uap->irq_name, uap)) {
 		pmz_error("Unable to register zs interrupt handler.\n");
 		pmz_set_scc_power(uap, 0);
-		mutex_unlock(&pmz_irq_mutex);
 		return -ENXIO;
 	}
 
-	mutex_unlock(&pmz_irq_mutex);
-
 	/* Right now, we deal with delay by blocking here, I'll be
 	 * smarter later on
 	 */
@@ -1017,26 +969,19 @@ static void pmz_shutdown(struct uart_port *port)
 
 	pmz_debug("pmz: shutdown()\n");
 
-	if (uap->node == NULL)
-		return;
-
-	mutex_lock(&pmz_irq_mutex);
-
 	spin_lock_irqsave(&port->lock, flags);
 
-	if (!ZS_IS_ASLEEP(uap)) {
-		/* Disable interrupt requests for the channel */
-		pmz_interrupt_control(uap, 0);
+	/* Disable interrupt requests for the channel */
+	pmz_interrupt_control(uap, 0);
 
-		if (!ZS_IS_CONS(uap)) {
-			/* Disable receiver and transmitter */
-			uap->curregs[R3] &= ~RxENABLE;
-			uap->curregs[R5] &= ~TxENABLE;
+	if (!ZS_IS_CONS(uap)) {
+		/* Disable receiver and transmitter */
+		uap->curregs[R3] &= ~RxENABLE;
+		uap->curregs[R5] &= ~TxENABLE;
 
-			/* Disable break assertion */
-			uap->curregs[R5] &= ~SND_BRK;
-			pmz_maybe_update_regs(uap);
-		}
+		/* Disable break assertion */
+		uap->curregs[R5] &= ~SND_BRK;
+		pmz_maybe_update_regs(uap);
 	}
 
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -1048,16 +993,11 @@ static void pmz_shutdown(struct uart_port *port)
 
 	uap->flags &= ~PMACZILOG_FLAG_IS_OPEN;
 
-	if (!ZS_IS_OPEN(uap->mate))
-		pmz_get_port_A(uap)->flags &= ~PMACZILOG_FLAG_IS_IRQ_ON;
-
-	if (!ZS_IS_ASLEEP(uap) && !ZS_IS_CONS(uap))
+	if (!ZS_IS_CONS(uap))
 		pmz_set_scc_power(uap, 0);	/* Shut the chip down */
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	mutex_unlock(&pmz_irq_mutex);
-
 	pmz_debug("pmz: shutdown() done.\n");
 }
 
@@ -1305,9 +1245,6 @@ static void __pmz_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	pmz_debug("pmz: set_termios()\n");
 
-	if (ZS_IS_ASLEEP(uap))
-		return;
-
 	memcpy(&uap->termios_cache, termios, sizeof(struct ktermios));
 
 	/* XXX Check which revs of machines actually allow 1 and 4Mb speeds
@@ -1605,25 +1542,34 @@ static void pmz_dispose_port(struct uart_pmac_port *uap)
  */
 static int pmz_attach(struct macio_dev *mdev, const struct of_device_id *match)
 {
+	struct uart_pmac_port *uap;
 	int i;
 	
 	/* Iterate the pmz_ports array to find a matching entry
 	 */
 	for (i = 0; i < MAX_ZS_PORTS; i++)
-		if (pmz_ports[i].node == mdev->ofdev.dev.of_node) {
-			struct uart_pmac_port *uap = &pmz_ports[i];
-
-			uap->dev = mdev;
-			dev_set_drvdata(&mdev->ofdev.dev, uap);
-			if (macio_request_resources(uap->dev, "pmac_zilog"))
-				printk(KERN_WARNING "%s: Failed to request resource"
-				       ", port still active\n",
-				       uap->node->name);
-			else
-				uap->flags |= PMACZILOG_FLAG_RSRC_REQUESTED;				
-			return 0;
-		}
-	return -ENODEV;
+		if (pmz_ports[i].node == mdev->ofdev.dev.of_node)
+			break;
+	if (i >= MAX_ZS_PORTS)
+		return -ENODEV;
+
+
+	uap = &pmz_ports[i];
+	uap->dev = mdev;
+	uap->port.dev = &mdev->ofdev.dev;
+	dev_set_drvdata(&mdev->ofdev.dev, uap);
+
+	/* We still activate the port even when failing to request resources
+	 * to work around bugs in ancient Apple device-trees
+	 */
+	if (macio_request_resources(uap->dev, "pmac_zilog"))
+		printk(KERN_WARNING "%s: Failed to request resource"
+		       ", port still active\n",
+		       uap->node->name);
+	else
+		uap->flags |= PMACZILOG_FLAG_RSRC_REQUESTED;				
+
+	return uart_add_one_port(&pmz_uart_reg, &uap->port);
 }
 
 /*
@@ -1637,12 +1583,15 @@ static int pmz_detach(struct macio_dev *mdev)
 	if (!uap)
 		return -ENODEV;
 
+	uart_remove_one_port(&pmz_uart_reg, &uap->port);
+
 	if (uap->flags & PMACZILOG_FLAG_RSRC_REQUESTED) {
 		macio_release_resources(uap->dev);
 		uap->flags &= ~PMACZILOG_FLAG_RSRC_REQUESTED;
 	}
 	dev_set_drvdata(&mdev->ofdev.dev, NULL);
 	uap->dev = NULL;
+	uap->port.dev = NULL;
 	
 	return 0;
 }
@@ -1651,62 +1600,13 @@ static int pmz_detach(struct macio_dev *mdev)
 static int pmz_suspend(struct macio_dev *mdev, pm_message_t pm_state)
 {
 	struct uart_pmac_port *uap = dev_get_drvdata(&mdev->ofdev.dev);
-	struct uart_state *state;
-	unsigned long flags;
 
 	if (uap == NULL) {
 		printk("HRM... pmz_suspend with NULL uap\n");
 		return 0;
 	}
 
-	if (pm_state.event == mdev->ofdev.dev.power.power_state.event)
-		return 0;
-
-	pmz_debug("suspend, switching to state %d\n", pm_state.event);
-
-	state = pmz_uart_reg.state + uap->port.line;
-
-	mutex_lock(&pmz_irq_mutex);
-	mutex_lock(&state->port.mutex);
-
-	spin_lock_irqsave(&uap->port.lock, flags);
-
-	if (ZS_IS_OPEN(uap) || ZS_IS_CONS(uap)) {
-		/* Disable interrupt requests for the channel */
-		pmz_interrupt_control(uap, 0);
-
-		/* Disable receiver and transmitter */
-		uap->curregs[R3] &= ~RxENABLE;
-		uap->curregs[R5] &= ~TxENABLE;
-
-		/* Disable break assertion */
-		uap->curregs[R5] &= ~SND_BRK;
-		pmz_load_zsregs(uap, uap->curregs);
-
-		uap->flags |= PMACZILOG_FLAG_IS_ASLEEP;
-		mb();
-	}
-
-	spin_unlock_irqrestore(&uap->port.lock, flags);
-
-	if (ZS_IS_OPEN(uap) || ZS_IS_OPEN(uap->mate))
-		if (ZS_IS_ASLEEP(uap->mate) && ZS_IS_IRQ_ON(pmz_get_port_A(uap))) {
-			pmz_get_port_A(uap)->flags &= ~PMACZILOG_FLAG_IS_IRQ_ON;
-			disable_irq(uap->port.irq);
-		}
-
-	if (ZS_IS_CONS(uap))
-		uap->port.cons->flags &= ~CON_ENABLED;
-
-	/* Shut the chip down */
-	pmz_set_scc_power(uap, 0);
-
-	mutex_unlock(&state->port.mutex);
-	mutex_unlock(&pmz_irq_mutex);
-
-	pmz_debug("suspend, switching complete\n");
-
-	mdev->ofdev.dev.power.power_state = pm_state;
+	uart_suspend_port(&pmz_uart_reg, &uap->port);
 
 	return 0;
 }
@@ -1715,74 +1615,20 @@ static int pmz_suspend(struct macio_dev *mdev, pm_message_t pm_state)
 static int pmz_resume(struct macio_dev *mdev)
 {
 	struct uart_pmac_port *uap = dev_get_drvdata(&mdev->ofdev.dev);
-	struct uart_state *state;
-	unsigned long flags;
-	int pwr_delay = 0;
 
 	if (uap == NULL)
 		return 0;
 
-	if (mdev->ofdev.dev.power.power_state.event == PM_EVENT_ON)
-		return 0;
-	
-	pmz_debug("resume, switching to state 0\n");
-
-	state = pmz_uart_reg.state + uap->port.line;
-
-	mutex_lock(&pmz_irq_mutex);
-	mutex_lock(&state->port.mutex);
-
-	spin_lock_irqsave(&uap->port.lock, flags);
-	if (!ZS_IS_OPEN(uap) && !ZS_IS_CONS(uap)) {
-		spin_unlock_irqrestore(&uap->port.lock, flags);
-		goto bail;
-	}
-	pwr_delay = __pmz_startup(uap);
-
-	/* Take care of config that may have changed while asleep */
-	__pmz_set_termios(&uap->port, &uap->termios_cache, NULL);
-
-	spin_unlock_irqrestore(&uap->port.lock, flags);
-
-	if (ZS_IS_CONS(uap))
-		uap->port.cons->flags |= CON_ENABLED;
-
-	/* Re-enable IRQ on the controller */
-	if (ZS_IS_OPEN(uap) && !ZS_IS_IRQ_ON(pmz_get_port_A(uap))) {
-		pmz_get_port_A(uap)->flags |= PMACZILOG_FLAG_IS_IRQ_ON;
-		enable_irq(uap->port.irq);
-	}
-
-	if (ZS_IS_OPEN(uap)) {
-		spin_lock_irqsave(&uap->port.lock, flags);
-		pmz_interrupt_control(uap, 1);
-		spin_unlock_irqrestore(&uap->port.lock, flags);
-	}
-
- bail:
-	mutex_unlock(&state->port.mutex);
-	mutex_unlock(&pmz_irq_mutex);
-
-	/* Right now, we deal with delay by blocking here, I'll be
-	 * smarter later on
-	 */
-	if (pwr_delay != 0) {
-		pmz_debug("pmz: delaying %d ms\n", pwr_delay);
-		msleep(pwr_delay);
-	}
-
-	pmz_debug("resume, switching complete\n");
-
-	mdev->ofdev.dev.power.power_state.event = PM_EVENT_ON;
+	uart_resume_port(&pmz_uart_reg, &uap->port);
 
 	return 0;
 }
 
 /*
  * Probe all ports in the system and build the ports array, we register
- * with the serial layer at this point, the macio-type probing is only
- * used later to "attach" to the sysfs tree so we get power management
- * events
+ * with the serial layer later, so we get a proper struct device which
+ * allows the tty to attach properly. This is later than it used to be
+ * but the tty layer really wants it that way.
  */
 static int __init pmz_probe(void)
 {
@@ -1818,8 +1664,10 @@ static int __init pmz_probe(void)
 		/*
 		 * Fill basic fields in the port structures
 		 */
-		pmz_ports[count].mate		= &pmz_ports[count+1];
-		pmz_ports[count+1].mate		= &pmz_ports[count];
+		if (node_b != NULL) {
+			pmz_ports[count].mate		= &pmz_ports[count+1];
+			pmz_ports[count+1].mate		= &pmz_ports[count];
+		}
 		pmz_ports[count].flags		= PMACZILOG_FLAG_IS_CHANNEL_A;
 		pmz_ports[count].node		= node_a;
 		pmz_ports[count+1].node		= node_b;
@@ -1887,19 +1735,19 @@ static int __init pmz_probe(void)
 
 	pmz_ports_count = 0;
 
-	pmz_ports[0].mate      = &pmz_ports[1];
 	pmz_ports[0].port.line = 0;
 	pmz_ports[0].flags     = PMACZILOG_FLAG_IS_CHANNEL_A;
-	pmz_ports[0].node      = &scc_a_pdev;
+	pmz_ports[0].pdev      = &scc_a_pdev;
 	err = pmz_init_port(&pmz_ports[0]);
 	if (err)
 		return err;
 	pmz_ports_count++;
 
+	pmz_ports[0].mate      = &pmz_ports[1];
 	pmz_ports[1].mate      = &pmz_ports[0];
 	pmz_ports[1].port.line = 1;
 	pmz_ports[1].flags     = 0;
-	pmz_ports[1].node      = &scc_b_pdev;
+	pmz_ports[1].pdev      = &scc_b_pdev;
 	err = pmz_init_port(&pmz_ports[1]);
 	if (err)
 		return err;
@@ -1918,13 +1766,22 @@ static int __init pmz_attach(struct platform_device *pdev)
 	int i;
 
 	for (i = 0; i < pmz_ports_count; i++)
-		if (pmz_ports[i].node == pdev)
-			return 0;
-	return -ENODEV;
+		if (pmz_ports[i].pdev == pdev)
+			break;
+	if (i >= pmz_ports_count)
+		return -ENODEV;
+
+	uap = &pmz_ports[i];
+	uap->port.dev = &pdev->dev;
+	dev_set_drvdata(&mdev->ofdev.dev, uap);
+
+			return uart_add_one_port(&pmz_uart_reg,
+						 &pmz_ports[i]->port);
 }
 
 static int __exit pmz_detach(struct platform_device *pdev)
 {
+	uart_remove_one_port(&pmz_uart_reg, &uap->port);
 	return 0;
 }
 
@@ -1956,38 +1813,13 @@ static struct console pmz_console = {
  */
 static int __init pmz_register(void)
 {
-	int i, rc;
-	
 	pmz_uart_reg.nr = pmz_ports_count;
 	pmz_uart_reg.cons = PMACZILOG_CONSOLE;
 
 	/*
 	 * Register this driver with the serial core
 	 */
-	rc = uart_register_driver(&pmz_uart_reg);
-	if (rc)
-		return rc;
-
-	/*
-	 * Register each port with the serial core
-	 */
-	for (i = 0; i < pmz_ports_count; i++) {
-		struct uart_pmac_port *uport = &pmz_ports[i];
-		/* NULL node may happen on wallstreet */
-		if (uport->node != NULL)
-			rc = uart_add_one_port(&pmz_uart_reg, &uport->port);
-		if (rc)
-			goto err_out;
-	}
-
-	return 0;
-err_out:
-	while (i-- > 0) {
-		struct uart_pmac_port *uport = &pmz_ports[i];
-		uart_remove_one_port(&pmz_uart_reg, &uport->port);
-	}
-	uart_unregister_driver(&pmz_uart_reg);
-	return rc;
+	return uart_register_driver(&pmz_uart_reg);
 }
 
 #ifdef CONFIG_PPC_PMAC
@@ -2086,10 +1918,8 @@ static void __exit exit_pmz(void)
 
 	for (i = 0; i < pmz_ports_count; i++) {
 		struct uart_pmac_port *uport = &pmz_ports[i];
-		if (uport->node != NULL) {
-			uart_remove_one_port(&pmz_uart_reg, &uport->port);
+		if (uport->node != NULL)
 			pmz_dispose_port(uport);
-		}
 	}
 	/* Unregister UART driver */
 	uart_unregister_driver(&pmz_uart_reg);
@@ -2116,8 +1946,6 @@ static void pmz_console_write(struct console *con, const char *s, unsigned int c
 	struct uart_pmac_port *uap = &pmz_ports[con->index];
 	unsigned long flags;
 
-	if (ZS_IS_ASLEEP(uap))
-		return;
 	spin_lock_irqsave(&uap->port.lock, flags);
 
 	/* Turn of interrupts and enable the transmitter. */
@@ -2162,8 +1990,10 @@ static int __init pmz_console_setup(struct console *co, char *options)
 	if (co->index >= pmz_ports_count)
 		co->index = 0;
 	uap = &pmz_ports[co->index];
+#ifdef CONFIG_PPC_PMAC
 	if (uap->node == NULL)
 		return -ENODEV;
+#endif
 	port = &uap->port;
 
 	/*
diff --git a/drivers/tty/serial/pmac_zilog.h b/drivers/tty/serial/pmac_zilog.h
index cbc34fb..9ae4556 100644
--- a/drivers/tty/serial/pmac_zilog.h
+++ b/drivers/tty/serial/pmac_zilog.h
@@ -2,9 +2,12 @@
 #define __PMAC_ZILOG_H__
 
 #ifdef CONFIG_PPC_PMAC
-#define pmz_debug(fmt, arg...)	dev_dbg(&uap->dev->ofdev.dev, fmt, ## arg)
-#define pmz_error(fmt, arg...)	dev_err(&uap->dev->ofdev.dev, fmt, ## arg)
-#define pmz_info(fmt, arg...)	dev_info(&uap->dev->ofdev.dev, fmt, ## arg)
+/* We cannot use dev_* because this can be called early, way before
+ * we are matched with a device (when using it as a kernel console)
+ */
+#define pmz_debug(fmt, arg...)	pr_debug("ttyPZ%d: " fmt, uap->port.line, ## arg)
+#define pmz_error(fmt, arg...)	pr_err("ttyPZ%d: " fmt, uap->port.line, ## arg)
+#define pmz_info(fmt, arg...)	pr_info("ttyPZ%d: " fmt, uap->port.line, ## arg)
 #else
 #define pmz_debug(fmt, arg...)	dev_dbg(&uap->node->dev, fmt, ## arg)
 #define pmz_error(fmt, arg...)	dev_err(&uap->node->dev, fmt, ## arg)
@@ -35,7 +38,7 @@ struct uart_pmac_port {
 	 */
 	struct device_node		*node;
 #else
-	struct platform_device		*node;
+	struct platform_device		*pdev;
 #endif
 
 	/* Port type as obtained from device tree (IRDA, modem, ...) */
@@ -50,14 +53,11 @@ struct uart_pmac_port {
 #define PMACZILOG_FLAG_REGS_HELD	0x00000010
 #define PMACZILOG_FLAG_TX_STOPPED	0x00000020
 #define PMACZILOG_FLAG_TX_ACTIVE	0x00000040
-#define PMACZILOG_FLAG_ENABLED          0x00000080
 #define PMACZILOG_FLAG_IS_IRDA		0x00000100
 #define PMACZILOG_FLAG_IS_INTMODEM	0x00000200
 #define PMACZILOG_FLAG_HAS_DMA		0x00000400
 #define PMACZILOG_FLAG_RSRC_REQUESTED	0x00000800
-#define PMACZILOG_FLAG_IS_ASLEEP	0x00001000
 #define PMACZILOG_FLAG_IS_OPEN		0x00002000
-#define PMACZILOG_FLAG_IS_IRQ_ON	0x00004000
 #define PMACZILOG_FLAG_IS_EXTCLK	0x00008000
 #define PMACZILOG_FLAG_BREAK		0x00010000
 
@@ -74,6 +74,8 @@ struct uart_pmac_port {
 	volatile struct dbdma_regs	__iomem *rx_dma_regs;
 #endif
 
+	unsigned char			irq_name[8];
+
 	struct ktermios			termios_cache;
 };
 
@@ -388,9 +390,7 @@ static inline void zssync(struct uart_pmac_port *port)
 #define ZS_IS_IRDA(UP)			((UP)->flags & PMACZILOG_FLAG_IS_IRDA)
 #define ZS_IS_INTMODEM(UP)		((UP)->flags & PMACZILOG_FLAG_IS_INTMODEM)
 #define ZS_HAS_DMA(UP)			((UP)->flags & PMACZILOG_FLAG_HAS_DMA)
-#define ZS_IS_ASLEEP(UP)		((UP)->flags & PMACZILOG_FLAG_IS_ASLEEP)
 #define ZS_IS_OPEN(UP)			((UP)->flags & PMACZILOG_FLAG_IS_OPEN)
-#define ZS_IS_IRQ_ON(UP)		((UP)->flags & PMACZILOG_FLAG_IS_IRQ_ON)
 #define ZS_IS_EXTCLK(UP)		((UP)->flags & PMACZILOG_FLAG_IS_EXTCLK)
 
 #endif /* __PMAC_ZILOG_H__ */
-- 
1.7.7.3
