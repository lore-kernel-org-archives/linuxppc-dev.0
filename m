Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 8F213B70AA
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Sep 2010 21:23:22 +1000 (EST)
Received: by eyg24 with SMTP id 24so886062eyg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Sep 2010 04:23:19 -0700 (PDT)
Date: Thu, 9 Sep 2010 15:23:15 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH 2/3 v2][MTD] P4080/mtd: Only make elbc nand driver
	detect nand flash partitions
Message-ID: <20100909112315.GA6622@oksana.dev.rtsoft.ru>
References: <1284027632-32573-1-git-send-email-tie-fei.zang@freescale.com>
	<1284027632-32573-2-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1284027632-32573-2-git-send-email-tie-fei.zang@freescale.com>
Cc: B07421@freescale.com, dedekind1@gmail.com, B25806@freescale.com,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 09, 2010 at 06:20:31PM +0800, Roy Zang wrote:
[...]
>  #include <linux/types.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> -#include <linux/string.h>
> -#include <linux/ioport.h>
> -#include <linux/of_platform.h>
> -#include <linux/slab.h>
> -#include <linux/interrupt.h>
>  
> -#include <linux/mtd/mtd.h>
>  #include <linux/mtd/nand.h>
> -#include <linux/mtd/nand_ecc.h>
>  #include <linux/mtd/partitions.h>
> -
> -#include <asm/io.h>
>  #include <asm/fsl_lbc.h>
> +#include <linux/slab.h>

Why move slab.h?

