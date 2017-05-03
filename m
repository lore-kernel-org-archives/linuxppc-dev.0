Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHsLY4GBjzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 18:50:29 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v438nEb6061898
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 May 2017 04:50:22 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a7aasv79y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 May 2017 04:50:22 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 3 May 2017 18:50:19 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v438o83g1704346
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 May 2017 18:50:16 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v438nh9O008596
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 May 2017 18:49:43 +1000
Subject: Re: [PATCH v4 RFT 1/2] powerpc/fadump: reduce memory consumption for
 capture kernel
To: Michal Suchanek <msuchanek@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
 Michal Hocko <mhocko@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170502155611.6789-1-msuchanek@suse.de>
 <765ca86f-b6c5-190e-b3a9-91282e199baf@linux.vnet.ibm.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 3 May 2017 14:19:19 +0530
MIME-Version: 1.0
In-Reply-To: <765ca86f-b6c5-190e-b3a9-91282e199baf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <c70b9fde-c3a1-751c-b69e-942d8a6b81af@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 03 May 2017 12:43 PM, Hari Bathini wrote:
>
>
> On Tuesday 02 May 2017 09:26 PM, Michal Suchanek wrote:
>> With fadump (dump capture) kernel booting like a regular kernel, it 
>> almost
>> needs the same amount of memory to boot as the production kernel, 
>> which is
>> unwarranted for a dump capture kernel. But with no option to disable 
>> some
>> of the unnecessary subsystems in fadump kernel, that much memory is 
>> wasted
>> on fadump, depriving the production kernel of that memory.
>>
>> Introduce kernel parameter 'fadump_append=' that would take regular 
>> kernel
>> parameters to be appended when fadump is active.
>> This 'fadump_append=' parameter can be leveraged to pass parameters like
>> nr_cpus=1, cgroup_disable=memory and numa=off, to disable unwarranted
>> resources/subsystems.
>>
>> Also, ensure the log "Firmware-assisted dump is active" is printed early
>> in the boot process to put the subsequent fadump messages in context.
>>
>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
>> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>> ---
>> v4:
>>   - use space separated arguments instead of comma separated
>>   - do not append parameters when fadummp is disabled
>> ---
>>   arch/powerpc/kernel/fadump.c | 27 ++++++++++++++++++++++++---
>>   1 file changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>> index ebf2e9c..e0c728a 100644
>> --- a/arch/powerpc/kernel/fadump.c
>> +++ b/arch/powerpc/kernel/fadump.c
>> @@ -79,8 +79,10 @@ int __init early_init_dt_scan_fw_dump(unsigned 
>> long node,
>>        * dump data waiting for us.
>>        */
>>       fdm_active = of_get_flat_dt_prop(node, "ibm,kernel-dump", NULL);
>> -    if (fdm_active)
>> +    if (fdm_active) {
>> +        pr_info("Firmware-assisted dump is active.\n");
>>           fw_dump.dump_active = 1;
>> +    }
>>
>>       /* Get the sizes required to store dump data for the firmware 
>> provided
>>        * dump sections.
>> @@ -263,8 +265,12 @@ int __init fadump_reserve_mem(void)
>>   {
>>       unsigned long base, size, memory_boundary;
>>
>> -    if (!fw_dump.fadump_enabled)
>> +    if (!fw_dump.fadump_enabled) {
>> +        if (fw_dump.dump_active)
>> +            pr_warn("Firmware-assisted dump was active but kernel"
>> +                " booted with fadump disabled!\n");
>>           return 0;
>> +    }
>>
>>       if (!fw_dump.fadump_supported) {
>>           printk(KERN_INFO "Firmware-assisted dump is not supported on"
>> @@ -304,7 +310,6 @@ int __init fadump_reserve_mem(void)
>>           memory_boundary = memblock_end_of_DRAM();
>>
>>       if (fw_dump.dump_active) {
>> -        printk(KERN_INFO "Firmware-assisted dump is active.\n");
>>           /*
>>            * If last boot has crashed then reserve all the memory
>>            * above boot_memory_size so that we don't touch it until
>> @@ -363,6 +368,22 @@ unsigned long __init 
>> arch_reserved_kernel_pages(void)
>>       return memblock_reserved_size() / PAGE_SIZE;
>>   }
>>
>> +/* Look for fadump_append= cmdline option. */
>> +static int __init early_fadump_append_param(char *p)
>> +{
>> +    if (!p)
>> +        return 1;
>> +
>> +    if (fw_dump.fadump_enabled && fw_dump.dump_active) {
>> +    pr_info("enforcing additional parameters (%s) passed through "
>> +        "'fadump_append=' parameter\n", p);
>> +        parse_early_options(p);
>
> While testing this on a system with yaboot bootloader, it seems that 
> parsing
> a parameter with syntax like fadump_append="nr_cpus numa=off" is not

fadump_append="nr_cpus numa=off" should have read 
fadump_append="nr_cpus=1 numa=off".
Nonetheless, considering different environments this is supposed to 
work, I was trying to convey
comma-separated append list maybe better over space-separated one..

Thanks
Hari
