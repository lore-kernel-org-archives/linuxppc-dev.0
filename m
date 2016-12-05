Return-Path: <BATV+4c94f64e688bd1b3d3b9+4852+infradead.org+acme@merlin.srs.infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXdRg1s1xzDw1g
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 08:38:39 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alexei Starovoitov <ast@fb.com>, Chris Riyder <chris.ryder@arm.com>,
 David Ahern <dsahern@gmail.com>, He Kuang <hekuang@huawei.com>,
 Jiri Olsa <jolsa@redhat.com>, Joe Stringer <joe@ovn.org>,
 Kim Phillips <kim.phillips@arm.com>, linuxppc-dev@lists.ozlabs.org,
 Markus Trippelsdorf <markus@trippelsdorf.de>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Peter Foley <pefoley2@pefoley.com>, Peter Zijlstra <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Taeung Song <treeze.taeung@gmail.com>, Wang Nan <wangnan0@huawei.com>,
 Zefan Li <lizefan@huawei.com>, pi3orama@163.com,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/20] perf/core improvements and fixes
Date: Mon,  5 Dec 2016 18:37:48 -0300
Message-Id: <20161205213808.6231-1-acme@kernel.org>
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

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit e7af7b15121ca08c31a0ab9df71a41b4c53365b4:

  Merge tag 'perf-core-for-mingo-20161201' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2016-12-02 10:08:03 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-20161205

