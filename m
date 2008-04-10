Return-Path: <Leonid@a-k-a.net>
Received: from mis011.exch011.intermedia.net (mis011.exch011.intermedia.net
	[64.78.21.10]) by ozlabs.org (Postfix) with ESMTP id BC80ADE5D9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Apr 2008 01:16:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Access physical memory via mmap() on ppc440epx.
Date: Thu, 10 Apr 2008 08:15:59 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3C02529303@ehost011-3.exch011.intermedia.net>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C033A9D08@ehost011-3.exch011.intermedia.net>
References: <406A31B117F2734987636D6CCC93EE3C033A981B@ehost011-3.exch011.intermedia.net><1207100665.12155.100.camel@vader.jdub.homelinux.org><406A31B117F2734987636D6CCC93EE3C025292E2@ehost011-3.exch011.intermedia.net>
	<406A31B117F2734987636D6CCC93EE3C033A9D08@ehost011-3.exch011.intermedia.net>
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

I have double checked, mmap64 doesn't work either. This is the piece of
code which does re-mapping:

    unsigned long long StartAddressL =3D 0x100000000ULL | StartAddress;

        mmap_addr =3D (unsigned int) mmap64(NULL,=20
                                        size,=20
                                        PROT_READ | PROT_WRITE,
                                        MAP_SHARED,=20
                                        dev_mem_fd,=20
                                        StartAddressL);

While in GDB I can see variables' values:

(gdb) p/x mmap_addr
$1 =3D 0x30028000
(gdb) p/x StartAddressL
No symbol "StartAddressL" in current context.
(gdb) p/x StartAddress
$2 =3D 0xfc240000
(gdb) p/x size
$3 =3D 0x60000
(gdb)

This call returns successfully, but when I stop the board and dump TLB
entries (I have BDI2000 connected) on BDI2000 screen, there is no entry
with this physical address.

However when I also do re-mapping (using ioremap64()) in kernel driver
(physical address is different - 0xea000000), this is the code:

if((mcfp_ebi_baseptr =3D ioremap64 (0x1ea000000ULL, 512)) =3D=3D NULL) {
...

When I stop in debugger right after remapping, TLB entry shows up but
somewhat non-completed yet:

10 : 00 00000000   1KB -0 -> 1_ea000000 U:0000 -I-G- XWRXWR

Later, when I stop board right BEFORE actual accessing memory, the entry
is
present:

23 : 00 d1050000   4KB V0 -> 1_ea000000 U:0000 -IMG- ----WR

And kernel driver is working.

So something is definitely wrong with mmap/mmap64 call itself. Should I
use different parameters?=20

Thanks,

Leonid.


-----Original Message-----
From: linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org
[mailto:linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org] On =
Behalf
Of Leonid
Sent: Wednesday, April 02, 2008 3:51 PM
To: Josh Boyer
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Access physical memory via mmap() on ppc440epx.

Hi, Josh:

I have resolved my kernel driver problem, it was my own bug, didn't have
anything to do with memory remapping itself. Your suggestion to move to
ioremap64() did resolve problem completely.

I still need investigate mmap() crash. Apparently switch to mmap64()
didn't help, but it could be some another bug, I'll double check.

Thanks,

Leonid.=20

-----Original Message-----
From: linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org
[mailto:linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org] On =
Behalf
Of Leonid
Sent: Tuesday, April 01, 2008 9:30 PM
To: Josh Boyer
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Access physical memory via mmap() on ppc440epx.

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
From: Josh Boyer [mailto:jwboyer@gmail.com]
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

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
