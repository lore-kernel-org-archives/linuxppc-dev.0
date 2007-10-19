Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp105.mail.mud.yahoo.com (smtp105.mail.mud.yahoo.com
	[209.191.85.215]) by ozlabs.org (Postfix) with SMTP id A5CEFDDE23
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 12:59:27 +1000 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] synchronize_irq needs a barrier
Date: Fri, 19 Oct 2007 12:52:17 +1000
References: <E1IiWnJ-0000ne-00@gondolin.me.apana.org.au>
	<alpine.LFD.0.999.0710181627091.26902@woody.linux-foundation.org>
	<20071019023219.GB8453@gondor.apana.org.au>
In-Reply-To: <20071019023219.GB8453@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710191252.18272.nickpiggin@yahoo.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 19 October 2007 12:32, Herbert Xu wrote:

> First of all let's agree on some basic assumptions:
>
> * A pair of spin lock/unlock subsumes the effect of a full mb.

Not unless you mean a pair of spin lock/unlock as in
2 spin lock/unlock pairs (4 operations).

*X = 10;
spin_lock(&lock);
/* *Y speculatively loaded here */
/* store to *X leaves CPU store queue here */
spin_unlock(&lock);
y = *Y;

> * A spin lock in general only equates to (SS/SL/LL).
> * A spin unlock in general only equates to (SS/LS).

I don't use the sparc barriers, so they don't come naturally to
me ;)

I think both loads and stores can pass into the critical section
by having the spin_lock pass earlier ops, or by having spin_unlock
be passed by later ones.


> In particular, a load after a spin unlock may pass before the
> spin unlock.
>
> Here is the race (with tg3 as the only example that I know of).
> The driver attempts to quiesce interrupts such that after the
> call to synchronize_irq it is intended that no further IRQ
> handler calls for that device will do any work besides acking
> the IRQ.
>
> Here is how it does it:
>
> CPU0				CPU1
> 				spin lock
> 					load irq_sync
> irq_sync = 1
> smp_mb
> synchronize_irq()
> 	while (IRQ_INPROGRESS)
> 		wait
> 	return
> 				set IRQ_INPROGRESS
> 				spin unlock
> 				tg3_msi
> 					ack IRQ
> 					if (irq_sync)
> 						return
> 					do work
>
> The problem here is that load of irq_sync in the handler has
> passed above the setting of IRQ_INPROGRESS.
>
> Linus's patch fixes it because this becomes:
>
> CPU0				CPU1
> 				spin lock
> 					load irq_sync
> irq_sync = 1
> smp_mb
> synchronize_irq
> 				set IRQ_INPROGRESS
> 				spin unlock
> 	spin lock
> 	spin unlock
> 				tg3_msi
> 					ack IRQ
> 					if (irq_sync)
> 						return
> 					do work
> 	while (IRQ_INPROGRESS)
> 		wait
> 				spin lock
> 				clear IRQ_INPROGRESS
> 				spin unlock
> 	return
>
> Even though we still do the work on the right we will now notice
> the INPROGRESS flag on the left and wait.
>
> It's hard to fix this in the drivers because they'd either have
> to access the desc lock or add a full mb to the fast path on the
> right.
>
> Once this goes in we can also remove the smp_mb from tg3.c.  BTW,
> a lot of drivers (including the fusion example Ben quoted) call
> synchronize_irq before free_irq.  This is unnecessary because
> the latter already calls it anyway.
>
> Cheers,
