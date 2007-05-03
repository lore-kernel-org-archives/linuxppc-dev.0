Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83FBFDDF86
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 10:21:37 +1000 (EST)
Subject: Re: [PATCH] powermac: support G5 CPU hotplug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <f885d6b1472525fb5bebdd96ae4c3157@kernel.crashing.org>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178086872.13233.27.camel@johannes.berg>
	<17976.28170.695715.416339@cargo.ozlabs.ibm.com>
	<1178116438.13233.65.camel@johannes.berg>
	<1178143429.17299.7.camel@localhost.localdomain>
	<17977.9796.15991.630737@cargo.ozlabs.ibm.com>
	<f885d6b1472525fb5bebdd96ae4c3157@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 03 May 2007 10:21:30 +1000
Message-Id: <1178151690.17299.46.camel@localhost.localdomain>
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


> The difference between doze and nap is that in nap mode
> the bus interface unit is switched off; on the 970 and
> 970FX this means that the L2 cache has to be flushed
> before entering nap mode (or otherwise snoops will go
> missing in action); 

BZZZT... incorrect... the 970FX and MP behave the same here. There is
only one state you can "manually" enter and it's NAP. Transitions
between DOZE and NAP are automatic to handle snooping in both cases.
Cache flushing is never needed ... unless in our case the CPU gets
actually powered down for suspend-to-ram.

> the 970MP automatically transitions
> from nap to doze mode if snoops are requested (and back
> to nap again), so no L2 flush is required.  The 970MP
> also has a "deep nap" mode which saves more power by
> automatically clocking the CPU down.

Also deep nap only really works on 970MP DD3 and later I think

> One more thing -- perhaps keeping the CPU in reset
> state saves even more power?

Dunno... Somebody can try... but I don't think we have access to the
reset line on 970's..

Ben.
