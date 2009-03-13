Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 4/9] powerpc/mm: Tweak PTE bit combination definitions (v2)
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090311035335.5899BDE1A6@ozlabs.org>
References: <20090311035335.5899BDE1A6@ozlabs.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-s73eQT8NWoephu0xP7YD"
Date: Fri, 13 Mar 2009 14:44:27 +1100
Message-Id: <1236915867.10992.6.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-s73eQT8NWoephu0xP7YD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-03-11 at 14:53 +1100, Benjamin Herrenschmidt wrote:
> This patch tweaks the way some PTE bit combinations are defined, in such =
a
> way that the 32 and 64-bit variant become almost identical and that will
> make it easier to bring in a new common pte-* file for the new variant
> of the Book3-E support.
>=20
<snip>
> +/* Permission masks used to generate the __P and __S table,
> + *
> + * Note:__pgprot is defined in arch/powerpc/include/asm/page.h
> + */
> +#define PAGE_NONE	__pgprot(_PAGE_BASE)
> +#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
> +#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | _PAG=
E_EXEC)
>  #define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER)
>  #define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
>  #define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
>  #define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
> -#define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_WRENABLE)
> -#define PAGE_KERNEL_CI	__pgprot(_PAGE_PRESENT | _PAGE_ACCESSED | \
> -			       _PAGE_WRENABLE | _PAGE_NO_CACHE | _PAGE_GUARDED)
> -#define PAGE_KERNEL_EXEC __pgprot(_PAGE_BASE | _PAGE_WRENABLE | _PAGE_EX=
EC)

Generic code needs PAGE_KERNEL_EXEC:

mm/vmalloc.c:

#ifndef PAGE_KERNEL_EXEC
# define PAGE_KERNEL_EXEC PAGE_KERNEL
#endif


Not having it breaks modules because we don't map the text executable.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-s73eQT8NWoephu0xP7YD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkm51psACgkQdSjSd0sB4dIWtACfQD49Em98I3b9zyXMw3k5VM4v
+OIAoIBZccaahimNE+TwPyqooMZ5pmeQ
=KHsg
-----END PGP SIGNATURE-----

--=-s73eQT8NWoephu0xP7YD--
