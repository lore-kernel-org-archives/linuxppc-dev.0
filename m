Return-Path: <dja@axtens.net>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxw9g40VyzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 13:55:35 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id 81so34238622pgh.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 20:55:35 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, benh@kernel.crashing.org,
 paulus@samba.org, anton@samba.org, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org, stewart@linux.vnet.ibm.com, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 05/11] powerpc/perf: Generic imc pmu event functions
In-Reply-To: <1491231308-15282-6-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491231308-15282-6-git-send-email-maddy@linux.vnet.ibm.com>
Date: Tue, 04 Apr 2017 13:55:29 +1000
Message-ID: <878tngltce.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

So a major complaint I have is that you're changing prototypes of
functions from earlier patches.

This makes my life a lot harder: I get my head around what a function is
and does and then suddenly the prototype changes, the behaviour changes,
and I have to re-evaluate everything I thought I knew about the
function. The diffs are also usually quite unhelpful.

It would be far better, from my point of view, to squash related commits
together. You're adding a large-ish driver: we might as well review one
large, complete commit rather than several smaller incomplete commits.

There are a lot of interrelated benefits to this - just from the patches
I've reviewed so far, if there were fewer, larger commits then:

 - I would only have to read a function once to get a full picture of
   what it does

 - comments in function headers wouldn't get out of sync with function
   bodies

 - there would be less movement of variables from file to file

 - earlier comments wouldn't be invalidated by things I learn later. For
   example I suggested different names for imc_event_info_{str,val}
   based on their behaviour when first added in patch 3. Here you change
   the behaviour of imc_event_info_val - it would have been helpful to
   see the fuller picture when I was first reviewing as I would have
   been able to make more helpful suggestions.

and so on.

Anyway, further comments in line.

