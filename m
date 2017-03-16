Return-Path: <BATV+c415928f1c07afbf9bf8+4953+infradead.org+acme@merlin.srs.infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkYNb0pXJzDqLW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 03:10:39 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Anton Blanchard <anton@ozlabs.org>, Borislav Petkov <bp@suse.de>,
 Brendan Gregg <brendan.d.gregg@gmail.com>, David Ahern <dsahern@gmail.com>,
 David Miller <davem@davemloft.net>, He Kuang <hekuang@huawei.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Taeung Song <treeze.taeung@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Wang Nan <wangnan0@huawei.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 0/6] perf/core improvements and fixes
Date: Thu, 16 Mar 2017 13:09:56 -0300
Message-Id: <20170316161002.15445-1-acme@kernel.org>
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

The following changes since commit ffa86c2f1a8862cf58c873f6f14d4b2c3250fb48:

  Merge tag 'perf-core-for-mingo-4.12-20170314' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-03-15 19:27:27 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.12-20170316

for you to fetch changes up to 61f35d750683b21e9e3836e309195c79c1daed74:

  uprobes: Default UPROBES_EVENTS to Y (2017-03-16 12:42:02 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

New features:

- Add 'brstackinsn' field in 'perf script' to reuse the x86 instruction
  decoder used in the Intel PT code to study hot paths to samples (Andi Kleen)

Kernel:

- Default UPROBES_EVENTS to Y (Alexei Starovoitov)

- Fix check for kretprobe offset within function entry (Naveen N. Rao)

Infrastructure:

- Introduce util func is_sdt_event() (Ravi Bangoria)

- Make perf_event__synthesize_mmap_events() scale on older kernels where
  reading /proc/pid/maps is way slower than reading /proc/pid/task/pid/maps (Stephane Eranian)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andi Kleen (1):
      perf script: Add 'brstackinsn' for branch stacks

Arnaldo Carvalho de Melo (2):
      tools headers: Sync {tools/,}arch/x86/include/asm/cpufeatures.h
      uprobes: Default UPROBES_EVENTS to Y

Naveen N. Rao (1):
      trace/kprobes: Fix check for kretprobe offset within function entry

Ravi Bangoria (1):
      perf probe: Introduce util func is_sdt_event()

Stephane Eranian (1):
      perf tools: Make perf_event__synthesize_mmap_events() scale

 include/linux/kprobes.h                            |   1 +
 kernel/kprobes.c                                   |  40 ++--
 kernel/trace/Kconfig                               |   2 +-
 kernel/trace/trace_kprobe.c                        |   2 +-
 tools/arch/x86/include/asm/cpufeatures.h           |   5 +-
 tools/perf/Documentation/perf-script.txt           |  13 +-
 tools/perf/builtin-script.c                        | 264 ++++++++++++++++++++-
 tools/perf/util/Build                              |   1 +
 tools/perf/util/dump-insn.c                        |  14 ++
 tools/perf/util/dump-insn.h                        |  22 ++
 tools/perf/util/event.c                            |   4 +-
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |  24 ++
 tools/perf/util/parse-events.h                     |  20 ++
 tools/perf/util/probe-event.c                      |   9 +-
 14 files changed, 381 insertions(+), 40 deletions(-)
 create mode 100644 tools/perf/util/dump-insn.c
 create mode 100644 tools/perf/util/dump-insn.h

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

  # uname -a
  Linux zoo 4.9.13-100.fc24.x86_64 #1 SMP Mon Feb 27 16:57:22 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
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
  # 
  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/linux/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
              make_no_libelf_O: make NO_LIBELF=1
             make_no_libperl_O: make NO_LIBPERL=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                   make_pure_O: make
                 make_perf_o_O: make perf.o
                make_no_newt_O: make NO_NEWT=1
                   make_help_O: make help
            make_no_libaudit_O: make NO_LIBAUDIT=1
                 make_static_O: make LDFLAGS=-static
                    make_doc_O: make doc
              make_clean_all_O: make clean all
                  make_debug_O: make DEBUG=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
           make_no_libpython_O: make NO_LIBPYTHON=1
               make_no_slang_O: make NO_SLANG=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
         make_install_prefix_O: make install prefix=/tmp/krava
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
            make_no_demangle_O: make NO_DEMANGLE=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
            make_install_bin_O: make install-bin
             make_util_map_o_O: make util/map.o
                   make_tags_O: make tags
              make_no_libbpf_O: make NO_LIBBPF=1
                make_install_O: make install
                make_no_gtk2_O: make NO_GTK2=1
           make_no_backtrace_O: make NO_BACKTRACE=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
