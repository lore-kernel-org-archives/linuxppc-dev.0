Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	by ozlabs.org (Postfix) with ESMTP id 432C4B7B6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Dec 2009 23:42:59 +1100 (EST)
From: Rob Landley <rob@landley.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] Re: ZILOG serial port broken in 2.6.32
Date: Tue, 8 Dec 2009 06:42:50 -0600
References: <200912060101.22515.rob@landley.net>
	<1260148248.2076.1348.camel@pasglop>
In-Reply-To: <1260148248.2076.1348.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <200912080642.52103.rob@landley.net>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 06 December 2009 19:10:48 Benjamin Herrenschmidt wrote:
> On Sun, 2009-12-06 at 01:01 -0600, Rob Landley wrote:
> > Trying again with a few likely-looking cc's from the MAINTAINERS file:
> >
> > Summary:
> >
> > The PMACZILOG serial driver last worked in 2.6.28.  It was broken by
> > commit f751928e0ddf54ea4fe5546f35e99efc5b5d9938 by Alan Cox making bits
> > of the tty layer dynamically allocated.  The PMACZILOG driver wasn't
> > properly converted, it works with interrupts disabled (for boot
> > messages), but as soon as interrupts are enabled (PID 1 spawns) the next
> > write to the serial console panics the kernel.
>
> Ah looks like I missed that... I'll dig. Thanks for the report.
>
> Cheers,
> Ben.

Ok, here's the fix.  It's not the _right_ fix, but it Works For Me (tm) and I'll
leave it to you guys to figure out what this _means_:

Signed-off-by: Rob Landley <rob@landley.net>

diff -ru build/packages/linux/drivers/serial/serial_core.c build/packages/linux2/drivers/serial/serial_core.c
--- build/packages/linux/drivers/serial/serial_core.c	2009-12-02 21:51:21.000000000 -0600
+++ build/packages/linux2/drivers/serial/serial_core.c	2009-12-08 06:17:06.000000000 -0600
@@ -113,7 +113,7 @@
 static void uart_tasklet_action(unsigned long data)
 {
 	struct uart_state *state = (struct uart_state *)data;
-	tty_wakeup(state->port.tty);
+	if (state->port.tty) tty_wakeup(state->port.tty);
 }
 
 static inline void

That one line workaround makes the panic go away, and things seem to work fine from there.

I note that pmac_zilog.c function pmz_receiv_chars() has the following chunk:

        /* Sanity check, make sure the old bug is no longer happening */
        if (uap->port.state == NULL || uap->port.state->port.tty == NULL) {
                WARN_ON(1);
                (void)read_zsdata(uap);
                return NULL;
        }

Which doesn't catch this because it's the write code path (not the read code path) that's running into 
this.

Rob
-- 
Latency is more important than throughput. It's that simple. - Linus Torvalds
