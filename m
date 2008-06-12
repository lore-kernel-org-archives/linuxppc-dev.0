Return-Path: <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [PATCH] powerpc/cell: disable ptcal in case of
	kdump reboot
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <11619.1213258014@neuling.org>
References: <200806111828.59043.arnd@arndb.de>
	<1213202956.28589.4.camel@localhost> <200806120939.23836.arnd@arndb.de>
	<11619.1213258014@neuling.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-pfIsV/4u5ijq15qdJVWZ"
Date: Thu, 12 Jun 2008 19:04:40 +1000
Message-Id: <1213261480.8652.5.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
	cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-pfIsV/4u5ijq15qdJVWZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-06-12 at 18:06 +1000, Michael Neuling wrote:
> In message <200806120939.23836.arnd@arndb.de> you wrote:
> > On Wednesday 11 June 2008, Michael Ellerman wrote:
> > > On Wed, 2008-06-11 at 18:28 +0200, Arnd Bergmann wrote:
> > > > We used to do this correctly in case of a user triggered
> > > > kexec, but not for kdump.
> > >=20
> > > Used to?
> >=20
> > Sorry, wrong wording. I meant without this patch, it's correct
> > for kexec.
> > =20
> > > > This patch disables ptcal from the cell specific
> > > > machine_crash_shutdown() callback.=20
> > >=20
> > > I'd rather you used the crash_shutdown_register() infrastructure Mike=
y
> > > added for EHEA - it's designed for just this sort of thing.
> >=20
> > Thanks for pointing this out, I wasn't aware of that call.
> > New patch coming up.
>=20
> In theory we can register lots of call backs but currently the maximum
> is set to 1 through CRASH_HANDLER_MAX.  This is to discourage people
> from using this infrastructure at all.

Yeah true. In this case I think it's the less horrible solution to
something that's fundamentally kdump-unfriendly.

> Unless there's some crazy arse company that's going to mix a CBE with an
> eHEA, we are probably ok leaving this at 1.  Right?

No comment *cough*. I guess I'd say just increase it to 2 on the off
chance, can't hurt much.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-pfIsV/4u5ijq15qdJVWZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIUOaodSjSd0sB4dIRAshpAKCQrXcmjdar6w1rT58Ko9BsfOl9VgCeNp0h
Pltl94MaSkI3vtbHgBtZgF8=
=8QIQ
-----END PGP SIGNATURE-----

--=-pfIsV/4u5ijq15qdJVWZ--
