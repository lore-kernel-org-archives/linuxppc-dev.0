Return-Path: <tomi.valkeinen@ti.com>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHSxh4tyLzDvXN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 22:30:31 +1100 (AEDT)
Subject: Re: [PATCH] Fix loading of module radeonfb on PowerMac
To: Mathieu Malaterre <malat@debian.org>, <linux-fbdev@vger.kernel.org>
References: <1475928540-19647-1-git-send-email-malat@debian.org>
CC: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Jean-Christophe
 Plagniol-Villard <plagnioj@jcrosoft.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <d994a36f-a7d8-eeb7-ef73-7935ea737075@ti.com>
Date: Mon, 14 Nov 2016 13:30:06 +0200
MIME-Version: 1.0
In-Reply-To: <1475928540-19647-1-git-send-email-malat@debian.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pO9GldfQb1O0RFQIG4xD3hRbDsmgV5IwP"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--pO9GldfQb1O0RFQIG4xD3hRbDsmgV5IwP
Content-Type: multipart/mixed; boundary="gLoJ4gNQ2FivwttWifopS59Io9MiRVdsd";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Mathieu Malaterre <malat@debian.org>, linux-fbdev@vger.kernel.org
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Message-ID: <d994a36f-a7d8-eeb7-ef73-7935ea737075@ti.com>
Subject: Re: [PATCH] Fix loading of module radeonfb on PowerMac
References: <1475928540-19647-1-git-send-email-malat@debian.org>
In-Reply-To: <1475928540-19647-1-git-send-email-malat@debian.org>

--gLoJ4gNQ2FivwttWifopS59Io9MiRVdsd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/16 15:09, Mathieu Malaterre wrote:
> When the linux kernel is build with (typical kernel ship with Debian
> installer):
>=20
> CONFIG_FB_OF=3Dy
> CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> CONFIG_FB_RADEON=3Dm
>=20
> The offb driver takes precedence over module radeonfb. It is then
> impossible to load the module, error reported is:
>=20
> [   96.551486] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
> [   96.551526] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0x98000=
000-0x9fffffff pref]
> [   96.551531] radeonfb (0000:00:10.0): cannot request region 0.
> [   96.551545] radeonfb: probe of 0000:00:10.0 failed with error -16
>=20
> This patch reproduce the behavior of the module radeon, so as to make i=
t
> possible to load radeonfb when offb is first loaded.
>=20
> It should be noticed that `offb_destroy` is never called which explain =
the
> need to skip error detection on the radeon side.
>=20
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Link: https://bugs.debian.org/826629#57
> Suggested-by: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
> ---
>  drivers/video/fbdev/aty/radeon_base.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)

Thanks, queued for 4.9 fixes.

 Tomi


--gLoJ4gNQ2FivwttWifopS59Io9MiRVdsd--

--pO9GldfQb1O0RFQIG4xD3hRbDsmgV5IwP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYKaA+AAoJEPo9qoy8lh71K9UQAKKyOTf5J0IwOmmPGoF4Hmp9
nUYk0gbySzPuDJYVHX+M7WaZFyfZFI9m+E/7N32kySFKfFwOjvBwl1xrDqXa6N5e
n54x5dzMVkwrChfjkZUdxKh5ylzmKTCubbDFxSHIt8a/l8m4BT3X2nbQRJJ0PnDI
aBT1J9lo73vbQJdTdhAM478NlvP/BMISywkaqWtBfRdRjN0ctzY9ooLqf6UwuRsA
EpdLvky/4FtIKnL6PtZrgbqeGiwJZcdN34kKBzSQih7Ry2NAtx213bO0Vi/dIP0p
pi3BrzaPs3WH75PSnI7xU4sLS7+v7QVDSRMZqpeZSsnkGq8rp+5Wqb7cx3BcdlGQ
cwiZHDyOUceE2wPZGI/oP3UaNfcwCjcmoc2dKPS06tLpKkhnS5k4/pfuT6jAc2fG
D8ePz5WZnHx7qzIWOWLj2mmF6wc/h02YQX1k3aBBXWnEhRPcMezHknDh+UbXlTNd
ouJ4oI6l8rbpX9wOnvEpaVmmLFOcqY/H+nyuJ2Dmy+ASchidS/NMYUAJH49V4Z1A
l3zVXPF7qvOwQnD+QD2+R/jG7HTn3AnJf+IYrFgjibJ6U6VqJI5f+qSm9RMZzW84
6q9218VgYJxXSe+2LX+J89MNewM/A5DKzOjvmOEFyInfzmNFnCKaP5HqMeFjf732
NiNBuUIa1Y1084ryc8L5
=quIT
-----END PGP SIGNATURE-----

--pO9GldfQb1O0RFQIG4xD3hRbDsmgV5IwP--
