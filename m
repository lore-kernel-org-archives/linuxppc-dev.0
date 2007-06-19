Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6BD1DDDE25
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 23:15:53 +1000 (EST)
In-Reply-To: <20070619123721.202110@gmx.net>
References: <20070618185715.321010@gmx.net>
	<20070619054232.GB32039@localhost.localdomain>
	<20070619084015.202120@gmx.net>
	<73aafd0955b8ea695af9221b48aaa3f1@kernel.crashing.org>
	<20070619095251.202080@gmx.net>
	<81b5cc3c799c9ec65df04468d4d9051e@kernel.crashing.org>
	<20070619123721.202110@gmx.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bec0a23b1a544fe66810f43a73b142a2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
Date: Tue, 19 Jun 2007 15:15:33 +0200
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> I guess I can define both of them or do they conflict (IIRC
>>> the two hardware revision should be compatible)?
>>
>> Use one or the other, not both.  Perhaps you'll need
>> to add the pnpPNP,500 and pnpPNP,501 entries to the
>> generic OF serial code, should be trivial to do.
> I guess I stick with compatible = "serial" for now, as it should
> also work with the generic serial console support code.

"compatible" = "serial" is completely wrong -- it is
a generic name and should never be matched on.

>> The 16550A supports something the 16550 doesn't (don't
>> ask me what, I forgot :-) ), so don't say it is an A
>> when it isn't; the other way around is fine though.
>>
>> And it doesn't matter much for Linux anyway currently,
>> the "generic" kernel driver will do its own wacky probing.
> Yes, that's why the current AmigaOne kernels (2.6.16) detect 3 serial
> ports, whereas there should be only 2 (the first two are detected by
> probing for the VIA southbridge and the last one IIRC is registered by
> request_region()). I hope the device tree fixes this.

It should, yes.

>>> Where are all this "pnpPNP,xxx" identifiers specified (except
>>> for serial parallel, fdc, keyboard, mouse)?
>>
>> They are defined by the vendor of the devices; for
>> vendor "PNP", i.e. legacy non-PNP PC devices, that
>> is MicroSoft.
> Downloaded the file you pointed to and the OF generic names document. I
> thought the OF core specification defines them, but it's not available
> freely.

That's a common misconception :-)

<ftp://playground.sun.com/pub/p1275/coredoc/1275-1994/1275.ps.gz>


Segher
