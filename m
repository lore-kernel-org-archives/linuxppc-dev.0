Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2C6BDDDF7F
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 19:29:10 +1000 (EST)
In-Reply-To: <20070619090816.55840@gmx.net>
References: <20070618185715.321010@gmx.net>
	<136ef2695edbe7c8a535b5b4c7a669bf@kernel.crashing.org>
	<20070619090816.55840@gmx.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <956019fbf071a89518ccfdd8799cf5c2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
Date: Tue, 19 Jun 2007 11:28:47 +0200
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Where in the OF specs did you find this pnpPNP thing btw?
> See here:
> http://playground.sun.com/1275/bindings/devices/html/serial.html

Ah, the CHRP stuff I so happily ignore.

The generic pnpPNP thing is described in the ISA binding,
4.1.1 "name".  You should put this into "compatible"
though, since generic names are preferred.

>> "compatible" is one of those pnpPNP things.
>
> Quote from the "CHRP(TM) ISA Interrupt Controller Device
> Binding" document:

But you're not CHRP.  This is an ISA device however,
so you should follow the ISA binding.

> I couldn't find any reference about a "pnp..." value for an i8259
> interrupt controller.

pnpPNP,0 for AT-style, pnpPNP,1 for EISA-style.

It is quite hard to find a list of the standard PNP
device code.  Here's a link, grab it before the file
disappears forever:

<http://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a 
-923143f3456c/devids.txt>

> Is there already a generic function within the
> kernel that can setup the interrupt controller based solely on the
> information in the device tree?

Probably not.  There are bits and pieces though, your
job is to glue it all together.  You can handle this
in your platform code, if people want to make it more
generic they can always refactor the code ;-)


Segher
