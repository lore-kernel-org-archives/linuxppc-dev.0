Return-Path: <BATV+f2ecf1341dfe0364f26e+4785+infradead.org+acme@merlin.srs.infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slHG36CpKzDskS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 00:36:59 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux Weekly News <lwn@lwn.net>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Chong Jiang <chongjiang@chromium.org>,
 Clark Williams <williams@redhat.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Matt Fleming <matt.fleming@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, pi3orama@163.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Simon Que <sque@chromium.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, Wang Nan <wangnan0@huawei.com>,
 Zefan Li <lizefan@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/27] perf/core improvements and fixes
Date: Thu, 29 Sep 2016 11:35:29 -0300
Message-Id: <1475159756-21326-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ingo,

	Please consider pulling, more to come soon,

- Arnaldo

Build and test results at the end of this message.

The following changes since commit 6b652de2b27c0a4020ce0e8f277e782b6af76096:

  Merge tag 'perf-core-for-mingo-20160922' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2016-09-23 07:21:38 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-20160929

for you to fetch changes up to d18019a53a07e009899ff6b8dc5ec30f249360d9:

  perf tests: Add dwarf unwind test for powerpc (2016-09-29 11:18:21 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

User visible:
-------------

New features:

- Add support for using symbols in address filters with Intel PT and ARM
  CoreSight (hardware assisted tracing facilities) (Adrian Hunter, Mathieu Poirier)

Fixes:

- Fix MMAP event synthesis for pre-existing threads when no hugetlbfs
  mount is in place (Adrian Hunter)

- Don't ignore kernel idle symbols in 'perf script' (Adrian Hunter)

- Assorted Intel PT fixes (Adrian Hunter)

Improvements:

- Fix handling of C++ symbols in 'perf probe' (Masami Hiramatsu)

- Beautify sched_[gs]et_attr return value in 'perf trace' (Arnaldo Carvalho de Melo)

Infrastructure:
---------------

New features:

- Add dwarf unwind 'perf test' for powerpc (Ravi Bangoria)

Fixes:

- Fix error paths in 'perf record' (Adrian Hunter)

Documentation:

- Update documentation info about quipper, a C++ parser for converting
  to/from perf.data/chromium profiling format (Simon Que)

Build Fixes:

  Fix building in 32 bit platform with libbabeltrace (Wang Nan)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (16):
      perf record: Fix documentation 'event_sources' -> 'event_source'
      perf tools: Fix MMAP event synthesis broken by MAP_HUGETLB change
      perf script: Fix vanished idle symbols
      perf record: Rename label 'out_symbol_exit'
      perf record: Fix error paths
      perf symbols: Add dso__last_symbol()
      perf record: Add support for using symbols in address filters
      perf probe: Increase debug level of SDT debug messages
      perf intel-pt: Fix snapshot overlap detection decoder errors
      perf intel-pt: Add support for recording the max non-turbo ratio
      perf intel-pt: Fix missing error codes processing auxtrace_info
      perf intel-pt: Add a helper function for processing AUXTRACE_INFO
      perf intel-pt: Record address filter in AUXTRACE_INFO event
      perf intel-pt: Read address filter from AUXTRACE_INFO event
      perf intel-pt: Enable decoder to handle TIP.PGD with missing IP
      perf intel-pt: Fix decoding when there are address filters

Arnaldo Carvalho de Melo (1):
      perf trace: Beautify sched_[gs]et_attr return value

Masami Hiramatsu (4):
      perf probe: Ignore the error of finding inline instance
      perf probe: Skip if the function address is 0
      perf probe: Fix to cut off incompatible chars from group name
      perf probe: Match linkage name with mangled name

Mathieu Poirier (3):
      perf tools: Make perf_evsel__append_filter() generic
      perf evsel: New tracepoint specific function
      perf evsel: Add support for address filters

Ravi Bangoria (1):
      perf tests: Add dwarf unwind test for powerpc

Simon Que (1):
      perf tools: Update documentation info about quipper

Wang Nan (1):
      perf data: Fix building in 32 bit platform with libbabeltrace

 tools/perf/Documentation/perf-record.txt           |  61 +-
 tools/perf/Documentation/perf.data-file-format.txt |   6 +-
 tools/perf/arch/powerpc/Build                      |   1 +
 tools/perf/arch/powerpc/include/arch-tests.h       |  13 +
 tools/perf/arch/powerpc/include/perf_regs.h        |   2 +
 tools/perf/arch/powerpc/tests/Build                |   4 +
 tools/perf/arch/powerpc/tests/arch-tests.c         |  15 +
 tools/perf/arch/powerpc/tests/dwarf-unwind.c       |  62 ++
 tools/perf/arch/powerpc/tests/regs_load.S          |  94 +++
 tools/perf/arch/x86/util/intel-pt.c                |  57 +-
 tools/perf/builtin-record.c                        |  32 +-
 tools/perf/builtin-trace.c                         |  10 +-
 tools/perf/tests/Build                             |   2 +-
 tools/perf/tests/dwarf-unwind.c                    |   2 +-
 tools/perf/util/auxtrace.c                         | 737 +++++++++++++++++++++
 tools/perf/util/auxtrace.h                         |  54 ++
 tools/perf/util/build-id.c                         |   4 +-
 tools/perf/util/data-convert-bt.c                  |   2 +-
 tools/perf/util/dwarf-aux.c                        |  28 +-
 tools/perf/util/dwarf-aux.h                        |   3 +
 tools/perf/util/event.c                            |   3 +-
 tools/perf/util/evsel.c                            |  16 +-
 tools/perf/util/evsel.h                            |   5 +-
 tools/perf/util/evsel_fprintf.c                    |   7 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  30 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   1 +
 tools/perf/util/intel-pt.c                         | 172 ++++-
 tools/perf/util/intel-pt.h                         |   4 +-
 tools/perf/util/parse-events.c                     |  41 +-
 tools/perf/util/probe-event.c                      |  10 +-
 tools/perf/util/probe-file.c                       |   2 +-
 tools/perf/util/probe-finder.c                     |  17 +-
 tools/perf/util/symbol.c                           |  15 +
 tools/perf/util/symbol.h                           |   1 +
 34 files changed, 1451 insertions(+), 62 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/include/arch-tests.h
 create mode 100644 tools/perf/arch/powerpc/tests/Build
 create mode 100644 tools/perf/arch/powerpc/tests/arch-tests.c
 create mode 100644 tools/perf/arch/powerpc/tests/dwarf-unwind.c
 create mode 100644 tools/perf/arch/powerpc/tests/regs_load.S

  # time dm
   1  alpine:3.4: Ok
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
  16 fedora:rawhide: Ok
  17 mageia:5: Ok
  18 opensuse:13.2: Ok
  19 opensuse:42.1: Ok
  20 opensuse:tumbleweed: Ok
  21 ubuntu:12.04.5: Ok
  22 ubuntu:14.04: Ok
  23 ubuntu:14.04.4: Ok
  24 ubuntu:15.10: Ok
  25 ubuntu:16.04: Ok
  26 ubuntu:16.04-x-arm: Ok
  27 ubuntu:16.04-x-arm64: Ok
  28 ubuntu:16.04-x-powerpc: Ok
  29 ubuntu:16.04-x-powerpc64: Ok
  30 ubuntu:16.04-x-powerpc64el: Ok
  31 ubuntu:16.04-x-s390: Ok
  32 ubuntu:16.10: Ok
  33 2246.21

  real	37m26.862s
  user	0m2.148s
  sys	0m2.256s
  # 

  # perf test
   1: vmlinux symtab matches kallsyms                          : Ok
   2: detect openat syscall event                              : Ok
   3: detect openat syscall event on all cpus                  : Ok
   4: read samples using the mmap interface                    : Ok
   5: parse events tests                                       : Ok
   6: Validate PERF_RECORD_* events & perf_sample fields       : Ok
   7: Test perf pmu format parsing                             : Ok
   8: Test dso data read                                       : Ok
   9: Test dso data cache                                      : Ok
  10: Test dso data reopen                                     : Ok
  11: roundtrip evsel->name check                              : Ok
  12: Check parsing of sched tracepoints fields                : Ok
  13: Generate and check syscalls:sys_enter_openat event fields: Ok
  14: struct perf_event_attr setup                             : Ok
  15: Test matching and linking multiple hists                 : Ok
  16: Try 'import perf' in python, checking link problems      : Ok
  17: Test breakpoint overflow signal handler                  : Ok
  18: Test breakpoint overflow sampling                        : Ok
  19: Test number of exit event of a simple workload           : Ok
  20: Test software clock events have valid period values      : Ok
  21: Test object code reading                                 : Ok
  22: Test sample parsing                                      : Ok
  23: Test using a dummy software event to keep tracking       : Ok
  24: Test parsing with no sample_id_all bit set               : Ok
  25: Test filtering hist entries                              : Ok
  26: Test mmap thread lookup                                  : Ok
  27: Test thread mg sharing                                   : Ok
  28: Test output sorting of hist entries                      : Ok
  29: Test cumulation of child hist entries                    : Ok
  30: Test tracking with sched_switch                          : Ok
  31: Filter fds with revents mask in a fdarray                : Ok
  32: Add fd to a fdarray, making it autogrow                  : Ok
  33: Test kmod_path__parse function                           : Ok
  34: Test thread map                                          : Ok
  35: Test LLVM searching and compiling                        :
  35.1: Basic BPF llvm compiling test                          : Ok
  35.2: Test kbuild searching                                  : Ok
  35.3: Compile source for BPF prologue generation test        : Ok
  35.4: Compile source for BPF relocation test                 : Ok
  36: Test topology in session                                 : Ok
  37: Test BPF filter                                          :
  37.1: Test basic BPF filtering                               : Ok
  37.2: Test BPF prologue generation                           : Ok
  37.3: Test BPF relocation checker                            : Ok
  38: Test thread map synthesize                               : Ok
  39: Test cpu map synthesize                                  : Ok
  40: Test stat config synthesize                              : Ok
  41: Test stat synthesize                                     : Ok
  42: Test stat round synthesize                               : Ok
  43: Test attr update synthesize                              : Ok
  44: Test events times                                        : Ok
  45: Test backward reading from ring buffer                   : Ok
  46: Test cpu map print                                       : Ok
  47: Test SDT event probing                                   : Ok
  48: Test is_printable_array function                         : Ok
  49: Test bitmap print                                        : Ok
  50: x86 rdpmc test                                           : Ok
  51: Test converting perf time to TSC                         : Ok
  52: Test dwarf unwind                                        : Ok
  53: Test x86 instruction decoder - new instructions          : Ok
  54: Test intel cqm nmi context read                          : Skip
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/linux/tools/perf'
                        tarpkg: ./tests/perf-targz-src-pkg .
                  make_debug_O: make DEBUG=1
             make_no_libnuma_O: make NO_LIBNUMA=1
               make_no_slang_O: make NO_SLANG=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
              make_no_libbpf_O: make NO_LIBBPF=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                   make_tags_O: make tags
                    make_doc_O: make doc
           make_no_libunwind_O: make NO_LIBUNWIND=1
            make_install_bin_O: make install-bin
           make_no_libbionic_O: make NO_LIBBIONIC=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
            make_no_demangle_O: make NO_DEMANGLE=1
                 make_perf_o_O: make perf.o
            make_no_auxtrace_O: make NO_AUXTRACE=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                   make_pure_O: make
             make_util_map_o_O: make util/map.o
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                make_no_newt_O: make NO_NEWT=1
           make_no_libpython_O: make NO_LIBPYTHON=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                   make_help_O: make help
         make_install_prefix_O: make install prefix=/tmp/krava
                 make_static_O: make LDFLAGS=-static
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
           make_no_backtrace_O: make NO_BACKTRACE=1
              make_clean_all_O: make clean all
                make_install_O: make install
              make_no_libelf_O: make NO_LIBELF=1
             make_no_libperl_O: make NO_LIBPERL=1
                make_no_gtk2_O: make NO_GTK2=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
  $
