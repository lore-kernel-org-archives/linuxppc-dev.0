Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcnzD5gcVzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 18:17:12 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id u132so9171714wmg.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 23:17:11 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 7 Mar 2017 08:17:03 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>,
 Borislav Petkov <bp@suse.de>, Charles Baylis <charles.baylis@linaro.org>,
 Dave Hansen <dave.hansen@intel.com>, David Ahern <dsahern@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>, David Windsor <dwindsor@gmail.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans Liljestrand <ishkamiel@gmail.com>,
 Jiri Hladky <jhladky@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@intel.com>,
 Karol Wachowski <karol.wachowski@intel.com>,
 Kees Kook <keescook@chromium.org>, kernel-team@lge.com,
 linuxppc-dev@lists.ozlabs.org, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
 Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Piotr Luc <piotr.luc@intel.com>, Robert Richter <rric@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Vince Weaver <vince@deater.net>, Wang Nan <wangnan0@huawei.com>
Subject: Re: [GIT PULL 00/35] perf/core improvements and fixes
Message-ID: <20170307071703.GA29708@gmail.com>
References: <20170306193825.24011-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170306193825.24011-1-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 9d020d33fc1b2faa0eb35859df1381ca5dc94ffe:
> 
>   Merge branch 'linus' into perf/urgent, to resolve conflict (2017-03-02 08:05:45 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.11-20170306
> 
> for you to fetch changes up to 001916b94a04809a94abb07daba6f9ace01906ba:
> 
>   perf bench numa: Add more comment for -c option (2017-03-06 12:39:30 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> New features:
> 
> - Allow sorting by symbol_size in 'perf report' and 'perf top' (Charles Baylis)
> 
>   E.g.:
> 
>   # perf report -s symbol_size,symbol
> 
>   Samples: 9K of event 'cycles:k', Event count (approx.): 2870461623
>   Overhead  Symbol size  Symbol
>     14.55%          326  [k] flush_tlb_mm_range
>      7.20%         1045  [k] filemap_map_pages
>      5.82%          124  [k] vma_interval_tree_insert
>      5.18%         2430  [k] unmap_page_range
>      2.57%          571  [k] vma_interval_tree_remove
>      1.94%          494  [k] page_add_file_rmap
>      1.82%          740  [k] page_remove_rmap
>      1.66%         1017  [k] release_pages
>      1.57%         1636  [k] update_blocked_averages
>      1.57%           76  [k] unlock_page
> 
> - Add support for -p/--pid, -a/--all-cpus and -C/--cpu in 'perf ftrace' (Namhyung Kim)
> 
> Change in behaviour:
> 
> - Make system wide (-a) the default option if no target was specified and one
>   of following conditions is met:
> 
>   - No workload specified (current behaviour)
> 
>   - A workload is specified but all requested events are system wide ones,
>     like uncore ones. (Jiri Olsa)
> 
> Fixes:
> 
> - Add missing initialization to the instruction decoder used in the
>   intel PT/BTS code, which was causing lots of failures in 'perf test',
>   looking for a value when there was none (Adrian Hunter)
> 
> Infrastructure:
> 
> - Add arch code needed to adopt the kernel's refcount_t to aid in
>   catching bugs when using atomic_t as a reference counter, basically
>   cmpxchg related functions (Arnaldo Carvalho de Melo)
> 
> - Convert the code using atomic_t as reference counts to refcount_t
>   (Elena Rashetova)
> 
> - Add feature test for sched_getcpu() to more easily check for its
>   presence in the many libc implementations and accross different
>   versions of such C libraries (Arnaldo Carvalho de Melo)
> 
> - Issue a HW watchdog disable hint in 'perf stat' for when some of the
>   requested events can't get counted because a PMU counter is taken by that
>   watchdog (Borislav Petkov).
> 
> - Add mapping for Intel's KnightsMill PMU events (Karol Wachowski)
> 
> Documentation:
> 
> - Clarify the term 'convergence' in:
> 
>    perf bench numa numa-mem -h --show_convergence (Jiri Olsa)
> 
> Kernel code:
> 
> - Ensure probe location is at function entry in kretprobes (Naveen N. Rao)
> 
> - Allow return probes with offsets and absolute addresses (Naveen N. Rao)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (1):
>       perf intel-PT/BTS: Add missing initialization
> 
> Arnaldo Carvalho de Melo (12):
>       tools include: Adopt __compiletime_error
>       tools arch x86: Include asm/cmpxchg.h
>       tools arch x86: Introduce atomic_cmpxchg()
>       tools include: Introduce atomic_cmpxchg_{relaxed,release}()
>       tools include: Provide gcc based cmpxchg fallback for !x86
>       tools include: Add UINT_MAX def to kernel.h
>       tools include: Adopt kernel's refcount.h
>       perf evlist: Clarify a bit the use of perf_mmap->refcnt
>       tools build: Add test for sched_getcpu()
>       perf bench futex: Use __maybe_unused
>       perf bench futex: Fix build on musl + clang
>       tools build: Use the same CC for feature detection and actual build
> 
> Borislav Petkov (1):
>       perf stat: Issue a HW watchdog disable hint
> 
> Charles Baylis (1):
>       perf tools: Allow sorting by symbol size
> 
> Elena Reshetova (9):
>       perf cgroup: Convert cgroup_sel.refcnt from atomic_t to refcount_t
>       perf cpumap: Convert cpu_map.refcnt from atomic_t to refcount_t
>       perf comm: Convert comm_str.refcnt from atomic_t to refcount_t
>       perf dso: Convert dso.refcnt from atomic_t to refcount_t
>       perf map: Convert map.refcnt from atomic_t to refcount_t
>       perf map: Convert map_groups.refcnt from atomic_t to refcount_t
>       perf evlist: Convert perf_map.refcnt from atomic_t to refcount_t
>       perf thread: convert thread.refcnt from atomic_t to refcount_t
>       perf thread_map: Convert thread_map.refcnt from atomic_t to refcount_t
> 
> Jiri Olsa (2):
>       perf tools: Force uncore events to system wide monitoring
>       perf bench numa: Add more comment for -c option
> 
> Karol Wachowski (1):
>       perf vendor events: Add mapping for KnightsMill PMU events
> 
> Namhyung Kim (4):
>       perf ftrace: Add support for --pid option
>       perf cpumap: Introduce cpu_map__snprint_mask()
>       perf ftrace: Add support for -a and -C option
>       perf ftrace: Use pager for displaying result
> 
> Naveen N. Rao (3):
>       kretprobes: Ensure probe location is at function entry
>       trace/kprobes: Allow return probes with offsets and absolute addresses
>       perf probe: Generalize probe event file open routine
> 
> Steven Rostedt (VMware) (1):
>       trace/kprobes: Add back warning about offset in return probes
> 
>  include/linux/kprobes.h                            |   1 +
>  kernel/kprobes.c                                   |  13 ++
>  kernel/trace/trace.c                               |   1 +
>  kernel/trace/trace_kprobe.c                        |   9 +-
>  tools/arch/x86/include/asm/atomic.h                |   7 +
>  tools/arch/x86/include/asm/cmpxchg.h               |  89 ++++++++++++
>  tools/build/Makefile.feature                       |   1 +
>  tools/build/feature/Makefile                       |  10 +-
>  tools/build/feature/test-all.c                     |   5 +
>  tools/build/feature/test-sched_getcpu.c            |   7 +
>  tools/include/asm-generic/atomic-gcc.h             |   8 ++
>  tools/include/linux/atomic.h                       |   6 +
>  tools/include/linux/compiler-gcc.h                 |   4 +
>  tools/include/linux/compiler.h                     |   4 +
>  tools/include/linux/kernel.h                       |   4 +
>  tools/include/linux/refcount.h                     | 151 ++++++++++++++++++++
>  tools/perf/Documentation/perf-ftrace.txt           |  18 +++
>  tools/perf/Documentation/perf-report.txt           |   1 +
>  tools/perf/MANIFEST                                |   2 +
>  tools/perf/Makefile.config                         |   4 +
>  tools/perf/bench/futex-hash.c                      |   1 +
>  tools/perf/bench/futex-lock-pi.c                   |   1 +
>  tools/perf/bench/futex-requeue.c                   |   1 +
>  tools/perf/bench/futex-wake-parallel.c             |   1 +
>  tools/perf/bench/futex-wake.c                      |   1 +
>  tools/perf/bench/futex.h                           |  10 +-
>  tools/perf/bench/numa.c                            |   3 +-
>  tools/perf/builtin-ftrace.c                        | 152 +++++++++++++++++----
>  tools/perf/builtin-stat.c                          |  44 +++++-
>  tools/perf/pmu-events/arch/x86/mapfile.csv         |   1 +
>  tools/perf/tests/cpumap.c                          |   2 +-
>  tools/perf/tests/thread-map.c                      |   6 +-
>  tools/perf/tests/thread-mg-share.c                 |  12 +-
>  tools/perf/util/cgroup.c                           |   6 +-
>  tools/perf/util/cgroup.h                           |   4 +-
>  tools/perf/util/cloexec.h                          |   6 -
>  tools/perf/util/comm.c                             |  15 +-
>  tools/perf/util/cpumap.c                           |  62 +++++++--
>  tools/perf/util/cpumap.h                           |   5 +-
>  tools/perf/util/dso.c                              |   6 +-
>  tools/perf/util/dso.h                              |   4 +-
>  tools/perf/util/evlist.c                           |  31 +++--
>  tools/perf/util/evlist.h                           |   4 +-
>  tools/perf/util/hist.h                             |   1 +
>  .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |   2 +
>  tools/perf/util/machine.c                          |   2 +-
>  tools/perf/util/map.c                              |  10 +-
>  tools/perf/util/map.h                              |  10 +-
>  tools/perf/util/parse-events.c                     |   5 +-
>  tools/perf/util/probe-file.c                       |  20 +--
>  tools/perf/util/probe-file.h                       |   1 +
>  tools/perf/util/sort.c                             |  41 ++++++
>  tools/perf/util/sort.h                             |   1 +
>  tools/perf/util/thread.c                           |   6 +-
>  tools/perf/util/thread.h                           |   4 +-
>  tools/perf/util/thread_map.c                       |  20 +--
>  tools/perf/util/thread_map.h                       |   4 +-
>  tools/perf/util/util.h                             |   4 +-
>  tools/scripts/Makefile.include                     |   9 ++
>  59 files changed, 720 insertions(+), 143 deletions(-)
>  create mode 100644 tools/arch/x86/include/asm/cmpxchg.h
>  create mode 100644 tools/build/feature/test-sched_getcpu.c
>  create mode 100644 tools/include/linux/refcount.h

Pulled, thanks a lot Arnaldo!

	Ingo
