Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A31C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 13:07:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7E72186A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 13:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7E72186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LQpR36WfzDqRR
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 00:07:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=lvivier@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LQm64GxqzDqRR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2019 00:05:10 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 88ECB7D7BB;
 Fri, 15 Mar 2019 13:05:07 +0000 (UTC)
Received: from [10.36.117.12] (ovpn-117-12.ams2.redhat.com [10.36.117.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E130601AE;
 Fri, 15 Mar 2019 13:05:00 +0000 (UTC)
Subject: Re: [RFC v3] sched/topology: fix kernel crash when a CPU is
 hotplugged in a memoryless node
To: Peter Zijlstra <peterz@infradead.org>
References: <20190304195952.16879-1-lvivier@redhat.com>
 <77b142fe-0886-1510-28bd-d432ea2c796a@redhat.com>
 <20190315122556.GE6058@hirez.programming.kicks-ass.net>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <18d517b6-0554-f241-abf8-ed085998c6d8@redhat.com>
Date: Fri, 15 Mar 2019 14:05:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190315122556.GE6058@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 15 Mar 2019 13:05:08 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, Borislav Petkov <bp@suse.de>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 15/03/2019 13:25, Peter Zijlstra wrote:
> On Fri, Mar 15, 2019 at 12:12:45PM +0100, Laurent Vivier wrote:
> 
>> Another way to avoid the nodes overlapping for the offline nodes at
>> startup is to ensure the default values don't define a distance that
>> merge all offline nodes into node 0.
>>
>> A powerpc specific patch can workaround the kernel crash by doing this:
>>
>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>> index 87f0dd0..3ba29bb 100644
>> --- a/arch/powerpc/mm/numa.c
>> +++ b/arch/powerpc/mm/numa.c
>> @@ -623,6 +623,7 @@ static int __init parse_numa_properties(void)
>>         struct device_node *memory;
>>         int default_nid = 0;
>>         unsigned long i;
>> +       int nid, dist;
>>
>>         if (numa_enabled == 0) {
>>                 printk(KERN_WARNING "NUMA disabled by user\n");
>> @@ -636,6 +637,10 @@ static int __init parse_numa_properties(void)
>>
>>         dbg("NUMA associativity depth for CPU/Memory: %d\n",
>> min_common_depth);
>>
>> +       for (nid = 0; nid < MAX_NUMNODES; nid ++)
>> +               for (dist = 0; dist < MAX_DISTANCE_REF_POINTS; dist++)
>> +                       distance_lookup_table[nid][dist] = nid;
>> +
>>         /*
>>          * Even though we connect cpus to numa domains later in SMP
>>          * init, we need to know the node ids now. This is because
> 
> What does that actually do? That is, what does it make the distance
> table look like before and after you bring up the CPUs?

By default the table is full of 0. When a CPU is brought up the value is
read from the device-tree and the table is updated. What I've seen is
this value is common for 2 nodes at a given level if they share the level.
So as the table is initialized with 0, all offline nodes (no memory no
cpu) are merged with node 0.
My fix initializes the table with unique values for each node, so by
default no nodes are mixed.

> 
>> Any comment?
> 
> Well, I had a few questions here:
> 
>   20190305115952.GH32477@hirez.programming.kicks-ass.net
> 
> that I've not yet seen answers to.

I didn't answer because:

- I thought this was not the good way to fix the problem as you said "it
seems very fragile and unfortunate",

- I don't have the answers, I'd really like someone from IBM that knows
well the NUMA part of powerpc answers to these questions... and perhaps
find a better solution.

Thanks,
Laurent



