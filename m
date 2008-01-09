Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 44C4ADDF16
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 18:01:16 +1100 (EST)
Date: Wed, 9 Jan 2008 18:01:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 1/3] sbc834x: Add support for Wind River SBC834x boards
Message-Id: <20080109180105.7c745bde.sfr@canb.auug.org.au>
In-Reply-To: <1199857773848-git-send-email-paul.gortmaker@windriver.com>
References: <11998577723665-git-send-email-paul.gortmaker@windriver.com>
	<1199857773848-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__9_Jan_2008_18_01_05_+1100_T4dRwAZgb4C1hCLK"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__9_Jan_2008_18_01_05_+1100_T4dRwAZgb4C1hCLK
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Wed,  9 Jan 2008 00:49:30 -0500 Paul Gortmaker <paul.gortmaker@windriver=
.com> wrote:
>
> +static void __init sbc834x_init_IRQ(void)
> +{
> +	struct device_node *np;
> +
> +	np =3D of_find_node_by_type(NULL, "ipic");
> +	if (!np)
> +		return;
> +
> +	ipic_init(np, 0);
> +
> +	/* Initialize the default interrupt mapping priorities,
> +	 * in case the boot rom changed something on us.
> +	 */
> +	ipic_set_default_priority();
> +}

This needs an of_node_put(np) somewhere.

> +static struct of_device_id sbc834x_ids[] =3D {

__initdata

> +static int __init sbc834x_declare_of_platform_devices(void)
> +{
> +	if (!machine_is(sbc834x))
> +		return 0;
> +
> +	of_platform_bus_probe(NULL, sbc834x_ids, NULL);
> +	return 0;
> +}
> +device_initcall(sbc834x_declare_of_platform_devices);

machine_device_initcall(sbc834x, ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__9_Jan_2008_18_01_05_+1100_T4dRwAZgb4C1hCLK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhHE1TgG2atn1QN8RAlycAJ9PRVHMUKn+whMb0yRmAiWuZmU9rgCggJDV
dKeJNQyV8kTm+XCXmGLkHXU=
=11MM
-----END PGP SIGNATURE-----

--Signature=_Wed__9_Jan_2008_18_01_05_+1100_T4dRwAZgb4C1hCLK--
