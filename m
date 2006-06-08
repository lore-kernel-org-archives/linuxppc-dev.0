Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/3] powerpc: Add early debugging / xmon support for Cell
From: Michael Ellerman <michael@ellerman.id.au>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
In-Reply-To: <20060502095406.C25DA67B3B@ozlabs.org>
References: <20060502095406.C25DA67B3B@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0W6OvW5a3ciG4CPgBrQo"
Date: Thu, 08 Jun 2006 05:22:12 +0000
Message-Id: <1149744132.7277.12.camel@localhost.localdomain>
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


--=-0W6OvW5a3ciG4CPgBrQo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-05-02 at 19:54 +1000, Michael Ellerman wrote:
> This patch adds udbg routines for cell, and hooks them up for use as an e=
arly
> debugging console or for xmon.
>=20
> With this patch xmon seems to work. On one occasion after sitting in xmon
> for a while I lost hard disk interrupts and had to power off, not sure wh=
at
> the story was there.
>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

This patch is no good, it allows you to inadvertently call rtas before
it's ready which causes the kernel to die. I think we can structure
things so that a) rtas is callable earlier, and b) rtas_call fails
gracefully when rtas isn't setup yet.

The BML guys now use these rtas calls too, so I'll do a version under
kernel/ so they can use it too.

New patch RSN.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-0W6OvW5a3ciG4CPgBrQo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEh7QEdSjSd0sB4dIRAi+rAJ9QLgXwCii7QmmwTJK6riXtj/a/mACcDlZ4
q1YAZSXei1KnXdgWcP82UoI=
=bNQD
-----END PGP SIGNATURE-----

--=-0W6OvW5a3ciG4CPgBrQo--
