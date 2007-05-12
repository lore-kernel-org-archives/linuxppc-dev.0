Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 4528ADDEC8
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 09:27:12 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/9] powerpc: BestComm core support for Freescale MPC5200
Date: Sun, 13 May 2007 01:27:08 +0200
References: <11790019171838-git-send-email-tnt@246tNt.com>
	<11790019223925-git-send-email-tnt@246tNt.com>
	<11790019234031-git-send-email-tnt@246tNt.com>
In-Reply-To: <11790019234031-git-send-email-tnt@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705130127.08761.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 12 May 2007, Sylvain Munaut wrote:

> This patch adds support for the core of the BestComm API
> for the Freescale MPC5200(b). The BestComm engine is a
> microcode-controlled / tasks-based DMA used by several
> of the onchip devices.

Have you tried if the DMA engine API that is now in drivers/dma
fits the hardware interfaces? Could they perhaps be extended to
do so?

> +struct bcom_engine *bcom = NULL;

Doe this need to be a global? In most cases, you get a cleaner driver by
passing around pointers through function calls and your own device specific
data structures.

If you can't make that work, at least give it a longer name to make sure
it doesn't conflict with other global variables.

> +/* ======================================================================== */
> +/* Public and private API                                                   */
> +/* ======================================================================== */
> +
> +/* Debug Dump */
> +
> +#define BCOM_DPRINTK(a,b...) printk(KERN_DEBUG DRIVER_NAME ": " a, ## b)

just use pr_debug in new code instead of defining your own

> +static int __init
> +mpc52xx_bcom_init(void)
> +{
> +	struct device_node *ofn_bcom, *ofn_sram;
> +	struct resource res_bcom;
> +
> +	int rv;
> +
> +	/* Find the bestcomm node. If none, fails 'silently' since
> +	 * we may just be on another platform */
> +	ofn_bcom = of_find_compatible_node(
> +			NULL, "dma-controller", "mpc5200-bestcomm");
> +	if (!ofn_bcom)
> +		return -ENODEV;

I know, my usual rant is getting old, but why is this one not an
of_platform_driver? It's not shared with arch/ppc or with arch/mips,
and it's not needed before module_init() time.

> +
> +#ifdef MODULE
> +module_init(mpc52xx_bcom_init);
> +module_exit(mpc52xx_bcom_exit);
> +#endif
> +
> +/* If we're not a module, we must make sure everything is setup before anyone */
> +/* tries to use us ... */
> +#ifndef MODULE
> +subsys_initcall(mpc52xx_bcom_init);
> +#endif

You can make it subsys_initcall() unconditionally. If the driver gets built
as a module, it will turn into module_init() by itself.

> +MODULE_DESCRIPTION("Freescale MPC52xx BestComm DMA");
> +MODULE_AUTHOR("Sylvain Munaut <tnt@246tNt.com>");
> +MODULE_AUTHOR("Andrey Volkov <avolkov@varma-el.com>");
> +MODULE_AUTHOR("Dale Farnsworth <dfarnsworth@mvista.com>");
> +MODULE_LICENSE("GPL v2");

I didn't know that you could have multiple MODULE_AUTHOR statements.
Does this do the right thing with /bin/modinfo?

> +EXPORT_SYMBOL(bcom);
> +EXPORT_SYMBOL(bcom_dump_status);
> +EXPORT_SYMBOL(bcom_dump_task);
> +EXPORT_SYMBOL(bcom_dump_bdring);
> +EXPORT_SYMBOL(bcom_task_alloc);
> +EXPORT_SYMBOL(bcom_task_release);
> +EXPORT_SYMBOL(bcom_load_image);
> +EXPORT_SYMBOL(bcom_set_initiator);
> +EXPORT_SYMBOL(bcom_enable);
> +EXPORT_SYMBOL(bcom_disable);

Please put every EXPORT_SYMBOL right after the definition of the symbol
you are exporting.

Why don't you use EXPORT_SYMBOL_GPL?

> +
> +EXPORT_SYMBOL(bcom_sram);
> +
> +EXPORT_SYMBOL(bcom_sram_init);
> +EXPORT_SYMBOL(bcom_sram_cleanup);
> +EXPORT_SYMBOL(bcom_sram_alloc);
> +EXPORT_SYMBOL(bcom_sram_free);
> +
Same comment as above.

	Arnd <><
