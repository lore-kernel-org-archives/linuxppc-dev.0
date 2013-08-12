Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id E43DF2C00DE
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Aug 2013 14:41:05 +1000 (EST)
Date: Mon, 12 Aug 2013 14:41:00 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] powerpc: Pull out cpu_core_mask updates into a
 separate function
Message-Id: <20130812144100.93446f243b4be405f1a7ac73@canb.auug.org.au>
In-Reply-To: <20130810034530.GD5240@iris.ozlabs.ibm.com>
References: <20130810034530.GD5240@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__12_Aug_2013_14_41_00_+1000_GH7DrjUIuinV2WZg"
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__12_Aug_2013_14_41_00_+1000_GH7DrjUIuinV2WZg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Sat, 10 Aug 2013 13:45:30 +1000 Paul Mackerras <paulus@samba.org> wrote:
>
> This factors out the details of updating cpu_core_mask into a separate
> function, to make it easier to change how the mask is calculated later.
> This makes no functional change.
>=20
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
>  arch/powerpc/kernel/smp.c | 56 +++++++++++++++++++++++------------------=
------
>  1 file changed, 28 insertions(+), 28 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 38b0ba6..663cefd 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -609,11 +609,36 @@ static struct device_node *cpu_to_l2cache(int cpu)
>  	return cache;
>  }
> =20
> +static void traverse_core_siblings(int cpu, int add)

This "add" parameter is only used as a boolean, so should be declared
that way.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__12_Aug_2013_14_41_00_+1000_GH7DrjUIuinV2WZg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSCGdgAAoJEECxmPOUX5FEM54P+gPiv9mH4Xj0MltuBhHR2Prh
F1Ew6k6Bsu05vNqHWlU3rULtolro+NihHq4YMRFMwWClypK46I9uOyJE+2IiTIpi
5Rme50BZGle8GRApdtl1eAxNcO3zcF8vabJpFuDbWoJkgOJJDzN+jUjiF97ECnjV
YC3a7xIVz6icpr3CBH4JpNSgiti1IQI6F74Im8m3C9GycFdVVTKiFgZ4oYo16G6h
NW/6XO4adIdOyHpR9twhsv3TZbuLIbAwh6H5oC1noELHoP2nDyP7l8fWvHzTvKd1
MeneBomXqgqP/51L8WoJl1BMYAf0f+m+jPbXJ2g0k3UJZfM2HW5bj5TJ2jUqW6nx
Dd8btPSY1F6lLs+KX4KEveLb7knVi+EXGKbyp46aMlBVUL+1E42iwL9CDlhDHSpj
Qa0HcdvLahSvV5s+Szu1pVqHrTo76KOz97g8wrAKMXNK2cYzNTMYHLuvE7O/+dnk
Jdnn/o6V7MmLAUe32FehzcebLw6PBrP58ebQhhcypTgfFXRl1EhsidefOTt24YS4
F+NTJeTtpk4rD6D0W0Rv/B88HarlihiNn5Qki8ihmHLdO3wN994ENwqC7r2t1aAQ
nFOJo8SuXYGABgTNKqKnqc0LhJ2Ud8LbUs51rn6IQayyep3OLG2N7PNy9QekUgsy
T1aUnvY+ckyXUcQNju6Y
=oxbM
-----END PGP SIGNATURE-----

--Signature=_Mon__12_Aug_2013_14_41_00_+1000_GH7DrjUIuinV2WZg--
