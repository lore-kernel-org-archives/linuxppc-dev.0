Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E69FC1A02CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 16:49:05 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 23 Jul 2015 16:49:05 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D1BAA2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 16:49:02 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6N6msPF59965510
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 16:49:02 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6N6mT0Q031648
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 16:48:30 +1000
Message-ID: <55B08E28.3090902@linux.vnet.ibm.com>
Date: Thu, 23 Jul 2015 12:18:08 +0530
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
 <1437541404.30906.43.camel@axtens.net>
In-Reply-To: <1437541404.30906.43.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 22 July 2015 10:33 AM, Daniel Axtens wrote:
>> +static void nest_change_cpu_context(int old_cpu, int new_cpu)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; per_nest_pmu_arr[i] != NULL; i++)
>> +		perf_pmu_migrate_context(&per_nest_pmu_arr[i]->pmu,
>> +						old_cpu, new_cpu);
> From patch 4, I see per_nest_pmu_arr is defined as:
>  +static struct nest_pmu *per_nest_pmu_arr[P8_NEST_MAX_PMUS];
>
> Therefore, does this loop need to have a check that 
> i < P8_NEST_MAX_PMUS?

No, that is max possible pmu, but we may have only couple for nest pmus
registered.

Thanks for the review comments
Maddy
>
