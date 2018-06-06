Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410r9P3SyGzF1wr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2018 11:06:49 +1000 (AEST)
Date: Wed, 6 Jun 2018 11:06:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH QEMU] osdep: powerpc64 align memory to allow 2MB radix
 THP page tables
Message-ID: <20180606010615.GE17757@umbus.fritz.box>
References: <20180506072949.12783-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
In-Reply-To: <20180506072949.12783-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--brEuL7wsLY8+TuWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2018 at 05:29:49PM +1000, Nicholas Piggin wrote:
> This allows KVM with the Book3S radix MMU mode to take advantage of
> THP and install larger pages in the partition scope page tables (the
> host translation).
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

I've applied this to my ppc-for-3.0 tree.  It's not strictly within
the code I maintain, but since it only affects ppc, it seems
reasonable to go through my tree.

> ---
>  include/qemu/osdep.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 41658060a7..5910682221 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -357,7 +357,8 @@ void qemu_anon_ram_free(void *ptr, size_t size);
>  #endif
> =20
>  #if defined(__linux__) && \
> -    (defined(__x86_64__) || defined(__arm__) || defined(__aarch64__))
> +    (defined(__x86_64__) || defined(__arm__) || defined(__aarch64__) \
> +     || defined(__powerpc64__))
>     /* Use 2 MiB alignment so transparent hugepages can be used by KVM.
>        Valgrind does not support alignments larger than 1 MiB,
>        therefore we need special code which handles running on Valgrind. =
*/

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsXM4cACgkQbDjKyiDZ
s5LgxxAA3/kc3un9Gylx4Zke7JyldmZg8AbJET8FXSBSHnaBzs90rjT6RFfpJlvm
BzJz8RZjFozH5tu5o+0YRc1WUvLCpyNYBIkSoATc2eM4RsVrmMn6PEySdhRBuIdo
t/4Uj/QWtg3Qp6azosRVkFzE8pLJrudF/IDa+e1KC32PmyUvaufiCsbHytePQ1pI
JHQSfJl+iL2bI8HxJrPxzY8xtwi2+bI+R77U0GRFQqwCVfuuo34cosL9TTDhq6qw
XIfT12qHAN+RyfYExyiKH1sdCfBFfwprJXb7qysyfyxiOCdjxKkbEyoSgJwac4aB
hRBIJSV2bd7iRq0XeLodKAeypVZgM5IQQhKuqdP3tW8RPs2STlhr1Ky61/eWI40v
GSNg3i8JeMKxjBbAQBdlaWR2bz69KJR89sRDQUx46AZDDE9o00hx1Fv4/WdDK5ZO
484vTZ5Y+5rXSiQAZTHobDVaRumJ4aHkHGQS22lbJB4PrZDBgLYf/+tkO1X56RRa
b4LpIXZ0i/HaNP/giFMxVFtXzm0ruVDHqJuJxhflW/z6Jvf2l3CprZvNlmteqS/h
bTOm7g43qpX+su3r1kctseL/4Zncujryjhrr6+r27SuIGQ6C6ArOx9qy9do0O/xI
Jgn4B/W9rzRdW6YruLYMJbRtChKv+0DsMDaDLSku4hNm2T8/U14=
=Yz/P
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--
