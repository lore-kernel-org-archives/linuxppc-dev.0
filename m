Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B0061DDF11
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 02:46:51 +1000 (EST)
In-Reply-To: <1181232358.2785.79.camel@pmac.infradead.org>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<bd6ef296692e8cfb81118f2dc85189a5@kernel.crashing.org>
	<4662EAA9.70104@ru.mvista.com>
	<e4197fd2753f2b4d548d5dde9e3fd1d3@kernel.crashing.org>
	<466308F4.8050004@ru.mvista.com>
	<8ac5664208e0f59329b62ac2138bbc8c@kernel.crashing.org>
	<466312C2.4090200@ru.mvista.com>
	<548a7e11ffb577f6395b8f5a9c2fba2d@kernel.crashing.org>
	<466323EF.5040807@ru.mvista.com>
	<1181228442.2785.60.camel@pmac.infradead.org>
	<18fbfbaf113ab76b602d279848d9b405@kernel.crashing.org>
	<1181232358.2785.79.camel@pmac.infradead.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <04823a3fa3fc5d1e6c14ef896fabfdb0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Thu, 7 Jun 2007 18:46:45 +0200
To: David Woodhouse <dwmw2@infradead.org>
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

>> So I think the best thing to have would be
>>
>> 	compatible      "cfi-flash"
>> 	bank-width      like you said
>> 	device-width    width of a single flash device
>> 	reg             complete address range of this thing
>>
>> and then the Linux OF CFI flash code / MTD code just keeps
>> on probing devices from that address range until it has it
>> filled.
>>
>> Sounds good / comments / anything I missed?
>
> That seems reasonable. I would personally have used 'interleave' to 
> give
> the number of devices interleaved together into the specified
> bank-width, rather than specifying device-width.

I think "device-width" is much clearer -- from the name
"interleave" you cannot tell that it actually means
"number-of-interleaved-devices-in-this-bank".

> People might get
> confused by device-width because many devices can actually be _either_
> x16 or x8.

Well after it has been soldered down to the board, it's
pretty much fixed what the device's bus width is ;-)

> But I don't care much. Linux will only be using the
> bank-width anyway.

So it can reliably detect interleaving itself?

I'd like "device-width" to be a required property still,
for the benefit of non-Linux device tree users, or just
in case.

> The other thing that might be seen in the 'compatible' property would 
> be
> 'jedec-flash',

I don't want to deal with that yet, one thing at a time,
and CFI flash it is now.  JEDEC is a bit hairier.

> and in that case perhaps we also want properties for the
> manufacturer and device ident?

Certainly, since they cannot be reliably probed.

> Linux wouldn't necessarily care about
> them, but other operating systems might.
>
> And we also need partition information to get through somehow, in the
> cases where the firmware knows it.

A child node per partition I suppose, dunno.


Segher
