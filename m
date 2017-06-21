Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtCHT3mCrzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:03:01 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>,
 David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@intel.com>, linuxppc-dev@lists.ozlabs.org,
 Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Robert Elliott <elliott@hpe.com>, Stephane Eranian <eranian@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Wang Nan <wangnan0@huawei.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/25] perf/core improvements and fixes
Date: Wed, 21 Jun 2017 15:02:20 -0300
Message-Id: <20170621180245.23134-1-acme@kernel.org>
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

The following changes since commit 007b811b4041989ec2dc91b9614aa2c41332723e:

  Merge tag 'perf-core-for-mingo-4.13-20170719' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-06-20 10:49:08 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.13-20170621

for you to fetch changes up to 701516ae3dec801084bc913d21e03fce15c61a0b:

  perf script: Fix message because field list option is -F not -f (2017-06-21 11:35:53 -0300)

----------------------------------------------------------------
perf/core improvements ad fixes:

New features:

- Add support to measure SMI cost in 'perf stat' (Kan Liang)

- Add support for unwinding callchains in powerpc with libdw (Paolo Bonzini)

Fixes:

- Fix message: cpu list option is -C not -c (Adrian Hunter)

- Fix 'perf script' message: field list option is -F not -f (Adrian Hunter)

- Intel PT fixes: (Adrian Hunter)

  o Fix missing stack clear
  o Ensure IP is zero when state is INTEL_PT_STATE_NO_IP
  o Fix last_ip usage
  o Ensure never to set 'last_ip' when packet 'count' is zero
  o Clear FUP flag on error
  o Fix transactions_sample_type

Infrastructure:

- Intel PT cleanups/refactorings (Adrian Hunter)

  o Use FUP always when scanning for an IP
  o Add missing __fallthrough
  o Remove redundant initial_skip checks
  o Allow decoding with branch tracing disabled
  o Add default config for pass-through branch enable
  o Add documentation for new config terms
  o Add decoder support for ptwrite and power event packets
  o Add reserved byte to CBR packet payload
  o Add decoder support for CBR events

- Move  find_process() to the only place that uses it, skimming some
  more fat from util.[ch] (Arnaldo Carvalho de Melo)

- Do parameter validation earlier on fetch_kernel_version() (Arnaldo Carvalho de Melo)

- Remove unused _ALL_SOURCE define (Arnaldo Carvalho de Melo)

- Add sysfs__write_int function (Kan Liang)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (19):
      perf intel-pt: Move decoder error setting into one condition
      perf intel-pt: Improve sample timestamp
      perf intel-pt: Fix missing stack clear
      perf intel-pt: Ensure IP is zero when state is INTEL_PT_STATE_NO_IP
      perf intel-pt: Fix last_ip usage
      perf intel-pt: Ensure never to set 'last_ip' when packet 'count' is zero
      perf intel-pt: Use FUP always when scanning for an IP
      perf intel-pt: Clear FUP flag on error
      perf intel-pt: Add missing __fallthrough
      perf intel-pt: Allow decoding with branch tracing disabled
      perf intel-pt: Add default config for pass-through branch enable
      perf intel-pt: Add documentation for new config terms
      perf intel-pt: Add decoder support for ptwrite and power event packets
      perf intel-pt: Add reserved byte to CBR packet payload
      perf intel-pt: Add decoder support for CBR events
      perf intel-pt: Remove redundant initial_skip checks
      perf intel-pt: Fix transactions_sample_type
      perf tools: Fix message because cpu list option is -C not -c
      perf script: Fix message because field list option is -F not -f

Arnaldo Carvalho de Melo (3):
      perf evsel: Adopt find_process()
      perf tools: Do parameter validation earlier on fetch_kernel_version()
      perf tools: Remove unused _ALL_SOURCE define

Kan Liang (2):
      tools lib api fs: Add sysfs__write_int function
      perf stat: Add support to measure SMI cost

