Return-Path: <cyril.bur@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 250A21A0037
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 13:53:17 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyril.bur@au1.ibm.com>;
 Thu, 4 Sep 2014 13:53:15 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AFE003578054
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 13:53:11 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s843sNKs34144494
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Sep 2014 13:54:23 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s843rAGW006979
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Sep 2014 13:53:10 +1000
Message-ID: <5407E220.8030309@au1.ibm.com>
Date: Thu, 04 Sep 2014 13:53:04 +1000
From: Cyril Bur <cyril.bur@au1.ibm.com>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 2/3] powerpc: Only set numa node information for
 present cpus at boottime
References: <1409132041-11890-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1409132041-11890-2-git-send-email-zhong@linux.vnet.ibm.com>
 <20140903030247.GB31420@linux.vnet.ibm.com>
In-Reply-To: <20140903030247.GB31420@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03/09/14 13:02, Nishanth Aravamudan wrote:
> On 27.08.2014 [17:34:00 +0800], Li Zhong wrote:
>> As Nish suggested, it makes more sense to init the numa node informatiion
>> for present cpus at boottime, which could also avoid WARN_ON(1) in
>> numa_setup_cpu().
Hit this on a Power8 LPAR. With the patchset applied the warnings no 
longer present.
>>
>> With this change, we also need to change the smp_prepare_cpus() to set up
>> numa information only on present cpus.
>>
>> For those possible, but not present cpus, their numa information
>> will be set up after they are started, as the original code did before commit
>> 2fabf084b6ad.
>>
>> Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
>> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
>> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
>
> Acked-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

Tested-by: Cyril Bur <cyril.bur@au1.ibm.com>
>> ---
>>   arch/powerpc/kernel/smp.c | 10 ++++++++--
>>   arch/powerpc/mm/numa.c    |  2 +-
>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> index a0738af..dc0e774 100644
>> --- a/arch/powerpc/kernel/smp.c
>> +++ b/arch/powerpc/kernel/smp.c
>> @@ -379,8 +379,11 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>>   		/*
>>   		 * numa_node_id() works after this.
>>   		 */
>> -		set_cpu_numa_node(cpu, numa_cpu_lookup_table[cpu]);
>> -		set_cpu_numa_mem(cpu, local_memory_node(numa_cpu_lookup_table[cpu]));
>> +		if (cpu_present(cpu)) {
>> +			set_cpu_numa_node(cpu, numa_cpu_lookup_table[cpu]);
>> +			set_cpu_numa_mem(cpu,
>> +				local_memory_node(numa_cpu_lookup_table[cpu]));
>> +		}
>>   	}
>>
>>   	cpumask_set_cpu(boot_cpuid, cpu_sibling_mask(boot_cpuid));
>> @@ -728,6 +731,9 @@ void start_secondary(void *unused)
>>   	}
>>   	traverse_core_siblings(cpu, true);
>>
>> +	set_numa_node(numa_cpu_lookup_table[cpu]);
>> +	set_numa_mem(local_memory_node(numa_cpu_lookup_table[cpu]));
>> +
>>   	smp_wmb();
>>   	notify_cpu_starting(cpu);
>>   	set_cpu_online(cpu, true);
>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>> index 9918c02..3a9061e 100644
>> --- a/arch/powerpc/mm/numa.c
>> +++ b/arch/powerpc/mm/numa.c
>> @@ -1127,7 +1127,7 @@ void __init do_init_bootmem(void)
>>   	 * even before we online them, so that we can use cpu_to_{node,mem}
>>   	 * early in boot, cf. smp_prepare_cpus().
>>   	 */
>> -	for_each_possible_cpu(cpu) {
>> +	for_each_present_cpu(cpu) {
>>   		numa_setup_cpu((unsigned long)cpu);
>>   	}
>>   }
>> --
>> 1.9.1
>>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
