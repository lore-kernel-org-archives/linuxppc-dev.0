Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBB8B1A19DD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 22:52:08 +1000 (AEST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 46A561402EC
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 22:52:08 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 25 Jun 2015 18:22:06 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2F596E0058
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 18:25:40 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5PCppwf393654
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 18:21:52 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5PBnjT3023738
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 17:19:45 +0530
Message-ID: <558BF964.3070007@linux.vnet.ibm.com>
Date: Thu, 25 Jun 2015 18:21:48 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH V9 04/13] powerpc, perf: Restore privilege level filter
 support for BHRB
References: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1434370268-19056-5-git-send-email-khandual@linux.vnet.ibm.com>
 <1435208534.4286.25.camel@axtens.net>
In-Reply-To: <1435208534.4286.25.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2015 10:32 AM, Daniel Axtens wrote:
> 
>> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
>> index 7a03cce..892340e 100644
>> --- a/arch/powerpc/perf/core-book3s.c
>> +++ b/arch/powerpc/perf/core-book3s.c
>> @@ -930,7 +930,7 @@ static int power_check_constraints(struct cpu_hw_events *cpuhw,
>>   * added events.
>>   */
>>  static int check_excludes(struct perf_event **ctrs, unsigned int cflags[],
>> -			  int n_prev, int n_new)
>> +			  int n_prev, int n_new, int bhrb_users)
> Shouldn't this be an unsigned int too?

Yeah it should be, will change it.

> 
>> -	if (ppmu->flags & PPMU_ARCH_207S)
>> +	if ((ppmu->flags & PPMU_ARCH_207S) && !bhrb_users)
> This is now different to the others. Now that bhrb_users is unsigned,
> I'm happy if you want to revert all of them to be like this, I was just
> concerned that if bhrb_users is an int, both 1 and -1 evaluate to true
> and I wasn't sure that was the desired behaviour.

Sure, will change it.
