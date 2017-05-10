Return-Path: <yao.jin@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wMxfq5ZfZzDqKk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 May 2017 10:18:43 +1000 (AEST)
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
 <0e0b5c46-23ee-64dc-7ab3-2e8016d6a160@linux.intel.com>
 <20170509123913.GC9983@krava>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <29d920f3-3491-2be2-f9f7-795e23217621@linux.intel.com>
Date: Wed, 10 May 2017 08:18:37 +0800
MIME-Version: 1.0
In-Reply-To: <20170509123913.GC9983@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 5/9/2017 8:39 PM, Jiri Olsa wrote:
> On Tue, May 09, 2017 at 07:57:11PM +0800, Jin, Yao wrote:
>
> SNIP
>
>>>>>> +
>>>>>> +	type >>= 2; /* skip X86_BR_USER and X86_BR_KERNEL */
>>>>>> +	mask = ~(~0 << 1);
>>>>> is that a fancy way to get 1 into the mask? what do I miss?
>>> you did not comment on this one
>> Sorry, I misunderstood that this comment and the next comment had the same
>> meaning.
>>
>> In the previous version, I used the switch/case to convert from X86_BR to
>> PERF_BR. I got a comment from community that it'd better use a lookup table
>> for conversion.
>>
>> Since each bit in type represents a X86_BR type so I use a mask (0x1) to
>> filter the bit. Yes, it looks I can also directly set 0x1 to mask.
>>
>> I write the code "mask = ~(~0 << 1)" according to my coding habits. If you
>> think I should change the code to "mask = 0x1", that's OK  :)
> im ok with that.. was just wondering for the reason
> I guess compiler will make it single constant assignment anyway

I think so.  The compiler should be clever enough for this optimization.
>>>>>> +
>>>>>> +	for (i = 0; i < X86_BR_TYPE_MAP_MAX; i++) {
>>>>>> +		if (type & mask)
>>>>>> +			return branch_map[i];
>>>>> I wonder some bit search would be faster in here, but maybe not big deal
>>>>>
>>>>> jirka
>>>> I just think the branch_map[] doesn't contain many entries (16 entries
>>>> here), so maybe checking 1 bit one time should be acceptable. I just want to
>>>> keep the code simple.
>>>>
>>>> But if the number of entries is more (e.g. 64), maybe it'd better check 2 or
>>>> 4 bits one time.
>>> ook
>>>
>>> jirka
>> Sorry, what's the meaning of ook? Does it mean "OK"?
> just means ok ;-)
>
> thanks,
> jirka

Thanks so much!

Jin Yao
