Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 52E85B7CEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Feb 2010 21:01:43 +1100 (EST)
Subject: Re: [PATCHv4 2/2] powerpc: implement arch_scale_smt_power for Power7
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <14639.1266559532@neuling.org>
References: <1264017638.5717.121.camel@jschopp-laptop>
	<1264017847.5717.132.camel@jschopp-laptop>
	<1264548495.12239.56.camel@jschopp-laptop>
	<1264720855.9660.22.camel@jschopp-laptop>
	<1264721088.10385.1.camel@jschopp-laptop>
	<1265403478.6089.41.camel@jschopp-laptop>
	<1266142340.5273.418.camel@laptop> <25851.1266445258@neuling.org>
	<1266499023.26719.597.camel@laptop>  <14639.1266559532@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 19 Feb 2010 11:01:12 +0100
Message-ID: <1266573672.1806.70.camel@laptop>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, ego@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-02-19 at 17:05 +1100, Michael Neuling wrote:

> >  include/linux/sched.h |    2 +-
> >  kernel/sched_fair.c   |   61 +++++++++++++++++++++++++++++++++++++++++++++--
> -
> >  2 files changed, 58 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 0eef87b..42fa5c6 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -849,7 +849,7 @@ enum cpu_idle_type {
> >  #define SD_POWERSAVINGS_BALANCE	0x0100	/* Balance for power savings */
> >  #define SD_SHARE_PKG_RESOURCES	0x0200	/* Domain members share cpu pkg
>  resources */
> >  #define SD_SERIALIZE		0x0400	/* Only a single load balancing instanc
> e */
> > -
> > +#define SD_ASYM_PACKING		0x0800
> 
> Would we eventually add this to SD_SIBLING_INIT in a arch specific hook,
> or is this ok to add it generically?

I'd think we'd want to keep that limited to architectures that actually
need it.

>  
> > +static int update_sd_pick_busiest(struct sched_domain *sd,
> > +	       			  struct sd_lb_stats *sds,
> > +				  struct sched_group *sg,
> > +			  	  struct sg_lb_stats *sgs)
> > +{
> > +	if (sgs->sum_nr_running > sgs->group_capacity)
> > +		return 1;
> > +
> > +	if (sgs->group_imb)
> > +		return 1;
> > +
> > +	if ((sd->flags & SD_ASYM_PACKING) && sgs->sum_nr_running) {
> > +		if (!sds->busiest)
> > +			return 1;
> > +
> > +		if (group_first_cpu(sds->busiest) < group_first_cpu(group))
> 
> "group" => "sg" here? (I get a compile error otherwise)

Oh, quite ;-)

> > +static int check_asym_packing(struct sched_domain *sd,
> > +				    struct sd_lb_stats *sds, 
> > +				    int cpu, unsigned long *imbalance)
> > +{
> > +	int i, cpu, busiest_cpu;
> 
> Redefining cpu here.  Looks like the cpu parameter is not really needed?

Seems that way indeed, I went back and forth a few times on the actual
implementation of this function (which started out live as a copy of
check_power_save_busiest_group), its amazing there were only these two
compile glitches ;-)

> > +
> > +	if (!(sd->flags & SD_ASYM_PACKING))
> > +		return 0;
> > +
> > +	if (!sds->busiest)
> > +		return 0;
> > +
> > +	i = 0;
> > +	busiest_cpu = group_first_cpu(sds->busiest);
> > +	for_each_cpu(cpu, sched_domain_span(sd)) {
> > +		i++;
> > +		if (cpu == busiest_cpu)
> > +			break;
> > +	}
> > +
> > +	if (sds->total_nr_running > i)
> > +		return 0;
> > +
> > +	*imbalance = sds->max_load;
> > +	return 1;
> > +}
