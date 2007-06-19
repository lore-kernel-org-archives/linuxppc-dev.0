Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 700D6DDFB5
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 19:52:52 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 19 Jun 2007 11:52:51 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <73aafd0955b8ea695af9221b48aaa3f1@kernel.crashing.org>
Message-ID: <20070619095251.202080@gmx.net>
MIME-Version: 1.0
References: <20070618185715.321010@gmx.net>
	<20070619054232.GB32039@localhost.localdomain>
	<20070619084015.202120@gmx.net>
	<73aafd0955b8ea695af9221b48aaa3f1@kernel.crashing.org>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
Datum: Tue, 19 Jun 2007 11:14:44 +0200
Von: Segher Boessenkool <segher@kernel.crashing.org>
An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
CC: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Betreff: Re: [RFC] Device tree for new desktop platform in arch/powerpc

> "pnpPNP,501" says that the device is a 16550A-compatible
> UART compatible with how that is used in a PC (using the
> same base clock, and some other minor things).
> 
> "ns16550" simply says the device is compatible with
> the NS16550.  Also note the lack of "A".
I guess I can define both of them or do they conflict (IIRC
the two hardware revision should be compatible)?

> >> Is there a device binding defined somewhere for "chrp,iic"?
> > Dunno. :-) It's based on these document here:
> > http://playground.sun.com/1275/bindings/devices/html/isa-pic-1_1d.html
> > http://playground.sun.com/1275/bindings/pci/pci2_1.pdf
> 
> How does PCI come into the picture here?
I just added it, because it defines how the interrupts property
should be specfied.

> Sure.  There typically is a device node for every
> (addressable) device on the system.  There is no
> defined binding for timer devices though, so there
> shouldn't be a "device_type" in a timer node.
Okay, I'll remove the device_type property.
> >>> 		clock-frequency = <0>;			// Not necessary?
> 
> Since this is an AT timer, you should use "compatible"
> = "pnpPNP,100", and the clock frequency is implicit.
Where are all this "pnpPNP,xxx" identifiers specified (except
for serial parallel, fdc, keyboard, mouse)?

> "disk" subnodes describe the floppy disk _drives_ actually.
> You should have a disk@0 and/or a disk@1, if you have any
> floppy disk drives at all that is.
Ah yes, I may have forgotten the "@0" by mistake.

> The linux floppy driver will do its own probing, so no
> it won't care. Can't hurt to include it though.
That was my intention.

Gerhard
-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
