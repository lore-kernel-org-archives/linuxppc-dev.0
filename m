Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46E351A08A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 19:06:17 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 14:36:14 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8E96A3940060
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 14:36:11 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t54969rj1049080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 14:36:10 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t54968HB016787
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 14:36:09 +0530
Message-ID: <557014FC.2000209@linux.vnet.ibm.com>
Date: Thu, 04 Jun 2015 14:36:04 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Stephane Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 4/9]powerpc/powernv: Add generic nest pmu ops
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1433260778-26497-5-git-send-email-maddy@linux.vnet.ibm.com>
 <1433289819.438.38.camel@axtens.net>
In-Reply-To: <1433289819.438.38.camel@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 03 June 2015 05:33 AM, Daniel Axtens wrote:
> On Tue, 2015-06-02 at 21:29 +0530, Madhavan Srinivasan wrote:
>> Patch adds generic nest pmu functions and format attribute.
>>
> I'm not sure this commit message accurately reflects the content of the
> patch. At any rate, please could you:
>   - say what the patch adds the functions and attributes to.
>   - phrase your message as "Add generic ..." not "Patch adds
> generic ...": see
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches#n155

Sure. Will rephrase it.
>
>>   
>> +PMU_FORMAT_ATTR(event, "config:0-20");
>> +struct attribute *p8_nest_format_attrs[] = {
>> +	&format_attr_event.attr,
>> +	NULL,
>> +};
>> +
>> +struct attribute_group p8_nest_format_group = {
>> +	.name = "format",
>> +	.attrs = p8_nest_format_attrs,
>> +};
> Can these structs be constified?
I guess it can. Will check it out.

>> +
>> +int p8_nest_event_init(struct perf_event *event)
>> +{
>> +	int chip_id;
>> +
>> +	if (event->attr.type != event->pmu->type)
>> +		return -ENOENT;
>> +
>> +	/* Sampling not supported yet */
>> +	if (event->hw.sample_period)
>> +		return -EINVAL;
>> +
>> +	/* unsupported modes and filters */
>> +	if (event->attr.exclude_user   ||
>> +	    event->attr.exclude_kernel ||
>> +	    event->attr.exclude_hv     ||
>> +	    event->attr.exclude_idle   ||
>> +	    event->attr.exclude_host   ||
>> +	    event->attr.exclude_guest  ||
>> +	    event->attr.sample_period) /* no sampling */
>> +		return -EINVAL;
> You test for sample period twice here.
Yes right. I will remove it.

>> +
>> +	if (event->cpu < 0)
>> +		return -EINVAL;
>> +
>> +	chip_id = topology_physical_package_id(event->cpu);
>> +	event->hw.event_base = event->attr.config +
>> +				p8_perchip_nest_info[chip_id].vbase;
>> +
>> +	return 0;
>> +}
>> +
>> +void p8_nest_read_counter(struct perf_event *event)
>> +{
>> +	u64 *addr;
>> +	u64 data = 0;
>> +
>> +	addr = (u64 *)event->hw.event_base;
>> +	data = __be64_to_cpu((uint64_t)*addr);
>> +	local64_set(&event->hw.prev_count, data);
>> +}
>> +
>> +void p8_nest_perf_event_update(struct perf_event *event)
>> +{
>> +	u64 counter_prev, counter_new, final_count;
>> +	uint64_t *addr;
>> +
>> +	addr = (u64 *)event->hw.event_base;
>> +	counter_prev = local64_read(&event->hw.prev_count);
>> +	counter_new = __be64_to_cpu((uint64_t)*addr);
>> +	final_count = counter_new - counter_prev;
>> +
>> +	local64_set(&event->hw.prev_count, counter_new);
>> +	local64_add(final_count, &event->count);
>> +}
>> +
>> +void p8_nest_event_start(struct perf_event *event, int flags)
>> +{
>> +	event->hw.state = 0;
>> +	p8_nest_read_counter(event);
>> +}
>> +
>> +void p8_nest_event_stop(struct perf_event *event, int flags)
>> +{
>> +	p8_nest_perf_event_update(event);
>> +}
>> +
>> +int p8_nest_event_add(struct perf_event *event, int flags)
>> +{
>> +	p8_nest_event_start(event, flags);
>> +	return 0;
>> +}
>> +
>> +void p8_nest_event_del(struct perf_event *event, int flags)
>> +{
>> +	p8_nest_event_stop(event, flags);
> Is this necessary?
>
> Stop calls update, which I guess makes sense as it finalises the value.
> But if the event is being deleted anyway, why not just do nothing here?
Since these Nest PMUs does not support sampling. IIUC, "perf record" 
interface uses
the event start/stop ops. Incase of perf stat interface event add/del 
interface are used to enable and disable the counters. Now, when we 
disable or delete, we update the event counter with the delta value.

>> +}
>> +
> Regards,
> Daniel Axtens

Thanks for the review
Maddy
