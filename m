Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w5vN24WS3zDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 13:47:14 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3H3illo145591
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Apr 2017 23:47:05 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29udntcjhh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Apr 2017 23:47:04 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 17 Apr 2017 09:17:01 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3H3kw3R4784154
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 09:16:58 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3H3ktB0023843
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 09:16:58 +0530
Subject: Re: [PATCH v3 1/6] powerpc/perf: Define big-endian version of
 perf_mem_data_src
To: Michael Ellerman <mpe@ellerman.id.au>,
 Peter Zijlstra <peterz@infradead.org>
References: <1491875470-17904-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491875470-17904-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20170413123849.556kqah6o6tzzs5d@hirez.programming.kicks-ass.net>
 <87a87k8mqt.fsf@concordia.ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, sukadev@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, mingo@redhat.com, acme@kernel.org,
 alexander.shishkin@linux.intel.com, wangnan0@huawei.com,
 ast@kernel.org, eranian@google.com
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 17 Apr 2017 09:16:54 +0530
MIME-Version: 1.0
In-Reply-To: <87a87k8mqt.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <db2f5eac-dead-bc6b-73c1-80ccbbf37278@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 13 April 2017 06:53 PM, Michael Ellerman wrote:
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
> Sure I'll fold in something along those lines.

Thanks mpe.

Maddy

>
>> Aside from that amendment,
>>
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Thanks.
>
> cheers
>
