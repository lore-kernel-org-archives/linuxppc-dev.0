Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from tag-03.ashton-group.com (tag-03.ashton-group.com [66.94.86.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0ACA467B1F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 01:06:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 3 Jun 2005 11:06:27 -0400
Message-ID: <1628E43D99629C46988BE46087A3FBB928523A@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: <scarayol@assystembrime.com>,
	<wd@denx.de>
Cc: ctrichet@assystembrime.com, linuxppc-embedded@ozlabs.org
Subject: =?iso-8859-1?q?RE=3A_R=E9f=2E_=3A_Re=3A_starting_RAM_adress_for_?=
	=?iso-8859-1?q?linux_kernel?=
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>=20
> we need to have the start of Ram at 0x0300 0000 because we=20
> use the command mem=3D40M (for uboot) to force Linux in the low=20
> part of memory and to reserve the high part of memory (218M=20
> exactly ) for ioremap (for our application) but we keep the=20
> same flash mapping (to avoid more problems).
> So how can we do that ? The boot seems OK but there is some=20
> problems in Kernel after uncompressing the kernel image.
> Is the only solution is to inverse the mapping with Ram from=20
> 0 to 258M and the flash above ?

RAM should always start at address 0x0 in your chip select mapping.  =
When you pass mem=3D40M Linux will claim
RAM from 0x0 to 0x02800000.  The rest of the RAM, 0x02800000 to the end =
will be available for ioremap.  The reason your kernel does nothing =
after being uncompressed is because it has no idea where it is and =
probably is not being uncompressed to a valid RAM address.

The sensible place to map FLASH is the end of memory, or anywhere out of =
the way.  I assume you are low booting and that is why you think FLASH =
needs to be at the beginning of memory.  It does not, even though that =
is where you boot from you can remap the FLASH.


>=20
> Finally, will Busybox work with Ram starting at 0x03000000 ?

Busy box is part of your ramdisk, it does not know anything about the =
memory map.  If your kernel does not get past uncompressing then you did =
not get anywhere near busy box running.
