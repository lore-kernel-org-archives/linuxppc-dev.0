Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id DF43FDDF3D
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 20:33:20 +1000 (EST)
Date: Wed, 30 Apr 2008 12:33:28 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/7] Implement arch disable/enable irq hooks.
In-Reply-To: <18454.42926.213374.977098@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0804301229310.5099@axis700.grange>
References: <20071023212404.GA30942@loki.buserror.net>
	<Pine.LNX.4.64.0804251454050.6045@axis700.grange>
	<20080428203322.GD15223@ld0162-tx32.am.freescale.net>
	<18454.42926.213374.977098@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 29 Apr 2008, Paul Mackerras wrote:

> Scott Wood writes:
> 
> > On Fri, Apr 25, 2008 at 02:57:24PM +0200, Guennadi Liakhovetski wrote:
> > > is there any specific reason, why out of these 7 patches only the first 
> > > one made it into the mainline? AFAICS, there has been only one comment, 
> > > suggesting to replace printk with dev_err on two occasions in one of 
> > > the patches...
> > 
> > A while ago Paul said on IRC he'd prefer to do the TLF_SLEEPING hack more
> > like the soft IRQ disabling that 64-bit uses.  I haven't yet had a chance
> > to look into it, so the patch collects dust, despite the current
> > implementation of TLF_SLEEPING working just fine.
> 
> I have taken a closer look at the TLF_SLEEPING patch and crystallized
> my thoughts about it a bit:
> 
> 1. Too many ifdefs - it's only a few instructions extra, so if we're
> going to have the TLF_SLEEPING stuff we might as well have it
> unconditionally.
> 
> 2. It seems convoluted to me to go through transfer_to_handler_cont
> and ret_from_except when we could just get out directly through
> fast_exception_return, given that we are not calling a handler.  The
> only thing to watch out for there is that r7 and r8 haven't been
> modified (or have been restored if they have).
> 
> 3. The style in all the assembly code is not to have spaces after
> commas separating instruction operands.
> 
> The untested patch below is what I was thinking of.  If you'd like to
> try it out, I'd be interested to hear how it goes.

The patch (with the _TLF_SLEEPING fix you mentioned in a later email) 
works for me. Shall I submit it "From: <you>" or would you prefer to post 
it yourself? But, I guess, you have to put your "S-o-b" under it yourself, 
don't you?

Thanks
Guennadi
---
Guennadi Liakhovetski
