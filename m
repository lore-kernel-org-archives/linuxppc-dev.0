Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 004EFDDEDA
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 00:41:26 +1100 (EST)
Date: Tue, 5 Feb 2008 00:41:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 7/9] powerpc: add MPC837x RDB platform support
Message-Id: <20080205004119.fb37d472.sfr@canb.auug.org.au>
In-Reply-To: <20080124204711.02ba14f0.kim.phillips@freescale.com>
References: <20080124204711.02ba14f0.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__5_Feb_2008_00_41_19_+1100_hHRfwQkM+HF7UA6C"
Cc: linuxppc-dev@ozlabs.org, D'Abbraccio <ljd015@freescale.com>, Joe
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__5_Feb_2008_00_41_19_+1100_hHRfwQkM+HF7UA6C
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kim,

Again, a bit late but a couple of comments.

On Thu, 24 Jan 2008 20:47:11 -0600 Kim Phillips <kim.phillips@freescale.com=
> wrote:
>
> +static struct of_device_id mpc837x_ids[] =3D {

Make this __initdata, please.

> +static void __init mpc837x_rdb_init_IRQ(void)
> +{
> +	struct device_node *np;
> +
> +	np =3D of_find_compatible_node(NULL, NULL, "fsl,ipic");
> +	if (!np)
> +		return;
> +
> +	ipic_init(np, 0);

You need an of_node_put(np) here.

> +static int __init mpc837x_rdb_probe(void)
> +{
> +	unsigned long root =3D of_get_flat_dt_root();
> +
> +	return of_flat_dt_is_compatible(root, "fsl,mpc8377rdb") ||
> +	       of_flat_dt_is_compatible(root, "fsl,mpc8378rdb") ||
> +	       of_flat_dt_is_compatible(root, "fsl,mpc8379rdb");

You need to include asm/prom.h to use the flattened device tree accessors.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__5_Feb_2008_00_41_19_+1100_hHRfwQkM+HF7UA6C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHpxYGTgG2atn1QN8RAkZhAJ40URnO2XyJh8guBCYTjKNoWSPbHQCgkdyy
17K1JCC+dzYzYK5Uk8Qjtzc=
=QKN0
-----END PGP SIGNATURE-----

--Signature=_Tue__5_Feb_2008_00_41_19_+1100_hHRfwQkM+HF7UA6C--
