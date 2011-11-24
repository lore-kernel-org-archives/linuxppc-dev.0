Return-Path: <fthain@telegraphics.com.au>
Received: from vps4.telegraphics.com.au (vm4.telegraphics.com.au
 [98.124.60.149]) by ozlabs.org (Postfix) with ESMTP id 9DE741007D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 01:35:09 +1100 (EST)
Date: Fri, 25 Nov 2011 01:34:58 +1100 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 01/16] pmac_zilog: fix unexpected irq
In-Reply-To: <20111023141115.208699274@telegraphics.com.au>
Message-ID: <alpine.LNX.2.00.1111250133321.6314@nippy.intranet>
References: <20111023141108.856998818@telegraphics.com.au>
 <20111023141115.208699274@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
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

Fix this by setting the SCC master interrupt enable bit only after the 
handler is installed. This is achieved by extracting that operation out of 
__pmz_startup() and placing it into a seperate routine.

A similar problem arises when the irq is freed. Fix this by resetting the 
chip first (on m68k mac).

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

---

This patch has been tested on a variety of m68k Macs but no PowerMacs.

I am re-sending this patch Cc linux-serial. It still needs a suitable ack 
so that Geert can push it through his tree.

Index: linux-m68k/drivers/tty/serial/pmac_zilog.c
===================================================================
--- linux-m68k.orig/drivers/tty/serial/pmac_zilog.c	2011-10-22 23:02:22.000000000 +1100
+++ linux-m68k/drivers/tty/serial/pmac_zilog.c	2011-10-22 23:02:38.000000000 +1100
@@ -910,8 +910,8 @@ static int __pmz_startup(struct uart_pma
 	/* Clear handshaking, enable BREAK interrupts */
 	uap->curregs[R15] = BRKIE;
 
-	/* Master interrupt enable */
-	uap->curregs[R9] |= NV | MIE;
+	/* No vector */
+	uap->curregs[R9] |= NV;
 
 	pmz_load_zsregs(uap, uap->curregs);
 
@@ -925,6 +925,17 @@ static int __pmz_startup(struct uart_pma
 	return pwr_delay;
 }
 
+static void pmz_master_int_control(struct uart_pmac_port *uap, int enable)
+{
+	if (enable) {
+		uap->curregs[R9] |= MIE; /* Master interrupt enable */
+		write_zsreg(uap, R9, uap->curregs[R9]);
+	} else {
+		uap->curregs[R9] &= ~MIE;
+		write_zsreg(uap, 9, FHWRES);
+	}
+}
+
 static void pmz_irda_reset(struct uart_pmac_port *uap)
 {
 	uap->curregs[R5] |= DTR;
@@ -976,6 +987,19 @@ static int pmz_startup(struct uart_port
 		return -ENXIO;
 	}
 
+	/*
+	 * Most 68k Mac models cannot mask the SCC IRQ so they must enable
+	 * interrupts after the handler is installed and not before.
+	 */
+#ifndef CONFIG_MAC
+	if (!ZS_IS_CONS(uap))
+#endif
+	{
+		spin_lock_irqsave(&port->lock, flags);
+		pmz_master_int_control(uap, 1);
+		spin_unlock_irqrestore(&port->lock, flags);
+	}
+
 	mutex_unlock(&pmz_irq_mutex);
 
 	/* Right now, we deal with delay by blocking here, I'll be
@@ -1015,6 +1039,11 @@ static void pmz_shutdown(struct uart_por
 
 	mutex_lock(&pmz_irq_mutex);
 
+#ifdef CONFIG_MAC
+	if (!ZS_IS_OPEN(uap->mate))
+		pmz_master_int_control(uap, 0);
+#endif
+
 	/* Release interrupt handler */
 	free_irq(uap->port.irq, uap);
 
@@ -1734,6 +1763,7 @@ static int pmz_resume(struct macio_dev *
 		goto bail;
 	}
 	pwr_delay = __pmz_startup(uap);
+	pmz_master_int_control(uap, 1);
 
 	/* Take care of config that may have changed while asleep */
 	__pmz_set_termios(&uap->port, &uap->termios_cache, NULL);
@@ -2178,6 +2208,9 @@ static int __init pmz_console_setup(stru
 	 * Enable the hardware
 	 */
 	pwr_delay = __pmz_startup(uap);
+#ifndef CONFIG_MAC
+	pmz_master_int_control(uap, 1);
+#endif
 	if (pwr_delay)
 		mdelay(pwr_delay);
 	
