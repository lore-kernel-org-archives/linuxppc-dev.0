Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4E206DDF29
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 00:08:25 +1000 (EST)
In-Reply-To: <20070510235453.GD27188@localhost.localdomain>
References: <cbcd7823ea9b0f17f998670915719a05@kernel.crashing.org>
	<AF0367BA48C55940A43CCF08DF35553C012AA296@az33exm24.fsl.freescale.net>
	<20070509004948.GB4198@localhost.localdomain>
	<1178706570.3453.63.camel@zod.rchland.ibm.com>
	<0f60e44e6c7848e5eee8c82c0f2bfaec@kernel.crashing.org>
	<20070510235453.GD27188@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b5cd56b7081eaba062cf056545777989@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 6/7] Holly DTS
Date: Sat, 12 May 2007 14:02:42 +0200
To: David Gibson <dwg@au1.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Loeliger Jon-LOELIGER <jdl@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> What exactly did this ?? syntax imply?  I must have missed that 
>>> thread.
>>
>> A property in a DTS file can use that to say
>> the property should have a value, but it will
>> be filled in by the bootwrapper instead (memory
>> address/size, or network MAC address, for
>> instance).  Presumably the kernel parser would
>> complain when it sees the this-is-still-undefined
>> marker.
>>
>> The original proposal specified the length of
>> the property value IIRC, but that isn't necessary
>> anymore.
>
> Well.. sort of.  The first cut at the idea is that ? would be
> equivalent to zeroes in terms of dtc output, but would act as internal
> documentation that that property is supposed to be filled in by the
> bootloader.

Yes.

> Refinements to try to enforce that would be nice:

Exactly my point.

> easiest is to
> replace it with a configurable poison value.  When using asm output,
> or with a map file, it might be possible to generate out-of-band
> information which we can use to check that the right things are filled
> in.
>
> It's not a simply a matter of making the kernel parser recognize the
> uninitialized info, because there's no way to encode that in the dtb
> itself.

There can be, with a new DTB version -- perhaps simply
define proplen == -1 to mean "undefined" or similar.


Segher
