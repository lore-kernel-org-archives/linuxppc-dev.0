Return-Path: <Vineet.Gupta1@synopsys.com>
Received: from smtprelay.synopsys.com (smtprelay.synopsys.com [198.182.47.9])
 (using TLSv1.1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7BEF51A0D1C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 May 2015 17:02:18 +1000 (AEST)
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, "mingo@redhat.com"
 <mingo@redhat.com>, "ak@linux.intel.com" <ak@linux.intel.com>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC][PATCH 0/4] perf: Enable symbolic event names
Date: Sat, 2 May 2015 07:02:11 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230756659D931@IN01WEMBXB.internal.synopsys.com>
References: <1430463941-26109-1-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 01 May 2015 12:35 PM, Sukadev Bhattiprolu wrote:=0A=
> Implement ability to specify Power PMU events by their symbolic event=0A=
> names rather than raw codes. This approach pulls tables of the Power7=0A=
> and Power8 PMU events into the perf source tree and uses these tables=0A=
> to create aliases for the PMU events. With these aliases users can run:=
=0A=
> =0A=
> 	perf stat -e PM_1PLUS_PPC_CMPL:ku sleep 1=0A=
> or=0A=
> 	perf stat -e cpu/PM_VSU_SINGLE/ sleep 1=0A=
> =0A=
> This is an early POC patchset based on discussions with Jiri Olsa,=0A=
> Michael Ellerman and Ingo Molnar. Lightly tested on Power7 and Power8.=0A=
> =0A=
> Can other architectures can implement arch_get_events_table() and similar=
ly =0A=
> use symoblic event names?=0A=
=0A=
=0A=
Yes, ARC can certainly use this infrastructure. Our hardware conditions are=
=0A=
actually 1-8 char strings. So using raw events requires me to first convert=
 the=0A=
string to ASCII.=0A=
=0A=
> =0A=
> I am also assuming that if the header files like power8-events.h are=0A=
> easily readable, we don't need the JSON files anymore?=0A=
> =0A=
> TODO:=0A=
> 	- Maybe translate event names to lower-case?=0A=
> 	- Allow perf to process event descriptions (need Andi Kleen's patch)=0A=
> =0A=
> =0A=
> Sukadev Bhattiprolu (4):=0A=
>   perf: Create a table of Power7 PMU events=0A=
>   perf: Create a table of Power8 PMU events=0A=
>   perf/powerpc: Move mfspr and friends to header file=0A=
>   perf: Create aliases for Power PMU events=0A=
> =0A=
>  tools/perf/arch/powerpc/util/Build           |    2 +-=0A=
>  tools/perf/arch/powerpc/util/header.c        |    9 +-=0A=
>  tools/perf/arch/powerpc/util/header.h        |    9 +=0A=
>  tools/perf/arch/powerpc/util/pmu-events.c    |   52 +=0A=
>  tools/perf/arch/powerpc/util/pmu-events.h    |   17 +=0A=
>  tools/perf/arch/powerpc/util/power7-events.h | 3315 +++++++++++++=0A=
>  tools/perf/arch/powerpc/util/power8-events.h | 6408 ++++++++++++++++++++=
++++++=0A=
>  tools/perf/util/pmu.c                        |   77 +=0A=
>  tools/perf/util/pmu.h                        |   10 +=0A=
>  9 files changed, 9890 insertions(+), 9 deletions(-)=0A=
>  create mode 100644 tools/perf/arch/powerpc/util/header.h=0A=
>  create mode 100644 tools/perf/arch/powerpc/util/pmu-events.c=0A=
>  create mode 100644 tools/perf/arch/powerpc/util/pmu-events.h=0A=
>  create mode 100644 tools/perf/arch/powerpc/util/power7-events.h=0A=
>  create mode 100644 tools/perf/arch/powerpc/util/power8-events.h=0A=
> =0A=
=0A=
