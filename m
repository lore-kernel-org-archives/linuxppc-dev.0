Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3JwW5mlHzDr3x
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 23:48:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org, stewart@linux.vnet.ibm.com,
 dja@axtens.net, eranian@google.com, hemant@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: Re: [PATCH v12 03/10] powerpc/powernv: Detect supported IMC units and
 its events
In-Reply-To: <1499074673-30576-4-git-send-email-anju@linux.vnet.ibm.com>
References: <1499074673-30576-1-git-send-email-anju@linux.vnet.ibm.com>
 <1499074673-30576-4-git-send-email-anju@linux.vnet.ibm.com>
Date: Thu, 06 Jul 2017 23:48:06 +1000
Message-ID: <87fue93cdl.fsf@concordia.ellerman.id.au>
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

Hi Maddy/Anju,

Comments inline ...

Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
> From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>
> Parse device tree to detect IMC units. Traverse through each IMC unit
> node to find supported events and corresponding unit/scale files (if any).
>
> The device tree for IMC counters starts at the node "imc-counters".
> This node contains all the IMC PMU nodes and event nodes
> for these IMC PMUs. The PMU nodes have an "events" property which has a
> phandle value for the actual events node. The events are separated from
> the PMU nodes to abstract out the common events. For example, PMU node
> "mcs0", "mcs1" etc. will contain a pointer to "nest-mcs-events" since,
> the events are common between these PMUs. These events have a different
> prefix based on their relation to different PMUs, and hence, the PMU
> nodes themselves contain an "events-prefix" property. The value for this
> property concatenated to the event name, forms the actual event
> name. Also, the PMU have a "reg" field as the base offset for the events
> which belong to this PMU. This "reg" field is added to event's "reg" field
> in the "events" node, which gives us the location of the counter data. Kernel
> code uses this offset as event configuration value.
>
> Device tree parser code also looks for scale/unit property in the event
> node and passes on the value as an event attr for perf interface to use
> in the post processing by the perf tool. Some PMUs may have common scale
> and unit properties which implies that all events supported by this PMU
> inherit the scale and unit properties of the PMU itself. For those
> events, we need to set the common unit and scale values.
>
> For failure to initialize any unit or any event, disable that unit and
> continue setting up the rest of them.
>
> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/imc-pmu.h        |   5 +
>  arch/powerpc/platforms/powernv/opal-imc.c | 439 +++++++++++++++++++++++++++++-

Bit of a meta comment. I feel like the split between opal-imc.c and
imc-pmu.c is not helping the code much.

We end up with the imc_pmu structure in a header when it really should
be private to imc-pmu.c, and we have details of perf in opal-imc.c

I haven't quite reviewed everything enough to say for certain that all
the code should be in imc-pmu.c, but that's the way I'm thinking ATM.

> diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
> index ffaea0b9c13e..2a0239e2590d 100644
> --- a/arch/powerpc/include/asm/imc-pmu.h
> +++ b/arch/powerpc/include/asm/imc-pmu.h
> @@ -91,6 +91,11 @@ struct imc_pmu {
>  	const struct attribute_group *attr_groups[4];
>  };
>  
> +/* In-Memory Collection Counters Type */
> +enum {
> +	IMC_COUNTER_PER_CHIP            = 0x10,
> +};

Who decides on that value? It looks like it comes from the device tree,
so this should at least have a comment explaining that. It should
probably be called IMC_TYPE_CHIP or something though to make it more
obvious that it's one of the legal values for a "type" property.

> diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
> index 5b1045c81af4..839c25718110 100644
> --- a/arch/powerpc/platforms/powernv/opal-imc.c
> +++ b/arch/powerpc/platforms/powernv/opal-imc.c
> @@ -34,9 +34,437 @@
>  #include <asm/cputable.h>
>  #include <asm/imc-pmu.h>
>  
> +struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
> +
> +static int imc_event_prop_update(char *name, struct imc_events *events)
> +{
> +	char *buf;
> +
> +	if (!events || !name)
> +		return -EINVAL;

Unless there's a reason to expect that to happen in normal operation we
usually avoid explicit NULL checks everywhere. The CPU will catch them
for you.

> +
> +	/* memory for content */
> +	buf = kzalloc(IMC_MAX_NAME_VAL_LEN, GFP_KERNEL);

We shouldn't need to allocate the maximum. The caller knows how much
space they'll need.

> +	if (!buf)
> +		return -ENOMEM;
> +
> +	events->ev_name = name;
> +	events->ev_value = buf;
> +	return 0;
> +}
> +
> +static int imc_event_prop_str(struct property *pp, char *name,
> +			      struct imc_events *events)
> +{
> +	int ret;
> +
> +	ret = imc_event_prop_update(name, events);
> +	if (ret)
> +		return ret;
> +
> +	if (!pp->value || (strnlen(pp->value, pp->length) == pp->length) ||
> +	   (pp->length > IMC_MAX_NAME_VAL_LEN))
> +		return -EINVAL;
> +	strncpy(events->ev_value, (const char *)pp->value, pp->length);

We shouldn't be passing struct property around and doing these strnlen()
etc. checks everywhere.

There are device tree helpers for reading strings.

> +
> +	return 0;
> +}
> +
> +static int imc_event_prop_val(char *name, u32 val,
> +			      struct imc_events *events)
> +{
> +	int ret;
> +
> +	ret = imc_event_prop_update(name, events);
> +	if (ret)
> +		return ret;
> +	snprintf(events->ev_value, IMC_MAX_NAME_VAL_LEN, "event=0x%x", val);

kasprintf() is what you want here.

Though this funtion only has one caller so should probably just go away.

But, the syntax here "event=0x%x" is dictated by the perf attribute
code, so that's a detail that should not be in this file.

Either the parsing should happen in the PMU code (probably), or this
code should just give a list of strings to the PMU code and then it
should do things like adding the "event=" prefix when it create the
attributes.

> +
> +	return 0;
> +}
> +
> +static int set_event_property(struct property *pp, char *event_prop,
> +			      struct imc_events *events, char *ev_name)
> +{
> +	char *buf;
> +	int ret;

Again too much passing around of struct property.

Ideally we should never use struct property, and instead use the device
tree helpers to extract the values we need immediately.

> +	buf = kzalloc(IMC_MAX_NAME_VAL_LEN, GFP_KERNEL);

Over large allocation.

> +	if (!buf)
> +		return -ENOMEM;
> +
> +	sprintf(buf, "%s.%s", ev_name, event_prop);

That could overflow the buffer AFAICS, but again use kasprintf().

Also this syntax comes from the PMU code too, right?

> +	ret = imc_event_prop_str(pp, buf, events);
> +	if (ret) {
> +		if (events->ev_name)
> +			kfree(events->ev_name);
> +		if (events->ev_value)
> +			kfree(events->ev_value);

You don't need to check before calling kfree.

So just:
                kfree(events->ev_name);
                kfree(events->ev_value);

Having said that, this doesn't seem like the right place to be freeing
those. Leave it to the caller.

> +	}
> +	return ret;
> +}
> +
> +/*
> + * imc_events_node_parser: Parse the event node "dev" and assign the parsed
> + *                         information to event "events".
> + *
> + * Parses the "reg", "scale" and "unit" properties of this event.
> + * "reg" gives us the event offset in the counter memory.
> + */
> +static int imc_events_node_parser(struct device_node *dev,
> +				  struct imc_events *events,
> +				  struct property *event_scale,
> +				  struct property *event_unit,
> +				  struct property *name_prefix,
> +				  u32 reg, int pmu_domain)
> +{
> +	struct property *name, *pp;
> +	char *ev_name;
> +	u32 val;
> +	int idx = 0, ret;

Whenever possible you should defer initialisation of variables until you
need to. So in this case just before the for_each loop below.

> +	if (!dev)
> +		goto fail;

That can't happen as the code is currently written. Again the CPU will
catch it for you if it's NULL.

> +	/* Check for "event-name" property, which is the perfix for event names */
> +	name = of_find_property(dev, "event-name", NULL);
> +	if (!name)
> +		return -ENODEV;
> +
> +	if (!name->value ||
> +	  (strnlen(name->value, name->length) == name->length) ||
> +	  (name->length > IMC_MAX_NAME_VAL_LEN))
> +		return -EINVAL;
> +
> +	ev_name = kzalloc(IMC_MAX_NAME_VAL_LEN, GFP_KERNEL);
> +	if (!ev_name)
> +		return -ENOMEM;
> +
> +	snprintf(ev_name, IMC_MAX_NAME_VAL_LEN, "%s%s",
> +		 (char *)name_prefix->value,
> +		 (char *)name->value);

All of the above can become:

	const char *s;

	if (of_property_read_string(dev, "event-name", &s))
		return -ENODEV;

	ev_name = kasprintf(GFP_KERNEL, "%s%s", name_prefix, s);
	if (!ev_name)
		return -ENOMEM;

Where name_prefix should be a const char *, not a struct property.

> +	/*
> +	 * Parse each property of this event node "dev". Property "reg" has
> +	 * the offset which is assigned to the event name. Other properties
> +	 * like "scale" and "unit" are assigned to event.scale and event.unit
> +	 * accordingly.
> +	 */
> +	for_each_property_of_node(dev, pp) {

I don't see why you're using for_each_property_of_node() here.

And in fact it can lead to a bug ...

> +		/*
> +		 * If there is an issue in parsing a single property of
> +		 * this event, we just clean up the buffers, but we still
> +		 * continue to parse. TODO: This could be rewritten to skip the
> +		 * entire event node incase of parsing issues, but that can be
> +		 * done later.
> +		 */
> +		if (strncmp(pp->name, "reg", 3) == 0) {
> +			of_property_read_u32(dev, pp->name, &val);
> +			val += reg;
> +			ret = imc_event_prop_val(ev_name, val, &events[idx]);
> +			if (ret) {
> +				if (events[idx].ev_name)
> +					kfree(events[idx].ev_name);
> +				if (events[idx].ev_value)
> +					kfree(events[idx].ev_value);
> +				goto fail;
> +			}
> +			idx++;
> +			/*
> +			 * If the common scale and unit properties available,
> +			 * then, assign them to this event
> +			 */
> +			if (event_scale) {
> +				ret = set_event_property(event_scale, "scale",
> +							 &events[idx],
> +							 ev_name);
> +				if (ret)
> +					goto fail;
> +				idx++;
> +			}
> +			if (event_unit) {
> +				ret = set_event_property(event_unit, "unit",
> +							 &events[idx],
> +							 ev_name);
> +				if (ret)
> +					goto fail;
> +				idx++;
> +			}
> +		} else if (strncmp(pp->name, "unit", 4) == 0) {
> +			/*
> +			 * The event's unit and scale properties can override the
> +			 * PMU's event and scale properties, if present.
> +			 */

.. because the order in which you discover the properties is not well
defined, the device tree properties may appear in any order.

So the event's unit and scale may or may not override the PMU's event
and scale, depending on what order they're discovered in.

Though even if you did find them in order, they don't override the
inherited value, they just create a new attribute with the same name.

Which means sysfs will complain about the duplicate attribute names:
  sysfs: cannot create duplicate filename '/devices/nest_mcs01/events/PM_MCS01_64B_RD_OR_WR_DISP_PORT01.scale'

Also the events array is sized (below in imc_events_setup()) as:

	nr_children = get_nr_children(dir) * 3;

Which doesn't account for inherited scale/unit, which means we overflow
the events array and corrupt memory :}

  Unable to handle kernel paging request for data at address 0x313053434d5f4d50

> +			ret = set_event_property(pp, "unit", &events[idx],
> +						 ev_name);
> +			if (ret)
> +				goto fail;
> +			idx++;
> +		} else if (strncmp(pp->name, "scale", 5) == 0) {
> +			ret = set_event_property(pp, "scale", &events[idx],
> +						 ev_name);
> +			if (ret)
> +				goto fail;
> +			idx++;
> +		}
> +	}
> +
> +	return idx;
> +fail:
> +	return -EINVAL;
> +}


