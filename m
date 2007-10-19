Return-Path: <torvalds@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BA681DDEBA
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 12:57:16 +1000 (EST)
Date: Thu, 18 Oct 2007 19:55:47 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] synchronize_irq needs a barrier
In-Reply-To: <20071019023219.GB8453@gondor.apana.org.au>
Message-ID: <alpine.LFD.0.999.0710181941020.26902@woody.linux-foundation.org>
References: <E1IiWnJ-0000ne-00@gondolin.me.apana.org.au>
	<1192745137.7367.40.camel@pasglop>
	<alpine.LFD.0.999.0710181549330.26902@woody.linux-foundation.org>
	<1192749449.7367.51.camel@pasglop>
	<alpine.LFD.0.999.0710181627091.26902@woody.linux-foundation.org>
	<20071019023219.GB8453@gondor.apana.org.au>
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



On Fri, 19 Oct 2007, Herbert Xu wrote:
>
> In other words I think this patch is great :)

Hey, I appreciate it, but I do think that the "spinlock only to 
immediately unlock it again" is pretty horrid.

I'm convinced that there should be some way to do this without actually 
taking the lock. I *think* it should work with something like

	for (;;) {
		smp_rmb();
		if (!spin_is_locked(&desc->lock)) {
			smp_rmb();
			if (!(desc->status & IRQ_INPROGRESS)
				break;
		}
		cpu_relax();
	}

instead. Which basically requires that we see the descriptor lock being 
not held, before we see the IRQ_INPROGRESS bit being clear. Put another 
way: it loops until it sees the lock having been released, and the 
IRQ_INPROGRESS bit being clear after that.

The above requires no serializing instructions on x86, which is a good 
goal (now that smp_rmb() is just a compiler barrier). And it doesn't 
actually have to bounce any cachelines.

And it doesn't have that ugly "get lock only to release it", which just 
makes me go "Eww!".

But it's a bit subtler. It basically depends on the fact that 
spin_unlock() obviously has to make sure that there is a release barrier 
in the unlock, so any writes done (to the IRQ_INPROGRESS bit) within the 
locked region *must* be visible before the spinlock itself has been 
released.

So somebody should:
 - use another pair of eyes and brains to back me up on this.
 - write up some coherent changelog entry, using the emails that have 
   passed back and forth.
 - actually turn the above into a tested patch with a comment.

And I'm pushing for that "somebody" being somebody else than me ;)

			Linus
