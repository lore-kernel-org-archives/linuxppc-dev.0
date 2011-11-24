Return-Path: <B11780@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 77EE81007DE
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 16:12:29 +1100 (EST)
Received: from mail106-db3 (localhost [127.0.0.1])	by
 mail106-db3-R.bigfish.com (Postfix) with ESMTP id 99B093403AD	for
 <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 05:12:00 +0000 (UTC)
Received: from DB3EHSMHS012.bigfish.com (unknown [10.3.81.253])	by
 mail106-db3.bigfish.com (Postfix) with ESMTP id 716391C0046	for
 <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 05:12:00 +0000 (UTC)
Subject: Re: [PATCH 1/3] powerpc/85xx: p1022ds: disable the NOR flash node if
 video is enabled
MIME-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1321638601-6861-1-git-send-email-timur@freescale.com>
Date: Wed, 23 Nov 2011 23:12:21 -0600
Message-ID: <1A0AD338-C79B-4C7A-8343-4727DA5886DE@freescale.com>
References: <1321638601-6861-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 18, 2011, at 11:49 AM, Timur Tabi wrote:

> The Freescale P1022 has a unique pin muxing "feature" where the DIU =
video
> controller's video signals are muxed with 24 of the local bus address =
signals.
> When the DIU is enabled, the bulk of the local bus is disabled, =
preventing
> access to memory-mapped devices like NOR flash and the pixis FPGA.
>=20
> Therefore, if the DIU is going to be enabled, then memory-mapped =
devices on
> the localbus, like NOR flash, need to be disabled.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/platforms/85xx/p1022_ds.c |   70 =
++++++++++++++++++++++++++++++++
> 1 files changed, 70 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c =
b/arch/powerpc/platforms/85xx/p1022_ds.c
> index fda1571..e0280e2 100644
> --- a/arch/powerpc/platforms/85xx/p1022_ds.c
> +++ b/arch/powerpc/platforms/85xx/p1022_ds.c
> @@ -270,6 +270,54 @@ void __init p1022_ds_pic_init(void)
> void __init mpc85xx_smp_init(void);
> #endif
>=20
> +#if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
> +
> +/*
> + * Disables a node in the device tree.
> + *
> + * This function is called before kmalloc() is available, and it's =
only called
> + * once, so we instead of allocating the new property object via the =
bootmem
> + * allocator, we just create a static local variable.
> + */
> +static void __init disable_one_node(struct device_node *np)
> +{
> +	struct property *old;
> +	static struct property new =3D {
> +		.name =3D "status",
> +		.value =3D "disabled",
> +		.length =3D sizeof("disabled"),
> +	};
> +
> +	old =3D of_find_property(np, new.name, NULL);
> +	if (old)
> +		prom_update_property(np, &new, old);
> +	else
> +		prom_add_property(np, &new);
> +}
> +
> +/* TRUE if there is a "video=3Dfslfb" command-line parameter. */
> +static bool fslfb;
> +
> +/*
> + * Search for a "video=3Dfslfb" command-line parameter, and set =
'fslfb' to
> + * true if we find it.
> + *
> + * We need to use early_param() instead of __setup() because the =
normal
> + * __setup() gets called to late.  However, early_param() gets called =
very
> + * early, before the device tree is unflattened, so all we can do now =
is set a
> + * global variable.  Later on, p1022_ds_setup_arch() will use that =
variable
> + * to determine if we need to update the device tree.
> + */
> +static int __init early_video_setup(char *options)
> +{
> +	fslfb =3D (strncmp(options, "fslfb:", 6) =3D=3D 0);
> +
> +	return 0;
> +}
> +early_param("video", early_video_setup);
> +
> +#endif
> +
> /*
>  * Setup the architecture
>  */
> @@ -307,6 +355,28 @@ static void __init p1022_ds_setup_arch(void)
> 	diu_ops.set_monitor_port	=3D p1022ds_set_monitor_port;
> 	diu_ops.set_pixel_clock		=3D p1022ds_set_pixel_clock;
> 	diu_ops.valid_monitor_port	=3D p1022ds_valid_monitor_port;
> +
> +	/*
> +	 * Delete the NOR flash node if there is video=3Dfslfb... =
command-line
> +	 * parameter.  When the DIU is active, NOR flash is unavailable, =
so we
> +	 * have to delete the node before the MTD driver loads.
> +	 */

Fix comment, you aren't deleting the node, your marked it disabled.

> +	if (fslfb) {
> +		struct device_node *np =3D
> +			of_find_compatible_node(NULL, NULL, =
"fsl,p1022-elbc");
> +
> +		if (np) {
> +			np =3D of_find_compatible_node(np, NULL, =
"cfi-flash");
> +			if (np) {
> +				pr_info("p1022ds: disabling %s node",
> +					np->full_name);
> +				disable_one_node(np);
> +				of_node_put(np);
> +			}
> +		}
> +
> +	}
> +
> #endif
>=20
> #ifdef CONFIG_SMP
> --=20
> 1.7.3.4
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
