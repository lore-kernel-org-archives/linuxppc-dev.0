Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x22a.google.com (mail-wi0-x22a.google.com
 [IPv6:2a00:1450:400c:c05::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 041251A0551
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 17:27:58 +1000 (AEST)
Received: by wicmc15 with SMTP id mc15so8321600wic.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 00:27:54 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 29 May 2015 09:27:50 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] perf: jevents: Program to convert JSON file to C
 style file
Message-ID: <20150529072750.GA23124@gmail.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150527135402.GA29557@danjae.kornet>
 <20150527144007.GL7484@tassilo.jf.intel.com>
 <CAM9d7cgSPbBgHL8qkmFEfbA3pNct4VPaxDwOcKZD3_5ZNL-oNQ@mail.gmail.com>
 <20150528115223.GD12392@krava.redhat.com>
 <20150528120954.GA8478@gmail.com> <20150528130724.GA8987@gmail.com>
 <20150528153911.GO7484@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150528153911.GO7484@tassilo.jf.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Andi Kleen <ak@linux.intel.com> wrote:

> > So instead of this flat structure, there should at minimum be broad categorization 
> > of the various parts of the hardware they relate to: whether they relate to the 
> > branch predictor, memory caches, TLB caches, memory ops, offcore, decoders, 
> > execution units, FPU ops, etc., etc. - so that they can be queried via 'perf 
> > list'.
> 
> The categorization is generally on the stem name, which already works fine with 
> the existing perf list wildcard support. So for example you only want branches.
>
> perf list br*
> ...
>   br_inst_exec.all_branches                         
>        [Speculative and retired branches]
>   br_inst_exec.all_conditional                      
>        [Speculative and retired macro-conditional branches]
>   br_inst_exec.all_direct_jmp                       
>        [Speculative and retired macro-unconditional branches excluding calls and indirects]
>   br_inst_exec.all_direct_near_call                 
>        [Speculative and retired direct near calls]
>   br_inst_exec.all_indirect_jump_non_call_ret       
>        [Speculative and retired indirect branches excluding calls and returns]
>   br_inst_exec.all_indirect_near_return             
>        [Speculative and retired indirect return branches]
> ...
> 
> Or mid level cache events:
> 
> perf list l2*
> ...
>   l2_l1d_wb_rqsts.all                               
>        [Not rejected writebacks from L1D to L2 cache lines in any state]
>   l2_l1d_wb_rqsts.hit_e                             
>        [Not rejected writebacks from L1D to L2 cache lines in E state]
>   l2_l1d_wb_rqsts.hit_m                             
>        [Not rejected writebacks from L1D to L2 cache lines in M state]
>   l2_l1d_wb_rqsts.miss                              
>        [Count the number of modified Lines evicted from L1 and missed L2. (Non-rejected WBs from the DCU.)]
>   l2_lines_in.all                                   
>        [L2 cache lines filling L2]
> ...
> 
> There are some exceptions, but generally it works this way.

You are missing my point in several ways:

1)

Firstly, there are _tons_ of 'exceptions' to the 'stem name' grouping, to the 
level that makes it unusable for high level grouping of events.

Here's the 'stem name' histogram on the SandyBridge event list:

  $ grep EventName pmu-events/arch/x86/SandyBridge_core.json  | cut -d\. -f1 | cut -d\" -f4 | cut -d\_ -f1 | sort | uniq -c | sort -n

      1 AGU
      1 BACLEARS
      1 EPT
      1 HW
      1 ICACHE
      1 INSTS
      1 PAGE
      1 ROB
      1 RS
      1 SQ
      2 ARITH
      2 DSB2MITE
      2 ILD
      2 LOAD
      2 LOCK
      2 LONGEST
      2 MISALIGN
      2 SIMD
      2 TLB
      3 CPL
      3 DSB
      3 INST
      3 INT
      3 LSD
      3 MACHINE
      4 CPU
      4 OTHER
      4 PARTIAL
      5 CYCLE
      5 ITLB
      6 LD
      7 L1D
      8 DTLB
     10 FP
     12 RESOURCE
     21 UOPS
     24 IDQ
     25 MEM
     37 BR
     37 L2
    131 OFFCORE

