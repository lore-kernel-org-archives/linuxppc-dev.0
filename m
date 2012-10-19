Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 097802C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 21:36:27 +1100 (EST)
Date: Fri, 19 Oct 2012 13:30:39 +0300
From: Felipe Balbi <balbi@ti.com>
To: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH 5/7] usb: gadget: fsl_udc: postpone freeing current dTD
Message-ID: <20121019103039.GF11191@arwen.pp.htv.fi>
References: <1350642156-8034-1-git-send-email-chf.fritz@googlemail.com>
 <1350642285-8145-5-git-send-email-chf.fritz@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4f28nU6agdXSinmL"
In-Reply-To: <1350642285-8145-5-git-send-email-chf.fritz@googlemail.com>
Cc: Estevam Fabio-R49496 <r49496@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Chen Peter-B29397 <B29397@freescale.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-usb@vger.kernel.org,
 Felipe Balbi <balbi@ti.com>, "Hans J. Koch" <hjk@hansjkoch.de>,
 Daniel Mack <daniel@caiaq.de>, Christian Hemp <c.hemp@phytec.de>,
 linuxppc-dev@lists.ozlabs.org, Teresa Gamez <T.Gamez@phytec.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--4f28nU6agdXSinmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2012 at 12:24:43PM +0200, Christoph Fritz wrote:
> USB controller may access a wrong address for the dTD (endpoint transfer
> descriptor) and then hang. This happens a lot when doing tests with
> g_ether module and iperf, a tool for measuring maximum TCP and UDP
> bandwidth.
>=20
> This hardware bug is explained in detail by errata number 2858 for i.MX23:
> http://cache.freescale.com/files/dsp/doc/errata/IMX23CE.pdf
>=20
> All (?) SOCs with an IP from chipidea suffer from this problem.
> mv_udc_core fixes this bug by commit daec765.  There still may be
> unfixed drivers.

why aren't you using that driver instead ? Is it really necessary to
keep this driver around ? I would really like to see uniformization
towards that, if you use the same IP, then the same driver ought to
suffice.

What's the reason for not using drivers/usb/chipidea ?

--=20
balbi

--4f28nU6agdXSinmL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgSvPAAoJEIaOsuA1yqREKK4QAJ5qWR7kNXr1dwvZJqheLgH/
RBEo/bmtRqFGM+xbBpbrtBMlZ+fOgdH3hEcP5QIi8Yw7qG8N0OYpb4ywOTf8jGYp
Fp6LIZUaT6OW64TtWXgAcZtISS2QbSp5vK/+/+5bcC9dtRqsUAfAglBe/SmIxF4R
NTTKtnTkgSf0qfrcQbdLGHLmBcn4QvFLqAeUZM7LUmNDJXXC1FwnnfJrZpkOzje2
A/7nkqXdmDFgMFy1gGvt2lRMVep7dpPmMK2GrfXpSvspHvSlPfh8dqi4z1J5BeU5
4oqjmH7werV5PEthnShHNtl/trVS+wVS9Af1tmwW3JzjO5hs5QJV98vmEIViF9f/
TIYWcRJFWJJ/3ninlaK9OIZzb9fzSLI9VfLs9dn3CnRT6RLPKGjywDK7fAOuUnqg
qqbie4ri9XHkc+EWd54CMGk7SErGrno/a79Vjx0jOC773O4GU73Dv9gv/omh3I/I
Arhjf5hCZISgZlxmP2iOX7lq8tFiMnC+YAN+/nC3XGb94d03tVP/nugYGwsHb/cO
1F6JP5rCOQTRnHjiUL0xyDmxWCiB7bKqu1b1WPJKR0kGh6KPrSIWIRi5NB6GSqlG
uJwfCd2IdjL6wzg0qBu7V+P6nwO5ABBKH3WTdBr1sDuxeteuF2ap3R+wgZwLq9mk
kdiRMxGCjTB/NTFp0xIr
=6xlf
-----END PGP SIGNATURE-----

--4f28nU6agdXSinmL--
