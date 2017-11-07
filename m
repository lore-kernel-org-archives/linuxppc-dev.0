Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWSnh63F6zDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 23:06:16 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA7C4g4A073355
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Nov 2017 07:06:13 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e3a7j0676-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Nov 2017 07:06:12 -0500
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 7 Nov 2017 07:06:11 -0500
Subject: Re: [PATCH v2] powerpc/kernel/sysfs: Export ldbar spr to sysfs
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com
References: <1509466547-761-1-git-send-email-anju@linux.vnet.ibm.com>
 <87h8ue960z.fsf@concordia.ellerman.id.au>
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Tue, 7 Nov 2017 17:36:08 +0530
MIME-Version: 1.0
In-Reply-To: <87h8ue960z.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <48d62ebb-73b9-86c6-b1f2-39ee1d3ae846@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi mpe,


On Wednesday 01 November 2017 06:20 AM, Michael Ellerman wrote:
> Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
>
>> Add ldbar spr to sysfs. The spr will hold thread level In-Memory Collection (IMC)
>> counter configuration data.
> This is missing any justification for why we would want to expose this,
> and in particular why we would make it *writable*.
>
> cheers


Thank you for reviewing the patch.

LDBAR, holds the thread-level counter configuration. Exposing this will help
us to understand  the current status of thread-level counters in the system.
Primarily, Bit 0 of ldbar tells whether the counters are enabled or not.
And bit 1  tells the mode (if 0-Accumulation Mode/if 1-Trace Mode).

But regarding the permission, you are right. On a reassessment I think 
that the permission
should be read only, because it is possible that we may write an 
incorrect value to the ldbar, that is wrong.
So I will change the permission here.



Thanks,
Anju
>
>> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
>> index 4437c70..f8caee0 100644
>> --- a/arch/powerpc/kernel/sysfs.c
>> +++ b/arch/powerpc/kernel/sysfs.c
>> @@ -485,6 +485,7 @@ SYSFS_PMCSETUP(mmcra, SPRN_MMCRA);
>>   SYSFS_SPRSETUP(purr, SPRN_PURR);
>>   SYSFS_SPRSETUP(spurr, SPRN_SPURR);
>>   SYSFS_SPRSETUP(pir, SPRN_PIR);
>> +SYSFS_SPRSETUP(ldbar, SPRN_LDBAR);
>>   
>>   /*
>>     Lets only enable read for phyp resources and
>> @@ -492,6 +493,7 @@ SYSFS_SPRSETUP(pir, SPRN_PIR);
>>     Lets be conservative and default to pseries.
>>   */
>>   static DEVICE_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
>> +static DEVICE_ATTR(ldbar, 0600, show_ldbar, store_ldbar);
>>   static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
>>   static DEVICE_ATTR(purr, 0400, show_purr, store_purr);
>>   static DEVICE_ATTR(pir, 0400, show_pir, NULL);
>> @@ -757,6 +759,9 @@ static int register_cpu_online(unsigned int cpu)
>>   			device_create_file(s, &pmc_attrs[i]);
>>   
>>   #ifdef CONFIG_PPC64
>> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
>> +		device_create_file(s, &dev_attr_ldbar);
>> +
>>   	if (cpu_has_feature(CPU_FTR_MMCRA))
>>   		device_create_file(s, &dev_attr_mmcra);
>>   
>> @@ -842,6 +847,9 @@ static int unregister_cpu_online(unsigned int cpu)
>>   			device_remove_file(s, &pmc_attrs[i]);
>>   
>>   #ifdef CONFIG_PPC64
>> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
>> +		device_remove_file(s, &dev_attr_ldbar);
>> +
>>   	if (cpu_has_feature(CPU_FTR_MMCRA))
>>   		device_remove_file(s, &dev_attr_mmcra);
>>   
>> -- 
>> 2.7.4
