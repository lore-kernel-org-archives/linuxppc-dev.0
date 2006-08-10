Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH][2/2] RTAS MSI
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1155117003.4040.69.camel@localhost.localdomain>
References: <1154024154.29826.229.camel@goblue>
	<1154024834.29826.240.camel@goblue>
	<1154320382.19883.26.camel@localhost.localdomain>
	<1154379714.29826.396.camel@goblue>
	<1154509462.26242.9.camel@localhost.localdomain>
	<1155117003.4040.69.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-F6Aqa2rLiI9YnXjbazK1"
Date: Thu, 10 Aug 2006 18:03:35 +1000
Message-Id: <1155197015.9801.82.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, PaulMackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-F6Aqa2rLiI9YnXjbazK1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-08-09 at 11:50 +0200, Benjamin Herrenschmidt wrote:
> > I'm only just starting to get benh's new irq code, but I think
> > irq_find_host(dn) isn't doing what we want here. It's probably harmless=
,
> > but AFAICT irq_find_host() is only meant to be called when you have the
> > node of the irq controller, not for an arbitrary dn. The doco's a bit
> > ambiguous:
> >=20
> >  * irq_find_host - Locates a host for a given device node
> >  * @node: device-tree node of the interrupt controller
> >=20
> > But looking at the implementation, it doesn't do a search up the tree o=
r
> > anything, it just checks node against each host.
>=20
> For pSeries, passing NULL is fine for host anyway as there is only one
> domain that is relevant for MSIs (there might be a 8259 legacy domain
> too but it's not relevant) and that domain is set to be the default
> host.

OK, will fix it. In the long run we probably want a function that takes
any dn and finds the host for it.

>=20
> > Also, since's benh's latest patch went in we'll have to split this into
> > two calls, I think we want:
> >=20
> > virq =3D irq_create_mapping(NULL ???, ret[0]);
> > set_irq_type(virq, ret[1] ? IRQ_TYPE_EDGE_RISING : IRQ_TYPE_LEVEL_LOW);
>=20
> MSIs are always edge (though there might be an issue with some P5IOC
> errata lurking here...). The xics code doesn't care much at this point
> though.

Err, great. Anymore info? I'll just set it to EDGE for now.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-F6Aqa2rLiI9YnXjbazK1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE2uhXdSjSd0sB4dIRAjGGAKCuD2V6hixdJiQ+i1cftC1d7ssJOgCfc5I8
259kveEU+Y+56Sr/2F5RA78=
=Ix5R
-----END PGP SIGNATURE-----

--=-F6Aqa2rLiI9YnXjbazK1--
