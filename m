Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2CBF31A0034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 13:53:38 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 24 Jun 2015 13:53:36 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D59CB2CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 13:53:33 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5O3rPXm12910654
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 13:53:33 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5O3r0nb024928
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 13:53:00 +1000
Message-ID: <558A2986.1030505@linux.vnet.ibm.com>
Date: Wed, 24 Jun 2015 09:22:38 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 rusty@rustcorp.com.au, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 6/7]powerpc/powernv: generic nest pmu event functions
References: <1433999874-2043-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1433999874-2043-7-git-send-email-maddy@linux.vnet.ibm.com>
 <20150623014949.GE25856@us.ibm.com>
In-Reply-To: <20150623014949.GE25856@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 23 June 2015 07:19 AM, Sukadev Bhattiprolu wrote:
> Madhavan Srinivasan [maddy@linux.vnet.ibm.com] wrote:
> | From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> | Subject: [PATCH v2 6/7]powerpc/powernv: generic nest pmu event functions
> | 
> | Add generic format attribute and set of generic nest pmu related
> | event functions to be used by each nest pmu. Add code to register nest pmus.
> | 
> | Cc: Michael Ellerman <mpe@ellerman.id.au>
> | Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> | Cc: Paul Mackerras <paulus@samba.org>
> | Cc: Anton Blanchard <anton@samba.org>
> | Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> | Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> | Cc: Stephane Eranian <eranian@google.com>
> | Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> | ---
> |  arch/powerpc/perf/nest-pmu.c | 109 +++++++++++++++++++++++++++++++++++++++++++
> |  1 file changed, 109 insertions(+)
> | 
> | diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
> | index 8fad2d9..a662c14 100644
> | --- a/arch/powerpc/perf/nest-pmu.c
> | +++ b/arch/powerpc/perf/nest-pmu.c
> | @@ -13,6 +13,108 @@
> |  static struct perchip_nest_info p8_perchip_nest_info[P8_MAX_CHIP];
> |  static struct nest_pmu *per_nest_pmu_arr[P8_MAX_NEST_PMUS];
> | 
> | +PMU_FORMAT_ATTR(event, "config:0-20");
> | +struct attribute *p8_nest_format_attrs[] = {
> | +	&format_attr_event.attr,
> | +	NULL,
> | +};
> | +
> | +struct attribute_group p8_nest_format_group = {
> | +	.name = "format",
> | +	.attrs = p8_nest_format_attrs,
> | +};
>
> Could this be included in previous/separate patch? That way,
> this patch could focus on just registering the nest-pmu.

Yes. Will move it.

