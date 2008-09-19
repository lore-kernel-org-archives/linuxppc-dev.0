Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 7C8EADDF65
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 07:41:16 +1000 (EST)
Message-ID: <48D41823.4040106@mvista.com>
Date: Fri, 19 Sep 2008 14:22:43 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Nate Case <ncase@xes-inc.com>
Subject: Re: [PATCH] edac: mpc85xx: Add support for MPC8572
References: <1221858771-14928-1-git-send-email-ncase@xes-inc.com>
In-Reply-To: <1221858771-14928-1-git-send-email-ncase@xes-inc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andrew Kilkenny <akilkenny@xes-inc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Acked-by: Dave Jiang <djiang@mvista.com>

Nate Case wrote:
> From: Andrew Kilkenny <akilkenny@xes-inc.com>
> 
> This adds support for the dual-core MPC8572 processor.  We have
> to support making SPR changes on each core.  Also, since we can
> have multiple memory controllers sharing an interrupt, flag the
> interrupts with IRQF_SHARED.
> 
> Signed-off-by: Andrew Kilkenny <akilkenny@xes-inc.com>
> Signed-off-by: Nate Case <ncase@xes-inc.com>
> ---
>  drivers/edac/mpc85xx_edac.c |   34 +++++++++++++++++++++++++++-------
>  1 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> index 2265d9c..0668492 100644
> --- a/drivers/edac/mpc85xx_edac.c
> +++ b/drivers/edac/mpc85xx_edac.c
> @@ -17,6 +17,7 @@
>  #include <linux/io.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/edac.h>
> +#include <linux/smp.h>
>  
>  #include <linux/of_platform.h>
>  #include <linux/of_device.h>
> @@ -40,7 +41,7 @@ static u32 orig_pci_err_en;
>  #endif
>  
>  static u32 orig_l2_err_disable;
> -static u32 orig_hid1;
> +static u32 orig_hid1[2];
>  
>  /************************ MC SYSFS parts ***********************************/
>  
> @@ -272,7 +273,8 @@ static int __devinit mpc85xx_pci_err_probe(struct of_device *op,
>  	if (edac_op_state == EDAC_OPSTATE_INT) {
>  		pdata->irq = irq_of_parse_and_map(op->node, 0);
>  		res = devm_request_irq(&op->dev, pdata->irq,
> -				       mpc85xx_pci_isr, IRQF_DISABLED,
> +				       mpc85xx_pci_isr,
> +				       IRQF_DISABLED | IRQF_SHARED,
>  				       "[EDAC] PCI err", pci);
>  		if (res < 0) {
>  			printk(KERN_ERR
> @@ -576,7 +578,8 @@ static int __devinit mpc85xx_l2_err_probe(struct of_device *op,
>  	if (edac_op_state == EDAC_OPSTATE_INT) {
>  		pdata->irq = irq_of_parse_and_map(op->node, 0);
>  		res = devm_request_irq(&op->dev, pdata->irq,
> -				       mpc85xx_l2_isr, IRQF_DISABLED,
> +				       mpc85xx_l2_isr,
> +				       IRQF_DISABLED | IRQF_SHARED,
>  				       "[EDAC] L2 err", edac_dev);
>  		if (res < 0) {
>  			printk(KERN_ERR
> @@ -647,6 +650,9 @@ static struct of_device_id mpc85xx_l2_err_of_match[] = {
>  	{
>  	 .compatible = "fsl,8568-l2-cache-controller",
>  	 },
> +	{
> +	 .compatible = "fsl,8572-l2-cache-controller",
> +	 },
>  	{},
>  };
>  
> @@ -912,7 +918,8 @@ static int __devinit mpc85xx_mc_err_probe(struct of_device *op,
>  		/* register interrupts */
>  		pdata->irq = irq_of_parse_and_map(op->node, 0);
>  		res = devm_request_irq(&op->dev, pdata->irq,
> -				       mpc85xx_mc_isr, IRQF_DISABLED,
> +				       mpc85xx_mc_isr,
> +				       IRQF_DISABLED | IRQF_SHARED,
>  				       "[EDAC] MC err", mci);
>  		if (res < 0) {
>  			printk(KERN_ERR "%s: Unable to request irq %d for "
> @@ -980,6 +987,9 @@ static struct of_device_id mpc85xx_mc_err_of_match[] = {
>  	{
>  	 .compatible = "fsl,8568-memory-controller",
>  	 },
> +	{
> +	 .compatible = "fsl,8572-memory-controller",
> +	 },
>  	{},
>  };
>  
> @@ -995,6 +1005,12 @@ static struct of_platform_driver mpc85xx_mc_err_driver = {
>  		   },
>  };
>  
> +static void __init mpc85xx_mc_clear_rfxe(void *data)
> +{
> +	orig_hid1[smp_processor_id()] = mfspr(SPRN_HID1);
> +	mtspr(SPRN_HID1, (orig_hid1[smp_processor_id()] & ~0x20000));
> +}
> +
>  static int __init mpc85xx_mc_init(void)
>  {
>  	int res = 0;
> @@ -1031,8 +1047,7 @@ static int __init mpc85xx_mc_init(void)
>  	 * so we can catch it
>  	 */
>  	if (edac_op_state == EDAC_OPSTATE_INT) {
> -		orig_hid1 = mfspr(SPRN_HID1);
> -		mtspr(SPRN_HID1, (orig_hid1 & ~0x20000));
> +		on_each_cpu(mpc85xx_mc_clear_rfxe, NULL, 0);
>  	}
>  
>  	return 0;
> @@ -1040,9 +1055,14 @@ static int __init mpc85xx_mc_init(void)
>  
>  module_init(mpc85xx_mc_init);
>  
> +static void __exit mpc85xx_mc_restore_hid1(void *data)
> +{
> +	mtspr(SPRN_HID1, orig_hid1[smp_processor_id()]);
> +}
> +
>  static void __exit mpc85xx_mc_exit(void)
>  {
> -	mtspr(SPRN_HID1, orig_hid1);
> +	on_each_cpu(mpc85xx_mc_restore_hid1, NULL, 0);
>  #ifdef CONFIG_PCI
>  	of_unregister_platform_driver(&mpc85xx_pci_err_driver);
>  #endif


-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
