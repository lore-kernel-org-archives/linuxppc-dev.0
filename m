Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0130.outbound.protection.outlook.com [65.55.169.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED3341A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 10:40:19 +1000 (AEST)
Date: Fri, 28 Aug 2015 08:40:22 +0800
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2,2/5] powerpc/rcpm: add RCPM driver
To: Scott Wood <scottwood@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <Jason.Jin@freescale.com>
Message-ID: <1440722422.31670.0@remotesmtp.freescale.net>
In-Reply-To: <20150826203539.GA10582@home.buserror.net>
References: <1440590988-25594-1-git-send-email-chenhui.zhao@freescale.com>
 <1440590988-25594-2-git-send-email-chenhui.zhao@freescale.com>
 <20150826203539.GA10582@home.buserror.net>
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



On Thu, Aug 27, 2015 at 4:35 AM, Scott Wood <scottwood@freescale.com> 
wrote:
> On Wed, Aug 26, 2015 at 08:09:45PM +0800, Chenhui Zhao wrote:
>>  +#ifdef CONFIG_PPC_BOOK3E
>>  +static void qoriq_disable_thread(int cpu)
>>  +{
>>  +	int hw_cpu = get_hard_smp_processor_id(cpu);
>>  +	int thread = cpu_thread_in_core(hw_cpu);
>>  +
>>  +	mtspr(SPRN_TENC, TEN_THREAD(thread));
>>  +}
>>  +#endif
> 
> This file is always used on book3e.  If the intent is to only build 
> this
> on 64-bit, use CONFIG_PPC64 rather than relying on the fact that this 
> one
> of the confusing mess of BOOKE/BOOK3E symbols is 64-bit-only.

OK. Will use CONFIG_PPC64.

> 
>>  +static void rcpm_v2_cpu_die(int cpu)
>>  +{
>>  +#ifdef CONFIG_PPC_BOOK3E
>>  +	int primary;
>>  +
>>  +	if (threads_per_core == 2) {
>>  +		primary = cpu_first_thread_sibling(cpu);
>>  +		if (cpu_is_offline(primary) && cpu_is_offline(primary + 1)) {
>>  +			/* if both threads are offline, put the cpu in PH20 */
>>  +			rcpm_v2_cpu_enter_state(cpu, E500_PM_PH20);
>>  +		} else {
>>  +			/* if only one thread is offline, disable the thread */
>>  +			qoriq_disable_thread(cpu);
>>  +		}
>>  +	}
>>  +#endif
>>  +
>>  +	if (threads_per_core == 1) {
>>  +		rcpm_v2_cpu_enter_state(cpu, E500_PM_PH20);
>>  +		return;
>>  +	}
>>  +}
> 
> That "return;" adds nothing, and it's even more awkward having it on 
> the
> one-thread case but not the two-thread case.

Will get rid of it.

> 
> 
>>  +static void rcpm_v1_cpu_up_prepare(int cpu)
>>  +{
>>  +	rcpm_v1_cpu_exit_state(cpu, E500_PM_PH15);
>>  +	rcpm_v1_irq_unmask(cpu);
>>  +}
>>  +
>>  +static void rcpm_v2_cpu_exit_state(int cpu, int state)
>>  +{
>>  +	int hw_cpu = get_hard_smp_processor_id(cpu);
>>  +	u32 mask = 1 << cpu_core_index_of_thread(hw_cpu);
> 
> Are you sure cpu_core_index_of_thread() is supposed to take a hardware
> cpu id?  The only current user, pseries_energy.c, has the comment
> "Convert logical cpu number to core number".

Here, the method of getting core index of thread is same for physical 
and logical.
So use this existed function to do the job.

> 
>>  +static const struct of_device_id rcpm_matches[] = {
>>  +	{
>>  +		.compatible = "fsl,qoriq-rcpm-1.0",
>>  +		.data = (void *)&qoriq_rcpm_v1_ops,
>>  +	},
>>  +	{
>>  +		.compatible = "fsl,qoriq-rcpm-2.0",
>>  +		.data = (void *)&qoriq_rcpm_v2_ops,
>>  +	},
>>  +	{
>>  +		.compatible = "fsl,qoriq-rcpm-2.1",
>>  +		.data = (void *)&qoriq_rcpm_v2_ops,
>>  +	},
>>  +	{},
>>  +};
> 
> Unnecessary (and const-unsafe) casts.
> 
> 
>>  +
>>  +int __init fsl_rcpm_init(void)
>>  +{
>>  +	struct device_node *np;
>>  +	const struct of_device_id *match;
>>  +	void __iomem *base;
>>  +
>>  +	np = of_find_matching_node_and_match(NULL, rcpm_matches, &match);
>>  +	if (!np) {
>>  +		pr_err("can't find the rcpm node.\n");
>>  +		return -ENODEV;
>>  +	}
> 
> It's not an error for the device tree node to not have this.
> 
> -Scott

Thanks.

-Chenhui
