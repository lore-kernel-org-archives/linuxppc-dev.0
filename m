Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A40DADDFCE
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 11:01:23 +1000 (EST)
In-Reply-To: <1178151690.17299.46.camel@localhost.localdomain>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178086872.13233.27.camel@johannes.berg>
	<17976.28170.695715.416339@cargo.ozlabs.ibm.com>
	<1178116438.13233.65.camel@johannes.berg>
	<1178143429.17299.7.camel@localhost.localdomain>
	<17977.9796.15991.630737@cargo.ozlabs.ibm.com>
	<f885d6b1472525fb5bebdd96ae4c3157@kernel.crashing.org>
	<1178151690.17299.46.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <15a6025d58d0f62ee10efab20dc98278@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powermac: support G5 CPU hotplug
Date: Thu, 3 May 2007 03:01:16 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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

>> The difference between doze and nap is that in nap mode
>> the bus interface unit is switched off; on the 970 and
>> 970FX this means that the L2 cache has to be flushed
>> before entering nap mode (or otherwise snoops will go
>> missing in action);
>
> BZZZT... incorrect... the 970FX and MP behave the same here.

Yeah I goofed here -- cache flush is only required if
you take a CPU offline.

> There is
> only one state you can "manually" enter and it's NAP.

BZZZT... incorrect... you can "manually" switch to
all of doze, nap, and deep nap.

> Transitions
> between DOZE and NAP are automatic to handle snooping in both cases.
> Cache flushing is never needed ... unless in our case the CPU gets
> actually powered down for suspend-to-ram.

Yeah.  Or to hot-unplug it ;-)

>> the 970MP automatically transitions
>> from nap to doze mode if snoops are requested (and back
>> to nap again), so no L2 flush is required.  The 970MP
>> also has a "deep nap" mode which saves more power by
>> automatically clocking the CPU down.
>
> Also deep nap only really works on 970MP DD3 and later I think

Yes, we put that knowledge into the kernel already.

>> One more thing -- perhaps keeping the CPU in reset
>> state saves even more power?
>
> Dunno... Somebody can try... but I don't think we have access to the
> reset line on 970's..

Isn't it just a GPIO, like on older Macs?  Of course, we
cannot bring a CPU back online after doing that so it's
pretty useless I suppose.


Segher
