Return-Path: <gknispel@proformatique.com>
Date: Sun, 18 Apr 2010 16:46:14 +0200
From: Guillaume Knispel <gknispel@proformatique.com>
To: linux-kernel@vger.kernel.org, Linuxppc-dev@lists.ozlabs.org
Subject: Re: Pending interrupts not always replayed
Message-ID: <20100418164614.771d4f01@xilun.lan.proformatique.com>
In-Reply-To: <20100418053439.4d2ffe11@xilun.lan.proformatique.com>
References: <20100418053439.4d2ffe11@xilun.lan.proformatique.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Buesch <mb@bu3sch.de>, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 18 Apr 2010 05:34:39 +0200
Guillaume Knispel <gknispel@proformatique.com> wrote:

> From reading the code (kernel/irq stuffs), it seems that at least some
> handle_edge_irq based interrupts are not replayed when enabling if
> desc->chip->retrigger == NULL and on a platform where
> CONFIG_HARDIRQS_SW_RESEND is not set (which for now is only defined for
> (some?) arm and avr32). Depending on the pic this problem might
> be masked if multiple interrupts are received between disable_irq and
> enable_irq (maybe other conditions exist with controllers i don't know).
> 
> I happen to program a PPC SoC (MPC8555E to be precise), using some edge
> interrupts on the PortC of the CPM2 pic (arch/powerpc/sysdev/cpm2_pic.c)
> in a driver that does some enable_irq/disable_irq while various
> patterns of interrupts are received and i think i've hit the problem.
> 
> Is the behavior intended (not always replaying edge triggered interrupts)
> or is it just a bug to fix?
> 
> Anybody knows if it's safe to activate CONFIG_HARDIRQS_SW_RESEND for a
> powerpc or are there some known dangerous interactions?
> (I'll give it a try on my side in the meantime anyway)

A follow up on this issue and on my CONFIG_HARDIRQS_SW_RESEND tests:
I've basically done this:

Index: linux-2.6.22.18/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.22.18.orig/arch/powerpc/Kconfig   2010-04-18 15:22:24.000000000 +0200
+++ linux-2.6.22.18/arch/powerpc/Kconfig        2010-04-18 15:23:21.000000000 +0200
@@ -35,6 +35,10 @@
        bool
        default y
 
+config HARDIRQS_SW_RESEND
+       bool
+       default y
+
 config IRQ_PER_CPU
        bool
        default y

(yeah, I know, old kernel, but the code involved hasn't change much
 since)

and of course +CONFIG_HARDIRQS_SW_RESEND=y in my .config

Now everything seems to work fine: my device was not previously not
interrupting anymore after typically 1 or 2 minutes (because the
interrupt signal stays at level low until the device is served, so
if one falling edge is missed no more interruption will ever be seen),
and right now it has been running for 1 hour without any observable
problem.

Cheers!
-- 
Guillaume Knispel