I think it might work better if the order of things is reversed here.
Instead of walking the device tree to find a list of strings that are
then passed to the PMU, it would work better I think if when the PMU is
registering, it walks the device tree (or calls a helper) to get each
event, and creates an attribute from them.

Either way, it should end up looking more like this:

struct imc_event
{
	char *name;
	char *scale;
	char *unit;
	u32 value;
};

struct imc_event *imc_parse_event(struct device_node *np, const char *scale,
				  const char *unit, const char *prefix)
{
	struct imc_event *event;
	const char *s;

	event = kzalloc(sizeof(*event), GFP_KERNEL);
	if (!event)
		return NULL;

	if (of_property_read_u32(np, "reg", &event->value))
		goto error;

	if (of_property_read_string(np, "event-name", &s))
		goto error;

	event->name = kasprintf(GFP_KERNEL, "%s%s", prefix, s);
	if (!event->name)
		goto error;

	if (of_property_read_string(np, "scale", &s))
		s = scale;

	if (s) {
		event->scale = kstrdup(s, GFP_KERNEL);
		if (!event->scale)
			goto error;
	}

	if (of_property_read_string(np, "unit", &s))
		s = unit;

	if (s) {
		event->unit = kstrdup(s, GFP_KERNEL);
		if (!event->unit)
			goto error;
	}

	return event;
error:
	kfree(event->unit);
	kfree(event->scale);
	kfree(event->name);
	kfree(event);

	return NULL;
}



