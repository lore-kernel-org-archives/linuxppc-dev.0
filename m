Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 85CF6DE16B
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 23:53:21 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] rtc-pcf8563: Add device ids table
Date: Wed, 23 Apr 2008 15:53:14 +0200
References: <200804171708.32847.laurentp@cse-semaphore.com>
	<200804231412.40038.laurentp@cse-semaphore.com>
	<20080423144756.3fc9b1bf@hyperion.delvare>
In-Reply-To: <20080423144756.3fc9b1bf@hyperion.delvare>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9233562.uNRQ6XUGWQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804231553.17926.laurentp@cse-semaphore.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart9233562.uNRQ6XUGWQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 23 April 2008 14:47, Jean Delvare wrote:
> On Wed, 23 Apr 2008 14:12:37 +0200, Laurent Pinchart wrote:
> > On Wednesday 23 April 2008 13:16, Jean Delvare wrote:
> > > I still don't know exactly what happened there... I think I saw some
> > > "OpenFirmware i2c" patches go upstream yesterday? But not the ones
> > > listed below, which I thought they depended upon.
> >=20
> > The code that went upstream introduces helper functions to create i2c
> > devices from information supplied by the OF device tree. It doesn't
> > strictly depend on the below patches, but the new devices won't be
> > properly bound to a driver without them.
>=20
> OK. So... Out of the 7 patches Jochen sent originally, only 1 ([3/7] OF
> helpers for the i2c API) went upstream. Am I correct?
>=20
> Jochen, I'm a bit confused by the dependencies that exist - or not -
> between these 7 patches you sent at once. I thought they had to be
> applied in sequence but it seems not? And some of them should
> apparently go through me i2c tree but others (e.g. [7/7]) not?
>=20
> I would appreciate if you could summarize quickly which patches depend
> on others in which way. If we can make smaller subsets of patches, that
> will be easier for me to review and push upstream on my limited time.

Here is a summary based on my understanding of the situation. Jochen please=
=20
correct me if I'm wrong.

[PATCH1/7] i2c: Add support for device alias names

This patch allows new-style i2c chip drivers to have alias names using
the official kernel aliasing system and MODULE_DEVICE_TABLE(). It basically=
=20
adds device id table found in various subsystems (PCI, USB, ...) to i2c=20
new-style drivers.

The patch extends the new-style i2c device/driver matching code to support=
=20
device id tables. It modifies the drivers accordingly, as the probe functio=
n=20
now takes an extra argument (pointer to the device id entry that matched),=
=20
but doesn't add device id tables to the drivers.

[PATCH2/7] i2c: Convert all new-style drivers to use module aliasing

This patch adds the device id tables to the new-style i2c drivers. It depen=
ds=20
on the previous patch.

[PATCH3/7] i2c: OF helpers for the i2c API

This one has already been applied through the ppc subsystem. It adds helper=
=20
functions to instantiate i2c devices from the OF device tree. The patch has=
=20
no compile time dependencies but relies on 1/7 and 2/7 to bind devices to=20
drivers at runtime.

[PATCH4/7] i2c: Convert PowerPC MPC i2c to of_platform_driver from=20
platform_driver

This patch should go through the ppc subsystem. It adds OF device tree supp=
ort=20
to the i2c-mpc driver. To the best of my knowledge it depends on 3/7 only.

[PATCH5/7] i2c: Kill the old driver matching scheme

This patch removes the old driver_name/type scheme for i2c driver matching.=
=20
Only the new matching scheme introduced by 2/7 remains for new-style driver=
s.

[PATCH6/7] i2c: adds support for i2c bus on Freescale CPM1/CPM2 controllers

This one introduces a new i2c bus driver. It should go through the ppc=20
subsystem. To the best of my knowledge it depends on 3/7 only.

[PATCH7/7] [POWERPC] Add i2c pins to dts and board setup

This last patch configures i2c pins on various powerpc boards and updates t=
he=20
associated device trees to include the i2c controller. It should go through=
=20
the ppc subsystem. It has no compile-time dependency on any other patch in=
=20
the serie.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart9233562.uNRQ6XUGWQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIDz9N8y9gWxC9vpcRAqBsAJ9oADBm6R00DzJRCK9xxhL6RQaRnQCdHQQw
YgfMHJs4GJ6hEnKOkMPoJI4=
=LMqq
-----END PGP SIGNATURE-----

--nextPart9233562.uNRQ6XUGWQ--
