Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH kexec-tools 1/5] ppc64: always check number of ranges
	when adding
From: Michael Ellerman <michael@ellerman.id.au>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <kexec-29-1-1r.miltonm@bga.com>
References: <kexec-29-1-1r.miltonm@bga.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-PLiU4TOASLxTQCgToQjz"
Date: Wed, 07 Jan 2009 13:42:52 +1100
Message-Id: <1231296172.8292.20.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>,
	kexec@lists.infradead.org, "M.MohanK" <"umar mohan"@in.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-PLiU4TOASLxTQCgToQjz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-01-02 at 15:04 -0600, Milton Miller wrote:
> make the idom "always call realloc_memory_ranges when filling a range ent=
ry"
>=20
> kexec was core dumping after using 5 exclude_range pairs when only 3
> were allocated.
>=20
> also delcare realloc_memory_ranges to take no arguments.
>=20
> Signed-off-by: Milton Miller <miltonm@bga.com>
>=20
> Index: kexec-tools/kexec/arch/ppc64/kexec-ppc64.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- kexec-tools.orig/kexec/arch/ppc64/kexec-ppc64.c	2009-01-02 02:08:58.0=
00000000 -0600
> +++ kexec-tools/kexec/arch/ppc64/kexec-ppc64.c	2009-01-02 02:09:08.000000=
000 -0600
> @@ -96,7 +96,7 @@ err1:
> =20
>  }
> =20
> -static int realloc_memory_ranges()
> +static int realloc_memory_ranges(void)
>  {
>  	size_t memory_range_len;
> =20
> @@ -469,6 +469,8 @@ static int get_devtree_details(unsigned=20
>  				exclude_range[i].start =3D initrd_start;
>  				exclude_range[i].end =3D initrd_end;
>  				i++;
> +				if (i >=3D max_memory_ranges)
> +					realloc_memory_ranges();
>  			}
>  		} /* chosen */
> =20
> @@ -581,6 +583,8 @@ static int get_devtree_details(unsigned=20
>  			exclude_range[i].start =3D tce_base;
>  			exclude_range[i].end =3D tce_base + tce_size;
>  			i++;
> +			if (i >=3D max_memory_ranges)
> +				realloc_memory_ranges();
>  			if (kexec_flags & KEXEC_ON_CRASH)
>  				add_usable_mem_rgns(tce_base, tce_size);
>  			closedir(cdir);
> @@ -634,6 +638,8 @@ int setup_memory_ranges(unsigned long ke
>  				memory_range[j].end =3D exclude_range[i].start - 1;
>  				memory_range[j].type =3D RANGE_RAM;
>  				j++;
> +				if (j >=3D max_memory_ranges)
> +					realloc_memory_ranges();
>  			}
>  		} /* i =3D=3D 0 */
>  		/* If the last exclude range does not end at memory_max, include
> @@ -646,6 +652,8 @@ int setup_memory_ranges(unsigned long ke
>  				memory_range[j].end =3D memory_max;
>  				memory_range[j].type =3D RANGE_RAM;
>  				j++;
> +				if (j >=3D max_memory_ranges)
> +					realloc_memory_ranges();
>  				/* Limit the end to rmo_top */
>  				if (memory_range[j-1].start >=3D rmo_top) {
>  					j--;
> @@ -666,6 +674,8 @@ int setup_memory_ranges(unsigned long ke
>  		memory_range[j].end =3D exclude_range[i+1].start - 1;
>  		memory_range[j].type =3D RANGE_RAM;
>  		j++;
> +		if (i >=3D max_memory_ranges)
> +			realloc_memory_ranges();

Should this be checking against i or j?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-PLiU4TOASLxTQCgToQjz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklkFqwACgkQdSjSd0sB4dKQ/gCeL4FdWYqyFpzcPTAEN170P12+
wbEAoJAW51XjL0TzwoPxS6zl1PngcER/
=KWAW
-----END PGP SIGNATURE-----

--=-PLiU4TOASLxTQCgToQjz--
