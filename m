Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdL4N0ysszDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 17:22:43 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5R7JW7b022688
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 03:22:40 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23sp3ghb3j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 03:22:40 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Mon, 27 Jun 2016 17:22:36 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A855A3578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 17:22:35 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5R7MZRx1835474
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 17:22:35 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5R7MZKt008750
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 17:22:35 +1000
Subject: Re: [PATCH] cpufreq: powernv: Replacing pstate_id with frequency
 table index
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <1466776987-19031-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20160627063034.GA3341@vireshk-i7>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Date: Mon, 27 Jun 2016 12:52:31 +0530
MIME-Version: 1.0
In-Reply-To: <20160627063034.GA3341@vireshk-i7>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <5770D437.6000406@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi viresh,

My apologies. I realize that i have messed it up a quite a few places. Surely with the checkpatch as well. I will send a v2 with corrections.

On 06/27/2016 12:00 PM, Viresh Kumar wrote:

> Hi Akshay,
>
> Did you try running checkpatch for this?
>
> On 24-06-16, 19:33, Akshay Adiga wrote:
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>> index b29c5c2..f6ce6f0 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -43,6 +43,7 @@
>>   #define PMSR_SPR_EM_DISABLE	(1UL << 31)
>>   #define PMSR_MAX(x)		((x >> 32) & 0xFF)
>>   
>> +
> ?
>
>>   #define MAX_RAMP_DOWN_TIME				5120
>>   /*
>>    * On an idle system we want the global pstate to ramp-down from max value to
>> @@ -124,20 +125,29 @@ static int nr_chips;
>>   static DEFINE_PER_CPU(struct chip *, chip_info);
>>   
>>   /*
>> - * Note: The set of pstates consists of contiguous integers, the
>> - * smallest of which is indicated by powernv_pstate_info.min, the
>> - * largest of which is indicated by powernv_pstate_info.max.
>> + * Note: The set of pstates consists of contiguous integers,
>> + *
>> + * powernv_pstate_info stores the index of the frequency table
>> + *  instead of pstate itself for each of the pstates referred
>>    *
>>    * The nominal pstate is the highest non-turbo pstate in this
>>    * platform. This is indicated by powernv_pstate_info.nominal.
>>    */
>>   static struct powernv_pstate_info {
>> -	int min;
>> -	int max;
>> -	int nominal;
>> -	int nr_pstates;
>> +	unsigned int min;
>> +	unsigned int max;
>> +	unsigned int nominal;
>> +	unsigned int nr_pstates;
>>   } powernv_pstate_info;
>>   
>> +/* Use following macros for conversions between pstate_id and index */
>> +static inline int get_pstate(unsigned int i) {
> Read coding-styles please on how to write functions.
>
>> +	return powernv_freqs[i].driver_data;
>> +}
> Add a blank line here please.
>
>> +static inline unsigned int get_index(int pstate) {
>> +	return abs(pstate - get_pstate(powernv_pstate_info.max));
>> +}
>> +
>>   static inline void reset_gpstates(struct cpufreq_policy *policy)
>>   {
>>   	struct global_pstate_info *gpstates = policy->driver_data;
>> @@ -208,23 +218,28 @@ static int init_powernv_pstates(void)
>>   		return -ENODEV;
>>   	}
>>   
>> +	powernv_pstate_info.nr_pstates = nr_pstates;
>>   	pr_debug("NR PStates %d\n", nr_pstates);
>>   	for (i = 0; i < nr_pstates; i++) {
>>   		u32 id = be32_to_cpu(pstate_ids[i]);
>>   		u32 freq = be32_to_cpu(pstate_freqs[i]);
>>   
>> -		pr_debug("PState id %d freq %d MHz\n", id, freq);
> ?
>
>>   		powernv_freqs[i].frequency = freq * 1000; /* kHz */
>>   		powernv_freqs[i].driver_data = id;
> Will it be possible for Shilpa who was earlier on this to review this patch? As
> we don't really have great knowledge of the internals of this driver.
>
