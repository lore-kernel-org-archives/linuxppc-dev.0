Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id C91FDDDEC9
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 09:47:29 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Update on: MPC85xx git/MPC8548cds - PCI/PCIE problemS with Marvel
	SATA driver...
Date: Fri, 23 Feb 2007 17:47:22 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D901053E84AA@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D9010685DAA6@EMPBEDEX.empirix.com>
	<BE415006-0D71-4D2F-8699-3BD2A513D9C0@freescale.com>
	<BD261180E6D35F4D9D32F3E44FD3D9010685DCFC@EMPBEDEX.empirix.com>
	<8B9F6546-0D85-4AD0-A196-25F0F9C1A5A0@freescale.com>
	<BD261180E6D35F4D9D32F3E44FD3D901069D9CA4@EMPBEDEX.empirix.com>
	<20070223202921.GA22331@lixom.net>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "Olof Johansson" <olof@lixom.net>
Cc: Geary Sean-R60898 <sean.geary@freescale.com>, linuxppc-dev@ozlabs.org,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof,

Are you saying that it must 'know' about the PCI id(s)
for this SATA card before it even probes that device???

Even though the module is compiled into the kernel and=20
I've verified that:

  a) the pci scan bus has detected this device
  b) that the sata_mv driver is registering itself
     as a PCI Device driver?

????

Also, fyi, its also complaining about the PCI Express=20
Root Bridge on the MPC8548 as an unknown device...

   manufacturer: 0x1957 (aka: Freescale)
   class: 0xFFFF

although that doesn't explain why the same PCI=20
Express SATA card / ~same sata_mv driver on an=20
Intel X86 platform doesn't get recognized either.

Thank you for any additional insight you have on this Olof!

Tom

-----Original Message-----
From: Olof Johansson [mailto:olof@lixom.net]
Sent: Fri 2/23/2007 3:29 PM
To: Morrison, Tom
Cc: Andy Fleming; Geary Sean-R60898; linuxppc-dev@ozlabs.org; Zhang =
Wei-r63237
Subject: Re: Update on: MPC85xx git/MPC8548cds - PCI/PCIE problemS with =
Marvel SATA driver...
=20
On Fri, Feb 23, 2007 at 02:57:38PM -0500, Morrison, Tom wrote:

> PCI Express/7042 Marvell Sata Card:
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    On PCI Express Bus - it never performs the probe - even though
>    the bus was scanned and device was found ("lspci" shows this =
device)
>=20
>    FYI, I tried the PCI Express SATA Card in an X86 running Fedora
>    Core 6 (2.6.19.1-2xxx) and this seemingly is the same behavior
>    on this platform?

A patch went into 2.6.20 quite late to add the PCI ids for at least
one 7042 controller (Highpoint). You might have to add the ids of your
controller as well.


-Olof
