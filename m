Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404mbH2nb1zDrKN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 06:39:07 +1100 (AEDT)
Received: by mail-wr0-x243.google.com with SMTP id l8so19829539wrg.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 12:39:06 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 19 Mar 2018 20:39:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Colin King <colin.king@canonical.com>,
 David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 kernel-janitors@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-trace-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Stephane Eranian <eranian@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Tom Zanussi <tom.zanussi@linux.intel.com>,
 Wang Nan <wangnan0@huawei.com>, Willy Tarreau <w@1wt.eu>,
 Yisheng Xie <xieyisheng1@huawei.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/14] perf/core improvements and fixes
Message-ID: <20180319193900.27fk6paow6fy4gkk@gmail.com>
References: <20180319190136.7441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180319190136.7441-1-acme@kernel.org>
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
> 	Please consider pulling, this has those 31 patches that were
> blocked due to some problems (author not being the fist S-o-B, build
> broken on ppc), those issues should all be fixed and then we have 14
> patches more, described in the signed tag.
> 
> Regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 10f354a36f9a9aa1b8bffe0abc1cd43822a85bcd:
> 
>   perf test: Fix exit code for record+probe_libc_inet_pton.sh (2018-03-16 13:56:31 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180319
> 
> for you to fetch changes up to 1cd618838b9703eabe4a75badf433382b12f6bef:
> 
>   perf tests bp_account: Fix build with clang-6 (2018-03-19 13:51:54 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Fixes for problems experienced with new gcc 8 warnings, that treated
>   as errors, broke the build, related to snprintf and casting issues.
>   (Arnaldo Carvalho de Melo, Jiri Olsa, Josh Poinboeuf)
> 
> - Fix build of new breakpoint 'perf test' entry with clang < 6, noticed
>   on fedora 25, 26 and 27 (Arnaldo Carvalho de Melo)
> 
> - Workaround problem with symbol resolution in 'perf annotate', using
>   the symbol name already present in the objdump output (Arnaldo Carvalho de Melo)
> 
> - Document 'perf top --ignore-vmlinux' (Arnaldo Carvalho de Melo)
> 
> - Fix out of bounds access on array fd when cnt is 100 in one of the
>   'perf test' entries, detected using 'cpptest' (Colin Ian King)
> 
> - Add support for the forced leader feature, i.e. 'perf report --group'
>   for a group of events not really grouped when scheduled (without using
>   {} to enclose the list of events in the command line) in pipe mode,
>   e.g.:
> 
>   $ perf record -e cycles,instructions -o - kill | perf report --group -i -
> 
> - Use right type to access array elements in 'perf probe' (Masami Hiramatsu)
> 
> - Update POWER9 vendor events (those described in JSON format) (Sukadev Bhattiprolu)
> 
> - Discard head in overwrite_rb_find_range() (Yisheng Xie)
> 
> - Avoid setting 'quiet' to 'true' unnecessarily (Yisheng Xie)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (4):
>       perf annotate: Use asprintf when formatting objdump command line
>       perf top: Document --ignore-vmlinux
>       perf annotate: Use ops->target.name when available for unresolved call targets
>       perf tests bp_account: Fix build with clang-6
> 
> Colin Ian King (1):
>       perf tests: Fix out of bounds access on array fd when cnt is 100
> 
> Jiri Olsa (4):
>       perf record: Synthesize features before events in pipe mode
>       perf report: Support forced leader feature in pipe mode
>       perf tools: Fix snprint warnings for gcc 8
>       perf tools: Fix python extension build for gcc 8
> 
> Josh Poimboeuf (1):
>       objtool, perf: Fix GCC 8 -Wrestrict error
> 
> Masami Hiramatsu (1):
>       perf probe: Use right type to access array elements
> 
> Sukadev Bhattiprolu (1):
>       perf vendor events: Update POWER9 events
> 
> Yisheng Xie (2):
>       perf mmap: Discard head in overwrite_rb_find_range()
>       perf debug: Avoid setting 'quiet' to 'true' unnecessarily
> 
>  tools/lib/str_error_r.c                            |   2 +-
>  tools/perf/Documentation/perf-top.txt              |   3 +
>  tools/perf/builtin-record.c                        |  18 +-
>  tools/perf/builtin-report.c                        |  57 +++--
>  tools/perf/builtin-script.c                        |  22 +-
>  .../perf/pmu-events/arch/powerpc/power9/cache.json |  25 ---
>  .../pmu-events/arch/powerpc/power9/frontend.json   |  10 -
>  .../pmu-events/arch/powerpc/power9/marked.json     |   5 -
>  .../pmu-events/arch/powerpc/power9/memory.json     |   5 -
>  .../perf/pmu-events/arch/powerpc/power9/other.json | 241 ++++++++++++++-------
>  .../pmu-events/arch/powerpc/power9/pipeline.json   |  50 ++---
>  tools/perf/pmu-events/arch/powerpc/power9/pmc.json |   5 -
>  .../arch/powerpc/power9/translation.json           |  10 +-
>  tools/perf/tests/attr.c                            |   4 +-
>  tools/perf/tests/bp_account.c                      |  10 +-
>  tools/perf/tests/mem.c                             |   2 +-
>  tools/perf/tests/pmu.c                             |   2 +-
>  tools/perf/util/annotate.c                         |  20 +-
>  tools/perf/util/cgroup.c                           |   2 +-
>  tools/perf/util/debug.c                            |   1 -
>  tools/perf/util/header.c                           |  11 +-
>  tools/perf/util/mmap.c                             |  15 +-
>  tools/perf/util/parse-events.c                     |   4 +-
>  tools/perf/util/pmu.c                              |   2 +-
>  tools/perf/util/probe-finder.c                     |  13 +-
>  tools/perf/util/setup.py                           |   2 +
>  26 files changed, 298 insertions(+), 243 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
