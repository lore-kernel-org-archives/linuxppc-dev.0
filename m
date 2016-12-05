Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXbyC466CzDvwd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 07:31:31 +1100 (AEDT)
Date: Mon, 5 Dec 2016 17:31:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, chris.ryder@arm.com,
 mhiramat@kernel.org, kim.phillips@arm.com, treeze.taeung@gmail.com,
 markus@trippelsdorf.de, naveen.n.rao@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 1/3] perf annotate: Show raw form for jump instruction
 with indirect target
Message-ID: <20161205203124.GD28260@kernel.org>
References: <1480953407-7605-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20161205202142.GC28260@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161205202142.GC28260@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Dec 05, 2016 at 05:21:42PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Dec 05, 2016 at 09:26:45PM +0530, Ravi Bangoria escreveu:
> > For jump instructions that does not include target address as direct
> > operand, show the original disassembled line for them. This is needed
> > for certain powerpc jump instructions that use target address in a
> > register (such as bctr, btar, ...).
> 
> Found it, .__bpf_prog_run, that is present in that perf.data file you
> sent me, has it, will use it in my committer notes for this patch.

So, I've added these committer notes while testing it, will continue
processing your patches later/tomorrow, thanks!

    Committer notes:
    
    Testing it using a perf.data file and vmlinux for powerpc64,
    cross-annotating it on a x86_64 workstation:
    
    Before:
    
      .__bpf_prog_run  vmlinux.powerpc
             │        std    r10,512(r9)                      ▒
             │        lbz    r9,0(r31)                        ▒
             │        rldicr r9,r9,3,60                       ▒
             │        ldx    r9,r30,r9                        ▒
             │        mtctr  r9                               ▒
      100.00 │      ↓ bctr   3fffffffffe01510                 ▒
             │        lwa    r10,4(r31)                       ▒
             │        lwz    r9,0(r31)                        ▒
      <SNIP>
      Invalid jump offset: 3fffffffffe01510
    
    After:
    
      .__bpf_prog_run  vmlinux.powerpc
             │        std    r10,512(r9)                      ▒
             │        lbz    r9,0(r31)                        ▒
             │        rldicr r9,r9,3,60                       ▒
             │        ldx    r9,r30,r9                        ▒
             │        mtctr  r9                               ▒
      100.00 │      ↓ bctr                                    ▒
             │        lwa    r10,4(r31)                       ▒
             │        lwz    r9,0(r31)                        ▒
      <SNIP>
      Invalid jump offset: 3fffffffffe01510
    
    This, in turn, uncovers another problem with jumps without operands, the
    ENTER/-> operation, to jump to the target, still continues using the bogus
    target :-)
    
    BTW, this was the file used for the above tests:
    
      [acme@jouet ravi_bangoria]$ perf report --header-only -i perf.data.f22vm.powerdev
      # ========
      # captured on: Thu Nov 24 12:40:38 2016
      # hostname : pdev-f22-qemu
      # os release : 4.4.10-200.fc22.ppc64
      # perf version : 4.9.rc1.g6298ce
      # arch : ppc64
      # nrcpus online : 48
      # nrcpus avail : 48
      # cpudesc : POWER7 (architected), altivec supported
      # cpuid : 74,513
      # total memory : 4158976 kB
      # cmdline : /home/ravi/Workspace/linux/tools/perf/perf record -a
      # event : name = cycles:ppp, , size = 112, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|CPU|PERIOD, disabled = 1, inherit = 1, mmap = 1, c
      # HEADER_CPU_TOPOLOGY info available, use -I to display
      # HEADER_NUMA_TOPOLOGY info available, use -I to display
      # pmu mappings: cpu = 4, software = 1, tracepoint = 2, breakpoint = 5
      # missing features: HEADER_TRACING_DATA HEADER_BRANCH_STACK HEADER_GROUP_DESC HEADER_AUXTRACE HEADER_STAT HEADER_CACHE
      # ========
      #
      [acme@jouet ravi_bangoria]$
    
    Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
    Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> - Arnaldo
> 
> > 
> > Before:
> >      ld     r12,32088(r12)
> >      mtctr  r12
> >   v  bctr   ffffffffffffca2c
> >      std    r2,24(r1)
> >      addis  r12,r2,-1
> > 
> > After:
> >      ld     r12,32088(r12)
> >      mtctr  r12
> >   v  bctr
> >      std    r2,24(r1)
> >      addis  r12,r2,-1
> > 
> > Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> > ---
> > Changes in v8:
> >   - v7: https://lkml.org/lkml/2016/9/21/436
> >   - Rebase to acme/perf/core
> >   - No logical changes. (Cross arch annotate patches are in. This patch
> >     is for hardening annotate for powerpc.)
> > 
> >  tools/perf/util/annotate.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 4012b1d..ea7e0de 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -237,6 +237,9 @@ static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *op
> >  static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
> >  			   struct ins_operands *ops)
> >  {
> > +	if (!ops->target.addr)
> > +		return ins__raw_scnprintf(ins, bf, size, ops);
> > +
> >  	return scnprintf(bf, size, "%-6.6s %" PRIx64, ins->name, ops->target.offset);
> >  }
> >  
> > -- 
> > 2.4.11
