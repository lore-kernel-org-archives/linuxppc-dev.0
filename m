Return-Path: <kmilligan@austin.polycom.com>
Received: from ausexch00.austin.polycom.com (unknown [216.54.148.81])
	by ozlabs.org (Postfix) with ESMTP id 7D80D2BDB5
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Nov 2004 03:15:30 +1100 (EST)
Message-ID: <F3CF3D25A7F8F44BB59BC7A2CA83E30B02322253@ausexch00.austin.polycom.com>
From: "Milligan, Keath" <kmilligan@austin.polycom.com>
To: linuxppc-dev@ozlabs.org
Date: Mon, 22 Nov 2004 10:15:23 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Large PCI region mapping 8272
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Well, I've confirmed that I have the right platform files and I've =
enabled
debugging in most of the related files.

At this point, I am specifically concerned about code in
arch/ppc/kernel/mpc10x_common.c and m8260_setup.c.

In mpc10x_common.c there is a setup switch statement that has the =
following
case for the 8272ADS:

#if defined CONFIG_MPC8272ADS || defined CONFIG_ADS8266
		case MPC10X_MEM_MAP_826x:
			pci_init_resource(&hose->io_resource,
#if 0 /* zhx */
					0xe0000000,
					0xeeffffff,
#else
					0xa0000000,
					0xafffffff,
#endif
					IORESOURCE_IO,
					"PCI host bridge");

			pci_init_resource (&hose->mem_resources[0],
					0x80000000,
					0x9fffffff,
					IORESOURCE_MEM,
					"PCI host bridge");
			break;

This seems to be limiting resources to a0000000-afffffff and
80000000-9fffffff. Does anyone know where these hard-coded values come =
from?

Also in m8260_setup.c, more hard-coded ranges appear in m8260_map_io().

These would seem to suggest the 8272ADS is pretty limited on the amount =
of
PCI-mapped memory that it can handle.


-----Original Message-----
From: Marc Leeman [mailto:marc.leeman@gmail.com]=20
Sent: Friday, November 19, 2004 4:34 AM
To: Milligan, Keath
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Large PCI region mapping 8272

> Could someone point me in the right direction to getting everything
> initialized and mapped correctly?

I had the same impression (that the PCI initialisation) was not quite
right. After some investigation, it was me that used a wrong platform
file (overzealous deleting and copying to minimise custom code).

>From what I understand (after a brief look in the files), most of the
changes can be localised in that file.

You can enable debugging in  (IIRC) -#define DEBUG-
arch/ppc/kernel/pci.c
to have a more verbose look at what is happening.

The same goes for quircks.c and pci.c (in drivers/ somewhere).

In any case, the pci mapping calls your platform dependent fixes.=20

--=20
ash nazg durbatul=FBk, ash nazg gimbatul,
ash nazg thrakatul=FBk agh burzum-ishi krimpatul
