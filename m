Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 80F92DDDDB
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 19:18:28 +1100 (EST)
Date: Sun, 23 Dec 2007 19:18:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH/RFC] powerpc: DBox2 Board Support
Message-Id: <20071223191819.cb4f8119.sfr@canb.auug.org.au>
In-Reply-To: <476D61DB.2090201@scram.de>
References: <476D61DB.2090201@scram.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__23_Dec_2007_19_18_19_+1100_r5GqPDbWqmFSKbZ."
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__23_Dec_2007_19_18_19_+1100_r5GqPDbWqmFSKbZ.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 22 Dec 2007 20:13:31 +0100 Jochen Friedrich <jochen@scram.de> wrote:
>
> +++ b/arch/powerpc/platforms/8xx/dbox2.h
> +
> +#include <sysdev/fsl_soc.h>

Nothing in this header files uses anything in that one, so don't include
it.

> +++ b/arch/powerpc/platforms/8xx/dbox2_setup.c
> +
> +char *dbox2_manuf_name[3] =3D {

static const.

> +	"Nokia",
> +	"Philips",
> +	"Sagem",
> +};
> +
> +static enum dbox2_mid dbox2_manuf_id;
> +
> +struct cpm_pin {
> +	int port, pin, flags;
> +};
> +
> +static struct cpm_pin dbox2_pins[] =3D {

const?

> +static int __init dbox2_probe(void)
> +{
> +	unsigned long root =3D of_get_flat_dt_root();
> +	return of_flat_dt_is_compatible(root, "betaresearch,dbox2");

You should include asm/prom.h to use the flattened device tree function.

> +static struct of_device_id __initdata of_bus_ids[] =3D {

__initdata

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__23_Dec_2007_19_18_19_+1100_r5GqPDbWqmFSKbZ.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHbhnQTgG2atn1QN8RAuY6AJ9bt0uHOMpEMqGtTynERjylswhtNwCePSrV
ZAx58DyElhqHSrSH2Xe2+AQ=
=iTj2
-----END PGP SIGNATURE-----

--Signature=_Sun__23_Dec_2007_19_18_19_+1100_r5GqPDbWqmFSKbZ.--
