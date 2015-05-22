Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6289E1A0BF5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2015 03:33:27 +1000 (AEST)
Date: Fri, 22 May 2015 19:33:19 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: ak@linux.intel.com, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@redhat.com,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] perf: jevents: Program to convert JSON file to C
 style file
Message-ID: <20150522173319.GB16703@krava.redhat.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150522145615.GA16473@krava.redhat.com>
 <20150522155822.GA15904@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150522155822.GA15904@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 22, 2015 at 08:58:22AM -0700, Sukadev Bhattiprolu wrote:

SNIP

> | 
> | there's no concetion (yet) in the new build system to trigger
> | another binery build as a dependency for object file.. I'd
> | rather do this the framework way, please check attached patch
> | 
> | also currently the pmu-events.c is generated every time,
> | so we need to add the event json data files as dependency
> 
> pmu-events.c depends only on JSON files relevant to the arch perf is
> being built on and there could be several JSON files per arch. So it
> would complicate the Makefiles.
> 
> Besides, didn't we conclude that the cost of generating pmu-events.c
> during build is negligible ?

yes, but only when it's necessary.. if there's no change in definitions
and we already have pmu-events.o built.. why rebuild?

> |  
> | -libperf-y += pmu-events/
> |  libperf-y += util/
> |  libperf-y += arch/
> |  libperf-y += ui/
> | diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> | index 57e46a541686..a4ba451cffa2 100644
> | --- a/tools/perf/Makefile.perf
> | +++ b/tools/perf/Makefile.perf
> | @@ -272,14 +272,29 @@ strip: $(PROGRAMS) $(OUTPUT)perf
> |  
> |  PERF_IN := $(OUTPUT)perf-in.o
> |  
> | +JEVENTS       := $(OUTPUT)pmu-events/jevents
> | +JEVENTS_IN    := $(OUTPUT)pmu-events/jevents-in.o
> | +PMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
> 
> I will try this out, but why not just add pmu-events.o to libperf?

this is related to my first comment:

	> | there's no concetion (yet) in the new build system to trigger
	> | another binery build as a dependency for object file.. I'd
	> | rather do this the framework way, please check attached patch

it's not possible to trigger the application build within the Build file
in a way the framework was designed.. so it cannot easily display commands
handle dependencies etc.. just allows simple/hacky solution you did ;-)

so I separated the pmu-events.o so libperf does not have dependency
on the jevents applications, and treat it as separated object

jirka
