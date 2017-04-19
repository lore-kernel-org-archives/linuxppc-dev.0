Return-Path: <yao.jin@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w73083lHqzDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 10:34:00 +1000 (AEST)
Subject: Re: [PATCH v4 5/5] perf report: Show branch type in callchain entry
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
References: <1491949266-6835-1-git-send-email-yao.jin@linux.intel.com>
 <1491949266-6835-6-git-send-email-yao.jin@linux.intel.com>
 <20170418185314.GA15584@krava>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <c26d35d6-cfa9-3735-363c-05e5be981082@linux.intel.com>
Date: Wed, 19 Apr 2017 08:33:56 +0800
MIME-Version: 1.0
In-Reply-To: <20170418185314.GA15584@krava>
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
>> +static int branch_type_str(struct branch_type_stat *stat,
>> +			   char *bf, int bfsize)
>> +{
>> +	int i, j = 0, printed = 0;
>> +	u64 total = 0;
>> +
>> +	for (i = 0; i < PERF_BR_MAX; i++)
>> +		total += stat->counts[i];
>> +
>> +	if (total == 0)
>> +		return 0;
>> +
>> +	printed += scnprintf(bf + printed, bfsize - printed, " (");
>> +
>> +	if (stat->jcc_fwd > 0) {
>> +		j++;
>> +		printed += scnprintf(bf + printed, bfsize - printed,
>> +				     "JCC forward");
>> +	}
>> +
>> +	if (stat->jcc_bwd > 0) {
>> +		if (j++)
>> +			printed += scnprintf(bf + printed, bfsize - printed,
>> +					     " JCC backward");
>> +		else
>> +			printed += scnprintf(bf + printed, bfsize - printed,
>> +					     "JCC backward");
>> +	}
>> +
>> +	if (stat->cross_4k > 0) {
>> +		if (j++)
>> +			printed += scnprintf(bf + printed, bfsize - printed,
>> +					     " CROSS_4K");
>> +		else
>> +			printed += scnprintf(bf + printed, bfsize - printed,
>> +					     "CROSS_4K");
>> +	}
> could that 2 legs if be shortened to just one scnprintf like (untested):
>
>     printed += scnprintf(bf + printed, bfsize - printed, "%s%s", j++ ? " " : "", "CROSS_4K");
>
> I'd also probably use some kind of macro or function
> with all that similar code, but I dont insist ;-)
>
> thanks,
> jirka

Thanks for this suggestion. I will use this kind of code. Of course, I 
will test. :)

Thanks
Jin Yao
