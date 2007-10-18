Return-Path: <torvalds@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CE67DDDE39
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 12:12:30 +1000 (EST)
Date: Wed, 17 Oct 2007 19:12:20 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] synchronize_irq needs a barrier
In-Reply-To: <1192670742.12879.5.camel@pasglop>
Message-ID: <alpine.LFD.0.999.0710171906150.26902@woody.linux-foundation.org>
References: <1192670742.12879.5.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Thu, 18 Oct 2007, Benjamin Herrenschmidt wrote:
>  
> +	smp_mb();
>  	while (desc->status & IRQ_INPROGRESS)
>  		cpu_relax();

So, what exactly does it protect against? At a minimum, this needs a 
comment in the changelog, and probably preferably in the source code too.

The thing is, synchronize_irq() can only protect against interrupts that 
are *already*running* on another CPU, and the caller must have made sure 
that no new interrupts are coming in (or at least that whatever new 
interrupts that come in will not pick up a certain piece of data). 

So I can imagine that the smb_mb() is there so that the caller - who has 
cleared some list or done something like that - will have any preceding 
writes that it did be serialized with actually checking the old state of 
"desc->status".

Fair enough - I can see that a smp_mb() is useful. But I think it needs 
documenting as such, and preferably with an example of how this actually 
happened in the first place (do you have one?)

The synchronize_irq() users that are really fundamental (ie the irq 
datastructures themselves) all should use the irq descriptor spinlock, and 
should *not* be needing any of this, since they would have serialized with 
whoever actually set the IRQ_INPROGRESS bit in the first place.

So in *that* sense, I think the memory barrier is useless, and I can't 
make up my mind whether it's good or bad. Which is why I'd really like to 
have an example scenario spelled out where it makes a difference..

Ok?

		Linus
