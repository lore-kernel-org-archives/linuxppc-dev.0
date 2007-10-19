Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp105.mail.mud.yahoo.com (smtp105.mail.mud.yahoo.com
	[209.191.85.215]) by ozlabs.org (Postfix) with SMTP id 34856DDDD5
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 14:49:59 +1000 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] synchronize_irq needs a barrier
Date: Fri, 19 Oct 2007 14:49:29 +1000
References: <E1IiiX6-0002V0-00@gondolin.me.apana.org.au>
In-Reply-To: <E1IiiX6-0002V0-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710191449.30027.nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, tglx@linutronix.de,
	akpm@linux-foundation.org, torvalds@linux-foundation.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 19 October 2007 13:28, Herbert Xu wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >> First of all let's agree on some basic assumptions:
> >>
> >> * A pair of spin lock/unlock subsumes the effect of a full mb.
> >
> > Not unless you mean a pair of spin lock/unlock as in
> > 2 spin lock/unlock pairs (4 operations).
> >
> > *X = 10;
> > spin_lock(&lock);
> > /* *Y speculatively loaded here */
> > /* store to *X leaves CPU store queue here */
> > spin_unlock(&lock);
> > y = *Y;
>
> Good point.
>
> Although in this case we're still safe because in the worst
> cases:
>
> CPU0				CPU1
> irq_sync = 1
> synchronize_irq
> 	spin lock
> 	load IRQ_INPROGRESS
> irq_sync sync is visible
> 	spin unlock
> 				spin lock
> 					load irq_sync
> 	while (IRQ_INPROGRESS)
> 		wait
> 	return
> 				set IRQ_INPROGRESS
> 				spin unlock
> 				tg3_msi
> 					ack IRQ
> 					if (irq_sync)
> 						return
> 				spin lock
> 				clear IRQ_INPROGRESS
> 				spin unlock
>
> ------------------------------------------------------------
>
> CPU0				CPU1
> 				spin lock
> 					load irq_sync
> irq_sync = 1
> synchronize_irq
> 				set IRQ_INPROGRESS
> 				spin unlock
> 	spin lock
> 	load IRQ_INPROGRESS
> irq_sync sync is visible
> 	spin unlock
> 	while (IRQ_INPROGRESS)
> 		wait
> 				tg3_msi
> 					ack IRQ
> 					if (irq_sync)
> 						return
> 					do work
> 				spin lock
> 				clear IRQ_INPROGRESS
> 				spin unlock
> 	return
>
> So because we're using the same lock on both sides, it does
> do the right thing even without the memory barrier.


Yeah, if you've got the lock on both sides there, then I
agree it will be correct.
