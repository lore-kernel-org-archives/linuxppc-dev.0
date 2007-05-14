Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5E8DFDDECC
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 00:43:55 +1000 (EST)
In-Reply-To: <20070514002457.GD6517@localhost.localdomain>
References: <cbcd7823ea9b0f17f998670915719a05@kernel.crashing.org>
	<AF0367BA48C55940A43CCF08DF35553C012AA296@az33exm24.fsl.freescale.net>
	<20070509004948.GB4198@localhost.localdomain>
	<1178706570.3453.63.camel@zod.rchland.ibm.com>
	<0f60e44e6c7848e5eee8c82c0f2bfaec@kernel.crashing.org>
	<20070510235453.GD27188@localhost.localdomain>
	<b5cd56b7081eaba062cf056545777989@kernel.crashing.org>
	<20070514002457.GD6517@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1777f196ba995c48a00d72b94a4dbbd8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 6/7] Holly DTS
Date: Mon, 14 May 2007 14:33:13 +0200
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

>>> easiest is to
>>> replace it with a configurable poison value.  When using asm output,
>>> or with a map file, it might be possible to generate out-of-band
>>> information which we can use to check that the right things are 
>>> filled
>>> in.
>>>
>>> It's not a simply a matter of making the kernel parser recognize the
>>> uninitialized info, because there's no way to encode that in the dtb
>>> itself.
>>
>> There can be, with a new DTB version -- perhaps simply
>> define proplen == -1 to mean "undefined" or similar.
>
> That doesn't quite do it, because I'd prefer ? to cover cases where
> the property's length is known, just not its value.  In particular
> that could be useful for device trees where *only* non-moving edits
> are required by the bootloader, letting us use the asm output mode as
> intended.

[First things first -- it is generally wrong to
require properties to have a certain length, newer
(versions of) bindings can add extra fields to the
end of a property.  It should be okay for this ??
stuff though, if a bootwrapper/firmware fills in
the property it better know its whole semantics,
including the new part.]

Okay, so use negative lengths to represent undefined
properties of a certain length, and use -inf to mean
"completely undefined yet".  Or some other encoding,
there are many ways that would work.

My point is that you need a new DTB version to properly
represent ??.


Segher
