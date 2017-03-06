Return-Path: <BATV+66b78c8ded87d72a509b+4943+infradead.org+acme@merlin.srs.infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcVTl0pmNzDqYQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 06:39:07 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
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
 Hans Liljestrand <ishkamiel@gmail.com>, Jiri Hladky <jhladky@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>,
 Karol Wachowski <karol.wachowski@intel.com>,
 Kees Kook <keescook@chromium.org>, kernel-team@lge.com,
 linuxppc-dev@lists.ozlabs.org, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
 Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Piotr Luc <piotr.luc@intel.com>,
 Robert Richter <rric@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Steven Rostedt <rostedt@goodmis.org>, Vince Weaver <vince@deater.net>,
 Wang Nan <wangnan0@huawei.com>
Subject: [GIT PULL 00/35] perf/core improvements and fixes
Date: Mon,  6 Mar 2017 16:37:50 -0300
Message-Id: <20170306193825.24011-1-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 9d020d33fc1b2faa0eb35859df1381ca5dc94ffe:

  Merge branch 'linus' into perf/urgent, to resolve conflict (2017-03-02 08:05:45 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.11-20170306

for you to fetch changes up to 001916b94a04809a94abb07daba6f9ace01906ba:

  perf bench numa: Add more comment for -c option (2017-03-06 12:39:30 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

New features:

- Allow sorting by symbol_size in 'perf report' and 'perf top' (Charles Baylis)

  E.g.:

  # perf report -s symbol_size,symbol

  Samples: 9K of event 'cycles:k', Event count (approx.): 2870461623
  Overhead  Symbol size  Symbol
    14.55%          326  [k] flush_tlb_mm_range
     7.20%         1045  [k] filemap_map_pages
     5.82%          124  [k] vma_interval_tree_insert
     5.18%         2430  [k] unmap_page_range
     2.57%          571  [k] vma_interval_tree_remove
     1.94%          494  [k] page_add_file_rmap
     1.82%          740  [k] page_remove_rmap
     1.66%         1017  [k] release_pages
     1.57%         1636  [k] update_blocked_averages
     1.57%           76  [k] unlock_page

- Add support for -p/--pid, -a/--all-cpus and -C/--cpu in 'perf ftrace' (Namhyung Kim)

Change in behaviour:

- Make system wide (-a) the default option if no target was specified and one
  of following conditions is met:

  - No workload specified (current behaviour)

  - A workload is specified but all requested events are system wide ones,
    like uncore ones. (Jiri Olsa)

Fixes:

- Add missing initialization to the instruction decoder used in the
  intel PT/BTS code, which was causing lots of failures in 'perf test',
  looking for a value when there was none (Adrian Hunter)

Infrastructure:

- Add arch code needed to adopt the kernel's refcount_t to aid in
  catching bugs when using atomic_t as a reference counter, basically
  cmpxchg related functions (Arnaldo Carvalho de Melo)

- Convert the code using atomic_t as reference counts to refcount_t
  (Elena Rashetova)

- Add feature test for sched_getcpu() to more easily check for its
  presence in the many libc implementations and accross different
  versions of such C libraries (Arnaldo Carvalho de Melo)

- Issue a HW watchdog disable hint in 'perf stat' for when some of the
  requested events can't get counted because a PMU counter is taken by that
  watchdog (Borislav Petkov).

- Add mapping for Intel's KnightsMill PMU events (Karol Wachowski)

Documentation:

- Clarify the term 'convergence' in:

   perf bench numa numa-mem -h --show_convergence (Jiri Olsa)

Kernel code:

- Ensure probe location is at function entry in kretprobes (Naveen N. Rao)

- Allow return probes with offsets and absolute addresses (Naveen N. Rao)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (1):
      perf intel-PT/BTS: Add missing initialization

Arnaldo Carvalho de Melo (12):
      tools include: Adopt __compiletime_error
      tools arch x86: Include asm/cmpxchg.h
      tools arch x86: Introduce atomic_cmpxchg()
      tools include: Introduce atomic_cmpxchg_{relaxed,release}()
      tools include: Provide gcc based cmpxchg fallback for !x86
      tools include: Add UINT_MAX def to kernel.h
      tools include: Adopt kernel's refcount.h
      perf evlist: Clarify a bit the use of perf_mmap->refcnt
      tools build: Add test for sched_getcpu()
      perf bench futex: Use __maybe_unused
      perf bench futex: Fix build on musl + clang
      tools build: Use the same CC for feature detection and actual build

Borislav Petkov (1):
      perf stat: Issue a HW watchdog disable hint

Charles Baylis (1):
      perf tools: Allow sorting by symbol size

Elena Reshetova (9):
      perf cgroup: Convert cgroup_sel.refcnt from atomic_t to refcount_t
      perf cpumap: Convert cpu_map.refcnt from atomic_t to refcount_t
      perf comm: Convert comm_str.refcnt from atomic_t to refcount_t
      perf dso: Convert dso.refcnt from atomic_t to refcount_t
      perf map: Convert map.refcnt from atomic_t to refcount_t
      perf map: Convert map_groups.refcnt from atomic_t to refcount_t
      perf evlist: Convert perf_map.refcnt from atomic_t to refcount_t
      perf thread: convert thread.refcnt from atomic_t to refcount_t
      perf thread_map: Convert thread_map.refcnt from atomic_t to refcount_t

Jiri Olsa (2):
      perf tools: Force uncore events to system wide monitoring
      perf bench numa: Add more comment for -c option

Karol Wachowski (1):
      perf vendor events: Add mapping for KnightsMill PMU events

Namhyung Kim (4):
      perf ftrace: Add support for --pid option
      perf cpumap: Introduce cpu_map__snprint_mask()
      perf ftrace: Add support for -a and -C option
      perf ftrace: Use pager for displaying result

Naveen N. Rao (3):
      kretprobes: Ensure probe location is at function entry
      trace/kprobes: Allow return probes with offsets and absolute addresses
      perf probe: Generalize probe event file open routine

Steven Rostedt (VMware) (1):
      trace/kprobes: Add back warning about offset in return probes

 include/linux/kprobes.h                            |   1 +
 kernel/kprobes.c                                   |  13 ++
 kernel/trace/trace.c                               |   1 +
 kernel/trace/trace_kprobe.c                        |   9 +-
 tools/arch/x86/include/asm/atomic.h                |   7 +
 tools/arch/x86/include/asm/cmpxchg.h               |  89 ++++++++++++
 tools/build/Makefile.feature                       |   1 +
 tools/build/feature/Makefile                       |  10 +-
 tools/build/feature/test-all.c                     |   5 +
 tools/build/feature/test-sched_getcpu.c            |   7 +
 tools/include/asm-generic/atomic-gcc.h             |   8 ++
 tools/include/linux/atomic.h                       |   6 +
 tools/include/linux/compiler-gcc.h                 |   4 +
 tools/include/linux/compiler.h                     |   4 +
 tools/include/linux/kernel.h                       |   4 +
 tools/include/linux/refcount.h                     | 151 ++++++++++++++++++++
 tools/perf/Documentation/perf-ftrace.txt           |  18 +++
 tools/perf/Documentation/perf-report.txt           |   1 +
 tools/perf/MANIFEST                                |   2 +
 tools/perf/Makefile.config                         |   4 +
 tools/perf/bench/futex-hash.c                      |   1 +
 tools/perf/bench/futex-lock-pi.c                   |   1 +
 tools/perf/bench/futex-requeue.c                   |   1 +
 tools/perf/bench/futex-wake-parallel.c             |   1 +
 tools/perf/bench/futex-wake.c                      |   1 +
 tools/perf/bench/futex.h                           |  10 +-
 tools/perf/bench/numa.c                            |   3 +-
 tools/perf/builtin-ftrace.c                        | 152 +++++++++++++++++----
 tools/perf/builtin-stat.c                          |  44 +++++-
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   1 +
 tools/perf/tests/cpumap.c                          |   2 +-
 tools/perf/tests/thread-map.c                      |   6 +-
 tools/perf/tests/thread-mg-share.c                 |  12 +-
 tools/perf/util/cgroup.c                           |   6 +-
 tools/perf/util/cgroup.h                           |   4 +-
 tools/perf/util/cloexec.h                          |   6 -
 tools/perf/util/comm.c                             |  15 +-
 tools/perf/util/cpumap.c                           |  62 +++++++--
 tools/perf/util/cpumap.h                           |   5 +-
 tools/perf/util/dso.c                              |   6 +-
 tools/perf/util/dso.h                              |   4 +-
 tools/perf/util/evlist.c                           |  31 +++--
 tools/perf/util/evlist.h                           |   4 +-
 tools/perf/util/hist.h                             |   1 +
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |   2 +
 tools/perf/util/machine.c                          |   2 +-
 tools/perf/util/map.c                              |  10 +-
 tools/perf/util/map.h                              |  10 +-
 tools/perf/util/parse-events.c                     |   5 +-
 tools/perf/util/probe-file.c                       |  20 +--
 tools/perf/util/probe-file.h                       |   1 +
 tools/perf/util/sort.c                             |  41 ++++++
 tools/perf/util/sort.h                             |   1 +
 tools/perf/util/thread.c                           |   6 +-
 tools/perf/util/thread.h                           |   4 +-
 tools/perf/util/thread_map.c                       |  20 +--
 tools/perf/util/thread_map.h                       |   4 +-
 tools/perf/util/util.h                             |   4 +-
 tools/scripts/Makefile.include                     |   9 ++
 59 files changed, 720 insertions(+), 143 deletions(-)
 create mode 100644 tools/arch/x86/include/asm/cmpxchg.h
 create mode 100644 tools/build/feature/test-sched_getcpu.c
 create mode 100644 tools/include/linux/refcount.h

Test results:

The first ones are container (docker) based builds of tools/perf with and
without libelf support, objtool where it is supported and samples/bpf/, ditto.
Where clang is available, it is also used to build perf with/without libelf.

Several are cross builds, the ones with -x-ARCH, and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one. It is planned to have it run on each
of the containers mentioned above, using some container orchestration
infrastructure. Get in contact if interested in helping having this in place.

  [root@jouet ~]# waitp `pidof perf` ; time dm
     1 alpine:3.4: Ok
     2 alpine:3.5: Ok
     3 alpine:edge: Ok
     4 android-ndk:r12b-arm: Ok
     5 archlinux:latest: Ok
     6 centos:5: Ok
     7 centos:6: Ok
     8 centos:7: Ok
     9 debian:7: Ok
    10 debian:8: Ok
    11 debian:experimental: Ok
    12 debian:experimental-x-arm64: Ok
    13 debian:experimental-x-mips: Ok
    14 debian:experimental-x-mips64: Ok
    15 debian:experimental-x-mipsel: Ok
    16 fedora:20: Ok
    17 fedora:21: Ok
    18 fedora:22: Ok
    19 fedora:23: Ok
    20 fedora:24: Ok
    21 fedora:24-x-ARC-uClibc: Ok
    22 fedora:25: Ok
    23 fedora:rawhide: Ok
    24 mageia:5: Ok
    25 opensuse:13.2: Ok
    26 opensuse:42.1: Ok
    27 opensuse:tumbleweed: Ok
    28 ubuntu:12.04.5: Ok
    29 ubuntu:14.04.4: Ok
    30 ubuntu:14.04.4-x-linaro-arm64: Ok
    31 ubuntu:15.10: Ok
    32 ubuntu:16.04: Ok
    33 ubuntu:16.04-x-arm: Ok
    34 ubuntu:16.04-x-arm64: Ok
    35 ubuntu:16.04-x-powerpc: Ok
    36 ubuntu:16.04-x-powerpc64: Ok
    37 ubuntu:16.04-x-s390: Ok
    38 ubuntu:16.10: Ok
    39 ubuntu:17.04: Ok
  [root@jouet ~]#

  [root@zoo ~]# uname -a
  Linux zoo 4.9.13-100.fc24.x86_64 #1 SMP Mon Feb 27 16:57:22 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
  [root@zoo ~]# perf test
   1: vmlinux symtab matches kallsyms            : Ok
   2: Detect openat syscall event                : Ok
   3: Detect openat syscall event on all cpus    : Ok
   4: Read samples using the mmap interface      : Ok
   5: Parse event definition strings             : Ok
   6: PERF_RECORD_* events & perf_sample fields  : Ok
   7: Parse perf pmu format                      : Ok
   8: DSO data read                              : Ok
   9: DSO data cache                             : Ok
  10: DSO data reopen                            : Ok
  11: Roundtrip evsel->name                      : Ok
  12: Parse sched tracepoints fields             : Ok
  13: syscalls:sys_enter_openat event fields     : Ok
  14: Setup struct perf_event_attr               : Ok
  15: Match and link multiple hists              : Ok
  16: 'import perf' in python                    : Ok
  17: Breakpoint overflow signal handler         : Ok
  18: Breakpoint overflow sampling               : Ok
  19: Number of exit events of a simple workload : Ok
  20: Software clock events period values        : Ok
  21: Object code reading                        : Ok
  22: Sample parsing                             : Ok
  23: Use a dummy software event to keep tracking: Ok
  24: Parse with no sample_id_all bit set        : Ok
  25: Filter hist entries                        : Ok
  26: Lookup mmap thread                         : Ok
  27: Share thread mg                            : Ok
  28: Sort output of hist entries                : Ok
  29: Cumulate child hist entries                : Ok
  30: Track with sched_switch                    : Ok
  31: Filter fds with revents mask in a fdarray  : Ok
  32: Add fd to a fdarray, making it autogrow    : Ok
  33: kmod_path__parse                           : Ok
  34: Thread map                                 : Ok
  35: LLVM search and compile                    :
  35.1: Basic BPF llvm compile                    : Ok
  35.2: kbuild searching                          : Ok
  35.3: Compile source for BPF prologue generation: Ok
  35.4: Compile source for BPF relocation         : Ok
  36: Session topology                           : Ok
  37: BPF filter                                 :
  37.1: Basic BPF filtering                      : Ok
  37.2: BPF pinning                              : Ok
  37.3: BPF prologue generation                  : Ok
  37.4: BPF relocation checker                   : Ok
  38: Synthesize thread map                      : Ok
  39: Remove thread map                          : Ok
  40: Synthesize cpu map                         : Ok
  41: Synthesize stat config                     : Ok
  42: Synthesize stat                            : Ok
  43: Synthesize stat round                      : Ok
  44: Synthesize attr update                     : Ok
  45: Event times                                : Ok
  46: Read backward ring buffer                  : Ok
  47: Print cpu map                              : Ok
  48: Probe SDT events                           : Ok
  49: is_printable_array                         : Ok
  50: Print bitmap                               : Ok
  51: perf hooks                                 : Ok
  52: builtin clang support                      : Skip (not compiled in)
  53: unit_number__scnprintf                     : Ok
  54: x86 rdpmc                                  : Ok
  55: Convert perf time to TSC                   : Ok
  56: DWARF unwind                               : Ok
  57: x86 instruction decoder - new instructions : Ok
  58: Intel cqm nmi context read                 : Skip
  [root@zoo ~]#

  [acme@jouet linux]$ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/linux/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_pure_O: make
                    make_doc_O: make doc
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                 make_static_O: make LDFLAGS=-static
                   make_help_O: make help
             make_no_libnuma_O: make NO_LIBNUMA=1
              make_clean_all_O: make clean all
              make_no_libelf_O: make NO_LIBELF=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
             make_no_libperl_O: make NO_LIBPERL=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                   make_tags_O: make tags
                  make_debug_O: make DEBUG=1
                make_no_newt_O: make NO_NEWT=1
         make_install_prefix_O: make install prefix=/tmp/krava
            make_install_bin_O: make install-bin
                 make_perf_o_O: make perf.o
               make_no_slang_O: make NO_SLANG=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
             make_util_map_o_O: make util/map.o
           make_no_libpython_O: make NO_LIBPYTHON=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                make_no_gtk2_O: make NO_GTK2=1
              make_no_libbpf_O: make NO_LIBBPF=1
                make_install_O: make install
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
  OK
  [acme@jouet linux]$
