Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
From: Michael Ellerman <michael@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <a2b3134aaf411c43fabdb6bba233f91a@kernel.crashing.org>
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<65a522813f1b95748a3acc0c05e0285c@kernel.crashing.org>
	<34656f27cfbc4a091e08526b42969ec1@kernel.crashing.org>
	<200706082206.55380.arnd@arndb.de>
	<a2b3134aaf411c43fabdb6bba233f91a@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Dn5vzRACTdMRsV98RcYc"
Date: Tue, 12 Jun 2007 12:32:14 +1000
Message-Id: <1181615534.17771.12.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Dn5vzRACTdMRsV98RcYc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-06-08 at 22:16 +0200, Segher Boessenkool wrote:
> > If you do
> >
> > for_each_compatible_node(node, NULL, "foo") {
> > 	do_something(node);
> > }
> >
> > then the reference count is held just as long as the do_something()
> > function is run,
>=20
> Yeah.  so (like we discussed on irc) the of_node_get() in
> the code under discussion should really be done inside the
> axon_msi_setup_one() function.

Yep.

> > and if you do
> >
> > for_each_compatible_node(node, NULL, "foo")
> > 	if (conditional_func(node))
> > 		break;
> >
> > then the node variable will have the reference count.
>=20
> Yes.  This is bad form though, "for_each" means for
> _each_, open coding the loop would be clearer IMHO.

No. That just means more places people can get the refcounting wrong.

If in doubt, just do:

for_each_compatible_node(node, NULL, "foo") {
   ..
}

...

of_node_put(node);

And then you're free to do whatever inside the loop, including breaking
out.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Dn5vzRACTdMRsV98RcYc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGbgWudSjSd0sB4dIRAsnRAJ9k+OcS/sZsjsSkODPMsZP2ctfmQACgtvQf
5Z7uZn7bfCDasWBd6+8gWHk=
=gqY4
-----END PGP SIGNATURE-----

--=-Dn5vzRACTdMRsV98RcYc--
