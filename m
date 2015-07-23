Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5EACD1A02CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 16:33:01 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 23 Jul 2015 16:33:00 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 930022CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 16:32:57 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6N6WnhA54722736
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 16:32:57 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6N6WOiJ009036
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 16:32:25 +1000
Message-ID: <55B08A65.8070906@linux.vnet.ibm.com>
Date: Thu, 23 Jul 2015 12:02:05 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 5/7] powerpc/powernv: add event attribute and group
 to nest pmu
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1437045206-7491-6-git-send-email-maddy@linux.vnet.ibm.com>
 <1437540294.30906.30.camel@axtens.net>
In-Reply-To: <1437540294.30906.30.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 22 July 2015 10:14 AM, Daniel Axtens wrote:
> On Thu, 2015-07-16 at 16:43 +0530, Madhavan Srinivasan wrote:
>> Add code to create event/format attributes and attribute groups for
>> each nest pmu.
>>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Anton Blanchard <anton@samba.org>
>> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> Cc: Stephane Eranian <eranian@google.com>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/perf/nest-pmu.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 65 insertions(+)
>>
>> diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
>> index c4c08e4dee55..f3418bdec1cd 100644
>> --- a/arch/powerpc/perf/nest-pmu.c
>> +++ b/arch/powerpc/perf/nest-pmu.c
>> @@ -13,6 +13,17 @@
>>  static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
>>  static struct nest_pmu *per_nest_pmu_arr[P8_NEST_MAX_PMUS];
>>  
>> +PMU_FORMAT_ATTR(event, "config:0-20");
>> +static struct attribute *p8_nest_format_attrs[] = {
>> +	&format_attr_event.attr,
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group p8_nest_format_group = {
>> +	.name = "format",
>> +	.attrs = p8_nest_format_attrs,
>> +};
>> +
>>  static int nest_event_info(struct property *pp, char *name,
>>  			struct nest_ima_events *p8_events, int string, u32 val)
>>  {
>> @@ -46,6 +57,56 @@ static int nest_event_info(struct property *pp, char *name,
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Populate event name and string in attribute
>> + */
>> +static struct attribute *dev_str_attr(const char *name, const char *str)
>> +{
>> +	struct perf_pmu_events_attr *attr;
>> +
>> +	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
>> +
>> +	sysfs_attr_init(&attr->attr.attr);
>> +
>> +	attr->event_str = str;
>> +	attr->attr.attr.name = name;
>> +	attr->attr.attr.mode = 0444;
>> +	attr->attr.show = perf_event_sysfs_show;
>> +
>> +	return &attr->attr.attr;
> So I asked you about this before, and you pointed me to
> perf_event_sysfs_show. Looking at that in kernel/events/core.c, it looks
> like that uses container_of to pull out the perf_pmu_events_attr. So I
> guess that is at least mostly correct.
>
> I'm hoping something else uses container_of to pull out attr->attr, so
> that they can actually grab the attr->attr.show function pointer, so
> that perf_event_sysfs_show actually gets called. Where would that be?

OK, what we return is the device attribute struct which also have sysfs_ops.
So ->show and ->store are those entries in the strucutre and here we only
populate show ops using perf_event_sysfs_show. Now at the time of
pmu registering, we end up calling device_add->device_create_file->
sysfs_create_file which will end up adding a sysfs device file linked to
this
->show ops.

>> +}
>> +
>> +static int update_events_in_group(
>> +	struct nest_ima_events *p8_events, int idx, struct nest_pmu *pmu)
>> +{
>> +	struct attribute_group *attr_group;
>> +	struct attribute **attrs;
>> +	int i;
>> +
>> +	/*
>> +	 * Allocate memory for both event attribute group and for
>> +	 * event attributes array.
>> +	 */
>> +	attr_group = kzalloc(((sizeof(struct attribute *) * (idx + 1)) +
>> +				sizeof(*attr_group)), GFP_KERNEL);
>> +	if (!attr_group)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * Assign memory for event attribute array
>> +	 */
>> +	attrs = (struct attribute **)(attr_group + 1);
>> +	attr_group->name = "events";
>> +	attr_group->attrs = attrs;
> I am super uncomfortable with this block, especially the assignment to
> attrs. I *think* you're trying to allocate an attribute group and a set
> of attributes, but you've combined the allocation into one big
> contiguous chunk, and then you're trying to tease them apart. Is that
> necessary? Could it be two allocs, one for the attribute_group and one
> for the attribute?

I wanted to avoid two function calls here, but this is not a hot path
This happens at the pmu init time (booting), so I guess we can have
two allocs here.  
 
>
