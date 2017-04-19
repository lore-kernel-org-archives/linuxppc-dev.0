Return-Path: <yao.jin@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w72yS4gLkzDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 10:32:32 +1000 (AEST)
Subject: Re: [PATCH v4 5/5] perf report: Show branch type in callchain entry
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
References: <1491949266-6835-1-git-send-email-yao.jin@linux.intel.com>
 <1491949266-6835-6-git-send-email-yao.jin@linux.intel.com>
 <20170418185323.GB15584@krava>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <79f0c49a-5f63-5ed7-bb37-fe5f0c0af1e1@linux.intel.com>
Date: Wed, 19 Apr 2017 08:32:27 +0800
MIME-Version: 1.0
In-Reply-To: <20170418185323.GB15584@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 4/19/2017 2:53 AM, Jiri Olsa wrote:
> On Wed, Apr 12, 2017 at 06:21:06AM +0800, Jin Yao wrote:
>
> SNIP
>
>>   static int counts_str_build(char *bf, int bfsize,
>>   			     u64 branch_count, u64 predicted_count,
>>   			     u64 abort_count, u64 cycles_count,
>> -			     u64 iter_count, u64 samples_count)
>> +			     u64 iter_count, u64 samples_count,
>> +			     struct branch_type_stat *brtype_stat)
>>   {
>> -	double predicted_percent = 0.0;
>> -	const char *null_str = "";
>> -	char iter_str[32];
>> -	char cycle_str[32];
>> -	char *istr, *cstr;
>>   	u64 cycles;
>> +	int printed, i = 0;
>>   
>>   	if (branch_count == 0)
>>   		return scnprintf(bf, bfsize, " (calltrace)");
>>   
>> +	printed = branch_type_str(brtype_stat, bf, bfsize);
>> +	if (printed)
>> +		i++;
>> +
>>   	cycles = cycles_count / branch_count;
>> +	if (cycles) {
>> +		if (i++)
>> +			printed += scnprintf(bf + printed, bfsize - printed,
>> +				" cycles:%" PRId64 "", cycles);
>> +		else
>> +			printed += scnprintf(bf + printed, bfsize - printed,
>> +				" (cycles:%" PRId64 "", cycles);
>> +	}
>>   
>>   	if (iter_count && samples_count) {
>> -		if (cycles > 0)
>> -			scnprintf(iter_str, sizeof(iter_str),
>> -				 " iterations:%" PRId64 "",
>> -				 iter_count / samples_count);
>> +		if (i++)
>> +			printed += scnprintf(bf + printed, bfsize - printed,
>> +				" iterations:%" PRId64 "",
>> +				iter_count / samples_count);
>>   		else
>> -			scnprintf(iter_str, sizeof(iter_str),
>> -				 "iterations:%" PRId64 "",
>> -				 iter_count / samples_count);
>> -		istr = iter_str;
> could you please put the change from using iter_str
> to bf into separate patch before the actual branch
> display change?
>
> it's hard to see if anything is broken ;-)
>
> thanks,
> jirka
Got it, I will separate the patches.

Thanks
Jin Yao
