Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2E947DDE2B
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 19:06:13 +1000 (EST)
In-Reply-To: <46B96294322F7D458F9648B60E15112C6F3281@zch01exm26.fsl.freescale.net>
References: <11829333481420-git-send-email-wei.zhang@freescale.com>
	<11829333481977-git-send-email-wei.zhang@freescale.com>
	<5f0438212493766009684d63e41c85cc@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C6F3281@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8ee77b5f79ee0c0c5ead1f0acbe95bda@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/5 v2] Add the explanation and a sample of RapidIO DTS
	sector to the document of booting-without-of.txt file.
Date: Fri, 29 Jun 2007 11:05:56 +0200
To: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +    - #address-cells : Address representation for
>> "rapidio" devices.
>>> +      This field represents the number of cells needed to represent
>>> +      the RapidIO address of the registers.  For
>> supporting more than
>>> +      32-bits RapidIO address, this field should be <2>.
>>> +      See 1) above for more details on defining #address-cells.
>>
>> What does the RapidIO standard say about number of address
>> bits?  You want to follow that, so all RapidIO devices can
>> use the same #address-cells, not just the FSL ones.  Also,
>> are there different kinds of address spaces on the bus, or
>> is it just one big memory-like space?
>
> I've checked the specification of RapidIO. The supporting of RapidIO
> extended address modes are 66, 50 and 34 bit.

These three are all two bits more than some "regular" size --
do those two extra bits have some special meaning perhaps,
like an address space identifier or something?

> The Freescale's silicons is only support 34 bit address now.
> Do you mean I should not use words -- 'should be <2>'?
> The #address-cells should be assigned according the address mode
> supported by silicon.

No.  The #address-cells is determined by the bus binding,
so that all RapidIO busses on the planet can be represented
in a similar way in the OF device tree.  Take for example
the PCI binding, which gives you three address cells -- one
to distinguish between different address spaces (configuration
space, legacy I/O space, memory mapped space) and to contain
some flags (prefetchable vs. non-prefetchable, etc.); the
other two 32-bit cells contain a 64-bit address, although
config and legacy I/O never are more than 32 bit, and many
PCI devices can't do 64-bit addressing at all.

Now, there is no OF binding for RapidIO yet of course, but
it would be good to start thinking about one while doing
the binding for your specific controller -- it will make
life easier down the line for everyone, including yourself.


Segher
