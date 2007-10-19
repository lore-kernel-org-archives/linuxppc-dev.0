Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CCCD6DDE1D
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 10:43:37 +1000 (EST)
Date: Fri, 19 Oct 2007 10:43:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v6 4/9] add platform support for MPC837x MDS board
Message-Id: <20071019104318.edfd2ad1.sfr@canb.auug.org.au>
In-Reply-To: <1192719847-25045-4-git-send-email-leoli@freescale.com>
References: <1192719847-25045-1-git-send-email-leoli@freescale.com>
	<1192719847-25045-2-git-send-email-leoli@freescale.com>
	<1192719847-25045-3-git-send-email-leoli@freescale.com>
	<1192719847-25045-4-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__19_Oct_2007_10_43_18_+1000_GXjVIWnIPm84y+HG"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__19_Oct_2007_10_43_18_+1000_GXjVIWnIPm84y+HG
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Oct 2007 23:04:02 +0800 Li Yang <leoli@freescale.com> wrote:
>
> +++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
> +static void __init mpc837x_mds_setup_arch(void)
> +{
> +#ifdef CONFIG_PCI
> +	struct device_node *np;
> +#endif
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("mpc837x_mds_setup_arch()", 0);
> +
> +#ifdef CONFIG_PCI
> +	for (np =3D NULL; (np =3D of_find_node_by_type(np, "pci")) !=3D NULL;)

	for_each_node_by_type(np, "pci")

> +static int __init mpc837x_mds_probe(void)
> +{
> +        unsigned long root =3D of_get_flat_dt_root();
> +
> +        return of_flat_dt_is_compatible(root, "fsl,mpc837xmds");

To call these two routines, you should include <asm/prom.h> directly.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__19_Oct_2007_10_43_18_+1000_GXjVIWnIPm84y+HG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHF/2rTgG2atn1QN8RAlh3AJ0TgxqAXGHmNwdlbh15pvpKrtXeHACfdkuI
z0boBw2E3Eull7YZUvXGXr4=
=Ed0C
-----END PGP SIGNATURE-----

--Signature=_Fri__19_Oct_2007_10_43_18_+1000_GXjVIWnIPm84y+HG--
