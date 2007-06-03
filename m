Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6C52BDDEC5
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 05:56:39 +1000 (EST)
In-Reply-To: <466312C2.4090200@ru.mvista.com>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<bd6ef296692e8cfb81118f2dc85189a5@kernel.crashing.org>
	<4662EAA9.70104@ru.mvista.com>
	<e4197fd2753f2b4d548d5dde9e3fd1d3@kernel.crashing.org>
	<466308F4.8050004@ru.mvista.com>
	<8ac5664208e0f59329b62ac2138bbc8c@kernel.crashing.org>
	<466312C2.4090200@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <548a7e11ffb577f6395b8f5a9c2fba2d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Sun, 3 Jun 2007 21:56:31 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> You obviously completely misunderstand the semantics
>>>> of the "compatible" property.
>
>>>    Oh well, on the chip level, your "compatible" prop would be 
>>> correct.
>
>> This has nothing to do with a "chip level", it is plain and
>> simply the most basic device tree stuff.
>
>    If it was as "plain and simple" as you say, there would be nothing 
> to argue about.

There isn't as far as I am concerned; the purpose and
meaning of the "compatible" property, as well as of any
other standard OF properties, is clear.

> What we ended up with is 2 or 3 level hierarchy of nodes which doesn't 
> at all seem to be such simple (considering the fact that what's 
> covered by a the simple "bank-width" property could be represented by 
> several combinations of interleaved flash chips).

Yes, the more complex (and sometimes insane) ways that
flash chips are connected to systems can be really hard
to describe properly.  Which is why I don't even want
to make a "binding" for it (yet).  It seems easy enough
to do this for single flash chips (possibly direct-mapped)
though.

> So, what you wanted us to do was either substantially redesign Linux 
> MTD subsys to fit it into that model

Nah.  The current MTD model has some issues of course,
but that is a separate problem.

>  (either that or over-engineer the physmap_of driver to gather that 
> kind of information from the multiple "chip" subnodes).

I would say it is overengineered already.  It shouldn't
try to be a general solution for all possible cases since
it has no hope of achieving that.  Get the simple cases
(that actually are used in real life) right, first.


Segher
