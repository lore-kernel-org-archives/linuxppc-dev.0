Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 00D1BDDFB4
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 10:17:21 +1000 (EST)
In-Reply-To: <17977.9796.15991.630737@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178086872.13233.27.camel@johannes.berg>
	<17976.28170.695715.416339@cargo.ozlabs.ibm.com>
	<1178116438.13233.65.camel@johannes.berg>
	<1178143429.17299.7.camel@localhost.localdomain>
	<17977.9796.15991.630737@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f885d6b1472525fb5bebdd96ae4c3157@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powermac: support G5 CPU hotplug
Date: Thu, 3 May 2007 02:17:15 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> Ultimately we want to put the disabled cpus in sleep mode, but that
>>>> will require a suitable cache flush routine.
>>>
>>> I don't have any docs for the particular processors the G5s have, do
>>> they have a sleep mode?
>>
>> They have, but the cache flush is not trivial to do (and might imply
>> access to non documented bits). So let's put that on the to-do list 
>> and
>> stick to NAP for now while I dig something.
>
> Hmmm, I went looking in the 970FX manual for sleep mode and didn't
> find it, only nap and doze...

"Sleep" is a generic term for both "doze" and "nap", heh.

The difference between doze and nap is that in nap mode
the bus interface unit is switched off; on the 970 and
970FX this means that the L2 cache has to be flushed
before entering nap mode (or otherwise snoops will go
missing in action); the 970MP automatically transitions
from nap to doze mode if snoops are requested (and back
to nap again), so no L2 flush is required.  The 970MP
also has a "deep nap" mode which saves more power by
automatically clocking the CPU down.

One more thing -- perhaps keeping the CPU in reset
state saves even more power?


Segher
