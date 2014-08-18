Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wg0-x22d.google.com (mail-wg0-x22d.google.com
 [IPv6:2a00:1450:400c:c00::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E884E1A003D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Aug 2014 18:18:56 +1000 (EST)
Received: by mail-wg0-f45.google.com with SMTP id x12so4550409wgg.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Aug 2014 01:18:50 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 18 Aug 2014 10:18:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [GIT PULL 00/18] perf/core improvements and fixes
Message-ID: <20140818081846.GA13319@gmail.com>
References: <1408121403-11919-1-git-send-email-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408121403-11919-1-git-send-email-acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, Alex Converse <aconverse@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Paul Mackerras <paulus@samba.org>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Jiri Olsa <jolsa@redhat.com>, Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Namhyung Kim <namhyung.kim@lge.com>, Andi Kleen <ak@linux.intel.com>,
 Cody P Schafer <cody@linux.vnet.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Arun Sharma <asharma@fb.com>,
 Naohiro Aota <naota@elisp.net>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Stephane Eranian <eranian@google.com>, yrl.pp-manager.tt@hitachi.com,
 Michael Ellerman <michaele@au1.ibm.com>, Rodrigo Campos <rodrigo@sdfg.com.ar>,
 linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>,
 Brendan Gregg <brendan.d.gregg@gmail.com>, Elliott Hughes <enh@google.com>,
 linuxppc-dev@lists.ozlabs.org
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
> The following changes since commit f373da34282560c60f0c197690eecb1b2dc49fc0:
> 
>   Merge tag 'perf-core-for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2014-08-14 10:38:40 +0200)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo
> 
> for you to fetch changes up to 759e612bf96627b64fcafe4174b3f6f2dedf2c0d:
> 
>   perf stat: Use strerror_r instead of strerror (2014-08-15 13:08:40 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> User visible:
> 
> . Warn user to rebuild target with debuginfo in 'perf probe' (Masami Hiramatsu)
> 
> . Don't truncate Intel style addresses in 'annotate'. (Alex Converse)
> 
> Developer stuff:
> 
> . Annotate PMU related list_head members with type info. (Cody P Schafer)
> 
> . Add the triplet used for arm64 by Android (Elliott Hughes)
> 
> . Replace thread unsafe strerror() with strerror_r() accross the
>   whole tools/perf/ tree (Masami Hiramatsu)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Alex Converse (1):
>       perf annotate: Don't truncate Intel style addresses
> 
> Cody P Schafer (1):
>       perf tools: Annotate PMU related list_head members with type info
> 
> Elliott Hughes (1):
>       perf tools: Add arm64 triplets
> 
> Masami Hiramatsu (14):
>       perf probe: Warn user to rebuild target with debuginfo
>       perf probe: Don't use strerror if strlist__add failed
>       perf: Use strerror_r instead of strerror
>       perf probe: Make error messages thread-safe
>       perf util: Replace strerror with strerror_r for thread-safety
>       perf top: Use strerror_r instead of strerror
>       perf trace: Use strerror_r instead of strerror
>       perf record: Use strerror_r instead of strerror
>       perf test: Use strerror_r instead of strerror
>       perf sched: Use strerror_r instead of strerror
>       perf buildid-cache: Use strerror_r instead of strerror
>       perf kvm: Use strerror_r instead of strerror
>       perf help: Use strerror_r instead of strerror
>       perf stat: Use strerror_r instead of strerror
> 
> Namhyung Kim (1):
>       perf report: Relax -g option parsing not to limit the option order
> 
>  tools/perf/arch/common.c                  |  9 +++
>  tools/perf/builtin-buildid-cache.c        |  7 ++-
>  tools/perf/builtin-help.c                 | 20 +++++--
>  tools/perf/builtin-kvm.c                  |  7 ++-
>  tools/perf/builtin-probe.c                |  5 +-
>  tools/perf/builtin-record.c               |  7 ++-
>  tools/perf/builtin-sched.c                |  4 +-
>  tools/perf/builtin-stat.c                 |  2 +-
>  tools/perf/builtin-top.c                  |  2 +-
>  tools/perf/builtin-trace.c                |  6 +-
>  tools/perf/perf.c                         | 10 +++-
>  tools/perf/tests/builtin-test.c           |  4 +-
>  tools/perf/tests/mmap-basic.c             |  7 ++-
>  tools/perf/tests/open-syscall-all-cpus.c  |  5 +-
>  tools/perf/tests/open-syscall-tp-fields.c |  7 ++-
>  tools/perf/tests/open-syscall.c           |  3 +-
>  tools/perf/tests/perf-record.c            | 13 +++--
>  tools/perf/tests/rdpmc.c                  |  6 +-
>  tools/perf/tests/sw-clock.c               |  6 +-
>  tools/perf/tests/task-exit.c              |  6 +-
>  tools/perf/util/annotate.c                | 12 +++-
>  tools/perf/util/callchain.c               | 95 +++++++++++++------------------
>  tools/perf/util/cloexec.c                 |  6 +-
>  tools/perf/util/data.c                    |  8 ++-
>  tools/perf/util/debug.h                   |  3 +
>  tools/perf/util/dso.c                     |  8 ++-
>  tools/perf/util/evlist.c                  |  2 +-
>  tools/perf/util/evsel.c                   |  7 ++-
>  tools/perf/util/parse-events.c            |  5 +-
>  tools/perf/util/pmu.c                     |  4 +-
>  tools/perf/util/pmu.h                     |  6 +-
>  tools/perf/util/probe-event.c             | 75 +++++++++++++-----------
>  tools/perf/util/probe-finder.c            |  7 ++-
>  tools/perf/util/run-command.c             |  9 ++-
>  tools/perf/util/util.c                    |  5 +-
>  35 files changed, 234 insertions(+), 154 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
