Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmBMb4H1LzDqZ8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 00:00:59 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Anton Blanchard <anton@au1.ibm.com>,
 Flavio Bruno Leitner <fbl@redhat.com>, Jack Henschel <jackdev@mailbox.org>,
 Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Taeung Song <treeze.taeung@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Wang Nan <wangnan0@huawei.com>,
 Yao Jin <yao.jin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/13] perf/core improvements and fixes
Date: Mon,  4 Sep 2017 11:00:31 -0300
Message-Id: <20170904140044.22912-1-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 1b2f76d77a277bb70d38ad0991ed7f16bbc115a9:

  Merge tag 'perf-core-for-mingo-4.14-20170829' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-08-29 23:13:56 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.14-20170901

for you to fetch changes up to eba9fac017617e685d648339e29a1453a30cb065:

  perf annotate browser: Help for cycling thru hottest instructions with TAB/shift+TAB (2017-09-01 14:55:40 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Support syscall name glob matching in 'perf trace' (Arnaldo Carvalho de Melo)

  e.g.:

   # perf trace -e pkey_*
   32.784 (0.006 ms): pkey/16018 pkey_alloc(init_val: DISABLE_WRITE) = -1 EINVAL Invalid argument
   32.795 (0.004 ms): pkey/16018 pkey_mprotect(start: 0x7f380d0a6000, len: 4096, prot: READ|WRITE, pkey: -1) = 0
   32.801 (0.002 ms): pkey/16018 pkey_free(pkey: -1                ) = -1 EINVAL Invalid argument
   ^C#

- Do not auto merge counts for explicitely specified events in
  'perf stat' (Arnaldo Carvalho de Melo)

- Fix syntax in documentation of .perfconfig intel-pt option (Jack Henschel)

- Calculate the average cycles of iterations for loops detected by the
  branch history support in 'perf report' (Jin Yao)

- Support PERF_SAMPLE_PHYS_ADDR as a sort key "phys_daddr" in the 'script', 'mem',
  'top' and 'report'. Also add a test entry for it in 'perf test' (Kan Liang)

- Fix 'Object code reading' 'perf test' entry in PowerPC (Ravi Bangoria)

- Remove some duplicate Power9 duplicate vendor events (described in JSON
  files) (Sukadev Bhattiprolu)

- Add help entry in the TUI annotate browser about cycling thru hottest
  instructions with TAB/shift+TAB (Arnaldo Carvalho de Melo)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (4):
      perf syscalltbl: Support glob matching on syscall names
      perf trace: Support syscall name globbing
      perf stat: Only auto-merge events that are PMU aliases
      perf annotate browser: Help for cycling thru hottest instructions with TAB/shift+TAB

Jack Henschel (1):
      perf intel-pt: Fix syntax in documentation of config option

Jin Yao (1):
      perf report: Calculate the average cycles of iterations

Kan Liang (5):
      perf tools: Support new sample type for physical address
      perf sort: Add sort option for physical address
      perf mem: Support physical address
      perf script: Support physical address
      perf test: Add test case for PERF_SAMPLE_PHYS_ADDR

Ravi Bangoria (1):
      perf test powerpc: Fix 'Object code reading' test

Sukadev Bhattiprolu (1):
      perf vendor events powerpc: Remove duplicate events

 tools/include/uapi/linux/perf_event.h              |   4 +-
 tools/perf/Documentation/intel-pt.txt              |   2 +-
 tools/perf/Documentation/perf-mem.txt              |   4 +
 tools/perf/Documentation/perf-record.txt           |   5 +-
 tools/perf/Documentation/perf-report.txt           |   1 +
 tools/perf/Documentation/perf-script.txt           |   2 +-
 tools/perf/Documentation/perf-trace.txt            |   2 +-
 tools/perf/builtin-mem.c                           |  97 ++++++++++++-----
 tools/perf/builtin-record.c                        |   2 +
 tools/perf/builtin-script.c                        |  15 ++-
 tools/perf/builtin-stat.c                          |   2 +-
 tools/perf/builtin-trace.c                         |  39 ++++++-
 tools/perf/perf.h                                  |   1 +
 .../pmu-events/arch/powerpc/power9/frontend.json   |   7 +-
 .../perf/pmu-events/arch/powerpc/power9/other.json | 120 ---------------------
 .../pmu-events/arch/powerpc/power9/pipeline.json   |   7 +-
 tools/perf/pmu-events/arch/powerpc/power9/pmc.json |   7 +-
 tools/perf/tests/code-reading.c                    |   5 +
 tools/perf/tests/sample-parsing.c                  |   6 +-
 tools/perf/ui/browsers/annotate.c                  |   3 +-
 tools/perf/ui/browsers/hists.c                     |   8 +-
 tools/perf/ui/stdio/hist.c                         |  10 +-
 tools/perf/util/callchain.c                        |  49 ++++-----
 tools/perf/util/callchain.h                        |   9 +-
 tools/perf/util/event.h                            |   1 +
 tools/perf/util/evsel.c                            |  19 +++-
 tools/perf/util/evsel.h                            |   1 +
 tools/perf/util/hist.c                             |   4 +
 tools/perf/util/hist.h                             |   1 +
 tools/perf/util/machine.c                          |  96 ++++++++++-------
 tools/perf/util/parse-events.c                     |  24 +++--
 tools/perf/util/session.c                          |   3 +
 tools/perf/util/sort.c                             |  42 ++++++++
 tools/perf/util/sort.h                             |   1 +
 tools/perf/util/symbol.h                           |   1 +
 tools/perf/util/syscalltbl.c                       |  33 ++++++
 tools/perf/util/syscalltbl.h                       |   3 +
 37 files changed, 368 insertions(+), 268 deletions(-)

Test results:

The first ones are container (docker) based builds of tools/perf with and
without libelf support, objtool where it is supported and samples/bpf/, ditto.
Where clang is available, it is also used to build perf with/without libelf.

Several are cross builds, the ones with -x-ARCH, and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf
commands with a variety of command line event specifications to then
intercept the sys_perf_event syscall to check that the perf_event_attr
fields are set up as expected, among a variety of other unit tests.

The 'perf test'  also runs shell scripts exercising the tools, checking
if they affect the system in certain ways, like setting up kprobes and
uprobes, request callchains for well known programs and check that they
are the expected ones, see if 'perf trace' beautifies system call
arguments correctly, etc.

Additionally, a new set of tests, script based, runs the tools in a live system,
setting probes in place that then gets used by 'perf trace', with its output
compared against expected results.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one. It is planned to have it run on each
of the containers mentioned above, using some container orchestration
infrastructure. Get in contact if interested in helping having this in place.

# time dm
   1 alpine:3.4: Ok
   2 alpine:3.5: Ok
   3 alpine:3.6: Ok
   4 alpine:edge: Ok
   5 android-ndk:r12b-arm: Ok
   6 archlinux:latest: Ok
   7 centos:5: Ok
   8 centos:6: Ok
   9 centos:7: Ok
  10 debian:7: Ok
  11 debian:8: Ok
  12 debian:9: Ok
  13 debian:experimental: Ok
  14 debian:experimental-x-arm64: Ok
  15 debian:experimental-x-mips: Ok
  16 debian:experimental-x-mips64: Ok
  17 debian:experimental-x-mipsel: Ok
  18 fedora:20: Ok
  19 fedora:21: Ok
  20 fedora:22: Ok
  21 fedora:23: Ok
  22 fedora:24: Ok
  23 fedora:24-x-ARC-uClibc: Ok
  24 fedora:25: Ok
  25 fedora:26: Ok
  26 fedora:rawhide: Ok
  27 mageia:5: Ok
  28 opensuse:13.2: Ok
  29 opensuse:42.1: Ok
  30 opensuse:42.2: Ok
  31 opensuse:42.3: Ok
  32 opensuse:tumbleweed: Ok
  33 oraclelinux:6: Ok
  34 oraclelinux:7: Ok
  35 ubuntu:12.04.5: Ok
  36 ubuntu:14.04.4: Ok
  37 ubuntu:14.04.4-x-linaro-arm64: Ok
  38 ubuntu:15.10: Ok
  39 ubuntu:16.04: Ok
  40 ubuntu:16.04-x-arm: Ok
  41 ubuntu:16.04-x-arm64: Ok
  42 ubuntu:16.04-x-powerpc: Ok
  43 ubuntu:16.04-x-powerpc64: Ok
  44 ubuntu:16.04-x-powerpc64el: Ok
  45 ubuntu:16.04-x-s390: Ok
  46 ubuntu:16.10: Ok
  47 ubuntu:17.04: Ok
  48 ubuntu:17.10: Ok
  #

  # uname -a
  Linux jouet 4.13.0-rc4+ #2 SMP Fri Aug 11 12:39:09 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
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
  60: Intel cqm nmi context read                            : Skip
  61: Use vfs_getname probe to get syscall args filenames   : Ok
  62: probe libc's inet_pton & backtrace it with ping       : Ok
  63: Check open filename arg using perf trace + vfs_getname: Ok
  64: Add vfs_getname probe to get syscall args filenames   : Ok
  #

  $ time make -C tools/perf build-test
  make: Entering directory '/home/acme/git/linux/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
           make_no_libbionic_O: make NO_LIBBIONIC=1
                  make_debug_O: make DEBUG=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
             make_no_libperl_O: make NO_LIBPERL=1
                   make_help_O: make help
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
            make_no_demangle_O: make NO_DEMANGLE=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                   make_tags_O: make tags
                make_no_newt_O: make NO_NEWT=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
           make_no_libpython_O: make NO_LIBPYTHON=1
                make_no_gtk2_O: make NO_GTK2=1
             make_util_map_o_O: make util/map.o
                 make_perf_o_O: make perf.o
                    make_doc_O: make doc
                 make_static_O: make LDFLAGS=-static
           make_no_libunwind_O: make NO_LIBUNWIND=1
             make_no_libnuma_O: make NO_LIBNUMA=1
            make_install_bin_O: make install-bin
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                   make_pure_O: make
         make_with_clangllvm_O: make LIBCLANGLLVM=1
              make_no_libelf_O: make NO_LIBELF=1
              make_no_libbpf_O: make NO_LIBBPF=1
           make_no_backtrace_O: make NO_BACKTRACE=1
         make_install_prefix_O: make install prefix=/tmp/krava
                make_install_O: make install
              make_clean_all_O: make clean all
               make_no_slang_O: make NO_SLANG=1
  OK
  $
