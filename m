Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 598331A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 18:03:09 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 9 Jul 2015 18:03:08 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 09CB52BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 18:03:03 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6982sYZ52756710
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2015 18:03:03 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6982TdP020497
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2015 18:02:30 +1000
Message-ID: <559E2A7E.4040607@linux.vnet.ibm.com>
Date: Thu, 09 Jul 2015 13:32:06 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>, peterz@infradead.org
Subject: Re: [PATCH v4 4/7] powerpc/powernv: detect supported nest pmus and
 its events
References: <1436360506-18805-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1436360506-18805-5-git-send-email-maddy@linux.vnet.ibm.com>
 <20150708220125.GA22635@us.ibm.com>
In-Reply-To: <20150708220125.GA22635@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 09 July 2015 03:31 AM, Sukadev Bhattiprolu wrote:
> Madhavan Srinivasan [maddy@linux.vnet.ibm.com] wrote:
> | Parse device tree to detect supported nest pmu units. Traverse
> | through each nest pmu unit folder to find supported events and
> | corresponding unit/scale files (if any).
> | 
> | The nest unit event file from DT, will contain the offset in the
> | reserved memory region to get the counter data for a given event.
> | Kernel code uses this offset as event configuration value.
> | 
> | Device tree parser code also looks for scale/unit in the file name and
> | passes on the file as an event attr for perf tool to use in the post
> | processing.
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
> |  arch/powerpc/perf/nest-pmu.c | 124 ++++++++++++++++++++++++++++++++++++++++++-
> |  1 file changed, 123 insertions(+), 1 deletion(-)
> | 
> | diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
> | index e7d45ed..6116ff3 100644
> | --- a/arch/powerpc/perf/nest-pmu.c
> | +++ b/arch/powerpc/perf/nest-pmu.c
> | @@ -11,6 +11,119 @@
> |  #include "nest-pmu.h"
> | 
> |  static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
> | +static struct nest_pmu *per_nest_pmu_arr[P8_NEST_MAX_PMUS];
> | +
> | +static int nest_event_info(struct property *pp, char *start,
>
> nit: s/start/name/?

Yes. Will change it.

>
> | +			struct nest_ima_events *p8_events, int flg, u32 val)
>
> nit: s/flg/string/?

Yes. Will change it.

