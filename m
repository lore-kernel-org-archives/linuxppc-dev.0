Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0113.outbound.protection.outlook.com [157.56.110.113])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 58DBB1A05EE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 07:38:11 +1100 (AEDT)
Message-ID: <1418157478.5581.30.camel@freescale.com>
Subject: Re: [PATCH 1/1] uio: uio_fsl_elbc_gpcm: new driver
From: Scott Wood <scottwood@freescale.com>
To: John Ogness <john.ogness@linutronix.de>
Date: Tue, 9 Dec 2014 14:37:58 -0600
In-Reply-To: <87iohk22qp.fsf@linutronix.de>
References: <87iohk22qp.fsf@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Trimmed excessive CC list]

On Tue, 2014-12-09 at 17:43 +0100, John Ogness wrote:
> This driver provides UIO access to memory of a peripheral connected
> to the Freescale enhanced local bus controller (eLBC) interface
> using the general purpose chip-select mode (GPCM).
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
> There are currently drivers that use FCM and UPM modes. But there
> are no drivers using the very simple GPCM mode.

Yes, there are -- the NOR flash driver, various board FPGAs, etc.

> If other drivers from other subsystems should start using this mode
> (for example, mtd, eeprom, char) then it may make sense to try to
> implement generic GPCM support in arch/powerpc/sysdev/fsl_lbc.c.

It's already there, though all that's needed is error handling.  Setting
up the chipselects is handled in U-Boot (same as with FCM -- and
probably UPM, though I'm less familiar with that).

> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/lbc.txt b/Documentation/devicetree/bindings/powerpc/fsl/lbc.txt
> index 3300fec..1c80fce 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/lbc.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/lbc.txt
> @@ -16,20 +16,28 @@ Example:
>  			   "fsl,pq2-localbus";
>  		#address-cells = <2>;
>  		#size-cells = <1>;
> -		reg = <f0010100 40>;
> +		reg = <0xf0010100 0x40>;
>  
> -		ranges = <0 0 fe000000 02000000
> -			  1 0 f4500000 00008000>;
> +		ranges = <0x0 0x0 0xfe000000 0x02000000
> +			  0x1 0x0 0xf4500000 0x00008000
> +			  0x2 0x0 0xfd810000 0x00010000>;
>  
>  		flash@0,0 {
>  			compatible = "jedec-flash";
> -			reg = <0 0 2000000>;
> +			reg = <0x0 0x0 0x2000000>;
>  			bank-width = <4>;
>  			device-width = <1>;
>  		};
>  
>  		board-control@1,0 {
> -			reg = <1 0 20>;
> +			reg = <0x1 0x0 0x20>;
>  			compatible = "fsl,mpc8272ads-bcsr";
>  		};
> +

Ideally this sort of cleanup change would be a separate patch.

> +		simple-periph@2,0 {
> +			compatible = "fsl,elbc-gpcm-uio";
> +			reg = <0x2 0x0 0x10000>;
> +			elbc-gpcm-br = <0xfd810800>;
> +			elbc-gpcm-or = <0xffff09f7>;
> +		};

This is not an acceptable compatible string.  Compatible should describe
what the hardware is, not how you plan to use it in Linux.

I also see no description of elbc-gpcm-br/or, and in general putting
register values in the device tree is not a good idea.  As with
compatible, the device tree should describe the hardware, not how to
configure it.

>  	};
> diff --git a/arch/powerpc/include/asm/fsl_lbc.h b/arch/powerpc/include/asm/fsl_lbc.h
> index 067fb0d..c7240a0 100644
> --- a/arch/powerpc/include/asm/fsl_lbc.h
> +++ b/arch/powerpc/include/asm/fsl_lbc.h
> @@ -95,6 +95,9 @@ struct fsl_lbc_bank {
>  #define OR_FCM_TRLX_SHIFT                2
>  #define OR_FCM_EHTR             0x00000002
>  #define OR_FCM_EHTR_SHIFT                1
> +
> +#define OR_GPCM_AM		0xFFFF8000
> +#define OR_GPCM_AM_SHIFT		15
>  };

Please maintain a consistent whitespace style with what's already there.

