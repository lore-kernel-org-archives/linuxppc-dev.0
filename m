Return-Path: <js084@bucknell.edu>
Received: from ivory.bucknell.edu (ivory.bucknell.edu [134.82.9.79])
	by ozlabs.org (Postfix) with ESMTP id C062DDDF9B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Aug 2008 05:09:32 +1000 (EST)
Received: from [134.82.224.137] (wifi224-137.bucknell.edu [134.82.224.137])
	(authenticated bits=0)
	by ivory.bucknell.edu (8.14.2/8.14.2) with ESMTP id m75J9SCa000649
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Tue, 5 Aug 2008 15:09:29 -0400
Message-ID: <4898A568.10502@bucknell.edu>
Date: Tue, 05 Aug 2008 15:09:28 -0400
From: Juliana Su <js084@bucknell.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: PCI support on the ML310 (Linux 2.4/2.6)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Thanks for your reply, Bin! I checked system.mhs and "C_BRIDGE_IDSEL_ADDR=
_BIT" was set to 16, but the code that was in pci_init( ) was the code fo=
r as if "C_BRIDGE_IDSEL_ADDR_BIT" was set to 24. After replacing the code=
 in pci_init( ), the PCI now initializes. However, after the ML310 initia=
lization finishes, the system hangs at "Now booting the kernel". I rememb=
er encountering this problem when I was porting Linux 2.6. It had to do w=
ith a linker problem and after rolling back to gcc-4.0.2, I got past the =
problem. I'm using Linux 2.4, though, so that solution will not work here=
=2E.. I am using UART Lite and I made sure that it (and not UART 16550) w=
as selected in the kernel configuration and that "Console on UART Lite po=
rt" was selected as well. I also made sure that UART Lite was what was ch=
osen when I built the BSP. Oh, and there is a /dev/ttyUL0 device node in =
my root file system. I even did a "make mrproper" and re-did the kernel c=
onfiguration, but that did not solve my problem. Any suggestions? Thanks!=



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
Linux/PPC load: console=3DttyUL0,9600 ip=3Doff root=3D/dev/xsysace/disc0/=
part2 rw    =20
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
been migrating their PCI stuff to 2.6 kernel for couple of months so I mi=
ght =20
understand what you are suffering here.=20

If your system hangs just after "Xilinx ML310 Board-Specific =20
Initialization:", then probably there is something wrong with your OPB-PC=
I =20
core on virtex-2 FPGA. I highly recommend you double check the value of  =

"C_BRIDGE_IDSEL_ADDR_BIT" within your system.mhs file.=20

When the 2.4/2.6 kernel tries to initialize pci core, it has to do self- =

configuration first. If the wrong address is assigned in pci_init(), then=
 =20
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

Porting BSP from EDK9.1 to MVista 2.4 should be quite straightforward, bu=
t =20
porting them to 2.6 virtex is a little bit vague. If you are trying to us=
e IDE =20
southbridge, I could recommend you start from 2.6.10 rather than 2.6 virt=
ex =20
because driver/ide/pci/alim15x3.c has been updated a lot and I =20
hate to say that a none-disclosure agreement on alim15x3 makes it time co=
nsuming =20
to understand super I/O on ml310. If you just need PCI bus function, then=
 life
will much more easier but you still need be care of about opb-pci core pa=
rameters

Bin





-----Original Message-----
From: linuxppc-embedded-bounces+bhuang2=3Duncc.edu@ozlabs.org ?? linuxppc=
-embedded-request@ozlabs.org
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
arch/ppc/syslib/ppc4xx_setup.c:118: error: for each function it appears i=
n.)
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
is getting stuck? Any suggestions, in general, would be greatly appreciat=
ed.

Let me know if I need to provide more information or code. Thanks!


-Juliana
