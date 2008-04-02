Return-Path: <Leonid@a-k-a.net>
Received: from mis011.exch011.intermedia.net (mis011.exch011.intermedia.net
	[64.78.21.10]) by ozlabs.org (Postfix) with ESMTP id 3F775DDE22
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Apr 2008 15:30:02 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Access physical memory via mmap() on ppc440epx.
Date: Tue, 1 Apr 2008 21:30:00 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3C025292E2@ehost011-3.exch011.intermedia.net>
In-Reply-To: <1207100665.12155.100.camel@vader.jdub.homelinux.org>
References: <406A31B117F2734987636D6CCC93EE3C033A981B@ehost011-3.exch011.intermedia.net>
	<1207100665.12155.100.camel@vader.jdub.homelinux.org>
From: "Leonid" <Leonid@a-k-a.net>
To: "Josh Boyer" <jwboyer@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Josh:

Thank you for your suggestion. Somehow it didn't work with mmap (may be,
my mistake, I'll double check), however it partially helped me with my
another problem.

I have kernel driver where I need read/write some HW device, connected
on address 0xea000000, chip select 4. This chip select configured
properly, here are EBC registers:

440EPx>rd ebc0_b4cr
ebc0_b4cr: 0xea01a000  -368992256
440EPx>rd ebc0_b4ap
ebc0_b4ap: 0x03037000  50556928

>From u-boot I can read/write this address with no problem (I use md/mw
commands).

In my driver I tried to ioremap() this address and any attempt to access
led to crash, same as with mmap().

When, following your suggestion, I used address 0x1ea00000 and
ioremap64(), crashes disappeared!

I even can write, but when I read data back I see least significant byte
of each 16 bits word only (bus is configured 16 bits width).=20

What can it be?

Thanks,

Leonid.=20

-----Original Message-----
From: Josh Boyer [mailto:jwboyer@gmail.com]=20
Sent: Tuesday, April 01, 2008 6:44 PM
To: Leonid
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Access physical memory via mmap() on ppc440epx.

On Tue, 2008-04-01 at 14:12 -0700, Leonid wrote:
> Hi:
>=20
> I am trying to read from NOR flash, located on address 0xfc000000, on
my

It's at 0x1fc000000 IIRC.

> TLB entries look strange though. That what it was on u-boot stage:
>=20
> 440EPx>tlb 0 10
> IDX TID      EPN  SIZE VTS          RPN   USER WIMGE USRSVC
>  0 : 00 40000000 256MB V0 -> 0_00000000 U:0000 -I-G- XWRXWR
>  1 : 00 00000000 256MB V0 -> 0_00000000 U:0000 -I-G- XWRXWR
>  2 : 00 c0000000 256MB V0 -> 1_c0000000 U:0000 -I-G- XWRXWR
>  3 : 00 f0000000 256MB V0 -> 1_f0000000 U:0000 WI-G- XWRXWR

See.  Virtual is 0xf0000000, physical is 0x1f0000000.

> On Linux stage it looks rather different:

I don't even see your entry in here.  Likely because the TLB is small
and it's gone by the time you do the dump

> Probably under MMU it should look this way? How to use mmap() then?

Try mmap64 on the real physical address and see if that helps.

josh
