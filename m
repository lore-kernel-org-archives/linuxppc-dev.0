Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40kv9p0DLNzF29L
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 18:33:49 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4E8SuQJ138682
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 04:33:47 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hy61kaqan-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 04:33:46 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 14 May 2018 02:33:46 -0600
Subject: Re: [PATCH] powerpc/perf: Fix memory allocation for core-imc based on
 num_possible_cpus()
To: Balbir Singh <bsingharora@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, ppaidipe@linux.vnet.ibm.com
References: <1526046222-17842-1-git-send-email-anju@linux.vnet.ibm.com>
 <CAKTCnzn1QmirDJNOJ5hVB0wKE-wpVLePivZocZ8g0e+sA4O7Wg@mail.gmail.com>
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Mon, 14 May 2018 14:02:24 +0530
MIME-Version: 1.0
In-Reply-To: <CAKTCnzn1QmirDJNOJ5hVB0wKE-wpVLePivZocZ8g0e+sA4O7Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e36d5e9e-0d93-0641-061e-730444f1c621@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,


On Saturday 12 May 2018 06:05 AM, Balbir Singh wrote:
> On Fri, May 11, 2018 at 11:43 PM, Anju T Sudhakar
> <anju@linux.vnet.ibm.com> wrote:
>> Currently memory is allocated for core-imc based on cpu_present_mask, which has
>> bit 'cpu' set iff cpu is populated. We use  (cpu number / threads per core)
>> as as array index to access the memory.
>> So in a system with guarded cores, since allocation happens based on
>> cpu_present_mask, (cpu number / threads per core) bounds the index and leads
>> to memory overflow.
>>
>> The issue is exposed in a guard test.
>> The guard test will make some CPU's as un-available to the system during boot
>> time as well as at runtime. So when the cpu is unavailable to the system during
>> boot time, the memory allocation happens depending on the number of available
>> cpus. And when we access the memory using (cpu number / threads per core) as the
>> index the system crashes due to memory overflow.
>>
>> Allocating memory for core-imc based on cpu_possible_mask, which has
>> bit 'cpu' set iff cpu is populatable, will fix this issue.
>>
>> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
>> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/perf/imc-pmu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> The changelog does not clearly call out the confusion between present
> and possible.
> Guarded CPUs are possible but not present, so it blows a hole when we assume the
> max length of our allocation is driven by our max present cpus, where
> as one of the cpus
> might be online and be beyond the max present cpus, due to the hole..
>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
>
> Balbir Singh.
>

Thanks for the review.
OK. I will update the commit message here.



Regards,
Anju
