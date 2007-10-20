Return-Path: <maximlevitsky@gmail.com>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.235])
	by ozlabs.org (Postfix) with ESMTP id 85835DDEBB
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 13:10:44 +1000 (EST)
Received: by hu-out-0506.google.com with SMTP id 24so1132658hud
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 20:10:42 -0700 (PDT)
From: Maxim Levitsky <maximlevitsky@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] synchronize_irq needs a barrier
Date: Sat, 20 Oct 2007 05:10:01 +0200
References: <1192670742.12879.5.camel@pasglop>
	<200710200402.43106.maximlevitsky@gmail.com>
	<alpine.LFD.0.999.0710191924520.3794@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0710191924520.3794@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710200510.01409.maximlevitsky@gmail.com>
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

On Saturday 20 October 2007 04:25:34 Linus Torvalds wrote:
> 
> On Sat, 20 Oct 2007, Maxim Levitsky wrote:
> > 
> > and the interrupt handler:
> > 
> > 	smp_rmb();
> > 	if (dev->insuspend)
> > 		goto out;
> 
> Something like that can work, yes. However, you need to make sure that:
> 
>  - even when you ignore the interrupt (because the driver doesn't care, 
>    it's suspending), you need to make sure the hardware gets shut up by 
>    reading (or writing) the proper interrupt status register.
I agree, but while device is powered off, its registers can't be accessed
Thus, if I ack the IRQ every time the handler is called, I will access the 
powered off device (this is probably won't hurt a lot, but a bit incorrectly)

> 
>    Otherwise, with a level interrupt, the interrupt will continue to be 
>    held active ("screaming") and the CPU will get interrupted over and 
>    over again, until the irq subsystem will just turn the irq off 
>    entirely.
> 
>  - when you resume, make sure that you get the engine going again, with 
>    the understanding that some interrupts may have gotten ignored.
Here it isn't a problem, this is a video capture card, and I suspend it by just stopping dma
on all active buffers even if in the middle of capture, and I send those buffers to card again
to fill them from the beginning during the resume.
> 
> Also, in general, these kinds of things shouldn't always even be 
> neicessary. If you use the suspend_late()/resume_early() hooks, those will 
> be called with interrupts off, and while they can be harder to debug (and 
> may be worth avoiding for non-critical drivers), they do allow for simpler 
> models partly exactly because they don't need to worry about interrupts 
> etc.
Exactly, I am aware of suspend_late , but I don't want to abuse it.
> 
> 		Linus
> 


Best regards,
	Maxim Levitsky
