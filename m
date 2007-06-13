Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ECD14DDF0B
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 15:05:37 +1000 (EST)
In-Reply-To: <20070613031615.GC16148@localhost.localdomain>
References: <e4197fd2753f2b4d548d5dde9e3fd1d3@kernel.crashing.org>
	<466308F4.8050004@ru.mvista.com>
	<8ac5664208e0f59329b62ac2138bbc8c@kernel.crashing.org>
	<466312C2.4090200@ru.mvista.com>
	<548a7e11ffb577f6395b8f5a9c2fba2d@kernel.crashing.org>
	<466323EF.5040807@ru.mvista.com>
	<1181228442.2785.60.camel@pmac.infradead.org>
	<18fbfbaf113ab76b602d279848d9b405@kernel.crashing.org>
	<20070612044459.GD4198@localhost.localdomain>
	<9e1a55ac71a2ecf5155d2fddf547025e@kernel.crashing.org>
	<20070613031615.GC16148@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <96f5b23c4f53e986e8caa2156f149cd8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Wed, 13 Jun 2007 07:05:31 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Of course, Ebony has flash which is JEDEC rather than CFI probed, so 
>>> I
>>> have an interest in a binding for that, too.
>>
>> For JEDEC flash, you probably want extra properties
>> for manufacturing ID and chip ID.  Also, you need
>> to describe the block sizes in some way (on CFI, this
>> can be probed; on JEDEC, not).  Anything else?
>
> Hrm.  At the moment it appears to work without supplying this
> information for the Ebony flash...  I wonder if there are defaults in
> the mtd layer or something.

MTD does a lot of heuristic probing.  It is pretty good,
but it would be nice if you could skip that and hand it
the exact values it needs.  Also, this information should
be in the device tree no matter what, even if Linux
doesn't use it yet ;-)


Segher
