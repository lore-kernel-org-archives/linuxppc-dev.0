Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 85104DDE2F
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 19:49:51 +1000 (EST)
In-Reply-To: <46B96294322F7D458F9648B60E15112C6F3312@zch01exm26.fsl.freescale.net>
References: <11829333481420-git-send-email-wei.zhang@freescale.com>
	<11829333481977-git-send-email-wei.zhang@freescale.com>
	<5f0438212493766009684d63e41c85cc@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C6F3281@zch01exm26.fsl.freescale.net>
	<8ee77b5f79ee0c0c5ead1f0acbe95bda@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C6F3312@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e463944d2ab9266347361f7cd3b61b09@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/5 v2] Add the explanation and a sample of RapidIO DTS
	sector to the document of booting-without-of.txt file.
Date: Fri, 29 Jun 2007 11:49:42 +0200
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

>> No.  The #address-cells is determined by the bus binding,
>> so that all RapidIO busses on the planet can be represented
>> in a similar way in the OF device tree.  Take for example
>> the PCI binding, which gives you three address cells -- one
>> to distinguish between different address spaces (configuration
>> space, legacy I/O space, memory mapped space) and to contain
>> some flags (prefetchable vs. non-prefetchable, etc.); the
>> other two 32-bit cells contain a 64-bit address, although
>> config and legacy I/O never are more than 32 bit, and many
>> PCI devices can't do 64-bit addressing at all.
>>
>> Now, there is no OF binding for RapidIO yet of course, but
>> it would be good to start thinking about one while doing
>> the binding for your specific controller -- it will make
>> life easier down the line for everyone, including yourself.
>>
> How about I add more words here for more clear expression?
> Such as "<2> for 34 and 50 bit address, <3> for 66 bit address".

You should more explicitly define the address format, i.e.
what every bit means -- just saying it is 64 or 96 bits isn't
enough.  While you're doing that, think of a way that can
represent _every possible_ RapidIO address, not just the ones
supported by this particular controller.


Segher
