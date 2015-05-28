Return-Path: <ak@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id D784B1A127C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 01:39:15 +1000 (AEST)
Date: Thu, 28 May 2015 08:39:11 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] perf: jevents: Program to convert JSON file to C
 style file
Message-ID: <20150528153911.GO7484@tassilo.jf.intel.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150527135402.GA29557@danjae.kornet>
 <20150527144007.GL7484@tassilo.jf.intel.com>
 <CAM9d7cgSPbBgHL8qkmFEfbA3pNct4VPaxDwOcKZD3_5ZNL-oNQ@mail.gmail.com>
 <20150528115223.GD12392@krava.redhat.com>
 <20150528120954.GA8478@gmail.com> <20150528130724.GA8987@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150528130724.GA8987@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> So instead of this flat structure, there should at minimum be broad categorization 
> of the various parts of the hardware they relate to: whether they relate to the 
> branch predictor, memory caches, TLB caches, memory ops, offcore, decoders, 
> execution units, FPU ops, etc., etc. - so that they can be queried via 'perf 
> list'.

The categorization is generally on the stem name, which already works fine with
the existing perf list wildcard support. So for example you only want 
branches. 

perf list br*
...
  br_inst_exec.all_branches                         
       [Speculative and retired branches]
  br_inst_exec.all_conditional                      
       [Speculative and retired macro-conditional branches]
  br_inst_exec.all_direct_jmp                       
       [Speculative and retired macro-unconditional branches excluding calls and indirects]
  br_inst_exec.all_direct_near_call                 
       [Speculative and retired direct near calls]
  br_inst_exec.all_indirect_jump_non_call_ret       
       [Speculative and retired indirect branches excluding calls and returns]
  br_inst_exec.all_indirect_near_return             
       [Speculative and retired indirect return branches]
...

Or mid level cache events:

perf list l2*
...
  l2_l1d_wb_rqsts.all                               
       [Not rejected writebacks from L1D to L2 cache lines in any state]
  l2_l1d_wb_rqsts.hit_e                             
       [Not rejected writebacks from L1D to L2 cache lines in E state]
  l2_l1d_wb_rqsts.hit_m                             
       [Not rejected writebacks from L1D to L2 cache lines in M state]
  l2_l1d_wb_rqsts.miss                              
       [Count the number of modified Lines evicted from L1 and missed L2. (Non-rejected WBs from the DCU.)]
  l2_lines_in.all                                   
       [L2 cache lines filling L2]
...

There are some exceptions, but generally it works this way.

The stem could be put into a separate header, but it would seem redundant to me. 

> We don't just want the import the unstructured mess that these event files are - 
> we want to turn them into real structure. We can still keep the messy vendor names 
> as well, like IDQ.DSB_CYCLES, but we want to impose structure as well.

The vendor names directly map to the micro architecture, which is whole
point of the events. IDQ is a part of the CPU, and is described in the 
CPU manuals. One of the main motivations for adding event lists is to make
perf match to that documentation.

> 
> 3)
> 
> There should be good 'perf list' visualization for these events: grouping, 
> individual names, with a good interface to query details if needed. I.e. it should 
> be possible to browse and discover events relevant to the CPU the tool is 
> executing on.

I suppose we could change perf list to give the stem names as section headers
to make the long list a bit more readable.

Generally you need to have some knowledge of the micro architecture to use
these events. There is no way around that.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only
