Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4FE15DDED9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 10:32:53 +1100 (EST)
Date: Tue, 12 Feb 2008 10:32:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Jiang <djiang@mvista.com>
Subject: Re: [PATCH 2/2] powerpc: create mpc85xx pci err platform device for
	EDAC
Message-Id: <20080212103243.fe970150.sfr@canb.auug.org.au>
In-Reply-To: <20080211203445.GB5331@blade.az.mvista.com>
References: <20080211203445.GB5331@blade.az.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__12_Feb_2008_10_32_43_+1100_iEdN8ksJ9XdwS.cD"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__12_Feb_2008_10_32_43_+1100_iEdN8ksJ9XdwS.cD
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Mon, 11 Feb 2008 13:34:45 -0700 Dave Jiang <djiang@mvista.com> wrote:
>
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> +static int __init mpc85xx_pcierr_setup(void)
> +{
> +	struct device_node *np =3D NULL;

You don't need to initialiase this as it is first used in
for_each_compatible_node().

> +	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci") {

> +		of_dev =3D of_find_device_by_node(np);
> +		if (!of_dev)
> +			return -ENODEV;

You need an of_node_put(np) before you return.

> +		pdev =3D platform_device_alloc("mpc85xx_pci_err", id++);
> +		if (!pdev)
> +			return -ENOMEM;

And again.

> +	}
> +	return 0;
> +
> +error:
> +	platform_device_put(pdev);

You need an of_node_put(np) here.

> +	return err;
> +}
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__12_Feb_2008_10_32_43_+1100_iEdN8ksJ9XdwS.cD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHsNskTgG2atn1QN8RAotnAKCFJjOO4ob1HQbgiVik6IueV7r++ACeMURS
f+V3vl19vTBrv4n5nOdwb5Y=
=Ldyf
-----END PGP SIGNATURE-----

--Signature=_Tue__12_Feb_2008_10_32_43_+1100_iEdN8ksJ9XdwS.cD--
