Return-Path: <fthain@telegraphics.com.au>
Received: from vps4.telegraphics.com.au (vm4.telegraphics.com.au
 [98.124.60.149]) by ozlabs.org (Postfix) with ESMTP id 24D781007D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2011 02:13:55 +1100 (EST)
Date: Wed, 7 Dec 2011 02:13:41 +1100 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 01/16 v2] pmac_zilog: fix unexpected irq
In-Reply-To: <20111023141115.208699274@telegraphics.com.au>
Message-ID: <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
References: <20111023141108.856998818@telegraphics.com.au>
 <20111023141115.208699274@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On most 68k Macs the SCC IRQ is an autovector interrupt and cannot be 
masked. This can be a problem when pmac_zilog starts up.

For example, the serial debugging code in arch/m68k/kernel/head.S may be 
used beforehand. It disables the SCC interrupts at the chip but doesn't 
ack them. Then when a pmac_zilog port is opened and SCC chip interrupts 
become enabled, the machine locks up with "unexpected interrupt" because 
request_irq() hasn't happened yet.

Fix this by setting the interrupt enable bits only after the handler is 
installed and before it is uninstalled. Also move this bit flipping into a 
separate pmz_interrupt_control() routine. Replace all instances of these 
operations with calls to this routine.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---

Re-implemented since v1 using a simpler approach that avoids messing with 
the Master Interrupt Enable bit. As well as the ifdef problem, it turns 
out that v1 was not sufficient to entirely fix the problem.

This patch has been tested on a PowerBook 520 but no PowerMacs yet.

Index: linux-git/drivers/tty/serial/pmac_zilog.c
===================================================================
--- linux-git.orig/drivers/tty/serial/pmac_zilog.c	2011-12-07 01:56:43.000000000 +1100
+++ linux-git/drivers/tty/serial/pmac_zilog.c	2011-12-07 01:56:55.000000000 +1100
@@ -216,6 +216,18 @@ static void pmz_maybe_update_regs(struct
 	}
 }
 
