Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vk0WF2pDrzDqYG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 05:29:29 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id n11so6069692wma.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 11:29:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 15 Mar 2017 19:29:21 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alexei Starovoitov <ast@fb.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Andi Kleen <ak@linux.intel.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 Brendan Gregg <bgregg@netflix.com>, Changbin Du <changbin.du@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Eric Biederman <ebiederm@xmission.com>, Feng Tang <feng.tang@intel.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Jiri Olsa <jolsa@redhat.com>, kernel-team@lge.com,
 linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Sargun Dhillon <sargun@sargun.me>,
 Steven Rostedt <rostedt@goodmis.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/19] perf/core improvements and fixes
Message-ID: <20170315182921.GA29612@gmail.com>
References: <20170314185023.31303-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170314185023.31303-1-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 84e5b549214f2160c12318aac549de85f600c79a:
> 
>   Merge tag 'perf-core-for-mingo-4.11-20170306' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-03-07 08:14:14 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.12-20170314
> 
> for you to fetch changes up to 5f6bee34707973ea7879a7857fd63ddccc92fff3:
> 
>   kprobes: Convert kprobe_exceptions_notify to use NOKPROBE_SYMBOL (2017-03-14 15:17:40 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> New features:
> 
> - Add PERF_RECORD_NAMESPACES so that the kernel can record information
>   required to associate samples to namespaces, helping in container
>   problem characterization.
> 
>   Now the 'perf record has a --namespace' option to ask for such info,
>   and when present, it can be used, initially, via a new sort order,
>   'cgroup_id', allowing histogram entry bucketization by a (device, inode)
>   based cgroup identifier (Hari Bathini)
> 
> - Add --next option to 'perf sched timehist', showing what is the next
>   thread to run (Brendan Gregg)
> 
> Fixes:
> 
> - Fix segfault with basic block 'cycles' sort dimension (Changbin Du)
> 
> - Add c2c to command-list.txt, making it appear in the 'perf help'
>   output (Changbin Du)
> 
> - Fix zeroing of 'abs_path' variable in the perf hists browser switch
>   file code (Changbin Du)
> 
> - Hide tips messages when -q/--quiet is given to 'perf report' (Namhyung Kim)
> 
> Infrastructure:
> 
> - Use ref_reloc_sym + offset to setup kretprobes (Naveen Rao)
> 
> - Ignore generated files pmu-events/{jevents,pmu-events.c} for git (Changbin Du)
> 
> Documentation:
> 
> - Document +field style argument support for --field option (Changbin Du)
> 
> - Clarify 'perf c2c --stats' help message (Namhyung Kim)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Brendan Gregg (1):
>       perf sched timehist: Add --next option
> 
> Changbin Du (5):
>       perf tools: Missing c2c command in command-list
>       perf tools: Ignore generated files pmu-events/{jevents,pmu-events.c} for git
>       perf sort: Fix segfault with basic block 'cycles' sort dimension
>       perf report: Document +field style argument support for --field option
>       perf hists browser: Fix typo in function switch_data_file
> 
> Hari Bathini (5):
>       perf: Add PERF_RECORD_NAMESPACES to include namespaces related info
>       perf tools: Add PERF_RECORD_NAMESPACES to include namespaces related info
>       perf record: Synthesize namespace events for current processes
>       perf script: Add script print support for namespace events
>       perf tools: Add 'cgroup_id' sort order keyword
> 
> Namhyung Kim (3):
>       perf report: Hide tip message when -q option is given
>       perf c2c: Clarify help message of --stats option
>       perf c2c: Fix display bug when using pipe
> 
> Naveen N. Rao (5):
>       perf probe: Factor out the ftrace README scanning
>       perf kretprobes: Offset from reloc_sym if kernel supports it
>       perf powerpc: Choose local entry point with kretprobes
>       doc: trace/kprobes: add information about NOKPROBE_SYMBOL
>       kprobes: Convert kprobe_exceptions_notify to use NOKPROBE_SYMBOL
> 
>  Documentation/trace/kprobetrace.txt         |   5 +-
>  include/linux/perf_event.h                  |   2 +
>  include/uapi/linux/perf_event.h             |  32 +++++-
>  kernel/events/core.c                        | 139 ++++++++++++++++++++++++++
>  kernel/fork.c                               |   2 +
>  kernel/kprobes.c                            |   5 +-
>  kernel/nsproxy.c                            |   3 +
>  tools/include/uapi/linux/perf_event.h       |  32 +++++-
>  tools/perf/.gitignore                       |   2 +
>  tools/perf/Documentation/perf-record.txt    |   3 +
>  tools/perf/Documentation/perf-report.txt    |   7 +-
>  tools/perf/Documentation/perf-sched.txt     |   4 +
>  tools/perf/Documentation/perf-script.txt    |   3 +
>  tools/perf/arch/powerpc/util/sym-handling.c |  14 ++-
>  tools/perf/builtin-annotate.c               |   1 +
>  tools/perf/builtin-c2c.c                    |   4 +-
>  tools/perf/builtin-diff.c                   |   1 +
>  tools/perf/builtin-inject.c                 |  13 +++
>  tools/perf/builtin-kmem.c                   |   1 +
>  tools/perf/builtin-kvm.c                    |   2 +
>  tools/perf/builtin-lock.c                   |   1 +
>  tools/perf/builtin-mem.c                    |   1 +
>  tools/perf/builtin-record.c                 |  35 ++++++-
>  tools/perf/builtin-report.c                 |   4 +-
>  tools/perf/builtin-sched.c                  |  26 ++++-
>  tools/perf/builtin-script.c                 |  41 ++++++++
>  tools/perf/builtin-trace.c                  |   3 +-
>  tools/perf/command-list.txt                 |   1 +
>  tools/perf/perf.h                           |   1 +
>  tools/perf/ui/browsers/hists.c              |   2 +-
>  tools/perf/util/Build                       |   1 +
>  tools/perf/util/data-convert-bt.c           |   1 +
>  tools/perf/util/event.c                     | 150 ++++++++++++++++++++++++++--
>  tools/perf/util/event.h                     |  19 ++++
>  tools/perf/util/evsel.c                     |   3 +
>  tools/perf/util/hist.c                      |   7 ++
>  tools/perf/util/hist.h                      |   1 +
>  tools/perf/util/machine.c                   |  34 +++++++
>  tools/perf/util/machine.h                   |   3 +
>  tools/perf/util/namespaces.c                |  36 +++++++
>  tools/perf/util/namespaces.h                |  26 +++++
>  tools/perf/util/probe-event.c               |  12 +--
>  tools/perf/util/probe-file.c                |  77 ++++++++------
>  tools/perf/util/probe-file.h                |   1 +
>  tools/perf/util/session.c                   |   7 ++
>  tools/perf/util/sort.c                      |  46 +++++++++
>  tools/perf/util/sort.h                      |   7 ++
>  tools/perf/util/thread.c                    |  44 +++++++-
>  tools/perf/util/thread.h                    |   6 ++
>  tools/perf/util/tool.h                      |   2 +
>  50 files changed, 799 insertions(+), 74 deletions(-)
>  create mode 100644 tools/perf/util/namespaces.c
>  create mode 100644 tools/perf/util/namespaces.h

Pulled, thanks a lot Arnaldo!

	Ingo
