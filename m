Return-Path: <ami@waves.com>
Received: from dcmail1.waves.com (dcmail1.waves.com [12.34.136.6])
	by ozlabs.org (Postfix) with SMTP id 7EAFDDDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 19:51:57 +1100 (EST)
From: "Ami Levi Waves" <ami@waves.com>
To: "'Charles Krinke'" <ckrinke@istor.com>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: understanding an IO question
Date: Wed, 21 Feb 2007 09:50:57 +0100
Message-ID: <003a01c75595$818084c0$0600000a@waves.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A164@MERCURY.inside.istor.com>
Reply-To: ami@waves.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The way we do it:

Fisrt open a memory device:

	Handle =3D open("/dev/mem", O_RDWR);

Than map the address using:

	mmap(NULL, nAdress, PORT_READ | PROT_WRITE, MAP_SHARED, Handle, your
base address);

mmap returns a virtual pointer, pointing to your HW.

Ami

> -----Original Message-----
> From: linuxppc-embedded-bounces+ami=3Dwaves.com@ozlabs.org =
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
> 0xc905_8000. Unfortunately, I cannot seem to access my registers as =
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
> to look next for the missing piece of why I cannot access the =
registers
> on our ASIC from Linux whereas things were working fine from uboot
> before booting Linux.
>=20
> Charles
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
