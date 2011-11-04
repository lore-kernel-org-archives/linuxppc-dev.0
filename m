Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 457A4B6FA0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2011 05:45:30 +1100 (EST)
Received: from mail110-db3 (localhost.localdomain [127.0.0.1])	by
 mail110-db3-R.bigfish.com (Postfix) with ESMTP id 2AC498C83F2	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 18:45:17 +0000 (UTC)
Received: from DB3EHSMHS019.bigfish.com (unknown [10.3.81.245])	by
 mail110-db3.bigfish.com (Postfix) with ESMTP id E40A410C8050	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 18:45:16 +0000 (UTC)
Message-ID: <4EB432C1.1000601@freescale.com>
Date: Fri, 4 Nov 2011 13:45:21 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH 3/7] powerpc/85xx: add sleep and deep sleep support
References: <1320410014-14453-1-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1320410014-14453-1-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/04/2011 07:33 AM, Zhao Chenhui wrote:
> +/* Cast the ccsrbar to 64-bit parameter so that the assembly
> + * code can be compatible with both 32-bit & 36-bit */
> +extern void mpc85xx_enter_deep_sleep(u64 ccsrbar, u32 powmgtreq);

/*
 * Please use proper
 * Linux multi-line comment format.
 */

>  static int pmc_suspend_enter(suspend_state_t state)
>  {
>  	int ret;
> +	u32 powmgtreq = 0x00500000;

Where does this 0x00500000 come from?  Please symbolically define
individual bits.

The comment in the asm code says it should be 0x00100000, BTW.

> +
> +	switch (state) {
> +	case PM_SUSPEND_MEM:
> +#ifdef CONFIG_SPE
> +		enable_kernel_spe();
> +#endif

Should comment that currently only e500v2 hardware supports deep sleep
-- else we'd need to save normal FP here.

> +		pr_debug("Entering deep sleep\n");
> +
> +		local_irq_disable();
> +		mpc85xx_enter_deep_sleep(get_immrbase(),
> +				powmgtreq);
> +		pr_debug("Resumed from deep sleep\n");
> +
> +		return 0;
> +
> +	/* else fall-through */
> +	case PM_SUSPEND_STANDBY:

What fall-through?  You just returned.

> +	}
>  
> -	/* Upon resume, wait for SLP bit to be clear. */
> -	ret = spin_event_timeout((in_be32(&pmc_regs->pmcsr) & PMCSR_SLP) == 0,
> -				 10000, 10) ? 0 : -ETIMEDOUT;
> -	if (ret)
> -		dev_err(pmc_dev, "tired waiting for SLP bit to clear\n");
> -	return ret;
>  }

Remove that blank line as well.

> @@ -58,13 +101,23 @@ static const struct platform_suspend_ops pmc_suspend_ops = {
>  	.enter = pmc_suspend_enter,
>  };
>  
> -static int pmc_probe(struct platform_device *ofdev)
> +static int pmc_probe(struct platform_device *pdev)
>  {
> -	pmc_regs = of_iomap(ofdev->dev.of_node, 0);
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	pmc_regs = of_iomap(pdev->dev.of_node, 0);
>  	if (!pmc_regs)
>  		return -ENOMEM;
>  
> -	pmc_dev = &ofdev->dev;
> +	has_deep_sleep = 0;
> +	if (of_device_is_compatible(np, "fsl,mpc8536-pmc"))
> +		has_deep_sleep = 1;
> +
> +	has_lossless = 0;
> +	if (of_device_is_compatible(np, "fsl,p1022-pmc"))
> +		has_lossless = 1;
> +

You never use has_lossless.

-Scott
