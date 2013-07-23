Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CDC652C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 22:38:01 +1000 (EST)
Message-ID: <51EE7909.6080804@pengutronix.de>
Date: Tue, 23 Jul 2013 14:37:29 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Wolfram Sang <wsa@the-dreams.de>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>, Detlev Zundel <dzu@denx.de>
Subject: Re: [PATCH v3 27/31] net: can: mscan: add common clock support for
 mpc512x
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-28-git-send-email-gsi@denx.de>
 <51ED2DF4.2090606@pengutronix.de>
 <20130723120733.GH19071@book.gsilab.sittig.org>
In-Reply-To: <20130723120733.GH19071@book.gsilab.sittig.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2LNKLSCTBFABCEPVBXJTO"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2LNKLSCTBFABCEPVBXJTO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/23/2013 02:07 PM, Gerhard Sittig wrote:
[...]

>>> +	return freq_calc;
>>> +
>>> +err_invalid:
>>> +	dev_err(&ofdev->dev, "invalid clock source specification\n");
>>> +	return 0;
>>
>> return 0 in case of error? Please add a comment what this 0 means here=
=2E
>=20
> The .get_clock() callback is supposed to return the resulting
> rate after the clock source was determined and the clock subtree
> was setup.  It wasn't (explicitly) documented before (in the
> non-common-clock case), so I did not bother to comment it in the
> parallel common-clock case.

Yes, but returning 0 in case of error should be documented, as it's very
uncommon.

> But it's true that returning zero in the error case may be
> unexpected, and I will add a comment in v4 (in all the
> .get_clock() implementations).

I think a one liner stating that the return value is the clock rate and
"0" indicates is an invalid clock rate, this meaning an error here, is
enough.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2LNKLSCTBFABCEPVBXJTO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHueQkACgkQjTAFq1RaXHNrUgCfXdRq5YL87KGdoay+xmUVetzD
0VUAn38NH4TzPswLSGIW+V0iArkbhNZE
=j3Kf
-----END PGP SIGNATURE-----

------enig2LNKLSCTBFABCEPVBXJTO--
