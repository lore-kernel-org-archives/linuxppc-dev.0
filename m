Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhW3x2v87zDqjB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 16:19:57 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAM5JMPk138509
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 00:19:55 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ecwfapjfd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 00:19:54 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 22 Nov 2017 05:19:53 -0000
Subject: Re: [PATCH 2/2] powerpc/perf: Fix IMC_MAX_PMU macro
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
References: <1510346389-16505-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1510346389-16505-2-git-send-email-maddy@linux.vnet.ibm.com>
 <87wp2j2jir.fsf@concordia.ellerman.id.au>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 22 Nov 2017 10:49:48 +0530
MIME-Version: 1.0
In-Reply-To: <87wp2j2jir.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1d964e85-472f-9f11-e58e-23ce1c217e65@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 22 November 2017 06:53 AM, Michael Ellerman wrote:
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
>
>> diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
>> index b150f4deaccf..4764e6932cb7 100644
>> --- a/arch/powerpc/platforms/powernv/opal-imc.c
>> +++ b/arch/powerpc/platforms/powernv/opal-imc.c
>> @@ -153,6 +153,22 @@ static void disable_core_pmu_counters(void)
>>   	put_online_cpus();
>>   }
>>   
>> +int get_max_nest_dev(void)
>> +{
>> +	struct device_node *node;
>> +	u32 pmu_units, type;
>> +
>> +	for_each_compatible_node(node, NULL, IMC_DTB_UNIT_COMPAT) {
>> +		if (of_property_read_u32(node, "type", &type))
>> +			continue;
>> +
>> +		if (type == IMC_TYPE_CHIP)
>> +			pmu_units++;
>> +	}
>> +
>> +	return pmu_units;
>> +}
> Breaks:
>
>    arch/powerpc/platforms/powernv/opal-imc.c:169:2: error: 'pmu_units' may be used uninitialized in this function [-Werror=maybe-uninitialized]

My bad. My cross tool also missed to catch this.
Will respin.

Maddy


>
> http://kisskb.ellerman.id.au/kisskb/head/1e59fb813346ee43be2a3a9acf4aac2815af1284/
>
> cheers
>
