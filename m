Return-Path: <ak@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id E0BEE1A044C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 02:07:51 +1000 (AEST)
Date: Sun, 31 May 2015 09:07:49 -0700
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
Message-ID: <20150531160749.GF1187@tassilo.jf.intel.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150527135402.GA29557@danjae.kornet>
 <20150527144007.GL7484@tassilo.jf.intel.com>
 <CAM9d7cgSPbBgHL8qkmFEfbA3pNct4VPaxDwOcKZD3_5ZNL-oNQ@mail.gmail.com>
 <20150528115223.GD12392@krava.redhat.com>
 <20150528120954.GA8478@gmail.com> <20150528130724.GA8987@gmail.com>
 <20150528153911.GO7484@tassilo.jf.intel.com>
 <20150529072750.GA23124@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150529072750.GA23124@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Ok I did some scripting to add these topics you requested to the Intel JSON files,
and changed perf list to group events by them. 

I'll redirect any questions on their value to you.  
And I certainly hope this is the last of your "improvements" for now.

The updated event lists are available in

git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc perf/intel-json-files-3

The updated patches are available in 

git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc perf/builtin-json-6

Also posted separately.

The output looks like this

% perf list
...
Cache:
  l1d.replacement                                   
       [L1D data line replacements]
  l1d_pend_miss.pending                             
       [L1D miss oustandings duration in cycles]
  l1d_pend_miss.pending_cycles                      
       [Cycles with L1D load Misses outstanding]
...
Floating point:
  fp_assist.any                                     
       [Cycles with any input/output SSE or FP assist]
  fp_assist.simd_input                              
       [Number of SIMD FP assists due to input values]
  fp_assist.simd_output                             
       [Number of SIMD FP assists due to Output values]
...
Memory:
  machine_clears.memory_ordering                    
       [Counts the number of machine clears due to memory order conflicts]
  mem_trans_retired.load_latency_gt_128             
       [Loads with latency value being above 128 (Must be precise)]
  mem_trans_retired.load_latency_gt_16              
       [Loads with latency value being above 16 (Must be precise)]
...
Pipeline:
  arith.fpu_div                                     
       [Divide operations executed]
  arith.fpu_div_active                              
       [Cycles when divider is busy executing divide operations]
  baclears.any                                      
       [Counts the total number when the front end is resteered, mainly when the BPU cannot provide a correct
        prediction and this is corrected by other branch handling mechanisms at the front end]


-Andi

P.S.: You may want to look up the definition of logical fallacy in wikipedia.
