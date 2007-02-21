Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0DEEBDDD0A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 01:14:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: understanding an IO question
Date: Wed, 21 Feb 2007 06:14:43 -0800
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A165@MERCURY.inside.istor.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: <ami@waves.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I apologize for not making myself clearer. This is a kernel driver
issue, not a user space issue. The issue is addressing the registers in
a PCI device in its driver.

We have a functioning code base that works with Linux 2.6.17.11 on our
8241 platform. We have built a new board using the 8541. Although the
registers are addressable from uboot and can be read/written, once Linux
boots, the registers cannot be addressed.

I suspect this to be in either TLB1 setup or Outbound Address
Translation windows.

So,... my questions really are=20

1. "Where are the TLB's setup in the 85xx chip during Linux
initialization for devices that may be using PCI memory in the
0x8000_0000 - 0x9fff_ffff address space region?". I can see that some
reset of TLB's occurs in head_fsl_booke.S and perhaps that is part of
the answer. The other part may be in where TLB's are then setup again
after they are reset in Linux.

2. "Are Outbound Address Translation windows reset by the arch/ppc/...
Linux initialization and if so, where. If they are reset, where is the
best place to put them back to the state I had set them up in uboot.

Charles



-----Original Message-----
From: Ami Levi Waves [mailto:ami@waves.com]=20
Sent: Wednesday, February 21, 2007 12:51 AM
To: Charles Krinke; linuxppc-embedded@ozlabs.org
Subject: RE: understanding an IO question

The way we do it:

Fisrt open a memory device:

	Handle =3D open("/dev/mem", O_RDWR);

Than map the address using:

	mmap(NULL, nAdress, PORT_READ | PROT_WRITE, MAP_SHARED, Handle,
your
base address);

mmap returns a virtual pointer, pointing to your HW.

Ami

> -----Original Message-----
> From: linuxppc-embedded-bounces+ami=3Dwaves.com@ozlabs.org
[mailto:linuxppc-
> embedded-bounces+ami=3Dwaves.com@ozlabs.org] On Behalf Of Charles =
Krinke
> Sent: Wednesday, February 21, 2007 2:14 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: understanding an IO question
>=20
> I have a board using an 8541 which is based on the mpc85xx_cds bsp. It
> has one PCI device connected to the 8541, an ASIC we make that maps in
> resources for its registers at 0x8400_0000 - 0x8400_0038.
>=20
> The driver for our ASIC works in an 8241 design and I am trying to get
> its register access working in the 8541 and need a little additional
> understanding.
>=20
> I can see in cat /proc/iomem where we have memory apparently allocated
> for our registers, like this.
>=20
> cat /proc/iomem
> 80000000-9fffffff : PCI1 host bridge
>   84000000-84000038 : ichar
>   88000000-8fffffff : ichar
> e0003000-e00030ff : fsl-i2c.1
> e0004500-e0004507 : serial
>=20
> In our driver, I do an ioremap_nocache with 0x8400_0000 as an argument
> to the ioremap and am returned a virtual address of the form
> 0xc905_8000. Unfortunately, I cannot seem to access my registers as
they
> all return zero when accessed with the iowrite32/ioread32 helper
> functions.
>=20
> A little further. We do use the Outbound Address Translation window
> feature in the 8541 to get to our PCI device and I do set this up in
> uboot and I can read and write registers on our ASIC from uboot. Its
> just in the Linux driver that I seem to be having trouble.
>=20
> So,... I am hoping someone could give me a couple of pointers on where
> to look next for the missing piece of why I cannot access the
registers
> on our ASIC from Linux whereas things were working fine from uboot
> before booting Linux.
>=20
> Charles
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
