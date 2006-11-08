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
	boundary="=-uT0hJmXDV7/QQH/VJhc0"
Date: Wed, 08 Nov 2006 16:54:30 +1100
Message-Id: <1162965270.20271.22.camel@localhost.localdomain>
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


--=-uT0hJmXDV7/QQH/VJhc0
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

Yeah OK I missed the cast, I guess it's worth it then. In that case can
you change the names? Having the struct, the member and the accessor all
named the same is a bit confusing.

The BUG() is pretty superfluous, you're just preempting the NULL deref
by 1 instruction.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-uT0hJmXDV7/QQH/VJhc0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFUXEWdSjSd0sB4dIRAklSAJwOo0zfCIPc5823UDgZqH1mqnLXuwCfTAPE
mBW2AwugdUCzTihpJKW5ZWM=
=y+kt
-----END PGP SIGNATURE-----

--=-uT0hJmXDV7/QQH/VJhc0--
