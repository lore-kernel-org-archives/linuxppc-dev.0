Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0111.outbound.protection.outlook.com [207.46.100.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F2A91A02C2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2015 21:10:43 +1000 (AEST)
Date: Mon, 3 Aug 2015 19:10:32 +0800
From: Chenhui Zhao <chenhui.zhao@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: add sleep and deep sleep support
To: Scott Wood <scottwood@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <Jason.Jin@freescale.com>
Message-ID: <1438600232.7515.0@remotesmtp.freescale.net>
In-Reply-To: <1438397837.2097.4.camel@freescale.com>
References: <1437741961-6663-1-git-send-email-chenhui.zhao@freescale.com>
 <1438397837.2097.4.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Sat, Aug 1, 2015 at 10:57 AM, Scott Wood <scottwood@freescale.com> 
wrote:
> On Fri, 2015-07-24 at 20:46 +0800, Chenhui Zhao wrote:
>>  +static void mpc85xx_pmc_set_wake(struct device *dev, void *enable)
>>   {
>>        int ret;
>>  +     u32 value[2];
>>  +
>>  +     if (!device_may_wakeup(dev))
>>  +             return;
>>  +
>>  +     if (!pmc_regs) {
>>  +             dev_err(dev, "%s: PMC is unavailable\n", __func__);
>>  +             return;
>>  +     }
>>  +
>>  +     ret = of_property_read_u32_array(dev->of_node, "sleep", 
>> value, 2);
> 
> This will crash on any device without an of_node.

Add this before this line:
if (!dev->of_node)
	return;

> 
> 
>>  +     if (ret) {
>>  +             dev_dbg(dev, "%s: Can not find the \"sleep\" 
>> property.\n",
>>  +                     __func__);
>>  +             return;
>>  +     }
>>  +
>>  +     if (*(int *)enable)
>>  +             pmc_pmcdr_mask &= ~value[1];
>>  +     else
>>  +             pmc_pmcdr_mask |= value[1];
>>  +
>>  +     if ((value[1] & 0xe0) && (pmc_flag & PMC_LOSSLESS))
>>  +             pmc_powmgtcsr = POWMGTCSR_LOSSLESS;
>>  +}
> 
> What is 0xe0?
> 
> -Scott

This is a mask value for the register PMCDR, which includes all bits 
corresponding to eTSEC. Will use a macro instead.

-Chenhui
