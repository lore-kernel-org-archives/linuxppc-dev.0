Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/4] Convert axon_msi to an of_platform driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <a42b0e1b5224f8f2e6f87ab1bbe520a55be85e98.1201240265.git.michael@ellerman.id.au>
References: <3ce7be4c77581ce103a8da9f33a734270c9dc6e8.1201240265.git.michael@ellerman.id.au>
	<a42b0e1b5224f8f2e6f87ab1bbe520a55be85e98.1201240265.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 05 Feb 2008 11:20:33 +1100
Message-Id: <1202170833.7079.28.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-01-25 at 16:59 +1100, Michael Ellerman wrote:
> Now that we create of_platform devices earlier on cell, we can make the
> axon_msi driver an of_platform driver. This makes the code cleaner in
> several ways, and most importantly means we have a struct device.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/platforms/cell/axon_msi.c |   76 ++++++++++++++-----------------
>  1 files changed, 34 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
> index 095988f..ea3dc8c 100644
> --- a/arch/powerpc/platforms/cell/axon_msi.c
> +++ b/arch/powerpc/platforms/cell/axon_msi.c
> @@ -13,7 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/msi.h>
> -#include <linux/reboot.h>
> +#include <linux/of_platform.h>
>  
>  #include <asm/dcr.h>
>  #include <asm/machdep.h>
> @@ -67,12 +67,9 @@ struct axon_msic {
>  	struct irq_host *irq_host;
>  	__le32 *fifo;
>  	dcr_host_t dcr_host;
> -	struct list_head list;
>  	u32 read_offset;
>  };
>  
> -static LIST_HEAD(axon_msic_list);
> -
>  static void msic_dcr_write(struct axon_msic *msic, unsigned int dcr_n, u32 val)
>  {
>  	pr_debug("axon_msi: dcr_write(0x%x, 0x%x)\n", val, dcr_n);
> @@ -292,30 +289,25 @@ static struct irq_host_ops msic_host_ops = {
>  	.map	= msic_host_map,
>  };
>  
> -static int axon_msi_notify_reboot(struct notifier_block *nb,
> -				  unsigned long code, void *data)
> +static int axon_msi_shutdown(struct of_device *device)
>  {
> -	struct axon_msic *msic;
> +	struct axon_msic *msic = device->dev.platform_data;
>  	u32 tmp;
>  
> -	list_for_each_entry(msic, &axon_msic_list, list) {
> -		pr_debug("axon_msi: disabling %s\n",
> -			  msic->irq_host->of_node->full_name);
> -		tmp  = dcr_read(msic->dcr_host, MSIC_CTRL_REG);
> -		tmp &= ~MSIC_CTRL_ENABLE & ~MSIC_CTRL_IRQ_ENABLE;
> -		msic_dcr_write(msic, MSIC_CTRL_REG, tmp);
> -	}
> +	pr_debug("axon_msi: disabling %s\n",
> +		  msic->irq_host->of_node->full_name);
> +	tmp  = dcr_read(msic->dcr_host, MSIC_CTRL_REG);
> +	tmp &= ~MSIC_CTRL_ENABLE & ~MSIC_CTRL_IRQ_ENABLE;
> +	msic_dcr_write(msic, MSIC_CTRL_REG, tmp);
>  
>  	return 0;
>  }
>  
> -static struct notifier_block axon_msi_reboot_notifier = {
> -	.notifier_call = axon_msi_notify_reboot
> -};
> -
> -static int axon_msi_setup_one(struct device_node *dn)
> +static int axon_msi_probe(struct of_device *device,
> +			  const struct of_device_id *device_id)
>  {
>  	struct page *page;
> +	struct device_node *dn = device->node;
>  	struct axon_msic *msic;
>  	unsigned int virq;
>  	int dcr_base, dcr_len;
> @@ -385,7 +377,11 @@ static int axon_msi_setup_one(struct device_node *dn)
>  			MSIC_CTRL_IRQ_ENABLE | MSIC_CTRL_ENABLE |
>  			MSIC_CTRL_FIFO_SIZE);
>  
> -	list_add(&msic->list, &axon_msic_list);
> +	device->dev.platform_data = msic;
> +
> +	ppc_md.setup_msi_irqs = axon_msi_setup_msi_irqs;
> +	ppc_md.teardown_msi_irqs = axon_msi_teardown_msi_irqs;
> +	ppc_md.msi_check_device = axon_msi_check_device;
>  
>  	printk(KERN_DEBUG "axon_msi: setup MSIC on %s\n", dn->full_name);
>  
> @@ -402,28 +398,24 @@ out:
>  	return -1;
>  }
>  
> -static int axon_msi_init(void)
> -{
> -	struct device_node *dn;
> -	int found = 0;
> -
> -	pr_debug("axon_msi: initialising ...\n");
> -
> -	for_each_compatible_node(dn, NULL, "ibm,axon-msic") {
> -		if (axon_msi_setup_one(dn) == 0)
> -			found++;
> -	}
> -
> -	if (found) {
> -		ppc_md.setup_msi_irqs = axon_msi_setup_msi_irqs;
> -		ppc_md.teardown_msi_irqs = axon_msi_teardown_msi_irqs;
> -		ppc_md.msi_check_device = axon_msi_check_device;
> -
> -		register_reboot_notifier(&axon_msi_reboot_notifier);
> +static const struct of_device_id axon_msi_device_id[] = {
> +	{
> +		.compatible	= "ibm,axon-msic"
> +	},
> +	{}
> +};
>  
> -		pr_debug("axon_msi: registered callbacks!\n");
> -	}
> +static struct of_platform_driver axon_msi_driver = {
> +	.match_table	= axon_msi_device_id,
> +	.probe		= axon_msi_probe,
> +	.shutdown	= axon_msi_shutdown,
> +	.driver		= {
> +		.name	= "axon-msi"
> +	},
> +};
>  
> -	return 0;
> +static int __init axon_msi_init(void)
> +{
> +	return of_register_platform_driver(&axon_msi_driver);
>  }
> -arch_initcall(axon_msi_init);
> +subsys_initcall(axon_msi_init);
> -- 
> 1.5.2.rc1.1884.g59b20
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
