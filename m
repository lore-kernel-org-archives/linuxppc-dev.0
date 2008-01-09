Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7B421DDF1E
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 13:36:56 +1100 (EST)
Date: Wed, 9 Jan 2008 13:36:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH 3/7] Basic Freescale MPC512x support
Message-Id: <20080109133644.84276ffa.sfr@canb.auug.org.au>
In-Reply-To: <1199808093-15929-4-git-send-email-jrigby@freescale.com>
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__9_Jan_2008_13_36_44_+1100_aA6=K3ix6BwqRp5o"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__9_Jan_2008_13_36_44_+1100_aA6=K3ix6BwqRp5o
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue,  8 Jan 2008 09:01:29 -0700 John Rigby <jrigby@freescale.com> wrote:
>
> +++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
> +#include <asm/of_platform.h>

I see I don't need to comment on this :-)

> +static void __init mpc5121_ads_init_IRQ(void)
> +{
> +	struct device_node *np;
> +
> +	np =3D of_find_node_by_type(NULL, "ipic");
> +	if (!np)
> +		return;
> +
> +	ipic_init(np, 0);
> +
> +	/*
> +	 * Initialize the default interrupt mapping priorities,
> +	 * in case the boot rom changed something on us.
> +	 */
> +	ipic_set_default_priority();
> +}

This needs an of_node_put(np) somewhere.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__9_Jan_2008_13_36_44_+1100_aA6=K3ix6BwqRp5o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhDNBTgG2atn1QN8RAhwjAJ4nrgo2NyPYYp0Ue7E8128pUV9hlQCdF8dH
iz0pWA5RRpjZJ1YEFUwoK3w=
=5ctH
-----END PGP SIGNATURE-----

--Signature=_Wed__9_Jan_2008_13_36_44_+1100_aA6=K3ix6BwqRp5o--
