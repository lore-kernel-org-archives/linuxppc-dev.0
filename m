Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 34D31DDEC9
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Dec 2006 07:44:21 +1100 (EST)
Date: Wed, 27 Dec 2006 21:44:27 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Chenging 2 bits in MSR in ppc6xx_idle() with 1 command?
In-Reply-To: <1167176934.3522.15.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0612272135470.13342@poirot.grange>
References: <Pine.LNX.4.60.0612252053410.3424@poirot.grange>
	<1167176934.3522.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 27 Dec 2006, Benjamin Herrenschmidt wrote:

> On Mon, 2006-12-25 at 21:07 +0100, Guennadi Liakhovetski wrote:
> > Hi
> > 
> > Here's a code fragment from ppc6xx_idle(), which should send the CPU into 
> > a powersaving mode (DOZE or NAP) and re-enable interrupts after a 
> > local_irq_disable():
> > 
> > 	mfmsr	r7
> > 	ori	r7,r7,MSR_EE
> > 	oris	r7,r7,MSR_POW@h
> > 1:	sync
> > 	mtmsr	r7
> > 	isync
> > 	b	1b
> > 
> > Whereas MPC8245's user manual says, that when setting the MSR_POW bit in 
> > the MSR one may not set any other bit in it with the same instruction. 
> > Does this mean that the above does not actually work on those (and 
> > similar) CPUs or does it work because of the loop?
> 
> That doc bit looks a bit strange. The kernel pretty much relies on
> setting MSR:EE and MSR:POW atomicaly.

Hm, wouldn't it just work? In ppc6xx_idle() the _TLF_NAPPING bit is set. 
If as a result of mtmsr only the EE bit is set and we get an interrupt, we 
end up in transfer_to_handler(), check the flag, it is set, so we branch 
to power_save_6xx_restore(). There we clear NAP/DOZE and just jump to 
transfer_to_handler_cont(). Why did you say we'd miss the check for 
need_resched (on IRC)? How is this case difference from if we really did 
go to NAP / DOZE?

Are there other places in the kernel where we rely on setting MSR:POW and 
some other bit atomically?

Thanks
Guennadi
---
Guennadi Liakhovetski
