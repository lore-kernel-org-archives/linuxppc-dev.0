Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7C19FDDE10
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 15:07:39 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m0E47MKD014578
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 15:07:22 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0E4BE2o173844
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 15:11:14 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0E47cAf013594
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 15:07:38 +1100
Date: Mon, 14 Jan 2008 15:02:07 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Enable RTC for Ebony and Walnut (v2)
Message-ID: <20080114040207.GA15119@localhost.localdomain>
References: <20071221022130.GI2665@localhost.localdomain>
	<20080111032534.GA25055@localhost.localdomain>
	<20080111172957.c0431145.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
In-Reply-To: <20080111172957.c0431145.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2008 at 05:29:57PM +1100, Stephen Rothwell wrote:
> On Fri, 11 Jan 2008 14:25:34 +1100 David Gibson <dwg@au1.ibm.com> wrote:
> >
> > +++ working-2.6/arch/powerpc/sysdev/of_rtc.c	2008-01-11 14:17:03.000000=
000 +1100
>=20
> > +static __initdata struct {
> > +	const char *compatible;
>=20
> If you make this an array, then the string will become __initdata as well.

Well, yes, but then I'd have to pick a specific size for the string.
Since this is supposed to be a stopgap until I can build a more
general constructor mechanism..

> > +	char *plat_name;
> > +} of_rtc_table[] =3D {
> > +	{ "ds1743-nvram", "rtc-ds1742" },
> > +};
>=20
> > +			platform_device_register_simple(plat_name, -1, res, 1);
>=20
> Do we care if this fails?

Well.. sort of, but there's not really any sane way of reporting it.
This will be called from early platform init code, failures shouldn't
cause us not to boot, and failure to register one rtc shouldn't cause
us not to attempt to register others if they're present.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHit6/aILKxv3ab8YRAsi2AJ9ciZDGMTdSSBBeAJJYUf2geQOFJwCeOVci
ka8WlAUzI8g39F+uj0Vq1i0=
=+xMw
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
