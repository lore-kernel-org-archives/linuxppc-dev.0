Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A93C61A0EFC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 17:06:47 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 01316140283
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 17:06:46 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 12 Jun 2015 12:36:44 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 380A53940062
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 12:36:38 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5C76ZAn14352638
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 12:36:36 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5C76YaP007378
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 12:36:35 +0530
Message-ID: <557A84FA.6040902@linux.vnet.ibm.com>
Date: Fri, 12 Jun 2015 12:36:34 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH V8 02/10] powerpc, perf: Restore privillege level filter
 support for BHRB
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-2-git-send-email-khandual@linux.vnet.ibm.com>
 <1433907837.3096.11.camel@axtens.net> <557828CB.9080806@linux.vnet.ibm.com>
 <1433993307.31423.35.camel@axtens.net>
In-Reply-To: <1433993307.31423.35.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/2015 08:58 AM, Daniel Axtens wrote:
> 
>>>>  
>>>> -	if (!(ppmu->flags & PPMU_ARCH_207S)) {
>>>> +	if (!(ppmu->flags & PPMU_ARCH_207S) || cpuhw->bhrb_users)
>>
>>> You're using cpuhw->bhrb_users as a bool here, where it's an int. Could
>>> you make the test more specific so that it's clear exactly what you're
>>> expecting bhrb_users to contain?
>>
>> Using cpuhw->bhrb_users as a bool just verifies whether it contains
>> zero or non-zero value in it. The test seems to be doing that as
>> expected. But yes, we can move it as a nested conditional block as
>> well if that is better.
>>
> 
> What I meant was, should this read (cpuhw->bhrb_users != 0)? Because
> bhrb_users in check_excludes() is a signed int, I also wanted to make
> sure it shouldn't be a test for bhrb_users > 0 instead. (Also, if
> bhrb_users is always positive, should it be an unsigned int?)

Will replace both the conditional checks in comparison against 0.
Will change the data type of bhrb_users into unsigned int as well.

> 
> I don't think a nested conditional would be better. 

Okay.

> 
> 
> 
>>>> -	if (check_excludes(ctrs, cflags, n, 1))
>>>> +	cpuhw = &get_cpu_var(cpu_hw_events);
>>> Should this be using a this_cpu_ptr rather than a get_cpu_var? (as with
>>> the power_pmu_commit_txn case?)
>>>> +	if (check_excludes(ctrs, cflags, n, 1, cpuhw->bhrb_users)) {
>>>> +		put_cpu_var(cpu_hw_events);
>>> Likewise with this?
>>>>  		return -EINVAL;
>>>> +	}
>>>>  
>>>> -	cpuhw = &get_cpu_var(cpu_hw_events);
>>
>> This patch just moves the existing code couple of lines above without
>> changing it in any manner.
>>
> I see that, but I still think you should take this opportunity to
> improve it.

Will try to change it in a separate patch.
