Return-Path: <rdcorle@yahoo.com>
Received: from web56315.mail.re3.yahoo.com (web56315.mail.re3.yahoo.com
	[216.252.110.239]) by ozlabs.org (Postfix) with SMTP id A3FB867BB4
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Nov 2006 07:33:15 +1100 (EST)
Message-ID: <20061101203314.2385.qmail@web56315.mail.re3.yahoo.com>
Date: Wed, 1 Nov 2006 12:33:14 -0800 (PST)
From: robert corley <rdcorle@yahoo.com>
Subject: RE: plb_temac w/linux 2.6.18.1 driver init error
To: David Bolcsfoldi <dbolcsfoldi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Cc: linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Anyone?;=0A=0AThe offending instruction is:=0A=0Aout_be32((volatile unsigne=
d *) InstancePtr->RegBaseAddress+XPF_V200A_RESET_REG_OFFSET, XPF_V200A_RESE=
T_FIFO_MASK);=0A=0Acalled vai a #define in "drivers/xilinx_edk/xpacket_fifo=
_v2_00_a.c"=0A=0AWould anyone care to speculate if the error is in the out_=
be32 definition or is this a function of a memory access to an incorrect va=
lue?=0A=0AHere is the latest dump:=0A=0A[    2.702189] xtenet_probe: xtemac=
 0: IO resources obtained.  IRQ =3D 0, MEM =3D 0x60000000=0A[    2.710095] =
xtenet_probe: xtemac 0: private data initialized=0A[    2.715872]     remap=
 info =3D> start =3D 0x60000000, end=3D0x60003fff, total=3D16384, virtual d=
est.=3D0xc5050000=0A[    2.725007] xtenet_probe: TEMAC config lookup succee=
ded.  Details =3D =0A[    2.731369]         Base address    =3D 0x60000000=
=0A[    2.735471]         Unique ID       =3D 0x0000=0A[    2.739230]      =
   RCV FIFO depth  =3D 0x131072=0A[    2.743161]         XMIT FIFO depth =
=3D 0x131072=0A[    2.747091]         MAC FIFO depth  =3D 0x64=0A[    2.750=
677]         IPIF/DMA config =3D 0x03=0A[    2.754260]         DCR Host    =
    =3D 0x0=0A[    2.757759]         DRE Engine?     =3D 0x1=0A[    2.76126=
0] Initialize : Handlers set up.  Configuring FIFO access...=0A[    2.76770=
9] XPacketFifoV200a_Initialize : setting FIFO REG base address to 0xC505201=
0=0A[    2.775548] XPacketFifoV200a_Initialize : setting FIFO DATA base add=
ress to 0xC5052200=0A[    2.783474] XPacketFifoV200a_Initialize : setting I=
sReady to 286331153=0A[    2.790011] XPacketFifoV200a_Initialize : resettin=
g FIFO by writing 0x000A to 0xC5052010=0A[    2.798103] Data machine check =
in kernel mode.=0A[    2.802544] Oops: machine check, sig: 7 [#1]=0A=0A-cy=
=0A=0A=0A=0A=0A
