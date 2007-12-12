Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E0A4FDDFCD
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 05:03:15 +1100 (EST)
Subject: Re: apm_emulation regression
From: Johannes Berg <johannes@sipsolutions.net>
To: benh@kernel.crashing.org
In-Reply-To: <1197427530.8385.59.camel@pasglop>
References: <1197427530.8385.59.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-SlHN4jmI+M9LGbW4DOrO"
Date: Wed, 12 Dec 2007 19:03:07 +0100
Message-Id: <1197482587.6558.145.camel@johannes.berg>
Mime-Version: 1.0
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-pm <linux-pm@lists.osdl.org>, ralf <ralf@linux-mips.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-SlHN4jmI+M9LGbW4DOrO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Wed, 2007-12-12 at 13:45 +1100, Benjamin Herrenschmidt wrote:
> I only just noticed a huge regression that was introduced when we moved
> PowerPC to the generic APM emulation code instead of our own. I'm in
> large part to blame since I acked the patch...
>=20
> Basically, what we lost is the mechanism for notifying user applications
> and waiting for their ACK before proceeding to system suspend. The new
> generic code will still do that ... only when the actual suspend request
> initiates from an APM suspend ioctl.

Indeed.

> For any other suspend (via our private PMU ioctl or via the sysfs
> interface), userspace will -not- be notified.

Right.

> That basically means X will break. That's why X broke on the latest
> ubuntu until I whacked some new scripts in them to force console
> switching, among other things. Possibly other apps that relied
> on /dev/apm_bios to be notified of system suspend/resume broke as well.

Ah. I guess I never noticed because I had the scripts to do console
switching all along.

> Now the question is that is it still work trying to fix it ? That would
> probably require APM emulation hooking at a fairly high level into the
> generic PM code to trigger the signaling & waiting of processes before
> freeze & device suspend among others...

Yeah, bit icky... but doable. Rafael, any ideas?

johannes

--=-SlHN4jmI+M9LGbW4DOrO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR2AiWaVg1VMiehFYAQLTkBAAsOIzqkCf4GXPRnMOWXyW28PqUqTVfU4D
PclFsePxu+Fj750ZbxodWmXvIurhiWPIyH5Eqy4BbrP/T9aj5Gb/1L4v+kIJ/IV3
Jye/Fk/Uk1XW3bFSjjOHM4BLTnb90ZkvkFjBTrNUDb32i9TghjKVAQGkM4w8V1dE
tFfIxXEVHiCOBH9D0W5vEIqN8m6Zy0dcU6KyZBmHFuT+becXNq5HjOmPdnsz9DcM
Ol4223/PozVPGIEd5htPyJjCnPiKmkd+3MLSjwk/4GirGP/t3MCGaCAYw0eq3Leg
uGFgXOkepkQG7yhPCPI2HHJOUeJr8JUfpxhTeEmhRpdcCLxvUvPacHevdwHrM2Ae
1UMQrhYr0IwC7RxapOPaYfYhb17cfWTl5mhCxNOMeb9ELSb9zDJxnss4WNryD3j5
GjyJzZPJek2n+z79/8AQZnjSUQlmYsE/2aO0GPa75knPPNbJATJDiI8z673s1pGz
o8IkTjqhZ62yeWzwjJGlEZMdxzgycK/qqBKbbYJ1gBuUbau/npUogqfhxVU1/FuA
XmHCKiDYMBxaqUToBYz8eaMtjdM+KuPMavjXyLn6hgy8ofeN3RLe9WQ41ZaZ2kyX
lbS9Hz4gk/pGfRC2x+Io6T5uQnuZgtc4CJNA5VHxo+2Hbho3T2c8ug5ivCGM1TjQ
xjzlvKzMHv8=
=YwC8
-----END PGP SIGNATURE-----

--=-SlHN4jmI+M9LGbW4DOrO--
