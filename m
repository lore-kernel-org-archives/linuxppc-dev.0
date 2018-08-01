Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gmq60x1WzF1mc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 07:37:05 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alexey Budankov <alexey.budankov@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 David Ahern <dsahern@gmail.com>, Don Zickus <dzickus@redhat.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Jan Glauber <jan.glauber@cavium.com>,
 Jayachandran C <jnair@caviumnetworks.com>, Jiri Olsa <jolsa@redhat.com>,
 Joe Mario <jmario@redhat.com>, Kan Liang <kan.liang@linux.intel.com>,
 Kim Phillips <kim.phillips@arm.com>, Leo Yan <leo.yan@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Mark Rutland <mark.rutland@arm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Michael Petlan <mpetlan@redhat.com>, Mike Leach <mike.leach@linaro.org>,
 Namhyung Kim <namhyung@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
 Robert Richter <robert.richter@cavium.com>,
 Robert Walker <robert.walker@arm.com>, rodia@autistici.org,
 Sandipan Das <sandipan@linux.ibm.com>, Stefan Liebler <stli@linux.ibm.com>,
 Sunil K Pandey <sunil.k.pandey@intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>,
 Vadim Lomovtsev <vadim.lomovtsev@cavium.com>,
 Wang Nan <wangnan0@huawei.com>, Will Deacon <will.deacon@arm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/21] perf/core improvements and fixes
Date: Wed,  1 Aug 2018 18:36:27 -0300
Message-Id: <20180801213648.4814-1-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ingo,

	Please consider pulling, contains a recently merged
