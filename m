Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C22F3DDEE7
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 20:38:58 +1100 (EST)
Date: Mon, 13 Oct 2008 20:38:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Martyn Welch <martyn.welch@gefanuc.com>
Subject: Re: [PATCH v2] powerpc: FPGA support for GE Fanuc SBC610
Message-Id: <20081013203850.9b600bd9.sfr@canb.auug.org.au>
In-Reply-To: <20081013085202.15525.75859.stgit@ubuntu8041.localdomain>
References: <20081013085202.15525.75859.stgit@ubuntu8041.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__13_Oct_2008_20_38_50_+1100_vI4kds_x_yiWLcMw"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__13_Oct_2008_20_38_50_+1100_vI4kds_x_yiWLcMw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Martyn,

On Mon, 13 Oct 2008 09:53:49 +0100 Martyn Welch <martyn.welch@gefanuc.com> =
wrote:
>
> --- a/arch/powerpc/platforms/86xx/gef_sbc610.c
> +++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
> @@ -73,6 +73,7 @@ static void __init gef_sbc610_init_irq(void)
> =20
>  static void __init gef_sbc610_setup_arch(void)
>  {
> +	struct device_node *regs;
>  #ifdef CONFIG_PCI
>  	struct device_node *np;
> =20
> @@ -86,8 +87,42 @@ static void __init gef_sbc610_setup_arch(void)
>  #ifdef CONFIG_SMP
>  	mpc86xx_smp_init();
>  #endif
> +
> +	/* Remap basic board registers */
> +	regs =3D of_find_compatible_node(NULL, NULL, "gef,fpga-regs");
> +	if (regs) {
> +		sbc610_regs =3D of_iomap(regs, 0);
> +		if (sbc610_regs =3D=3D NULL)
> +			printk(KERN_WARNING "Unable to map board registers\n");

You need an of_node_put(regs) here.

> +	}
> +}
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__13_Oct_2008_20_38_50_+1100_vI4kds_x_yiWLcMw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjzFyoACgkQjjKRsyhoI8xS+gCdHjDQN6oWwYSP6zS0KVPWk0gi
VGUAmwSxsfqavHzGhX50BML/Wkr/w9FK
=2Ykh
-----END PGP SIGNATURE-----

--Signature=_Mon__13_Oct_2008_20_38_50_+1100_vI4kds_x_yiWLcMw--
