Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0B6E1A0456
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 17:06:26 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A5978140283
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 17:06:26 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 12 Jun 2015 17:06:25 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DDEA5357804F
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 17:06:23 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5C750RA33095840
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 17:05:08 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5C74ZEF030990
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 17:04:36 +1000
Message-ID: <557A8472.6070900@linux.vnet.ibm.com>
Date: Fri, 12 Jun 2015 12:34:18 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH V8 09/10] powerpc, perf: Enable privilege mode SW branch
 filters
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-9-git-send-email-khandual@linux.vnet.ibm.com>
 <1433985583.31423.4.camel@axtens.net>
In-Reply-To: <1433985583.31423.4.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/2015 06:49 AM, Daniel Axtens wrote:
>> 	if (sw_filter & PERF_SAMPLE_BRANCH_PLM_ALL) {
>> +		flag = false;
> Would it be possible to use a more meaningful name than flag? Perhaps
> indicating what is it flagging?

sure, will change it with "select_branch"

>> +
>> +		if (sw_filter & PERF_SAMPLE_BRANCH_USER) {
>> +			if (to_plm == POWER_ADDR_USER)
>> +				flag = true;
>> +		}
>> +
>> +		if (sw_filter & PERF_SAMPLE_BRANCH_KERNEL) {
>> +			if (to_plm == POWER_ADDR_KERNEL)
>> +				flag = true;
>> +		}
>> +
>> +		if (sw_filter & PERF_SAMPLE_BRANCH_HV) {
>> +			if (cpu_has_feature(CPU_FTR_HVMODE)) {
>> +				if (to_plm == POWER_ADDR_KERNEL)
>> +					flag = true;
>> +			}
>> +		}
> 
> Is there any reason these are nested ifs rather than &&s?

No reason as such, will change it.

> 
>> +
>> +		if (!flag)
>> +			return false;
>> +	}
>> +
> 
>> @@ -700,7 +710,6 @@ static u64 power8_bhrb_filter_map(u64 branch_sample_type, u64 *bhrb_filter)
>>  			if (branch_sample_type) {
>>  				/* Multiple filters will be processed in SW */
>>  				pmu_bhrb_filter = 0;
>> -				*bhrb_filter = 0;
>>  				return pmu_bhrb_filter;
>>  			} else {
>>  				/* Individual filter will be processed in HW */
> What's the justification for the removal of this line? You added it in
> the previous patch...

Previously PMU passed the entire branch processing to SW by indicating
0 in the bhrb_filter mask although it was handling the privilege level
requests received from the normal PMU event. SW just ignored privilege
level requests while figuring out what other filters which need to be
processed for each captured branch.

Now that we support privilege level SW branch filters, PMU needs to
exclusively inform SW about it, so that SW does not do the processing
itself assuming its not already taken care of. That is the reason why
we removed the above statement and added this code block here instead.

        if (branch_sample_type & PERF_SAMPLE_BRANCH_USER)
                *bhrb_filter |= PERF_SAMPLE_BRANCH_USER;

        if (branch_sample_type & PERF_SAMPLE_BRANCH_KERNEL)
                *bhrb_filter |= PERF_SAMPLE_BRANCH_KERNEL;

        if (branch_sample_type & PERF_SAMPLE_BRANCH_HV)
                *bhrb_filter |= PERF_SAMPLE_BRANCH_HV;
