Return-Path: <david-b@pacbell.net>
Received: from smtp120.sbc.mail.sp1.yahoo.com (smtp120.sbc.mail.sp1.yahoo.com
	[69.147.64.93]) by ozlabs.org (Postfix) with SMTP id C233FDDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 19:01:22 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: benh@kernel.crashing.org
Subject: Re: Bug in "genirq: record trigger type"
Date: Tue, 21 Oct 2008 01:01:19 -0700
References: <200810202205.m9KM5une024759@hera.kernel.org>
	<1224570730.7654.242.camel@pasglop>
In-Reply-To: <1224570730.7654.242.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200810210101.19741.david-b@pacbell.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 20 October 2008, Benjamin Herrenschmidt wrote:
> This one is obviously broken and breaks booting on a whole bunch of
> machines (including powermac's and thus my G5, it's never good when my
> own machine breaks !).
> 
> Nice to see 3 SOB's and one Ack and nobody caught the obvious bug :-)

As you saw, that one's fixed.  Chris' patch unfortunately didn't
get integrated right away.


I'm a bit more curious about another potential issue though ... as
described in the patch comment:

     - Make set_irq_type() usage match request_irq() usage:
        * IRQ_TYPE_NONE should be a NOP; succeed, so irq_chip methods
          won't have to handle that case any more (many do it wrong).

It might be a bit more accurate to say irq_chip.set_type() methods
are *inconsistent* in handling IRQ_TYPE_NONE.  Previously the
set_irq_type() method would pass that down to irq_chip code. 

I had observed two behaviors, but I thought I observed a third one
in some of the PowerPC code:

 (1) ignore it ... matching request_irq() usage
 (2) return an error ... nasty
 (3) assign some irq_chip-specific trigger mode

That third behavior might cause a bit of trouble, but I think
it was only used during platform init.  Someone more attuned
to PowerPC might want to check ...

- Dave
