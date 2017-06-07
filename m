Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjRBB37JtzDqKY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 21:28:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, nish.aravamudan@gmail.com,
 Anton Blanchard <anton@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/numa: Fix percpu allocations to be NUMA aware
In-Reply-To: <CAKTCnznVed64wtCyyJYdwsJbm9O97RKPW19PymiPLrNzEw+TLw@mail.gmail.com>
References: <1496380487-21699-1-git-send-email-mpe@ellerman.id.au>
 <CAKTCnznVed64wtCyyJYdwsJbm9O97RKPW19PymiPLrNzEw+TLw@mail.gmail.com>
Date: Wed, 07 Jun 2017 21:28:01 +1000
Message-ID: <877f0of35q.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:
> On Fri, Jun 2, 2017 at 3:14 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
>> index 8b3b46b7b0f2..8f3b2ec09b9e 100644
>> --- a/arch/powerpc/include/asm/topology.h
>> +++ b/arch/powerpc/include/asm/topology.h
>> @@ -44,8 +44,22 @@ extern void __init dump_numa_cpu_topology(void);
>>  extern int sysfs_add_device_to_node(struct device *dev, int nid);
>>  extern void sysfs_remove_device_from_node(struct device *dev, int nid);
>>
>> +static inline int early_cpu_to_node(int cpu)
>> +{
>> +       int nid;
>> +
>> +       nid = numa_cpu_lookup_table[cpu];
>> +
>> +       /*
>> +        * Some functions, eg. node_distance() don't cope with -1, so instead
>> +        * fall back to node 0 if nid is unset (it should be, except bugs).
>> +        */
>> +       return (nid < 0) ? 0 : nid;
>> +}
>>  #else
>
> Not sure if its entirely related, but I had tried to do
>
> https://patchwork.ozlabs.org/patch/683556/
>
> to setup the mapping earlier, but we would have still missed the pcpu_fc_alloc.

It's related. But doesn't fix this bug.

I didn't merge it because I assumed it wouldn't build with
CONFIG_NUMA=n, but seems it does so I'll grab it.

cheers
