Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com
 [IPv6:2a00:1450:400c:c05::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBFEA1A0BF2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 01:50:25 +1100 (AEDT)
Received: by mail-wi0-f174.google.com with SMTP id n3so12473552wiv.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 06:50:20 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 28 Jan 2015 15:50:15 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>
Subject: Re: [GIT PULL 00/26] perf/core improvements and fixes
Message-ID: <20150128145015.GB6559@gmail.com>
References: <1422294449-12735-1-git-send-email-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422294449-12735-1-git-send-email-acme@kernel.org>
Cc: Richard Fowles <rfowles@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Stephane Eranian <eranian@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Mackerras <paulus@samba.org>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Jiri Olsa <jolsa@redhat.com>,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 Borislav Petkov <bp@suse.de>, Don Zickus <dzickus@redhat.com>,
 Ramkumar Ramachandra <artagnon@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Joe Mario <jmario@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Kan Liang <kan.liang@intel.com>, Mike Galbraith <efault@gmx.de>,
 linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>,
 Cody P Schafer <cody@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
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
> 	Please consider pulling, it has my latest perf/urgent pull content,
> please let me know if you don't want it to be submitted like that, i.e. if
> you have any problems with my latest perf/urgent pull request and I'll try
> to address it ASAP.
> 
> - Arnaldo
> 
> The following changes since commit 25dd9171f51c482eb7c4dc8618766ae733756e2d:
> 
>   perf probe: Fix probing kretprobes (2015-01-21 10:06:24 -0300)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo
> 
> for you to fetch changes up to 3d199b5be53348bef84883013c484b414adf0a2e:
> 
>   tools lib traceevent: Add support for IP address formats (2015-01-26 12:04:41 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> User visible:
> 
> - Enable sampling loads and stores simultaneously in 'perf mem' (Stephane Eranian)
> 
> - 'perf diff' output improvements (Namhyung Kim)
> 
> - Fix error reporting for evsel pgfault constructor (Arnaldo Carvalho de Melo)
> 
> Infrastructure:
> 
> - Move debugfs sterrno like method to tools/lib/ so that it may be used by
>   other tools, as 'perf probe' will be soon (Arnaldo Carvalho de Melo)
> 
> - Introduce function fro deleting/removing hist_entry to avoid code duplication
>   (Arnaldo Carvalho de Melo)
> 
> - Support parsing parameterized events (Cody P Schafer)
> 
> - Add support for IP address formats in libtraceevent (David Ahern)
> 
> - Fix typo in sample-parsing.c 'perf test' entry (Rasmus Villemoes)
> 
> - Remove some unused functions from color.c (Rickard Strandqvist)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (9):
>       perf mem: Move the mem_operations global to struct perf_mem
>       perf tools: Remove EOL whitespaces
>       perf hists: Rename hist_entry__free to __delete
>       perf hists: Introduce function for deleting/removing hist_entry
>       tools lib fs: Adopt debugfs open strerrno method
>       tools lib fs: Pass filename to debugfs__strerror_open
>       perf trace: Fix error reporting for evsel pgfault constructor
>       tools lib fs debugfs: Introduce debugfs__strerror_open_tp
>       tools lib fs debugfs: Check if debugfs is mounted when handling ENOENT
> 
> Cody P Schafer (4):
>       perf tools: Support parsing parameterized events
>       perf tools: Extend format_alias() to include event parameters
>       perf Documentation: Add event parameters
>       perf tools: Document parameterized and symbolic events
> 
> David Ahern (1):
>       tools lib traceevent: Add support for IP address formats
> 
> Namhyung Kim (9):
>       perf report: Get rid of report__inc_stat()
>       perf tools: Allow use of an exclusive option more than once
>       perf diff: Get rid of hists__compute_resort()
>       perf diff: Print diff result more precisely
>       perf diff: Introduce fmt_to_data_file() helper
>       perf tools: Pass struct perf_hpp_fmt to its callbacks
>       perf diff: Fix output ordering to honor next column
>       perf diff: Fix -o/--order option behavior
>       perf ui/tui: Show fatal error message only if exists
> 
> Rasmus Villemoes (1):
>       perf tests: Fix typo in sample-parsing.c
> 
> Rickard Strandqvist (1):
>       perf tools: Remove some unused functions from color.c
> 
> Stephane Eranian (1):
>       perf mem: Enable sampling loads and stores simultaneously
> 
>  .../testing/sysfs-bus-event_source-devices-events  |   6 +
>  tools/lib/api/fs/debugfs.c                         |  43 +++
>  tools/lib/api/fs/debugfs.h                         |   3 +
>  tools/lib/traceevent/event-parse.c                 | 328 +++++++++++++++++++++
>  tools/perf/Documentation/perf-buildid-cache.txt    |   2 +-
>  tools/perf/Documentation/perf-list.txt             |  13 +
>  tools/perf/Documentation/perf-mem.txt              |   9 +-
>  tools/perf/Documentation/perf-record.txt           |  12 +
>  tools/perf/Documentation/perf-script.txt           |  28 +-
>  tools/perf/Documentation/perf-stat.txt             |  20 +-
>  tools/perf/builtin-buildid-cache.c                 |   4 +-
>  tools/perf/builtin-diff.c                          | 248 ++++++++++------
>  tools/perf/builtin-mem.c                           | 131 ++++++--
>  tools/perf/builtin-report.c                        |  16 +-
>  tools/perf/builtin-stat.c                          |   2 +-
>  tools/perf/builtin-top.c                           |   2 +-
>  tools/perf/builtin-trace.c                         | 106 ++++---
>  tools/perf/tests/attr.py                           |   1 -
>  tools/perf/tests/hists_cumulate.c                  |   2 +-
>  tools/perf/tests/hists_output.c                    |   2 +-
>  tools/perf/tests/make                              |   1 -
>  tools/perf/tests/parse-events.c                    |   2 +-
>  tools/perf/tests/sample-parsing.c                  |   2 +-
>  tools/perf/ui/browsers/annotate.c                  |   3 +-
>  tools/perf/ui/hist.c                               |  12 +-
>  tools/perf/ui/progress.h                           |   4 +-
>  tools/perf/ui/tui/helpline.c                       |   3 +
>  tools/perf/ui/tui/setup.c                          |   3 +-
>  tools/perf/util/annotate.c                         |   2 +-
>  tools/perf/util/color.c                            | 126 --------
>  tools/perf/util/color.h                            |   2 -
>  tools/perf/util/evlist.c                           |  27 --
>  tools/perf/util/evlist.h                           |   1 -
>  tools/perf/util/hist.c                             |  48 ++-
>  tools/perf/util/hist.h                             |  11 +-
>  tools/perf/util/parse-events.c                     |   6 +-
>  tools/perf/util/parse-events.h                     |   1 +
>  tools/perf/util/parse-options.c                    |   2 +-
>  tools/perf/util/pmu.c                              | 102 ++++++-
>  tools/perf/util/python.c                           |   2 +-
>  .../util/scripting-engines/trace-event-python.c    |   2 +-
>  tools/perf/util/session.c                          |   2 +-
>  tools/perf/util/sort.c                             |  37 ++-
>  tools/perf/util/symbol.c                           |   2 +-
>  44 files changed, 950 insertions(+), 431 deletions(-)

Pulled, thanks a lot Arnaldo!

Note that there was some minimal interaction with Frederic's 
pending perf/hw_breakpoint work, in tools/perf/Documentation/perf-record.txt.

I resolved the conflict and merged perf/hw_breakpoint into 
perf/core as well, to avoid future complications. (Once I've 
pushed it all out you guys might want to double check what I did 
there though, just to make sure.)

Thanks,

	Ingo