[...]
>  	for (i = 0; i < len; i++)
> -		if (in_8(&ctrl->addr[ctrl->index + i]) != buf[i])
> +		if (in_8(&elbc_fcm_ctrl->addr[elbc_fcm_ctrl->index + i])
> +				!= buf[i])
>  			break;
>  
> -	ctrl->index += len;
> -	return i == len && ctrl->status == LTESR_CC ? 0 : -EIO;
> +	elbc_fcm_ctrl->index += len;
> +	return i == len && elbc_fcm_ctrl->status == LTESR_CC ? 0 : -EIO;
>  }
>  
>  /* This function is called after Program and Erase Operations to
> @@ -635,22 +625,21 @@ static int fsl_elbc_verify_buf(struct mtd_info *mtd, const u_char *buf, int len)
>  static int fsl_elbc_wait(struct mtd_info *mtd, struct nand_chip *chip)
>  {
>  	struct fsl_elbc_mtd *priv = chip->priv;
> -	struct fsl_elbc_ctrl *ctrl = priv->ctrl;
> -

Please keep the empty line between variables declaration and the code.

> -	if (ctrl->status != LTESR_CC)
> +	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
> +	if (elbc_fcm_ctrl->status != LTESR_CC)
>  		return NAND_STATUS_FAIL;
[...]
> @@ -750,18 +739,18 @@ static void fsl_elbc_write_page(struct mtd_info *mtd,
>                                  const uint8_t *buf)
>  {
>  	struct fsl_elbc_mtd *priv = chip->priv;
> -	struct fsl_elbc_ctrl *ctrl = priv->ctrl;
> -
> +	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;

Ditto.

>  	fsl_elbc_write_buf(mtd, buf, mtd->writesize);
>  	fsl_elbc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
>  
> -	ctrl->oob_poi = chip->oob_poi;
> +	elbc_fcm_ctrl->oob_poi = chip->oob_poi;
>  }

[...]
> -static int __devinit fsl_elbc_chip_probe(struct fsl_elbc_ctrl *ctrl,
> -					 struct device_node *node)
> +static int __devinit fsl_elbc_nand_probe(struct platform_device *dev,
> +					 const struct of_device_id *match)
>  {
> -	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
> +	struct fsl_lbc_regs __iomem *lbc;
>  	struct fsl_elbc_mtd *priv;
>  	struct resource res;
> +	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = NULL;

(***1)

>  #ifdef CONFIG_MTD_PARTITIONS
>  	static const char *part_probe_types[]
>  		= { "cmdlinepart", "RedBoot", NULL };
> @@ -843,11 +832,16 @@ static int __devinit fsl_elbc_chip_probe(struct fsl_elbc_ctrl *ctrl,
>  #endif
>  	int ret;
>  	int bank;
> +	struct device_node *node = dev->dev.of_node;
> +
> +	if (!fsl_lbc_ctrl_dev || !fsl_lbc_ctrl_dev->regs)
> +		return -ENODEV;
> +	lbc = fsl_lbc_ctrl_dev->regs;
>  
>  	/* get, allocate and map the memory resource */
>  	ret = of_address_to_resource(node, 0, &res);
>  	if (ret) {
> -		dev_err(ctrl->dev, "failed to get resource\n");
> +		dev_err(fsl_lbc_ctrl_dev->dev, "failed to get resource\n");
>  		return ret;
>  	}
>  
> @@ -861,7 +855,8 @@ static int __devinit fsl_elbc_chip_probe(struct fsl_elbc_ctrl *ctrl,
>  			break;
>  
>  	if (bank >= MAX_BANKS) {
> -		dev_err(ctrl->dev, "address did not match any chip selects\n");
> +		dev_err(fsl_lbc_ctrl_dev->dev, "address did not match any "
> +			"chip selects\n");
>  		return -ENODEV;
>  	}
>  
> @@ -869,14 +864,28 @@ static int __devinit fsl_elbc_chip_probe(struct fsl_elbc_ctrl *ctrl,
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	ctrl->chips[bank] = priv;
> +	if (fsl_lbc_ctrl_dev->nand == NULL) {
> +		elbc_fcm_ctrl = kzalloc(sizeof(*elbc_fcm_ctrl), GFP_KERNEL);
> +		if (!elbc_fcm_ctrl)
> +			return -ENOMEM;

'priv' leaked.

> +
> +		elbc_fcm_ctrl->read_bytes = 0;
> +		elbc_fcm_ctrl->index = 0;
> +		elbc_fcm_ctrl->addr = NULL;
> +
> +		spin_lock_init(&elbc_fcm_ctrl->controller.lock);
> +		init_waitqueue_head(&elbc_fcm_ctrl->controller.wq);
> +		fsl_lbc_ctrl_dev->nand = elbc_fcm_ctrl;
> +	}
> +
> +	elbc_fcm_ctrl->chips[bank] = priv;

The driver will oops on the second probe.

You probably meant

  struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = fsl_lbc_ctrl_dev->nand;

at (***1).

Also, nowadays the kernel may probe devices in parallel, which
means that you probably need a mutex for fsl_lbc_ctrl_dev->nand.

[...]
> -static const struct of_device_id fsl_elbc_match[] = {
> +static const struct of_device_id fsl_elbc_nand_match[] = {

linux/mod_devicetable.h is needed for this.

>  	{
> -		.compatible = "fsl,elbc",
> +		.compatible = "fsl,elbc-fcm-nand",
>  	},
>  	{}
>  };
>  
> -static struct of_platform_driver fsl_elbc_ctrl_driver = {
> +static struct of_platform_driver fsl_elbc_nand_driver = {

If you write of_platform_driver, you need linux/of_platform.h (which
you removed in this patch).

But I think that you need just 'struct platform_driver' here, and
include linux/platform_device.h.

>  	.driver = {
> -		.name = "fsl-elbc",
> +		.name = "fsl,elbc-fcm-nand",
>  		.owner = THIS_MODULE,
> -		.of_match_table = fsl_elbc_match,
> +		.of_match_table = fsl_elbc_nand_match,
>  	},
> -	.probe = fsl_elbc_ctrl_probe,
> -	.remove = fsl_elbc_ctrl_remove,
> +	.probe = fsl_elbc_nand_probe,
> +	.remove = fsl_elbc_nand_remove,
>  };

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
