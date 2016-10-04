Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spBN80bYqzDrM2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 19:07:20 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id p138so18335905wmb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Oct 2016 01:07:19 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 4 Oct 2016 10:07:12 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux Weekly News <lwn@lwn.net>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Colin Ian King <colin.king@canonical.com>,
 David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/22] perf/core improvements and fixes
Message-ID: <20161004080712.GA6124@gmail.com>
References: <1475548641-12182-1-git-send-email-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475548641-12182-1-git-send-email-acme@kernel.org>
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
> Build and test stats at the end of the message.
> 
> The following changes since commit 41aad2a6d4fcdda8d73c9739daf7a9f3f49499d6:
> 
>   Merge tag 'perf-core-for-mingo-20160929' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2016-09-29 19:09:58 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-20161003
> 
> for you to fetch changes up to b42c7369e3f451e22c2b0be5d193955498d37546:
> 
>   perf pmu-events: Add Skylake frontend MSR support (2016-10-03 21:52:01 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Allow vendors to provide JSON files describing PMU events, that then
>   get parsed to generate C tables that are linked against perf, allowing
>   the use of the names in their documentations, such as:
> 
>   # perf list l1d
> 
>   List of pre-defined events (to be used in -e):
> 
>   Cache:
>     l1d.replacement
>          [L1D data line replacements]
>     l1d_pend_miss.fb_full
>          [Cycles a demand request was blocked due to Fill Buffers inavailability]
>     l1d_pend_miss.pending
>          [L1D miss oustandings duration in cycles]
>     l1d_pend_miss.pending_cycles
>          [Cycles with L1D load Misses outstanding]
>     l1d_pend_miss.pending_cycles_any
>          [Cycles with L1D load Misses outstanding from any thread on physical core]
>     l2_trans.l1d_wb
>          [L1D writebacks that access L2 cache]
> 
>   Pipeline:
>     cycle_activity.cycles_l1d_miss
>          [Cycles while L1 cache miss demand load is outstanding]
>     cycle_activity.cycles_l1d_pending
>          [Cycles while L1 cache miss demand load is outstanding]
>     cycle_activity.stalls_l1d_miss
>          [Execution stalls while L1 cache miss demand load is outstanding]
>     cycle_activity.stalls_l1d_pending
>          [Execution stalls while L1 cache miss demand load is outstanding]
> 
>   The above example was done on a Broadwell based ThinkPad t450s after
>   downloading and installing such JSON files which will be added to the
>   tools/perf/pmu-events/ directory in a subsequent patchkit.
> 
>   Now one can use those names with -e/--event in all 'perf tools'.
>   (Andi Kleen, Sukadev Bhattiprolu)
> 
> - Add a missing pointer dereference in 'perf probe' (Colin Ian King)
> 
> - Add support for building host programs to be used in generating files
>   to be used in the build process, such as fixdep and jevents, fixing
>   the usage of these features in a cross compilation setup (Jiri Olsa)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (12):
>       perf tools: Add jsmn `jasmine' JSON parser
>       perf jevents: Program to convert JSON file
>       perf tools: Support CPU id matching for x86 v2
>       perf jevents: Handle header line in mapfile
>       perf pmu: Support alias descriptions
>       perf tools: Query terminal width and use in perf list
>       perf list: Add a --no-desc flag
>       perf pmu: Add override support for event list CPUID
>       perf list jevents: Add support for event list topics
>       perf tools: Make alias matching case-insensitive
>       perf pmu-events: Fix fixed counters on Intel
>       perf pmu-events: Add Skylake frontend MSR support
> 
> Arnaldo Carvalho de Melo (1):
>       perf tools: Experiment with cppcheck
> 
> Colin Ian King (1):
>       perf probe: Check if *ptr2 is zero and not ptr2
> 
> Jiri Olsa (2):
>       tools build: Add support for host programs format
>       tools build: Make fixdep a hostprog
> 
> Sukadev Bhattiprolu (6):
>       perf pmu: Use pmu_events table to create aliases
>       perf powerpc: Support CPU ID matching for Powerpc
>       perf jevents: Add support for long descriptions
>       perf list: Support long jevents descriptions
>       perf tools: Add README for info on parsing JSON/map files
>       perf tools: Allow period= in perf stat CPU event descriptions.
> 
>  tools/build/Build                      |   2 +
>  tools/build/Build.include              |   5 +
>  tools/build/Makefile                   |   8 +-
>  tools/build/Makefile.build             |  19 +-
>  tools/build/Makefile.include           |   4 -
>  tools/lib/subcmd/pager.c               |  16 +
>  tools/lib/subcmd/pager.h               |   1 +
>  tools/perf/Documentation/perf-list.txt |  12 +-
>  tools/perf/Makefile.perf               |  34 +-
>  tools/perf/arch/powerpc/util/header.c  |  11 +
>  tools/perf/arch/x86/util/header.c      |  24 +-
>  tools/perf/builtin-list.c              |  20 +-
>  tools/perf/pmu-events/Build            |  13 +
>  tools/perf/pmu-events/README           | 147 ++++++
>  tools/perf/pmu-events/jevents.c        | 812 +++++++++++++++++++++++++++++++++
>  tools/perf/pmu-events/jevents.h        |  18 +
>  tools/perf/pmu-events/jsmn.c           | 313 +++++++++++++
>  tools/perf/pmu-events/jsmn.h           |  67 +++
>  tools/perf/pmu-events/json.c           | 162 +++++++
>  tools/perf/pmu-events/json.h           |  38 ++
>  tools/perf/pmu-events/pmu-events.h     |  37 ++
>  tools/perf/util/evlist.c               |  12 +-
>  tools/perf/util/evsel.c                |   3 +-
>  tools/perf/util/header.h               |   1 +
>  tools/perf/util/machine.c              |   6 +-
>  tools/perf/util/parse-events.c         |   8 +-
>  tools/perf/util/parse-events.h         |   3 +-
>  tools/perf/util/pmu.c                  | 176 ++++++-
>  tools/perf/util/pmu.h                  |   6 +-
>  tools/perf/util/probe-event.c          |   2 +-
>  tools/perf/util/strbuf.h               |   3 +-
>  tools/perf/util/thread.c               |   9 +-
>  32 files changed, 1926 insertions(+), 66 deletions(-)
>  create mode 100644 tools/perf/pmu-events/Build
>  create mode 100644 tools/perf/pmu-events/README
>  create mode 100644 tools/perf/pmu-events/jevents.c
>  create mode 100644 tools/perf/pmu-events/jevents.h
>  create mode 100644 tools/perf/pmu-events/jsmn.c
>  create mode 100644 tools/perf/pmu-events/jsmn.h
>  create mode 100644 tools/perf/pmu-events/json.c
>  create mode 100644 tools/perf/pmu-events/json.h
>  create mode 100644 tools/perf/pmu-events/pmu-events.h
> 
>   # time dm
>    1 alpine:3.4: Ok
>    2 android-ndk:r12b-arm: Ok
>    3 archlinux:latest: Ok
>    4 centos:5: Ok
>    5 centos:6: Ok
>    6 centos:7: Ok
>    7 debian:7: Ok
>    8 debian:8: Ok
>    9 debian:experimental: Ok
>   10 fedora:20: Ok
>   11 fedora:21: Ok
>   12 fedora:22: Ok
>   13 fedora:23: Ok
>   14 fedora:24: Ok
>   15 fedora:24-x-ARC-uClibc: Ok
>   16 fedora:rawhide: Ok
>   17 mageia:5: Ok
>   18 opensuse:13.2: Ok
>   19 opensuse:42.1: Ok
>   20 opensuse:tumbleweed: Ok
>   21 ubuntu:12.04.5: Ok
>   22 ubuntu:14.04: Ok
>   23 ubuntu:14.04.4: Ok
>   24 ubuntu:15.10: Ok
>   25 ubuntu:16.04: Ok
>   26 ubuntu:16.04-x-arm: Ok
>   27 ubuntu:16.04-x-arm64: Ok
>   28 ubuntu:16.04-x-powerpc: Ok
>   29 ubuntu:16.04-x-powerpc64: Ok
>   30 ubuntu:16.04-x-powerpc64el: Ok
>   31 ubuntu:16.04-x-s390: Ok
>   32 ubuntu:16.10: Ok
> 
>   real	33m23.855s
>   user	0m2.128s
>   sys	0m2.305s
>   #
> 
>   # perf test
>    1: vmlinux symtab matches kallsyms                          : Ok
>    2: detect openat syscall event                              : Ok
>    3: detect openat syscall event on all cpus                  : Ok
>    4: read samples using the mmap interface                    : Ok
>    5: parse events tests                                       : Ok
>    6: Validate PERF_RECORD_* events & perf_sample fields       : Ok
>    7: Test perf pmu format parsing                             : Ok
>    8: Test dso data read                                       : Ok
>    9: Test dso data cache                                      : Ok
>   10: Test dso data reopen                                     : Ok
>   11: roundtrip evsel->name check                              : Ok
>   12: Check parsing of sched tracepoints fields                : Ok
>   13: Generate and check syscalls:sys_enter_openat event fields: Ok
>   14: struct perf_event_attr setup                             : Ok
>   15: Test matching and linking multiple hists                 : Ok
>   16: Try 'import perf' in python, checking link problems      : Ok
>   17: Test breakpoint overflow signal handler                  : Ok
>   18: Test breakpoint overflow sampling                        : Ok
>   19: Test number of exit event of a simple workload           : Ok
>   20: Test software clock events have valid period values      : Ok
>   21: Test object code reading                                 : Ok
>   22: Test sample parsing                                      : Ok
>   23: Test using a dummy software event to keep tracking       : Ok
>   24: Test parsing with no sample_id_all bit set               : Ok
>   25: Test filtering hist entries                              : Ok
>   26: Test mmap thread lookup                                  : Ok
>   27: Test thread mg sharing                                   : Ok
>   28: Test output sorting of hist entries                      : Ok
>   29: Test cumulation of child hist entries                    : Ok
>   30: Test tracking with sched_switch                          : Ok
>   31: Filter fds with revents mask in a fdarray                : Ok
>   32: Add fd to a fdarray, making it autogrow                  : Ok
>   33: Test kmod_path__parse function                           : Ok
>   34: Test thread map                                          : Ok
>   35: Test LLVM searching and compiling                        :
>   35.1: Basic BPF llvm compiling test                          : Ok
>   35.2: Test kbuild searching                                  : Ok
>   35.3: Compile source for BPF prologue generation test        : Ok
>   35.4: Compile source for BPF relocation test                 : Ok
>   36: Test topology in session                                 : Ok
>   37: Test BPF filter                                          :
>   37.1: Test basic BPF filtering                               : Ok
>   37.2: Test BPF prologue generation                           : Ok
>   37.3: Test BPF relocation checker                            : Ok
>   38: Test thread map synthesize                               : Ok
>   39: Test cpu map synthesize                                  : Ok
>   40: Test stat config synthesize                              : Ok
>   41: Test stat synthesize                                     : Ok
>   42: Test stat round synthesize                               : Ok
>   43: Test attr update synthesize                              : Ok
>   44: Test events times                                        : Ok
>   45: Test backward reading from ring buffer                   : Ok
>   46: Test cpu map print                                       : Ok
>   47: Test SDT event probing                                   : Ok
>   48: Test is_printable_array function                         : Ok
>   49: Test bitmap print                                        : Ok
>   50: x86 rdpmc test                                           : Ok
>   51: Test converting perf time to TSC                         : Ok
>   52: Test dwarf unwind                                        : Ok
>   53: Test x86 instruction decoder - new instructions          : Ok
>   54: Test intel cqm nmi context read                          : Skip
>   # 
> 
>   $ make -C tools/perf build-test
>   make: Entering directory '/home/acme/git/linux/tools/perf'
>                       - tarpkg: ./tests/perf-targz-src-pkg .
>              make_no_libperl_O: make NO_LIBPERL=1
>                 make_no_newt_O: make NO_NEWT=1
>                make_no_slang_O: make NO_SLANG=1
>              make_no_libnuma_O: make NO_LIBNUMA=1
>         make_with_babeltrace_O: make LIBBABELTRACE=1
>    make_install_prefix_slash_O: make install prefix=/tmp/krava/
>               make_no_libbpf_O: make NO_LIBBPF=1
>             make_no_demangle_O: make NO_DEMANGLE=1
>             make_install_bin_O: make install-bin
>                 make_install_O: make install
>            make_no_libbionic_O: make NO_LIBBIONIC=1
>            make_no_libunwind_O: make NO_LIBUNWIND=1
>             make_no_libaudit_O: make NO_LIBAUDIT=1
>            make_no_libpython_O: make NO_LIBPYTHON=1
>                    make_tags_O: make tags
>                  make_perf_o_O: make perf.o
>                  make_static_O: make LDFLAGS=-static
>               make_clean_all_O: make clean all
>          make_install_prefix_O: make install prefix=/tmp/krava
>                    make_help_O: make help
>              make_util_map_o_O: make util/map.o
>                   make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
>   make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
>                 make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1
>            make_no_backtrace_O: make NO_BACKTRACE=1
>                   make_debug_O: make DEBUG=1
>               make_no_libelf_O: make NO_LIBELF=1
>              make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
>             make_no_auxtrace_O: make NO_AUXTRACE=1
>                     make_doc_O: make doc
>        make_util_pmu_bison_o_O: make util/pmu-bison.o
>                 make_no_gtk2_O: make NO_GTK2=1
>   OK

Pulled, thanks a lot Arnaldo!

	Ingo
