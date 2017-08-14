Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWNCv0QG1zDr1y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 03:39:55 +1000 (AEST)
Received: by mail-wm0-x243.google.com with SMTP id y206so15201194wmd.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 10:39:54 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 14 Aug 2017 19:39:48 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
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
Subject: Re: [GIT PULL 00/19] perf/core improvements and fixes
Message-ID: <20170814173948.pio6tbbkmqwrksmn@gmail.com>
References: <20170814162741.6101-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170814162741.6101-1-acme@kernel.org>
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
> Test results at the end of this message, as usual.
> 
> 
> The following changes since commit 82119cbe8e1e32cc2a941393e59816e731681310:
> 
>   Merge tag 'perf-core-for-mingo-4.14-20170801' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-08-10 17:07:02 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.14-20170814
> 
> for you to fetch changes up to 8fc375d7d36c72b4c2d55f5c24be022a939295d4:
> 
>   perf test shell: Add uprobes + backtrace ping test (2017-08-11 16:18:49 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> Infrastructure:
> 
> - Do not consider empty files as valid srclines (Milian Wolff)
> 
> - Fix wrong size in perf_record_mmap for last kernel module,
>   which resulted in erroneous symbol resolution in at least s390x (Thomas Richter)
> 
> - Add missing newline to expr parser error messages (Andi Kleen)
> 
> - Fix saved values rbtree lookup in 'perf stat' (Andi Kleen)
> 
> - Add support for shell based tests in 'perf test', add a few that
>   run 'perf probe', 'perf trace', using kprobes, uprobes to check
>   the output of those tools and the effects on the system, checking,
>   for instance, DWARF backtraces from uprobes (Arnaldo Carvalho de Melo)
> 
> Arch specific:
> 
> - Add ppc64le to audit uname list in the python scripting support (Naveen N. Rao)
> 
> - Update POWER9 vendor events tables (Sukadev Bhattiprolu)
> 
> - Fix module symbol adjustment for s390x (Thomas Richter)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (2):
>       perf stat: Fix saved values rbtree lookup
>       perf tools: Add missing newline to expr parser error messages
> 
> Arnaldo Carvalho de Melo (10):
>       perf test: Make 'list' subcommand match main 'perf test' numbering/matching
>       perf test: Add 'struct test *' to the test functions
>       perf test: Add infrastructure to run shell based tests
>       perf test: Make 'list' use same filtering code as main 'perf test'
>       perf test shell: Add 'probe_vfs_getname' shell test
>       perf test shell: Install shell tests
>       perf test shell: Move vfs_getname probe function to lib
>       perf test shell: Add test using probe:vfs_getname and verifying results
>       perf test shell: Add test using vfs_getname + 'perf trace'
>       perf test shell: Add uprobes + backtrace ping test
> 
> Milian Wolff (2):
>       perf util: Take elf_name as const string in dso__demangle_sym
>       perf srcline: Do not consider empty files as valid srclines
> 
> Naveen N. Rao (1):
>       perf scripting python: Add ppc64le to audit uname list
> 
> Sukadev Bhattiprolu (2):
>       perf vendor events powerpc: remove suffix in mapfile
>       perf vendor events powerpc: Update POWER9 events
> 
> Thomas Richter (2):
>       perf record: Fix wrong size in perf_record_mmap for last kernel module
>       perf report: Fix module symbol adjustment for s390x
> 
>  tools/perf/Makefile.perf                           |    6 +-
>  tools/perf/arch/s390/util/sym-handling.c           |    7 +
>  tools/perf/arch/x86/include/arch-tests.h           |   11 +-
>  tools/perf/arch/x86/tests/insn-x86.c               |    2 +-
>  tools/perf/arch/x86/tests/intel-cqm.c              |    2 +-
>  tools/perf/arch/x86/tests/perf-time-to-tsc.c       |    2 +-
>  tools/perf/arch/x86/tests/rdpmc.c                  |    2 +-
>  tools/perf/pmu-events/arch/powerpc/mapfile.csv     |   20 +-
>  .../perf/pmu-events/arch/powerpc/power9/cache.json |  191 +-
>  .../arch/powerpc/power9/floating-point.json        |   42 +-
>  .../pmu-events/arch/powerpc/power9/frontend.json   |  517 ++--
>  .../pmu-events/arch/powerpc/power9/marked.json     |  905 +++----
>  .../pmu-events/arch/powerpc/power9/memory.json     |  178 +-
>  .../perf/pmu-events/arch/powerpc/power9/other.json | 2768 ++++++++++++++++----
>  .../pmu-events/arch/powerpc/power9/pipeline.json   |  779 +++---
>  tools/perf/pmu-events/arch/powerpc/power9/pmc.json |  167 +-
>  .../arch/powerpc/power9/translation.json           |  314 +--
>  .../python/Perf-Trace-Util/lib/Perf/Trace/Util.py  |    1 +
>  tools/perf/tests/attr.c                            |    2 +-
>  tools/perf/tests/backward-ring-buffer.c            |    2 +-
>  tools/perf/tests/bitmap.c                          |    2 +-
>  tools/perf/tests/bp_signal.c                       |    2 +-
>  tools/perf/tests/bp_signal_overflow.c              |    2 +-
>  tools/perf/tests/bpf.c                             |    4 +-
>  tools/perf/tests/builtin-test.c                    |  184 +-
>  tools/perf/tests/clang.c                           |    4 +-
>  tools/perf/tests/code-reading.c                    |    2 +-
>  tools/perf/tests/cpumap.c                          |    4 +-
>  tools/perf/tests/dso-data.c                        |    6 +-
>  tools/perf/tests/dwarf-unwind.c                    |    2 +-
>  tools/perf/tests/event-times.c                     |    2 +-
>  tools/perf/tests/event_update.c                    |    2 +-
>  tools/perf/tests/evsel-roundtrip-name.c            |    2 +-
>  tools/perf/tests/evsel-tp-sched.c                  |    2 +-
>  tools/perf/tests/expr.c                            |    2 +-
>  tools/perf/tests/fdarray.c                         |    4 +-
>  tools/perf/tests/hists_cumulate.c                  |    2 +-
>  tools/perf/tests/hists_filter.c                    |    2 +-
>  tools/perf/tests/hists_link.c                      |    2 +-
>  tools/perf/tests/hists_output.c                    |    2 +-
>  tools/perf/tests/is_printable_array.c              |    2 +-
>  tools/perf/tests/keep-tracking.c                   |    2 +-
>  tools/perf/tests/kmod-path.c                       |    2 +-
>  tools/perf/tests/llvm.c                            |    2 +-
>  tools/perf/tests/mmap-basic.c                      |    2 +-
>  tools/perf/tests/mmap-thread-lookup.c              |    2 +-
>  tools/perf/tests/openat-syscall-all-cpus.c         |    2 +-
>  tools/perf/tests/openat-syscall-tp-fields.c        |    2 +-
>  tools/perf/tests/openat-syscall.c                  |    2 +-
>  tools/perf/tests/parse-events.c                    |    2 +-
>  tools/perf/tests/parse-no-sample-id-all.c          |    2 +-
>  tools/perf/tests/perf-hooks.c                      |    2 +-
>  tools/perf/tests/perf-record.c                     |    2 +-
>  tools/perf/tests/pmu.c                             |    2 +-
>  tools/perf/tests/python-use.c                      |    2 +-
>  tools/perf/tests/sample-parsing.c                  |    2 +-
>  tools/perf/tests/sdt.c                             |    4 +-
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh    |   28 +
>  tools/perf/tests/shell/probe_vfs_getname.sh        |   10 +
>  .../tests/shell/record+script_probe_vfs_getname.sh |   37 +
>  .../perf/tests/shell/trace+probe_libc_inet_pton.sh |   40 +
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh  |   31 +
>  tools/perf/tests/stat.c                            |    6 +-
>  tools/perf/tests/sw-clock.c                        |    2 +-
>  tools/perf/tests/switch-tracking.c                 |    2 +-
>  tools/perf/tests/task-exit.c                       |    2 +-
>  tools/perf/tests/tests.h                           |  113 +-
>  tools/perf/tests/thread-map.c                      |    6 +-
>  tools/perf/tests/thread-mg-share.c                 |    2 +-
>  tools/perf/tests/topology.c                        |    2 +-
>  tools/perf/tests/unit_number__scnprintf.c          |    2 +-
>  tools/perf/tests/vmlinux-kallsyms.c                |    2 +-
>  tools/perf/util/expr.y                             |    2 +-
>  tools/perf/util/machine.c                          |    4 +-
>  tools/perf/util/srcline.c                          |    6 +
>  tools/perf/util/stat-shadow.c                      |    6 +-
>  tools/perf/util/symbol-elf.c                       |   12 +-
>  tools/perf/util/symbol-minimal.c                   |    2 +-
>  tools/perf/util/symbol.c                           |   21 +-
>  tools/perf/util/symbol.h                           |    7 +-
>  80 files changed, 4054 insertions(+), 2479 deletions(-)
>  create mode 100644 tools/perf/tests/shell/lib/probe_vfs_getname.sh
>  create mode 100755 tools/perf/tests/shell/probe_vfs_getname.sh
>  create mode 100755 tools/perf/tests/shell/record+script_probe_vfs_getname.sh
>  create mode 100755 tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
>  create mode 100755 tools/perf/tests/shell/trace+probe_vfs_getname.sh

Pulled, thanks a lot Arnaldo!

	Ingo
