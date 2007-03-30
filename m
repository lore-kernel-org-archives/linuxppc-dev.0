Return-Path: <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [PATCH] Implement check_legacy_ioport() on PS3
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070330014542.GA28342@lixom.net>
References: <1175212972.3122.87.camel@pmac.infradead.org>
	<20070330014542.GA28342@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-mHJHVrbWiVx8eZQXH9qR"
Date: Fri, 30 Mar 2007 11:43:20 +1000
Message-Id: <1175219000.5241.6.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-mHJHVrbWiVx8eZQXH9qR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-03-29 at 20:45 -0500, Olof Johansson wrote:
> On Fri, Mar 30, 2007 at 01:02:52AM +0100, David Woodhouse wrote:
> > It doesn't like it when we poke at legacy I/O ports like the i8042. We
> > should probably change the _default_ to return -ENODEV, and let any
> > strange platform which wants to allow unfettered access provide its own
> > function for that.
>=20
> I ran into the very same thing earlier myself and had exactly the same
> idea. However, it turned out then that it would have meant adding more
> cases of ioport being allowed than it would have removed the opposite. It
> might have changed since then. Either way it's annoying.

No I just looked at it too. We have 19 platforms, 7 define
check_legacy_ioport(), 6 of those return ENODEV, one does something
useful. Which leaves 12 platforms that get the default "return 0"
behaviour.

I still don't like it though, having to opt _out_ of random io port
poking is not nice.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-mHJHVrbWiVx8eZQXH9qR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBGDGs3dSjSd0sB4dIRAvFiAJ95DMSVC6anBjUR/zJmLVnppLqsTACgxOqM
hwoXbY6JjufBkOPOhievLx8=
=P4az
-----END PGP SIGNATURE-----

--=-mHJHVrbWiVx8eZQXH9qR--
