Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 9F925DDE3D
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 02:16:58 +1000 (EST)
Subject: Re: [PATCH] Fix I8042 IRQs on MPC8641 HPCN
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <000737fbc16c8d25bb3ebcdc9bbd9eab@kernel.crashing.org>
References: <1182298509.5674.356.camel@rhino>
	<567a30ea184b6efc37e4c5df60fea1ac@kernel.crashing.org>
	<46795026.8040502@ru.mvista.com>
	<000737fbc16c8d25bb3ebcdc9bbd9eab@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 20 Jun 2007 09:16:56 -0700
Message-Id: <1182356216.5674.370.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-06-20 at 18:07 +0200, Segher Boessenkool wrote:
> >>> 	 * IRQ 9:  Level
> >>> 	 * IRQ 10: Level
> >>> 	 * IRQ 11: Level
> >>> -	 * IRQ 12: Level
> >>> +	 * IRQ 12: Edge
> >>> 	 * IRQ 14: Edge
> >>> 	 * IRQ 15: Edge
> >>> 	 */
> >>> -	outb(0xfa, 0x4d0);
> >>> -	outb(0x1e, 0x4d1);
> >>> +	outb(0xf8, 0x4d0);
> >>> +	outb(0x0e, 0x4d1);
> >> The comment doesn't mention IRQ13.  You're changing IRQ9
> >> to edge as well; is this an accident?
> >
> >    Whare -- I'm only seeing bit 1 changing which corresponds to IRQ1 
> > and is reserved (0) anyway.
> 
> Uh yeah, bit 1, it's hard to count these single-byte quantities :-)

Yep, only IRQ's 1 and 12 should be changed here.

> 
> >>  If not, you need to change the comment too.
>

I'm not the original author of the comment, but I think it's only
mentioning the IRQ's whose triggering is being modified here.  The
omitted IRQ's already had the correct triggering.

In any case, I can clarify the comment to make it more clear.

--Wade
