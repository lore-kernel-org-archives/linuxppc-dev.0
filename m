Return-Path: <chenhui.zhao@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8BDE32C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 15:00:14 +1100 (EST)
Date: Wed, 12 Mar 2014 11:59:54 +0800
From: Chenhui Zhao <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/9] powerpc/rcpm: add RCPM driver
Message-ID: <20140312035954.GB4706@localhost.localdomain>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
 <1394168285-32275-3-git-send-email-chenhui.zhao@freescale.com>
 <1394581371.13761.62.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1394581371.13761.62.camel@snotra.buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jason.Jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 11, 2014 at 06:42:51PM -0500, Scott Wood wrote:
> On Fri, 2014-03-07 at 12:57 +0800, Chenhui Zhao wrote:
> > diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
> > index b756f3d..3fdf9f3 100644
> > --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> > +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> > @@ -56,6 +56,8 @@ void __init corenet_gen_setup_arch(void)
> >  
> >  	swiotlb_detect_4g();
> >  
> > +	fsl_rcpm_init();
> > +
> >  	pr_info("%s board from Freescale Semiconductor\n", ppc_md.name);
> 
> RCPM is not board-specific.  Why is this in board code?

Init the RCPM driver in the early stage before smp_init(). Because
the time base sync calls a callback function .freeze_time_base()
in the RCPM driver.

Will use early_initcall() instead.

> 
> > +static void rcpm_v1_cpu_enter_state(int cpu, int state)
> > +{
> > +	unsigned int hw_cpu = get_hard_smp_processor_id(cpu);
> > +	unsigned int mask = 1 << hw_cpu;
> > +
> > +	switch (state) {
> > +	case E500_PM_PH10:
> > +		setbits32(&rcpm_v1_regs->cdozcr, mask);
> > +		break;
> > +	case E500_PM_PH15:
> > +		setbits32(&rcpm_v1_regs->cnapcr, mask);
> > +		break;
> > +	default:
> > +		pr_err("Unknown cpu PM state\n");
> > +		break;
> > +	}
> > +}
> 
> Put __func__ in error messages -- and for "unknown value" type messages,
> print the value.

OK.

> 
> 
> > +static int rcpm_v1_plat_enter_state(int state)
> > +{
> > +	u32 *pmcsr_reg = &rcpm_v1_regs->powmgtcsr;
> > +	int ret = 0;
> > +	int result;
> > +
> > +	switch (state) {
> > +	case PLAT_PM_SLEEP:
> > +		setbits32(pmcsr_reg, RCPM_POWMGTCSR_SLP);
> > +
> > +		/* At this point, the device is in sleep mode. */
> > +
> > +		/* Upon resume, wait for RCPM_POWMGTCSR_SLP bit to be clear. */
> > +		result = spin_event_timeout(
> > +		  !(in_be32(pmcsr_reg) & RCPM_POWMGTCSR_SLP), 10000, 10);
> > +		if (!result) {
> > +			pr_err("%s: timeout waiting for SLP bit to be cleared\n",
> > +			  __func__);
> 
> Why are you indenting continuation lines with only two spaces (and yet
> still not aligning with anything)?

Will align with the previous parenthesis.

> 
> > +			ret = -ETIMEDOUT;
> > +		}
> > +		break;
> > +	default:
> > +		pr_err("Unsupported platform PM state\n");
> > +		ret = -EINVAL;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static void rcpm_v1_freeze_time_base(int freeze)
> > +{
> > +	u32 *tben_reg = &rcpm_v1_regs->ctbenr;
> > +	static u32 mask;
> > +
> > +	if (freeze) {
> > +		mask = in_be32(tben_reg);
> > +		clrbits32(tben_reg, mask);
> > +	} else {
> > +		setbits32(tben_reg, mask);
> > +	}
> > +
> > +	/* read back to push the previous write */
> > +	in_be32(tben_reg);
> > +}
> > +
> > +static void rcpm_v2_freeze_time_base(int freeze)
> > +{
> > +	u32 *tben_reg = &rcpm_v2_regs->pctbenr;
> > +	static u32 mask;
> > +
> > +	if (freeze) {
> > +		mask = in_be32(tben_reg);
> > +		clrbits32(tben_reg, mask);
> > +	} else {
> > +		setbits32(tben_reg, mask);
> > +	}
> > +
> > +	/* read back to push the previous write */
> > +	in_be32(tben_reg);
> > +}
> 
> It looks like the only difference between these two functions is how you
> calculate tben_reg -- factor the rest out into a single function.

Yes. Will factor them out into a single function.

> 
> > +int fsl_rcpm_init(void)
> > +{
> > +	struct device_node *np;
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "fsl,qoriq-rcpm-2.0");
> > +	if (np) {
> > +		rcpm_v2_regs = of_iomap(np, 0);
> > +		of_node_put(np);
> > +		if (!rcpm_v2_regs)
> > +			return -ENOMEM;
> > +
> > +		qoriq_pm_ops = &qoriq_rcpm_v2_ops;
> > +
> > +	} else {
> > +		np = of_find_compatible_node(NULL, NULL, "fsl,qoriq-rcpm-1.0");
> > +		if (np) {
> > +			rcpm_v1_regs = of_iomap(np, 0);
> > +			of_node_put(np);
> > +			if (!rcpm_v1_regs)
> > +				return -ENOMEM;
> > +
> > +			qoriq_pm_ops = &qoriq_rcpm_v1_ops;
> > +
> > +		} else {
> > +			pr_err("%s: can't find the rcpm node.\n", __func__);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Why isn't this a proper platform driver?
> 
> -Scott

The RCPM is not a single function IP block, instead it is a collection
of device run control and power management. It would be called by other
drivers and functions. For example, the callback .freeze_time_base()
need to be called at early stage of kernel init. Therefore, it would be
better to init it at early stage.

-Chenhui
