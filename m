Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D2890DDF9C
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 20:09:24 +1000 (EST)
In-Reply-To: <20070619095251.202080@gmx.net>
References: <20070618185715.321010@gmx.net>
	<20070619054232.GB32039@localhost.localdomain>
	<20070619084015.202120@gmx.net>
	<73aafd0955b8ea695af9221b48aaa3f1@kernel.crashing.org>
	<20070619095251.202080@gmx.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <81b5cc3c799c9ec65df04468d4d9051e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
Date: Tue, 19 Jun 2007 12:08:06 +0200
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

>> "pnpPNP,501" says that the device is a 16550A-compatible
>> UART compatible with how that is used in a PC (using the
>> same base clock, and some other minor things).
>>
>> "ns16550" simply says the device is compatible with
>> the NS16550.  Also note the lack of "A".
> I guess I can define both of them or do they conflict (IIRC
> the two hardware revision should be compatible)?

Use one or the other, not both.  Perhaps you'll need
to add the pnpPNP,500 and pnpPNP,501 entries to the
generic OF serial code, should be trivial to do.

The 16550A supports something the 16550 doesn't (don't
ask me what, I forgot :-) ), so don't say it is an A
when it isn't; the other way around is fine though.

And it doesn't matter much for Linux anyway currently,
the "generic" kernel driver will do its own wacky probing.

>>> http://playground.sun.com/1275/bindings/pci/pci2_1.pdf
>>
>> How does PCI come into the picture here?
> I just added it, because it defines how the interrupts property
> should be specfied.

"interrupts" is defined by the base OF spec.  The specific
format for any interrupt domain is defined by the binding
for that domain, notably by the bindings for interrupt
controllers.

> Where are all this "pnpPNP,xxx" identifiers specified (except
> for serial parallel, fdc, keyboard, mouse)?

They are defined by the vendor of the devices; for
vendor "PNP", i.e. legacy non-PNP PC devices, that
is MicroSoft.


Segher