tip/perf/urgent,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit c2586cfbb905939b79b49a9121fb0a59a5668fd6:

  Merge remote-tracking branch 'tip/perf/urgent' into perf/core (2018-07-31 09:55:45 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.19-20180801

for you to fetch changes up to b912885ab75c7c8aa841c615108afd755d0b97f8:

  perf trace: Do not require --no-syscalls to suppress strace like output (2018-08-01 16:20:28 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf trace: (Arnaldo Carvalho de Melo)

- Do not require --no-syscalls to suppress strace like output, i.e.

     # perf trace -e sched:*switch

  will show just sched:sched_switch events, not strace-like formatted
  syscall events, use --syscalls to get the previous behaviour.

  If instead:

     # perf trace

  is used, i.e. no events specified, then --syscalls is implied and
  system wide strace like formatting will be applied to all syscalls.

  The behaviour when just a syscall subset is used with '-e' is unchanged:

     # perf trace -e *sleep,sched:*switch

  will work as before: just the 'nanosleep' syscall will be strace-like
  formatted plus the sched:sched_switch tracepoint event, system wide.

- Allow string table generators to use a default header dir, allowing
  use of them without parameters to see the table it generates on
  stdout, e.g.:

    $ tools/perf/trace/beauty/kvm_ioctl.sh
    static const char *kvm_ioctl_cmds[] = {
        [0x00] = "GET_API_VERSION",
        [0x01] = "CREATE_VM",
        [0x02] = "GET_MSR_INDEX_LIST",
        [0x03] = "CHECK_EXTENSION",
<BIG SNIP>
        [0xe0] = "CREATE_DEVICE",
        [0xe1] = "SET_DEVICE_ATTR",
        [0xe2] = "GET_DEVICE_ATTR",
        [0xe3] = "HAS_DEVICE_ATTR",
    };
    $

  See 'ls tools/perf/trace/beauty/*.sh' to see the available string
  table generators.

- Add a generator for IPPROTO_ socket's protocol constants.

perf record: (Kan Liang)

- Fix error out while applying initial delay and using LBR, due to
  the use of a PERF_TYPE_SOFTWARE/PERF_COUNT_SW_DUMMY event to track
  PERF_RECORD_MMAP events while waiting for the initial delay. Such
  events fail when configured asking PERF_SAMPLE_BRANCH_STACK in
  perf_event_attr.sample_type.

perf c2c: (Jiri Olsa)

- Fix report crash for empty browser, when processing a perf.data file
  without events of interest, either because not asked for in
  'perf record' or because the workload didn't triggered such events.

perf list: (Michael Petlan)

- Align metric group description format with PMU event description.

perf tests: (Sandipan Das)

- Fix indexing when invoking subtests, which caused BPF tests to
  get results for the next test in the list, with the last one
  reporting a failure.

eBPF:

- Fix installation directory for header files included from eBPF proggies,
  avoiding clashing with relative paths used to build other software projects
  such as glibc. (Thomas Richter)

- Show better message when failing to load an object. (Arnaldo Carvalho de Melo)

General: (Christophe Leroy)

- Allow overriding MAX_NR_CPUS at compile time, to make the tooling
  usable in systems with less memory, in time this has to be changed
  to properly allocate based on _NPROCESSORS_ONLN.

Architecture specific:

- Update arm64's ThunderX2 implementation defined pmu core events (Ganapatrao Kulkarni)

- Fix complex event name parsing in 'perf test' for PowerPC, where the 'umask' event
  modifier isn't present. (Sandipan Das)

CoreSight ARM hardware tracing: (Leo Yan)

- Fix start tracing packet handling.

- Support dummy address value for CS_ETM_TRACE_ON packet.

- Generate branch sample when receiving a CS_ETM_TRACE_ON packet.

- Generate branch sample for CS_ETM_TRACE_ON packet.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (9):
      perf trace beauty: Default header_dir to cwd to work without parms
      tools include uapi: Grab a copy of linux/in.h
      perf beauty: Add a generator for IPPROTO_ socket's protocol constants
      perf trace beauty: Do not print NULL strarray entries
      perf trace beauty: Add beautifiers for 'socket''s 'protocol' arg
      perf trace: Beautify the AF_INET & AF_INET6 'socket' syscall 'protocol' args
      perf bpf: Show better message when failing to load an object
      perf bpf: Include uapi/linux/bpf.h from the 'perf trace' script's bpf.h
      perf trace: Do not require --no-syscalls to suppress strace like output

Christophe Leroy (1):
      perf tools: Allow overriding MAX_NR_CPUS at compile time

Ganapatrao Kulkarni (1):
      perf vendor events arm64: Update ThunderX2 implementation defined pmu core events

Jiri Olsa (1):
      perf c2c report: Fix crash for empty browser

Kan Liang (1):
      perf evlist: Fix error out while applying initial delay and LBR

Leo Yan (4):
      perf cs-etm: Fix start tracing packet handling
      perf cs-etm: Support dummy address value for CS_ETM_TRACE_ON packet
      perf cs-etm: Generate branch sample when receiving a CS_ETM_TRACE_ON packet
      perf cs-etm: Generate branch sample for CS_ETM_TRACE_ON packet

Michael Petlan (1):
      perf list: Unify metric group description format with PMU event description

Sandipan Das (2):
      perf tests: Fix complex event name parsing
      perf tests: Fix indexing when invoking subtests

Thomas Richter (1):
      perf build: Fix installation directory for eBPF

 tools/include/uapi/linux/in.h                      | 301 +++++++++++++++++++++
 tools/perf/Makefile.config                         |   4 +-
 tools/perf/Makefile.perf                           |  10 +
 tools/perf/builtin-c2c.c                           |   3 +
 tools/perf/builtin-trace.c                         |  19 +-
 tools/perf/check-headers.sh                        |   1 +
 tools/perf/include/bpf/bpf.h                       |   3 +
 tools/perf/perf.h                                  |   2 +
 .../arch/arm64/cavium/thunderx2/core-imp-def.json  |  87 +++++-
 tools/perf/tests/builtin-test.c                    |   4 +-
 tools/perf/tests/parse-events.c                    |   2 +-
 tools/perf/trace/beauty/Build                      |   1 +
 tools/perf/trace/beauty/beauty.h                   |   3 +
 tools/perf/trace/beauty/drm_ioctl.sh               |   9 +-
 tools/perf/trace/beauty/kcmp_type.sh               |   2 +-
 tools/perf/trace/beauty/kvm_ioctl.sh               |   4 +-
 tools/perf/trace/beauty/madvise_behavior.sh        |   2 +-
 tools/perf/trace/beauty/perf_ioctl.sh              |   2 +-
 .../perf/trace/beauty/pkey_alloc_access_rights.sh  |   2 +-
 tools/perf/trace/beauty/sndrv_ctl_ioctl.sh         |   4 +-
 tools/perf/trace/beauty/sndrv_pcm_ioctl.sh         |   4 +-
 tools/perf/trace/beauty/socket.c                   |  28 ++
 tools/perf/trace/beauty/socket_ipproto.sh          |  11 +
 tools/perf/trace/beauty/vhost_virtio_ioctl.sh      |   6 +-
 tools/perf/util/bpf-loader.c                       |   4 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |   1 +
 tools/perf/util/cs-etm.c                           |  68 ++++-
 tools/perf/util/evsel.c                            |  14 +
 tools/perf/util/metricgroup.c                      |   4 +-
 29 files changed, 556 insertions(+), 49 deletions(-)
 create mode 100644 tools/include/uapi/linux/in.h
 create mode 100644 tools/perf/trace/beauty/socket.c
 create mode 100755 tools/perf/trace/beauty/socket_ipproto.sh

Test results:

The first ones are container (docker) based builds of tools/perf with
and without libelf support.  Where clang is available, it is also used
to build perf with/without libelf, and building with LIBCLANGLLVM=1
(built-in clang) with gcc and clang when clang and its devel libraries
are installed.

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

  # dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   7 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
   8 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   9 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  10 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  11 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  12 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
  13 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  14 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  15 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  16 debian:experimental           : Ok   gcc (Debian 8.2.0-1) 8.2.0
  17 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  18 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  19 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.3.0-18) 7.3.0
  20 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.1.0-12) 8.1.0
  21 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  22 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  23 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  26 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  27 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  28 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  29 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
  30 fedora:28                     : Ok   gcc (GCC) 8.1.1 20180502 (Red Hat 8.1.1-1)
  31 fedora:rawhide                : Ok   gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
  32 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 7.3.0-r3 p1.4) 7.3.0
  33 mageia:5                      : Ok   gcc (GCC) 4.9.2
  34 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  35 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  36 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  37 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  38 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  39 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  40 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28.0.1)
  41 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  42 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  43 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  44 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
  45 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  46 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  47 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  48 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  49 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  52 ubuntu:17.04                  : Ok   gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  53 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  54 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  55 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-1ubuntu2) 8.2.0
  #

  # uname -a
  # Linux seventh 4.17.9-100.fc27.x86_64 #1 SMP Mon Jul 23 22:35:38 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  b912885ab75c (HEAD -> perf/core) perf trace: Do not require --no-syscalls to suppress strace like output
  # perf version --build-options
  perf version 4.18.rc7.g822c262
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                    gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
               libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
      libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                    zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                    lzma: [ on  ]  # HAVE_LZMA_SUPPORT
               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                     bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
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
  21: Breakpoint accounting                                 : Ok
  22: Number of exit events of a simple workload            : Ok
  23: Software clock events period values                   : Ok
  24: Object code reading                                   : Ok
  25: Sample parsing                                        : Ok
  26: Use a dummy software event to keep tracking           : Ok
  27: Parse with no sample_id_all bit set                   : Ok
  28: Filter hist entries                                   : Ok
  29: Lookup mmap thread                                    : Ok
  30: Share thread mg                                       : Ok
  31: Sort output of hist entries                           : Ok
  32: Cumulate child hist entries                           : Ok
  33: Track with sched_switch                               : Ok
  34: Filter fds with revents mask in a fdarray             : Ok
  35: Add fd to a fdarray, making it autogrow               : Ok
  36: kmod_path__parse                                      : Ok
  37: Thread map                                            : Ok
  38: LLVM search and compile                               :
  38.1: Basic BPF llvm compile                              : Ok
  38.2: kbuild searching                                    : Ok
  38.3: Compile source for BPF prologue generation          : Ok
  38.4: Compile source for BPF relocation                   : Ok
  39: Session topology                                      : Ok
  40: BPF filter                                            :
  40.1: Basic BPF filtering                                 : Ok
  40.2: BPF pinning                                         : Ok
  40.3: BPF prologue generation                             : Ok
  40.4: BPF relocation checker                              : Ok
  41: Synthesize thread map                                 : Ok
  42: Remove thread map                                     : Ok
  43: Synthesize cpu map                                    : Ok
  44: Synthesize stat config                                : Ok
  45: Synthesize stat                                       : Ok
  46: Synthesize stat round                                 : Ok
  47: Synthesize attr update                                : Ok
  48: Event times                                           : Ok
  49: Read backward ring buffer                             : Ok
  50: Print cpu map                                         : Ok
  51: Probe SDT events                                      : Ok
  52: is_printable_array                                    : Ok
  53: Print bitmap                                          : Ok
  54: perf hooks                                            : Ok
  55: builtin clang support                                 : Skip (not compiled in)
  56: unit_number__scnprintf                                : Ok
  57: mem2node                                              : Ok
  58: x86 rdpmc                                             : Ok
  59: Convert perf time to TSC                              : Ok
  60: DWARF unwind                                          : Ok
  61: x86 instruction decoder - new instructions            : Ok
  62: probe libc's inet_pton & backtrace it with ping       : Ok
  63: Check open filename arg using perf trace + vfs_getname: Ok
  64: Use vfs_getname probe to get syscall args filenames   : Ok
  65: Add vfs_getname probe to get syscall args filenames   : Ok
  #
  
  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
           make_no_libunwind_O: make NO_LIBUNWIND=1
                make_no_newt_O: make NO_NEWT=1
            make_install_bin_O: make install-bin
         make_install_prefix_O: make install prefix=/tmp/krava
                    make_doc_O: make doc
                 make_perf_o_O: make perf.o
             make_util_map_o_O: make util/map.o
           make_no_libbionic_O: make NO_LIBBIONIC=1
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_libpython_O: make NO_LIBPYTHON=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                   make_help_O: make help
               make_no_slang_O: make NO_SLANG=1
             make_no_libperl_O: make NO_LIBPERL=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                 make_static_O: make LDFLAGS=-static
                   make_pure_O: make
                   make_tags_O: make tags
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
              make_no_libelf_O: make NO_LIBELF=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                make_install_O: make install
         make_with_clangllvm_O: make LIBCLANGLLVM=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
            make_no_libaudit_O: make NO_LIBAUDIT=1
                make_no_gtk2_O: make NO_GTK2=1
             make_no_libnuma_O: make NO_LIBNUMA=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
              make_no_libbpf_O: make NO_LIBBPF=1
              make_clean_all_O: make clean all
           make_no_backtrace_O: make NO_BACKTRACE=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                  make_debug_O: make DEBUG=1
                 make_cscope_O: make cscope
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
