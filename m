Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com
 [IPv6:2a00:1450:400c:c09::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1MWT6xtjzDqGn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 16:36:53 +1000 (AEST)
Received: by mail-wm0-x22c.google.com with SMTP id g17so61231192wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 May 2016 23:36:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 6 May 2016 08:36:43 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 David Ahern <dsahern@gmail.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Jiri Olsa <jolsa@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Mark Wielaard <mjw@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, pi3orama@163.com,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Wang Nan <wangnan0@huawei.com>, Zefan Li <lizefan@huawei.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/17] perf/core improvements and fixes
Message-ID: <20160506063643.GA11792@gmail.com>
References: <1462494580-27164-1-git-send-email-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462494580-27164-1-git-send-email-acme@kernel.org>
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
> 
> The following changes since commit 1b6de5917172967acd8db4d222df4225d23a8a60:
> 
>   perf/x86/intel/pt: Convert ACCESS_ONCE()s (2016-05-05 10:16:29 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-20160505
> 
> for you to fetch changes up to b6b85dad30ad7e7394990e2317a780577974a4e6:
> 
>   perf evlist: Rename variable in perf_mmap__read() (2016-05-05 21:04:04 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> User visible:
> 
> - Order output of 'perf trace --summary' better, now the threads will
>   appear ascending order of number of events, and then, for each, in
>   descending order of syscalls by the time spent in the syscalls, so
>   that the last page produced can be the one about the most interesting
>   thread straced, suggested by Milian Wolff (Arnaldo Carvalho de Melo)
> 
> - Do not show the runtime_ms for a thread when not collecting it, that
>   is done so far only with 'perf trace --sched' (Arnaldo Carvalho de Melo)
> 
> - Fix kallsyms perf test on ppc64le (Naveen N. Rao)
> 
> Infrastructure:
> 
> - Move global variables related to presence of some keys in the sort order to a
>   per hist struct, to allow code like the hists browser to work with multiple
>   hists with different lists of columns (Jiri Olsa)
> 
> - Add support for generating bpf prologue in powerpc (Naveen N. Rao)
> 
> - Fix kprobe and kretprobe handling with kallsyms on ppc64le (Naveen N. Rao)
> 
> - evlist mmap changes, prep work for supporting reading backwards (Wang Nan)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (5):
>       perf machine: Introduce number of threads member
>       perf tools: Add template for generating rbtree resort class
>       perf trace: Sort summary output by number of events
>       perf trace: Sort syscalls stats by msecs in --summary
>       perf trace: Do not show the runtime_ms for a thread when not collecting it
> 
> Jiri Olsa (7):
>       perf hists: Move sort__need_collapse into struct perf_hpp_list
>       perf hists: Move sort__has_parent into struct perf_hpp_list
>       perf hists: Move sort__has_sym into struct perf_hpp_list
>       perf hists: Move sort__has_dso into struct perf_hpp_list
>       perf hists: Move sort__has_socket into struct perf_hpp_list
>       perf hists: Move sort__has_thread into struct perf_hpp_list
>       perf hists: Move sort__has_comm into struct perf_hpp_list
> 
> Naveen N. Rao (3):
>       perf tools powerpc: Add support for generating bpf prologue
>       perf powerpc: Fix kprobe and kretprobe handling with kallsyms on ppc64le
>       perf symbols: Fix kallsyms perf test on ppc64le
> 
> Wang Nan (2):
>       perf evlist: Extract perf_mmap__read()
>       perf evlist: Rename variable in perf_mmap__read()
> 
>  tools/perf/arch/powerpc/Makefile            |   1 +
>  tools/perf/arch/powerpc/util/dwarf-regs.c   |  40 +++++---
>  tools/perf/arch/powerpc/util/sym-handling.c |  43 ++++++--
>  tools/perf/builtin-diff.c                   |   4 +-
>  tools/perf/builtin-report.c                 |   4 +-
>  tools/perf/builtin-top.c                    |   8 +-
>  tools/perf/builtin-trace.c                  |  87 ++++++++++------
>  tools/perf/tests/hists_common.c             |   2 +-
>  tools/perf/tests/hists_cumulate.c           |   2 +-
>  tools/perf/tests/hists_link.c               |   4 +-
>  tools/perf/tests/hists_output.c             |   2 +-
>  tools/perf/ui/browsers/hists.c              |  32 +++---
>  tools/perf/ui/gtk/hists.c                   |   2 +-
>  tools/perf/ui/hist.c                        |   2 +-
>  tools/perf/util/annotate.c                  |   2 +-
>  tools/perf/util/callchain.c                 |   2 +-
>  tools/perf/util/evlist.c                    |  56 ++++++-----
>  tools/perf/util/hist.c                      |  14 +--
>  tools/perf/util/hist.h                      |  10 ++
>  tools/perf/util/machine.c                   |   9 +-
>  tools/perf/util/machine.h                   |   1 +
>  tools/perf/util/probe-event.c               |   5 +-
>  tools/perf/util/probe-event.h               |   3 +-
>  tools/perf/util/rb_resort.h                 | 149 ++++++++++++++++++++++++++++
>  tools/perf/util/sort.c                      |  35 +++----
>  tools/perf/util/sort.h                      |   7 --
>  tools/perf/util/symbol-elf.c                |   7 +-
>  tools/perf/util/symbol.h                    |   3 +-
>  28 files changed, 382 insertions(+), 154 deletions(-)
>  create mode 100644 tools/perf/util/rb_resort.h

Pulled, thanks a lot Arnaldo!

	Ingo
