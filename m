Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75CF61A0066
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 19:22:40 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 23 Jul 2015 14:52:37 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 7C1C71258053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 14:55:31 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6N9MTN37077990
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 14:52:30 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6N81FKK025118
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 13:31:15 +0530
Message-ID: <55B0B247.9040207@linux.vnet.ibm.com>
Date: Thu, 23 Jul 2015 14:52:15 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 6/7] powerpc/powernv: generic nest pmu event functions
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1437045206-7491-7-git-send-email-maddy@linux.vnet.ibm.com>
 <1437540961.30906.39.camel@axtens.net>	 <55B08D4C.7050104@linux.vnet.ibm.com>
 <1437642259.29271.1.camel@ellerman.id.au>
In-Reply-To: <1437642259.29271.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 23 July 2015 02:34 PM, Michael Ellerman wrote:
> On Thu, 2015-07-23 at 12:14 +0530, Madhavan Srinivasan wrote:
>> On Wednesday 22 July 2015 10:26 AM, Daniel Axtens wrote:
>>>> +static void p8_nest_read_counter(struct perf_event *event)
>>>> +{
>>>> +	uint64_t *addr;
>>>> +	u64 data = 0;
>>> You've got a u64 and a uint64_t, and then...
>>>> +
>>>> +	addr = (u64 *)event->hw.event_base;
>>> ... you cast to event_base to a u64 pointer, which you assign to a
>>> uint64_t pointer.
>>>> +	data = __be64_to_cpu(*addr);
>>> And now you dereference the pointer.
>>> Could you just have:
>>>     data = __be64_to_cpu(*event->hw.event_base);
>>>> +	local64_set(&event->hw.prev_count, data);
>>>> +}
>>>> +
>>>> +static void p8_nest_perf_event_update(struct perf_event *event)
>>>> +{
>>>> +	u64 counter_prev, counter_new, final_count;
>>>> +	uint64_t *addr;
>>>> +
>>>> +	addr = (uint64_t *)event->hw.event_base;
>>> Here at least the cast type is the same as the type of addr, but again,
>>> why do you need the different types, and why local variable?
>> Damn sorry, copy paste errors. When I added debug prints i messed
>> the type case in both the functions. I will make them as uint64_t.
> No please use u64/u32 etc. Most code in powerpc does and I prefer them.
>
> cheers
Ok Sure. Will use only u64 and u32.

Thanks
maddy

>