> From: Hemant Kumar <hemant@linux.vnet.ibm.com>
>
> Since, the IMC counters' data are periodically fed to a memory location,
> the functions to read/update, start/stop, add/del can be generic and can
> be used by all IMC PMU units.
>
> This patch adds a set of generic imc pmu related event functions to be
> used  by each imc pmu unit. Add code to setup format attribute and to
> register imc pmus. Add a event_init function for nest_imc events.
>
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/imc-pmu.h        |   1 +
>  arch/powerpc/perf/imc-pmu.c               | 137 ++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal-imc.c |  30 ++++++-
>  3 files changed, 164 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
> index a3d4f1bf9492..e13f51047522 100644
> --- a/arch/powerpc/include/asm/imc-pmu.h
> +++ b/arch/powerpc/include/asm/imc-pmu.h
> @@ -65,4 +65,5 @@ struct imc_pmu {
>  #define IMC_DOMAIN_NEST		1
>  #define IMC_DOMAIN_UNKNOWN	-1
>  
> +int imc_get_domain(struct device_node *pmu_dev);
>  #endif /* PPC_POWERNV_IMC_PMU_DEF_H */
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index ec464c76b749..bd5bf66bd920 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -18,6 +18,132 @@
>  struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
>  struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
>  
> +/* Needed for sanity check */
> +extern u64 nest_max_offset;
Should this be in a header file?

> +
> +PMU_FORMAT_ATTR(event, "config:0-20");
> +static struct attribute *imc_format_attrs[] = {
> +	&format_attr_event.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group imc_format_group = {
> +	.name = "format",
> +	.attrs = imc_format_attrs,
> +};
> +
> +static int nest_imc_event_init(struct perf_event *event)
> +{
> +	int chip_id;
> +	u32 config = event->attr.config;
> +	struct perchip_nest_info *pcni;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/* Sampling not supported */
> +	if (event->hw.sample_period)
> +		return -EINVAL;
> +
> +	/* unsupported modes and filters */
> +	if (event->attr.exclude_user   ||
> +	    event->attr.exclude_kernel ||
> +	    event->attr.exclude_hv     ||
> +	    event->attr.exclude_idle   ||
> +	    event->attr.exclude_host   ||
> +	    event->attr.exclude_guest)
> +		return -EINVAL;
> +
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +
> +	/* Sanity check for config (event offset) */
> +	if (config > nest_max_offset)
> +		return -EINVAL;
config is a u32, nest_max_offset is a u64. Is there a reason for this?
(Also, config is an unintuitive name for the local variable - the data
is stored in the attribute config space but the value represents an
offset into the reserved memory region.)

> +
> +	chip_id = topology_physical_package_id(event->cpu);
> +	pcni = &nest_perchip_info[chip_id];
> +
> +	/*
> +	 * Memory for Nest HW counter data could be in multiple pages.
> +	 * Hence check and pick the right base page from the event offset,
> +	 * and then add to it.
> +	 */
> +	event->hw.event_base = pcni->vbase[config/PAGE_SIZE] +
> +							(config & ~PAGE_MASK);
> +
> +	return 0;
> +}
> +
> +static void imc_read_counter(struct perf_event *event)
> +{
> +	u64 *addr, data;
> +
> +	addr = (u64 *)event->hw.event_base;
> +	data = __be64_to_cpu(READ_ONCE(*addr));

It looks like this would trigger a sparse violation.
I would have thought addr is (__be64 *) and data is a u64.
Likewise all following uses of addr.

Have you checked this code for sparse warnings? I wrote a script to make
it a bit simpler: https://github.com/daxtens/smart-sparse-diff
Usage is simple - build your kernel without patches with C=2, apply
patches, build with C=2 again, use script to compare logs. (Be aware
that you will need a pretty recent version of python to run the script -
my apologies, I haven't got around to fixing that.)

> +	local64_set(&event->hw.prev_count, data);
> +}
> +
> +static void imc_perf_event_update(struct perf_event *event)
> +{
> +	u64 counter_prev, counter_new, final_count, *addr;
> +
> +	addr = (u64 *)event->hw.event_base;
> +	counter_prev = local64_read(&event->hw.prev_count);
> +	counter_new = __be64_to_cpu(READ_ONCE(*addr));
> +	final_count = counter_new - counter_prev;
> +
> +	local64_set(&event->hw.prev_count, counter_new);
> +	local64_add(final_count, &event->count);
> +}
> +
> +static void imc_event_start(struct perf_event *event, int flags)
> +{
> +	/*
> +	 * In Memory Counters are free flowing counters. HW or the microcode
> +	 * keeps adding to the counter offset in memory. To get event
> +	 * counter value, we snapshot the value here and we calculate
> +	 * delta at later point.
> +	 */
> +	imc_read_counter(event);
> +}
> +
> +static void imc_event_stop(struct perf_event *event, int flags)
> +{
> +	/*
> +	 * Take a snapshot and calculate the delta and update
> +	 * the event counter values.
> +	 */
> +	imc_perf_event_update(event);
> +}

These functions confused me for a bit. I think I mostly understand them
now, but I have a few questions:

 0) everything deals with u64s. What happens when an in-memory value
    overflows? I assume it all works, but there's just a little bit too
    much modular arithmetic for me to be comfortable.

 1) shouldn't imc_event_start() set event->count to 0? Or is this done
    implicitly somewhere?

 2) I took quite a while to get understand imc_event_update(), largely
    because of the use of final_count as a variable name. If I
    understand correctly, final_count represents the delta between the
    previous value and the current value. And the logic of _update is:
       - read the previous value from local storage
       - read the current value from reserved memory
       - calculate the delta
       - save the measured value to local storage as the new prev_value
       - add the delta to the accumulated event count

I think update is free from accounting errors - I don't think it will
ever miss events that occur during calculation, but it took me a while
to get there. I'm still not convinced it wouldn't be better to do this
instead:

 - on start, save the current value to local storage
 - on update:
    * read the local storage
    * read the current value from hw
    * _set_ event->count to (current value - local storage)
    * do _not_ save back the current value to local storage

This saves a bunch of writes to local storage; not sure if there's any
reason it would be a worse design. I'm not 100% convinced of its
behaviour in the case of a long-running high-volume counter where the
count exceeds 2^64, but I think it would share any such issues with the
current design.

I'm not saying you have to adopt this design, I was just wondering if
you'd considered it and if there was a reason not to do it.

