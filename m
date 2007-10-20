Return-Path: <torvalds@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F1934DDE9E
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 12:25:46 +1000 (EST)
Date: Fri, 19 Oct 2007 19:25:34 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH] synchronize_irq needs a barrier
In-Reply-To: <200710200402.43106.maximlevitsky@gmail.com>
Message-ID: <alpine.LFD.0.999.0710191924520.3794@woody.linux-foundation.org>
References: <1192670742.12879.5.camel@pasglop>
	<200710200402.43106.maximlevitsky@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: akpm <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Sat, 20 Oct 2007, Maxim Levitsky wrote:
> 
> and the interrupt handler:
> 
> 	smp_rmb();
> 	if (dev->insuspend)
> 		goto out;

Something like that can work, yes. However, you need to make sure that:

 - even when you ignore the interrupt (because the driver doesn't care, 
   it's suspending), you need to make sure the hardware gets shut up by 
   reading (or writing) the proper interrupt status register.

   Otherwise, with a level interrupt, the interrupt will continue to be 
   held active ("screaming") and the CPU will get interrupted over and 
   over again, until the irq subsystem will just turn the irq off 
   entirely.

 - when you resume, make sure that you get the engine going again, with 
   the understanding that some interrupts may have gotten ignored.

Also, in general, these kinds of things shouldn't always even be 
neicessary. If you use the suspend_late()/resume_early() hooks, those will 
be called with interrupts off, and while they can be harder to debug (and 
may be worth avoiding for non-critical drivers), they do allow for simpler 
models partly exactly because they don't need to worry about interrupts 
etc.

		Linus
