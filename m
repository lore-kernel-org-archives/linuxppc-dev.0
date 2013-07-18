Return-Path: <BATV+f443add70332147a0092+3616+infradead.org+acme@merlin.srs.infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 573112C009E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2013 05:50:40 +1000 (EST)
From: Arnaldo Carvalho de Melo <acme@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [GIT PULL 00/76] perf/core improvements and fixes
Date: Thu, 18 Jul 2013 16:48:47 -0300
Message-Id: <1374177003-3706-1-git-send-email-acme@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Stephane Eranian <eranian@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Maynard Johnson <mpjohn@us.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
 Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "David A. Gilbert" <DavidAGilbert@uk.ibm.com>,
 Robert Richter <rric@kernel.org>, icycoder@gmail.com,
 Corey Ashford <cjashfor@linux.vnet.ibm.com>,
 Kwanghyun Yoo <ykh815.yoo@lge.com>, Runzhen Wang <runzhew@clemson.edu>,
 Greg Price <price@mit.edu>, Borislav Petkov <bp@alien8.de>,
 Steven Rostedt <rostedt@goodmis.org>,
 Runzhen Wang <runzhen@linux.vnet.ibm.com>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Thomas Renninger <trenn@suse.de>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Mike Galbraith <efault@gmx.de>,
 linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
 David Ahern <dsahern@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Fengguang Wu <fengguang.wu@intel.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>

Hi Ingo,

	Please consider pulling.

	There was a long delay in processing patches related to my vacations
that took longer than antecipated to being addressed.

	With the recent acme/perf/urgent merge and this one I get closer to
processing the resulting long backlog.

	There are still many patches to process, which I will be working on as
time permits in the next days and weeks.

Thanks,

- Arnaldo

