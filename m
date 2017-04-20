Return-Path: <yao.jin@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7g1B4xMXzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 10:37:02 +1000 (AEST)
Subject: Re: [PATCH v5 7/7] perf report: Show branch type in callchain entry
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
References: <1492616894-3635-1-git-send-email-yao.jin@linux.intel.com>
 <1492616894-3635-8-git-send-email-yao.jin@linux.intel.com>
 <20170419141510.GA19643@krava>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <1757edc6-4737-e30f-bd5d-3d1334c5b9b7@linux.intel.com>
Date: Thu, 20 Apr 2017 08:36:57 +0800
MIME-Version: 1.0
In-Reply-To: <20170419141510.GA19643@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 4/19/2017 10:15 PM, Jiri Olsa wrote:
> On Wed, Apr 19, 2017 at 11:48:14PM +0800, Jin Yao wrote:
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
>> +	if (stat->jcc_fwd > 0)
>> +		printed += count_str_printf(j++, "JCC forward",
>> +				bf + printed, bfsize - printed);
>> +
>> +	if (stat->jcc_bwd > 0)
>> +		printed += count_str_printf(j++, "JCC backward",
>> +				bf + printed, bfsize - printed);
> please move that multiline conditional code inside {} brackets
>
> thanks,
> jirka

Thanks so much for all of your review comments. I will add the fix to v6.

Thanks
Jin Yao
