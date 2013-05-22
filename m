Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C9462C00A7
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 18:59:39 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 22 May 2013 14:22:23 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 422E51258052
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 14:31:30 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4M8xQ5V54263934
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 14:29:27 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4M8xUNg031835
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 08:59:30 GMT
Message-ID: <519C88D9.30009@linux.vnet.ibm.com>
Date: Wed, 22 May 2013 14:29:05 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc, perf: Ignore separate BHRB privilege state
 filter request
References: <1369201667-9048-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1369201667-9048-2-git-send-email-khandual@linux.vnet.ibm.com>
 <1369206855.12874.9.camel@concordia>
In-Reply-To: <1369206855.12874.9.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 
> Your description from patch 0 should be here.
>

Sure, will bring it here.

> 
>> diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
>> index f7d1c4f..8ed323d 100644
>> --- a/arch/powerpc/perf/power8-pmu.c
>> +++ b/arch/powerpc/perf/power8-pmu.c
>> @@ -525,16 +525,17 @@ static u64 power8_bhrb_filter_map(u64 branch_sample_type)
>>  	u64 pmu_bhrb_filter = 0;
>>  	u64 br_privilege = branch_sample_type & ONLY_PLM;
>>  
>> -	/* BHRB and regular PMU events share the same prvillege state
>> +	/* BHRB and regular PMU events share the same prvilege state
> 
> Please spell "privilege" correctly.
> 

My bad, will fix it.


>>  	 * filter configuration. BHRB is always recorded along with 
> It still says "privilege state filter criteria for the BHRB and the
> companion PMU events has to be the same".
> 
> But they don't, right?
> 

Right


> What it should say is "we ignore the privilege bits in the branch sample
> type because they are handled by the underlying PMC configuration" - or
> something like that.

Here is the latest description for the code block

	/* BHRB and regular PMU events share the same privilege state
	 * filter configuration. BHRB is always recorded along with a
	 * regular PMU event. As the privilege state filter is handled
	 * in the basic PMC configuration of the accompanying regular
	 * PMU event, we ignore any separate BHRB specific request.
	 */

Does it sound better ?

> 
>> -	if ((br_privilege != 7) && (br_privilege != 0))
>> -		return -1;
>> +
>> +	if (br_privilege)
>> +		pr_info("BHRB privilege state filter request %llx ignored\n",
>> +								br_privilege);
> 
> Don't do that. Ignoring the br_privilege is either the right thing to do
> in which case we do it and print nothing,


I thought the informational print would at least make the user aware
of the fact that the separate filter request for BHRB went ignored.
Can we add this some where in the documentation ?

  
 or it doesn't make sense and
> we reject it.
>

 
> cheers
> 