...
> +
> +/*
> + * imc_events_setup() : First finds the event node for the pmu and
> + *                      gets the number of supported events, then
> + * allocates memory for the same and parse the events.
> + */
> +static int imc_events_setup(struct device_node *parent,
> +					   int pmu_index,
> +					   struct imc_pmu *pmu_ptr,
> +					   u32 prop,
> +					   int *idx)
> +{
> +	struct device_node *ev_node = NULL, *dir = NULL;
> +	u32 reg;
> +	struct property *scale_pp, *unit_pp, *name_prefix;
> +	int ret = 0, nr_children = 0;
> +
> +	/*
> +	 * Fetch the actual node where the events for this PMU exist.
> +	 */
> +	dir = of_find_node_by_phandle(prop);
> +	if (!dir)
> +		return -ENODEV;

dir is a strange name for a device_node, np is most common.

> +	/*
> +	 * Get the maximum no. of events in this node.
> +	 * Multiply by 3 to account for .scale and .unit properties
> +	 * This number suggests the amount of memory needed to setup the
> +	 * events for this pmu.
> +	 */
> +	nr_children = get_nr_children(dir) * 3;

Doesn't account for inherited unit/scale as mentioned above.

Using the struct I suggested:

struct imc_event
{
	char *name;
	char *scale;
	char *unit;
	u32 value;
};

We don't have to do any guessing, we can just count the number of child
nodes and know that's exactly how many structs we'll need.

> +	pmu_ptr->events = kzalloc((sizeof(struct imc_events) * nr_children),
> +			 GFP_KERNEL);
> +	if (!pmu_ptr->events)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Check if there is a common "scale" and "unit" properties inside
> +	 * the PMU node for all the events supported by this PMU.
> +	 */
> +	scale_pp = of_find_property(parent, "scale", NULL);
> +	unit_pp = of_find_property(parent, "unit", NULL);
> +
> +	/*
> +	 * Get the event-prefix property from the PMU node
> +	 * which needs to be attached with the event names.
> +	 */
> +	name_prefix = of_find_property(parent, "events-prefix", NULL);
> +	if (!name_prefix)
> +		goto free_events;
> +
> +	/*
> +	 * "reg" property gives out the base offset of the counters data
> +	 * for this PMU.
> +	 */
> +	of_property_read_u32(parent, "reg", &reg);

Error checking.

> +
> +	if (!name_prefix->value ||
> +	   (strnlen(name_prefix->value, name_prefix->length) == name_prefix->length) ||
> +	   (name_prefix->length > IMC_MAX_NAME_VAL_LEN))
> +		goto free_events;

of_property_read_string()

> +
> +	/* Loop through event nodes */
> +	for_each_child_of_node(dir, ev_node) {
> +		ret = imc_events_node_parser(ev_node, &pmu_ptr->events[*idx], scale_pp,
> +				unit_pp, name_prefix, reg, pmu_ptr->domain);
> +		if (ret < 0) {
> +			/* Unable to parse this event */
> +			if (ret == -ENOMEM)
> +				goto free_events;
> +			continue;
> +		}

If this was being called from the PMU initialisation path, at this
point would take the 

> +
> +		/*
> +		 * imc_event_node_parser will return number of
> +		 * event entries created for this. This could include
> +		 * event scale and unit files also.
> +		 */
> +		*idx += ret;
> +	}
> +	return 0;
> +
> +free_events:
> +	imc_free_events(pmu_ptr->events, *idx);
> +	return -ENODEV;
> +
> +}
> +
> +/* imc_get_mem_addr_nest: Function to get nest counter memory region for each chip */
> +static int imc_get_mem_addr_nest(struct device_node *node,
> +				 struct imc_pmu *pmu_ptr,
> +				 u32 offset)
> +{
> +	int nr_chips = 0, i, j;
> +	u64 *base_addr_arr, baddr;
> +	u32 *chipid_arr, size = pmu_ptr->counter_mem_size, pages;
> +
> +	nr_chips = of_property_count_u32_elems(node, "chip-id");
> +	if (!nr_chips)
> +		return -ENODEV;

of_property_count_u32_elems() returns -EINVAL if the the property is not
found, and some other negative error codes too.

Which means if (!-22) is false, and we go on to kzalloc(8 * -22, ...)
bytes of memory below :)

