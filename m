Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
From: Michael Ellerman <michael@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200706041912.04651.arnd@arndb.de>
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<90f8b99fa6a8e4b8898d64630d96036f68668b03.1180961962.git.michael@ellerman.id.au>
	<200706041912.04651.arnd@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nc+HJkOncKYJRJuA1Q/o"
Date: Fri, 08 Jun 2007 12:53:00 +1000
Message-Id: <1181271180.6026.10.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-nc+HJkOncKYJRJuA1Q/o
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-06-04 at 19:12 +0200, Arnd Bergmann wrote:
> On Monday 04 June 2007, Michael Ellerman wrote:
> > +       for_each_compatible_node(node, NULL, "ibm,axon-msic") {
> > +               if (axon_msi_setup_one(of_node_get(node)) =3D=3D 0)
> > +                       found++;
> > +       }
> > +       of_node_put(node);
>=20
> One more thing: AFAICS 'node' is guaranteed to be NULL when you get
> out of the for_each_compatible_node loop, so you don't need the
> of_node_put().

Yeah it is. I kind of like having the put there, because the idiom is
often to have a for_each_* with a break in it, in which case you need
the put.

But in this case it's a waste so I'll remove it.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-nc+HJkOncKYJRJuA1Q/o
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGaMSMdSjSd0sB4dIRAoJMAJ0U1i/43AjpEIjEXGWldlrUQ9iuywCgnD1h
YP3N4OJlZMQYKnSHqjMQdsQ=
=k1WE
-----END PGP SIGNATURE-----

--=-nc+HJkOncKYJRJuA1Q/o--
