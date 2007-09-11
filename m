Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BB556DDF0A
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 00:17:29 +1000 (EST)
Date: Tue, 11 Sep 2007 09:18:21 -0500
From: Olof Johansson <olof@lixom.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Message-ID: <20070911141821.GA32545@lixom.net>
References: <Pine.LNX.4.64.0709110128040.27648@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0709110128040.27648@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Tue, Sep 11, 2007 at 01:29:18AM -0500, Kumar Gala wrote:
> Added basic board port for MPC8572 DS reference platform that is
> similiar to the MPC8544/33 DS reference platform in uniprocessor mode.
> 
> ---
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> index 3a5c3c4..1e2eba8 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> @@ -181,6 +181,23 @@ static int __init mpc8544_ds_probe(void)
>  	}
>  }
> 
> +/*
> + * Called very early, device-tree isn't unflattened
> + */
> +static int __init mpc8572_ds_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	if (of_flat_dt_is_compatible(root, "MPC8572DS")) {
> +#ifdef CONFIG_PCI
> +		primary_phb_addr = 0x8000;
> +#endif
> +		return 1;
> +	} else {
> +		return 0;
> +	}
> +}
> +
>  define_machine(mpc8544_ds) {
>  	.name			= "MPC8544 DS",
>  	.probe			= mpc8544_ds_probe,
> @@ -194,3 +211,17 @@ define_machine(mpc8544_ds) {
>  	.calibrate_decr		= generic_calibrate_decr,
>  	.progress		= udbg_progress,
>  };
> +
> +define_machine(mpc8572_ds) {
> +	.name			= "MPC8572 DS",
> +	.probe			= mpc8572_ds_probe,
> +	.setup_arch		= mpc85xx_ds_setup_arch,
> +	.init_IRQ		= mpc85xx_ds_pic_init,
> +#ifdef CONFIG_PCI
> +	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +#endif
> +	.get_irq		= mpic_get_irq,
> +	.restart		= mpc85xx_restart,
> +	.calibrate_decr		= generic_calibrate_decr,
> +	.progress		= udbg_progress,
> +};

How different are these boards really? Could you just detect MPC85xxDS
and have a generic platform for them, or are they different enough that
you need individual ones for it?


> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 06d23e1..c98b867 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -374,10 +374,9 @@
>  #define PCI_DEVICE_ID_ATI_IXP400_SATA   0x4379
>  #define PCI_DEVICE_ID_ATI_IXP400_SATA2	0x437a
>  #define PCI_DEVICE_ID_ATI_IXP600_SATA	0x4380
> -#define PCI_DEVICE_ID_ATI_IXP600_SMBUS	0x4385
> +#define PCI_DEVICE_ID_ATI_SBX00_SMBUS	0x4385
>  #define PCI_DEVICE_ID_ATI_IXP600_IDE	0x438c
>  #define PCI_DEVICE_ID_ATI_IXP700_SATA	0x4390
> -#define PCI_DEVICE_ID_ATI_IXP700_SMBUS	0x4395
>  #define PCI_DEVICE_ID_ATI_IXP700_IDE	0x439c

This looks like it doesn't belong in this patch.


-Olof