Out of 386 events. This grouping has the following severe problems:

  - that's 41 'stem name' groups, way too much as a first hop high level 
    structure. We want the kind of high level categorization I suggested:
    cache, decoding, branches, execution pipeline, memory events, vector unit 
    events - which broad categories exist in all CPUs and are microarchitecture 
    independent.

  - even these 'stem names' are mostly unstructured and unreadable. The two 
    examples you cited are the best case that are borderline readable, but they
    cover less than 20% of all events.

  - the 'stem name' concept is not even used consistently, the names are 
    essentially a random collection of Intel internal acronyms, which occasionally 
    match up with high level concepts. These vendor defined names have very poor 
    high level structure.

  - the 'stem names' are totally imbalanced: there's one 'super' category 'stem 
    name': OFFCORE_RESPONSE, with 131 events in it and then there are super small 
    groups in the list above. Not well suited to get a good overview about what 
    measurement capabilities the hardware has.

So forget about using 'stem names' as the high level structure. These events have 
no high level structure and we should provide that, instead of dumping 380+ events 
on the unsuspecting user.

2)

Secondly, categorization and higher level hieararchy should be used to keep the 
list manageable. The fact that if _you_ know what to search for you can list just 
a subset does not mean anything to the new user trying to discover events.

A simple 'perf list' should list the high level categories by default, with a 
count displayed that shows how many further events are within that category. 
(compacted tree output would be usable as well.)

> The stem could be put into a separate header, but it would seem redundant to me.

Higher level categories simply don't exist in these names in any usable form, so 
it has to be created. Just redundantly repeating the 'stem name' would be silly, 
as they are unusable for the purposes of high level categorization.

> > We don't just want the import the unstructured mess that these event files are 
> > - we want to turn them into real structure. We can still keep the messy vendor 
> > names as well, like IDQ.DSB_CYCLES, but we want to impose structure as well.
> 
> The vendor names directly map to the micro architecture, which is whole point of 
> the events. IDQ is a part of the CPU, and is described in the CPU manuals. One 
> of the main motivations for adding event lists is to make perf match to that 
> documentation.

Your argument is a logical fallacy: there is absolutely no conflict between also 
supporting quirky vendor names and also having good high level structure and 
naming, to make it all accessible to the first time user.

> > 3)
> > 
> > There should be good 'perf list' visualization for these events: grouping, 
> > individual names, with a good interface to query details if needed. I.e. it 
> > should be possible to browse and discover events relevant to the CPU the tool 
> > is executing on.
> 
> I suppose we could change perf list to give the stem names as section headers to 
> make the long list a bit more readable.

No, the 'stem names' are crap - instead we want to create sensible high level 
categories and want to categorize the events, I gave you a few ideas above and in 
the previous mail.

> Generally you need to have some knowledge of the micro architecture to use these 
> events. There is no way around that.

Here your argument again relies on a logical fallacy: there is absolutely no 
conflict between good high level structure, and the idea that you need to know 
about CPUs to make sense of hardware events that deal with fine internal details.

Also, you are denying the plain fact that the highest level categories _are_ 
largely microarchitecture independent: can you show me a single modern mainstream 
x86 CPU that doesn't have these broad high level categories:

  - CPU cache
  - memory accesses
  - decoding, branch execution
  - execution pipeline
  - FPU, vector units

?

There's none, and the reason is simple: the high level structure of CPUs is still 
dictated by basic physics, and physics is microarchitecture independent.

Lower level structure will inevitably be microarchitecture and sometimes even 
model specific - but that's absolutely no excuse to not have good high level 
structure.

So these are not difficult concepts at all, please make an honest effort at 
understanding then and responding to them, as properly addressing them is a 
must-have for this patch submission.

Thanks,

	Ingo