> diff --git a/drivers/uio/uio_fsl_elbc_gpcm.c b/drivers/uio/uio_fsl_elbc_gpcm.c
> new file mode 100644
> index 0000000..b6cac91
> --- /dev/null
> +++ b/drivers/uio/uio_fsl_elbc_gpcm.c
> @@ -0,0 +1,499 @@
> +/* uio_fsl_elbc_gpcm: UIO driver for eLBC/GPCM peripherals
> +
> +   Copyright (C) 2014 Linutronix GmbH
> +     Author: John Ogness <john.ogness@linutronix.de>
> +
> +   This driver provides UIO access to memory of a peripheral connected
> +   to the Freescale enhanced local bus controller (eLBC) interface
> +   using the general purpose chip-select mode (GPCM).
> +
> +   Here is an example of the device tree entries:
> +
> +	localbus@ffe05000 {
> +		ranges = <0x2 0x0 0x0 0xff810000 0x10000>;
> +
> +		dpm@2,0 {
> +			compatible = "fsl,elbc-gpcm-uio";
> +			reg = <0x2 0x0 0x10000>;
> +			elbc-gpcm-br = <0xff810800>;
> +			elbc-gpcm-or = <0xffff09f7>;
> +			interrupt-parent = <&mpic>;
> +			interrupts = <4 1>;
> +			device_type = "netx5152";
> +			uio_name = "netx_custom";
> +			netx5152,init-win0-offset = <0x0>;
> +		};
> +	};

What is "uio_name"?  Again, not hardware description.

Where is the binding for this device?  What is
netx5152,init-win0-offset?  Documentations go in
Documentation/devicetree/bindings, not code comments.

Don't use device_type.

> +#ifdef CONFIG_UIO_FSL_ELBC_GPCM_NETX5152
> +#define DPM_HOST_WIN0_OFFSET	0xff00
> +#define DPM_HOST_INT_STAT0	0xe0
> +#define DPM_HOST_INT_EN0	0xf0
> +#define DPM_HOST_INT_MASK	0xe600ffff
> +#define DPM_HOST_INT_GLOBAL_EN	0x80000000

What's this doing in the "generic" file?

> +static void netx5152_shutdown(struct uio_info *info, bool init_err)
> +{
> +	if (init_err)
> +		return;
> +
> +	/* disable interrupts */
> +	iowrite32(0, info->mem[0].internal_addr + DPM_HOST_WIN0_OFFSET +
> +		     DPM_HOST_INT_EN0);
> +}

Why would you ever call this function with init_err = true?  What is it
supposed to do?  When you introduce a callback interface you should
document the semantics that are expected of an implementation,
especially if there are details that aren't clear from existing
examples.

> +	/* get current BR/OR values */
> +	reg_br_cur = in_be32(&priv->lbc->bank[priv->bank].br);
> +	reg_or_cur = in_be32(&priv->lbc->bank[priv->bank].or);
> +
> +	/* if bank already configured, make sure it matches */
> +	if ((reg_br_cur & BR_V)) {
> +		if ((reg_br_cur & BR_MSEL) != BR_MS_GPCM ||
> +		    (reg_br_cur & reg_or_cur & BR_BA)
> +		     != fsl_lbc_addr(res.start)) {
> +			dev_err(priv->dev,
> +				"bank in use by another peripheral\n");
> +			ret = -ENODEV;
> +			goto out_err1;
> +		}
> +
> +		/* warn if behavior settings changing */
> +		if ((reg_br_cur & ~(BR_BA | BR_V)) !=
> +		    (reg_br_new & ~(BR_BA | BR_V))) {
> +			dev_warn(priv->dev,
> +				 "modifying BR settings: 0x%08x -> 0x%08x",
> +				 reg_br_cur, reg_br_new);
> +		}
> +		if ((reg_or_cur & ~OR_GPCM_AM) != (reg_or_new & ~OR_GPCM_AM)) {
> +			dev_warn(priv->dev,
> +				 "modifying OR settings: 0x%08x -> 0x%08x",
> +				 reg_or_cur, reg_or_new);
> +		}
> +	}

Why is a wrong value for MSEL in pre-existing BRn a fatal error but
wrong address/size isn't?

> +	info->version = "0.0.1";

What does this version mean?  When will it be updated?

> +	if (irq != NO_IRQ) {
> +		if (priv->irq_handler) {
> +			info->irq = irq;
> +			info->irq_flags = IRQF_SHARED;
> +			info->handler = priv->irq_handler;
> +		} else {
> +			irq = NO_IRQ;
> +			dev_warn(priv->dev, "ignoring irq, no handler\n");
> +		}
> +	}

Don't use NO_IRQ.  A value of zero indicates the absence of an
interrupt.

> +	if (priv->init)
> +		priv->init(info);
> +
> +	/* register UIO device */
> +	if (uio_register_device(priv->dev, info) != 0) {
> +		dev_err(priv->dev, "UIO registration failed\n");
> +		ret = -ENODEV;
> +		goto out_err2;
> +	}
> +
> +	/* store private data */
> +	platform_set_drvdata(pdev, info);

Shouldn't you set drvdata before registering?

> +static struct platform_driver uio_fsl_elbc_gpcm_driver = {
> +	.driver = {
> +		.name = "fsl,elbc-gpcm-uio",
> +		.owner = THIS_MODULE,
> +		.of_match_table = uio_fsl_elbc_gpcm_match,
> +	},

Setting .owner in platform_driver is no longer necessary, and there was
recently a big patchset to remove them.

> +static int __init uio_fsl_elbc_gpcm_init(void)
> +{
> +	return platform_driver_register(&uio_fsl_elbc_gpcm_driver);
> +}
> +
> +static void __exit uio_fsl_elbc_gpcm_exit(void)
> +{
> +	platform_driver_unregister(&uio_fsl_elbc_gpcm_driver);
> +}
> +
> +module_init(uio_fsl_elbc_gpcm_init);
> +module_exit(uio_fsl_elbc_gpcm_exit);

module_platform_driver()

-Scott
