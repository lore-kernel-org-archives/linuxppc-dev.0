Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2504AB6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jul 2011 00:00:34 +1000 (EST)
Subject: Re: [PATCH 10/14] 85xx/mpc85xx_rdb: merge p1020_rdb and p2020_rdb
	machine entries
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1311065631-3429-11-git-send-email-dbaryshkov@gmail.com>
Date: Tue, 19 Jul 2011 09:00:21 -0500
Message-Id: <276D152E-9A93-448C-BB1B-D749697FF4F0@kernel.crashing.org>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
	<1311065631-3429-11-git-send-email-dbaryshkov@gmail.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 19, 2011, at 3:53 AM, Dmitry Eremin-Solenikov wrote:

> p1020_rdb and p2020_rdb machine entries bear no in-kernel differencies
> other than dt compatible strings. Merge them into single machine entry
> named mpc85xx_rdb
>=20
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   40 =
++++++----------------------
> 1 files changed, 9 insertions(+), 31 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c =
b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> index 088f30b..7a3a37b 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> @@ -120,47 +120,25 @@ static int __init =
mpc85xxrdb_publish_devices(void)
> {
> 	return of_platform_bus_probe(NULL, mpc85xxrdb_ids, NULL);
> }
> -machine_device_initcall(p2020_rdb, mpc85xxrdb_publish_devices);
> -machine_device_initcall(p1020_rdb, mpc85xxrdb_publish_devices);
> +machine_device_initcall(mpc85xx_rdb, mpc85xxrdb_publish_devices);
>=20
> /*
>  * Called very early, device-tree isn't unflattened
>  */
> -static int __init p2020_rdb_probe(void)
> +static int __init mpc85xx_rdb_probe(void)
> {
> 	unsigned long root =3D of_get_flat_dt_root();
>=20
> -	if (of_flat_dt_is_compatible(root, "fsl,P2020RDB"))
> +	if (of_flat_dt_is_compatible(root, "fsl,P1020RDB") ||
> +	    of_flat_dt_is_compatible(root, "fsl,P2020RDB")) {
> 		return 1;
> -	return 0;
> +	} else
> +		return 0;
> }
>=20
> -static int __init p1020_rdb_probe(void)
> -{
> -	unsigned long root =3D of_get_flat_dt_root();
> -
> -	if (of_flat_dt_is_compatible(root, "fsl,P1020RDB"))
> -		return 1;
> -	return 0;
> -}
> -
> -define_machine(p2020_rdb) {
> -	.name			=3D "P2020 RDB",
> -	.probe			=3D p2020_rdb_probe,
> -	.setup_arch		=3D mpc85xx_rdb_setup_arch,
> -	.init_IRQ		=3D mpc85xx_rdb_pic_init,
> -#ifdef CONFIG_PCI
> -	.pcibios_fixup_bus	=3D fsl_pcibios_fixup_bus,
> -#endif
> -	.get_irq		=3D mpic_get_irq,
> -	.restart		=3D fsl_rstcr_restart,
> -	.calibrate_decr		=3D generic_calibrate_decr,
> -	.progress		=3D udbg_progress,
> -};
> -
> -define_machine(p1020_rdb) {
> -	.name			=3D "P1020 RDB",
> -	.probe			=3D p1020_rdb_probe,
> +define_machine(mpc85xx_rdb) {
> +	.name			=3D "MPC85xx RDB",

breaking 'name' this way isn't acceptable.

> +	.probe			=3D mpc85xx_rdb_probe,
> 	.setup_arch		=3D mpc85xx_rdb_setup_arch,
> 	.init_IRQ		=3D mpc85xx_rdb_pic_init,
> #ifdef CONFIG_PCI
> --=20
> 1.7.2.5