+static void pmz_interrupt_control(struct uart_pmac_port *uap, int enable)
+{
+	if (enable) {
+		uap->curregs[1] |= INT_ALL_Rx | TxINT_ENAB;
+		if (!ZS_IS_EXTCLK(uap))
+			uap->curregs[1] |= EXT_INT_ENAB;
+	} else {
+		uap->curregs[1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
+	}
+	write_zsreg(uap, R1, uap->curregs[1]);
+}
+
 static struct tty_struct *pmz_receive_chars(struct uart_pmac_port *uap)
 {
 	struct tty_struct *tty = NULL;
@@ -339,9 +351,7 @@ static struct tty_struct *pmz_receive_ch
 
 	return tty;
  flood:
-	uap->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
-	write_zsreg(uap, R1, uap->curregs[R1]);
-	zssync(uap);
+	pmz_interrupt_control(uap, 0);
 	pmz_error("pmz: rx irq flood !\n");
 	return tty;
 }
@@ -990,12 +1000,9 @@ static int pmz_startup(struct uart_port
 	if (ZS_IS_IRDA(uap))
 		pmz_irda_reset(uap);
 
-	/* Enable interrupts emission from the chip */
+	/* Enable interrupt requests for the channel */
 	spin_lock_irqsave(&port->lock, flags);
-	uap->curregs[R1] |= INT_ALL_Rx | TxINT_ENAB;
-	if (!ZS_IS_EXTCLK(uap))
-		uap->curregs[R1] |= EXT_INT_ENAB;
-	write_zsreg(uap, R1, uap->curregs[R1]);
+	pmz_interrupt_control(uap, 1);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	pmz_debug("pmz: startup() done.\n");
@@ -1015,6 +1022,25 @@ static void pmz_shutdown(struct uart_por
 
 	mutex_lock(&pmz_irq_mutex);
 
+	if (!ZS_IS_ASLEEP(uap)) {
+		spin_lock_irqsave(&port->lock, flags);
+
+		if (!ZS_IS_CONS(uap)) {
+			/* Disable receiver and transmitter */
+			uap->curregs[R3] &= ~RxENABLE;
+			uap->curregs[R5] &= ~TxENABLE;
+
+			/* Disable BRK assertion */
+			uap->curregs[R5] &= ~SND_BRK;
+			pmz_maybe_update_regs(uap);
+		}
+
+		/* Disable interrupt requests for the channel */
+		pmz_interrupt_control(uap, 0);
+
+		spin_unlock_irqrestore(&port->lock, flags);
+	}
+
 	/* Release interrupt handler */
 	free_irq(uap->port.irq, uap);
 
@@ -1025,29 +1051,8 @@ static void pmz_shutdown(struct uart_por
 	if (!ZS_IS_OPEN(uap->mate))
 		pmz_get_port_A(uap)->flags &= ~PMACZILOG_FLAG_IS_IRQ_ON;
 
-	/* Disable interrupts */
-	if (!ZS_IS_ASLEEP(uap)) {
-		uap->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
-		write_zsreg(uap, R1, uap->curregs[R1]);
-		zssync(uap);
-	}
-
-	if (ZS_IS_CONS(uap) || ZS_IS_ASLEEP(uap)) {
-		spin_unlock_irqrestore(&port->lock, flags);
-		mutex_unlock(&pmz_irq_mutex);
-		return;
-	}
-
-	/* Disable receiver and transmitter.  */
-	uap->curregs[R3] &= ~RxENABLE;
-	uap->curregs[R5] &= ~TxENABLE;
-
-	/* Disable all interrupts and BRK assertion.  */
-	uap->curregs[R5] &= ~SND_BRK;
-	pmz_maybe_update_regs(uap);
-
-	/* Shut the chip down */
-	pmz_set_scc_power(uap, 0);
+	if (!ZS_IS_ASLEEP(uap) && !ZS_IS_CONS(uap))
+		pmz_set_scc_power(uap, 0);	/* Shut the chip down */
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
@@ -1352,19 +1357,15 @@ static void pmz_set_termios(struct uart_
 	spin_lock_irqsave(&port->lock, flags);	
 
 	/* Disable IRQs on the port */
-	uap->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
-	write_zsreg(uap, R1, uap->curregs[R1]);
+	pmz_interrupt_control(uap, 0);
 
 	/* Setup new port configuration */
 	__pmz_set_termios(port, termios, old);
 
 	/* Re-enable IRQs on the port */
-	if (ZS_IS_OPEN(uap)) {
-		uap->curregs[R1] |= INT_ALL_Rx | TxINT_ENAB;
-		if (!ZS_IS_EXTCLK(uap))
-			uap->curregs[R1] |= EXT_INT_ENAB;
-		write_zsreg(uap, R1, uap->curregs[R1]);
-	}
+	if (ZS_IS_OPEN(uap))
+		pmz_interrupt_control(uap, 1);
+
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -1670,15 +1671,13 @@ static int pmz_suspend(struct macio_dev
 
 	spin_lock_irqsave(&uap->port.lock, flags);
 
+	/* Disable receiver and transmitter.  */
+	uap->curregs[R3] &= ~RxENABLE;
+	uap->curregs[R5] &= ~TxENABLE;
+
+	pmz_interrupt_control(uap, 0);
+
 	if (ZS_IS_OPEN(uap) || ZS_IS_CONS(uap)) {
-		/* Disable receiver and transmitter.  */
-		uap->curregs[R3] &= ~RxENABLE;
-		uap->curregs[R5] &= ~TxENABLE;
-
-		/* Disable all interrupts and BRK assertion.  */
-		uap->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
-		uap->curregs[R5] &= ~SND_BRK;
-		pmz_load_zsregs(uap, uap->curregs);
 		uap->flags |= PMACZILOG_FLAG_IS_ASLEEP;
 		mb();
 	}
@@ -1738,14 +1737,6 @@ static int pmz_resume(struct macio_dev *
 	/* Take care of config that may have changed while asleep */
 	__pmz_set_termios(&uap->port, &uap->termios_cache, NULL);
 
-	if (ZS_IS_OPEN(uap)) {
-		/* Enable interrupts */		
-		uap->curregs[R1] |= INT_ALL_Rx | TxINT_ENAB;
-		if (!ZS_IS_EXTCLK(uap))
-			uap->curregs[R1] |= EXT_INT_ENAB;
-		write_zsreg(uap, R1, uap->curregs[R1]);
-	}
-
 	spin_unlock_irqrestore(&uap->port.lock, flags);
 
 	if (ZS_IS_CONS(uap))
@@ -1757,6 +1748,12 @@ static int pmz_resume(struct macio_dev *
 		enable_irq(uap->port.irq);
 	}
 
+	if (ZS_IS_OPEN(uap)) {
+		spin_lock_irqsave(&uap->port.lock, flags);
+		pmz_interrupt_control(uap, 1);
+		spin_unlock_irqrestore(&uap->port.lock, flags);
+	}
+
  bail:
 	mutex_unlock(&state->port.mutex);
 	mutex_unlock(&pmz_irq_mutex);
