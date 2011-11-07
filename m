Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 93B891007D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 02:49:53 +1100 (EST)
Message-ID: <4EB7FE13.1000501@freescale.com>
Date: Mon, 7 Nov 2011 09:49:39 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH 6/7] fsl_pmc: Add API to enable device as wakeup event
 source
References: <1320410349-14600-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB455B1.8030009@freescale.com>
 <20111107112236.GB16470@localhost.localdomain>
In-Reply-To: <20111107112236.GB16470@localhost.localdomain>
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

On 11/07/2011 05:22 AM, Zhao Chenhui wrote:
> On Fri, Nov 04, 2011 at 04:14:25PM -0500, Scott Wood wrote:
>> On 11/04/2011 07:39 AM, Zhao Chenhui wrote:
>>> +	if (enable && !device_may_wakeup(&pdev->dev))
>>> +		return -EINVAL;
>>> +
>>> +	clk_np = of_parse_phandle(pdev->dev.of_node, "clk-handle", 0);
>>> +	if (!clk_np)
>>> +		return -EINVAL;
>>> +
>>> +	pmcdr_mask = (u32 *)of_get_property(clk_np, "fsl,pmcdr-mask", NULL);
>>> +	if (!pmcdr_mask) {
>>> +		ret = -EINVAL;
>>> +		goto out;
>>> +	}
>>> +
>>> +	/* clear to enable clock in low power mode */
>>> +	if (enable)
>>> +		clrbits32(&pmc_regs->pmcdr, *pmcdr_mask);
>>> +	else
>>> +		setbits32(&pmc_regs->pmcdr, *pmcdr_mask);
>>
>> We should probably initialize PMCDR to all bits set (or at least all
>> ones we know are valid) -- the default should be "not a wakeup source".
> 
> I think it should be initialized in u-boot.

I don't see it.  If you mean you think this should be added to U-Boot, I
disagree.  U-Boot does not use this, and we should not add gratuitous
U-Boot dependencies to Linux -- especially in cases where there are
existing U-Boots in use for relevant boards, that do not have this.

>>> +/**
>>> + * pmc_enable_lossless - enable lossless ethernet in low power mode
>>> + * @enable: True to enable event generation; false to disable
>>> + */
>>> +void pmc_enable_lossless(int enable)
>>> +{
>>> +	if (enable && has_lossless)
>>> +		setbits32(&pmc_regs->pmcsr, PMCSR_LOSSLESS);
>>> +	else
>>> +		clrbits32(&pmc_regs->pmcsr, PMCSR_LOSSLESS);
>>> +}
>>> +EXPORT_SYMBOL_GPL(pmc_enable_lossless);
>>> +#endif
>>
>> Won't we overwrite this later?
>>
>> -Scott
> 
> Do you have any idea?

Set a flag that the code that enters (deep) sleep can use.

Also, rename function to mpc85xx_pmc_set_lossless_ethernet().

-Scott