> +
> +static int imc_event_add(struct perf_event *event, int flags)
> +{
> +	if (flags & PERF_EF_START)
> +		imc_event_start(event, flags);
> +
> +	return 0;
> +}
> +
> +/* update_pmu_ops : Populate the appropriate operations for "pmu" */
> +static int update_pmu_ops(struct imc_pmu *pmu)
> +{
> +	if (!pmu)
> +		return -EINVAL;
> +
> +	pmu->pmu.task_ctx_nr = perf_invalid_context;
> +	pmu->pmu.event_init = nest_imc_event_init;
> +	pmu->pmu.add = imc_event_add;
> +	pmu->pmu.del = imc_event_stop;
> +	pmu->pmu.start = imc_event_start;
> +	pmu->pmu.stop = imc_event_stop;
> +	pmu->pmu.read = imc_perf_event_update;
> +	pmu->attr_groups[1] = &imc_format_group;
> +	pmu->pmu.attr_groups = pmu->attr_groups;
> +
> +	return 0;
> +}
> +
>  /* dev_str_attr : Populate event "name" and string "str" in attribute */
>  static struct attribute *dev_str_attr(const char *name, const char *str)
>  {
> @@ -84,6 +210,17 @@ int init_imc_pmu(struct imc_events *events, int idx,
>  	if (ret)
>  		goto err_free;
>  
> +	ret = update_pmu_ops(pmu_ptr);
> +	if (ret)
> +		goto err_free;
> +
> +	ret = perf_pmu_register(&pmu_ptr->pmu, pmu_ptr->pmu.name, -1);
> +	if (ret)
> +		goto err_free;
> +
> +	pr_info("%s performance monitor hardware support registered\n",
> +		pmu_ptr->pmu.name);
Do we need to be (or should we be) this chatty?

> +
>  	return 0;
>  
>  err_free:
> diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
> index 73c46703c2af..a98678266b0d 100644
> --- a/arch/powerpc/platforms/powernv/opal-imc.c
> +++ b/arch/powerpc/platforms/powernv/opal-imc.c
> @@ -37,6 +37,7 @@ extern struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
>  
>  extern int init_imc_pmu(struct imc_events *events,
>  			int idx, struct imc_pmu *pmu_ptr);
> +u64 nest_max_offset;
>  
>  static int imc_event_info(char *name, struct imc_events *events)
>  {
> @@ -69,8 +70,25 @@ static int imc_event_info_str(struct property *pp, char *name,
>  	return 0;
>  }
>  
> +/*
> + * Updates the maximum offset for an event in the pmu with domain
> + * "pmu_domain". Right now, only nest domain is supported.
> + */
> +static void update_max_value(u32 value, int pmu_domain)
> +{
> +	switch (pmu_domain) {
> +	case IMC_DOMAIN_NEST:
> +		if (nest_max_offset < value)
> +			nest_max_offset = value;
> +		break;
> +	default:
> +		/* Unknown domain, return */
> +		return;
Should this get a warning? WARN_ON_ONCE might be a bit much but maybe
pr_warn_ratelimited? pr_debug perhaps? It seems like something we should
know about as it would indicate a programming error...
> +	}
> +}
> +
>  static int imc_event_info_val(char *name, u32 val,
> -			      struct imc_events *events)
> +			      struct imc_events *events, int pmu_domain)
>  {
>  	int ret;
>  
> @@ -78,6 +96,7 @@ static int imc_event_info_val(char *name, u32 val,
>  	if (ret)
>  		return ret;
>  	sprintf(events->ev_value, "event=0x%x", val);
> +	update_max_value(val, pmu_domain);
>

I'm not sure this is the best place to call update_max_value. It's quite
an unexpected side-effect of a function which otherwise creates an event.

>  	return 0;
>  }
> @@ -114,7 +133,8 @@ static int imc_events_node_parser(struct device_node *dev,
>  				  struct property *event_scale,
>  				  struct property *event_unit,
>  				  struct property *name_prefix,
> -				  u32 reg)
> +				  u32 reg,
> +				  int pmu_domain)
>  {
>  	struct property *name, *pp;
>  	char *ev_name;
> @@ -159,7 +179,8 @@ static int imc_events_node_parser(struct device_node *dev,
>  		if (strncmp(pp->name, "reg", 3) == 0) {
>  			of_property_read_u32(dev, pp->name, &val);
>  			val += reg;
> -			ret = imc_event_info_val(ev_name, val, &events[idx]);
> +			ret = imc_event_info_val(ev_name, val, &events[idx],
> +				pmu_domain);
I would just put the call to update_max_value here.

>  			if (ret) {
>  				kfree(events[idx].ev_name);
>  				kfree(events[idx].ev_value);
> @@ -366,7 +387,8 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index)
>  	/* Loop through event nodes */
>  	for_each_child_of_node(dir, ev_node) {
>  		ret = imc_events_node_parser(ev_node, &events[idx], scale_pp,
> -					     unit_pp, name_prefix, reg);
> +					     unit_pp, name_prefix, reg,
> +					     pmu_ptr->domain);
>  		if (ret < 0) {
>  			/* Unable to parse this event */
>  			if (ret == -ENOMEM)
> -- 
> 2.7.4

Regards,
Daniel
