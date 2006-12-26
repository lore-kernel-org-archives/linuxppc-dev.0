Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 63101DDE2D
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Dec 2006 10:48:55 +1100 (EST)
Subject: Re: Chenging 2 bits in MSR in ppc6xx_idle() with 1 command?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.60.0612252053410.3424@poirot.grange>
References: <Pine.LNX.4.60.0612252053410.3424@poirot.grange>
Content-Type: text/plain
Date: Wed, 27 Dec 2006 10:48:54 +1100
Message-Id: <1167176934.3522.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-12-25 at 21:07 +0100, Guennadi Liakhovetski wrote:
> Hi
> 
> Here's a code fragment from ppc6xx_idle(), which should send the CPU into 
> a powersaving mode (DOZE or NAP) and re-enable interrupts after a 
> local_irq_disable():
> 
> 	mfmsr	r7
> 	ori	r7,r7,MSR_EE
> 	oris	r7,r7,MSR_POW@h
> 1:	sync
> 	mtmsr	r7
> 	isync
> 	b	1b
> 
> Whereas MPC8245's user manual says, that when setting the MSR_POW bit in 
> the MSR one may not set any other bit in it with the same instruction. 
> Does this mean that the above does not actually work on those (and 
> similar) CPUs or does it work because of the loop?

That doc bit looks a bit strange. The kernel pretty much relies on
setting MSR:EE and MSR:POW atomicaly.

Ben.
