Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjhKr1v5XzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 17:20:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Zijlstra <peterz@infradead.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 1/6] powerpc/perf: Define big-endian version of
 perf_mem_data_src
In-Reply-To: <20170314125626.GE3328@twins.programming.kicks-ass.net>
References: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1488796993-25495-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20170306112228.GZ6515@twins.programming.kicks-ass.net>
 <2fc7e466-1675-ef27-b820-ef33ed0be7da@linux.vnet.ibm.com>
 <20170307102359.GE6515@twins.programming.kicks-ass.net>
 <78c1b95d-2e82-f998-74ba-ebb1fdf5bb45@linux.vnet.ibm.com>
 <20170313125041.GB3328@twins.programming.kicks-ass.net>
 <f73bc62f-d1cf-2599-95f9-69bd8e27da4e@linux.vnet.ibm.com>
 <20170314125626.GE3328@twins.programming.kicks-ass.net>
Date: Wed, 15 Mar 2017 17:20:15 +1100
Message-ID: <8737efukm8.fsf@concordia.ellerman.id.au>
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

Hi Peter,

Peter Zijlstra <peterz@infradead.org> writes:
> On Tue, Mar 14, 2017 at 02:31:51PM +0530, Madhavan Srinivasan wrote:
>
>> >Huh? PPC hasn't yet implemented this? Then why are you fixing it?
>> 
>> yes, PPC hasn't implemented this (until now).
>
> until now where?

On powerpc there is currently no kernel support for filling the data_src
value with anything meaningful.

A user can still request PERF_SAMPLE_DATA_SRC (perf report -d), but they
just get the default value from perf_sample_data_init(), which is
PERF_MEM_NA.

Though even that is currently broken with a big endian perf tool.

>> And did not understand "Then why are you fixing it?"
>
> I see no implementation; so why are you poking at it.

Maddy has posted an implementation of the kernel part for powerpc in
patch 2 of this series, but maybe you're not on Cc?


Regardless of us wanting to do the kernel side on powerpc, the current
API is broken on big endian.

That's because in the kernel the PERF_MEM_NA value is constructed using
shifts:

  /* TLB access */
  #define PERF_MEM_TLB_NA		0x01 /* not available */
  ...
  #define PERF_MEM_TLB_SHIFT	26
  
  #define PERF_MEM_S(a, s) \
  	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
  
  #define PERF_MEM_NA (PERF_MEM_S(OP, NA)   |\
  		    PERF_MEM_S(LVL, NA)   |\
  		    PERF_MEM_S(SNOOP, NA) |\
  		    PERF_MEM_S(LOCK, NA)  |\
  		    PERF_MEM_S(TLB, NA))

Which works out as:

  ((0x01 << 0) | (0x01 << 5) | (0x01 << 19) | (0x01 << 24) | (0x01 << 26))


Which means the PERF_MEM_NA value comes out of the kernel as 0x5080021
in CPU endian.

But then in the perf tool, the code uses the bitfields to inspect the
value, and currently the bitfields are defined using little endian
ordering.

So eg. in perf_mem__tlb_scnprintf() we see:
  data_src->val = 0x5080021
             op = 0x0
            lvl = 0x0
          snoop = 0x0
           lock = 0x0
           dtlb = 0x0
           rsvd = 0x5080021


So this patch does what I think is the minimal fix, of changing the
definition of the bitfields to match the values that are already
exported by the kernel on big endian. And it makes no change on little
endian.

cheers
