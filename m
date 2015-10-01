Return-Path: <mingo.kernel.org@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E8C621A006C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 17:05:33 +1000 (AEST)
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com
 [IPv6:2a00:1450:400c:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 25A85140D69
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Oct 2015 17:05:32 +1000 (AEST)
Received: by wiclk2 with SMTP id lk2so14122674wic.1
 for <linuxppc-dev@ozlabs.org>; Thu, 01 Oct 2015 00:05:30 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 1 Oct 2015 09:05:26 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Borislav Petkov <bp@suse.de>, Chandler Carruth <chandlerc@gmail.com>,
 David Ahern <dsahern@gmail.com>,
 Dominik Dingel <dingel@linux.vnet.ibm.com>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 He Kuang <hekuang@huawei.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Jiri Olsa <jolsa@redhat.com>, linuxppc-dev@ozlabs.org,
 linux-tip-commits@vger.kernel.org,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Matt Fleming <matt@codeblueprint.co.uk>,
 Namhyung Kim <namhyung@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Raphael Beamonte <raphael.beamonte@gmail.com>,
 Stephane Eranian <eranian@google.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vinson Lee <vlee@twopensource.com>, Wang Nan <wangnan0@huawei.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/16] perf/core improvements and fixes
Message-ID: <20151001070526.GA11393@gmail.com>
References: <1443650111-31140-1-git-send-email-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443650111-31140-1-git-send-email-acme@kernel.org>
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
> The following changes since commit 9c17dbc6eb73bdd8a6aaea1baefd37ff78d86148:
> 
>   Merge tag 'perf-core-for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2015-09-29 09:43:46 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo
> 
> for you to fetch changes up to 7f8d1ade1b19f684ed3a7c4fb1dc5d347127b438:
> 
>   perf tools: By default use the most precise "cycles" hw counter available (2015-09-30 18:34:39 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> User visible:
> 
> - By default use the most precise "cycles" hw counter available, i.e.
>   when the user doesn't specify any event, it will try using cycles:ppp,
>   cycles:pp, etc (Arnaldo Carvalho de Melo)

That looks really useful!

> - Remove blank lines, headers when piping output in 'perf list', so that it can
>   be sanely used with 'wc -l', etc (Arnaldo Carvalho de Melo)
> 
> - Amend documentation about max_stack and synthesized callchains (Adrian Hunter)
> 
> - Fix 'perf probe -l' for probes added to kernel module functions (Masami Hiramatsu)
> 
> Build fixes:
> 
> - Fix shadowed declarations that break the build on older distros (Jiri Olsa)
> 
> - Fix build break on powerpc due to sample_reg_masks (Sukadev Bhattiprolu)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (1):
>       perf report: Amend documentation about max_stack and synthesized callchains
> 
> Arnaldo Carvalho de Melo (7):
>       perf maps: Introduce maps__find_symbol_by_name()
>       perf machine: Use machine__kernel_map() thoroughly
>       perf machine: Add method for common kernel_map(FUNCTION) operation
>       tools lib symbol: Rename kallsyms2elf_type to kallsyms2elf_binding
>       tools lib symbol: Introduce kallsyms2elf_type
>       perf list: Remove blank lines, headers when piping output
>       perf tools: By default use the most precise "cycles" hw counter available
> 
> Jiri Olsa (2):
>       tools: Fix shadowed declaration in err.h
>       perf tools: Fix shadowed declaration in parse-events.c
> 
> Masami Hiramatsu (5):
>       perf probe: Fix to remove dot suffix from second or latter events
>       perf probe: Begin and end libdwfl report session correctly
>       perf probe: Show correct source lines of probes on kmodules
>       perf probe: Fix a segfault bug in debuginfo_cache
>       perf probe: Improve error message when %return is on inlined function
> 
> Sukadev Bhattiprolu (1):
>       perf tools: Fix build break on powerpc due to sample_reg_masks
> 
>  tools/include/linux/err.h                |  4 +-
>  tools/lib/symbol/kallsyms.c              |  6 ++
>  tools/lib/symbol/kallsyms.h              |  4 +-
>  tools/perf/Documentation/perf-report.txt |  2 +
>  tools/perf/builtin-kmem.c                |  2 +-
>  tools/perf/builtin-list.c                |  2 +-
>  tools/perf/builtin-report.c              |  2 +-
>  tools/perf/tests/code-reading.c          |  2 +-
>  tools/perf/tests/vmlinux-kallsyms.c      |  4 +-
>  tools/perf/util/Build                    |  2 +-
>  tools/perf/util/event.c                  |  7 +--
>  tools/perf/util/evlist.c                 | 22 +++++++-
>  tools/perf/util/intel-pt.c               |  2 +-
>  tools/perf/util/machine.c                | 26 ++++-----
>  tools/perf/util/machine.h                |  8 ++-
>  tools/perf/util/map.c                    | 21 ++++---
>  tools/perf/util/map.h                    |  2 +
>  tools/perf/util/parse-events.c           | 53 +++++++++---------
>  tools/perf/util/perf_regs.c              |  2 +
>  tools/perf/util/perf_regs.h              |  1 +
>  tools/perf/util/pmu.c                    |  2 +-
>  tools/perf/util/probe-event.c            | 96 ++++++++++++++++++++------------
>  tools/perf/util/probe-finder.c           | 58 +++++++++++++++++--
>  tools/perf/util/symbol.c                 |  2 +-
>  24 files changed, 224 insertions(+), 108 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
