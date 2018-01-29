Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVXnT4cdWzDrC2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 02:03:09 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0TF1JqA004597
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 10:03:07 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ft5t68cek-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 10:03:06 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 29 Jan 2018 10:03:05 -0500
Subject: Re: [PATCH V2] powerpc/kernel: Add 'ibm,thread-groups' property for
 CPU allocation
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
References: <aeffc542-db28-7d1f-3263-52919b2d07c2@linux.vnet.ibm.com>
 <87efmb39yn.fsf@concordia.ellerman.id.au>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Mon, 29 Jan 2018 09:02:28 -0600
MIME-Version: 1.0
In-Reply-To: <87efmb39yn.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <5aea9d6a-eb25-23b4-19d1-fb67a57d183a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

You are correct.  I found a problem with multiple cores last week,
and I have a new patch in testing.  I will resubmit it after more
testing.

Sorry for the inconvenience.

Michael

On 01/27/2018 03:52 AM, Michael Ellerman wrote:
> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> 
>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index b15bae2..0a49231 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -303,6 +306,71 @@ static void __init check_cpu_feature_properties(unsigned long node)
>>  	}
>>  }
>>  
>> +static void __init early_init_setup_thread_group_mask(unsigned long node,
>> +						cpumask_t *thread_group_mask)
>> +{
>> +	const __be32 *thrgrp;
>> +	int len, rc = 0;
>> +	u32 cc_type = 0, no_split = 0, thr_per_split = 0;
>> +	int j, k;
>> +
>> +	cpumask_clear(thread_group_mask);
>> +
>> +	thrgrp = of_get_flat_dt_prop(node, "ibm,thread-groups", &len);
>> +	if (!thrgrp)
>> +		return;
> 
> This breaks booting on all my systems.
> 
> cheers
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