> | +
> | +static int p8_nest_event_init(struct perf_event *event)
> | +{
> | +	int chip_id;
> | +
> | +	if (event->attr.type != event->pmu->type)
> | +		return -ENOENT;
> | +
> | +	/* Sampling not supported yet */
> | +	if (event->hw.sample_period)
> | +		return -EINVAL;
> | +
> | +	/* unsupported modes and filters */
> | +	if (event->attr.exclude_user   ||
> | +	    event->attr.exclude_kernel ||
> | +	    event->attr.exclude_hv     ||
> | +	    event->attr.exclude_idle   ||
> | +	    event->attr.exclude_host   ||
> | +	    event->attr.exclude_guest)
> | +		return -EINVAL;
> | +
> | +	if (event->cpu < 0)
> | +		return -EINVAL;
> | +
> | +	chip_id = topology_physical_package_id(event->cpu);
> | +	event->hw.event_base = event->attr.config +
> | +				p8_perchip_nest_info[chip_id].vbase;
> | +
> | +	return 0;
> | +}
> | +
> | +static void p8_nest_read_counter(struct perf_event *event)
> | +{
> | +	u64 *addr;
> | 
>
> Define as uint64_t so we can eliminate one cast below? Would also
> be consistent with p8_nest_perf_event_update().
Yes make sense.

> | 
> | +	u64 data = 0;
> | +
> | +	addr = (u64 *)event->hw.event_base;
> | +	data = __be64_to_cpu((uint64_t)*addr);
> | +	local64_set(&event->hw.prev_count, data);
> | +}
> | +
> | +static void p8_nest_perf_event_update(struct perf_event *event)
> | +{
> | +	u64 counter_prev, counter_new, final_count;
> | +	uint64_t *addr;
> | +
> | +	addr = (u64 *)event->hw.event_base;
>
> uint64_t *?
My bad.  will change it.

> | +	counter_prev = local64_read(&event->hw.prev_count);
> | +	counter_new = __be64_to_cpu((uint64_t)*addr);
>
> Redundant cast? addr is already uint64_t *?

Nice catch. Will remove it.
> | +	final_count = counter_new - counter_prev;
> | +
> | +	local64_set(&event->hw.prev_count, counter_new);
> | +	local64_add(final_count, &event->count);
> | +}
> | +
> | +static void p8_nest_event_start(struct perf_event *event, int flags)
> | +{
>
> Check PERF_EF_RELOAD before reloading?
>
> | +	event->hw.state = 0;
> | +	p8_nest_read_counter(event);
> | +}
> | +
> | +static void p8_nest_event_stop(struct perf_event *event, int flags)
> | +{
>
> Check PERF_EF_UPDATE when stopping?
>
> | +	p8_nest_perf_event_update(event);
> | +}
> | +
> | +static int p8_nest_event_add(struct perf_event *event, int flags)
> | +{
>
> Check PERF_EF_START flags before starting the counter on an ->add()?
Will add the flags.

> | +	p8_nest_event_start(event, flags);
> | +	return 0;
> | +}
> | +
> | +/*
> | + * Populate pmu ops in the structure
> | + */
> | +static int update_pmu_ops(struct nest_pmu *pmu)
> | +{
> | +	if (!pmu)
> | +		return -EINVAL;
> | +
> | +	pmu->pmu.task_ctx_nr = perf_invalid_context;
> | +	pmu->pmu.event_init = p8_nest_event_init;
> | +	pmu->pmu.add = p8_nest_event_add;
> | +	pmu->pmu.del = p8_nest_event_stop;
> | +	pmu->pmu.start = p8_nest_event_start;
> | +	pmu->pmu.stop = p8_nest_event_stop;
> | +	pmu->pmu.read = p8_nest_perf_event_update;
> | +	pmu->pmu.attr_groups = pmu->attr_groups;
> | +
> | +	return 0;
> | +}
> | +
> |  /*
> |   * Populate event name and string in attribute
> |   */
> | @@ -106,6 +208,7 @@ static int nest_pmu_create(struct device_node *dev, int pmu_index)
> |  			/* Save the name to register the PMU with it */
> |  			sprintf(buf, "Nest_%s", (char *)pp->value);
> |  			pmu_ptr->pmu.name = (char *)buf;
> | +			pmu_ptr->attr_groups[1] = &p8_nest_format_group;
> |  		}
> | 
> |  		/* Skip these, we dont need it */
> | @@ -179,6 +282,12 @@ static int nest_pmu_create(struct device_node *dev, int pmu_index)
> |  		(struct ppc64_nest_ima_events *)p8_events_arr,
> |  							idx, pmu_ptr);
> | 
> | +	update_pmu_ops(pmu_ptr);
> | +
> | +	/* Register the pmu */
> | +	perf_pmu_register(&pmu_ptr->pmu, pmu_ptr->pmu.name, -1);
>
> There is a small chance that perf_pmu_register() can fail.
Sure. Will have a check for the return value.

Thanks for review
Maddy
> | +	printk(KERN_INFO "Nest PMU %s Registered\n", pmu_ptr->pmu.name);
> | +
> |  	return 0;
> |  }
> | 
> | -- 
> | 1.9.1
> | 
