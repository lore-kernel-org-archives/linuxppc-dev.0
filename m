Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWLct6xvYzDqh4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 02:27:58 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>,
 Anton Blanchard <anton@au1.ibm.com>, David Ahern <dsahern@gmail.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 Jiri Olsa <jolsa@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Matt Fleming <matt.fleming@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Petlan <mpetlan@redhat.com>,
 Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Paul Clarke <pc@us.ibm.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>,
 Wang Nan <wangnan0@huawei.com>, Yao Jin <yao.jin@linux.intel.com>,
 Zvonko Kosic <zvonko.kosic@de.ibm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/19] perf/core improvements and fixes
Date: Mon, 14 Aug 2017 13:27:22 -0300
Message-Id: <20170814162741.6101-1-acme@kernel.org>
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


The following changes since commit 82119cbe8e1e32cc2a941393e59816e731681310:

  Merge tag 'perf-core-for-mingo-4.14-20170801' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-08-10 17:07:02 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.14-20170814

for you to fetch changes up to 8fc375d7d36c72b4c2d55f5c24be022a939295d4:

  perf test shell: Add uprobes + backtrace ping test (2017-08-11 16:18:49 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

Infrastructure:

- Do not consider empty files as valid srclines (Milian Wolff)

- Fix wrong size in perf_record_mmap for last kernel module,
  which resulted in erroneous symbol resolution in at least s390x (Thomas Richter)

- Add missing newline to expr parser error messages (Andi Kleen)

- Fix saved values rbtree lookup in 'perf stat' (Andi Kleen)

- Add support for shell based tests in 'perf test', add a few that
  run 'perf probe', 'perf trace', using kprobes, uprobes to check
  the output of those tools and the effects on the system, checking,
  for instance, DWARF backtraces from uprobes (Arnaldo Carvalho de Melo)

Arch specific:

- Add ppc64le to audit uname list in the python scripting support (Naveen N. Rao)

- Update POWER9 vendor events tables (Sukadev Bhattiprolu)

- Fix module symbol adjustment for s390x (Thomas Richter)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andi Kleen (2):
      perf stat: Fix saved values rbtree lookup
      perf tools: Add missing newline to expr parser error messages

Arnaldo Carvalho de Melo (10):
      perf test: Make 'list' subcommand match main 'perf test' numbering/matching
      perf test: Add 'struct test *' to the test functions
      perf test: Add infrastructure to run shell based tests
      perf test: Make 'list' use same filtering code as main 'perf test'
      perf test shell: Add 'probe_vfs_getname' shell test
      perf test shell: Install shell tests
      perf test shell: Move vfs_getname probe function to lib
      perf test shell: Add test using probe:vfs_getname and verifying results
      perf test shell: Add test using vfs_getname + 'perf trace'
      perf test shell: Add uprobes + backtrace ping test

Milian Wolff (2):
      perf util: Take elf_name as const string in dso__demangle_sym
      perf srcline: Do not consider empty files as valid srclines

Naveen N. Rao (1):
      perf scripting python: Add ppc64le to audit uname list

Sukadev Bhattiprolu (2):
      perf vendor events powerpc: remove suffix in mapfile
      perf vendor events powerpc: Update POWER9 events

Thomas Richter (2):
      perf record: Fix wrong size in perf_record_mmap for last kernel module
      perf report: Fix module symbol adjustment for s390x

 tools/perf/Makefile.perf                           |    6 +-
 tools/perf/arch/s390/util/sym-handling.c           |    7 +
 tools/perf/arch/x86/include/arch-tests.h           |   11 +-
 tools/perf/arch/x86/tests/insn-x86.c               |    2 +-
 tools/perf/arch/x86/tests/intel-cqm.c              |    2 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c       |    2 +-
 tools/perf/arch/x86/tests/rdpmc.c                  |    2 +-
 tools/perf/pmu-events/arch/powerpc/mapfile.csv     |   20 +-
 .../perf/pmu-events/arch/powerpc/power9/cache.json |  191 +-
 .../arch/powerpc/power9/floating-point.json        |   42 +-
 .../pmu-events/arch/powerpc/power9/frontend.json   |  517 ++--
 .../pmu-events/arch/powerpc/power9/marked.json     |  905 +++----
 .../pmu-events/arch/powerpc/power9/memory.json     |  178 +-
 .../perf/pmu-events/arch/powerpc/power9/other.json | 2768 ++++++++++++++++----
 .../pmu-events/arch/powerpc/power9/pipeline.json   |  779 +++---
 tools/perf/pmu-events/arch/powerpc/power9/pmc.json |  167 +-
 .../arch/powerpc/power9/translation.json           |  314 +--
 .../python/Perf-Trace-Util/lib/Perf/Trace/Util.py  |    1 +
 tools/perf/tests/attr.c                            |    2 +-
 tools/perf/tests/backward-ring-buffer.c            |    2 +-
 tools/perf/tests/bitmap.c                          |    2 +-
 tools/perf/tests/bp_signal.c                       |    2 +-
 tools/perf/tests/bp_signal_overflow.c              |    2 +-
 tools/perf/tests/bpf.c                             |    4 +-
 tools/perf/tests/builtin-test.c                    |  184 +-
 tools/perf/tests/clang.c                           |    4 +-
 tools/perf/tests/code-reading.c                    |    2 +-
 tools/perf/tests/cpumap.c                          |    4 +-
 tools/perf/tests/dso-data.c                        |    6 +-
 tools/perf/tests/dwarf-unwind.c                    |    2 +-
 tools/perf/tests/event-times.c                     |    2 +-
 tools/perf/tests/event_update.c                    |    2 +-
 tools/perf/tests/evsel-roundtrip-name.c            |    2 +-
 tools/perf/tests/evsel-tp-sched.c                  |    2 +-
 tools/perf/tests/expr.c                            |    2 +-
 tools/perf/tests/fdarray.c                         |    4 +-
 tools/perf/tests/hists_cumulate.c                  |    2 +-
 tools/perf/tests/hists_filter.c                    |    2 +-
 tools/perf/tests/hists_link.c                      |    2 +-
 tools/perf/tests/hists_output.c                    |    2 +-
 tools/perf/tests/is_printable_array.c              |    2 +-
 tools/perf/tests/keep-tracking.c                   |    2 +-
 tools/perf/tests/kmod-path.c                       |    2 +-
 tools/perf/tests/llvm.c                            |    2 +-
 tools/perf/tests/mmap-basic.c                      |    2 +-
 tools/perf/tests/mmap-thread-lookup.c              |    2 +-
 tools/perf/tests/openat-syscall-all-cpus.c         |    2 +-
 tools/perf/tests/openat-syscall-tp-fields.c        |    2 +-
 tools/perf/tests/openat-syscall.c                  |    2 +-
 tools/perf/tests/parse-events.c                    |    2 +-
 tools/perf/tests/parse-no-sample-id-all.c          |    2 +-
 tools/perf/tests/perf-hooks.c                      |    2 +-
 tools/perf/tests/perf-record.c                     |    2 +-
 tools/perf/tests/pmu.c                             |    2 +-
 tools/perf/tests/python-use.c                      |    2 +-
 tools/perf/tests/sample-parsing.c                  |    2 +-
 tools/perf/tests/sdt.c                             |    4 +-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh    |   28 +
 tools/perf/tests/shell/probe_vfs_getname.sh        |   10 +
 .../tests/shell/record+script_probe_vfs_getname.sh |   37 +
 .../perf/tests/shell/trace+probe_libc_inet_pton.sh |   40 +
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |   31 +
 tools/perf/tests/stat.c                            |    6 +-
 tools/perf/tests/sw-clock.c                        |    2 +-
 tools/perf/tests/switch-tracking.c                 |    2 +-
 tools/perf/tests/task-exit.c                       |    2 +-
 tools/perf/tests/tests.h                           |  113 +-
 tools/perf/tests/thread-map.c                      |    6 +-
 tools/perf/tests/thread-mg-share.c                 |    2 +-
 tools/perf/tests/topology.c                        |    2 +-
 tools/perf/tests/unit_number__scnprintf.c          |    2 +-
 tools/perf/tests/vmlinux-kallsyms.c                |    2 +-
 tools/perf/util/expr.y                             |    2 +-
 tools/perf/util/machine.c                          |    4 +-
 tools/perf/util/srcline.c                          |    6 +
 tools/perf/util/stat-shadow.c                      |    6 +-
 tools/perf/util/symbol-elf.c                       |   12 +-
 tools/perf/util/symbol-minimal.c                   |    2 +-
 tools/perf/util/symbol.c                           |   21 +-
 tools/perf/util/symbol.h                           |    7 +-
 80 files changed, 4054 insertions(+), 2479 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/probe_vfs_getname.sh
 create mode 100755 tools/perf/tests/shell/probe_vfs_getname.sh
 create mode 100755 tools/perf/tests/shell/record+script_probe_vfs_getname.sh
 create mode 100755 tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
 create mode 100755 tools/perf/tests/shell/trace+probe_vfs_getname.sh

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

  # dm
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
  31 opensuse:tumbleweed: Ok
  32 oraclelinux:6: Ok
  33 oraclelinux:7: Ok
  34 ubuntu:12.04.5: Ok
  35 ubuntu:14.04.4: Ok
  36 ubuntu:14.04.4-x-linaro-arm64: Ok
  37 ubuntu:15.10: Ok
  38 ubuntu:16.04: Ok
  39 ubuntu:16.04-x-arm: Ok
  40 ubuntu:16.04-x-arm64: Ok
  41 ubuntu:16.04-x-powerpc: Ok
  42 ubuntu:16.04-x-powerpc64: Ok
  43 ubuntu:16.04-x-powerpc64el: Ok
  44 ubuntu:16.04-x-s390: Ok
  45 ubuntu:16.10: Ok
  46 ubuntu:17.04: Ok
  47 ubuntu:17.10: Ok
  #
  # uname -a
  Linux jouet 4.13.0-rc4+ #2 SMP Fri Aug 11 12:39:09 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
  # perf test
   1: vmlinux symtab matches kallsyms                       : Ok
   2: Detect openat syscall event                           : Ok
   3: Detect openat syscall event on all cpus               : Ok
   4: Read samples using the mmap interface                 : Ok
   5: Parse event definition strings                        : Ok
   6: Simple expression parser                              : Ok
   7: PERF_RECORD_* events & perf_sample fields             : Ok
   8: Parse perf pmu format                                 : Ok
   9: DSO data read                                         : Ok
  10: DSO data cache                                        : Ok
  11: DSO data reopen                                       : Ok
  12: Roundtrip evsel->name                                 : Ok
  13: Parse sched tracepoints fields                        : Ok
  14: syscalls:sys_enter_openat event fields                : Ok
  15: Setup struct perf_event_attr                          : Ok
  16: Match and link multiple hists                         : Ok
  17: 'import perf' in python                               : Ok
  18: Breakpoint overflow signal handler                    : Ok
  19: Breakpoint overflow sampling                          : Ok
  20: Number of exit events of a simple workload            : Ok
  21: Software clock events period values                   : Ok
  22: Object code reading                                   : Ok
  23: Sample parsing                                        : Ok
  24: Use a dummy software event to keep tracking           : Ok
  25: Parse with no sample_id_all bit set                   : Ok
  26: Filter hist entries                                   : Ok
  27: Lookup mmap thread                                    : Ok
  28: Share thread mg                                       : Ok
  29: Sort output of hist entries                           : Ok
  30: Cumulate child hist entries                           : Ok
  31: Track with sched_switch                               : Ok
  32: Filter fds with revents mask in a fdarray             : Ok
  33: Add fd to a fdarray, making it autogrow               : Ok
  34: kmod_path__parse                                      : Ok
  35: Thread map                                            : Ok
  36: LLVM search and compile                               :
  36.1: Basic BPF llvm compile                              : Ok
  36.2: kbuild searching                                    : Ok
  36.3: Compile source for BPF prologue generation          : Ok
  36.4: Compile source for BPF relocation                   : Ok
  37: Session topology                                      : Ok
  38: BPF filter                                            :
  38.1: Basic BPF filtering                                 : Ok
  38.2: BPF pinning                                         : Ok
  38.3: BPF prologue generation                             : Ok
  38.4: BPF relocation checker                              : Ok
  39: Synthesize thread map                                 : Ok
  40: Remove thread map                                     : Ok
  41: Synthesize cpu map                                    : Ok
  42: Synthesize stat config                                : Ok
  43: Synthesize stat                                       : Ok
  44: Synthesize stat round                                 : Ok
  45: Synthesize attr update                                : Ok
  46: Event times                                           : Ok
  47: Read backward ring buffer                             : Ok
  48: Print cpu map                                         : Ok
  49: Probe SDT events                                      : Ok
  50: is_printable_array                                    : Ok
  51: Print bitmap                                          : Ok
  52: perf hooks                                            : Ok
  53: builtin clang support                                 : Skip (not compiled in)
  54: unit_number__scnprintf                                : Ok
  55: x86 rdpmc                                             : Ok
  56: Convert perf time to TSC                              : Ok
  57: DWARF unwind                                          : Ok
  58: x86 instruction decoder - new instructions            : Ok
  59: Intel cqm nmi context read                            : Skip
  60: Use vfs_getname probe to get syscall args filenames   : Ok
  61: probe libc's inet_pton & backtrace it with ping       : Ok
  62: Check open filename arg using perf trace + vfs_getname: Ok
  63: Add vfs_getname probe to get syscall args filenames   : Ok
  #

  # The static build test works on Fedora 25, is failing on Fedora 26,
  # this issue is being investigated.
  
  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/linux/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
               make_no_slang_O: make NO_SLANG=1
         make_install_prefix_O: make install prefix=/tmp/krava
            make_install_bin_O: make install-bin
                  make_debug_O: make DEBUG=1
              make_clean_all_O: make clean all
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
            make_no_auxtrace_O: make NO_AUXTRACE=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
           make_no_libpython_O: make NO_LIBPYTHON=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                   make_help_O: make help
            make_no_demangle_O: make NO_DEMANGLE=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                make_install_O: make install
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                make_no_newt_O: make NO_NEWT=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                 make_perf_o_O: make perf.o
                make_no_gtk2_O: make NO_GTK2=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
              make_no_libbpf_O: make NO_LIBBPF=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                   make_tags_O: make tags
             make_util_map_o_O: make util/map.o
                   make_pure_O: make
             make_no_libperl_O: make NO_LIBPERL=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
           make_no_backtrace_O: make NO_BACKTRACE=1
             make_no_libnuma_O: make NO_LIBNUMA=1
              make_no_libelf_O: make NO_LIBELF=1
                    make_doc_O: make doc
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
  $
