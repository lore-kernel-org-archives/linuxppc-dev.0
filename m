Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRyLF49TnzDqvN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 14:03:33 +1000 (AEST)
Date: Wed, 9 Aug 2017 14:02:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 08/10] powerpc/xive: take into account
 '/ibm,plat-res-int-priorities'
Message-ID: <20170809040227.GE13670@umbus.fritz.box>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
 <1502182579-990-9-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tMbDGjvJuJijemkf"
In-Reply-To: <1502182579-990-9-git-send-email-clg@kaod.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 10:56:18AM +0200, C=E9dric Le Goater wrote:
> '/ibm,plat-res-int-priorities' contains a list of priorities that the
> hypervisor has reserved for its own use. Scan these ranges to choose
> the lowest unused priority for the xive spapr backend.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/sysdev/xive/spapr.c | 62 ++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 61 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/=
spapr.c
> index 7fc40047c23d..220331986bd8 100644
> --- a/arch/powerpc/sysdev/xive/spapr.c
> +++ b/arch/powerpc/sysdev/xive/spapr.c
> @@ -532,13 +532,70 @@ static const struct xive_ops xive_spapr_ops =3D {
>  	.name			=3D "spapr",
>  };
> =20
> +/*
> + * get max priority from "/ibm,plat-res-int-priorities"
> + */
> +static bool xive_get_max_prio(u8 *max_prio)
> +{
> +	struct device_node *rootdn;
> +	const __be32 *reg;
> +	u32 len;
> +	int prio, found;
> +
> +	rootdn =3D of_find_node_by_path("/");
> +	if (!rootdn) {
> +		pr_err("not root node found !\n");
> +		return false;
> +	}
> +
> +	reg =3D of_get_property(rootdn, "ibm,plat-res-int-priorities", &len);
> +	if (!reg) {
> +		pr_err("Failed to read 'ibm,plat-res-int-priorities' property\n");
> +		return false;
> +	}
> +
> +	if (len % (2 * sizeof(u32)) !=3D 0) {
> +		pr_err("invalid 'ibm,plat-res-int-priorities' property\n");
> +		return false;
> +	}
> +
> +	/* HW supports priorities in the range [0-7] and 0xFF is a
> +	 * wildcard priority used to mask. We scan the ranges reserved
> +	 * by the hypervisor to find the lowest priority we can use.
> +	 */
> +	found =3D 0xFF;
> +	for (prio =3D 0; prio < 8; prio++) {
> +		int reserved =3D 0;
> +		int i;
> +
> +		for (i =3D 0; i < len / (2 * sizeof(u32)); i++) {
> +			int base  =3D be32_to_cpu(reg[2 * i]);
> +			int range =3D be32_to_cpu(reg[2 * i + 1]);
> +
> +			if (prio >=3D base && prio < base + range)
> +				reserved++;
> +		}
> +
> +		if (!reserved)
> +			found =3D prio;

So you continue the loop here, rather than using break.  Which means
found will be the highest valued priority that's not reserved.  Is
that what you intended?  The commit message says you find the lowest
unused, but do lower numbers mean higher priorities or the other way around?

> +	}
> +
> +	if (found =3D=3D 0xFF) {
> +		pr_err("no valid priority found in 'ibm,plat-res-int-priorities'\n");
> +		return false;
> +	}
> +
> +	*max_prio =3D found;
> +	return true;
> +}
> +
>  bool xive_spapr_init(void)
>  {
>  	struct device_node *np;
>  	struct resource r;
>  	void __iomem *tima;
>  	struct property *prop;
> -	u8 max_prio =3D 7;
> +	u8 max_prio;
>  	u32 val;
>  	u32 len;
>  	const __be32 *reg;
> @@ -566,6 +623,9 @@ bool xive_spapr_init(void)
>  		return false;
>  	}
> =20
> +	if (!xive_get_max_prio(&max_prio))
> +		return false;
> +
>  	/* Feed the IRQ number allocator with the ranges given in the DT */
>  	reg =3D of_get_property(np, "ibm,xive-lisn-ranges", &len);
>  	if (!reg) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tMbDGjvJuJijemkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmKiVMACgkQbDjKyiDZ
s5KQGg//dCG84HS4Hg23jTsDqHAUcgeqLMY0b4/s4peK8uJ0ZucDvLLinUA1wkbR
MIIVlqtLEid5w0LLvzMbqM8UKeNSzt8QWEPvWB9gavDTgZiII9zBhsmRuKycL4TP
d0O8E+/TdHA/uIS8klOSblP6Z42xRea7vLqi9OoJDgEHgtD3bomBlLv/GwTcNdJX
MNGLyqkYKKSOYWqKW4165yb+kf/ILHmxGNEJqXLcnA5i7odTrZzzcFVtK65vIW7q
2z80SCZXwqtaiwaLrVhiP8/lBPq2lUGEchJCaS8bpCxLnDJ9vK9w8CKWtFfmc4Kt
TkyYUuzDCneN7iOeDJaOUSZQABEDvka9PplwanNimXyddJqyjj5CVNMhcB3JJgdx
RvYhpPl0mKH+3XyhMXpOfRhJv//67UwFWVCtGs+G4awTH6HamtdTyRwBlHyeQlJf
v4KyCcl/KA8qGhbU5kOM01Qa22B4e+MU8aLJyFgEX9Tewcu5Ya3C6S5jNMmmKjtA
PpE/9Ox8jeNSs8z/swcNHZmnBy9T/D/SF4nnDp80n3ol/QG9BFuAbc+xD0LRd1vi
Ushv4ZQ027lQhYVu4QeMhGgnB6Zwm+5GFsdTbh1JMpFrNIT3gMJUVmj8aoEcFWHD
Pb+SgcGKBqB/ilCBb4hIPWblKdA83EgJTJNXNfJd3LnIbOvw2rs=
=1l0Q
-----END PGP SIGNATURE-----

--tMbDGjvJuJijemkf--
