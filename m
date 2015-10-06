Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 960221A0019
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 21:32:50 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Tue, 6 Oct 2015 16:02:46 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5F40C125801B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 16:02:23 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t96AWI2P20119604
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Oct 2015 16:02:23 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t96AWA5U020048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Oct 2015 16:02:11 +0530
Message-ID: <5613A37E.5040302@linux.vnet.ibm.com>
Date: Tue, 06 Oct 2015 16:03:34 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: benh@kernel.crashing.org, paulus@samba.org, nikunj@linux.vnet.ibm.com,
 nacc@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, anton@samba.org,
 grant.likely@linaro.org, cl@linux.com, khandual@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, gkurz@linux.vnet.ibm.com
Subject: Re: [RFC, 1/5] powerpc:numa Add numa_cpu_lookup function to update
 lookup table
References: <20151006101732.52907140D72@ozlabs.org>
In-Reply-To: <20151006101732.52907140D72@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/06/2015 03:47 PM, Michael Ellerman wrote:
> On Sun, 2015-27-09 at 18:29:09 UTC, Raghavendra K T wrote:
>> We access numa_cpu_lookup_table array directly in all the places
>> to read/update numa cpu lookup information. Instead use a helper
>> function to update.
>>
>> This is helpful in changing the way numa<-->cpu mapping in single
>> place when needed.
>>
>> This is a cosmetic change, no change in functionality.
>>
>> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.inet.ibm.com>
>> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/mmzone.h |  2 +-
>>   arch/powerpc/kernel/smp.c         | 10 +++++-----
>>   arch/powerpc/mm/numa.c            | 28 +++++++++++++++++-----------
>>   3 files changed, 23 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/mmzone.h b/arch/powerpc/include/asm/mmzone.h
>> index 7b58917..c24a5f4 100644
>> --- a/arch/powerpc/include/asm/mmzone.h
>> +++ b/arch/powerpc/include/asm/mmzone.h
>> @@ -29,7 +29,7 @@ extern struct pglist_data *node_data[];
>>    * Following are specific to this numa platform.
>>    */
>>
>> -extern int numa_cpu_lookup_table[];
>> +extern int numa_cpu_lookup(int cpu);
>
> Can you rename it better :)
>
> Something like cpu_to_nid().

Good name. sure.

>
> Although maybe nid is wrong given the rest of the series.

May be not. The current plan is to rename (after discussing with Nish)

chipid to pnid (physical nid)
and nid to vnid (virtual nid)

within powerpc numa.c
[reasoning chipid is applicable only to OPAL, since we want to handle
powerkvm, powervm and baremetal we need a generic name ]

But 'nid' naming will be retained which is applicable for generic
kernel interactions.

>
>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>> index 8b9502a..d5e6eee 100644
>> --- a/arch/powerpc/mm/numa.c
>> +++ b/arch/powerpc/mm/numa.c
>> @@ -52,7 +52,6 @@ int numa_cpu_lookup_table[NR_CPUS];
>>   cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
>>   struct pglist_data *node_data[MAX_NUMNODES];
>>
>> -EXPORT_SYMBOL(numa_cpu_lookup_table);
>>   EXPORT_SYMBOL(node_to_cpumask_map);
>>   EXPORT_SYMBOL(node_data);
>>
>> @@ -134,19 +133,25 @@ static int __init fake_numa_create_new_node(unsigned long end_pfn,
>>   	return 0;
>>   }
>>
>> -static void reset_numa_cpu_lookup_table(void)
>> +int numa_cpu_lookup(int cpu)
>>   {
>> -	unsigned int cpu;
>> -
>> -	for_each_possible_cpu(cpu)
>> -		numa_cpu_lookup_table[cpu] = -1;
>> +	return numa_cpu_lookup_table[cpu];
>>   }
>> +EXPORT_SYMBOL(numa_cpu_lookup);
>
> I don't see you changing any modular code that uses this, or any macros that
> might be used by modules, so I don't see why this needs to be exported?
>
> I think you just added it because num_cpu_lookup_table was exported?
>

arch/powerpc/kernel/smp.c uses it.
