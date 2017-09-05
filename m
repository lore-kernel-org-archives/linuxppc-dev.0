Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmZg13QtczDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 15:15:40 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id r75so1978490wmf.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Sep 2017 22:15:40 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 5 Sep 2017 07:15:34 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Anton Blanchard <anton@au1.ibm.com>,
 Flavio Bruno Leitner <fbl@redhat.com>,
 Jack Henschel <jackdev@mailbox.org>, Jiri Olsa <jolsa@redhat.com>,
 Kan Liang <kan.liang@intel.com>, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Taeung Song <treeze.taeung@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Wang Nan <wangnan0@huawei.com>, Yao Jin <yao.jin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/13] perf/core improvements and fixes
Message-ID: <20170905051534.p5xzgpcfrizcx67u@gmail.com>
References: <20170904140044.22912-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170904140044.22912-1-acme@kernel.org>
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
> The following changes since commit 1b2f76d77a277bb70d38ad0991ed7f16bbc115a9:
> 
>   Merge tag 'perf-core-for-mingo-4.14-20170829' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-08-29 23:13:56 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.14-20170901
> 
> for you to fetch changes up to eba9fac017617e685d648339e29a1453a30cb065:
> 
>   perf annotate browser: Help for cycling thru hottest instructions with TAB/shift+TAB (2017-09-01 14:55:40 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Support syscall name glob matching in 'perf trace' (Arnaldo Carvalho de Melo)
> 
>   e.g.:
> 
>    # perf trace -e pkey_*
>    32.784 (0.006 ms): pkey/16018 pkey_alloc(init_val: DISABLE_WRITE) = -1 EINVAL Invalid argument
>    32.795 (0.004 ms): pkey/16018 pkey_mprotect(start: 0x7f380d0a6000, len: 4096, prot: READ|WRITE, pkey: -1) = 0
>    32.801 (0.002 ms): pkey/16018 pkey_free(pkey: -1                ) = -1 EINVAL Invalid argument
>    ^C#
> 
> - Do not auto merge counts for explicitely specified events in
>   'perf stat' (Arnaldo Carvalho de Melo)
> 
> - Fix syntax in documentation of .perfconfig intel-pt option (Jack Henschel)
> 
> - Calculate the average cycles of iterations for loops detected by the
>   branch history support in 'perf report' (Jin Yao)
> 
> - Support PERF_SAMPLE_PHYS_ADDR as a sort key "phys_daddr" in the 'script', 'mem',
>   'top' and 'report'. Also add a test entry for it in 'perf test' (Kan Liang)
> 
> - Fix 'Object code reading' 'perf test' entry in PowerPC (Ravi Bangoria)
> 
> - Remove some duplicate Power9 duplicate vendor events (described in JSON
>   files) (Sukadev Bhattiprolu)
> 
> - Add help entry in the TUI annotate browser about cycling thru hottest
>   instructions with TAB/shift+TAB (Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (4):
>       perf syscalltbl: Support glob matching on syscall names
>       perf trace: Support syscall name globbing
>       perf stat: Only auto-merge events that are PMU aliases
>       perf annotate browser: Help for cycling thru hottest instructions with TAB/shift+TAB
> 
> Jack Henschel (1):
>       perf intel-pt: Fix syntax in documentation of config option
> 
> Jin Yao (1):
>       perf report: Calculate the average cycles of iterations
> 
> Kan Liang (5):
>       perf tools: Support new sample type for physical address
>       perf sort: Add sort option for physical address
>       perf mem: Support physical address
>       perf script: Support physical address
>       perf test: Add test case for PERF_SAMPLE_PHYS_ADDR
> 
> Ravi Bangoria (1):
>       perf test powerpc: Fix 'Object code reading' test
> 
> Sukadev Bhattiprolu (1):
>       perf vendor events powerpc: Remove duplicate events
> 
>  tools/include/uapi/linux/perf_event.h              |   4 +-
>  tools/perf/Documentation/intel-pt.txt              |   2 +-
>  tools/perf/Documentation/perf-mem.txt              |   4 +
>  tools/perf/Documentation/perf-record.txt           |   5 +-
>  tools/perf/Documentation/perf-report.txt           |   1 +
>  tools/perf/Documentation/perf-script.txt           |   2 +-
>  tools/perf/Documentation/perf-trace.txt            |   2 +-
>  tools/perf/builtin-mem.c                           |  97 ++++++++++++-----
>  tools/perf/builtin-record.c                        |   2 +
>  tools/perf/builtin-script.c                        |  15 ++-
>  tools/perf/builtin-stat.c                          |   2 +-
>  tools/perf/builtin-trace.c                         |  39 ++++++-
>  tools/perf/perf.h                                  |   1 +
>  .../pmu-events/arch/powerpc/power9/frontend.json   |   7 +-
>  .../perf/pmu-events/arch/powerpc/power9/other.json | 120 ---------------------
>  .../pmu-events/arch/powerpc/power9/pipeline.json   |   7 +-
>  tools/perf/pmu-events/arch/powerpc/power9/pmc.json |   7 +-
>  tools/perf/tests/code-reading.c                    |   5 +
>  tools/perf/tests/sample-parsing.c                  |   6 +-
>  tools/perf/ui/browsers/annotate.c                  |   3 +-
>  tools/perf/ui/browsers/hists.c                     |   8 +-
>  tools/perf/ui/stdio/hist.c                         |  10 +-
>  tools/perf/util/callchain.c                        |  49 ++++-----
>  tools/perf/util/callchain.h                        |   9 +-
>  tools/perf/util/event.h                            |   1 +
>  tools/perf/util/evsel.c                            |  19 +++-
>  tools/perf/util/evsel.h                            |   1 +
>  tools/perf/util/hist.c                             |   4 +
>  tools/perf/util/hist.h                             |   1 +
>  tools/perf/util/machine.c                          |  96 ++++++++++-------
>  tools/perf/util/parse-events.c                     |  24 +++--
>  tools/perf/util/session.c                          |   3 +
>  tools/perf/util/sort.c                             |  42 ++++++++
>  tools/perf/util/sort.h                             |   1 +
>  tools/perf/util/symbol.h                           |   1 +
>  tools/perf/util/syscalltbl.c                       |  33 ++++++
>  tools/perf/util/syscalltbl.h                       |   3 +
>  37 files changed, 368 insertions(+), 268 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
