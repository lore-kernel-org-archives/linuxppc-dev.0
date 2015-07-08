Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 651751A19D8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 08:44:28 +1000 (AEST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 8 Jul 2015 16:44:26 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id BEA8F19D8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 16:35:23 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t68MhfpS40042578
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jul 2015 15:43:41 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t68MiMZj020234
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jul 2015 16:44:23 -0600
Date: Wed, 8 Jul 2015 15:43:20 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v4 5/7] powerpc/powernv: add event attribute and group to
 nest pmu
Message-ID: <20150708224320.GC22635@us.ibm.com>
References: <1436360506-18805-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1436360506-18805-6-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436360506-18805-6-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan [maddy@linux.vnet.ibm.com] wrote:
| Add code to create event/format attributes and attribute groups for
| each nest pmu.
| 
| Cc: Michael Ellerman <mpe@ellerman.id.au>
| Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
| Cc: Paul Mackerras <paulus@samba.org>
| Cc: Anton Blanchard <anton@samba.org>
| Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
| Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
| Cc: Stephane Eranian <eranian@google.com>
| Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
| ---
|  arch/powerpc/perf/nest-pmu.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
|  1 file changed, 57 insertions(+)
| 
| diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
| index 6116ff3..20ed9f8 100644
| --- a/arch/powerpc/perf/nest-pmu.c
| +++ b/arch/powerpc/perf/nest-pmu.c
| @@ -13,6 +13,17 @@
|  static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
|  static struct nest_pmu *per_nest_pmu_arr[P8_NEST_MAX_PMUS];
| 
| +PMU_FORMAT_ATTR(event, "config:0-20");
| +struct attribute *p8_nest_format_attrs[] = {

name collision unlikely, but could this be static struct?

| +	&format_attr_event.attr,
| +	NULL,
| +};
| +
| +struct attribute_group p8_nest_format_group = {

static struct?

| +	.name = "format",
| +	.attrs = p8_nest_format_attrs,
| +};
| +
|  static int nest_event_info(struct property *pp, char *start,
|  			struct nest_ima_events *p8_events, int flg, u32 val)
|  {
| @@ -45,6 +56,48 @@ static int nest_event_info(struct property *pp, char *start,
|  	return 0;
|  }
| 
| +/*
| + * Populate event name and string in attribute
| + */
| +struct attribute *dev_str_attr(const char *name, const char *str)

static function?

| +{
| +	struct perf_pmu_events_attr *attr;
| +
| +	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
| +

We recently needed following in 24x7 counters to keep lockdep happy:

	sysfs_attr_init(&attr->attr.attr);

| +	attr->event_str = str;
| +	attr->attr.attr.name = name;
| +	attr->attr.attr.mode = 0444;
| +	attr->attr.show = perf_event_sysfs_show;
| +
| +	return &attr->attr.attr;
| +}
| +
| +int update_events_in_group(

static function?

nit: do we need a new line before the first parameter? some functions
in the file don't add the new line.

| +	struct nest_ima_events *p8_events, int nevents, struct nest_pmu *pmu)

s/idx/nevents/?

| +{
| +	struct attribute_group *attr_group;
| +	struct attribute **attrs;
| +	int i;
| +
| +	/* Allocate memory for event attribute group */
| +	attr_group = kzalloc(((sizeof(struct attribute *) * (idx + 1)) +
| +				sizeof(*attr_group)), GFP_KERNEL);
| +	if (!attr_group)
| +		return -ENOMEM;
| +
| +	attrs = (struct attribute **)(attr_group + 1);

Can you add a comment on the +1?

| +	attr_group->name = "events";
| +	attr_group->attrs = attrs;
| +
| +	for (i = 0; i < idx; i++, p8_events++)
| +		attrs[i] = dev_str_attr((char *)p8_events->ev_name,
| +					(char *)p8_events->ev_value);
| +
| +	pmu->attr_groups[0] = attr_group;

The ->attr_groups[0] is initialized here, after the ->attr_groups[1] and
attr_groups[2] are initialized in caller. Since, ->attr_groups[1] and
->attr_groups[2] are set to global (loop-invariant) values, can we
initialize all the attribute-groups here? May need to rename function.

| +	return 0;
| +}
| +
|  static int nest_pmu_create(struct device_node *dev, int pmu_index)
|  {
|  	struct nest_ima_events **p8_events_arr, *p8_events;
| @@ -91,6 +144,7 @@ static int nest_pmu_create(struct device_node *dev, int pmu_index)
|  			/* Save the name to register it later */
|  			sprintf(buf, "Nest_%s", (char *)pp->value);
|  			pmu_ptr->pmu.name = (char *)buf;
| +			pmu_ptr->attr_groups[1] = &p8_nest_format_group;
|  			continue;
|  		}
| 
| @@ -122,6 +176,9 @@ static int nest_pmu_create(struct device_node *dev, int pmu_index)
|  		idx++;
|  	}
| 
| +	update_events_in_group(

nit: need newline before first param?

| +		(struct nest_ima_events *)p8_events_arr, idx, pmu_ptr);
| +
|  	return 0;
|  }
| 
| -- 
| 1.9.1
