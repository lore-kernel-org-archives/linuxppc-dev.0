Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 51DFCDDE25
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 11:31:04 +1100 (EST)
Date: Tue, 11 Dec 2007 11:30:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
Message-Id: <20071211113027.bee17bc0.sfr@canb.auug.org.au>
In-Reply-To: <20071210202934.GA32046@localhost.localdomain>
References: <20071210202934.GA32046@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__11_Dec_2007_11_30_27_+1100_I=aB5PE5giAb/VUR"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__11_Dec_2007_11_30_27_+1100_I=aB5PE5giAb/VUR
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Dec 2007 23:29:34 +0300 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> +++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
> +
> +static void __init mpc836x_rdk_setup_arch(void)
> +{
> +	struct device_node *np;
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("mpc836x_rdk_setup_arch()", 0);
> +
> +#ifdef CONFIG_QUICC_ENGINE
> +	qe_reset();
> +
> +	np =3D of_find_node_by_name(NULL, "par_io");
> +	if (np)
> +		par_io_init(np);
> +	else
> +		pr_warning("QE PIO not initialized!\n");

of_node_put(np); ?

> +static int __init mpc836x_rdk_probe(void)
> +{
> +	unsigned long root =3D of_get_flat_dt_root();
> +
> +	return of_flat_dt_is_compatible(root, "MPC836xRDK");

You need to include asm/prom.h to use the flattened device tree accessors.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__11_Dec_2007_11_30_27_+1100_I=aB5PE5giAb/VUR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHXdooTgG2atn1QN8RAjvgAKCEJWjvy398579TUXWqNasM4CJSSgCaA6O3
E5456y+amQ7rqALPXw9jY00=
=yqaC
-----END PGP SIGNATURE-----

--Signature=_Tue__11_Dec_2007_11_30_27_+1100_I=aB5PE5giAb/VUR--
