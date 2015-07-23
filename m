Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E22AB1A0163
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 16:45:02 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 23 Jul 2015 12:15:00 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 18F281258059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 12:17:57 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6N6iWBo43253834
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 12:14:33 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6N5Q21P006717
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 10:56:03 +0530
Message-ID: <55B08D4C.7050104@linux.vnet.ibm.com>
Date: Thu, 23 Jul 2015 12:14:28 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 6/7] powerpc/powernv: generic nest pmu event functions
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1437045206-7491-7-git-send-email-maddy@linux.vnet.ibm.com>
 <1437540961.30906.39.camel@axtens.net>
In-Reply-To: <1437540961.30906.39.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 22 July 2015 10:26 AM, Daniel Axtens wrote:
>> +static void p8_nest_read_counter(struct perf_event *event)
>> +{
>> +	uint64_t *addr;
>> +	u64 data = 0;
> You've got a u64 and a uint64_t, and then...
>> +
>> +	addr = (u64 *)event->hw.event_base;
> ... you cast to event_base to a u64 pointer, which you assign to a
> uint64_t pointer.
>> +	data = __be64_to_cpu(*addr);
> And now you dereference the pointer.
> Could you just have:
>     data = __be64_to_cpu(*event->hw.event_base);
>> +	local64_set(&event->hw.prev_count, data);
>> +}
>> +
>> +static void p8_nest_perf_event_update(struct perf_event *event)
>> +{
>> +	u64 counter_prev, counter_new, final_count;
>> +	uint64_t *addr;
>> +
>> +	addr = (uint64_t *)event->hw.event_base;
> Here at least the cast type is the same as the type of addr, but again,
> why do you need the different types, and why local variable?

Damn sorry, copy paste errors. When I added debug prints i messed
the type case in both the functions. I will make them as uint64_t.

Thanks for this detail review
Maddy

>> +	counter_prev = local64_read(&event->hw.prev_count);
>> +	counter_new = __be64_to_cpu(*addr);
>> +	final_count = counter_new - counter_prev;
>> +
>> +	local64_set(&event->hw.prev_count, counter_new);
>> +	local64_add(final_count, &event->count);
>> +}
>> +
>> +static void p8_nest_event_start(struct perf_event *event, int flags)
>> +{
>> +	event->hw.state = 0;
> Should this be an enum or a #define rather than a bare 0? (It may not
> need to be, I was just wondering because I don't know what 0 means.)

I could remove it since was just initializing at the start.

>> +	p8_nest_read_counter(event);
>> +}
>> +
