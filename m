Return-Path: <scottwood@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3F0712C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 09:41:31 +1100 (EST)
Message-ID: <1384900872.1403.381.camel@snotra.buserror.net>
Subject: Re: [PATCH v5 01/17] powerpc/fsl-pci: improve clock API use
From: Scott Wood <scottwood@freescale.com>
To: Gerhard Sittig <gsi@denx.de>
Date: Tue, 19 Nov 2013 16:41:13 -0600
In-Reply-To: <1384729577-7336-2-git-send-email-gsi@denx.de>
References: <1384729577-7336-1-git-send-email-gsi@denx.de>
 <1384729577-7336-2-git-send-email-gsi@denx.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Minghuan Lian <Minghuan.Lian@freescale.com>, Paul Mackerras <paulus@samba.org>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-11-18 at 00:06 +0100, Gerhard Sittig wrote:
> make the Freescale PCI driver get, prepare and enable the PCI clock
> during probe(); the clock gets put upon device shutdown by the devm
> approach
> 
> clock lookup is non-fatal as not all platforms may provide clock specs
> in their device tree or implement a device tree based clock provider,
> but failure to enable clocks after successful lookup is fatal
> 
> the driver appears to not have a remove() routine, so no reference to
> the clock is kept during use, and the clock isn't released (the devm
> approach will put the clock, but it won't get disabled or unprepared)
> 
> the 85xx/86xx platforms go through the probe() routine, where clock
> lookup occurs and the clock gets acquired if one was specified; the
> 512x/83xx platforms don't pass through probe() but instead directly call
> the add_bridge() routine at a point in time where the clock provider has
> not been setup yet even if the platform implements one -- add comments
> to the code paths as a reminder for the potential need of a workaround
> in the platform's clock driver, and to keep awareness if code should get
> re-arranged or moved
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  arch/powerpc/sysdev/fsl_pci.c |   52 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)

Please coordinate this change with Minghuan Lian's patchset (posted Oct
23) to move the bulk of this driver outside of arch/powerpc.


> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index ccfb50ddfe38..efa0916f61b6 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -17,6 +17,8 @@
>   * Free Software Foundation;  either version 2 of the  License, or (at your
>   * option) any later version.
>   */
> +
> +#include <linux/clk.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/delay.h>
> @@ -755,6 +757,32 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
>  	const int *bus_range;
>  	int primary;
>  
> +	/*
> +	 * 85xx/86xx platforms take the path through the probe() routine
> +	 * as one would expect, PCI related clocks get acquired there if
> +	 * specified
> +	 *
> +	 * 83xx/512x _don't_ pass through probe(), this add_bridge()
> +	 * routine instead is called from within .setup_arch() at a
> +	 * point in time where clock providers haven't been setup yet;
> +	 * so clocks cannot get acquired here -- lookup would always
> +	 * fail even on those platforms which implement the provider
> +	 *
> +	 * there is no counterpart for add_bridge() just like there is
> +	 * no remove() counterpart for probe(), so in either case the
> +	 * PCI related clock won't get released, and all of the
> +	 * 512x/83xx/85xx/86xx platforms behave in identical ways

How is it identical if 85xx/86xx will acquire a clock in probe(), but
83xx/512x can't acquire it in add_bridge()?

Could you explain the relevance of releasing clocks here?

> +	 *
> +	 * this comment is here to "keep the balance" against the
> +	 * probe() routine, and as a reminder to acquire clocks if the
> +	 * add_bridge() call should move to some later point in time
> +	 *
> +	 * until then clock providers are expected to work around the
> +	 * peripheral driver's not acquiring the PCI clock on those
> +	 * platforms where clock providers exist, while nothing needs to
> +	 * be done for those platforms without a clock provider
> +	 */

What would be involved in moving 83xx/512x to use .probe() as well?

>  	is_mpc83xx_pci = 1;
>  
>  	if (!of_device_is_available(dev)) {
> @@ -1086,9 +1114,33 @@ void fsl_pci_assign_primary(void)
>  
>  static int fsl_pci_probe(struct platform_device *pdev)
>  {
> +	struct clk *clk;
>  	int ret;
>  	struct device_node *node;
>  
> +	/*
> +	 * clock lookup is non-fatal since the driver is shared among
> +	 * platforms and not all of them provide clocks specs in their
> +	 * device tree, but failure to enable a specified clock is
> +	 * considered fatal
> +	 *
> +	 * note that only the 85xx and 86xx platforms pass through this
> +	 * probe() routine, while 83xx and 512x directly invoke the
> +	 * mpc83xx_add_bridge() routine from within .setup_arch() code
> +	 */
> +	clk = devm_clk_get(&pdev->dev, "ipg");
> +	if (!IS_ERR(clk)) {
> +		ret = clk_prepare_enable(clk);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Could not enable PCI clock\n");
> +			return ret;
> +		}
> +		/*
> +		 * TODO where to store the 'clk' reference?  there appears
> +		 * to be no remove() routine which undoes what probe() does
> +		 */
> +	}

There is a .remove(); this driver just doesn't support it.

As for where to store things, you could turn private_data into a struct
rather than a direct iomem pointer.  Or just replace the comment with a
non-TODO statement that says we'll never release the clock because the
PCI controller driver is non-removable.

-Scott