> | +{
> | +	char *buf;
> | +
> | +	/* memory for event name */
> | +	buf = kzalloc(P8_NEST_MAX_PMU_NAME_LEN, GFP_KERNEL);
> | +	if (!buf)
> | +		return -ENOMEM;
> | +
> | +	strncpy(buf, start, strlen(start));
> | +	p8_events->ev_name = buf;
> | +
> | +	/* memory for content */
> | +	buf = kzalloc(P8_NEST_MAX_PMU_NAME_LEN, GFP_KERNEL);
> | +	if (!buf)
> | +		return -ENOMEM;
> | +
> | +	if (flg) {
> | +		/* string content*/
> | +		if (!pp->value ||
> | +		   (strnlen(pp->value, pp->length) == pp->length))
> | +			return -EINVAL;
> | +
> | +		strncpy(buf, (const char *)pp->value, pp->length);
> | +	} else
> | +		sprintf(buf, "event=0x%x", val);
> | +
> | +	p8_events->ev_value = buf;
> | +	return 0;
> | +}
> | +
> | +static int nest_pmu_create(struct device_node *dev, int pmu_index)
> | +{
> | +	struct nest_ima_events **p8_events_arr, *p8_events;
> | +	struct nest_pmu *pmu_ptr;
> | +	struct property *pp;
> | +	char *buf, *start;
> | +	const __be32 *lval;
> | +	u32 val;
> | +	int idx = 0, ret;
> | +
> | +	if (!dev)
> | +		return -EINVAL;
> | +
> | +	/* memory for nest pmus */
> | +	pmu_ptr = kzalloc(sizeof(struct nest_pmu), GFP_KERNEL);
> | +	if (!pmu_ptr)
> | +		return -ENOMEM;
> | +
> | +	/* Needed for hotplug/migration */
> | +	per_nest_pmu_arr[pmu_index] = pmu_ptr;
> | +
> | +	/* memory for nest pmu events */
> | +	p8_events_arr = kzalloc((sizeof(struct nest_ima_events) * 64),
> | +								GFP_KERNEL);
> | +	if (!p8_events_arr)
> | +		return -ENOMEM;
> | +	p8_events = (struct nest_ima_events *)p8_events_arr;
> | +
> | +	/*
> | +	 * Loop through each property
> | +	 */
> | +	for_each_property_of_node(dev, pp) {
> | +		start = pp->name;
> | +
> | +		if (!strcmp(pp->name, "name")) {
> | +			if (!pp->value ||
> | +			   (strnlen(pp->value, pp->length) == pp->length))
> | +				return -EINVAL;
>
> Do we need to check the string length here? If so, should we check against
> size we are going to allocate below (P8_NEST_MAX_PMU_NAME_LEN)? Or is it
> possible pp->value is not NULL terminated?

Yes we need and can add a check for size is below the
P8_NEST_MAX_PMU_NAME_LEN .

> | +
> | +			buf = kzalloc(P8_NEST_MAX_PMU_NAME_LEN, GFP_KERNEL);
> | +			if (!buf)
> | +				return -ENOMEM;
> | +
> | +			/* Save the name to register it later */
> | +			sprintf(buf, "Nest_%s", (char *)pp->value);
> | +			pmu_ptr->pmu.name = (char *)buf;
> | +			continue;
> | +		}
> | +
> | +		/* Skip these, we dont need it */
> | +		if (!strcmp(pp->name, "phandle") ||
> | +		    !strcmp(pp->name, "device_type") ||
> | +		    !strcmp(pp->name, "linux,phandle"))
> | +			continue;
> | +
> | +		if (strncmp(pp->name, "unit.", 5) == 0) {
> | +			/* Skip first few chars in the name */
> | +			start += 5;
> | +			ret = nest_event_info(pp, start, p8_events++, 1, 0);
> | +		} else if (strncmp(pp->name, "scale.", 6) == 0) {
> | +			/* Skip first few chars in the name */
> | +			start += 6;
> | +			ret = nest_event_info(pp, start, p8_events++, 1, 0);
>
> Are the 'start.*' and 'unit.*' files events by themselves or just attributes
> of events?

These are attributes needed for computation. unit and scale attributes
will be used by perf tool in post-processing the counter data. These
can also use by other tools like pcp.

> These will show up in sysfs as:
>
> 	$ ls /sys/bus/event_source/devices/Nest_Alink_BW//events/
> 	Alink0        Alink0.unit  Alink1.scale  Alink2        Alink2.unit
> 	Alink0.scale  Alink1       Alink1.unit   Alink2.scale

Yes true.

> From the other PMUs, the 'events' directory contains just events.

For ex from x86 sandybridge system:

# ls
cas_count_read        cas_count_read.unit  cas_count_write.scale  clockticks
cas_count_read.scale  cas_count_write      cas_count_write.unit

> Attributes of events, like descriptions go into a separate directory:
> Eg: For 24x7 counters:
>
> 	$ ls -d /sys/bus/event_source/devices/hv_24x7/event*
> 	/sys/bus/event_source/devices/hv_24x7/event_descs
> 	/sys/bus/event_source/devices/hv_24x7/event_long_descs
> 	/sys/bus/event_source/devices/hv_24x7/events

Yes. But these attributes are not informational like event description.

> If events have/need parameters, they go into the event file itself:
> Eg on an x86 box:
>
> 	$ cat /sys/bus/event_source/devices/cpu/events/cache-misses
> 	event=0x2e,umask=0x41
>
> For the nest events, are the 'units'  and 'scale' files needed to
> identify the event (like the umask in x86 example above) or are they
> informational attributes (like descriptions for 24x7 counters)?

Yes. Again, these are not event parameter value to add in
the event configuration value or informational.

> IOW, following works on my x86 system (and with 24x7 counters):
>
> 	for i in `ls /sys/bus/event_source/devices/cpu/events/`; do
> 		perf stat -e cpu/$i/ sleep 1;
> 	done
>
> This loop will fail for Nest events, when it hits files like Alink0.unit.
>
> That said, I am not sure if the above for loop is supposed to work always!
> Maybe Peter Zijlstra can comment on that.

Yes.

> Are the units and scales needed/used by perf in computations? If just
> informational and, given that we can locate them from the device-tree,
> can we drop them altogether?
>
> If they are needed by perf and are attributes of an event, can we
> move them to separate directories?

I could prefer not to and here is my reason. Today perf tool
already have a mechanism to get the unit and scale values from
kernel, why to add one more and add code to perf tool to support it?

Thanks for review

Maddy


> 	/sys/bus/event_source/devices/Nest_Alink_BW/events 
> 	/sys/bus/event_source/devices/Nest_Alink_BW/units
> 	/sys/bus/event_source/devices/Nest_Alink_BW/scales
>
> Sukadev
>
>
>
> | +		} else {
> | +			lval = of_get_property(dev, pp->name, NULL);
> | +			val = (uint32_t)be32_to_cpup(lval);
> | +
> | +			ret = nest_event_info(pp, start, p8_events++, 0, val);
> | +		}
> | +
> | +		if (ret)
> | +			return ret;
> | +
> | +		/* book keeping */
> | +		idx++;
>
> I don't see idx being used after the increment?

Used in next patch.

> | +	}
> | +
> | +	return 0;
> | +}
> | 
> |  static int nest_ima_dt_parser(void)
> |  {
> | @@ -19,7 +132,7 @@ static int nest_ima_dt_parser(void)
> |  	const __be64 *chip_ima_size;
> |  	struct device_node *dev;
> |  	struct perchip_nest_info *p8ni;
> | -	int idx;
> | +	int idx, ret;
> | 
> |  	/*
> |  	 * "nest-ima" folder contains two things,
> | @@ -50,6 +163,15 @@ static int nest_ima_dt_parser(void)
> |  		p8ni->vbase = (uint64_t) phys_to_virt(p8ni->pbase);
> |  	}
> | 
> | +	/* Look for supported Nest PMU units */
> | +	idx = 0;
> | +	for_each_node_by_type(dev, "nest-ima-unit") {
> | +		ret = nest_pmu_create(dev, idx);
> | +		if (ret)
> | +			return ret;
> | +		idx++;
>
> idx not used?

used by code in patch 6 of this series.

Thanks
Maddy

> | +	}
> | +
> |  	return 0;
> |  }
> | 
> | -- 
> | 1.9.1
