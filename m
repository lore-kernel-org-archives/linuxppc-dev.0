Return-Path: <yao.jin@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wMdCL1mV4zDqJx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2017 21:57:17 +1000 (AEST)
Subject: Re: [PATCH v6 2/7] perf/x86/intel: Record branch type
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org
References: <1492690075-17243-1-git-send-email-yao.jin@linux.intel.com>
 <1492690075-17243-3-git-send-email-yao.jin@linux.intel.com>
 <20170423135559.GA23073@krava>
 <f6ede1eb-e015-5821-f00d-bbbc3ff3f317@linux.intel.com>
 <20170509082644.GB22125@krava>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <0e0b5c46-23ee-64dc-7ab3-2e8016d6a160@linux.intel.com>
Date: Tue, 9 May 2017 19:57:11 +0800
MIME-Version: 1.0
In-Reply-To: <20170509082644.GB22125@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 5/9/2017 4:26 PM, Jiri Olsa wrote:
> On Mon, Apr 24, 2017 at 08:47:14AM +0800, Jin, Yao wrote:
>>
>> On 4/23/2017 9:55 PM, Jiri Olsa wrote:
>>> On Thu, Apr 20, 2017 at 08:07:50PM +0800, Jin Yao wrote:
>>>
>>> SNIP
>>>
>>>> +#define X86_BR_TYPE_MAP_MAX	16
>>>> +
>>>> +static int
>>>> +common_branch_type(int type)
>>>> +{
>>>> +	int i, mask;
>>>> +	const int branch_map[X86_BR_TYPE_MAP_MAX] = {
>>>> +		PERF_BR_CALL,		/* X86_BR_CALL */
>>>> +		PERF_BR_RET,		/* X86_BR_RET */
>>>> +		PERF_BR_SYSCALL,	/* X86_BR_SYSCALL */
>>>> +		PERF_BR_SYSRET,		/* X86_BR_SYSRET */
>>>> +		PERF_BR_INT,		/* X86_BR_INT */
>>>> +		PERF_BR_IRET,		/* X86_BR_IRET */
>>>> +		PERF_BR_JCC,		/* X86_BR_JCC */
>>>> +		PERF_BR_JMP,		/* X86_BR_JMP */
>>>> +		PERF_BR_IRQ,		/* X86_BR_IRQ */
>>>> +		PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
>>>> +		PERF_BR_NONE,		/* X86_BR_ABORT */
>>>> +		PERF_BR_NONE,		/* X86_BR_IN_TX */
>>>> +		PERF_BR_NONE,		/* X86_BR_NO_TX */
>>>> +		PERF_BR_CALL,		/* X86_BR_ZERO_CALL */
>>>> +		PERF_BR_NONE,		/* X86_BR_CALL_STACK */
>>>> +		PERF_BR_IND_JMP,	/* X86_BR_IND_JMP */
>>>> +	};
>>>> +
>>>> +	type >>= 2; /* skip X86_BR_USER and X86_BR_KERNEL */
>>>> +	mask = ~(~0 << 1);
>>> is that a fancy way to get 1 into the mask? what do I miss?
> you did not comment on this one

Sorry, I misunderstood that this comment and the next comment had the 
same meaning.

In the previous version, I used the switch/case to convert from X86_BR 
to PERF_BR. I got a comment from community that it'd better use a lookup 
table for conversion.

Since each bit in type represents a X86_BR type so I use a mask (0x1) to 
filter the bit. Yes, it looks I can also directly set 0x1 to mask.

I write the code "mask = ~(~0 << 1)" according to my coding habits. If 
you think I should change the code to "mask = 0x1", that's OK  :)

>>>> +
>>>> +	for (i = 0; i < X86_BR_TYPE_MAP_MAX; i++) {
>>>> +		if (type & mask)
>>>> +			return branch_map[i];
>>> I wonder some bit search would be faster in here, but maybe not big deal
>>>
>>> jirka
>> I just think the branch_map[] doesn't contain many entries (16 entries
>> here), so maybe checking 1 bit one time should be acceptable. I just want to
>> keep the code simple.
>>
>> But if the number of entries is more (e.g. 64), maybe it'd better check 2 or
>> 4 bits one time.
> ook
>
> jirka
Sorry, what's the meaning of ook? Does it mean "OK"?

Thanks
Jin Yao
