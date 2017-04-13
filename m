Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3hLz2pvZzDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 23:23:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Zijlstra <peterz@infradead.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, sukadev@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, mingo@redhat.com, acme@kernel.org,
 alexander.shishkin@linux.intel.com, wangnan0@huawei.com, ast@kernel.org,
 eranian@google.com
Subject: Re: [PATCH v3 1/6] powerpc/perf: Define big-endian version of
 perf_mem_data_src
In-Reply-To: <20170413123849.556kqah6o6tzzs5d@hirez.programming.kicks-ass.net>
References: <1491875470-17904-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491875470-17904-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20170413123849.556kqah6o6tzzs5d@hirez.programming.kicks-ass.net>
Date: Thu, 13 Apr 2017 23:23:38 +1000
Message-ID: <87a87k8mqt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Apr 11, 2017 at 07:21:05AM +0530, Madhavan Srinivasan wrote:
>> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>> 
>> perf_mem_data_src is an union that is initialized via the ->val field
>> and accessed via the bitmap fields. For this to work on big endian
>> platforms (Which is broken now), we also need a big-endian represenation
>> of perf_mem_data_src. i.e, in a big endian system, if user request
>> PERF_SAMPLE_DATA_SRC (perf report -d), will get the default value from
>> perf_sample_data_init(), which is PERF_MEM_NA. Value for PERF_MEM_NA
>> is constructed using shifts:
>> 
>>   /* TLB access */
>>   #define PERF_MEM_TLB_NA		0x01 /* not available */
>>   ...
>>   #define PERF_MEM_TLB_SHIFT	26
>> 
>>   #define PERF_MEM_S(a, s) \
>> 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
>> 
>>   #define PERF_MEM_NA (PERF_MEM_S(OP, NA)   |\
>> 		    PERF_MEM_S(LVL, NA)   |\
>> 		    PERF_MEM_S(SNOOP, NA) |\
>> 		    PERF_MEM_S(LOCK, NA)  |\
>> 		    PERF_MEM_S(TLB, NA))
>> 
>> Which works out as:
>> 
>>   ((0x01 << 0) | (0x01 << 5) | (0x01 << 19) | (0x01 << 24) | (0x01 << 26))
>> 
>> Which means the PERF_MEM_NA value comes out of the kernel as 0x5080021
>> in CPU endian.
>> 
>> But then in the perf tool, the code uses the bitfields to inspect the
>> value, and currently the bitfields are defined using little endian
>> ordering.
>> 
>> So eg. in perf_mem__tlb_scnprintf() we see:
>>   data_src->val = 0x5080021
>>              op = 0x0
>>             lvl = 0x0
>>           snoop = 0x0
>>            lock = 0x0
>>            dtlb = 0x0
>>            rsvd = 0x5080021
>> 
>> Patch does a minimal fix of adding big endian definition of the bitfields
>> to match the values that are already exported by the kernel on big endian.
>> And it makes no change on little endian.
>
> I think it is important to note that there are no current big-endian
> users. So 'fixing' this will not break anybody and will ensure future
> users (next patch) will work correctly.

Sure I'll fold in something along those lines.

> Aside from that amendment,
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks.

cheers
