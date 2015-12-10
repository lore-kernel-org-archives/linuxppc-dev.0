Return-Path: <jthumshirn@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3686A1A105D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 18:50:10 +1100 (AEDT)
Message-ID: <1449733805.3311.30.camel@suse.de>
Subject: Re: [PATCH v2] EDAC, mpc85xx: Make mpc85xx-pci-edac a platform device
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-edac@vger.kernel.org
Cc: Jia Hongtao <B38951@freescale.com>, Borislav Petkov <bp@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 10 Dec 2015 08:50:05 +0100
In-Reply-To: <1449705774-12811-1-git-send-email-scottwood@freescale.com>
References: <1449705774-12811-1-git-send-email-scottwood@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-12-09 at 18:02 -0600, Scott Wood wrote:
> Originally the mpc85xx-pci-edac driver bound directly to the PCI
> controller node.
> 
> Commit 905e75c46dba5f30 ("powerpc/fsl-pci: Unify pci/pcie
> initialization code") turned the PCI controller code into a platform
> device.  Since we can't have two drivers binding to the same device,
> the edac code was changed to be called into as a library-style
> submodule.  However, this doesn't work if the edac driver is built as a
> module.
> 
> Commit 8d8fcba6d1eab ("EDAC: Rip out the edac_subsys reference
> counting") exposed another problem with this approach --
> mpc85xx_pci_err_probe() was being called in the same early boot phase
> that the PCI controller is initialized, rather than in the
> device_initcall phase that the EDAC layer expects.  This caused a crash
> on boot.
> 
> To fix this, the PCI controller code now creates a child platform
> device specifically for EDAC, which the mpc85xx-pci-edac driver binds
> to.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Cc: Jia Hongtao <B38951@freescale.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
> v2: Make mpc85xx_pci_err_probe() static again.
> 
>  arch/powerpc/sysdev/fsl_pci.c | 28 +++++++++++++++++++++++++++-
>  arch/powerpc/sysdev/fsl_pci.h |  9 ---------
>  drivers/edac/mpc85xx_edac.c   | 36 +++++++++++++++++++++++++++++++-----
>  include/linux/fsl/edac.h      |  8 ++++++++
>  4 files changed, 66 insertions(+), 15 deletions(-)
>  create mode 100644 include/linux/fsl/edac.h
> 
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 610f472..a1ac80b 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -21,10 +21,12 @@
>  #include <linux/pci.h>
>  #include <linux/delay.h>
>  #include <linux/string.h>
> +#include <linux/fsl/edac.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/memblock.h>
>  #include <linux/log2.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
>  #include <linux/syscore_ops.h>
> @@ -1255,6 +1257,25 @@ void fsl_pcibios_fixup_phb(struct pci_controller *phb)
>  #endif
>  }
>  
> +static int add_err_dev(struct platform_device *pdev)
> +{
> +	struct platform_device *errdev;
> +	struct mpc85xx_edac_pci_plat_data pd = {
> +		.of_node = pdev->dev.of_node
> +	};
> +
> +	errdev = platform_device_register_resndata(&pdev->dev,
> +						   "mpc85xx-pci-edac",
> +						   PLATFORM_DEVID_AUTO,
> +						   pdev->resource,
> +						   pdev->num_resources,
> +						   &pd, sizeof(pd));
> +	if (IS_ERR(errdev))
> +		return PTR_ERR(errdev);
> +
> +	return 0;
> +}
> +
>  static int fsl_pci_probe(struct platform_device *pdev)
>  {
>  	struct device_node *node;
> @@ -1262,8 +1283,13 @@ static int fsl_pci_probe(struct platform_device *pdev)
>  
>  	node = pdev->dev.of_node;
>  	ret = fsl_add_bridge(pdev, fsl_pci_primary == node);
> +	if (ret)
> +		return ret;
>  
> -	mpc85xx_pci_err_probe(pdev);
> +	ret = add_err_dev(pdev);
> +	if (ret)
> +		dev_err(&pdev->dev, "couldn't register error device: %d\n",
> +			ret);
>  
>  	return 0;
>  }
> diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
> index c1cec77..1515885 100644
> --- a/arch/powerpc/sysdev/fsl_pci.h
> +++ b/arch/powerpc/sysdev/fsl_pci.h
> @@ -130,15 +130,6 @@ void fsl_pci_assign_primary(void);
>  static inline void fsl_pci_assign_primary(void) {}
>  #endif
>  
> -#ifdef CONFIG_EDAC_MPC85XX
> -int mpc85xx_pci_err_probe(struct platform_device *op);
> -#else
> -static inline int mpc85xx_pci_err_probe(struct platform_device *op)
> -{
> -	return -ENOTSUPP;
> -}
> -#endif
> -
>  #ifdef CONFIG_FSL_PCI
>  extern int fsl_pci_mcheck_exception(struct pt_regs *);
>  #else
> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> index 3eab063..406d75a 100644
> --- a/drivers/edac/mpc85xx_edac.c
> +++ b/drivers/edac/mpc85xx_edac.c
> @@ -20,6 +20,7 @@
>  #include <linux/edac.h>
>  #include <linux/smp.h>
>  #include <linux/gfp.h>
> +#include <linux/fsl/edac.h>
>  
>  #include <linux/of_platform.h>
>  #include <linux/of_device.h>
> @@ -238,10 +239,12 @@ static irqreturn_t mpc85xx_pci_isr(int irq, void
> *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -int mpc85xx_pci_err_probe(struct platform_device *op)
> +static int mpc85xx_pci_err_probe(struct platform_device *op)
>  {
>  	struct edac_pci_ctl_info *pci;
>  	struct mpc85xx_pci_pdata *pdata;
> +	struct mpc85xx_edac_pci_plat_data *plat_data;
> +	struct device_node *of_node;
>  	struct resource r;
>  	int res = 0;
>  
> @@ -266,7 +269,15 @@ int mpc85xx_pci_err_probe(struct platform_device *op)
>  	pdata->name = "mpc85xx_pci_err";
>  	pdata->irq = NO_IRQ;
>  
> -	if (mpc85xx_pcie_find_capability(op->dev.of_node) > 0)
> +	plat_data = op->dev.platform_data;
> +	if (!plat_data) {
> +		dev_err(&op->dev, "no platform data");
> +		res = -ENXIO;
> +		goto err;
> +	}
> +	of_node = plat_data->of_node;
> +
> +	if (mpc85xx_pcie_find_capability(of_node) > 0)
>  		pdata->is_pcie = true;
>  
>  	dev_set_drvdata(&op->dev, pci);
> @@ -284,7 +295,7 @@ int mpc85xx_pci_err_probe(struct platform_device *op)
>  
>  	pdata->edac_idx = edac_pci_idx++;
>  
> -	res = of_address_to_resource(op->dev.of_node, 0, &r);
> +	res = of_address_to_resource(of_node, 0, &r);
>  	if (res) {
>  		printk(KERN_ERR "%s: Unable to get resource for "
>  		       "PCI err regs\n", __func__);
> @@ -339,7 +350,7 @@ int mpc85xx_pci_err_probe(struct platform_device *op)
>  	}
>  
>  	if (edac_op_state == EDAC_OPSTATE_INT) {
> -		pdata->irq = irq_of_parse_and_map(op->dev.of_node, 0);
> +		pdata->irq = irq_of_parse_and_map(of_node, 0);
>  		res = devm_request_irq(&op->dev, pdata->irq,
>  				       mpc85xx_pci_isr,
>  				       IRQF_SHARED,
> @@ -386,8 +397,22 @@ err:
>  	devres_release_group(&op->dev, mpc85xx_pci_err_probe);
>  	return res;
>  }
> -EXPORT_SYMBOL(mpc85xx_pci_err_probe);
>  
> +static const struct platform_device_id mpc85xx_pci_err_match[] = {
> +	{
> +		.name = "mpc85xx-pci-edac"
> +	},
> +	{}
> +};
> +
> +static struct platform_driver mpc85xx_pci_err_driver = {
> +	.probe = mpc85xx_pci_err_probe,
> +	.id_table = mpc85xx_pci_err_match,
> +	.driver = {
> +		.name = "mpc85xx_pci_err",
> +		.suppress_bind_attrs = true,
> +	},
> +};
>  #endif				/* CONFIG_PCI */
>  
>  /**************************** L2 Err device ***************************/
> @@ -1211,6 +1236,7 @@ static void __init mpc85xx_mc_clear_rfxe(void *data)
>  static struct platform_driver * const drivers[] = {
>  	&mpc85xx_mc_err_driver,
>  	&mpc85xx_l2_err_driver,
> +	&mpc85xx_pci_err_driver,
>  };
>  

One thing, if we don't have CONFIG_PCI it won't build AFICS, or I'm I totally
wrong now (my version had this bug as well, btw)?

With the above clarified/fixed feel free to add my
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
