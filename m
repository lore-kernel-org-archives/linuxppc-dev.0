Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.250])
	by ozlabs.org (Postfix) with ESMTP id 8EA28DE025
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 03:21:52 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 31so9589263agc.0
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 09:21:51 -0700 (PDT)
Message-ID: <fa686aa40803180921l654d6336udd285cf13e4138b5@mail.gmail.com>
Date: Tue, 18 Mar 2008 10:21:50 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Andre Schwarz" <andre.schwarz@matrix-vision.de>
Subject: Re: simple MPC5200B system
In-Reply-To: <47DFDC5B.90304@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47DD71D0.2010203@matrix-vision.de>
	<fa686aa40803161301r1685f2cale75d67b8a203cca3@mail.gmail.com>
	<47DF821B.6090600@matrix-vision.de>
	<47DF9ABB.2020607@matrix-vision.de>
	<fa686aa40803180731g3892e737h29db0cb917946588@mail.gmail.com>
	<47DFDC5B.90304@matrix-vision.de>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 18, 2008 at 9:14 AM, Andre Schwarz
<andre.schwarz@matrix-vision.de> wrote:
>  I've read some discussions about the "interrupt-map" attribute of the pci
> node. I tried to follow Ben and David in their explanations - obviously I
> didn't really get it.
>  Looks like there are a lot of people outside who need some enlightenment
> ... including me, of course.
>
>  Maybe you can clarify this ?
>
>  Taken from motionpro.dts ...
>

First, you also need to look at interrupt-map-mask to interpret these
values; from motionpro.dts:

interrupt-map-mask = <f800 0 0 7>;

which is applied to the unit interrupt specifier to figure out how to
map onto the interrupt controller.  The /size/ of this field is
obtained by adding #address-cells with #interrupt-cells. (3+1=4).

'f8' refers to the upper 5 bits of the interrupt identifier which is a
number from 0-31 which relates to the IDSEL line as you guessed.  The
'7' covers the lower 3 bits of the interrupt specifier which can be 1,
2, 3 or 4.

The 120 bits in the middle are irrelevant, so interrupt-map-mask
leaves them as zeros.

>      interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3 // 1st slot
>                                   c000 0 0 2 &mpc5200_pic 1 1 3
>                                   c000 0 0 3 &mpc5200_pic 1 2 3
>                                   c000 0 0 4 &mpc5200_pic 1 3 3
>
>                                   c800 0 0 1 &mpc5200_pic 1 1 3 // 2nd slot
>                                   c800 0 0 2 &mpc5200_pic 1 2 3
>                                   c800 0 0 3 &mpc5200_pic 1 3 3
>                                   c800 0 0 4 &mpc5200_pic 0 0 3>;
>
>
>  First parameter seems to be the slot number, i.e. IDSEL line of the PCI
> device.
>  How is this value coded ? Are these the bits 15..11 of the configuration
> address ?

I don't remember how this is encoded.  On the lite5200, idsel is wired
to d0 and d1 for slots 1 and 2 respectively, yet these values suggest
slots 24 and 25.  I'll need to look at this again later.

>
>  2nd + 3rd paramter : no clue ! can you explain ?

first 3 cells are the unit address and is #address-cells large.  Only
the first cell contains real data.

>
>  4th : seem to be INT_A ... _D of a PCI device. Usually a device uses only
> INT_A. Do we need 4 entries in any case ?

you only need entries for irq lines that are wired up.  If your board
does not wire up _B, _C and _D, then don't have an entry for them.
However, if they are wired up then you should describe them.

>
>  5th : ok - parent pic

Correct.

>
>  6th ... 8th  : IRQ representation of the parent pic, which gives :
>
>      6th : 0=CRIT for irq0 pin, 1=MAIN for irq1..3 pins
>      7th : irq number. 1 for the irq0 pin inside CRIT level. irq1..3 have
> number 1..3 inside MAIN level.
>      8th : should be 3 = "level low" which is default for PCI.

Correct.

There is also some good information here:
http://playground.sun.com/1275/practice/imap/imap0_9d.pdf

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
