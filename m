Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: New cpu type shows up as "unknown" even when
	logical PVR is recognized
From: Michael Ellerman <michael@ellerman.id.au>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
In-Reply-To: <1234557928.10378.8.camel@norville.austin.ibm.com>
References: <1234557928.10378.8.camel@norville.austin.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-+eQ6V9WMj2Zo+9T5PS6z"
Date: Sun, 15 Feb 2009 01:00:07 +1100
Message-Id: <1234620007.10265.7.camel@localhost>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-+eQ6V9WMj2Zo+9T5PS6z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-02-13 at 14:45 -0600, Dave Kleikamp wrote:
> When identify_cpu() is called a second time with a logical PVR, it only
> copies a subset of the cpu_spec structure to avoid overwriting the
> performance monitor fields that were initialized based on the real PVR.
>=20
> If the real PVR is not recognized, the structure is initialized with
> default data in which the pvr_mask field is zero.  Overriding the default
> definition with the one based on the logical PVR does not update the
> pvr_mask field.  Since the pvr_mask field remains zero, show_cpuinfo()
> reports the cpu as "unknown".
>=20
> identify_cpu() should update the pvr_mask, so that show_cpuinfo() reports
> the logical cpu name, as it would if the kernel recognized the real PVR.
>=20
> For completeness, this patch also updates pvr_value, although its only
> use appears to be in booke_wdt_init() setting ident.firmware_version.  I'=
m
> not sure which value (the real or logical) is the most useful here, if it
> matters at all.
>=20
> Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
>=20
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputabl=
e.c
> index 923f87a..a216fad 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -1780,6 +1780,8 @@ struct cpu_spec * __init identify_cpu(unsigned long=
 offset, unsigned int pvr)
>  			 * performance monitor fields.
>  			 */
>  			if (t->num_pmcs && !s->num_pmcs) {
> +				t->pvr_mask =3D s->pvr_mask;
> +				t->pvr_value =3D s->pvr_value;
>  				t->cpu_name =3D s->cpu_name;
>  				t->cpu_features =3D s->cpu_features;
>  				t->cpu_user_features =3D s->cpu_user_features;

Seems like we'd be better off copying the whole structure, and then
putting back the performance monitor fields. So we don't end up with
another bug if something's added to struct cpu_spec.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-+eQ6V9WMj2Zo+9T5PS6z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmWzmcACgkQdSjSd0sB4dLE3QCfWH51MbAvTuneJbP+HGIZmZ8y
1nQAn110PoPFd7Q79J3JW2WuJVB+DNAQ
=1sNU
-----END PGP SIGNATURE-----

--=-+eQ6V9WMj2Zo+9T5PS6z--
