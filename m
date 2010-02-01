Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 804EAB7D37
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Feb 2010 21:00:22 +1100 (EST)
Date: Mon, 1 Feb 2010 11:00:17 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	devicetree-discuss@ozlabs.org
Subject: Re: [resend] Make the kernel accept ePAPR style phandle information
Message-ID: <20100201100017.GA3288@pengutronix.de>
References: <20100201045242.GB8095@yookeroo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
In-Reply-To: <20100201045242.GB8095@yookeroo>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2010 at 03:52:42PM +1100, David Gibson wrote:
> Grant, I've updated this for your current test-devicetree branch.
> Please apply.
>=20
> Currently when processing flattened device trees, the kernel expects
> the phandle in a property called "linux,phandle".  The ePAPR spec -
> not being Linux specific - instead requires phandles to be encoded in
> a property named simply "phandle".  This patch makes the kernel accept
> either form when unflattening the device tree.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Index: working-2.6/drivers/of/fdt.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- working-2.6.orig/drivers/of/fdt.c	2010-02-01 15:51:44.000000000 +1100
> +++ working-2.6/drivers/of/fdt.c	2010-02-01 15:51:46.458557615 +1100
> @@ -310,10 +310,19 @@ unsigned long __init unflatten_dt_node(u
>  		pp =3D unflatten_dt_alloc(&mem, sizeof(struct property),
>  					__alignof__(struct property));
>  		if (allnextpp) {
> -			if (strcmp(pname, "linux,phandle") =3D=3D 0) {
> +			/* We accept flattened tree phandles either in
> +			 * ePAPR-style "phandle" properties, or the
> +			 * legacy "linux,phandle" properties.  If both
> +			 * appear and have different values, things
> +			 * will get weird.  Don't do that. */

I don't want to be just pedantic, I really think the preferred way of
multi-line comments

 /*
  * foo
  * bar
  */

will help readability a lot here.


> +			if ((strcmp(pname, "phandle") =3D=3D 0)
> +			    || (strcmp(pname, "linux,phandle") =3D=3D 0)) {
>  				if (np->phandle =3D=3D 0)
>  					np->phandle =3D *((u32 *)*p);
>  			}
> +			/* And we process the "ibm,phandle" property
> +			 * used in pSeries dynamic device tree
> +			 * stuff */
>  			if (strcmp(pname, "ibm,phandle") =3D=3D 0)
>  				np->phandle =3D *((u32 *)*p);
>  			pp->name =3D pname;
>=20
> --=20
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktmpjEACgkQD27XaX1/VRtH/gCgxP0YNT9wjgDky/HL163sOaGG
dUUAnjVkCEDwmwlh9bsQsmw8ufnlebP7
=f4Ab
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
