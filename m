Return-Path: <bhuang2@uncc.edu>
Received: from uncc.edu (ironhost1.uncc.edu [152.15.42.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ironhost1.uncc.edu",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B6ACADE076
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Aug 2008 03:04:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C8F71B.16DE553D"
Subject: =?gb2312?B?cmUgo7pQQ0kgc3VwcG9ydCBvbiB0aGUgTUwzMTAgKExpbnV4IDIuNC8yLjYp?=
Date: Tue, 5 Aug 2008 12:48:29 -0400
Message-ID: <61B0EE7C247C1349881F63414448FC1F920F25@EXEVS06.its.uncc.edu>
References: <mailman.5.1217901608.24397.linuxppc-embedded@ozlabs.org>
From: "Huang, Bin" <bhuang2@uncc.edu>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8F71B.16DE553D
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

As far as I know, only MVista has complete PCI support for ML310. I have =
=20
been migrating their PCI stuff to 2.6 kernel for couple of months so I =
might =20
understand what you are suffering here.=20

If your system hangs just after "Xilinx ML310 Board-Specific =20
Initialization:", then probably there is something wrong with your =
OPB-PCI =20
core on virtex-2 FPGA. I highly recommend you double check the value of  =

"C_BRIDGE_IDSEL_ADDR_BIT" within your system.mhs file.=20

When the 2.4/2.6 kernel tries to initialize pci core, it has to do self- =

configuration first. If the wrong address is assigned in pci_init(), =
then =20
the kernel could not proceed any more.=20

Here is what you need to take care of:=20

for C_BRIDGE_IDSEL_ADDR_BIT =3D 24, use=20
pci_init()
{
    /* self-configuration */
    WR32(PCI_CONFIG_ADDR, htole32(0x80004004)); // address
    WR32(PCI_CONFIG_DATA, htole32(0xffff0147)); // data
    /* max latency timer on bridge */
    WR32(PCI_CONFIG_ADDR, htole32(0x8000400c)); // address
    WR32(PCI_CONFIG_DATA, htole32(0x0000ff00)); // data
    /* max bus number */
    WR32(PCI_CONFIG_ADDR+8, htole32(0xff000000));
};

for C_BRIDGE_IDSEL_ADDR_BIT =3D 16, use=20
pci_init()
{
    /* self-configuration */
    WR32(PCI_CONFIG_ADDR, htole32(0x80000004)); // address
    WR32(PCI_CONFIG_DATA, htole32(0xffff0147)); // data
    /* max latency timer on bridge */
    WR32(PCI_CONFIG_ADDR, htole32(0x8000000c)); // address
    WR32(PCI_CONFIG_DATA, htole32(0x0000ff00)); // data
    /* max bus number */
    WR32(PCI_CONFIG_ADDR+8, htole32(0xff000000));
};

You may check Xilinx's user guide 241 for more details.=20

Porting BSP from EDK9.1 to MVista 2.4 should be quite straightforward, =
but =20
porting them to 2.6 virtex is a little bit vague. If you are trying to =
use IDE =20
southbridge, I could recommend you start from 2.6.10 rather than 2.6 =
virtex =20
because driver/ide/pci/alim15x3.c has been updated a lot and I =20
hate to say that a none-disclosure agreement on alim15x3 makes it time =
consuming =20
to understand super I/O on ml310. If you just need PCI bus function, =
then life
will much more easier but you still need be care of about opb-pci core =
parameters

Bin





-----Original Message-----
From: linuxppc-embedded-bounces+bhuang2=3Duncc.edu@ozlabs.org =
=B4=FA=B1=ED linuxppc-embedded-request@ozlabs.org
Sent: 8/4/2008 (=D0=C7=C6=DA=D2=BB) 22:00
To: linuxppc-embedded@ozlabs.org
Subject: Linuxppc-embedded Digest, Vol 48, Issue 5
=20
Send Linuxppc-embedded mailing list submissions to
	linuxppc-embedded@ozlabs.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://ozlabs.org/mailman/listinfo/linuxppc-embedded
or, via email, send a message with subject or body 'help' to
	linuxppc-embedded-request@ozlabs.org

You can reach the person managing the list at
	linuxppc-embedded-owner@ozlabs.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Linuxppc-embedded digest..."


Today's Topics:

   1. PCI support on the ML310 (Linux 2.4/2.6) (Juliana Su)
   2. Re: Creating a wrapped zImage.initrd -- can't start the
      trampoline? (Grant Likely)
   3. Re: suffisant space for U-Boot,	Linux and an initrd image ?
      (4MB SDRAM) (Wolfgang Denk)


----------------------------------------------------------------------

Message: 1
Date: Mon, 04 Aug 2008 16:08:33 -0400
From: Juliana Su <js084@bucknell.edu>
Subject: PCI support on the ML310 (Linux 2.4/2.6)
To: linuxppc-embedded@ozlabs.org
Message-ID: <489761C1.8030805@bucknell.edu>
Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed

Hi,

I am trying to get PCI support on the ML310. I was able to port Linux=20
2.6 (linux-2.6-virtex from Secret Lab) onto the board, but unfortunately =

there is no PCI support in the kernel. When I enabled PCI support, I got =

the same errors (see below) that were reported on the Secret Lab Wiki.


  CC      arch/ppc/syslib/ppc4xx_setup.o
arch/ppc/syslib/ppc4xx_setup.c: In function `ppc4xx_map_io':
arch/ppc/syslib/ppc4xx_setup.c:118: error: `PPC4xx_PCI_IO_VADDR'=20
undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:118: error: (Each undeclared identifier=20
is reported only once
arch/ppc/syslib/ppc4xx_setup.c:118: error: for each function it appears =
in.)
arch/ppc/syslib/ppc4xx_setup.c:119: error: `PPC4xx_PCI_IO_PADDR'=20
undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:119: error: `PPC4xx_PCI_IO_SIZE'=20
undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:120: error: `PPC4xx_PCI_CFG_VADDR'=20
undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:121: error: `PPC4xx_PCI_CFG_PADDR'=20
undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:121: error: `PPC4xx_PCI_CFG_SIZE'=20
undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:122: error: `PPC4xx_PCI_LCFG_VADDR'=20
undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:123: error: `PPC4xx_PCI_LCFG_PADDR'=20
undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:123: error: `PPC4xx_PCI_LCFG_SIZE'=20
undeclared (first use in this function)
make[1]: *** [arch/ppc/syslib/ppc4xx_setup.o] Error 1
make: *** [arch/ppc/syslib] Error 2


I went back to Linux 2.4 (v2.4.20_mvl31-ml300), but the system hangs=20
during ml310_init( ), specifically when it gets to pci_init( ), in=20
ml310.c. I put some print statements in ml310.c to debug and found out=20
that it gets pass the first two lines in pci_init( ) before hanging.=20
Basically, all I get on my screen is:


Xilinx ML310 Board-Specific Initialization:


ml310_init( ) looks like this:


void
ml310_init()
{
    prints("\n\n");
    prints("Xilinx ML310 Board-Specific Initialization:\n");
    prints("\n");


    pci_init();
    ppb_init(9);
    pci_scan();
    sio_init();
    sbr_init();
};


and pci_init( ) looks like this:


void
pci_init()
{
    /* self-configuration */
    WR32(PCI_CONFIG_ADDR, htole32(0x80004004)); // address
    WR32(PCI_CONFIG_DATA, htole32(0xffff0147)); // data
    /* max latency timer on bridge */
    WR32(PCI_CONFIG_ADDR, htole32(0x8000400c)); // address
    WR32(PCI_CONFIG_DATA, htole32(0x0000ff00)); // data
    /* max bus number */
    WR32(PCI_CONFIG_ADDR+8, htole32(0xff000000));
};


ml310.c was generated when I made the BSP in Xilinx EDK 9.1. I copied=20
it, along with the other files from the BSP, into the kernel source. I=20
am using a Crosstool cross-compiler, gcc-3.4.1-glibc-2.3.3. I have also=20
tried the linuxppc-2.4 and mvistappc_2_4_devel kernels from=20
source.mvista.com, but those both crashed with similar (and several)=20
errors concerning ide-taskfile.c during compilation.

Is anybody aware of how to manually map the PCI constants in 2.6 and=20
willing to help me map them? Does anybody have an idea why pci_init( )=20
is getting stuck? Any suggestions, in general, would be greatly =
appreciated.

Let me know if I need to provide more information or code. Thanks!


-Juliana



------------------------------

Message: 2
Date: Mon, 4 Aug 2008 15:30:07 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Creating a wrapped zImage.initrd -- can't start the
	trampoline?
To: paul@mad-scientist.us
Cc: Linuxppc-embedded@ozlabs.org
Message-ID:
	<fa686aa40808041430q2d81f2a9i600e9ae17f658d01@mail.gmail.com>
Content-Type: text/plain; charset=3DISO-8859-1

On Mon, Aug 4, 2008 at 1:43 PM, Paul Smith <paul@mad-scientist.us> =
wrote:
> On Mon, 2008-08-04 at 11:25 -0600, Grant Likely wrote:
>> Take a look at Documentation/powerpc/bootwrapper.txt
>> You probably want the 'simpleImage.%' target.  It also binds in a =
copy
>> of the device tree blob.
>
> Hm.  I'm using 2.6.25.14 and I don't see any bootwrapper.txt file in
> Documentation/powerpc (or anywhere else).  I also can't see any target
> simpleImage in any makefile.  Is this something new in 2.6.26?  :-(
>
> Any help for folks still using 2.6.25?

It's new in .26, but it is relevant for .25 also.

Here's a link to it:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dbl=
ob;f=3DDocumentation/powerpc/bootwrapper.txt;h=3Dd60fced5e1cc69169d9bbf1b=
49faacb41ef8db9c;hb=3D8f616cd5249e03c9e1b371623d85e76d4b86bbc1

> I think I need some basic instruction on how bootloaders etc. work, =
with
> a concentration on embedded PPC if possible.  Anyone have any pointers
> that would be worth investigating?

The document above should help.
Documentation/powerpc/booting-without-of.txt has some useful
information also.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.


------------------------------

Message: 3
Date: Tue, 05 Aug 2008 00:59:57 +0200
From: Wolfgang Denk <wd@denx.de>
Subject: Re: suffisant space for U-Boot,	Linux and an initrd image ?
	(4MB SDRAM)
To: Fabien Oriede <fabien.oriede@yahoo.fr>
Cc: linuxppc-embedded@ozlabs.org
Message-ID: <20080804225958.0827524848@gemini.denx.de>
Content-Type: text/plain; charset=3DISO-8859-1

In message <789365.58211.qm@web27401.mail.ukl.yahoo.com> you wrote:
>
> I would like to know if this is possible to port U-Boot, Linux and an =
initrd?image on a?board with 4MB of SDRAM ?

In Theory it may be possible, but just for very tiny demo
applications. Probably not for a useful device.

> When Linux try to boot, there is this line on the terminal :
> "Memory : 2036k available (1036k kernel code, 256k data, 80k init, 0k =
highmem)"
> So I have 2036k?memory available?for my initrd image?but I don't know =
if this is suffisant.

Note that a ramdisk is NOT an efficient way to use memory. See fro
example http://www.denx.de/wiki/view/DULG/RootFileSystemSelection
which shows that for example a cramfs image is not only faster to boot
but also needs less RAM.

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Keep your head and your heart going in the right  direction  and  you
will not have to worry about your feet.


------------------------------

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

End of Linuxppc-embedded Digest, Vol 48, Issue 5
************************************************


------_=_NextPart_001_01C8F71B.16DE553D
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+Ih8QAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEALQAAAHJlIDpQQ0kgc3VwcG9ydCBv
biB0aGUgTUwzMTAgKExpbnV4IDIuNC8yLjYpAO8MAQWAAwAOAAAA2AcIAAUADAAwAB0AAgBHAQEg
gAMADgAAANgHCAAFAAwAMAAeAAIASAEBCYABACEAAAAyOEZFNjcyNENFMTdGRjRDQkJGRTAxMTM5
M0M0MjE3OQBFBwEDkAYAECAAADkAAAADACYAAAAAAAMANgAAAAAAQAA5AD1V3hYb98gBHgA9AAEA
AAABAAAAAAAAAAIBRwABAAAANwAAAGM9VVM7YT0gO3A9VU5DIENoYXJsb3R0ZTtsPUVYRVZTMDYt
MDgwODA1MTY0ODI5Wi0xNjI3NAAAHgBJAAEAAAAqAAAATGludXhwcGMtZW1iZWRkZWQgRGlnZXN0
LCBWb2wgNDgsIElzc3VlIDUAAABAAE4AAARo/J72yAEeAFoAAQAAADYAAABsaW51eHBwYy1lbWJl
ZGRlZC1ib3VuY2VzK2JodWFuZzI9dW5jYy5lZHVAb3psYWJzLm9yZwAAAAIBWwABAAAAiQAAAAAA
AACBKx+kvqMQGZ1uAN0BD1QCAAAAAGxpbnV4cHBjLWVtYmVkZGVkLWJvdW5jZXMrYmh1YW5nMj11
bmNjLmVkdUBvemxhYnMub3JnAFNNVFAAbGludXhwcGMtZW1iZWRkZWQtYm91bmNlcytiaHVhbmcy
PXVuY2MuZWR1QG96bGFicy5vcmcAAAAAAgFcAAEAAAA7AAAAU01UUDpMSU5VWFBQQy1FTUJFRERF
RC1CT1VOQ0VTK0JIVUFORzI9VU5DQy5FRFVAT1pMQUJTLk9SRwAAHgBdAAEAAAAlAAAAbGludXhw
cGMtZW1iZWRkZWQtcmVxdWVzdEBvemxhYnMub3JnAAAAAAIBXgABAAAAZwAAAAAAAACBKx+kvqMQ
GZ1uAN0BD1QCAAAAAGxpbnV4cHBjLWVtYmVkZGVkLXJlcXVlc3RAb3psYWJzLm9yZwBTTVRQAGxp
bnV4cHBjLWVtYmVkZGVkLXJlcXVlc3RAb3psYWJzLm9yZwAAAgFfAAEAAAAqAAAAU01UUDpMSU5V
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
scJiABBZ4emTZg/Q78a8ht/yL4j8X/Qv9T/2Cv8OVZl+sHFW8ASis9B3MPcf25ofXjhzXtGaiC8t
4gFh/2GxdzF/EWG0+grwaoOwbKC/RHH5vwYgd1AK0W/wVt3AvRowOG/wUmAKkETANdpEXioDTwRf
BTvwan0HEAAAHgA1EAEAAAA+AAAAPDYxQjBFRTdDMjQ3QzEzNDk4ODFGNjM0MTQ0NDhGQzFGOTIw
RjI1QEVYRVZTMDYuaXRzLnVuY2MuZWR1PgAAAB4AORABAAAAOgAAADxtYWlsbWFuLjUuMTIxNzkw
MTYwOC4yNDM5Ny5saW51eHBwYy1lbWJlZGRlZEBvemxhYnMub3JnPgAAAB4ARxABAAAADwAAAG1l
c3NhZ2UvcmZjODIyAAALAPIQAQAAAB8A8xABAAAAYgAAAHIAZQAgABr/UABDAEkAIABzAHUAcABw
AG8AcgB0ACAAbwBuACAAdABoAGUAIABNAEwAMwAxADAAIAAoAEwAaQBuAHUAeAAgADIALgA0AP/4
MgAuADYAKQAuAEUATQBMAAAAAAALAPYQAAAAAEAABzAqk8niFvfIAUAACDCd3ecWG/fIAQMA3j+o
AwAAAwDxPwQIAAAeAPg/AQAAAAsAAABIdWFuZywgQmluAAACAfk/AQAAAFkAAAAAAAAA3KdAyMBC
EBq0uQgAKy/hggEAAAAAAAAAL089VU5DIENIQVJMT1RURS9PVT1VTkNDSEFSTE9UVEUtTlQvQ049
UkVDSVBJRU5UUy9DTj1CSFVBTkcyAAAAAB4A+j8BAAAAFQAAAFN5c3RlbSBBZG1pbmlzdHJhdG9y
AAAAAAIB+z8BAAAAHgAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAAAAAAAAAuAAAAAwD9P+QEAAAD
ABlAAAAAAAMAGkAAAAAAAwAdQAAAAAADAB5AAAAAAB4AMEABAAAACAAAAEJIVUFORzIAHgAxQAEA
AAAIAAAAQkhVQU5HMgAeADJAAQAAADYAAABsaW51eHBwYy1lbWJlZGRlZC1ib3VuY2VzK2JodWFu
ZzI9dW5jYy5lZHVAb3psYWJzLm9yZwAAAB4AM0ABAAAAJQAAAGxpbnV4cHBjLWVtYmVkZGVkLXJl
cXVlc3RAb3psYWJzLm9yZwAAAAAeADhAAQAAAAgAAABCSFVBTkcyAB4AOUABAAAAAgAAAC4AAAAD
AHZA/////wsAKQAAAAAACwAjAAAAAAADAAYQKZBqYAMABxBUIAAAAwAQEAAAAAADABEQAAAAAB4A
CBABAAAAZQAAAEFTRkFSQVNJS05PVyxPTkxZTVZJU1RBSEFTQ09NUExFVEVQQ0lTVVBQT1JURk9S
TUwzMTBJSEFWRUJFRU5NSUdSQVRJTkdUSEVJUlBDSVNUVUZGVE8yNktFUk5FTEZPUkNPVVAAAAAA
AgF/AAEAAAA+AAAAPDYxQjBFRTdDMjQ3QzEzNDk4ODFGNjM0MTQ0NDhGQzFGOTIwRjI1QEVYRVZT
MDYuaXRzLnVuY2MuZWR1PgAAAMdM

------_=_NextPart_001_01C8F71B.16DE553D--
