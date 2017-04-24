Return-Path: <yao.jin@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wB73D1jzYzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 10:47:19 +1000 (AEST)
Subject: Re: [PATCH v6 2/7] perf/x86/intel: Record branch type
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
References: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
 <1492690075-17243-3-git-send-email-yao.jin@linux.intel.com>
 <20170423135559.GA23073@krava>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <f6ede1eb-e015-5821-f00d-bbbc3ff3f317@linux.intel.com>
Date: Mon, 24 Apr 2017 08:47:14 +0800
MIME-Version: 1.0
In-Reply-To: <20170423135559.GA23073@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 4/23/2017 9:55 PM, Jiri Olsa wrote:
> On Thu, Apr 20, 2017 at 08:07:50PM +0800, Jin Yao wrote:
>
> SNIP
>
>>   
>> +#define X86_BR_TYPE_MAP_MAX	16
>> +
>> +static int
>> +common_branch_type(int type)
>> +{
>> +	int i, mask;
>> +	const int branch_map[X86_BR_TYPE_MAP_MAX] = {
>> +		PERF_BR_CALL,		/* X86_BR_CALL */
>> +		PERF_BR_RET,		/* X86_BR_RET */
>> +		PERF_BR_SYSCALL,	/* X86_BR_SYSCALL */
>> +		PERF_BR_SYSRET,		/* X86_BR_SYSRET */
>> +		PERF_BR_INT,		/* X86_BR_INT */
>> +		PERF_BR_IRET,		/* X86_BR_IRET */
>> +		PERF_BR_JCC,		/* X86_BR_JCC */
>> +		PERF_BR_JMP,		/* X86_BR_JMP */
>> +		PERF_BR_IRQ,		/* X86_BR_IRQ */
>> +		PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
>> +		PERF_BR_NONE,		/* X86_BR_ABORT */
>> +		PERF_BR_NONE,		/* X86_BR_IN_TX */
>> +		PERF_BR_NONE,		/* X86_BR_NO_TX */
>> +		PERF_BR_CALL,		/* X86_BR_ZERO_CALL */
>> +		PERF_BR_NONE,		/* X86_BR_CALL_STACK */
>> +		PERF_BR_IND_JMP,	/* X86_BR_IND_JMP */
>> +	};
>> +
>> +	type >>= 2; /* skip X86_BR_USER and X86_BR_KERNEL */
>> +	mask = ~(~0 << 1);
> is that a fancy way to get 1 into the mask? what do I miss?
>
>> +
>> +	for (i = 0; i < X86_BR_TYPE_MAP_MAX; i++) {
>> +		if (type & mask)
>> +			return branch_map[i];
> I wonder some bit search would be faster in here, but maybe not big deal
>
> jirka

I just think the branch_map[] doesn't contain many entries (16 entries 
here), so maybe checking 1 bit one time should be acceptable. I just 
want to keep the code simple.

But if the number of entries is more (e.g. 64), maybe it'd better check 
2 or 4 bits one time.

Thanks
Jin Yao

>
>> +
>> +		type >>= 1;
>> +	}
>> +
>> +	return PERF_BR_NONE;
>> +}
>> +
>>   /*
