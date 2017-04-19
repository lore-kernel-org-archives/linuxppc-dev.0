Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7bts00P3zDq8t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 08:16:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, sukadev@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, mingo@redhat.com, acme@kernel.org,
 alexander.shishkin@linux.intel.com, wangnan0@huawei.com, ast@kernel.org,
 eranian@google.com
Subject: Re: [PATCH v3 1/6] powerpc/perf: Define big-endian version of
 perf_mem_data_src
In-Reply-To: <bfcf37a8-c195-655e-2e54-95744800d968@linux.vnet.ibm.com>
References: <1491875470-17904-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491875470-17904-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20170413123849.556kqah6o6tzzs5d@hirez.programming.kicks-ass.net>
 <8760i16lxj.fsf@concordia.ellerman.id.au>
 <bfcf37a8-c195-655e-2e54-95744800d968@linux.vnet.ibm.com>
Date: Thu, 20 Apr 2017 08:16:17 +1000
Message-ID: <874lxk59hq.fsf@concordia.ellerman.id.au>
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

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
> On Wednesday 19 April 2017 10:20 AM, Michael Ellerman wrote:
>> It also occurred to me that we don't actually have to redefine the whole
>> union, it's only the bitfields that matter, so we could reduce the diff
>> to:
>>
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index c66a485a24ac..97152c79df6b 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -894,12 +894,23 @@ enum perf_callchain_context {
>>   union perf_mem_data_src {
>>   	__u64 val;
>>   	struct {
>> +#if defined(__LITTLE_ENDIAN_BITFIELD)
>>   		__u64   mem_op:5,	/* type of opcode */
>>   			mem_lvl:14,	/* memory hierarchy level */
>>   			mem_snoop:5,	/* snoop mode */
>>   			mem_lock:2,	/* lock instr */
>>   			mem_dtlb:7,	/* tlb access */
>>   			mem_rsvd:31;
>> +#elif defined(__BIG_ENDIAN_BITFIELD)
>> +		__u64	mem_rsvd:31,
>> +			mem_dtlb:7,	/* tlb access */
>> +			mem_lock:2,	/* lock instr */
>> +			mem_snoop:5,	/* snoop mode */
>> +			mem_lvl:14,	/* memory hierarchy level */
>> +			mem_op:5;	/* type of opcode */
>> +#else
>> +#error "Unknown endianness"
>> +#endif
>>   	};
>>   };
>>
>>
>> That looks better to me, thoughts?
>
> Yep.  Looks fine to me and also tested the same.

I merged the original version, as that's what Peterz acked and I didn't
want to block the series any longer.

I'll send an incremental patch to do the cleanup.

cheers
