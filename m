Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0096FDDDD8
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 19:31:00 +1100 (EST)
Subject: Re: Bug in "genirq: record trigger type"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
In-Reply-To: <200810210101.19741.david-b@pacbell.net>
References: <200810202205.m9KM5une024759@hera.kernel.org>
	<1224570730.7654.242.camel@pasglop>
	<200810210101.19741.david-b@pacbell.net>
Content-Type: text/plain
Date: Tue, 21 Oct 2008 19:29:54 +1100
Message-Id: <1224577794.7654.253.camel@pasglop>
Mime-Version: 1.0
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-10-21 at 01:01 -0700, David Brownell wrote:
> 
> I'm a bit more curious about another potential issue though ... as
> described in the patch comment:
> 
>      - Make set_irq_type() usage match request_irq() usage:
>         * IRQ_TYPE_NONE should be a NOP; succeed, so irq_chip methods
>           won't have to handle that case any more (many do it wrong).
> 
> It might be a bit more accurate to say irq_chip.set_type() methods
> are *inconsistent* in handling IRQ_TYPE_NONE.  Previously the
> set_irq_type() method would pass that down to irq_chip code. 
> 
> I had observed two behaviors, but I thought I observed a third one
> in some of the PowerPC code:
> 
>  (1) ignore it ... matching request_irq() usage
>  (2) return an error ... nasty
>  (3) assign some irq_chip-specific trigger mode
> 
> That third behavior might cause a bit of trouble, but I think
> it was only used during platform init.  Someone more attuned
> to PowerPC might want to check ...

Ok, I wrote a lot of the port of powerpc stuff to genirq so I supposed
I'm the person to do that sweep :-) I'll have a look tomorrow.

Thanks for the heads up,

Cheers,
Ben.
