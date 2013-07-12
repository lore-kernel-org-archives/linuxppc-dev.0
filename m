Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-ee0-x232.google.com (mail-ee0-x232.google.com
 [IPv6:2a00:1450:4013:c00::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7033B2C0344
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 17:46:20 +1000 (EST)
Received: by mail-ee0-f50.google.com with SMTP id d49so6112305eek.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 00:46:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 12 Jul 2013 09:46:11 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@infradead.org>
Subject: Re: [GIT PULL 00/23] perf/urgent fixes
Message-ID: <20130712074611.GA787@gmail.com>
References: <1373483963-19277-1-git-send-email-acme@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373483963-19277-1-git-send-email-acme@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Stephane Eranian <eranian@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Mackerras <paulus@samba.org>, Robert Richter <rric@kernel.org>,
 Jiri Olsa <jolsa@redhat.com>, Ramkumar Ramachandra <artagnon@gmail.com>,
 Andi Kleen <ak@linux.intel.com>, Hitoshi Mitake <h.mitake@gmail.com>,
 Michael Witten <mfwitten@gmail.com>,
 Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Ingo Molnar <mingo@elte.hu>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Mike Frysinger <vapier@gentoo.org>, icycoder@gmail.com,
 Corey Ashford <cjashfor@linux.vnet.ibm.com>,
 Runzhen Wang <runzhew@clemson.edu>, Steven Rostedt <rostedt@goodmis.org>,
 zheng.z.yan@intel.com, Namhyung Kim <namhyung@kernel.org>,
 Waiman Long <Waiman.Long@hp.com>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, Mike Galbraith <efault@gmx.de>,
 linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
 David Ahern <dsahern@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Arnaldo Carvalho de Melo <acme@infradead.org> wrote:

> From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
> 
> Hi Ingo,
> 
> 	Please consider pulling,
> 
> Regards,
> 
> - Arnaldo
> 
> The following changes since commit e5302920da9ef23f9d19d4e9ac85704cc25bee7a:
> 
>   perf: Fix interrupt handler timing harness (2013-07-05 08:54:43 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux tags/perf-urgent-for-mingo
> 
> for you to fetch changes up to 750ade7e82709c2835cb221a7b6a9ef0a6a9c0ac:
> 
>   perf script: Fix broken include in Context.xs (2013-07-10 13:47:00 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> . Fix some freeing bugs on the parsing error paths, from Adrian Hunter.
> 
> . Update symbol_conf.nr_events when processing attribute events, fix from Adrian Hunter.
> 
> . Fix missing increment in sample parsing when PERF_SAMPLE_STACK_USER
>   is present, from Adrian Hunt.
> 
> . Fix count parameter to read call in event_format__new, from David Ahern.
> 
> . Remove -A/--append option, not working for a long time, from Jiri Olsa.
> 
> . Remove -f/--force option, was a no-op for quite some time, from Jiri Olsa.
> 
> . Fix -x/--exclude-other option for report command, from Jiri Olsa.
> 
> . Cross build fixes, at least one for Android, from Joonsoo Kim.
> 
> . Fix memory allocation fail check in mem{set,cpy} 'perf bench' workloads,
>   from Kirill A. Shutemov.
> 
> . Revert regression in configuration of Python support, from Michael Witten.
> 
> . Fix -ldw/-lelf link test when static linking, from Mike Frysinger.
> 
> . Fix issues with multiple children processing in perf_evlist__start_workload(),
>   from Namhyung Kim.
> 
> . Fix broken include in Context.xs ('perf script'), from Ramkumar Ramachandra.
> 
> . Fixes for build problems, from Robert Richter.
> 
> . Fix a typo of a Power7 event name, from Runzhen Wang.
> 
> . Avoid sending SIGTERM to random processes in 'perf stat', fix from Stephane Eranian.
> 
> . Fix per-socket output bug for uncore events in 'perf stat', from Stephane Eranian.
> 
> . Fix vdso list searching, from Waiman Long.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (4):
>       perf tools: Fix parse_events_terms() segfault on error path
>       perf tools: Fix new_term() missing free on error path
>       perf tools: Update symbol_conf.nr_events when processing attribute events
>       perf evsel: Fix missing increment in sample parsing
> 
> David Ahern (1):
>       perf evsel: Fix count parameter to read call in event_format__new
> 
> Jiri Olsa (3):
>       perf record: Remove -A/--append option
>       perf record: Remove -f/--force option
>       perf tools: Fix -x/--exclude-other option for report command
> 
> Joonsoo Kim (2):
>       perf tools: Include termios.h explicitly
>       tools lib lk: Fix for cross build
> 
> Kirill A. Shutemov (1):
>       perf bench: Fix memory allocation fail check in mem{set,cpy} workloads
> 
> Michael Witten (1):
>       perf tools: Revert regression in configuration of Python support
> 
> Mike Frysinger (1):
>       perf tools: Fix -ldw/-lelf link test when static linking
> 
> Namhyung Kim (1):
>       perf evlist: Enhance perf_evlist__start_workload()
> 
> Ramkumar Ramachandra (1):
>       perf script: Fix broken include in Context.xs
> 
> Robert Richter (4):
>       tools: Get only verbose output with V=1
>       perf tools: Fix output directory of Documentation/
>       perf tools: Fix build errors with O and DESTDIR make vars set
>       perf tools: Fix perf version generation
> 
> Runzhen Wang (1):
>       perf tools: fix a typo of a Power7 event name
> 
> Stephane Eranian (2):
>       perf stat: Avoid sending SIGTERM to random processes
>       perf stat: Fix per-socket output bug for uncore events
> 
> Waiman Long (1):
>       perf symbols: Fix vdso list searching
> 
>  .../testing/sysfs-bus-event_source-devices-events  |  2 +-
>  arch/powerpc/perf/power7-pmu.c                     | 12 +--
>  tools/lib/lk/Makefile                              | 17 ++++-
>  tools/perf/Documentation/Makefile                  | 12 +--
>  tools/perf/Documentation/examples.txt              |  4 +-
>  tools/perf/Documentation/perf-record.txt           |  8 +-
>  tools/perf/Makefile                                |  5 +-
>  tools/perf/bench/mem-memcpy.c                      |  4 +-
>  tools/perf/bench/mem-memset.c                      |  2 +-
>  tools/perf/builtin-diff.c                          |  1 -
>  tools/perf/builtin-kmem.c                          |  2 +-
>  tools/perf/builtin-lock.c                          |  2 +-
>  tools/perf/builtin-record.c                        | 85 +++-------------------
>  tools/perf/builtin-report.c                        |  3 +-
>  tools/perf/builtin-sched.c                         |  1 -
>  tools/perf/builtin-stat.c                          | 30 +++++++-
>  tools/perf/builtin-timechart.c                     |  4 +-
>  tools/perf/builtin-top.c                           |  2 -
>  tools/perf/config/Makefile                         |  6 +-
>  tools/perf/config/utilities.mak                    |  4 +-
>  tools/perf/scripts/perl/Perf-Trace-Util/Context.xs |  2 +-
>  tools/perf/util/PERF-VERSION-GEN                   | 21 ++++--
>  tools/perf/util/dso.c                              | 10 ++-
>  tools/perf/util/dso.h                              |  3 +-
>  tools/perf/util/evlist.c                           | 10 ++-
>  tools/perf/util/evsel.c                            |  4 +-
>  tools/perf/util/header.c                           | 15 +---
>  tools/perf/util/parse-events.c                     |  4 +-
>  tools/perf/util/symbol.c                           |  1 -
>  tools/perf/util/util.h                             |  2 +-
>  tools/perf/util/vdso.c                             |  2 +-
>  tools/scripts/Makefile.include                     |  2 +-
>  32 files changed, 125 insertions(+), 157 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
