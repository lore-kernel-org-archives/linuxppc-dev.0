Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 61281DDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Dec 2006 08:15:25 +1100 (EST)
Subject: Re: Chenging 2 bits in MSR in ppc6xx_idle() with 1 command?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.60.0612272135470.13342@poirot.grange>
References: <Pine.LNX.4.60.0612252053410.3424@poirot.grange>
	<1167176934.3522.15.camel@localhost.localdomain>
	<Pine.LNX.4.60.0612272135470.13342@poirot.grange>
Content-Type: text/plain
Date: Thu, 28 Dec 2006 08:15:16 +1100
Message-Id: <1167254116.23340.14.camel@localhost.localdomain>
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


> Hm, wouldn't it just work? In ppc6xx_idle() the _TLF_NAPPING bit is set. 
> If as a result of mtmsr only the EE bit is set and we get an interrupt, we 
> end up in transfer_to_handler(), check the flag, it is set, so we branch 
> to power_save_6xx_restore(). There we clear NAP/DOZE and just jump to 
> transfer_to_handler_cont(). Why did you say we'd miss the check for 
> need_resched (on IRC)? How is this case difference from if we really did 
> go to NAP / DOZE?
> 
> Are there other places in the kernel where we rely on setting MSR:POW and 
> some other bit atomically?

Indeed, the napping "recovery" code might save us here... funny, as it
wasn't implemented to handle that case at all...

Ben.
