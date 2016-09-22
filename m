Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sg22Y5290zDt1n
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 02:27:17 +1000 (AEST)
Date: Thu, 22 Sep 2016 18:27:13 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, peterz@infradead.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21 00/20] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20160922162713.GA31617@krava>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20160919212017.GA11991@kernel.org>
 <20160919233113.GB11991@kernel.org>
 <20160919233753.GC11991@kernel.org>
 <20160920000258.GD11991@kernel.org>
 <20160920002820.GE11991@kernel.org> <20160922150022.GA20134@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160922150022.GA20134@krava>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 22, 2016 at 05:00:22PM +0200, Jiri Olsa wrote:
> On Mon, Sep 19, 2016 at 09:28:20PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Sep 19, 2016 at 09:02:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Mon, Sep 19, 2016 at 08:37:53PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > yeah, changing that typedef + true def to plain include <stdbool.h>
> > > > makes it progress to the next failure, which is in cross compilation
> > > > environments, such as using fedora 24 + the Android NDK to try to build
> > > > a ARM android binary.
> > 
> > > 14 fedora:24-x-ARC-uClibc: FAIL
> > >   GEN      /tmp/build/perf/pmu-events/pmu-events.c
> > > /bin/sh: /tmp/build/perf/pmu-events/jevents: cannot execute binary file: Exec format error
> > > pmu-events/Build:11: recipe for target '/tmp/build/perf/pmu-events/pmu-events.c' failed
> > > make[2]: *** [/tmp/build/perf/pmu-events/pmu-events.c] Error 126
> > > Makefile.perf:461: recipe for target '/tmp/build/perf/pmu-events/pmu-events-in.o' failed
> > > make[1]: *** [/tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
> > > make[1]: *** Waiting for unfinished jobs....
> > 
> > Jiri, we need something similar to scripts/Makefile.host :-\
> > 
> > Calling it a day, perhaps, for now, we should just detect that it is a
> > corss compile env (CROSS_COMPILE is set) and exclude all this code from
> > the build, emitting a warning.
> > 
> > I left what I did at the tmp.perf/core branch of my repo at
> > git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git.
> 
> as discussed on irc we will disable it for cross builds now,
> because we dont have good solution at the moment.. it's
> similar case as for fixdep tool:
> 
>     3a70fcd3a4db tools build: Fix cross compile build
>     ...
>     We need to add support for host side tools build, meanwhile
>     disabling fixdep usage for cross arch builds.
> 
> I'll make a change to disable this for crossbuild and
> work on common solution later

could you please give it a try with patch below?
I tested but not with properly cross building...

also,  did you want some message during the cross build that pmu-events are not included?

thanks,
jirka


---
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 24803c58049a..ec3a59d9a56b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -755,6 +755,10 @@ ifndef NO_AUXTRACE
   endif
 endif
 
+ifndef CROSS_COMPILE
+  CFLAGS += -DHAVE_PMU_EVENTS_SUPPORT
+endif
+
 # Among the variables below, these:
 #   perfexecdir
 #   template_dir
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 0abebcba849f..85257c49d5ab 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -349,7 +349,14 @@ include $(srctree)/tools/build/Makefile.include
 
 JEVENTS       := $(OUTPUT)pmu-events/jevents
 JEVENTS_IN    := $(OUTPUT)pmu-events/jevents-in.o
+
+#
+# Disabling pmu-events for cross compile, as
+# we dont support host CC tools building yet.
+#
+ifndef CROSS_COMPILE
 PMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
+endif
 
 export JEVENTS
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ac097fcaba7b..21a3f21a6f6f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -482,6 +482,8 @@ static struct cpu_map *pmu_cpumask(const char *name)
 	return cpus;
 }
 
+#ifdef HAVE_PMU_EVENTS_SUPPORT
+
 /*
  * Return the CPU id as a raw string.
  *
@@ -545,6 +547,13 @@ out:
 	return 0;
 }
 
+#else
+static int pmu_add_cpu_aliases(struct list_head *head __maybe_unused)
+{
+	return 0;
+}
+#endif /* HAVE_PMU_EVENTS_SUPPORT */
+
 struct perf_event_attr * __weak
 perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
