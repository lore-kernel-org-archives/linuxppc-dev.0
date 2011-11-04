Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6A6F1B6F69
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2011 08:14:36 +1100 (EST)
Message-ID: <4EB455B1.8030009@freescale.com>
Date: Fri, 4 Nov 2011 16:14:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH 6/7] fsl_pmc: Add API to enable device as wakeup event
 source
References: <1320410349-14600-1-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1320410349-14600-1-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/04/2011 07:39 AM, Zhao Chenhui wrote:
> @@ -45,6 +46,72 @@ static int has_lossless;
>   * code can be compatible with both 32-bit & 36-bit */
>  extern void mpc85xx_enter_deep_sleep(u64 ccsrbar, u32 powmgtreq);
>  
> +#ifdef CONFIG_FSL_PMC
> +/**
> + * pmc_enable_wake - enable OF device as wakeup event source
> + * @pdev: platform device affected
> + * @state: PM state from which device will issue wakeup events
> + * @enable: True to enable event generation; false to disable
> + *
> + * This enables the device as a wakeup event source, or disables it.
> + *
> + * RETURN VALUE:
> + * 0 is returned on success
> + * -EINVAL is returned if device is not supposed to wake up the system
> + * Error code depending on the platform is returned if both the platform and
> + * the native mechanism fail to enable the generation of wake-up events
> + */
> +int pmc_enable_wake(struct platform_device *pdev,
> +				suspend_state_t state, bool enable)

"pmc" is too generic for a global function.  If this can be either
enable or disable, perhaps it should be something like
mpc85xx_pmc_set_wake().

> +{
> +	int ret = 0;
> +	struct device_node *clk_np;
> +	u32 *pmcdr_mask;
> +
> +	if (!pmc_regs) {
> +		printk(KERN_WARNING "PMC is unavailable\n");
> +		return -ENOMEM;
> +	}

-ENOMEM is not appropriate here, maybe -ENODEV?

Should print __func__ so the user knows what's complaining.

> +	if (enable && !device_may_wakeup(&pdev->dev))
> +		return -EINVAL;
> +
> +	clk_np = of_parse_phandle(pdev->dev.of_node, "clk-handle", 0);
> +	if (!clk_np)
> +		return -EINVAL;
> +
> +	pmcdr_mask = (u32 *)of_get_property(clk_np, "fsl,pmcdr-mask", NULL);
> +	if (!pmcdr_mask) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* clear to enable clock in low power mode */
> +	if (enable)
> +		clrbits32(&pmc_regs->pmcdr, *pmcdr_mask);
> +	else
> +		setbits32(&pmc_regs->pmcdr, *pmcdr_mask);

We should probably initialize PMCDR to all bits set (or at least all
ones we know are valid) -- the default should be "not a wakeup source".

> +/**
> + * pmc_enable_lossless - enable lossless ethernet in low power mode
> + * @enable: True to enable event generation; false to disable
> + */
> +void pmc_enable_lossless(int enable)
> +{
> +	if (enable && has_lossless)
> +		setbits32(&pmc_regs->pmcsr, PMCSR_LOSSLESS);
> +	else
> +		clrbits32(&pmc_regs->pmcsr, PMCSR_LOSSLESS);
> +}
> +EXPORT_SYMBOL_GPL(pmc_enable_lossless);
> +#endif

Won't we overwrite this later?

-Scott
