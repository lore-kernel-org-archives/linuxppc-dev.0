Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 1BE00DDEE0
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Dec 2006 10:55:58 +1100 (EST)
Date: Wed, 27 Dec 2006 00:56:03 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Chenging 2 bits in MSR in ppc6xx_idle() with 1 command?
In-Reply-To: <1167176934.3522.15.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0612270052590.9923@poirot.grange>
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

So, would be good to verify? As MSR is implementation-specific and, for 
example, in 603e manual it doesn't have this limitation, it should be 
verified on one of platforms where the manual explicitely mentions that. 
If you post a test-patch to check it I could test it. Otherwise I could 
try to cook something up myself.

Thanks
Guennadi
---
Guennadi Liakhovetski
