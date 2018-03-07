Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zx1XJ63XczF1b1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 15:54:40 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w274sA4q012330
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2018 23:54:38 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gj5ceypjh-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 23:54:38 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 7 Mar 2018 04:54:36 -0000
Subject: Re: [PATCH 1/2] powerpc/perf: Fix kernel address leak to userspace
 via BHRB buffer
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
References: <1520164518-19097-1-git-send-email-maddy@linux.vnet.ibm.com>
 <CAKTCnzmY3-n3ZxdUJb_yE_K4sY93j+DfaDVEPBKaGUo_dgbaQg@mail.gmail.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 7 Mar 2018 10:24:30 +0530
MIME-Version: 1.0
In-Reply-To: <CAKTCnzmY3-n3ZxdUJb_yE_K4sY93j+DfaDVEPBKaGUo_dgbaQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <bf087c8a-bb34-a4b4-840e-49199c058718@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 05 March 2018 11:46 AM, Balbir Singh wrote:
> On Sun, Mar 4, 2018 at 10:55 PM, Madhavan Srinivasan
> <maddy@linux.vnet.ibm.com> wrote:
>> The current Branch History Rolling Buffer (BHRB) code does
>> not check for any privilege levels before updating the data
>> from BHRB. This leaks kernel addresses to userspace even when
>> profiling only with userspace privileges. Add proper checks
>> to prevent it.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/perf/core-book3s.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
>> index f89bbd54ecec..337db5831749 100644
>> --- a/arch/powerpc/perf/core-book3s.c
>> +++ b/arch/powerpc/perf/core-book3s.c
>> @@ -457,6 +457,10 @@ static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
>>                                  /* invalid entry */
>>                                  continue;
>>
>> +                       if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN) &&
>> +                               is_kernel_addr(addr))
>> +                               continue;
>> +
>
> Looks good to me. The scope of the leaks concern is KASLR related or
> something else (figuring out what's in the cache?)

I did not look at it closely. But will get the information.

Thanks for the review
Maddy

>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
>
> Balbir Singh.
>