The following changes since commit 67516844625f45f0ce148a01c27bf41f591872b2:

  perf: Remove the 'match' callback for auxiliary events processing (2013-07-12 13:50:36 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux tags/perf-core-for-mingo

for you to fetch changes up to 2a08c3ec4f7d6058a450d2d4bc6e366955872707:

  perf header: Recognize version number for perf data file (2013-07-17 17:04:00 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

. Add missing 'finished_round' event forwarding in 'perf inject', from Adrian Hunter.

. Assorted tidy ups, from Adrian Hunter.

. Fall back to sysfs event names when parsing fails, from Andi Kleen.

. List pmu events in perf list, from Andi Kleen.

. Cleanup some memory allocation/freeing uses, from David Ahern.

. Add option to collapse undesired parts of call graph, from Greg Price.

. Prep work for multi perf data file storage, from Jiri Olsa.

. Add support for more than two files comparision in 'perf diff', from Jiri Olsa

. A few more 'perf test' improvements, from Jiri Olsa

. libtraceevent cleanups, from Namhyung Kim.

. Remove odd build stall in 'perf sched' by moving a large struct initialization
  from a local variable to a global one, from Namhyung Kim.

. Add support for callchains in the gtk UI, from Namhyung Kim.

. Do not apply symfs for an absolute vmlinux path, fix from Namhyung Kim.

. Use default include path notation for libtraceevent, from Robert Richter.

. Fix 'make tools/perf', from Robert Richter.

. Make Power7 events available, from Runzhen Wang.

. Add --objdump option to 'perf top', from Sukadev Bhattiprolu.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (7):
      perf inject: Remove unused parameter
      perf tools: Fix missing tool parameter
      perf inject: Add missing 'finished_round'
      perf tools: Add const specifier to perf_pmu__find name parameter
      perf evlist: Tidy duplicated munmap code
      perf tools: Validate perf event header size
      perf tools: struct thread has a tid not a pid

Andi Kleen (2):
      perf tools: Default to cpu// for events v5
      perf list: List kernel supplied event aliases

David Ahern (5):
      perf tools: Add methods for setting/retrieving priv element of thread struct
      perf evlist: Fix use of uninitialized variable
      perf tools: Don't free list head in parse_events__free_terms
      perf tests: Make terms a stack variable in test_term
      perf parse events: Demystify memory allocations

Greg Price (1):
      perf report/top: Add option to collapse undesired parts of call graph

Jiri Olsa (30):
      perf tools: Remove cwd from perf_session struct
      perf tests: Omit end of the symbol check failure for test 1
      perf tests: Make TEST_ASSERT_VAL global
      perf tools: Remove callchain_cursor_reset call
      perf tools: Do not elide parent symbol column
      perf report: Fix perf_session__delete removal
      perf tools: Add struct perf_hpp_fmt into hpp callbacks
      perf tools: Centralize default columns init in perf_hpp__init
      perf diff: Introducing diff_data object to hold files
      perf diff: Switching the base hists to be pairs head
      perf hists: Marking dummy hists entries
      perf diff: Display data file info ahead of the diff output
      perf diff: Move diff related columns into diff command
      perf diff: Move columns into struct data__file
      perf diff: Change diff command to work over multiple data files
      perf diff: Update perf diff documentation for multiple data comparison
      perf diff: Making compute functions static
      perf diff: Add generic order option for compute sorting
      perf tools: Move hist_entry__period_snprintf into stdio code
      perf timechart: Use traceevent lib event-parse.h include
      perf timechart: Remove event types framework only user
      perf tools: Remove event types from perf data file
      perf record: Remove event types pushing
      perf tools: Remove event types framework completely
      perf tests: Check proper prev_state size for sched_switch tp
      perf session: Use session->fd instead of passing fd as argument
      perf header: Remove data_offset seek as it's not needed
      perf header: Remove attr_offset from perf_header
      perf header: Introduce feat_offset into perf_header
      perf header: Recognize version number for perf data file

Namhyung Kim (26):
      perf util: Move debugfs/tracing helper functions to util.c
      perf util: Use evsel->name to get tracepoint_paths
      tools lib traceevent: Remove unused install targets
      tools lib traceevent: Get rid of unused gui target
      tools lib traceevent: Add const qualifier to string arguments
      tools lib traceevent: Add trace_seq_reset()
      tools lib traceevent: Add page_size field to pevent
      tools lib traceevent: Port kbuffer parser routines
      perf util: Save page size in a trace file to pevent
      perf util: Save long size of traced system
      perf util: Make file/host_bigendian variable local
      perf util: Skip reading header_event file
      perf util: Parse header_page to get proper long size
      perf util: Get rid of unused header_page_* variables
      perf script: Adopt latency_format variable
      perf util: Rename read_*() functions in trace-event-info.c
      perf util: No need to call read_trace_init() in tracing_data_header()
      perf util: Remove unused enum and macro in trace-event.h
      perf sched: Move struct perf_sched definition out of cmd_sched()
      perf gtk/hists: Use GtkTreeStore instead of GtkListStore
      perf gtk/hists: Add support for callchains
      perf gtk/hists: Display callchain overhead also
      perf gtk/hists: Make column headers resizable
      perf gtk/hists: Add a double-click handler for callchains
      perf gtk/hists: Set rules hint for the hist browser
      perf symbols: Do not apply symfs for an absolute vmlinux path

Robert Richter (2):
      perf tools: Use default include path notation for libtraceevent headers
      perf tools: Fix 'make tools/perf'

Runzhen Wang (1):
      perf tools: Make Power7 events available for perf

Sukadev Bhattiprolu (2):
      perf tools: Rename cpu_map__all() to cpu_map__empty()
      perf top: Add --objdump option

 arch/powerpc/include/asm/perf_event_server.h |   4 +-
 arch/powerpc/perf/power7-events-list.h       | 548 ++++++++++++++++++++
 arch/powerpc/perf/power7-pmu.c               | 148 ++----
 tools/lib/traceevent/Makefile                |  18 +-
 tools/lib/traceevent/event-parse.c           |   7 +-
 tools/lib/traceevent/event-parse.h           |  15 +-
 tools/lib/traceevent/kbuffer-parse.c         | 732 +++++++++++++++++++++++++++
 tools/lib/traceevent/kbuffer.h               |  67 +++
 tools/lib/traceevent/trace-seq.c             |  13 +
 tools/perf/Documentation/perf-diff.txt       |  79 ++-
 tools/perf/Documentation/perf-list.txt       |   4 +-
 tools/perf/Documentation/perf-report.txt     |   5 +
 tools/perf/Documentation/perf-top.txt        |   5 +
 tools/perf/Makefile                          |   4 +-
 tools/perf/builtin-diff.c                    | 662 +++++++++++++++++++-----
 tools/perf/builtin-inject.c                  |  45 +-
 tools/perf/builtin-kmem.c                    |   2 +-
 tools/perf/builtin-list.c                    |   3 +
 tools/perf/builtin-record.c                  |  13 -
 tools/perf/builtin-report.c                  |  60 ++-
 tools/perf/builtin-sched.c                   |  53 +-
 tools/perf/builtin-script.c                  |   2 +-
 tools/perf/builtin-timechart.c               | 176 ++++---
 tools/perf/builtin-top.c                     |  15 +-
 tools/perf/builtin-trace.c                   |   6 +-
 tools/perf/config/Makefile                   |   5 +-
 tools/perf/tests/dso-data.c                  |   8 -
 tools/perf/tests/evsel-tp-sched.c            |   4 +-
 tools/perf/tests/parse-events.c              |  22 +-
 tools/perf/tests/tests.h                     |   8 +
 tools/perf/tests/vmlinux-kallsyms.c          |  15 +-
 tools/perf/ui/browsers/hists.c               |  18 +-
 tools/perf/ui/gtk/hists.c                    | 126 ++++-
 tools/perf/ui/hist.c                         | 258 +---------
 tools/perf/ui/setup.c                        |   1 -
 tools/perf/ui/stdio/hist.c                   |  45 +-
 tools/perf/util/cpumap.h                     |   2 +-
 tools/perf/util/event.c                      |   2 +-
 tools/perf/util/event.h                      |   2 +-
 tools/perf/util/evlist.c                     |  38 +-
 tools/perf/util/evsel.c                      |   8 +-
 tools/perf/util/header.c                     | 150 +-----
 tools/perf/util/header.h                     |  40 +-
 tools/perf/util/hist.c                       |   1 +
 tools/perf/util/hist.h                       |  26 +-
 tools/perf/util/include/linux/string.h       |   1 +
 tools/perf/util/machine.c                    |  46 +-
 tools/perf/util/machine.h                    |   8 +-
 tools/perf/util/parse-events.c               | 112 ++--
 tools/perf/util/parse-events.h               |  11 +-
 tools/perf/util/parse-events.y               |  62 ++-
 tools/perf/util/pmu.c                        |  87 +++-
 tools/perf/util/pmu.h                        |   5 +-
 tools/perf/util/session.c                    |  45 +-
 tools/perf/util/session.h                    |   1 -
 tools/perf/util/sort.c                       |   8 +-
 tools/perf/util/sort.h                       |   7 +
 tools/perf/util/string.c                     |  24 +
 tools/perf/util/symbol.c                     |   7 +-
 tools/perf/util/thread.c                     |  10 +-
 tools/perf/util/thread.h                     |  14 +-
 tools/perf/util/tool.h                       |  10 +-
 tools/perf/util/trace-event-info.c           |  96 +---
 tools/perf/util/trace-event-parse.c          |   6 -
 tools/perf/util/trace-event-read.c           |  52 +-
 tools/perf/util/trace-event.h                |  17 +-
 tools/perf/util/util.c                       |  59 +++
 tools/perf/util/util.h                       |   3 +
 68 files changed, 2948 insertions(+), 1208 deletions(-)
 create mode 100644 arch/powerpc/perf/power7-events-list.h
 create mode 100644 tools/lib/traceevent/kbuffer-parse.c
 create mode 100644 tools/lib/traceevent/kbuffer.h