Paolo Bonzini (1):
      perf unwind: Support for powerpc

 tools/lib/api/fs/fs.c                              |  30 +++
 tools/lib/api/fs/fs.h                              |   4 +
 tools/perf/Documentation/intel-pt.txt              |  36 +++
 tools/perf/Documentation/perf-stat.txt             |  14 +
 tools/perf/Makefile.config                         |   2 +-
 tools/perf/arch/powerpc/util/Build                 |   2 +
 tools/perf/arch/powerpc/util/unwind-libdw.c        |  73 ++++++
 tools/perf/arch/x86/util/intel-pt.c                |   5 +
 tools/perf/builtin-script.c                        |   2 +-
 tools/perf/builtin-stat.c                          |  49 ++++
 tools/perf/util/evsel.c                            |  39 +++
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 290 +++++++++++++++++++--
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |  13 +
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   | 110 +++++++-
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.h   |   7 +
 tools/perf/util/intel-pt.c                         |  23 +-
 tools/perf/util/session.c                          |   2 +-
 tools/perf/util/stat-shadow.c                      |  33 +++
 tools/perf/util/stat.c                             |   2 +
 tools/perf/util/stat.h                             |   2 +
 tools/perf/util/util.c                             |  52 +---
 tools/perf/util/util.h                             |   3 -
 22 files changed, 710 insertions(+), 83 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/unwind-libdw.c

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
  25 fedora:rawhide: Ok
  26 mageia:5: Ok
  27 opensuse:13.2: Ok
  28 opensuse:42.1: Ok
  29 opensuse:tumbleweed: Ok
  30 ubuntu:12.04.5: Ok
  31 ubuntu:14.04.4: Ok
  32 ubuntu:14.04.4-x-linaro-arm64: Ok
  33 ubuntu:15.10: Ok
  34 ubuntu:16.04: Ok
  35 ubuntu:16.04-x-arm: Ok
  36 ubuntu:16.04-x-arm64: Ok
  37 ubuntu:16.04-x-powerpc: Ok
  38 ubuntu:16.04-x-powerpc64: Ok
  39 ubuntu:16.04-x-powerpc64el: Ok
  40 ubuntu:16.04-x-s390: Ok
  41 ubuntu:16.10: Ok
  42 ubuntu:17.04: Ok
  # 

  # uname -a
  Linux jouet 4.12.0-rc4+ #1 SMP Fri Jun 9 12:59:23 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
  # perf test
   1: vmlinux symtab matches kallsyms            : Ok
   2: Detect openat syscall event                : Ok
   3: Detect openat syscall event on all cpus    : Ok
   4: Read samples using the mmap interface      : Ok
   5: Parse event definition strings             : Ok
   6: Simple expression parser                   : Ok
   7: PERF_RECORD_* events & perf_sample fields  : Ok
   8: Parse perf pmu format                      : Ok
   9: DSO data read                              : Ok
  10: DSO data cache                             : Ok
  11: DSO data reopen                            : Ok
  12: Roundtrip evsel->name                      : Ok
  13: Parse sched tracepoints fields             : Ok
  14: syscalls:sys_enter_openat event fields     : Ok
  15: Setup struct perf_event_attr               : Ok
  16: Match and link multiple hists              : Ok
  17: 'import perf' in python                    : Ok
  18: Breakpoint overflow signal handler         : Ok
  19: Breakpoint overflow sampling               : Ok
  20: Number of exit events of a simple workload : Ok
  21: Software clock events period values        : Ok
  22: Object code reading                        : Ok
  23: Sample parsing                             : Ok
  24: Use a dummy software event to keep tracking: Ok
  25: Parse with no sample_id_all bit set        : Ok
  26: Filter hist entries                        : Ok
  27: Lookup mmap thread                         : Ok
  28: Share thread mg                            : Ok
  29: Sort output of hist entries                : Ok
  30: Cumulate child hist entries                : Ok
  31: Track with sched_switch                    : Ok
  32: Filter fds with revents mask in a fdarray  : Ok
  33: Add fd to a fdarray, making it autogrow    : Ok
  34: kmod_path__parse                           : Ok
  35: Thread map                                 : Ok
  36: LLVM search and compile                    :
  36.1: Basic BPF llvm compile                    : Ok
  36.2: kbuild searching                          : Ok
  36.3: Compile source for BPF prologue generation: Ok
  36.4: Compile source for BPF relocation         : Ok
  37: Session topology                           : Ok
  38: BPF filter                                 :
  38.1: Basic BPF filtering                      : Ok
  38.2: BPF pinning                              : Ok
  38.3: BPF prologue generation                  : Ok
  38.4: BPF relocation checker                   : Ok
  39: Synthesize thread map                      : Ok
  40: Remove thread map                          : Ok
  41: Synthesize cpu map                         : Ok
  42: Synthesize stat config                     : Ok
  43: Synthesize stat                            : Ok
  44: Synthesize stat round                      : Ok
  45: Synthesize attr update                     : Ok
  46: Event times                                : Ok
  47: Read backward ring buffer                  : Ok
  48: Print cpu map                              : Ok
  49: Probe SDT events                           : Ok
  50: is_printable_array                         : Ok
  51: Print bitmap                               : Ok
  52: perf hooks                                 : Ok
  53: builtin clang support                      : Skip (not compiled in)
  54: unit_number__scnprintf                     : Ok
  55: x86 rdpmc                                  : Ok
  56: Convert perf time to TSC                   : Ok
  57: DWARF unwind                               : Ok
  58: x86 instruction decoder - new instructions : Ok
  59: Intel cqm nmi context read                 : Skip
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/linux/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
               make_no_slang_O: make NO_SLANG=1
              make_clean_all_O: make clean all
                make_no_gtk2_O: make NO_GTK2=1
             make_no_libperl_O: make NO_LIBPERL=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
                    make_doc_O: make doc
           make_no_libbionic_O: make NO_LIBBIONIC=1
           make_no_backtrace_O: make NO_BACKTRACE=1
              make_no_libelf_O: make NO_LIBELF=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
             make_no_libnuma_O: make NO_LIBNUMA=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
            make_no_demangle_O: make NO_DEMANGLE=1
             make_util_map_o_O: make util/map.o
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
         make_with_clangllvm_O: make LIBCLANGLLVM=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                 make_perf_o_O: make perf.o
                   make_tags_O: make tags
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
            make_install_bin_O: make install-bin
                  make_debug_O: make DEBUG=1
              make_no_libbpf_O: make NO_LIBBPF=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                   make_pure_O: make
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
         make_install_prefix_O: make install prefix=/tmp/krava
                make_install_O: make install
                   make_help_O: make help
                 make_static_O: make LDFLAGS=-static
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                make_no_newt_O: make NO_NEWT=1
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
  $ 
