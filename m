Return-Path: <BATV+4c94f64e688bd1b3d3b9+4852+infradead.org+acme@merlin.srs.infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXdRP4cpczDvx5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 08:38:25 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Chris Riyder <chris.ryder@arm.com>, Kim Phillips <kim.phillips@arm.com>,
 Markus Trippelsdorf <markus@trippelsdorf.de>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Taeung Song <treeze.taeung@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/20] perf annotate: Show raw form for jump instruction with
 indirect target
Date: Mon,  5 Dec 2016 18:38:08 -0300
Message-Id: <20161205213808.6231-21-acme@kernel.org>
In-Reply-To: <20161205213808.6231-1-acme@kernel.org>
References: <20161205213808.6231-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

For jump instructions that does not include target address as direct operand,
show the original disassembled line for them. This is needed for certain
powerpc jump instructions that use target address in a register (such as bctr,
btar, ...).

Before:
     ld     r12,32088(r12)
     mtctr  r12
  v  bctr   ffffffffffffca2c
     std    r2,24(r1)
     addis  r12,r2,-1

After:
     ld     r12,32088(r12)
     mtctr  r12
  v  bctr
     std    r2,24(r1)
     addis  r12,r2,-1

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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Chris Riyder <chris.ryder@arm.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1480953407-7605-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4012b1de2813..ea7e0de4b9c1 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -237,6 +237,9 @@ static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *op
 static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
 			   struct ins_operands *ops)
 {
+	if (!ops->target.addr)
+		return ins__raw_scnprintf(ins, bf, size, ops);
+
 	return scnprintf(bf, size, "%-6.6s %" PRIx64, ins->name, ops->target.offset);
 }
 
-- 
2.9.3
