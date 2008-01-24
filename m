Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EA5D2DDDF7
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 11:50:33 +1100 (EST)
Date: Thu, 24 Jan 2008 11:50:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 3/4 v4] POWERPC: Add initial iomega StorCenter board port.
Message-Id: <20080124115018.69551acf.sfr@canb.auug.org.au>
In-Reply-To: <E1JHkYk-00010g-M2@jdl.com>
References: <E1JHkYk-00010g-M2@jdl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__24_Jan_2008_11_50_18_+1100_EjLBUqgGLuc+Ji_1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__24_Jan_2008_11_50_18_+1100_EjLBUqgGLuc+Ji_1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Wed, 23 Jan 2008 12:42:50 -0600 Jon Loeliger <jdl@jdl.com> wrote:
>
> +++ b/arch/powerpc/platforms/embedded6xx/storcenter.c
> +static void __init storcenter_init_IRQ(void)
> +{
> +	struct mpic *mpic;
> +	struct device_node *dnp;
> +	const void *prop;
> +	int size;
> +	phys_addr_t paddr;
> +
> +	dnp =3D of_find_node_by_type(NULL, "open-pic");
> +	if (dnp =3D=3D NULL)
> +		return;
> +
> +	prop =3D of_get_property(dnp, "reg", &size);
> +	if (prop =3D=3D NULL)
> +		return;

You need an of_node_put(dnp) before you return.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__24_Jan_2008_11_50_18_+1100_EjLBUqgGLuc+Ji_1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHl+DRTgG2atn1QN8RAoeCAJsHKAq3ZjHNkPzeEdUXAyRSzw0cSQCeI5P/
+MqoNtC2HNu9+CqmsMwNMFU=
=i1Tb
-----END PGP SIGNATURE-----

--Signature=_Thu__24_Jan_2008_11_50_18_+1100_EjLBUqgGLuc+Ji_1--
