Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zjjbG4Zs8zF1K8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Feb 2018 06:18:02 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, coresight@lists.linaro.org,
 David Ahern <dsahern@gmail.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 Jaecheol Shin <jcgod413@gmail.com>, Jin Yao <yao.jin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>,
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
Subject: [GIT PULL 00/41] perf/core improvements and fixes
Date: Fri, 16 Feb 2018 16:17:05 -0300
Message-Id: <20180216191746.11095-1-acme@kernel.org>
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

Hi Ingo,

	Please consider pulling, this is on top of tip/perf/urgent.

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 297f9233b53a08fd457815e19f1d6f2c3389857b:

  kprobes: Propagate error from disarm_kprobe_ftrace() (2018-02-16 09:12:58 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180216

for you to fetch changes up to 21316ac6803d4a1aadd74b896db8d60a92cd1140:

  perf tests shell lib: Use a wildcard to remove the vfs_getname probe (2018-02-16 15:31:12 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Fix wrong jump arrow in systems with branch records with cycles,
  i.e. Intel's >= Skylake (Jin Yao)

- Fix 'perf record --per-thread' problem introduced when
  implementing 'perf stat --per-thread (Jin Yao)

- Use arch__compare_symbol_names() to fix 'perf test vmlinux',
  that was using strcmp(symbol names) while the dso routines
  doing symbol lookups used the arch overridable one, making
  this test fail in architectures that overrided that function
  with something other than strcmp() (Jiri Olsa)

- Add 'perf script --show-round-event' to display
  PERF_RECORD_FINISHED_ROUND entries (Jiri Olsa)

- Fix dwarf unwind for stripped binaries in 'perf test' (Jiri Olsa)

- Use ordered_events for 'perf report --tasks', otherwise we may get
  artifacts when PERF_RECORD_FORK gets processed before PERF_RECORD_COMM
  (when they got recorded in different CPUs) (Jiri Olsa)

- Add support to display group output for non group events, i.e.
  now when one uses 'perf report --group' on a perf.data file
  recorded without explicitly grouping events with {} (e.g.
  "perf record -e '{cycles,instructions}'" get the same output
  that would produce, i.e. see all those non-grouped events in
  multiple columns, at the same time (Jiri Olsa)

- Skip non-address kallsyms entries, e.g. '(null)' for !root (Jiri Olsa)

- Kernel maps fixes wrt perf.data(report) versus live system (top)
  (Jiri Olsa)

- Fix memory corruption when using 'perf record -j call -g -a <application>'
  followed by 'perf report --branch-history' (Jiri Olsa)

- ARM CoreSight fixes (Mathieu Poirier)

- Add inject capability for CoreSight Traces (Robert Waker)

- Update documentation for use of 'perf' + ARM CoreSight (Robert Walker)

- Man pages fixes (Sangwon Hong, Jaecheol Shin)

- Fix some 'perf test' cases on s/390 and x86_64 (some backtraces
  changed with a glibc update) (Thomas Richter)

- Add detailed CPUID info in the 'perf.data' headers for s/390 to
  then use it in 'perf annotate' (Thomas Richter)

- Add '--interval-count N' to 'perf stat', to use with -I, i.e.
  'perf stat -I 1000 --interval-count 2' will show stats every
   1000ms, two times (yuzhoujian)

- Add 'perf stat --timeout Nms', that will run for that many
  milliseconds and then stop, printing the counters (yuzhoujian)

- Fix description for 'perf report --mem-modex (Andi Kleen)

- Use a wildcard to remove the vfs_getname probe in the
  'perf test' shell based test cases (Arnaldo Carvalho de Melo)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andi Kleen (1):
      perf report: Fix description for --mem-mode

Arnaldo Carvalho de Melo (1):
      perf tests shell lib: Use a wildcard to remove the vfs_getname probe

Jaecheol Shin (1):
      perf annotate: Add missing arguments in Man page

Jin Yao (2):
      perf tools: Use target->per_thread and target->system_wide flags
      perf report: Fix wrong jump arrow

Jiri Olsa (18):
      perf record: Put new line after target override warning
      perf script: Add --show-round-event to display PERF_RECORD_FINISHED_ROUND
      tools lib api fs: Add filename__read_xll function
      tools lib api fs: Add sysfs__read_xll function
      perf tests: Fix dwarf unwind for stripped binaries
      perf tools: Fix comment for sort__* compare functions
      perf report: Ask for ordered events for --tasks option
      perf report: Add support to display group output for non group events
      tools lib symbol: Skip non-address kallsyms line
      perf symbols: Check if we read regular file in dso__load()
      perf machine: Free root_dir in machine__init() error path
      perf machine: Move kernel mmap name into struct machine
      perf machine: Generalize machine__set_kernel_mmap()
      perf machine: Don't search for active kernel start in __machine__create_kernel_maps
      perf machine: Remove machine__load_kallsyms()
      perf tools: Do not create kernel maps in sample__resolve()
      perf tests: Use arch__compare_symbol_names to compare symbols
      perf report: Fix memory corruption in --branch-history mode --branch-history

Mathieu Poirier (3):
      perf cs-etm: Freeing allocated memory
      perf auxtrace arm: Fixing uninitialised variable
      perf cs-etm: Properly deal with cpu maps

Ravi Bangoria (3):
      tools include powerpc: Grab a copy of arch/powerpc/include/uapi/asm/unistd.h
      perf powerpc: Generate system call table from asm/unistd.h
      perf trace powerpc: Use generated syscall table

Robert Walker (3):
      perf cs-etm: Inject capabilitity for CoreSight traces
      perf inject: Emit instruction records on ETM trace discontinuity
      coresight: Update documentation for perf usage

Sangwon Hong (2):
      perf kmem: Document a missing option & an argument
      perf mem: Document a missing option

Thomas Richter (5):
      perf record: Provide detailed information on s390 CPU
      perf annotate: Scan cpuid for s390 and save machine type
      perf cpuid: Introduce a platform specific cpuid compare function
      perf test: Fix test case 23 for s390 z/VM or KVM guests
      perf test: Fix test case inet_pton to accept inlines.

yuzhoujian (2):
      perf stat: Add support to print counts for fixed times
      perf stat: Add support to print counts after a period of time

 Documentation/trace/coresight.txt                  |  51 +++
 tools/arch/powerpc/include/uapi/asm/unistd.h       | 402 +++++++++++++++++
 tools/lib/api/fs/fs.c                              |  44 +-
 tools/lib/api/fs/fs.h                              |   2 +
 tools/lib/symbol/kallsyms.c                        |   4 +
 tools/perf/Documentation/perf-annotate.txt         |   6 +-
 tools/perf/Documentation/perf-kmem.txt             |   6 +-
 tools/perf/Documentation/perf-mem.txt              |   4 +
 tools/perf/Documentation/perf-report.txt           |   5 +-
 tools/perf/Documentation/perf-script.txt           |   3 +
 tools/perf/Documentation/perf-stat.txt             |  10 +
 tools/perf/Makefile.config                         |   2 +
 tools/perf/arch/arm/util/auxtrace.c                |   2 +-
 tools/perf/arch/arm/util/cs-etm.c                  |  51 ++-
 tools/perf/arch/powerpc/Makefile                   |  25 ++
 .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |  37 ++
 tools/perf/arch/s390/annotate/instructions.c       |  27 +-
 tools/perf/arch/s390/util/header.c                 | 148 ++++++-
 tools/perf/builtin-record.c                        |   2 +-
 tools/perf/builtin-report.c                        |   7 +-
 tools/perf/builtin-script.c                        |  17 +
 tools/perf/builtin-stat.c                          |  53 ++-
 tools/perf/check-headers.sh                        |   1 +
 tools/perf/tests/code-reading.c                    |  33 +-
 tools/perf/tests/dwarf-unwind.c                    |  46 +-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh    |   2 +-
 .../perf/tests/shell/trace+probe_libc_inet_pton.sh |   6 +-
 tools/perf/tests/vmlinux-kallsyms.c                |   4 +-
 tools/perf/ui/browsers/annotate.c                  |   9 +-
 tools/perf/util/build-id.c                         |  10 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  74 +++-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |   2 +
 tools/perf/util/cs-etm.c                           | 478 ++++++++++++++++++---
 tools/perf/util/event.c                            |  16 +-
 tools/perf/util/evlist.c                           |  21 +-
 tools/perf/util/header.h                           |   1 +
 tools/perf/util/hist.c                             |   4 +-
 tools/perf/util/hist.h                             |   1 -
 tools/perf/util/machine.c                          | 145 +++----
 tools/perf/util/machine.h                          |   6 +-
 tools/perf/util/pmu.c                              |  47 +-
 tools/perf/util/sort.c                             |   7 +-
 tools/perf/util/stat.h                             |   2 +
 tools/perf/util/symbol.c                           |  13 +-
 tools/perf/util/syscalltbl.c                       |   8 +
 tools/perf/util/thread_map.c                       |   4 +-
 tools/perf/util/thread_map.h                       |   2 +-
 47 files changed, 1577 insertions(+), 273 deletions(-)
 create mode 100644 tools/arch/powerpc/include/uapi/asm/unistd.h
 create mode 100755 tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl

Test results:

The first ones are container (docker) based builds of tools/perf with and
without libelf support.  Where clang is available, it is also used to build
perf with/without libelf.

The objtool and samples/bpf/ builds are disabled now that I'm switching from
using the sources in a local volume to fetching them from a http server to
build it inside the container, to make it easier to build in a container cluster.
Those will come back later.

Several are cross builds, the ones with -x-ARCH and the android one, and those
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

  On a Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz

  # dm
   1 39.82 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 57.59 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 44.30 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 42.14 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 35.50 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-11)
   6 42.97 amazonlinux:2                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
   7 26.46 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   8 27.28 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   9 24.29 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  10 32.15 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  11 39.36 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  12 34.69 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  13 37.92 debian:8                      : Ok   gcc (Debian 4.9.2-10) 4.9.2
  14 62.13 debian:9                      : Ok   gcc (Debian 6.3.0-18) 6.3.0 20170516
  15 65.51 debian:experimental           : Ok   gcc (Debian 7.2.0-18) 7.2.0
  16 38.73 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  17 68.18 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  18 36.21 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.2.0-11) 7.2.0
  19 37.57 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  20 38.22 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  21 42.49 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  22 39.15 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  23 41.46 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24 41.12 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  25 34.92 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  26 78.28 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  27 84.02 fedora:26                     : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  28 95.42 fedora:27                     : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  29 78.89 fedora:rawhide                : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-4)
  30 57.48 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 6.4.0-r1 p1.3) 6.4.0
  31 41.18 mageia:5                      : Ok   gcc (GCC) 4.9.2
  32 42.27 mageia:6                      : Ok   gcc (Mageia 5.4.0-5.mga6) 5.4.0
  33 39.66 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  34 40.09 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  35 41.01 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  36 82.32 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.0
  37 31.70 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  38 38.39 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  39 30.49 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  40 36.44 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  41 32.13 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  42 58.58 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.6) 5.4.0 20160609
  43 31.52 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  44 31.06 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  45 31.61 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  46 31.93 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) 5.4.0 20160609
  47 33.02 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  48 30.94 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  49 63.24 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  50 63.34 ubuntu:17.04                  : Ok   gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  51 63.56 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3) 7.2.0
  52 63.45 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.2.0-18ubuntu2) 7.2.0

  # uname -a
  Linux jouet 4.15.0-rc9+ #7 SMP Mon Jan 22 18:16:36 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
  # perf test
   1: vmlinux symtab matches kallsyms                       : Ok
   2: Detect openat syscall event                           : Ok
   3: Detect openat syscall event on all cpus               : Ok
   4: Read samples using the mmap interface                 : Ok
   5: Test data source output                               : Ok
   6: Parse event definition strings                        : Ok
   7: Simple expression parser                              : Ok
   8: PERF_RECORD_* events & perf_sample fields             : Ok
   9: Parse perf pmu format                                 : Ok
  10: DSO data read                                         : Ok
  11: DSO data cache                                        : Ok
  12: DSO data reopen                                       : Ok
  13: Roundtrip evsel->name                                 : Ok
  14: Parse sched tracepoints fields                        : Ok
  15: syscalls:sys_enter_openat event fields                : Ok
  16: Setup struct perf_event_attr                          : Ok
  17: Match and link multiple hists                         : Ok
  18: 'import perf' in python                               : Ok
  19: Breakpoint overflow signal handler                    : Ok
  20: Breakpoint overflow sampling                          : Ok
  21: Number of exit events of a simple workload            : Ok
  22: Software clock events period values                   : Ok
  23: Object code reading                                   : Ok
  24: Sample parsing                                        : Ok
  25: Use a dummy software event to keep tracking           : Ok
  26: Parse with no sample_id_all bit set                   : Ok
  27: Filter hist entries                                   : Ok
  28: Lookup mmap thread                                    : Ok
  29: Share thread mg                                       : Ok
  30: Sort output of hist entries                           : Ok
  31: Cumulate child hist entries                           : Ok
  32: Track with sched_switch                               : Ok
  33: Filter fds with revents mask in a fdarray             : Ok
  34: Add fd to a fdarray, making it autogrow               : Ok
  35: kmod_path__parse                                      : Ok
  36: Thread map                                            : Ok
  37: LLVM search and compile                               :
  37.1: Basic BPF llvm compile                              : Ok
  37.2: kbuild searching                                    : Ok
  37.3: Compile source for BPF prologue generation          : Ok
  37.4: Compile source for BPF relocation                   : Ok
  38: Session topology                                      : Ok
  39: BPF filter                                            :
  39.1: Basic BPF filtering                                 : Ok
  39.2: BPF pinning                                         : Ok
  39.3: BPF prologue generation                             : Ok
  39.4: BPF relocation checker                              : Ok
  40: Synthesize thread map                                 : Ok
  41: Remove thread map                                     : Ok
  42: Synthesize cpu map                                    : Ok
  43: Synthesize stat config                                : Ok
  44: Synthesize stat                                       : Ok
  45: Synthesize stat round                                 : Ok
  46: Synthesize attr update                                : Ok
  47: Event times                                           : Ok
  48: Read backward ring buffer                             : Ok
  49: Print cpu map                                         : Ok
  50: Probe SDT events                                      : Ok
  51: is_printable_array                                    : Ok
  52: Print bitmap                                          : Ok
  53: perf hooks                                            : Ok
  54: builtin clang support                                 : Skip (not compiled in)
  55: unit_number__scnprintf                                : Ok
  56: x86 rdpmc                                             : Ok
  57: Convert perf time to TSC                              : Ok
  58: DWARF unwind                                          : Ok
  59: x86 instruction decoder - new instructions            : Ok
  60: Use vfs_getname probe to get syscall args filenames   : Ok
  61: probe libc's inet_pton & backtrace it with ping       : Ok
  62: Check open filename arg using perf trace + vfs_getname: Ok
  63: Add vfs_getname probe to get syscall args filenames   : Ok
  # 
  
  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
           make_no_libunwind_O: make NO_LIBUNWIND=1
           make_no_backtrace_O: make NO_BACKTRACE=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                 make_static_O: make LDFLAGS=-static
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                make_install_O: make install
                    make_doc_O: make doc
                   make_pure_O: make
            make_no_libaudit_O: make NO_LIBAUDIT=1
               make_no_slang_O: make NO_SLANG=1
                make_no_gtk2_O: make NO_GTK2=1
            make_install_bin_O: make install-bin
             make_no_libperl_O: make NO_LIBPERL=1
            make_no_demangle_O: make NO_DEMANGLE=1
                   make_tags_O: make tags
            make_no_auxtrace_O: make NO_AUXTRACE=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
         make_install_prefix_O: make install prefix=/tmp/krava
                  make_debug_O: make DEBUG=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                make_no_newt_O: make NO_NEWT=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
  ^[[5~           make_no_libnuma_O: make NO_LIBNUMA=1
              make_no_libelf_O: make NO_LIBELF=1
                   make_help_O: make help
              make_no_libbpf_O: make NO_LIBBPF=1
           make_no_libpython_O: make NO_LIBPYTHON=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
              make_clean_all_O: make clean all
                 make_perf_o_O: make perf.o
             make_util_map_o_O: make util/map.o
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $ 
