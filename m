Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 309321A0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 17:26:42 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 23 Jul 2015 12:56:38 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 544FE1258074
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 12:59:35 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6N7Q3wd49414238
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 12:56:05 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6N7PsJ0004808
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 12:55:56 +0530
Message-ID: <55B096FF.80407@linux.vnet.ibm.com>
Date: Thu, 23 Jul 2015 12:55:51 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Stephane Eranian <eranian@google.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Preeti U Murthy <preetium@andrew.cmu.edu>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 7/7] powerpc/powernv: nest pmu cpumask and cpu hotplug
 support
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1437045206-7491-8-git-send-email-maddy@linux.vnet.ibm.com>
 <1437541404.30906.43.camel@axtens.net>	 <55B08E28.3090902@linux.vnet.ibm.com>
 <1437634142.13972.12.camel@axtens.net>
In-Reply-To: <1437634142.13972.12.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 23 July 2015 12:19 PM, Daniel Axtens wrote:
> On Thu, 2015-07-23 at 12:18 +0530, Madhavan Srinivasan wrote:
>> On Wednesday 22 July 2015 10:33 AM, Daniel Axtens wrote:
>>>> +static void nest_change_cpu_context(int old_cpu, int new_cpu)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; per_nest_pmu_arr[i] != NULL; i++)
>>>> +		perf_pmu_migrate_context(&per_nest_pmu_arr[i]->pmu,
>>>> +						old_cpu, new_cpu);
>>> From patch 4, I see per_nest_pmu_arr is defined as:
>>>  +static struct nest_pmu *per_nest_pmu_arr[P8_NEST_MAX_PMUS];
>>>
>>> Therefore, does this loop need to have a check that 
>>> i < P8_NEST_MAX_PMUS?
>> No, that is max possible pmu, but we may have only couple for nest pmus
>> registered.
>>
> What if we have P8_NEST_MAX_PMUS registered? Then we'll check beyond the
> end of the array...

OK, i will add check for P8_NEST_MAX_PMUS also.

>> Thanks for the review comments
>> Maddy
