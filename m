Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkYqZ5kfYzDqBt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 03:30:34 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id n11so10627937wma.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 09:30:34 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 16 Mar 2017 17:30:28 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Anton Blanchard <anton@ozlabs.org>, Borislav Petkov <bp@suse.de>,
 Brendan Gregg <brendan.d.gregg@gmail.com>,
 David Ahern <dsahern@gmail.com>, David Miller <davem@davemloft.net>,
 He Kuang <hekuang@huawei.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Jiri Olsa <jolsa@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Taeung Song <treeze.taeung@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Wang Nan <wangnan0@huawei.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/6] perf/core improvements and fixes
Message-ID: <20170316163028.GA31842@gmail.com>
References: <20170316161002.15445-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170316161002.15445-1-acme@kernel.org>
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
> The following changes since commit ffa86c2f1a8862cf58c873f6f14d4b2c3250fb48:
> 
>   Merge tag 'perf-core-for-mingo-4.12-20170314' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-03-15 19:27:27 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.12-20170316
> 
> for you to fetch changes up to 61f35d750683b21e9e3836e309195c79c1daed74:
> 
>   uprobes: Default UPROBES_EVENTS to Y (2017-03-16 12:42:02 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> New features:
> 
> - Add 'brstackinsn' field in 'perf script' to reuse the x86 instruction
>   decoder used in the Intel PT code to study hot paths to samples (Andi Kleen)
> 
> Kernel:
> 
> - Default UPROBES_EVENTS to Y (Alexei Starovoitov)
> 
> - Fix check for kretprobe offset within function entry (Naveen N. Rao)
> 
> Infrastructure:
> 
> - Introduce util func is_sdt_event() (Ravi Bangoria)
> 
> - Make perf_event__synthesize_mmap_events() scale on older kernels where
>   reading /proc/pid/maps is way slower than reading /proc/pid/task/pid/maps (Stephane Eranian)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (1):
>       perf script: Add 'brstackinsn' for branch stacks
> 
> Arnaldo Carvalho de Melo (2):
>       tools headers: Sync {tools/,}arch/x86/include/asm/cpufeatures.h
>       uprobes: Default UPROBES_EVENTS to Y
> 
> Naveen N. Rao (1):
>       trace/kprobes: Fix check for kretprobe offset within function entry
> 
> Ravi Bangoria (1):
>       perf probe: Introduce util func is_sdt_event()
> 
> Stephane Eranian (1):
>       perf tools: Make perf_event__synthesize_mmap_events() scale
> 
>  include/linux/kprobes.h                            |   1 +
>  kernel/kprobes.c                                   |  40 ++--
>  kernel/trace/Kconfig                               |   2 +-
>  kernel/trace/trace_kprobe.c                        |   2 +-
>  tools/arch/x86/include/asm/cpufeatures.h           |   5 +-
>  tools/perf/Documentation/perf-script.txt           |  13 +-
>  tools/perf/builtin-script.c                        | 264 ++++++++++++++++++++-
>  tools/perf/util/Build                              |   1 +
>  tools/perf/util/dump-insn.c                        |  14 ++
>  tools/perf/util/dump-insn.h                        |  22 ++
>  tools/perf/util/event.c                            |   4 +-
>  .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |  24 ++
>  tools/perf/util/parse-events.h                     |  20 ++
>  tools/perf/util/probe-event.c                      |   9 +-
>  14 files changed, 381 insertions(+), 40 deletions(-)
>  create mode 100644 tools/perf/util/dump-insn.c
>  create mode 100644 tools/perf/util/dump-insn.h

Pulled, thanks a lot Arnaldo!

	Ingo
