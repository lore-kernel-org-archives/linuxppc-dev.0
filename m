Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fltl1N8GzF14s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 15:51:42 +1000 (AEST)
Received: by mail-wr1-x444.google.com with SMTP id e7-v6so15209805wrs.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 22:51:42 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 31 Jul 2018 07:51:35 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Dan Williams <dan.j.williams@intel.com>, David Ahern <dsahern@gmail.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 Jiri Olsa <jolsa@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Thomas Richter <tmricht@linux.vnet.ibm.com>,
 Tony Luck <tony.luck@intel.com>, Vince Weaver <vincent.weaver@maine.edu>,
 Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/5] perf/urgent fixes
Message-ID: <20180731055135.GA29199@gmail.com>
References: <20180730205031.12853-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730205031.12853-1-acme@kernel.org>
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
> 	Please consider pulling, just to get the build without warnings
> and finishing successfully in all my test environments,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 7f635ff187ab6be0b350b3ec06791e376af238ab:
> 
>   perf/core: Fix crash when using HW tracing kernel filters (2018-07-25 11:46:22 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.18-20180730
> 
> for you to fetch changes up to 44fe619b1418ff4e9d2f9518a940fbe2fb686a08:
> 
>   perf tools: Fix the build on the alpine:edge distro (2018-07-30 13:15:03 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes: (Arnaldo Carvalho de Melo)
> 
> - Update the tools copy of several files, including perf_event.h,
>   powerpc's asm/unistd.h (new io_pgetevents syscall), bpf.h and
>   x86's memcpy_64.s (used in 'perf bench mem'), silencing the
>   respective warnings during the perf tools build.
> 
> - Fix the build on the alpine:edge distro.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (5):
>       tools headers uapi: Update tools's copy of linux/perf_event.h
>       tools headers powerpc: Update asm/unistd.h copy to pick new
>       tools headers uapi: Refresh linux/bpf.h copy
>       tools arch: Update arch/x86/lib/memcpy_64.S copy used in 'perf bench mem memcpy'
>       perf tools: Fix the build on the alpine:edge distro
> 
>  tools/arch/powerpc/include/uapi/asm/unistd.h |   1 +
>  tools/arch/x86/include/asm/mcsafe_test.h     |  13 ++++
>  tools/arch/x86/lib/memcpy_64.S               | 112 +++++++++++++--------------
>  tools/include/uapi/linux/bpf.h               |  28 +++++--
>  tools/include/uapi/linux/perf_event.h        |   2 +
>  tools/perf/arch/x86/util/pmu.c               |   1 +
>  tools/perf/arch/x86/util/tsc.c               |   1 +
>  tools/perf/bench/Build                       |   1 +
>  tools/perf/bench/mem-memcpy-x86-64-asm.S     |   1 +
>  tools/perf/bench/mem-memcpy-x86-64-lib.c     |  24 ++++++
>  tools/perf/perf.h                            |   1 +
>  tools/perf/util/header.h                     |   1 +
>  tools/perf/util/namespaces.h                 |   1 +
>  13 files changed, 124 insertions(+), 63 deletions(-)
>  create mode 100644 tools/arch/x86/include/asm/mcsafe_test.h
>  create mode 100644 tools/perf/bench/mem-memcpy-x86-64-lib.c

Pulled, thanks a lot Arnaldo!

	Ingo
