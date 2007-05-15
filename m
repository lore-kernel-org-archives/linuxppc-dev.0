Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 63E55DDED3
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 16:47:28 +1000 (EST)
In-Reply-To: <20070515063408.GE6998@localhost.localdomain>
References: <20070515020026.GG565@localhost.localdomain>
	<8492e53122b6e1ba269afd53b48a4968@kernel.crashing.org>
	<20070515054758.GC6998@localhost.localdomain>
	<200705150811.09927.sr@denx.de>
	<20070515061855.GD6998@localhost.localdomain>
	<1950a79f97480ba96f1b00352ec449a5@kernel.crashing.org>
	<20070515063408.GE6998@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5c785f662c13fdd938d48e40d3107050@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Small fixes for the Ebony device tree
Date: Tue, 15 May 2007 08:47:00 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> finally "ibm,sdram-4xx".
>>
>> Is that last entry ever useful?  Do all those controllers
>> have something in common?
>
> A quick glance over the descriptions in the 440GP and 405GP user
> manuals suggests that they have most of the registers in common,
> though I haven't checked to see if the semantics of those registers
> are actually all the same.

Let me rephrase: can a kernel driver ever do anything
useful with the device if it _only_ knows it is some
4xx memory controller?

If that isn't the case, but for example, the 440GP's
controller can be driven by the 405GP driver, you
can express exactly that in the "compatible" property.
It is a bad plan in general to say "4xx", it suggests
compatibility both ways, which almost never is true;
so what _does_ it mean?  Lowest common denominator?
Say exactly that, then.  "compatible" is meant for
drivers to figure if they can drive the device (or,
equivalently, for the kernel to figure out which driver
can drive a given device).


Segher
