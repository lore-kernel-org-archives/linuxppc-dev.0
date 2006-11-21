Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 17/22] coredump: Add SPU elf notes to coredump.
From: Michael Ellerman <michael@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20061120180526.374170000@arndb.de>
References: <20061120174454.067872000@arndb.de>
	<20061120180526.374170000@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Di0HqZQDpqqiq6j0IZLF"
Date: Tue, 21 Nov 2006 16:38:08 +1100
Message-Id: <1164087488.13318.43.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Dwayne Grant McConnell <decimal@us.ibm.com>, cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Di0HqZQDpqqiq6j0IZLF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-11-20 at 18:45 +0100, Arnd Bergmann wrote:
> Index: linux-2.6/include/linux/elf.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/linux/elf.h
> +++ linux-2.6/include/linux/elf.h
> @@ -368,5 +368,12 @@ extern Elf64_Dyn _DYNAMIC [];
> =20
>  #endif
> =20
> +#ifndef ARCH_HAVE_EXTRA_ELF_NOTES
> +static inline int arch_notes_size(void) { return 0; }
> +static inline int arch_write_notes(void) { return 0; }
> +
> +#define ELF_CORE_EXTRA_NOTES_SIZE arch_notes_size()
> +#define ELF_CORE_WRITE_EXTRA_NOTES arch_write_notes(file)
> +#endif /* ARCH_HAVE_EXTRA_ELF_NOTES */

This is broken for !CELL. arch_write_notes(void) can't be called as
arch_write_notes(file).

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Di0HqZQDpqqiq6j0IZLF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFYpDAdSjSd0sB4dIRAgdWAKDGO7KacnuOyxm4GKOOMRK/BXJi5gCffc3g
ZycW3TG83/VOlWKCUes4GTA=
=osyr
-----END PGP SIGNATURE-----

--=-Di0HqZQDpqqiq6j0IZLF--
