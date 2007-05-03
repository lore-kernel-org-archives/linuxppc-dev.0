Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ADC4BDDFB6
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 10:18:18 +1000 (EST)
Subject: Re: [PATCH] powermac: support G5 CPU hotplug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <3b16ca8bab1f2f05ea9c1f25e1010464@kernel.crashing.org>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178086872.13233.27.camel@johannes.berg>
	<17976.28170.695715.416339@cargo.ozlabs.ibm.com>
	<1178116438.13233.65.camel@johannes.berg>
	<1178143429.17299.7.camel@localhost.localdomain>
	<8dffc34312d10f0f93c7adfe9ec60003@kernel.crashing.org>
	<1178150380.17299.34.camel@localhost.localdomain>
	<3b16ca8bab1f2f05ea9c1f25e1010464@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 03 May 2007 10:18:09 +1000
Message-Id: <1178151489.17299.43.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-03 at 02:05 +0200, Segher Boessenkool wrote:
> >>> They have, but the cache flush is not trivial to do (and might imply
> >>> access to non documented bits).
> >>
> >> It is (publicly) documented just fine :-)
> >
> > Ah good... you happen to have a pointer ? Last I looked, it wasn't ...
> 
> It's in the UM, search for "L2 cache flush".

Ah yes, it's there for recent UM.

So, to summarize:

 - 970 only does NAP, not SLEEP

 - We should probably still flush the cache when bringing a CPU down
   because we might implement STR in which case the machine will go
   down and we won't get a chance to flush that CPU cache then.

Also, I always wondered what happened if you entered NAP without MSR:EE,
and so I checked the 970 UM and it's clearly undefined behaviour. Thus
we must make sure we always set EE, and we can "use" the trick of having
soft-disable to just return where we came from and re-enter NAP if we
got woken up by the DEC. I agree with Paulus, Johannes, we should just
do a separate routine for the CPU going down vs. Idle. Among others,
we'll also add the cache flush there.

Cheers,
Ben.
