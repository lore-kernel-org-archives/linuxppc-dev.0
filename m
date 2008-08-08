Return-Path: <bhuang2@uncc.edu>
Received: from uncc.edu (ironhost1.uncc.edu [152.15.42.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ironhost1.uncc.edu",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A5530DDF03
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Aug 2008 09:54:01 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C8F9B1.FC15D1CC"
Subject: Re: Re: PCI support on the ML310 (Linux 2.4/2.6) (Juliana Su)
Date: Fri, 8 Aug 2008 19:49:22 -0400
Message-ID: <61B0EE7C247C1349881F63414448FC1F920F27@EXEVS06.its.uncc.edu>
References: <mailman.3.1217988003.3121.linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C8F9B1.FC15D1CC
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable


There are a lot of pitfalls that might give you such kernel panic and I =
am sure I did not have a chance to experience them all. But I can share =
with you my check list for the panic of hanging at "Now booting the =
kernel".

Firstly, you may uncheck PCI bus option in your kernel config. If you =
still cannot get "Now booting the kernel" passed, then you need to make =
sure there are 128Mb ddr RAM on your ML310. From your booting message, I =
assume you have 128Mb RAM. But if actually you don't have that much =
size, the kernel may get confused and stuck.

Secondly, if you see this panic only when enabling PCI bus option, then =
I suggest you look into your arch/ppc/kernel/ppc405_pci.c, make sure the =
kernel actually execute this piece of code:

#ifdef CONFIG_XILINX_OCP
	/* Eliminate "unused variable" warning for pcip.  Optimizer removes. */
	pcip =3D NULL;
	new_pmm_min =3D PPC405_PCI_LOWER_MEM;
	new_pmm_max =3D PPC405_PCI_UPPER_MEM;

Some mainline kernel does not have CONFIG_XILINX_OCP setting for you , =
and ML310/ML410 does need them to boot up PCI bus.=20

Let me know if you still have problem.=20

Bin




-----Original Message-----
From: linuxppc-embedded-bounces+bhuang2=3Duncc.edu@ozlabs.org =
=B4=FA=B1=ED linuxppc-embedded-request@ozlabs.org
Sent: 8/5/2008 (=D0=C7=C6=DA=B6=FE) 22:00
To: linuxppc-embedded@ozlabs.org
Subject: Linuxppc-embedded Digest, Vol 48, Issue 7
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

   1. Re: floating point support in the driver. (David Hawkins)
   2. Re: PCI support on the ML310 (Linux 2.4/2.6) (Juliana Su)


----------------------------------------------------------------------

Message: 1
Date: Tue, 05 Aug 2008 09:53:45 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: floating point support in the driver.
To: Misbah khan <misbah_khan@engineer.com>
Cc: linuxppc-embedded@ozlabs.org
Message-ID: <48988599.5020008@ovro.caltech.edu>
Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed

Hi Misbah,

> I am running the algorithm on OMAP processor (arm-core)
> and i did tried the same on iMX processor which
> takes 1.7 times more than OMAP.

Ok, thats a 10,000ft benchmark. The observation being
that it fails your requirement.

How does that time compare to the operations
required, and their expected times?

> It is true that the algorithm is performing the vector
> operation which is blowing the cache.

Determined how? Obviously if your cache is 16K and your
data is 64K, there's no way it'll fit in there at once,
but the algorithm could be crafted such that 1K at a time
was processed, while another data packet was moved onto
the cache ... but this is very processor specific.

> But the question is How to lock the cache ? In driver
> how should we implement the same ?
>=20
> An example code or a document could be helpful in this regard.

Indeed :)

I have no idea how the OMAP works, so the following are
just random, and possibly incorrect ramblings ...

The MPC8349EA startup code uses a trick where it zeros
out sections of the cache while providing an address.
Once the addresses and zeros are in the cache, its locked.
 From that point on, memory accesses to those addresses
result in cache 'hits'. This is the startup stack used
by the U-Boot bootloader.

If something similar was done under Linux, then *I guess*
you could implement mmap() and ioremap() the section of
addresses associated with the locked cache lines.
You could then DMA data to and from the cache area,
and run your algorithm there. That would provide you
'fast SRAM'.

However, you might be able to get the same effect by
setting up your processing algorithm such that it handled
smaller chunks of data.

Feel free to explain your data processing :)

Cheers,
Dave




------------------------------

Message: 2
Date: Tue, 05 Aug 2008 15:09:28 -0400
From: Juliana Su <js084@bucknell.edu>
Subject: Re: PCI support on the ML310 (Linux 2.4/2.6)
To: linuxppc-embedded@ozlabs.org
Message-ID: <4898A568.10502@bucknell.edu>
Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed

Hi,

Thanks for your reply, Bin! I checked system.mhs and =
"C_BRIDGE_IDSEL_ADDR_BIT" was set to 16, but the code that was in =
pci_init( ) was the code for as if "C_BRIDGE_IDSEL_ADDR_BIT" was set to =
24. After replacing the code in pci_init( ), the PCI now initializes. =
However, after the ML310 initialization finishes, the system hangs at =
"Now booting the kernel". I remember encountering this problem when I =
was porting Linux 2.6. It had to do with a linker problem and after =
rolling back to gcc-4.0.2, I got past the problem. I'm using Linux 2.4, =
though, so that solution will not work here... I am using UART Lite and =
I made sure that it (and not UART 16550) was selected in the kernel =
configuration and that "Console on UART Lite port" was selected as well. =
I also made sure that UART Lite was what was chosen when I built the =
BSP. Oh, and there is a /dev/ttyUL0 device node in my root file system. =
I even did a "make mrproper" and re-did the kernel configuration, but =
that did not solve my pro
 blem. Any suggestions? Thanks!