> +	base_addr_arr = kzalloc((sizeof(u64) * nr_chips), GFP_KERNEL);
> +	chipid_arr = kzalloc((sizeof(u32) * nr_chips), GFP_KERNEL);
> +	if (!base_addr_arr || !chipid_arr)
> +		return -ENOMEM;

If one is allocated but not the other then we leak memory here. You
should be able to check for each case and just goto error, where you
free everything.

> +
> +	of_property_read_u32_array(node, "chip-id", chipid_arr, nr_chips);

Need error handling here, yes it should succeed but check anyway.

> +	of_property_read_u64_array(node, "base-addr", base_addr_arr, nr_chips);

If this fails we end up with base_addr_arr full of zeroes, and so below
we point mem_info[] at (0 + offset), which is probably the kernel.

> +	pmu_ptr->mem_info = kzalloc((sizeof(struct imc_mem_info) * nr_chips), GFP_KERNEL);
> +	if (!pmu_ptr->mem_info) {
> +		if (base_addr_arr)
> +			kfree(base_addr_arr);
> +		if (chipid_arr)
> +			kfree(chipid_arr);
> +
> +		return -ENOMEM;
> +		}
> +
> +	for (i = 0; i < nr_chips; i++) {
> +		pmu_ptr->mem_info[i].id = chipid_arr[i];
> +		baddr = base_addr_arr[i] + offset;
> +		for (j = 0; j < (size/PAGE_SIZE); j++) {
> +			pages = PAGE_SIZE * j;
> +			pmu_ptr->mem_info[i].vbase[j] = phys_to_virt(baddr + pages);
> +		}
> +	}

In the success case we leak base_addr_arr and chipid_arr don't we?

