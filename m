Return-Path: <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [PATCH] cell: abstract spu management routines
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45516A0C.5050607@am.sony.com>
References: <455161D2.3090004@am.sony.com>
	<1162962074.20271.16.camel@localhost.localdomain>
	<45516A0C.5050607@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/p21eOMcS52MgkR1g9y7"
Date: Wed, 08 Nov 2006 17:28:09 +1100
Message-Id: <1162967289.32720.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/p21eOMcS52MgkR1g9y7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-11-07 at 21:24 -0800, Geoff Levand wrote:
> Michael Ellerman wrote:
> >> +static struct platform_data *platform_data(struct spu *spu)
> >> +{
> >> +	BUG_ON(!spu->platform_data);
> >> +	return (struct platform_data*)spu->platform_data;
> >> +}
> >=20
> > I don't see the point of this, why not just grab platform data directly=
?
>=20
> Well, first, it does a check, and second, you can't just grab platform_da=
ta,
> you need to always do the cast also. So then, is something like
> '((struct platform_data*)spu->platform_data)->' preferred over
> 'platform_data(spu)->'?

Stephen points out that you shouldn't do the cast at all (inside the
function), it's implied by the return type. And by casting explicitly
you create the potential for the return type and the cast to get out of
sync.

At some point we'll actually read the rest of the patch ;)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-/p21eOMcS52MgkR1g9y7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFUXj4dSjSd0sB4dIRAqbRAKCtYoJFmW+rYtz2LwKIQq97SvbVYQCgq++p
qn4octalwZrDjzK9Fc6ZL/0=
=lmF7
-----END PGP SIGNATURE-----

--=-/p21eOMcS52MgkR1g9y7--
