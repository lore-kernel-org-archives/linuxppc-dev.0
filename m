Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Make RTAS console init generic
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20060816152303.7AF4967B5A@ozlabs.org>
References: <20060816040040.1E20967B55@ozlabs.org>
	<1155705695.12715.7.camel@localhost.localdomain>
	<20060816152303.7AF4967B5A@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xX/8rcnZjw1mH8xApBD5"
Date: Thu, 17 Aug 2006 10:44:12 +1000
Message-Id: <1155775453.6910.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-xX/8rcnZjw1mH8xApBD5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-08-16 at 10:22 -0500, Michael Neuling wrote:
> In message <1155705695.12715.7.camel@localhost.localdomain> you wrote:
> >=20
> > --=3D-PNKyW5KJv4630LcmkXVt
> > Content-Type: text/plain
> > Content-Transfer-Encoding: quoted-printable
> >=20
> > On Tue, 2006-08-15 at 23:00 -0500, Michael Neuling wrote:
> > > The RTAS console doesn't have to be Cell specific.  If we have both
> > > the put and get char RTAS functions, init the rtas console.
> > >=3D20
> > > Index: linux-2.6-ozlabs/arch/powerpc/kernel/rtas.c
> > > =3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3=
D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D
> > =3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=
=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D
> > =3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=
=3D3D=3D3D=3D3D=3D3D
> > > --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/rtas.c
> > > +++ linux-2.6-ozlabs/arch/powerpc/kernel/rtas.c
> > > @@ -910,6 +910,11 @@ int __init early_init_dt_scan_rtas(unsig
> > >  	basep =3D3D of_get_flat_dt_prop(node, "get-term-char", NULL);
> > >  	if (basep)
> > >  		rtas_getchar_token =3D3D *basep;
> > > +
> > > +	if (rtas_putchar_token !=3D3D RTAS_UNKNOWN_SERVICE &&
> > > +	    rtas_getchar_token !=3D3D RTAS_UNKNOWN_SERVICE)
> > > +		udbg_init_rtas_console();
> > > +
> > >  #endif
> > > =3D20
> > >  	/* break now */
> > > Index: linux-2.6-ozlabs/arch/powerpc/platforms/cell/setup.c
> > > =3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3=
D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D
> > =3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=
=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D
> > =3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=
=3D3D=3D3D=3D3D=3D3D
> > > --- linux-2.6-ozlabs.orig/arch/powerpc/platforms/cell/setup.c
> > > +++ linux-2.6-ozlabs/arch/powerpc/platforms/cell/setup.c
> > > @@ -150,10 +150,6 @@ static int __init cell_probe(void)
> > >  	    !of_flat_dt_is_compatible(root, "IBM,CPBW-1.0"))
> > >  		return 0;
> > > =3D20
> > > -#ifdef CONFIG_UDBG_RTAS_CONSOLE
> > > -	udbg_init_rtas_console();
> > > -#endif
> > > -
> >=20
> > I'd like to see it still guarded by UDBG_RTAS_CONSOLE, otherwise there'=
s
> > no way to select a different type of early console on a machine which
> > has those tokens in the device tree.
>=20
> Agreed but that section in rtas.c is already guarded by
> UDBG_RTAS_CONSOLE.  After applying the patch, it looks like:=20
>=20
> #ifdef CONFIG_UDBG_RTAS_CONSOLE
> 	basep =3D of_get_flat_dt_prop(node, "put-term-char", NULL);
> 	if (basep)
> 		rtas_putchar_token =3D *basep;
>=20
> 	basep =3D of_get_flat_dt_prop(node, "get-term-char", NULL);
> 	if (basep)
> 		rtas_getchar_token =3D *basep;
>=20
> 	if (rtas_putchar_token !=3D RTAS_UNKNOWN_SERVICE &&
> 	    rtas_getchar_token !=3D RTAS_UNKNOWN_SERVICE)
> 		udbg_init_rtas_console();
>=20
> #endif

Ah sorry, I just looked at the patch.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-xX/8rcnZjw1mH8xApBD5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE47vcdSjSd0sB4dIRAgGvAKCltNPfGdHMefLzo6S7jZRDpfslaACgrzz4
zbYDU+X0N6d8+g0INszfyFU=
=yd86
-----END PGP SIGNATURE-----

--=-xX/8rcnZjw1mH8xApBD5--
