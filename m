Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com",
	Issuer "GeoTrust SSL CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1C412B6FA0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Sep 2011 16:19:08 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id p896CO96022707
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Sep 2011 16:12:24 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p896IxY51875968
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Sep 2011 16:18:59 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p896IxaD003788
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Sep 2011 16:18:59 +1000
Message-ID: <4E69AFCF.3040404@linux.vnet.ibm.com>
Date: Fri, 09 Sep 2011 11:48:55 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <michael.neuling@au1.ibm.com>
Subject: Re: [PATCH] perf events,
	powerpc: Add POWER7 stalled-cycles-frontend/backend events
References: <4E5C6A7D.2010909@linux.vnet.ibm.com>
	<25545.1315532289@neuling.org>
In-Reply-To: <25545.1315532289@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 09 September 2011 07:08 AM, Michael Neuling wrote:
>> perf events, powerpc: Add POWER7 stalled-cycles-frontend/backend events
>>
>> 	Extent the POWER7 PMU driver with definitions
>> 	for generic front-end and back-end stall events.
> 
> Anshuman,
> 
> Can you explain what these P7 events actually are and how they relate to
> Ingo's original comment on this in
> 8f62242246351b5a4bc0c1f00c0c7003edea128a
> 
>     Both events limit performance: most front end stalls tend to be
>     caused by branch misprediction or instruction fetch cachemisses,
>     backend stalls can be caused by various resource shortages or
>     inefficient instruction scheduling.
> 
As explained in Ingo's original comment, the exact definitions of the stall 
events are very much processor specific as different things mean different in
their respective instruction pipeline. These two Power7 raw events are the closest 
approximation to the concept detailed in Ingo's comment.    
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>
>> diff --git a/arch/powerpc/kernel/power7-pmu.c b/arch/powerpc/kernel/power7-pmu.c
>> index 593740f..e5d2844 100644
>> --- a/arch/powerpc/kernel/power7-pmu.c
>> +++ b/arch/powerpc/kernel/power7-pmu.c
>> @@ -297,6 +297,8 @@ static void power7_disable_pmc(unsigned int pmc, unsigned long mmcr[])
>>  
>>  static int power7_generic_events[] = {
>>  	[PERF_COUNT_HW_CPU_CYCLES] = 0x1e,
>> +	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = 0x100f8, /* GCT_NOSLOT_CYC */
> 
> eg. Is this Global Completion Table (GCT) empty?
Yes, it means cycles when the Global Completion Table has no slots from this thread
> 
>> +	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = 0x4000a,  /* CMPLU_STALL */
> 
> eg. Is this instruction completion stall?
Yes, it means no groups completed and GCT not empty
> 
> Mikey
> 
>>  	[PERF_COUNT_HW_INSTRUCTIONS] = 2,
>>  	[PERF_COUNT_HW_CACHE_REFERENCES] = 0xc880,	/* LD_REF_L1_LSU*/
>>  	[PERF_COUNT_HW_CACHE_MISSES] = 0x400f0,		/* LD_MISS_L1	*/
>>
>> -- 
>> Anshuman Khandual 
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Anshuman Khandual 
LTC India 
