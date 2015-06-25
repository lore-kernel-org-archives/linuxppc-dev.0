Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wg0-x231.google.com (mail-wg0-x231.google.com
 [IPv6:2a00:1450:400c:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB5891A072B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 17:31:50 +1000 (AEST)
Received: by wgqq4 with SMTP id q4so54832202wgq.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 00:31:47 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 25 Jun 2015 09:31:41 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
 He Kuang <hekuang@huawei.com>, Jiri Olsa <jolsa@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, Lukas Wunner <lukas@wunner.de>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Stephane Eranian <eranian@google.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/13] perf/core improvements and fixes
Message-ID: <20150625073141.GA12795@gmail.com>
References: <1435096047-32088-1-git-send-email-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435096047-32088-1-git-send-email-acme@kernel.org>
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
> The following changes since commit a9a3cd900fbbcbf837d65653105e7bfc583ced09:
> 
>   Merge tag 'perf-core-for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2015-06-20 01:11:11 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo
> 
> for you to fetch changes up to 83b2ea257eb1d43e52f76d756722aeb899a2852c:
> 
>   perf tools: Allow auxtrace data alignment (2015-06-23 18:28:37 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> User visible:
> 
> - Move toggling event logic from 'perf top' and into hists browser, allowing
>   freeze/unfreeze with event lists with more than one entry (Namhyung Kim)
> 
> - Add missing newlines when dumping PERF_RECORD_FINISHED_ROUND and
>   showing the Aggregated stats in 'perf report -D' (Adrian Hunter)
> 
> Infrastructure:
> 
> - Allow auxtrace data alignment (Adrian Hunter)
> 
> - Allow events with dot (Andi Kleen)
> 
> - Fix failure to 'perf probe' events on arm (He Kuang)
> 
> - Add testing for Makefile.perf (Jiri Olsa)
> 
> - Add test for make install with prefix (Jiri Olsa)
> 
> - Fix single target build dependency check (Jiri Olsa)
> 
> - Access thread_map entries via accessors, prep patch to hold more info per
>   entry, for ongoing 'perf stat --per-thread' work (Jiri Olsa)
> 
> - Use __weak definition from compiler.h (Sukadev Bhattiprolu)
> 
> - Split perf_pmu__new_alias() (Sukadev Bhattiprolu)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (3):
>       perf session: Print a newline when dumping PERF_RECORD_FINISHED_ROUND
>       perf tools: Print a newline before dumping Aggregated stats
>       perf tools: Allow auxtrace data alignment
> 
> Andi Kleen (1):
>       perf tools: Allow events with dot
> 
> He Kuang (1):
>       perf probe: Fix failure to probe events on arm
> 
> Jiri Olsa (5):
>       perf tests: Add testing for Makefile.perf
>       perf tests: Add test for make install with prefix
>       perf build: Fix single target build dependency check
>       perf thread_map: Don't access the array entries directly
>       perf thread_map: Change map entries into a struct
> 
> Namhyung Kim (1):
>       perf top: Move toggling event logic into hists browser
> 
> Sukadev Bhattiprolu (2):
>       perf pmu: Use __weak definition from <linux/compiler.h>
>       perf pmu: Split perf_pmu__new_alias()
> 
>  tools/perf/Makefile                         |  4 +--
>  tools/perf/builtin-top.c                    | 24 ++-------------
>  tools/perf/builtin-trace.c                  |  4 +--
>  tools/perf/tests/make                       | 31 ++++++++++++++++++--
>  tools/perf/tests/openat-syscall-tp-fields.c |  2 +-
>  tools/perf/ui/browsers/hists.c              | 19 ++++++++++--
>  tools/perf/util/auxtrace.c                  | 11 +++++--
>  tools/perf/util/auxtrace.h                  |  1 +
>  tools/perf/util/event.c                     |  6 ++--
>  tools/perf/util/evlist.c                    |  4 +--
>  tools/perf/util/evsel.c                     |  2 +-
>  tools/perf/util/parse-events.l              |  5 ++--
>  tools/perf/util/pmu.c                       | 45 +++++++++++++++++++----------
>  tools/perf/util/probe-event.c               |  6 +++-
>  tools/perf/util/session.c                   |  4 ++-
>  tools/perf/util/thread_map.c                | 24 ++++++++-------
>  tools/perf/util/thread_map.h                | 16 +++++++++-
>  17 files changed, 136 insertions(+), 72 deletions(-)

Pulled, thanks a lot Arnaldo!

Btw., one small thing I noticed about the status line in perf top: if I ever use 
'f' to freeze/unfreeze events, the following message:

  Press 'f' to disable the events or 'h' to see other hotkeys

sticks around forever, even after I look into annotation and exit it, etc.

So I don't mind some default, helpful message there (such as 'Press 'h' to see 
hotkeys'), but it appears this particular message is context and usage sensitive, 
which wasn't really the goal, right?

Thanks,

	Ingo
