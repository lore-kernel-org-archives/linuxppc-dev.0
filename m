Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w78gY16Q9zDq9H
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 14:50:01 +1000 (AEST)
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
Date: Wed, 19 Apr 2017 14:50:00 +1000
Message-ID: <8760i16lxj.fsf@concordia.ellerman.id.au>
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

Actually that's only partly true. As I describe above the PERF_MEM_NA
value is currently exported on BE platforms when a user requests it.

So I added this text after the output from perf_mem__tlb_scnprintf():

  Because of the way the perf tool code is written this is still displayed to the
  user as "N/A", so there is no bug visible at the UI level.
  
  Currently there are no big endian architectures which export a meaningful
  value (ie. other than PERF_MEM_NA), so the extent of the bug on big endian
  platforms is that the PERF_MEM_NA value is exported incorrectly as described
  above. Subsequent patches will add support on big endian powerpc for populating
  the data source value.


Hope that is clear.

It also occurred to me that we don't actually have to redefine the whole
union, it's only the bitfields that matter, so we could reduce the diff
to:

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index c66a485a24ac..97152c79df6b 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -894,12 +894,23 @@ enum perf_callchain_context {
 union perf_mem_data_src {
 	__u64 val;
 	struct {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
 		__u64   mem_op:5,	/* type of opcode */
 			mem_lvl:14,	/* memory hierarchy level */
 			mem_snoop:5,	/* snoop mode */
 			mem_lock:2,	/* lock instr */
 			mem_dtlb:7,	/* tlb access */
 			mem_rsvd:31;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+		__u64	mem_rsvd:31,
+			mem_dtlb:7,	/* tlb access */
+			mem_lock:2,	/* lock instr */
+			mem_snoop:5,	/* snoop mode */
+			mem_lvl:14,	/* memory hierarchy level */
+			mem_op:5;	/* type of opcode */
+#else
+#error "Unknown endianness"
+#endif
 	};
 };
 

That looks better to me, thoughts?

cheers
