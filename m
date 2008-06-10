Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [POWERPC] Free a PTE bit on ppc64 with 64K pages
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20080529055401.9B758DDDE7@ozlabs.org>
References: <20080529055401.9B758DDDE7@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-UOqog35EJ46iSJzy1jbu"
Date: Tue, 10 Jun 2008 14:00:51 +1000
Message-Id: <1213070451.7957.3.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-UOqog35EJ46iSJzy1jbu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-05-29 at 15:51 +1000, Benjamin Herrenschmidt wrote:
> This patch frees a PTE bit when using 64K pages on ppc64. This is done
> by getting rid of the separate _PAGE_HASHPTE bit. Instead, we just test
> if any of the 16 sub-page bits is set. For non-combo pages (ie. real
> 64K pages), we set SUB0 and the location encoding in that field.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>=20
> Please review and make sure I didn't miss something ...=20

This doesn't build for CONFIG_PPC_64K_PAGES=3Dn and
CONFIG_PPC_HAS_HASH_64K=3Dy, because the asm is protected by the latter
but the header definitions are protected by the former.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-UOqog35EJ46iSJzy1jbu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBITfxzdSjSd0sB4dIRAh9cAJ9osm3E4pWW3WKnHqzjinZfWlbSUgCgusXj
uyq885llFNO2abgTazrFr6Q=
=MYxr
-----END PGP SIGNATURE-----

--=-UOqog35EJ46iSJzy1jbu--
