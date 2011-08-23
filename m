Return-Path: <jeffrey.t.kirsher@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by ozlabs.org (Postfix) with ESMTP id 039D6B6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 18:39:37 +1000 (EST)
Subject: Re: linux-next: boot test failure (net tree)
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To: David Miller <davem@davemloft.net>
Date: Tue, 23 Aug 2011 01:29:24 -0700
In-Reply-To: <20110822.210255.1902105215409964106.davem@davemloft.net>
References: <20110823114129.ceb18da164bf7df3c145941b@canb.auug.org.au>
	<20110822.191348.2099822249437201579.davem@davemloft.net>
	<CACqU3MW4BnucRt3gxPrKPDvWEjaVuxRF1VOPWk5hTRfneyANkg@mail.gmail.com>
	<20110822.210255.1902105215409964106.davem@davemloft.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-HpqJtc2ZH35A+XCxB7MA"
Message-ID: <1314088165.2128.221.camel@jtkirshe-mobl>
Mime-Version: 1.0
Cc: "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
	"mikey@neuling.org" <mikey@neuling.org>,
	"linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"paulus@samba.org" <paulus@samba.org>,
	"lacombar@gmail.com" <lacombar@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Reply-To: jeffrey.t.kirsher@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-HpqJtc2ZH35A+XCxB7MA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-08-22 at 21:02 -0700, David Miller wrote:
> From: Arnaud Lacombe <lacombar@gmail.com>
> Date: Mon, 22 Aug 2011 23:50:02 -0400
>=20
> > Are you implying we need some kind of way to migrate config ?
>=20
> The issue is that the dependencies for every single ethernet driver
> have changed.  Some dependencies have been dropped (f.e. NETDEV_10000
> and some have been added (f.e. ETHERNET, NET_VENDOR_****)
>=20
> So right now an automated (non-prompted, default to no on all new
> options) run on an existing config results in all ethernet drivers
> getting disabled because the new dependencies don't get enabled.
>=20
> This wouldn't be so bad if it was just one or two drivers, but in
> this case it's every single ethernet driver which will have and hit
> this problem.
>=20

Ok, I have patch which will resolve the issue.  It is the last patch in
the series I am about to send out.  What this patch does is set the
"new" Kconfig options to Y, so that current defconfig's can build
driver's that are currently set to build.

This will fix the issue, I have confirmed this with the x86_64
defconfig.  It will be nice that eventually all configs get updated so
that not all the NET_VENDOR_* tags have to be enabled, but
understandably this is the best way to ensure that current defconfig's
will compile all expected drivers.

--=-HpqJtc2ZH35A+XCxB7MA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOU2TkAAoJECTsCADr/EWUc3UH+wRmblkKCeeVZmfYQ8NrsFRX
mUuupGthI7v0VDrc7wOvt6lOb44Of1PmDV1CcFikKA+eYOEbSIF+F2jCZ2P05qLc
KWuOK9ZkcE1xVLvDOmbBUhHX/sOkdNfXfeprqzoYTjnXCnK14XcRkOGfZBGrotQw
yCpSKJGQRYNGexl8ohgz9GvZUIWwmJmS4tglvRuxQ7BXTA/kiYjWw8n9miqjl+wU
pHkd7+eFkS5axWTU0CLQGRdUkhhimhNBQ06i/FwCKgFIGlKB979RaMBBgg4wcCEM
FOUDRdShaJP/zFsC6/QW7/5oLWcB+kfbTIHFgeUuzRACNn37IptNF8pfKblt4yk=
=e3ED
-----END PGP SIGNATURE-----

--=-HpqJtc2ZH35A+XCxB7MA--
