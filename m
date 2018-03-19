Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404lmG1NkvzDrHv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 06:01:50 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Colin King <colin.king@canonical.com>,
 David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Kan Liang <kan.liang@linux.intel.com>, kernel-janitors@vger.kernel.org,
 Laura Abbott <labbott@redhat.com>, linux-kselftest@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-trace-users@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Stephane Eranian <eranian@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Tom Zanussi <tom.zanussi@linux.intel.com>, Wang Nan <wangnan0@huawei.com>,
 Willy Tarreau <w@1wt.eu>, Yisheng Xie <xieyisheng1@huawei.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/14] perf/core improvements and fixes
Date: Mon, 19 Mar 2018 16:01:22 -0300
Message-Id: <20180319190136.7441-1-acme@kernel.org>
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

	Please consider pulling, this has those 31 patches that were
blocked due to some problems (author not being the fist S-o-B, build
broken on ppc), those issues should all be fixed and then we have 14
patches more, described in the signed tag.

Regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 10f354a36f9a9aa1b8bffe0abc1cd43822a85bcd:

  perf test: Fix exit code for record+probe_libc_inet_pton.sh (2018-03-16 13:56:31 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180319

for you to fetch changes up to 1cd618838b9703eabe4a75badf433382b12f6bef:

  perf tests bp_account: Fix build with clang-6 (2018-03-19 13:51:54 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Fixes for problems experienced with new gcc 8 warnings, that treated
  as errors, broke the build, related to snprintf and casting issues.
  (Arnaldo Carvalho de Melo, Jiri Olsa, Josh Poinboeuf)

- Fix build of new breakpoint 'perf test' entry with clang < 6, noticed
  on fedora 25, 26 and 27 (Arnaldo Carvalho de Melo)

- Workaround problem with symbol resolution in 'perf annotate', using
  the symbol name already present in the objdump output (Arnaldo Carvalho de Melo)

- Document 'perf top --ignore-vmlinux' (Arnaldo Carvalho de Melo)

- Fix out of bounds access on array fd when cnt is 100 in one of the
  'perf test' entries, detected using 'cpptest' (Colin Ian King)

- Add support for the forced leader feature, i.e. 'perf report --group'
  for a group of events not really grouped when scheduled (without using
  {} to enclose the list of events in the command line) in pipe mode,
  e.g.:

  $ perf record -e cycles,instructions -o - kill | perf report --group -i -

- Use right type to access array elements in 'perf probe' (Masami Hiramatsu)

- Update POWER9 vendor events (those described in JSON format) (Sukadev Bhattiprolu)

- Discard head in overwrite_rb_find_range() (Yisheng Xie)

- Avoid setting 'quiet' to 'true' unnecessarily (Yisheng Xie)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (4):
      perf annotate: Use asprintf when formatting objdump command line
      perf top: Document --ignore-vmlinux
      perf annotate: Use ops->target.name when available for unresolved call targets
      perf tests bp_account: Fix build with clang-6

Colin Ian King (1):
      perf tests: Fix out of bounds access on array fd when cnt is 100

Jiri Olsa (4):
      perf record: Synthesize features before events in pipe mode
      perf report: Support forced leader feature in pipe mode
      perf tools: Fix snprint warnings for gcc 8
      perf tools: Fix python extension build for gcc 8

Josh Poimboeuf (1):
      objtool, perf: Fix GCC 8 -Wrestrict error

Masami Hiramatsu (1):
      perf probe: Use right type to access array elements

Sukadev Bhattiprolu (1):
      perf vendor events: Update POWER9 events

Yisheng Xie (2):
      perf mmap: Discard head in overwrite_rb_find_range()
      perf debug: Avoid setting 'quiet' to 'true' unnecessarily

 tools/lib/str_error_r.c                            |   2 +-
 tools/perf/Documentation/perf-top.txt              |   3 +
 tools/perf/builtin-record.c                        |  18 +-
 tools/perf/builtin-report.c                        |  57 +++--
 tools/perf/builtin-script.c                        |  22 +-
 .../perf/pmu-events/arch/powerpc/power9/cache.json |  25 ---
 .../pmu-events/arch/powerpc/power9/frontend.json   |  10 -
 .../pmu-events/arch/powerpc/power9/marked.json     |   5 -
 .../pmu-events/arch/powerpc/power9/memory.json     |   5 -
 .../perf/pmu-events/arch/powerpc/power9/other.json | 241 ++++++++++++++-------
 .../pmu-events/arch/powerpc/power9/pipeline.json   |  50 ++---
 tools/perf/pmu-events/arch/powerpc/power9/pmc.json |   5 -
 .../arch/powerpc/power9/translation.json           |  10 +-
 tools/perf/tests/attr.c                            |   4 +-
 tools/perf/tests/bp_account.c                      |  10 +-
 tools/perf/tests/mem.c                             |   2 +-
 tools/perf/tests/pmu.c                             |   2 +-
 tools/perf/util/annotate.c                         |  20 +-
 tools/perf/util/cgroup.c                           |   2 +-
 tools/perf/util/debug.c                            |   1 -
 tools/perf/util/header.c                           |  11 +-
 tools/perf/util/mmap.c                             |  15 +-
 tools/perf/util/parse-events.c                     |   4 +-
 tools/perf/util/pmu.c                              |   2 +-
 tools/perf/util/probe-finder.c                     |  13 +-
 tools/perf/util/setup.py                           |   2 +
 26 files changed, 298 insertions(+), 243 deletions(-)

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

[root@jouet ~]# time dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-11)
   7 amazonlinux:2                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
   8 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   9 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  10 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  11 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  12 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  13 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  14 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  15 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  16 debian:experimental           : Ok   gcc (Debian 7.2.0-17) 7.2.1 20171205
  17 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  18 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  19 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.2.0-11) 7.2.0
  20 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  21 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  22 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  23 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  26 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  27 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  28 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  29 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
  30 fedora:rawhide                : Ok   gcc (GCC) 8.0.1 20180222 (Red Hat 8.0.1-0.16)
  31 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 6.4.0-r1 p1.3) 6.4.0
  32 mageia:5                      : Ok   gcc (GCC) 4.9.2
  33 mageia:6                      : Ok   gcc (Mageia 5.4.0-5.mga6) 5.4.0
  34 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  35 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  36 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  37 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.3.0
  38 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  39 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16.0.3)
  40 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  41 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  42 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.4-2017.05) 5.4.1 20170404
  43 ubuntu:15.04                  : Ok   gcc (Ubuntu 4.9.2-10ubuntu13) 4.9.2
  44 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609
  45 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  46 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  47 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  48 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) 5.4.0 20160609
  49 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  50 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  51 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  52 ubuntu:17.04                  : Ok   gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  53 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3) 7.2.0
  54 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.2.0-16ubuntu1) 7.2.0

  # uname -a
  Linux jouet 4.16.0-rc5-00086-gdf09348f78dc #1 SMP Fri Mar 16 09:46:40 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
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
  21: Breakpoint accounting                                 : Skip
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
  62: Use vfs_getname probe to get syscall args filenames   : Ok
  63: Check open filename arg using perf trace + vfs_getname: Ok
  64: probe libc's inet_pton & backtrace it with ping       : Ok
  65: Add vfs_getname probe to get syscall args filenames   : Ok
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
           make_no_libbionic_O: make NO_LIBBIONIC=1
              make_no_libelf_O: make NO_LIBELF=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
              make_no_libbpf_O: make NO_LIBBPF=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
               make_no_slang_O: make NO_SLANG=1
             make_no_libnuma_O: make NO_LIBNUMA=1
              make_clean_all_O: make clean all
             make_util_map_o_O: make util/map.o
            make_no_demangle_O: make NO_DEMANGLE=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
                   make_pure_O: make
            make_install_bin_O: make install-bin
                make_install_O: make install
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                   make_tags_O: make tags
         make_install_prefix_O: make install prefix=/tmp/krava
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
             make_no_libperl_O: make NO_LIBPERL=1
                make_no_gtk2_O: make NO_GTK2=1
                 make_static_O: make LDFLAGS=-static
                   make_help_O: make help
                make_no_newt_O: make NO_NEWT=1
                  make_debug_O: make DEBUG=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                 make_perf_o_O: make perf.o
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
           make_no_libpython_O: make NO_LIBPYTHON=1
                    make_doc_O: make doc
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