for you to fetch changes up to bec60e50af83741cde1786ab475d4bf472aed6f9:

  perf annotate: Show raw form for jump instruction with indirect target (2016-12-05 17:21:57 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

Fixes:

- Do not show a bogus target address in 'perf annotate' for targetless powerpc
  jump instructions such as 'bctr' (Ravi Bangoria)

- tools/build fixes related to race conditions with the fixdep utility (Jiri Olsa)

- Fix building objtool with clang (Peter Foley)

Infrastructure:

- Support linking perf with clang and LLVM libraries, initially statically, but
  this limitation will be lifted and shared libraries, when available, will
  be preferred to the static build, that should, as with other features, be
  enabled explicitly (Wang Nan)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Jiri Olsa (7):
      tools build: Make fixdep parsing wait for last target
      tools build: Make the .cmd file more readable
      tools build: Move tabs to spaces where suitable
      perf tools: Move install-gtk target into rules area
      perf tools: Move python/perf.so target into rules area
      perf tools: Cleanup build directory before each test
      perf tools: Add non config targets

Peter Foley (1):
      tools build: Fix objtool build with clang

Ravi Bangoria (1):
      perf annotate: Show raw form for jump instruction with indirect target

Wang Nan (11):
      perf tools: Pass context to perf hook functions
      perf llvm: Extract helpers in llvm-utils.c
      tools build: Add feature detection for LLVM
      tools build: Add feature detection for clang
      perf build: Add clang and llvm compile and linking support
      perf clang: Add builtin clang support ant test case
      perf clang: Use real file system for #include
      perf clang: Allow passing CFLAGS to builtin clang
      perf clang: Update test case to use real BPF script
      perf clang: Support compile IR to BPF object and add testcase
      perf clang: Compile BPF script using builtin clang support

 tools/build/Build.include          |  20 ++--
 tools/build/Makefile.feature       | 138 +++++++++++++-------------
 tools/build/feature/Makefile       | 120 +++++++++++++----------
 tools/build/feature/test-clang.cpp |  21 ++++
 tools/build/feature/test-llvm.cpp  |   8 ++
 tools/build/fixdep.c               |   5 +-
 tools/perf/Makefile.config         |  62 +++++++++---
 tools/perf/Makefile.perf           |  56 +++++++----
 tools/perf/tests/Build             |   1 +
 tools/perf/tests/builtin-test.c    |   9 ++
 tools/perf/tests/clang.c           |  46 +++++++++
 tools/perf/tests/llvm.h            |   7 ++
 tools/perf/tests/make              |   4 +-
 tools/perf/tests/perf-hooks.c      |  14 ++-
 tools/perf/tests/tests.h           |   3 +
 tools/perf/util/Build              |   2 +
 tools/perf/util/annotate.c         |   3 +
 tools/perf/util/bpf-loader.c       |  19 +++-
 tools/perf/util/c++/Build          |   2 +
 tools/perf/util/c++/clang-c.h      |  43 ++++++++
 tools/perf/util/c++/clang-test.cpp |  62 ++++++++++++
 tools/perf/util/c++/clang.cpp      | 195 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/c++/clang.h        |  26 +++++
 tools/perf/util/llvm-utils.c       |  76 +++++++++++----
 tools/perf/util/llvm-utils.h       |   6 ++
 tools/perf/util/perf-hooks.c       |  10 +-
 tools/perf/util/perf-hooks.h       |   6 +-
 tools/perf/util/util-cxx.h         |  26 +++++
 28 files changed, 795 insertions(+), 195 deletions(-)
 create mode 100644 tools/build/feature/test-clang.cpp
 create mode 100644 tools/build/feature/test-llvm.cpp
 create mode 100644 tools/perf/tests/clang.c
 create mode 100644 tools/perf/util/c++/Build
 create mode 100644 tools/perf/util/c++/clang-c.h
 create mode 100644 tools/perf/util/c++/clang-test.cpp
 create mode 100644 tools/perf/util/c++/clang.cpp
 create mode 100644 tools/perf/util/c++/clang.h
 create mode 100644 tools/perf/util/util-cxx.h

  # uname -a
  Linux jouet 4.8.8-300.fc25.x86_64 #1 SMP Tue Nov 15 18:10:06 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
  # perf test
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
  37.2: BPF prologue generation                  : Ok
  37.3: BPF relocation checker                   : Ok
  38: Synthesize thread map                      : Ok
  39: Synthesize cpu map                         : Ok
  40: Synthesize stat config                     : Ok
  41: Synthesize stat                            : Ok
  42: Synthesize stat round                      : Ok
  43: Synthesize attr update                     : Ok
  44: Event times                                : Ok
  45: Read backward ring buffer                  : Ok
  46: Print cpu map                              : Ok
  47: Probe SDT events                           : Ok
  48: is_printable_array                         : Ok
  49: Print bitmap                               : Ok
  50: perf hooks                                 : Ok
  51: builtin clang support                      : Skip (not compiled in)
  52: x86 rdpmc                                  : Ok
  53: Convert perf time to TSC                   : Ok
  54: DWARF unwind                               : Ok
  55: x86 instruction decoder - new instructions : Ok
  56: Intel cqm nmi context read                 : Skip
  # 
  # time dm
   1 alpine:3.4: Ok
   2 android-ndk:r12b-arm: Ok
   3 archlinux:latest: Ok
   4 centos:5: Ok
   5 centos:6: Ok
   6 centos:7: Ok
   7 debian:7: Ok
   8 debian:8: Ok
   9 debian:experimental: Ok
  10 fedora:20: Ok
  11 fedora:21: Ok
  12 fedora:22: Ok
  13 fedora:23: Ok
  14 fedora:24: Ok
  15 fedora:24-x-ARC-uClibc: Ok
  16 fedora:25: Ok
  17 fedora:rawhide: Ok
  18 mageia:5: Ok
  19 opensuse:13.2: Ok
  20 opensuse:42.1: Ok
  21 opensuse:tumbleweed: Ok
  22 ubuntu:12.04.5: Ok
  23 ubuntu:14.04.4-x-linaro-arm64: Ok
  24 ubuntu:16.04: Ok
  25 ubuntu:16.04-x-arm: Ok
  26 ubuntu:16.04-x-arm64: Ok
  27 ubuntu:16.04-x-powerpc: Ok
  28 ubuntu:16.04-x-powerpc64: Ok
  29 ubuntu:16.04-x-powerpc64el: Ok
  30 ubuntu:16.04-x-s390: Ok
  31 ubuntu:16.10: Ok
  #
  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/linux/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
           make_no_backtrace_O: make NO_BACKTRACE=1
                make_no_gtk2_O: make NO_GTK2=1
                 make_static_O: make LDFLAGS=-static
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                 make_perf_o_O: make perf.o
               make_no_slang_O: make NO_SLANG=1
         make_install_prefix_O: make install prefix=/tmp/krava
           make_no_libpython_O: make NO_LIBPYTHON=1
                make_no_newt_O: make NO_NEWT=1
                  make_debug_O: make DEBUG=1
                   make_tags_O: make tags
           make_no_libbionic_O: make NO_LIBBIONIC=1
                   make_help_O: make help
                make_install_O: make install
           make_no_libunwind_O: make NO_LIBUNWIND=1
                   make_pure_O: make
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
             make_no_libperl_O: make NO_LIBPERL=1
              make_no_libbpf_O: make NO_LIBBPF=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                    make_doc_O: make doc
            make_no_libaudit_O: make NO_LIBAUDIT=1
              make_clean_all_O: make clean all
        make_with_babeltrace_O: make LIBBABELTRACE=1
             make_no_libnuma_O: make NO_LIBNUMA=1
             make_util_map_o_O: make util/map.o
            make_install_bin_O: make install-bin
            make_no_demangle_O: make NO_DEMANGLE=1
              make_no_libelf_O: make NO_LIBELF=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
         make_with_clangllvm_O: make LIBCLANGLLVM=1
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
  $
