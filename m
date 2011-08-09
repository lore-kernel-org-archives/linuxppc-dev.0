Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E6C6BB6F7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Aug 2011 22:04:49 +1000 (EST)
Message-ID: <4E412252.5000106@pengutronix.de>
Date: Tue, 09 Aug 2011 14:04:34 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Subject: Re: [RFC 4/4] [powerpc] Add flexcan device support for p1010rdb.
References: <1312869313-22434-1-git-send-email-holt@sgi.com>
	<1312869313-22434-5-git-send-email-holt@sgi.com>
	<20110809063319.GK4926@sgi.com> <4E40DDA5.1050004@grandegger.com>
	<20110809114043.GN4926@sgi.com>
In-Reply-To: <20110809114043.GN4926@sgi.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2361097E0AB76C23223C0B95"
Cc: socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
	U Bhaskar-B22300 <B22300@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2361097E0AB76C23223C0B95
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/09/2011 01:40 PM, Robin Holt wrote:
> On Tue, Aug 09, 2011 at 09:11:33AM +0200, Wolfgang Grandegger wrote:
>>> +	return &p1010_rdb_system_clock;
>>
>> Just returning fsl_get_sys_freq() here would already be fine. I'm also=

>> missing the factor of two here:
>>
>>         return fsl_get_sys_freq() / 2; ????
>=20
> I am working on the other comments right now as well, but this one
> brought up a good question.  The old algorithm in the original freescal=
e
> patches I started with actually did, essentially:
>=20
> 	...clock.freq =3D DIV_ROUND_CLOSEST(fsl_get_sys_freq() / 2, 1000) * 10=
00
>=20
> The end result was before:
> 	...clock.freq=3D0x0bebc200

That's exactly 200 MHz

> After:
> 	...clock.freq=3D0x0bebc1fe

this is 199 999 998 Hz

> Is that rounding relavent?

_If_ 200 MHz is correct, this would be an error of 0.000001%. But the
fsl code rounds to closest KHz. Rounding introduces errors in most of
the cases. IMHO it's better not to round here.

For example the usual at91can is clocked with 99.532800 MHz, this is a
least the value the arm clock framework reports.

Cheers, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2361097E0AB76C23223C0B95
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5BIlUACgkQjTAFq1RaXHOnnACfdRP3JrCLPDCqtDxN6P4UUvvM
W4oAn0uKbOHL6PIULb325PuQ19A6VcAN
=nVB5
-----END PGP SIGNATURE-----

--------------enig2361097E0AB76C23223C0B95--
