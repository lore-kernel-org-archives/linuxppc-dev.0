Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51C3EDDED9
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 23:59:14 +1000 (EST)
In-Reply-To: <20070907010449.GL26079@localhost.localdomain>
References: <20070829061300.GF3206@localhost.localdomain>
	<143067874eed1b4ee9c75d5272bb5958@kernel.crashing.org>
	<20070905025907.GG17189@localhost.localdomain>
	<a8b4282d0c58f1090c64591d387dae97@kernel.crashing.org>
	<20070907010449.GL26079@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <58aa17750f64df739b86abeff2616d55@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Document and implement an improved flash device binding
Date: Fri, 7 Sep 2007 15:58:39 +0200
To: David Gibson <dwg@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> Let's have bank-width optional instead, it's more natural
>>>> that way for the common case of just one chip.  Or, you can
>>>> say that either is optional.
>>>
>>> No, I'm disinclined to do that since bank-width is the primary bit of
>>> information that the driver needs.
>>
>> Bzzzzt.  That's not what the device tree is about; it should
>> describe the hardware, it shouldn't be just a config file for
>> the current Linux drivers.
>
> Yes, yes, so you've said many times.

Glad you noticed :-)

> But where there are multiple ways of encoding exactly the same
> information, I don't see that we can't use driver convenience as a
> deciding factor.

But a driver that supports interleaving needs _both_ those pieces
of information, and a driver that doesn't needs the device-width
only.

Sure, the current MTD driver will use some heuristics to guess
the device width, but an interface via which it can get it from
the device tree will have to be added anyway.


Segher
