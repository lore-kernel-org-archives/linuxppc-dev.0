Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkHbG2nNdzDqYt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 16:48:58 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2G5i0lH084700
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 01:48:52 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2978fhxcfx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 01:48:51 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 15:48:49 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2G5mdp835389550
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 16:48:47 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2G5mDuf029005
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 16:48:14 +1100
Subject: Re: [PATCH v2 1/6] powerpc/perf: Define big-endian version of
 perf_mem_data_src
To: Michael Ellerman <mpe@ellerman.id.au>,
 Peter Zijlstra <peterz@infradead.org>
References: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1488796993-25495-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20170306112228.GZ6515@twins.programming.kicks-ass.net>
 <2fc7e466-1675-ef27-b820-ef33ed0be7da@linux.vnet.ibm.com>
 <20170307102359.GE6515@twins.programming.kicks-ass.net>
 <78c1b95d-2e82-f998-74ba-ebb1fdf5bb45@linux.vnet.ibm.com>
 <20170313125041.GB3328@twins.programming.kicks-ass.net>
 <f73bc62f-d1cf-2599-95f9-69bd8e27da4e@linux.vnet.ibm.com>
 <20170314125626.GE3328@twins.programming.kicks-ass.net>
 <8737efukm8.fsf@concordia.ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Stephane Eranian <eranian@google.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Thu, 16 Mar 2017 11:17:48 +0530
MIME-Version: 1.0
In-Reply-To: <8737efukm8.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <b578ae21-0f41-65da-7ec8-05f77edb31be@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 15 March 2017 11:50 AM, Michael Ellerman wrote:
> Hi Peter,
>
> Peter Zijlstra <peterz@infradead.org> writes:
>> On Tue, Mar 14, 2017 at 02:31:51PM +0530, Madhavan Srinivasan wrote:
>>
>>>> Huh? PPC hasn't yet implemented this? Then why are you fixing it?
>>> yes, PPC hasn't implemented this (until now).
>> until now where?
> On powerpc there is currently no kernel support for filling the data_src
> value with anything meaningful.
>
> A user can still request PERF_SAMPLE_DATA_SRC (perf report -d), but they
> just get the default value from perf_sample_data_init(), which is
> PERF_MEM_NA.
>
> Though even that is currently broken with a big endian perf tool.
>
>>> And did not understand "Then why are you fixing it?"
>> I see no implementation; so why are you poking at it.
> Maddy has posted an implementation of the kernel part for powerpc in
> patch 2 of this series, but maybe you're not on Cc?

Sorry, was out yesterday.

Yes my bad. I CCed lkml and ppcdev and took the emails
from get_maintainer script and added to each file.

I will send out a v3 with peterz and others in all patch.

>
> Regardless of us wanting to do the kernel side on powerpc, the current
> API is broken on big endian.
>
> That's because in the kernel the PERF_MEM_NA value is constructed using
> shifts:
>
>    /* TLB access */
>    #define PERF_MEM_TLB_NA		0x01 /* not available */
>    ...
>    #define PERF_MEM_TLB_SHIFT	26
>    
>    #define PERF_MEM_S(a, s) \
>    	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
>    
>    #define PERF_MEM_NA (PERF_MEM_S(OP, NA)   |\
>    		    PERF_MEM_S(LVL, NA)   |\
>    		    PERF_MEM_S(SNOOP, NA) |\
>    		    PERF_MEM_S(LOCK, NA)  |\
>    		    PERF_MEM_S(TLB, NA))
>
> Which works out as:
>
>    ((0x01 << 0) | (0x01 << 5) | (0x01 << 19) | (0x01 << 24) | (0x01 << 26))
>
>
> Which means the PERF_MEM_NA value comes out of the kernel as 0x5080021
> in CPU endian.
>
> But then in the perf tool, the code uses the bitfields to inspect the
> value, and currently the bitfields are defined using little endian
> ordering.
>
> So eg. in perf_mem__tlb_scnprintf() we see:
>    data_src->val = 0x5080021
>               op = 0x0
>              lvl = 0x0
>            snoop = 0x0
>             lock = 0x0
>             dtlb = 0x0
>             rsvd = 0x5080021
>
>
> So this patch does what I think is the minimal fix, of changing the
> definition of the bitfields to match the values that are already
> exported by the kernel on big endian. And it makes no change on little
> endian.

Thanks for the detailed explanation. I will add this to the patch
commit message in the v3.

Maddy

>
> cheers
>