> +	return 0;
> +}
> +
> +/*
> + * imc_pmu_create : Takes the parent device which is the pmu unit, pmu_index
> + *		    and domain as the inputs.
> + * Allocates memory for the pmu, sets up its domain (NEST), and
> + * calls imc_events_setup() to allocate memory for the events supported
> + * by this pmu. Assigns a name for the pmu.
> + *
> + * If everything goes fine, it calls, init_imc_pmu() to setup the pmu device
> + * and register it.
> + */
> +static int imc_pmu_create(struct device_node *parent, int pmu_index, int domain)
> +{
> +	u32 prop = 0;
> +	struct property *pp;
> +	char *buf;
> +	int idx = 0, ret = 0;
> +	struct imc_pmu *pmu_ptr;
> +	u32 offset;
> +
> +	if (!parent)
> +		return -EINVAL;

Shouldn't be required.

> +	/* memory for pmu */
> +	pmu_ptr = kzalloc(sizeof(struct imc_pmu), GFP_KERNEL);
> +	if (!pmu_ptr)
> +		return -ENOMEM;
> +
> +	pmu_ptr->domain = domain;
> +
> +	/* Needed for hotplug/migration */
> +	per_nest_pmu_arr[pmu_index] = pmu_ptr;

You don't clear it on error?

> +	pp = of_find_property(parent, "name", NULL);
> +	if (!pp) {
> +		ret = -ENODEV;
> +		goto free_pmu;
> +	}
> +
> +	if (!pp->value ||
> +	   (strnlen(pp->value, pp->length) == pp->length) ||
> +	   (pp->length > IMC_MAX_NAME_VAL_LEN)) {
> +		ret = -EINVAL;
> +		goto free_pmu;
> +	}
> +
> +	buf = kzalloc(IMC_MAX_NAME_VAL_LEN, GFP_KERNEL);
> +	if (!buf) {
> +		ret = -ENOMEM;
> +		goto free_pmu;
> +	}
> +	/* Save the name to register it later */
> +	sprintf(buf, "nest_%s", (char *)pp->value);
> +	pmu_ptr->pmu.name = (char *)buf;

of_property_read_string() / kasprintf() again.

> +	if (of_property_read_u32(parent, "size", &pmu_ptr->counter_mem_size))
> +		pmu_ptr->counter_mem_size = 0;
> +
> +	if (!of_property_read_u32(parent, "offset", &offset)) {
> +		if (imc_get_mem_addr_nest(parent, pmu_ptr, offset))

You don't set ret here, which means we return 0 incorrectly.

> +			goto free_pmu;
> +		pmu_ptr->imc_counter_mmaped = 1;
> +	}
> +
> +	/*
> +	 * "events" property inside a PMU node contains the phandle value
> +	 * for the actual events node. The "events" node for the IMC PMU
> +	 * is not in this node, rather inside "imc-counters" node, since,
> +	 * we want to factor out the common events (thereby, reducing the
> +	 * size of the device tree)
> +	 */
> +	if (!of_property_read_u32(parent, "events", &prop)) {
> +		if (prop)
> +			imc_events_setup(parent, pmu_index, pmu_ptr, prop, &idx);

You don't need to check if (prop) here, of_find_node_by_phandle() will
handle it for you.

> +	}
> +	return 0;
> +
> +free_pmu:
> +	if (pmu_ptr)
> +		kfree(pmu_ptr);

        kfree(pmu_ptr);

> +	return ret;
> +}
> +
>  static int opal_imc_counters_probe(struct platform_device *pdev)
>  {
>  	struct device_node *imc_dev = NULL;
> +	int pmu_count = 0, domain;
> +	u32 type;
>  
>  	if (!pdev || !pdev->dev.of_node)
>  		return -ENODEV;
> @@ -50,7 +478,16 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
>  	imc_dev = pdev->dev.of_node;
>  	if (!imc_dev)
>  		return -ENODEV;
> -
> +	for_each_compatible_node(imc_dev, NULL, IMC_DTB_UNIT_COMPAT) {
> +		if (of_property_read_u32(imc_dev, "type", &type))
> +			continue;

That should at least get a pr_debug(), you found a compatible node but it
was missing a required property.

> +		if (type == IMC_COUNTER_PER_CHIP)
> +			domain = IMC_DOMAIN_NEST;

Why do we have type and domain? Why not just use type?

> +		else
> +			continue;
> +		if (!imc_pmu_create(imc_dev, pmu_count, domain))
> +			pmu_count++;

Where do we use pmu_count ?

> +	}
>  	return 0;
>  }


cheers
