Return-Path: <rick.moleres@xilinx.com>
Received: from outbound1-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4C0D667D20
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Nov 2006 08:07:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: plb_temac w/linux 2.6.18.1 driver init error
Date: Wed, 1 Nov 2006 13:45:38 -0700
Message-ID: <689CB232690D8D4E97DA6C76DA098E6C033750C1@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Rick Moleres" <rick.moleres@xilinx.com>
To: "robert corley" <rdcorle@yahoo.com>,
	"David Bolcsfoldi" <dbolcsfoldi@gmail.com>
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


Robert,

I haven't seen this before, but perhaps the plb_temac hardware is built
for DMA but xparameters.h is out of sync and thinks it's built with FIFO
mode?  This would probably cause a machine check if trying to write a
FIFO register but it doesn't exist.  You can crosscheck xparameters.h
with your hardware design to verify.

-Rick

-----Original Message-----
From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On
Behalf Of robert corley
Sent: Wednesday, November 01, 2006 1:33 PM
To: David Bolcsfoldi
Cc: linux linuxppc-embedded
Subject: RE: plb_temac w/linux 2.6.18.1 driver init error

Anyone?;

The offending instruction is:

out_be32((volatile unsigned *)
InstancePtr->RegBaseAddress+XPF_V200A_RESET_REG_OFFSET,
XPF_V200A_RESET_FIFO_MASK);

called vai a #define in "drivers/xilinx_edk/xpacket_fifo_v2_00_a.c"

Would anyone care to speculate if the error is in the out_be32
definition or is this a function of a memory access to an incorrect
value?

Here is the latest dump:

[    2.702189] xtenet_probe: xtemac 0: IO resources obtained.  IRQ =3D =
0,
MEM =3D 0x60000000
[    2.710095] xtenet_probe: xtemac 0: private data initialized
[    2.715872]     remap info =3D> start =3D 0x60000000, =
end=3D0x60003fff,
total=3D16384, virtual dest.=3D0xc5050000
[    2.725007] xtenet_probe: TEMAC config lookup succeeded.  Details =3D =

[    2.731369]         Base address    =3D 0x60000000
[    2.735471]         Unique ID       =3D 0x0000
[    2.739230]         RCV FIFO depth  =3D 0x131072
[    2.743161]         XMIT FIFO depth =3D 0x131072
[    2.747091]         MAC FIFO depth  =3D 0x64
[    2.750677]         IPIF/DMA config =3D 0x03
[    2.754260]         DCR Host        =3D 0x0
[    2.757759]         DRE Engine?     =3D 0x1
[    2.761260] Initialize : Handlers set up.  Configuring FIFO access...
[    2.767709] XPacketFifoV200a_Initialize : setting FIFO REG base
address to 0xC5052010
[    2.775548] XPacketFifoV200a_Initialize : setting FIFO DATA base
address to 0xC5052200
[    2.783474] XPacketFifoV200a_Initialize : setting IsReady to
286331153
[    2.790011] XPacketFifoV200a_Initialize : resetting FIFO by writing
0x000A to 0xC5052010
[    2.798103] Data machine check in kernel mode.
[    2.802544] Oops: machine check, sig: 7 [#1]

-cy





_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
