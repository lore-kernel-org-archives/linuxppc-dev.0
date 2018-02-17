Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zk6Fp0VvdzF161
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Feb 2018 21:49:17 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id j21so8735419wmh.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Feb 2018 02:49:17 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 17 Feb 2018 11:49:09 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, coresight@lists.linaro.org,
 David Ahern <dsahern@gmail.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 Jaecheol Shin <jcgod413@gmail.com>,
 Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@intel.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Robert Walker <robert.walker@arm.com>, Sangwon Hong <qpakzk@gmail.com>,
 Stephane Eranian <eranian@google.com>,
 Taeung Song <treeze.taeung@gmail.com>,
 Thomas Richter <tmricht@linux.vnet.ibm.com>,
 Wang Nan <wangnan0@huawei.com>, yuzhoujian <yuzhoujian@didichuxing.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/41] perf/core improvements and fixes
Message-ID: <20180217104909.sinw52ln3bcyzfms@gmail.com>
References: <20180216191746.11095-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
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
> 	Please consider pulling, this is on top of tip/perf/urgent.
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 297f9233b53a08fd457815e19f1d6f2c3389857b:
> 
>   kprobes: Propagate error from disarm_kprobe_ftrace() (2018-02-16 09:12:58 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180216
> 
> for you to fetch changes up to 21316ac6803d4a1aadd74b896db8d60a92cd1140:
> 
>   perf tests shell lib: Use a wildcard to remove the vfs_getname probe (2018-02-16 15:31:12 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Fix wrong jump arrow in systems with branch records with cycles,
>   i.e. Intel's >= Skylake (Jin Yao)
> 
> - Fix 'perf record --per-thread' problem introduced when
>   implementing 'perf stat --per-thread (Jin Yao)
> 
> - Use arch__compare_symbol_names() to fix 'perf test vmlinux',
>   that was using strcmp(symbol names) while the dso routines
>   doing symbol lookups used the arch overridable one, making
>   this test fail in architectures that overrided that function
>   with something other than strcmp() (Jiri Olsa)
> 
> - Add 'perf script --show-round-event' to display
>   PERF_RECORD_FINISHED_ROUND entries (Jiri Olsa)
> 
> - Fix dwarf unwind for stripped binaries in 'perf test' (Jiri Olsa)
> 
> - Use ordered_events for 'perf report --tasks', otherwise we may get
>   artifacts when PERF_RECORD_FORK gets processed before PERF_RECORD_COMM
>   (when they got recorded in different CPUs) (Jiri Olsa)
> 
> - Add support to display group output for non group events, i.e.
>   now when one uses 'perf report --group' on a perf.data file
>   recorded without explicitly grouping events with {} (e.g.
>   "perf record -e '{cycles,instructions}'" get the same output
>   that would produce, i.e. see all those non-grouped events in
>   multiple columns, at the same time (Jiri Olsa)
> 
> - Skip non-address kallsyms entries, e.g. '(null)' for !root (Jiri Olsa)
> 
> - Kernel maps fixes wrt perf.data(report) versus live system (top)
>   (Jiri Olsa)
> 
> - Fix memory corruption when using 'perf record -j call -g -a <application>'
>   followed by 'perf report --branch-history' (Jiri Olsa)
> 
> - ARM CoreSight fixes (Mathieu Poirier)
> 
> - Add inject capability for CoreSight Traces (Robert Waker)
> 
> - Update documentation for use of 'perf' + ARM CoreSight (Robert Walker)
> 
> - Man pages fixes (Sangwon Hong, Jaecheol Shin)
> 
> - Fix some 'perf test' cases on s/390 and x86_64 (some backtraces
>   changed with a glibc update) (Thomas Richter)
> 
> - Add detailed CPUID info in the 'perf.data' headers for s/390 to
>   then use it in 'perf annotate' (Thomas Richter)
> 
> - Add '--interval-count N' to 'perf stat', to use with -I, i.e.
>   'perf stat -I 1000 --interval-count 2' will show stats every
>    1000ms, two times (yuzhoujian)
> 
> - Add 'perf stat --timeout Nms', that will run for that many
>   milliseconds and then stop, printing the counters (yuzhoujian)
> 
> - Fix description for 'perf report --mem-modex (Andi Kleen)
> 
> - Use a wildcard to remove the vfs_getname probe in the
>   'perf test' shell based test cases (Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (1):
>       perf report: Fix description for --mem-mode
> 
> Arnaldo Carvalho de Melo (1):
>       perf tests shell lib: Use a wildcard to remove the vfs_getname probe
> 
> Jaecheol Shin (1):
>       perf annotate: Add missing arguments in Man page
> 
> Jin Yao (2):
>       perf tools: Use target->per_thread and target->system_wide flags
>       perf report: Fix wrong jump arrow
> 
> Jiri Olsa (18):
>       perf record: Put new line after target override warning
>       perf script: Add --show-round-event to display PERF_RECORD_FINISHED_ROUND
>       tools lib api fs: Add filename__read_xll function
>       tools lib api fs: Add sysfs__read_xll function
>       perf tests: Fix dwarf unwind for stripped binaries
>       perf tools: Fix comment for sort__* compare functions
>       perf report: Ask for ordered events for --tasks option
>       perf report: Add support to display group output for non group events
>       tools lib symbol: Skip non-address kallsyms line
>       perf symbols: Check if we read regular file in dso__load()
>       perf machine: Free root_dir in machine__init() error path
>       perf machine: Move kernel mmap name into struct machine
>       perf machine: Generalize machine__set_kernel_mmap()
>       perf machine: Don't search for active kernel start in __machine__create_kernel_maps
>       perf machine: Remove machine__load_kallsyms()
>       perf tools: Do not create kernel maps in sample__resolve()
>       perf tests: Use arch__compare_symbol_names to compare symbols
>       perf report: Fix memory corruption in --branch-history mode --branch-history
> 
> Mathieu Poirier (3):
>       perf cs-etm: Freeing allocated memory
>       perf auxtrace arm: Fixing uninitialised variable
>       perf cs-etm: Properly deal with cpu maps
> 
> Ravi Bangoria (3):
>       tools include powerpc: Grab a copy of arch/powerpc/include/uapi/asm/unistd.h
>       perf powerpc: Generate system call table from asm/unistd.h
>       perf trace powerpc: Use generated syscall table
> 
> Robert Walker (3):
>       perf cs-etm: Inject capabilitity for CoreSight traces
>       perf inject: Emit instruction records on ETM trace discontinuity
>       coresight: Update documentation for perf usage
> 
> Sangwon Hong (2):
>       perf kmem: Document a missing option & an argument
>       perf mem: Document a missing option
> 
> Thomas Richter (5):
>       perf record: Provide detailed information on s390 CPU
>       perf annotate: Scan cpuid for s390 and save machine type
>       perf cpuid: Introduce a platform specific cpuid compare function
>       perf test: Fix test case 23 for s390 z/VM or KVM guests
>       perf test: Fix test case inet_pton to accept inlines.
> 
> yuzhoujian (2):
>       perf stat: Add support to print counts for fixed times
>       perf stat: Add support to print counts after a period of time
> 
>  Documentation/trace/coresight.txt                  |  51 +++
>  tools/arch/powerpc/include/uapi/asm/unistd.h       | 402 +++++++++++++++++
>  tools/lib/api/fs/fs.c                              |  44 +-
>  tools/lib/api/fs/fs.h                              |   2 +
>  tools/lib/symbol/kallsyms.c                        |   4 +
>  tools/perf/Documentation/perf-annotate.txt         |   6 +-
>  tools/perf/Documentation/perf-kmem.txt             |   6 +-
>  tools/perf/Documentation/perf-mem.txt              |   4 +
>  tools/perf/Documentation/perf-report.txt           |   5 +-
>  tools/perf/Documentation/perf-script.txt           |   3 +
>  tools/perf/Documentation/perf-stat.txt             |  10 +
>  tools/perf/Makefile.config                         |   2 +
>  tools/perf/arch/arm/util/auxtrace.c                |   2 +-
>  tools/perf/arch/arm/util/cs-etm.c                  |  51 ++-
>  tools/perf/arch/powerpc/Makefile                   |  25 ++
>  .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |  37 ++
>  tools/perf/arch/s390/annotate/instructions.c       |  27 +-
>  tools/perf/arch/s390/util/header.c                 | 148 ++++++-
>  tools/perf/builtin-record.c                        |   2 +-
>  tools/perf/builtin-report.c                        |   7 +-
>  tools/perf/builtin-script.c                        |  17 +
>  tools/perf/builtin-stat.c                          |  53 ++-
>  tools/perf/check-headers.sh                        |   1 +
>  tools/perf/tests/code-reading.c                    |  33 +-
>  tools/perf/tests/dwarf-unwind.c                    |  46 +-
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh    |   2 +-
>  .../perf/tests/shell/trace+probe_libc_inet_pton.sh |   6 +-
>  tools/perf/tests/vmlinux-kallsyms.c                |   4 +-
>  tools/perf/ui/browsers/annotate.c                  |   9 +-
>  tools/perf/util/build-id.c                         |  10 +-
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  74 +++-
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |   2 +
>  tools/perf/util/cs-etm.c                           | 478 ++++++++++++++++++---
>  tools/perf/util/event.c                            |  16 +-
>  tools/perf/util/evlist.c                           |  21 +-
>  tools/perf/util/header.h                           |   1 +
>  tools/perf/util/hist.c                             |   4 +-
>  tools/perf/util/hist.h                             |   1 -
>  tools/perf/util/machine.c                          | 145 +++----
>  tools/perf/util/machine.h                          |   6 +-
>  tools/perf/util/pmu.c                              |  47 +-
>  tools/perf/util/sort.c                             |   7 +-
>  tools/perf/util/stat.h                             |   2 +
>  tools/perf/util/symbol.c                           |  13 +-
>  tools/perf/util/syscalltbl.c                       |   8 +
>  tools/perf/util/thread_map.c                       |   4 +-
>  tools/perf/util/thread_map.h                       |   2 +-
>  47 files changed, 1577 insertions(+), 273 deletions(-)
>  create mode 100644 tools/arch/powerpc/include/uapi/asm/unistd.h
>  create mode 100755 tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl

Pulled, thanks a lot Arnaldo!

	Ingo