-Juliana



Xilinx ML310 Board-Specific Initialization:                              =
      =20
                                                                         =
      =20
ppb_init: dev =3D  9, id =3D ac23104c                                    =
          =20
pci_scan: bus 0, device  0, id 030010ee                                  =
      =20
pci_scan: bus 0, device  1, id 545110b9                                  =
      =20
pci_scan: bus 0, device  2, id 153310b9                                  =
      =20
pci_scan: bus 0, device  3, id 545710b9                                  =
      =20
pci_scan: bus 0, device  7, id 12298086                                  =
      =20
pci_scan: bus 0, device  9, id ac23104c                                  =
      =20
pci_scan: bus 0, device 12, id 710110b9                                  =
      =20
pci_scan: bus 0, device 15, id 523710b9                                  =
      =20
sio_init: Device ID =3D 53 15, Revision =3D f3.                          =
          =20
sio_init: LPT1 base =3D 0x0378, irq =3D 5.                               =
          =20
sio_init: COM1 base =3D 0x03f8, irq =3D 4.                               =
          =20
sio_init: COM2 base =3D 0x02f8, irq =3D 3.                               =
          =20
sio_init: KBC irq =3D 1, PS2 irq =3D 1.                                  =
          =20
sio_init: Super I/O initialization complete.                             =
      =20
                                                                         =
      =20
loaded at:     00400000 004E91F4                                         =
      =20
board data at: 004E613C 004E6154                                         =
      =20
relocated to:  00406410 00406428                                         =
      =20
zimage at:     00406BF9 004E5566                                         =
      =20
avail ram:     004EA000 08000000                                         =
      =20
                                                                         =
      =20
Linux/PPC load: console=3DttyUL0,9600 ip=3Doff =
root=3D/dev/xsysace/disc0/part2 rw    =20
Uncompressing Linux...done.                                              =
      =20
Now booting the kernel   =20



------------------------------

Message: 11
Date: Tue, 5 Aug 2008 12:48:29 -0400
From: "Huang, Bin" <bhuang2@uncc.edu>
Subject: re ?PCI support on the ML310 (Linux 2.4/2.6)
To: <linuxppc-embedded@ozlabs.org>
Message-ID:
	<61B0EE7C247C1349881F63414448FC1F920F25@EXEVS06.its.uncc.edu>
Content-Type: text/plain; charset=3D"gb2312"

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
From: linuxppc-embedded-bounces+bhuang2=3Duncc.edu@ozlabs.org ?? =
linuxppc-embedded-request@ozlabs.org
Sent: 8/4/2008 (???) 22:00
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

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

End of Linuxppc-embedded Digest, Vol 48, Issue 7
************************************************


