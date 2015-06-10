Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411081A0023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 22:09:10 +1000 (AEST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 33B7B14028F
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 22:09:09 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 17:39:06 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id AA8FEE0059
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 17:42:26 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5AC8kpT47251470
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 17:38:47 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5AC8jAH002495
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 17:38:46 +0530
Message-ID: <557828CB.9080806@linux.vnet.ibm.com>
Date: Wed, 10 Jun 2015 17:38:43 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH V8 02/10] powerpc, perf: Restore privillege level filter
 support for BHRB
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-2-git-send-email-khandual@linux.vnet.ibm.com>
 <1433907837.3096.11.camel@axtens.net>
In-Reply-To: <1433907837.3096.11.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/10/2015 09:13 AM, Daniel Axtens wrote:
> In the subject line, privilege should only have 1 l, and I think it
> should probably start with "powerpc/perf:" rather than "powerpc, perf:".

Will fix the typo here. Have been using "powerpc, perf:" format for some
time now :) Seems to be more cleaner compared to "powerpc/perf:" format.
But again its subjective.

 > > On Mon, 2015-06-08 at 17:08 +0530, Anshuman Khandual wrote:
>> From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>
>>
>> 'commit 9de5cb0f6df8 ("powerpc/perf: Add per-event excludes on Power8")'
> Does this need a 'Fixes:' tag then?

Not really, it only fixes the BHRB privilege request cases not other
scenarios which are impacted by this previous commit.
 
> 
>> broke the PMU based BHRB privilege level filter. BHRB depends on the
>> same MMCR0 bits for privilege level filter which was used to freeze all
>> the PMCs as a group. Once we moved to individual event based privilege
>> filters through MMCR2 register on POWER8, event associated privilege
>> filters are no longer applicable to the BHRB captured branches.
>>
>> This patch solves the problem by restoring to the previous method of
>> privilege level filters for the event in case BHRB based branch stack
>> sampling is requested. This patch also changes 'check_excludes' for
>> the same reason.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/perf/core-book3s.c | 19 +++++++++++--------
>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
>> index c246e65..ae61629 100644
>> --- a/arch/powerpc/perf/core-book3s.c
>> +++ b/arch/powerpc/perf/core-book3s.c
>> @@ -930,7 +930,7 @@ static int power_check_constraints(struct cpu_hw_events *cpuhw,
>>   * added events.
>>   */
> Does this comment need to be updated?

Not really. The previous commit did not update it, hence this patch would
skip it as well.

>>  static int check_excludes(struct perf_event **ctrs, unsigned int cflags[],
>> -			  int n_prev, int n_new)
>> +			  int n_prev, int n_new, int bhrb_users)
>>  {
>>  	int eu = 0, ek = 0, eh = 0;
>>  	int i, n, first;
>> @@ -941,7 +941,7 @@ static int check_excludes(struct perf_event **ctrs, unsigned int cflags[],
>>  	 * don't need to do any of this logic. NB. This assumes no PMU has both
>>  	 * per event exclude and limited PMCs.
>>  	 */
> Likewise, does this comment need to be updated?

Yeah, will update it.

>> -	if (ppmu->flags & PPMU_ARCH_207S)
>> +	if ((ppmu->flags & PPMU_ARCH_207S) && !bhrb_users)
>>  		return 0;
>>  
>>  	n = n_prev + n_new;
>> @@ -1259,7 +1259,7 @@ static void power_pmu_enable(struct pmu *pmu)
>>  		goto out;
>>  	}
>>  
>> -	if (!(ppmu->flags & PPMU_ARCH_207S)) {
>> +	if (!(ppmu->flags & PPMU_ARCH_207S) || cpuhw->bhrb_users)

> You're using cpuhw->bhrb_users as a bool here, where it's an int. Could
> you make the test more specific so that it's clear exactly what you're
> expecting bhrb_users to contain?

Using cpuhw->bhrb_users as a bool just verifies whether it contains
zero or non-zero value in it. The test seems to be doing that as
expected. But yes, we can move it as a nested conditional block as
well if that is better.

>>  {
>>  		/*
>>  		 * Add in MMCR0 freeze bits corresponding to the attr.exclude_*
>>  		 * bits for the first event. We have already checked that all
>> @@ -1284,7 +1284,7 @@ static void power_pmu_enable(struct pmu *pmu)
>>  	mtspr(SPRN_MMCR1, cpuhw->mmcr[1]);
>>  	mtspr(SPRN_MMCR0, (cpuhw->mmcr[0] & ~(MMCR0_PMC1CE | MMCR0_PMCjCE))
>>  				| MMCR0_FC);
>> -	if (ppmu->flags & PPMU_ARCH_207S)
>> +	if ((ppmu->flags & PPMU_ARCH_207S) && !cpuhw->bhrb_users)
>>  		mtspr(SPRN_MMCR2, cpuhw->mmcr[3]);
>>  
>>  	/*
>> @@ -1436,7 +1436,8 @@ static int power_pmu_add(struct perf_event *event, int ef_flags)
>>  	if (cpuhw->group_flag & PERF_EVENT_TXN)
>>  		goto nocheck;
>>  
>> -	if (check_excludes(cpuhw->event, cpuhw->flags, n0, 1))
>> +	if (check_excludes(cpuhw->event, cpuhw->flags,
>> +				n0, 1, cpuhw->bhrb_users))
>>  		goto out;
>>  	if (power_check_constraints(cpuhw, cpuhw->events, cpuhw->flags, n0 + 1))
>>  		goto out;
>> @@ -1615,7 +1616,7 @@ static int power_pmu_commit_txn(struct pmu *pmu)
>>  		return -EAGAIN;
>>  	cpuhw = this_cpu_ptr(&cpu_hw_events);
>>  	n = cpuhw->n_events;
>> -	if (check_excludes(cpuhw->event, cpuhw->flags, 0, n))
>> +	if (check_excludes(cpuhw->event, cpuhw->flags, 0, n, cpuhw->bhrb_users))
>>  		return -EAGAIN;
>>  	i = power_check_constraints(cpuhw, cpuhw->events, cpuhw->flags, n);
>>  	if (i < 0)
>> @@ -1828,10 +1829,12 @@ static int power_pmu_event_init(struct perf_event *event)
>>  	events[n] = ev;
>>  	ctrs[n] = event;
>>  	cflags[n] = flags;
>> -	if (check_excludes(ctrs, cflags, n, 1))
>> +	cpuhw = &get_cpu_var(cpu_hw_events);
> Should this be using a this_cpu_ptr rather than a get_cpu_var? (as with
> the power_pmu_commit_txn case?)
>> +	if (check_excludes(ctrs, cflags, n, 1, cpuhw->bhrb_users)) {
>> +		put_cpu_var(cpu_hw_events);
> Likewise with this?
>>  		return -EINVAL;
>> +	}
>>  
>> -	cpuhw = &get_cpu_var(cpu_hw_events);

This patch just moves the existing code couple of lines above without
changing it in any manner.
