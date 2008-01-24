Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7A335DDE02
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 13:22:10 +1100 (EST)
Date: Thu, 24 Jan 2008 13:22:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] [POWERPC] MPC8360E-RDK: device tree, board file and
	defconfig
Message-Id: <20080124132201.c3086756.sfr@canb.auug.org.au>
In-Reply-To: <20080123204507.GA12973@localhost.localdomain>
References: <20080123204507.GA12973@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__24_Jan_2008_13_22_01_+1100_TZA=5qBsZ9LVumt_"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__24_Jan_2008_13_22_01_+1100_TZA=5qBsZ9LVumt_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Jan 2008 23:45:07 +0300 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> +++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
> +static int __init mpc836x_rdk_declare_of_platform_devices(void)
> +{
> +	const struct of_device_id mpc836x_rdk_ids[] =3D {

Please change this to static, __initdata and not const, thanks.  These
arrays are usually defined outside a function, but that is not really a
problem.

> +static void __init mpc836x_rdk_setup_arch(void)
> +{
> +	struct device_node *np;

!defined(CONFIG_PCI) && !defined(CONFIG_QUICC_ENGINE) will produce a
warning here.

> +	if (ppc_md.progress)
> +		ppc_md.progress("mpc836x_rdk_setup_arch()", 0);
> +
> +#ifdef CONFIG_PCI
> +	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
> +		mpc83xx_add_bridge(np);
> +#endif
> +
> +#ifdef CONFIG_QUICC_ENGINE
> +	qe_reset();
> +
> +	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-pario");
> +	if (!np) {
> +		pr_warning("QE PIO not initialized!\n");
> +		return;

You need an of_node_put(np) before the return.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__24_Jan_2008_13_22_01_+1100_TZA=5qBsZ9LVumt_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHl/ZNTgG2atn1QN8RAmp9AJ470ZvpD3RD6TKKVOGMES2C7cRjBACfbPg2
01qzJIyOBxyFy/QFUHCnjB8=
=kYXN
-----END PGP SIGNATURE-----

--Signature=_Thu__24_Jan_2008_13_22_01_+1100_TZA=5qBsZ9LVumt_--