------_=_NextPart_001_01C8F9B1.FC15D1CC
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IioXAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAPgAAAFJlOiBSZTogUENJIHN1cHBv
cnQgb24gdGhlIE1MMzEwIChMaW51eCAyLjQvMi42KSAoSnVsaWFuYSBTdSkA/REBBYADAA4AAADY
BwgACAATADEAFgAFAE4BASCAAwAOAAAA2AcIAAgAEwA1ACkABQBlAQEJgAEAIQAAADgwNjA2QUVF
OUZDNzk3NDFBOTdENzQxMjFEMzlBQ0NFAE0HAQOQBgCQJwAAOQAAAAMAJgAAAAAAAwA2AAAAAABA
ADkADZKaYbH5yAEeAD0AAQAAAAUAAABSZTogAAAAAAIBRwABAAAANwAAAGM9VVM7YT0gO3A9VU5D
IENoYXJsb3R0ZTtsPUVYRVZTMDYtMDgwODA4MjM1MzQxWi0yMzczMgAAHgBJAAEAAAAqAAAATGlu
dXhwcGMtZW1iZWRkZWQgRGlnZXN0LCBWb2wgNDgsIElzc3VlIDcAAABAAE4AgNPWI2j3yAEeAFoA
AQAAADYAAABsaW51eHBwYy1lbWJlZGRlZC1ib3VuY2VzK2JodWFuZzI9dW5jYy5lZHVAb3psYWJz
Lm9yZwAAAAIBWwABAAAAiQAAAAAAAACBKx+kvqMQGZ1uAN0BD1QCAAAAAGxpbnV4cHBjLWVtYmVk
ZGVkLWJvdW5jZXMrYmh1YW5nMj11bmNjLmVkdUBvemxhYnMub3JnAFNNVFAAbGludXhwcGMtZW1i
ZWRkZWQtYm91bmNlcytiaHVhbmcyPXVuY2MuZWR1QG96bGFicy5vcmcAAAAAAgFcAAEAAAA7AAAA
U01UUDpMSU5VWFBQQy1FTUJFRERFRC1CT1VOQ0VTK0JIVUFORzI9VU5DQy5FRFVAT1pMQUJTLk9S
RwAAHgBdAAEAAAAlAAAAbGludXhwcGMtZW1iZWRkZWQtcmVxdWVzdEBvemxhYnMub3JnAAAAAAIB
XgABAAAAZwAAAAAAAACBKx+kvqMQGZ1uAN0BD1QCAAAAAGxpbnV4cHBjLWVtYmVkZGVkLXJlcXVl
c3RAb3psYWJzLm9yZwBTTVRQAGxpbnV4cHBjLWVtYmVkZGVkLXJlcXVlc3RAb3psYWJzLm9yZwAA
AgFfAAEAAAAqAAAAU01UUDpMSU5VWFBQQy1FTUJFRERFRC1SRVFVRVNUQE9aTEFCUy5PUkcAAAAe
AGYAAQAAAAUAAABTTVRQAAAAAB4AZwABAAAANgAAAGxpbnV4cHBjLWVtYmVkZGVkLWJvdW5jZXMr
Ymh1YW5nMj11bmNjLmVkdUBvemxhYnMub3JnAAAAHgBoAAEAAAAFAAAAU01UUAAAAAAeAGkAAQAA
ACUAAABsaW51eHBwYy1lbWJlZGRlZC1yZXF1ZXN0QG96bGFicy5vcmcAAAAAHgBwAAEAAAA6AAAA
UmU6IFBDSSBzdXBwb3J0IG9uIHRoZSBNTDMxMCAoTGludXggMi40LzIuNikgKEp1bGlhbmEgU3Up
AAAAAgFxAAEAAAAbAAAAAcj3aDERk/JI0ryBSfSgWCkBXamZFgCSTCK4AB4AdAABAAAAHQAAAGxp
bnV4cHBjLWVtYmVkZGVkQG96bGFicy5vcmcAAAAAHgAaDAEAAAALAAAASHVhbmcsIEJpbgAAHgAd
DgEAAAA6AAAAUmU6IFBDSSBzdXBwb3J0IG9uIHRoZSBNTDMxMCAoTGludXggMi40LzIuNikgKEp1
bGlhbmEgU3UpAAAAAgEJEAEAAADyHgAA7h4AALVEAABMWkZ1MiQEWQMACgByY3BnMTI14jIDQ3Rl
eAVBAQMB908KgAKkA+MCAGNoCsBz8GV0MCAHEwKAD/MAUH8EVghVB7IRxQ5RAwEQxzJ3BgAGwxHF
MwRGEMkS32bWNBBeDiA4BdJNC4AQ4N5vAoAR0wjvCfc7Gw8OMHY1EcIMYGMAUAsJAWQznjYRUAum
CuMKgFRoBJBsZSAKwCCBIBqgBUBvsGYgcGkAMAdAbAQghnQQ8AVAbWlnaAVAKGdpdiCAeQhgIHPR
HcBoIGsEkWUDIAqwhQMAYyCQbmQgSSCQTm0jMSBxJKBkaSSAbn8hERDwItEg4BDhGdAggHT0byAO
wHAGcQnwJpIgUMMk0CGxLiBCdQVAJKD6YwORcxDxIIAD8CIAIvPsbXkmQQWQayDwBAAFQP8CEAXA
J6Ej9SFBJmEisCvg4yCQBUAiTm8H4AbgIRBnLAIq8iOUIi4f5B/kRkJpERB0bHksKYRhTSngdRnR
KiJQQySgYqp1BCBvBTBpAiAgC4DPIvIFwCOVBaBuZiJgKCB+SSFQIwMs8CHAKJIlomf/ETAsby12
I/EEEAmALzAnof8xUyWQCeAkgCbBAMAjkCTkpyehIHUZQU1iJVBkBcAYUkFNITAxVU1MM/QxMCgg
RgNhMWQ0hgeBvHNhM/AvMCShBBB1B4B/IvMl4ziUOTEoJAaQIJBjXHR1IbEp4CMCZAIgJ+8lxSIE
I1IAkHo74S1IL4N/M/IyMjCgNvEkYiqAHcBr9y37BmAyMWQvEj4hIwMJ4Nch8QQAKyZuPrF3NlIJ
8H8BoCpgLBEwXDYlJKAjQGfvM/AqgSMCGqBvKkALgCbBBzFzCsAQ4C9wcGMvQyOUSoI0MDVfSqBp
/C5jLzA3WyOGPlcOwAWQfyhQRSYIkCaRIUEFoAEAOh0uCiMGkAEBFwBPTkYASUdfWElMSU5gWF9P
Q1AuBQGRIPAvKiBFKmAiUEagTlF2Ii/QQkN2CsAHMAJgZX01oHcKwAMALBEqskuxcPkoICBPMOEi
UECQBcAbEMsEYCLQcyggKi9R+VVSxCA9B7BVTEwcIFIIxSPAd0ugbW1fUwFYAQ5QMFBLcjBRX0xP
V8BFUl9NRU1Yf1mC9GF4WexVWhBa/EOkA3D/IIAAwAuARtFA9z8gB5Elp/9Q70TxAkBU1iMCLzAk
Yjnz+i858DQ6IGBFNuMnsibBvzSCL8BX8DBVKCAuCkw0AX08cWsloAfgRJYzMyXjcOsDYFRBbWaM
QguBLhlrL/QKLWyiTwUQK/EHQAXQzzuUbKMuBSKAbWwAIRgF7wwBbrURUDpiOipRU5AnADVKoC0n
wGIJgAEAZC3HBuAv0QeQK2JoPoAr4CQyPS/RYy4JgHVAdG96C2BiVsAFsCwgXGQnOQBQJ2UV0HQg
Na10EDUkQHC/LRsQcQpQ7yqAc1lupgKxfW+4bk9vXocGYAIwcJA4LzUvAdCaMBlgKHQRAUAnYXfQ
+Cc4YXQQIaB0EXSBAEDgKSAyMjp7gHdveHk8VG9wnwmAdrpDpHVilmoFkHsBTHU+IEQiYItI0S8w
VgbwIDQ4O/H7PEEggDcf5B/VetEkgIJ/719CRtMqYyNAYiJQBBAxAf0h4W9R+X/PgN9/JogCBPLf
cWAhMAXAL9CMWHYHMCrjalcFsGwkgFclcI5BZW5iLzCN4ACQdFH5IoB0oHBzOi8vc2gvh0L9A4Ev
KmILgAIQkgFw3R/k/wWwj0Ig4CfAh1EvMBEgJHF/IOA7hSk0iBGCEoziBuBkxSngJyBQbHAniM91
X/t2by4ZWSMRKKIbEADQI3D7KvMEkHMxEQOBO8AtBipj3yIgl99xGjRQI8Bymh8f5O5XNlIbEAtQ
eSwBLzALUP+cEBEgJuAlYEjzBcCB5Z7yvzeBJtCjYUVhBGAgcXMnED9LwDJgAOAf8yIBA6AiUv9P
kBcBAjB64TCxIVCGLyVRtUjCLqlQImuPf3FkL6DuJwQgf4AhcGOQoC4KVaB3OIAoIKbSZhqgIiAs
AnD+b0mhIzFKkBqxMTIq8jkAZSLBciggKEQl8CVxSEhhd2sLgHMprAcy/6ykMFKt9jERKvI583uw
p9MlsNE0e2AuNn1QKEr+dSpgnSGj0bBFa++2D7cf/7gvuRwuCm2Ff6Ad4wqAr3D7DrB/oFQKUC8w
S4ARYEigA31ge4IwOTo1MzriNLygLTA3faEudHBjsa97IDxkRkBzUHYDYN9L4AdADrAQ4HMSPoGN
rM+Prd+u5X8oGbBzYmEjca2mgjyIQcWBX8XCQAnwLyvxCeCvMAWgbcElQ2NHf6+Kn7rHLUlEyDA8
AYRQOTg4NTk5Lnw1MHtxe5DAH8empyQtfFR5JxDIMA6ySoALYjuDJkIREj1JU08ty3J8LTHPQCqx
AMDPwMJhd1OTlh/kSGnFRSwuCj69JJRyL9BUwyryB0BnBbDHKVEk0DERT01BYjBpQZdyEZzQBcAo
CsBtLQWhvmWwRdOQJGLSQCVidAiBn2TzIzAkwE8RMSFNWNXZ+0ZADeBo0zYBkCOQBCCskH43IfAH
c6VDpnPVki37T75rNiIiIAQgIOA6ICzMAf8BgDRwJ1HVMArAQxCrICsB+2lgESByU/Aw83FgLAGm
F/8+ASqRh1EEIDFzmaIu0CfA+3rhLftINFFgUyID27IyIf5tCrEmoyryMNAEkOBjELD/H/PipTYR
JGInoS7QJuM+YPs28gdyP9LdpPPYQITB5LT/1JtFYgSQ0KItBiLQPmAFsP/TNuZH2jSlAgJgNFAt
Biig+yoBLftEETAEkFMBNvEZ8LR3P1WwYo3gCGBzPrGPRJQFwPAjpQIxNkskUx8xch/kqtABkKUC
NjRLPzYjGxCrASWgVIHywXQn/zNRMmCuViBysfImkNLFMJD/6z4FoLQAJICMwQUAfDDo0vsjQyID
MfQRnhHbox/kVJD/RXHV9DYC2kFUUCRRIRAgUf8lUPUiCrAqMDQB/NJWgiSA9wIhl8Xv5yCpUTCB
6zJFYf9FYa8RKeDV6KWWLfvTkChC/yrymcMxA95A5CImwRqgKjH7AKjyIEngoK7k0zbx8SjR//oT
0UAxMOVwaYF64diY6WXr05DTNkFGcXgkwKLRT1P/jOIg4D8gTjAJo/oHl1JCMO9NUK5zRWEbEGce
ES37B2D7HrA28Tq0mySgJeP2YY7RLyDgCHIq8tWTd5bAa3N/lOHl5FUQIcDvhDhRrARq/zCg+/Dm
cCRwXxBjVMLwiGH/GuDywRnQlsAbEJaR5nBxUD9G0t5AqVGLa7JSMFA4M/A0OUVBMxGsID5wV/D/
DENCQd5C2EEqMUZBOGGjYf9WIRZwk7UoUaMQPmCIgyFBvwCo/cRpQa+RLAPgoGE48fs7kS31Tydl
H6Ya8iRxHDP/OEOudfAjRHGncQZSyUAt9f86VD/TwvRH4uUgpUGXIJwg//1DiLI/wRZwIQnm5vsQ
wJDvMTLzZJdAI4En36IB5NijfxoVGgEGcUJC+IWXIJxiVfwtQmWiZZLCcYNQxJYP1f8dwJzQ5SBF
QVThiHBZsHOA/9oh/OE/IRqxEEE5EKfTNiXKKjwQZ3ZxcyqsBGMSx/oECVhZgGFwKH1Q16P/pVEz
tNijHTQdoawEISnWMf9LwFMxCQGWAp2jI9PzVV+S7yAWm4P6E0gjRNWg/pQGId1jcmYktADGImFh
0sVjcv/UAUnl1Nf149+i+AETQPoiPx7k9+BjEawEfKEVcVNS7EFNKbDjbWWvEfXAYxL9WbBnb8D6
UlQyBhJt0AnZ/VCwZqQiLCCsBGJWZeGjk7/V5R9D1Nf7GKNhpoFkVFD9k6VzlKBNwP5xz2DUEBNw
9x2i9RLjW0bHMPcRDwDls7/ogc8Co4T+pEcIEKxD97D/nLHSxa9xFOVQr7VfUx+5/827BTK7j7ya
MTV9kL1gfjJ7oL3gWkC+K7P4v8BqcnN7kDRAZlAGcGARbP/A78H1sV+yb7N0fy/Iz8nfwcroQTU2
OC5kQMvR/1pPzZ/Or8+/0M/R1tLLPxFfSpJnYeJGolH1wEJtMCFn06HwQTgzc3kVcJSQLgRtaCGk
IkNfQlIRyvBHRV/K8FNFTCBfQUREUm1QSVT+Ii+zZmEGEvPw9cD45gxDzyTzL8Io0Z9gaV8W8JYA
/CggfVAvwnAHalJw8h3Ap20/bk8GITI0sPBB+sH/asScIO+nDFJxLPXDXEP+MP/kQHGSlGCHwCIA
IBAF0kKE//qyo8BdSHln4GQDgNQwCLA/2+B4hGxESQIYAfgBIk6v5DEtAp1m2zByWpEisPD/MYDi
8oMR6GEXAdQQ8WGdZP/sMsxwQ8H54Buh4KAxgPzT98ORh4Ky9jaAEUjy2CESAP8wAJXklVCHcX+h
gfc7UnrEf8xwFEDCssWABnJEESZgLfF14DAuMvXAMYEs0eWA7xVxnGOCFIARJ/ngK4CDen409cLy
gENAE5X4AZzQbP8c8O6TlMD3EP4xEzMN8T7RhwFR07OKpFVBUlSnwf9lYDtDMYCUoHKx+xDcNOGj
39aA5/GNko9T8/A1y9Bx9L+jEKLg6MOudX+k+fFuA4D/MaDuZefkfmKnEYyx2ROPWP/Dgm62kyX8
4WgAWrHTouIg/xIAkF2PWC/CG6BwtWYgJzGf7rKCo/jgL3DrNEJT3OBf1YCMAeflG9LeQi+osHbi
L0YQeVVMXcCe4atg+xHSd3RtJjDMcCzRA4D98b9sRdOhQoEHcdgR/tAiSfD72zAl0HL9EeZRbrA9
M8rQ/9gDk9/mdG+m+AHYAo2SjLH/EcGggf0RrAWKBAuQJjD7EL5nysAFU+lQPwJKkSFRb+9ScLP1
qh/RxVgvcBbwszDnXYQssA8xLVMDRQdRe+r/X1Cv77D/sSAkNbKfs6+0v3e1z7GPw3BicYNfUJ7h
IHo9toA5I2GGsLjQKRAy/V2hNK7Qug+7H7bft+BxYf5zKQCvwfjg3kDekJ+GviL5olEwM8wA3oBM
gb/PwN8XvJ+9r76xMbkTNTQ18jHegGI5wU/GL8Hvwv/vvqKIsaJRV5AzXaHFD8tv18cvyD++hDPE
VjfKT9Cvl8xvzX++ZjfJtDIyYoD9V2A20W/WT9IP0x++orkE/7mP2y/W79f/vinUwLkTz5HfxN/g
v9x/3Y/elzXEVNpA/8+f5h/h30XgBXC4JfFAn7P/YhC4wcoQ5GNcED/w6FEo4Pm40GYzPvDrD+wf
59+PkDhQVDGHoSdBuNAweMm/QDc4I2FycemC6v+38Q/sz+h2QxLw7otm72dfdeH1f/aP8k/zVzLu
mTIf9Ljq7/u/93/oZ0tCQ/PvhcRBUFP5QP61+s8A/5/8v+hJWbCjUQdQL097vv8XEAvyZWD//wbv
sg8JDwof/wsvDD8H+C1DhrFb4QyCv2AHWEEPEQ7SRTkxRjT/DI8Q/wy/K/KuEk2kDmIPcvg2MTP+
kBRExKAR7xZffxIfKDMjwTczJuCv0Q7iNv40XbEZpFfxGr8bzxePNhCOei9QYdEOWzZCRuVQew9y
knA21T8hDxzPNfN2n00gTECU4FkBDqVFQQ8z/9UADxQlfyaPIk8Ifym/Ks/PK98nnyihXfMvUFxQ
OAEvNjBfUJRxliI9nyQsOeI2D0FpcD1K0ErgoLLaPZ7TeGxBPDBlntCegKxjMGWgp+B0+UByeUD9
KDhVgPEFgDZig3eOYYUA/zkABe82PzdPKEd+r6SkKEffOp9Sf1OPVJ/UsDFVz1bqPDI6YmBX4OVQ
WC8iSM51fhFrM26wPGJKcH4Rv2MwgSCIQFrfW+GeUT9cX/tdb15+PF9/YIlkFWGZaDUNTdBiWdAU
gEIwRUVcN0N10E0QFJA0YoA4JQ/ANk2AMTROMDhGB01gH2BXQEYyNUBF0FhFVlMZ0C6RQGDgR0Qt
ZI9lnyJnYtpBMvoiaDpBajGn4HMSkDBjgN85AIuQlnBrEEcAVp6AE9H/ZjCbsQV1XEty4kcTgBJm
MP+nMRLmv6CgYZSwlOJ25O+Q+VxEdHUwsXWiXqCkhnLi74EBBZGWYDDAbVDhbMGZQfuQMZSwaJHg
4oWBIGBQZlD/TGCd8ZtDapGFcJ5RqNAwsHeBVI4jOotJMMBqk32baveKoJHghtQirT+uSeKFrv3+
IniDcTGCEUpgVXGeJ5lA94BwgbF24XenoGjyhUJh4/BPUEItReLihYEAnlEvlnHqQEZwUcAt+UBG
UPxHQVgzXbFVcYBQBWGAcP+d8V9yhQBFIJZBm9BFUIfh/50hI4CM0FyT4oVzj3SYhUFzoFFh6S5t
XSGhAmDcV++cUomSR+WkhnSBYH0Qh/L/eWiXMK6QlGGAULkRhHJ18/OFAZfhZi1qp5SalKBesd+A
EVsBnSFpJJmAZDPynnM9NBFnpMCTc+Ly81IoKf9m9eKFpFurUJGkoyG+oJhC96ihXOBgvkieRV8n
pMAZI++MUKLC40BrMmZFgGD6XAL/cB9xJLjBTTCLkIqgoDDimMt89GD1eyh4Lyp4VJR8BCovKHhX
UjMyKIVF4V/zsE5GSUdw83+GkF3QljGLUe8QJQIPATTkKSlSUC8vezaKn4un8ERBVEGMejCwMLC/
cP9NQI21E7KIe5lwR8BSEFEBXmNn0R4gY4GWcWJgQGTvHlGKf4uPjJ9jjb+VT4/f94zjDxKRUTCR
v5LJvfJHoO9JsVwglP+WDSv6IZCaJRR7mDFg9X2iJoRPhV/UsDb/hp+Hr4i/ic+fD5ZvjPaNQv+Y
P6m/ml+Q75x/kw+UH62f/6qvq7yYL7Qvrr+bX7DfnX/fno+036Cvob9g+llfgR4w92zwbmRjxCdW
MKWhXCB5cP/Z8HShGfBb84BCyRFMYHMgG0/AOotQRmE0MkJTUANzAEJxIEVESzku3+6AWyFVpXTB
VxBofvNJwPwgccRAVrF6MCPQXbJcAf53E3GlgM4QXedGUjl1YoBfWyVrlHuzLsB3kHRcgWJ/d5Ej
gHlwNSFhtF+jdbB57zlzeEClokvARQK3X4B0gP+zdKWAXYB+5G0cVdFXcseC/0ghyABHUHmRaAF0
cV7gzMovWMfjQKWie2BpWJByL1fEUTJQdwAvBMFtFSB4//qw2pBWElkzA+ATsQ4yLsH/YzFe8WqH
XzHPgXhBwsHU8fdjMX8xfqAtMgIY0FcgaCH/S4B7cGJwURGzMtfWshGDEP97oWMwsuIvI70wNDJ9
xtAhz16IVyEEBbNBbWxYBM8E72MDgnNF4rziZkQhebJ9VS9mUGAgb6RpgGwjsG11+1JwxQRld9B1
0FwgyyLTJH/lkoJzyYGDRXswE1DLMW/4cGItdvZnUG/AI+BWob9esGD6Q0E6/+w/O/VPYED+Z3yA
BMBHAEtVPbhCZEkfri3o0U/we4ArQ6U9RCb7SilFwD/wH2TQe3DJsHuAnnRKKUS1URFFgDgvdOHl
QOIo84A/KXSwQTBB5j9IwvO/9U9FF0eD+OogRNd5YPURpYBWL3AgQVDR4ftLYG8xNSh19fd/4PtP
shHfY9JAsGZQYyFXIGJdoDQR/y9BGUFL+fif+a9IZgDSMiD/YEDoEaORRCAFKNWAyLB0ghZXSqB/
EVfEUldlYjelgNWANCB0S/ld0HRwbHM6t2BKOC8AEh4wbv4vAJJ8gFwACtECnW+kSqD/CBLIsGJw
I5GlgHhgXvHIsH9tYEtjaXQA4UVCBbITUGTFbPAnaABscCcBn/Pv//T/wc2DQHnge3AxwGmwdIL/
4UEvYFlhXuBLgDl2AJNfQO8Qr/CKOQB+oHIS73PZe3D/UgDPwqWAXHF30OZRMgBfU/9cIEUVF8Jf
0XYhYzB7wcUTznNlBX3W1REiUj/xUNX/VjBvYf7/beD8czTBU2tIZu27kHnDsUjAcGVQCXBg+n03
gTFYMEXvRv9IBEdgSn9/AGYw7mAcoUhVN4HI0CDfH6MU0TljyLB64GEl8IKR/HpJDXBLkE+QZgFk
wEGg+3igFJEnAMHTc3SBu9g3gJ/KITPQL3AdQfOQKEfqEP/dYUeAgxBVcCjY2EApk1/yP3vALsIe
YBTwaDBcAlUt+2SQf1AsTFNHhF7i1RErhQve8A6CPy0aKDRNQnMcoHEgQU0oAQcweIBn92Kx/FBt
cGum1jtvOA85H+86Lz0vPj8/W03kUqyAQIn2NvfAQWAz3jBBvyg4TJDkanM/EDRAvOBukH6h/mxE
b0VxJZ8mr0gOF98ZT2dLSUyQTlA5N0ywTWAu9awgMz8QME8AQg9Qv1HPAVLQSVNPLTg4NXg5LTFS
UFwBDXBS0Gbt3IB3DGaBBWkyEGEKezD/zIHPt7OwYzBDz0TVWDLKwH970W4iWyFXU0Vkb6RbUij3
RuNr8EYQLdWFx3P2UAVg/VJxTDJA94BMIYLRRMEPwPfK1/JAXAF08kDZQWfBfdf/aCR/QFKbfIF+
OGxgdDNcAN9tcFSi41RS5dHiZ39Rfdj/PQDfAX6AZ3DqcEVAeGDOIf9+sE+A94Dbg0+QaCEbAURB
j/wxRIVX6AeBa2kuNp/5p7FDQzSEb8BNsNeAR0AWL3JhdqBiZnI0eHh+X03x4TBIYG+kZj9nSmPN
MFBJeeHkBSBgZzUNcHJwfOBvJyRlaH9pjDHOMT+AYJQwUGBQUqBnYuG08klPX1a/UhBgN1Tv4HLc
cINRf+AoegOlk1yjP3vB4/ZGNWyfba9utyhF/xTycQnEUUxgHqG9YTdUe8H/Ynlakakwf7Bzf3SP
bl3E0r8U42qnHbEqsk3RMzEuc2/bev9uRDluv2/FUHBPcV8fcm9/H4AvgT9va1NJWv5Fg2+Ef4WP
hp+Hrz7wiN/9tPNGtYBwP4tfjG82i43v/Y7+MZAPkRaDH5Kvk7+Nf/+WP5dPkK2KX5pvm3+cj52f
74+j97CfH7UBTJFfoV+ib/ejf6SPj1gzpk+nV5lPqP//qg+rH6wvrT+m7qCfsG+xf6M3VN5SWzFd
MFAqusDsIFuy72dLXcewYLI9Vu/eUrqvu7O89jJkf1FhT5B93WFiFPDDMMyhRWdFQHatyNEuPvBr
oHbiAS3h8f33ACnLBGATu7DZUMyA1QH+Z+PQN1RLgNbwFkHh82vgeSuRKCDEAR5m19BakXf/GsId
sVJhAYIVYNegxqhcoe+51eID8nBUMXDm8RWg3wH+cMYBLGPE4SAjXKHKdVTi///QxDAqUdLxTvDg
ceGw5vF/Hudcgch1GmA88ESjuCR0/ncFAB0yzKPJGegBTvFc8P/FIioxVCDq9eaBx7MNAMfB/19C
UnHhwttgBVHY0rkQJGt9N1RYADLCYET0MdBZUS2+Ux51amEdsEEQRuB6KhGfawDWP8pV0gdhgG9r
49CfRuAvILjj2g/FwHZvB6Cb2t82hnstGMuzcygiUEZc63DhQCIpO+AfIv/Xb9h/2Yjhf+DX5cck
fckI6eXbcGLGpDnl29Hh1aCfNgDpWwFB6Q9S0GJy7Qz8XH3nb7LB/sHR2twf73/n3jjo2N+fIC++
YA3QNdDsLWNrALggZ8Xw2bO+MIIvLRhXUjMyKJET8E9ORkmvIK9SDQAJMOX88GX4QTB4SmA/AD/x
7DQp5dD18C/UkEewY6CHPPD3j/iXREFUQflqwzCQMJAwMTQ3+qUjoL8yMPVrDXDCYE1QTEFjx/D/
CxDMYAXQawHuMAegM+H3b/v4f/mPY/qvAj/8z/nT+jF+MP5Bw/D+v//IxDBbkXXPR4EckAHvAv0r
OP1sCKL/CQPu39qdzUFUYjPgGRFaYT+38MgTXAC94BiwRKNCUwZQXJLi5UVESyA5/i4lYVwA9oAk
IF5ReEVfIffUoGsAPtB3HbB9cESyMfD/WzHQkRuwuSFXohL1ycJYxf9dFB1xxfAxQFQisoVRoLiA
+yo0KeBvPPAIEPmgTaAbIpf2cS4AFzFyxyBnY0dQ9zAAwwDDkGe70UdQwuAwAPcwAVwAz1B2XPDU
oMtgztb/xgBeUUSyRufCgjLSw1C5EIMyMEcxXzJfNF9HwP8eYNTAXRQXZTdUGWUg9M1A/0CgxBYb
MFkSFlFYANQARMD3EhEWQtQQbeLwN3A00DLS903wHmAt4GzScDdUYKX2gS8xQF0wKjJ3kS0yMHNr
vxcizUHF5RwU9wNka0lUgdRueVkwZMfwYVRgYkH8b2bFEE+AweK94EWAx8P/a7FEo1Ki9oHMEcyF
VjIy0t83VBYwS0BR9UTAbC5wYHHpLlVtPzYwb9FxLEYeRP9+AUfAQUDIEMfw0dp4R1Jh3/cQUgHM
EErxMnBBLFBS0W5nSVDMELJBc8nDEZRs/8cg0RBA8LfwR5BSUGOgTzC/WpF+UWOg0eAR4mRrTGOx
/2BxQjAtYceAVDFdQB9yVQH3V6BXIBLBbdLCXKBO9Gryb30R9oBHwFQgVNMB8bAh8Q+/Ci1KOKA5
8F4QPz/vP4xCv0OK1qpfRV9Gb0c6/zq1H/bMUNKQBaBeUb3g4vIfGtATwMwQSE9JVEBveslNUGJz
Z/ByZ1XUBADcdHDyYAVgTAgvScItwb4vSkI9ck6hSM3WqkXOcr874ErvMoD2wDcxxyBWG4HeNA2h
LBBewFzwN1XUvkEvVJ9Vr1Zp1qp9WEAAAB4ANRABAAAAPgAAADw2MUIwRUU3QzI0N0MxMzQ5ODgx
RjYzNDE0NDQ4RkMxRjkyMEYyN0BFWEVWUzA2Lml0cy51bmNjLmVkdT4AAAAeADkQAQAAADkAAAA8
bWFpbG1hbi4zLjEyMTc5ODgwMDMuMzEyMS5saW51eHBwYy1lbWJlZGRlZEBvemxhYnMub3JnPgAA
AAAeAEcQAQAAAA8AAABtZXNzYWdlL3JmYzgyMgAACwDyEAEAAAAfAPMQAQAAAIwAAABSAGUAJQAz
AEEAIABSAGUAJQAzAEEAIABQAEMASQAgAHMAdQBwAHAAbwByAHQAIABvAG4AIAB0AGgAZQAgAE0A
TAAzADEAMAAgACgATABpAG4AdQB4ACAAMgAuADQA//gyAC4ANgApACAAKABKAHUAbABpAGEAbgBh
ACAAUwB1ACkALgBFAE0ATAAAAAsA9hAAAAAAQAAHMN9DjGGx+cgBQAAIMOP4HPyx+cgBAwDeP6gD
AAADAPE/BAgAAB4A+D8BAAAACwAAAEh1YW5nLCBCaW4AAAIB+T8BAAAAWQAAAAAAAADcp0DIwEIQ
GrS5CAArL+GCAQAAAAAAAAAvTz1VTkMgQ0hBUkxPVFRFL09VPVVOQ0NIQVJMT1RURS1OVC9DTj1S
RUNJUElFTlRTL0NOPUJIVUFORzIAAAAAHgD6PwEAAAAVAAAAU3lzdGVtIEFkbWluaXN0cmF0b3IA
AAAAAgH7PwEAAAAeAAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAAAC4AAAADAP0/5AQAAAMA
GUAAAAAAAwAaQAAAAAADAB1AAAAAAAMAHkAAAAAAHgAwQAEAAAAIAAAAQkhVQU5HMgAeADFAAQAA
AAgAAABCSFVBTkcyAB4AMkABAAAANgAAAGxpbnV4cHBjLWVtYmVkZGVkLWJvdW5jZXMrYmh1YW5n
Mj11bmNjLmVkdUBvemxhYnMub3JnAAAAHgAzQAEAAAAlAAAAbGludXhwcGMtZW1iZWRkZWQtcmVx
dWVzdEBvemxhYnMub3JnAAAAAB4AOEABAAAACAAAAEJIVUFORzIAHgA5QAEAAAACAAAALgAAAAMA
dkD/////CwApAAAAAAALACMAAAAAAAMABhDd0MDhAwAHEOcrAAADABAQAAAAAAMAERAAAAAAHgAI
EAEAAABlAAAAVEhFUkVBUkVBTE9UT0ZQSVRGQUxMU1RIQVRNSUdIVEdJVkVZT1VTVUNIS0VSTkVM
UEFOSUNBTkRJQU1TVVJFSURJRE5PVEhBVkVBQ0hBTkNFVE9FWFBFUklFTkNFVEhFTUFMTAAAAAAC
AX8AAQAAAD4AAAA8NjFCMEVFN0MyNDdDMTM0OTg4MUY2MzQxNDQ0OEZDMUY5MjBGMjdARVhFVlMw
Ni5pdHMudW5jYy5lZHU+AAAAOug=

------_=_NextPart_001_01C8F9B1.FC15D1CC--
