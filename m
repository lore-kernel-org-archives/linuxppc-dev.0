Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5DADDDDEE9
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Mar 2008 10:26:51 +1100 (EST)
Date: Sat, 15 Mar 2008 10:25:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: hs@denx.de
Subject: Re: [PATCH v2] 8xx: Add support for the MPC852 based board from
	keymile.
Message-Id: <20080315102508.bc698a90.sfr@canb.auug.org.au>
In-Reply-To: <47DA444E.9050507@denx.de>
References: <47DA444E.9050507@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__15_Mar_2008_10_25_08_+1100_mE8vUIYQ2O5e0L+9"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__15_Mar_2008_10_25_08_+1100_mE8vUIYQ2O5e0L+9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

On Fri, 14 Mar 2008 10:24:30 +0100 Heiko Schocher <hs@denx.de> wrote:
>
> This add support of the mgsuvd board from keymile to
> arch/powerpc. Supported SMC1 (serial console),
> SCC3 Ethernet (10Mbps hdx)

Paul would probably like some description of the board here.

> +++ b/arch/powerpc/platforms/8xx/mgsuvd.c
>
> +extern void cpm_reset(void);

This declaration is in asm/cpm1.h

> +struct cpm_pin {
> +		int port, pin, flags;
> +};

I wish someone would consolidate all these definitions of cpm_pin.

> +static void __init init_ioports(void)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(mgsuvd_pins); i++) {
> +		struct cpm_pin *pin =3D &mgsuvd_pins[i];
> +		cpm1_set_pin(pin->port, pin->pin, pin->flags);
> +	}

And the code that uses them ...

> +static void __init mgsuvd_setup_arch(void)
> +{
> +	struct device_node *cpu;
> +
> +	cpu =3D of_find_node_by_type(NULL, "cpu");
> +	if (cpu !=3D 0) {

"cpu" is a pointer, so "cpu !=3D NULL" or just "cpu"

> +		const unsigned int *fp;
> +
> +		fp =3D of_get_property(cpu, "clock-frequency", NULL);
> +		if (fp !=3D 0)

Ditto for "fp" test

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__15_Mar_2008_10_25_08_+1100_mE8vUIYQ2O5e0L+9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH2wlZTgG2atn1QN8RAq8rAJ9t2XC1R3pud9ZVupQEeVhThChk9ACdEHaG
YvQX27Wdp+92UmA0zntNgdo=
=iVMv
-----END PGP SIGNATURE-----

--Signature=_Sat__15_Mar_2008_10_25_08_+1100_mE8vUIYQ2O5e0L+9--
