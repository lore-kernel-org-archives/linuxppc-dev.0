Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtCWd2dPZzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:13:33 +1000 (AEST)
Received: by mail-wr0-x241.google.com with SMTP id 77so28585239wrb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 11:13:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 21 Jun 2017 20:13:27 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>,
 linuxppc-dev@lists.ozlabs.org, Milian Wolff <milian.wolff@kdab.com>,
 Namhyung Kim <namhyung@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Robert Elliott <elliott@hpe.com>, Stephane Eranian <eranian@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Wang Nan <wangnan0@huawei.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/25] perf/core improvements and fixes
Message-ID: <20170621181327.f563kmznmtmaun3m@gmail.com>
References: <20170621180245.23134-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170621180245.23134-1-acme@kernel.org>
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
> The following changes since commit 007b811b4041989ec2dc91b9614aa2c41332723e:
> 
>   Merge tag 'perf-core-for-mingo-4.13-20170719' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-06-20 10:49:08 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.13-20170621
> 
> for you to fetch changes up to 701516ae3dec801084bc913d21e03fce15c61a0b:
> 
>   perf script: Fix message because field list option is -F not -f (2017-06-21 11:35:53 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements ad fixes:
> 
> New features:
> 
> - Add support to measure SMI cost in 'perf stat' (Kan Liang)
> 
> - Add support for unwinding callchains in powerpc with libdw (Paolo Bonzini)
> 
> Fixes:
> 
> - Fix message: cpu list option is -C not -c (Adrian Hunter)
> 
> - Fix 'perf script' message: field list option is -F not -f (Adrian Hunter)
> 
> - Intel PT fixes: (Adrian Hunter)
> 
>   o Fix missing stack clear
>   o Ensure IP is zero when state is INTEL_PT_STATE_NO_IP
>   o Fix last_ip usage
>   o Ensure never to set 'last_ip' when packet 'count' is zero
>   o Clear FUP flag on error
>   o Fix transactions_sample_type
> 
> Infrastructure:
> 
> - Intel PT cleanups/refactorings (Adrian Hunter)
> 
>   o Use FUP always when scanning for an IP
>   o Add missing __fallthrough
>   o Remove redundant initial_skip checks
>   o Allow decoding with branch tracing disabled
>   o Add default config for pass-through branch enable
>   o Add documentation for new config terms
>   o Add decoder support for ptwrite and power event packets
>   o Add reserved byte to CBR packet payload
>   o Add decoder support for CBR events
> 
> - Move  find_process() to the only place that uses it, skimming some
>   more fat from util.[ch] (Arnaldo Carvalho de Melo)
> 
> - Do parameter validation earlier on fetch_kernel_version() (Arnaldo Carvalho de Melo)
> 
> - Remove unused _ALL_SOURCE define (Arnaldo Carvalho de Melo)
> 
> - Add sysfs__write_int function (Kan Liang)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (19):
>       perf intel-pt: Move decoder error setting into one condition
>       perf intel-pt: Improve sample timestamp
>       perf intel-pt: Fix missing stack clear
>       perf intel-pt: Ensure IP is zero when state is INTEL_PT_STATE_NO_IP
>       perf intel-pt: Fix last_ip usage
>       perf intel-pt: Ensure never to set 'last_ip' when packet 'count' is zero
>       perf intel-pt: Use FUP always when scanning for an IP
>       perf intel-pt: Clear FUP flag on error
>       perf intel-pt: Add missing __fallthrough
>       perf intel-pt: Allow decoding with branch tracing disabled
>       perf intel-pt: Add default config for pass-through branch enable
>       perf intel-pt: Add documentation for new config terms
>       perf intel-pt: Add decoder support for ptwrite and power event packets
>       perf intel-pt: Add reserved byte to CBR packet payload
>       perf intel-pt: Add decoder support for CBR events
>       perf intel-pt: Remove redundant initial_skip checks
>       perf intel-pt: Fix transactions_sample_type
>       perf tools: Fix message because cpu list option is -C not -c
>       perf script: Fix message because field list option is -F not -f
> 
> Arnaldo Carvalho de Melo (3):
>       perf evsel: Adopt find_process()
>       perf tools: Do parameter validation earlier on fetch_kernel_version()
>       perf tools: Remove unused _ALL_SOURCE define
> 
> Kan Liang (2):
>       tools lib api fs: Add sysfs__write_int function
>       perf stat: Add support to measure SMI cost
> 
> Paolo Bonzini (1):
>       perf unwind: Support for powerpc
> 
>  tools/lib/api/fs/fs.c                              |  30 +++
>  tools/lib/api/fs/fs.h                              |   4 +
>  tools/perf/Documentation/intel-pt.txt              |  36 +++
>  tools/perf/Documentation/perf-stat.txt             |  14 +
>  tools/perf/Makefile.config                         |   2 +-
>  tools/perf/arch/powerpc/util/Build                 |   2 +
>  tools/perf/arch/powerpc/util/unwind-libdw.c        |  73 ++++++
>  tools/perf/arch/x86/util/intel-pt.c                |   5 +
>  tools/perf/builtin-script.c                        |   2 +-
>  tools/perf/builtin-stat.c                          |  49 ++++
>  tools/perf/util/evsel.c                            |  39 +++
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 290 +++++++++++++++++++--
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |  13 +
>  .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   | 110 +++++++-
>  .../util/intel-pt-decoder/intel-pt-pkt-decoder.h   |   7 +
>  tools/perf/util/intel-pt.c                         |  23 +-
>  tools/perf/util/session.c                          |   2 +-
>  tools/perf/util/stat-shadow.c                      |  33 +++
>  tools/perf/util/stat.c                             |   2 +
>  tools/perf/util/stat.h                             |   2 +
>  tools/perf/util/util.c                             |  52 +---
>  tools/perf/util/util.h                             |   3 -
>  22 files changed, 710 insertions(+), 83 deletions(-)
>  create mode 100644 tools/perf/arch/powerpc/util/unwind-libdw.c

Pulled, thanks a lot Arnaldo!

	Ingo
