Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8441CDDDDB
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 14:32:49 +1100 (EST)
Date: Mon, 10 Mar 2008 14:32:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: hs@denx.de
Subject: Re: [Patch] 8xx: MGSUVD support
Message-Id: <20080310143217.11e2b10f.sfr@canb.auug.org.au>
In-Reply-To: <47D3B44D.8070909@denx.de>
References: <47D3B44D.8070909@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__10_Mar_2008_14_32_17_+1100_lujtfCvOA1V0gs.e"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__10_Mar_2008_14_32_17_+1100_lujtfCvOA1V0gs.e
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

Just a few small comments.

On Sun, 09 Mar 2008 10:56:29 +0100 Heiko Schocher <hs@denx.de> wrote:
>
> +++ b/arch/powerpc/platforms/8xx/mgsuvd.c
>
> +#include <asm/of_platform.h>

You should include linux/of_platform.h (not asm/)

> +static struct cpm_pin mgsuvd_pins[] =3D {

Make this __initdata, please.

> +	ROOT_DEV =3D Root_NFS;

I am not sue we do this explicitly any more ... hopefully someone else
will comment.

> +static struct of_device_id __initdata of_bus_ids[] =3D {

Make this __initdata, please.

> +static int __init declare_of_platform_devices(void)
> +{
> +	if (!machine_is(mgsuvd))
> +		return 0;
> +
> +	of_platform_bus_probe(NULL, of_bus_ids, NULL);
> +
> +	return 0;
> +}
> +device_initcall(declare_of_platform_devices);

This should be "machine_device_initcall(mgsuvd,
declare_of_platform_devices);" then you don't need the machine_is() check
above.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__10_Mar_2008_14_32_17_+1100_lujtfCvOA1V0gs.e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH1KvGTgG2atn1QN8RAvAJAJ9lbtkparwNVP+XNiEksQqStcOOpgCcDBTh
5KbEBSXEr+PYLNdIfJcVgSU=
=o8Tj
-----END PGP SIGNATURE-----

--Signature=_Mon__10_Mar_2008_14_32_17_+1100_lujtfCvOA1V0gs.e--
