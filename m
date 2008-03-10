Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id D3B46DDF0A
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 02:06:43 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: OF compatible MTD platform RAM driver ?
Date: Mon, 10 Mar 2008 16:06:31 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1451589.TJpG23SlHl";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803101606.39184.laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1451589.TJpG23SlHl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

as part of a ARCH=3Dppc to ARCH=3Dpowerpc migration process, I'm looking fo=
r an=20
OpenFirmware compatible way to handle a RAM-based MTD device.

On the platform_device based ppc architecture, the drivers/mtd/maps/plat-ra=
m.c=20
driver handled "mtd-ram" platform devices. There is no such driver for the=
=20
OF-based powerpc architecture.

As a temporary workaround I hacked the physmap_of driver to=20
handle "direct-mapped" OF devices oh type "ram" by adding a corresponding=20
entry in the of_flash_match[] array. This seems to work fine.

What would be the preferred way to handle OF-compatible RAM-based MTD=20
devices ? The 3 ways I can think of are

1. porting the plat-ram driver to OF (the driver isn't used in the kernel t=
ree=20
but I suspect it is used by out-of-tree boards)

2. creating a new plat-ram-of driver, much like the physmap_of driver comes=
=20
from the physmap driver

3. extending the physmap_of driver to handle RAM devices (in which case=20
references to "flash" in the function names should probably be replaced=20
by "mtd")

I live option 3 better so far.

Has anyone already worked on this ? Is there any defined device tree mappin=
g=20
for MTD RAM devices ?

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1451589.TJpG23SlHl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH1U5/8y9gWxC9vpcRAiHPAKC5fQMqWimjqFGVVqNX8hV+C+vhMgCdF5cf
hQ26RPBmjf9fBrvQHMkgQio=
=yPVj
-----END PGP SIGNATURE-----

--nextPart1451589.TJpG23SlHl--
