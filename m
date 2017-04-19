Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7PcL6gLKzDq9L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 00:33:06 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JEGVpw077902
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 10:32:52 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x74mrh57-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 10:32:52 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 20:02:48 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JEWjOQ14024950
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 20:02:45 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JEWgud006729
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 20:02:45 +0530
Subject: Re: [PATCH v3 1/6] powerpc/perf: Define big-endian version of
 perf_mem_data_src
To: Michael Ellerman <mpe@ellerman.id.au>,
 Peter Zijlstra <peterz@infradead.org>
References: <1491875470-17904-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491875470-17904-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20170413123849.556kqah6o6tzzs5d@hirez.programming.kicks-ass.net>
 <8760i16lxj.fsf@concordia.ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, sukadev@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, mingo@redhat.com, acme@kernel.org,
 alexander.shishkin@linux.intel.com, wangnan0@huawei.com,
 ast@kernel.org, eranian@google.com
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 19 Apr 2017 20:02:41 +0530
MIME-Version: 1.0
In-Reply-To: <8760i16lxj.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <bfcf37a8-c195-655e-2e54-95744800d968@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 19 April 2017 10:20 AM, Michael Ellerman wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
>
>> On Tue, Apr 11, 2017 at 07:21:05AM +0530, Madhavan Srinivasan wrote:
>>> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>>>
>>> perf_mem_data_src is an union that is initialized via the ->val field
>>> and accessed via the bitmap fields. For this to work on big endian
>>> platforms (Which is broken now), we also need a big-endian represenation
>>> of perf_mem_data_src. i.e, in a big endian system, if user request
>>> PERF_SAMPLE_DATA_SRC (perf report -d), will get the default value from
>>> perf_sample_data_init(), which is PERF_MEM_NA. Value for PERF_MEM_NA
>>> is constructed using shifts:
>>>
>>>    /* TLB access */
>>>    #define PERF_MEM_TLB_NA		0x01 /* not available */
>>>    ...
>>>    #define PERF_MEM_TLB_SHIFT	26
>>>
>>>    #define PERF_MEM_S(a, s) \
>>> 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
>>>
>>>    #define PERF_MEM_NA (PERF_MEM_S(OP, NA)   |\
>>> 		    PERF_MEM_S(LVL, NA)   |\
>>> 		    PERF_MEM_S(SNOOP, NA) |\
>>> 		    PERF_MEM_S(LOCK, NA)  |\
>>> 		    PERF_MEM_S(TLB, NA))
>>>
>>> Which works out as:
>>>
>>>    ((0x01 << 0) | (0x01 << 5) | (0x01 << 19) | (0x01 << 24) | (0x01 << 26))
>>>
>>> Which means the PERF_MEM_NA value comes out of the kernel as 0x5080021
>>> in CPU endian.
>>>
>>> But then in the perf tool, the code uses the bitfields to inspect the
>>> value, and currently the bitfields are defined using little endian
>>> ordering.
>>>
>>> So eg. in perf_mem__tlb_scnprintf() we see:
>>>    data_src->val = 0x5080021
>>>               op = 0x0
>>>              lvl = 0x0
>>>            snoop = 0x0
>>>             lock = 0x0
>>>             dtlb = 0x0
>>>             rsvd = 0x5080021
>>>
>>> Patch does a minimal fix of adding big endian definition of the bitfields
>>> to match the values that are already exported by the kernel on big endian.
>>> And it makes no change on little endian.
>> I think it is important to note that there are no current big-endian
>> users. So 'fixing' this will not break anybody and will ensure future
>> users (next patch) will work correctly.
> Actually that's only partly true. As I describe above the PERF_MEM_NA
> value is currently exported on BE platforms when a user requests it.
>
> So I added this text after the output from perf_mem__tlb_scnprintf():
>
>    Because of the way the perf tool code is written this is still displayed to the
>    user as "N/A", so there is no bug visible at the UI level.
>    
>    Currently there are no big endian architectures which export a meaningful
>    value (ie. other than PERF_MEM_NA), so the extent of the bug on big endian
>    platforms is that the PERF_MEM_NA value is exported incorrectly as described
>    above. Subsequent patches will add support on big endian powerpc for populating
>    the data source value.
>
>
> Hope that is clear.
>
> It also occurred to me that we don't actually have to redefine the whole
> union, it's only the bitfields that matter, so we could reduce the diff
> to:
>
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index c66a485a24ac..97152c79df6b 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -894,12 +894,23 @@ enum perf_callchain_context {
>   union perf_mem_data_src {
>   	__u64 val;
>   	struct {
> +#if defined(__LITTLE_ENDIAN_BITFIELD)
>   		__u64   mem_op:5,	/* type of opcode */
>   			mem_lvl:14,	/* memory hierarchy level */
>   			mem_snoop:5,	/* snoop mode */
>   			mem_lock:2,	/* lock instr */
>   			mem_dtlb:7,	/* tlb access */
>   			mem_rsvd:31;
> +#elif defined(__BIG_ENDIAN_BITFIELD)
> +		__u64	mem_rsvd:31,
> +			mem_dtlb:7,	/* tlb access */
> +			mem_lock:2,	/* lock instr */
> +			mem_snoop:5,	/* snoop mode */
> +			mem_lvl:14,	/* memory hierarchy level */
> +			mem_op:5;	/* type of opcode */
> +#else
> +#error "Unknown endianness"
> +#endif
>   	};
>   };
>
>
> That looks better to me, thoughts?

Yep.  Looks fine to me and also tested the same.

Maddy

>
> cheers
>
