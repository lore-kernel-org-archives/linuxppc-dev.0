Return-Path: <B37781@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 16801B7004
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 18:19:45 +1100 (EST)
Subject: Re: [SDK v1.2][PATCH 2/2 v3] powerpc/85xx: Added P1021RDB-PC
 Platform support
From: Xu Jiucheng <B37781@freescale.com>
To: <galak@kernel.crashing.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
In-Reply-To: <1326092022-10085-2-git-send-email-B37781@freescale.com>
References: <1326092022-10085-1-git-send-email-B37781@freescale.com>
 <1326092022-10085-2-git-send-email-B37781@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Jan 2012 15:23:55 +0800
Message-ID: <1326180235.1895.13.camel@xujc-desktop>
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm sorry, please ignore this email.

Thanks & Best Regards=20
Jiucheng

=E5=9C=A8 2012-01-09Mon=E7=9A=84 14:53 +0800=EF=BC=8CXu Jiucheng=E5=86=99=
=E9=81=93=EF=BC=9A
> Signed-off-by: Xu Jiucheng <B37781@freescale.com>
> ---
>  arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   25 +++++++++++++++++++++=
++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/p=
latforms/85xx/mpc85xx_rdb.c
> index 9feccbb..0c32668 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> @@ -113,6 +113,7 @@ static void __init mpc85xx_rdb_setup_arch(void)
> =20
>  machine_device_initcall(p2020_rdb, mpc85xx_common_publish_devices);
>  machine_device_initcall(p1020_rdb, mpc85xx_common_publish_devices);
> +machine_device_initcall(p1021_rdb_pc, mpc85xx_common_publish_devices);
> =20
>  /*
>   * Called very early, device-tree isn't unflattened
> @@ -135,6 +136,15 @@ static int __init p1020_rdb_probe(void)
>  	return 0;
>  }
> =20
> +static int __init p1021_rdb_pc_probe(void)
> +{
> +	unsigned long root =3D of_get_flat_dt_root();
> +
> +	if (of_flat_dt_is_compatible(root, "fsl,P1021RDB-PC"))
> +		return 1;
> +	return 0;
> +}
> +
>  define_machine(p2020_rdb) {
>  	.name			=3D "P2020 RDB",
>  	.probe			=3D p2020_rdb_probe,
> @@ -162,3 +172,18 @@ define_machine(p1020_rdb) {
>  	.calibrate_decr		=3D generic_calibrate_decr,
>  	.progress		=3D udbg_progress,
>  };
> +
> +define_machine(p1021_rdb_pc) {
> +	.name			=3D "P1021 RDB-PC",
> +	.probe			=3D p1021_rdb_pc_probe,
> +	.setup_arch		=3D mpc85xx_rdb_setup_arch,
> +	.init_IRQ		=3D mpc85xx_rdb_pic_init,
> +#ifdef CONFIG_PCI
> +	.pcibios_fixup_bus	=3D fsl_pcibios_fixup_bus,
> +#endif
> +	.get_irq		=3D mpic_get_irq,
> +	.restart		=3D fsl_rstcr_restart,
> +	.calibrate_decr		=3D generic_calibrate_decr,
> +	.progress		=3D udbg_progress,
> +};
> +
