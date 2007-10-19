Return-Path: <torvalds@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 63B05DDEA0
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 13:27:45 +1000 (EST)
Date: Thu, 18 Oct 2007 20:26:45 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] synchronize_irq needs a barrier
In-Reply-To: <alpine.LFD.0.999.0710181941020.26902@woody.linux-foundation.org>
Message-ID: <alpine.LFD.0.999.0710182007170.26902@woody.linux-foundation.org>
References: <E1IiWnJ-0000ne-00@gondolin.me.apana.org.au>
	<1192745137.7367.40.camel@pasglop>
	<alpine.LFD.0.999.0710181549330.26902@woody.linux-foundation.org>
	<1192749449.7367.51.camel@pasglop>
	<alpine.LFD.0.999.0710181627091.26902@woody.linux-foundation.org>
	<20071019023219.GB8453@gondor.apana.org.au>
	<alpine.LFD.0.999.0710181941020.26902@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Thu, 18 Oct 2007, Linus Torvalds wrote:
>
> I *think* it should work with something like
> 
> 	for (;;) {
> 		smp_rmb();
> 		if (!spin_is_locked(&desc->lock)) {
> 			smp_rmb();
> 			if (!(desc->status & IRQ_INPROGRESS)
> 				break;
> 		}
> 		cpu_relax();
> 	}

I'm starting to doubt this. 

One of the issues is that we still need the smp_mb() in front of the loop 
(because we want to serialize the loop with any writes in the caller).

The other issue is that I don't think it's enough that we saw the 
descriptor lock unlocked, and then the IRQ_INPROGRESS bit clear. It might 
have been unlocked *while* the IRQ was in progress, but the interrupt 
handler is now in its last throes, and re-takes the spinlock and clears 
the IRQ_INPROGRESS thing. But we're not actually happy until we've seen 
the IRQ_INPROGRESS bit clear and the spinlock has been released *again*.

So those two tests should actually be the other way around: we want to see 
the IRQ_INPROGRESS bit clear first.

It's all just too damn subtle and clever. Something like this should not 
need to be that subtle. 

Maybe the rigth thing to do is to not rely on *any* ordering what-so-ever, 
and just make the rule be: "if you look at the IRQ_INPROGRESS bit, you'd 
better hold the descriptor spinlock", and not have any subtle ordering 
issues at all.

But that makes us have a loop with getting/releasing the lock all the 
time, and then we get back to horrid issues with cacheline bouncing and 
unfairness of cache accesses across cores (ie look at the issues we had 
with the runqueue starvation in wait_task_inactive()).

Those were fixed by starting out with the non-locked and totally unsafe 
versions, but then having one last "check with lock held, and repeat only 
if that says things went south". 

See commit fa490cfd15d7ce0900097cc4e60cfd7a76381138 and ponder. Maybe we 
should take the same approach here, and do something like

	repeat:
		/* Optimistic, no-locking loop */
		while (desc->status & IRQ_INPROGRESS)
			cpu_relax();

		/* Ok, that indicated we're done: double-check carefully */
		spin_lock_irqsave(&desc->lock, flags);
		status = desc->status;
		spin_unlock_irqrestore(&desc->lock, flags);

		/* Oops, that failed? */
		if (status & IRQ_INPROGRESS)
			goto repeat;

Hmm?

			Linus
