Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 693B1B7B6B
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 07:27:30 +1100 (EST)
Date: Thu, 8 Oct 2009 22:27:23 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
Message-ID: <20091008202723.GA8116@pengutronix.de>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
	<20091008143301.GA6084@oksana.dev.rtsoft.ru>
	<fa686aa40910080753v6f597b0h4ce835db9f7a653@mail.gmail.com>
	<20091008151007.GA21328@oksana.dev.rtsoft.ru>
	<fa686aa40910080848r459c47baob73fc70a95a08604@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
In-Reply-To: <fa686aa40910080848r459c47baob73fc70a95a08604@mail.gmail.com>
Cc: linux-embedded@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-i2c@vger.kernel.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> No, this goes beyond PPC/OF.  The real issue is that it is no longer a
> safe assumption that pdata will be a static data structure in platform
> code.  The number of possible data sources is going to get larger, not
> smaller.  OF is just one.  UEFI is another.  Translating that data
> into pdata will be the problem that comes up over and over again.
> However, translation code is still driver specific, so it belongs with
> the driver that it translates code for.
>=20
> So, in my opinion, translation code must:
> 1. be *tiny* -- should be trivial to add to a driver without impacting
> common code
> 2. live with the driver that it translates data for; ideally in the
> same .c file for drivers that are small.

I am with Grant on these points. It is more than just PPC.

> > No matter how small the OF code is, I believe we shouldn't put it
> > into the generic code. Take a look at mmc_spi case again, it can be
> > easily extended to any arch, because there is no arch-specific stuff,
> > but a "get/put" pattern for platform data.

Will check this tomorrow.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrOSysACgkQD27XaX1/VRvKzgCgmRbw4QYsnCx/oLx+FBH5JuPP
g1gAn1uIVJgNUzvickgYUbHyqfzGFNTs
=ZWWV
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
