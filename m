Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjS0T5QXqzDrRW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 01:03:52 +1000 (AEST)
Date: Mon, 26 Sep 2016 12:03:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v21 00/20] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20160926150343.GJ5588@kernel.org>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20160919212017.GA11991@kernel.org>
 <20160919233113.GB11991@kernel.org>
 <20160919233753.GC11991@kernel.org>
 <20160920000258.GD11991@kernel.org>
 <20160920002820.GE11991@kernel.org> <20160922150022.GA20134@krava>
 <20160922162713.GA31617@krava> <20160926083533.GA15523@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160926083533.GA15523@krava>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Sep 26, 2016 at 10:35:33AM +0200, Jiri Olsa escreveu:
> ping.. is that working for you? IMO we can include this
> as additional patch to the set..

No, it doesn't fails to build on the first cross env I tried, fixing it
now, resulting patch:

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 72edf83d76b7..9365c155c6f3 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -758,6 +758,10 @@ ifndef NO_AUXTRACE
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
index 26dbee50b36c..ee86dbf2814e 100644
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
index 2babcdf62839..37f74fcc9ca2 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -377,6 +377,8 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias,
 	return 0;
 }
 
+#ifdef HAVE_PMU_EVENTS_SUPPORT
+
 /*
  * Reading/parsing the default pmu type value, which should be
  * located at:
@@ -473,6 +475,23 @@ static struct cpu_map *pmu_cpumask(const char *name)
 	return cpus;
 }
 
+#else
+static int pmu_type(const char *name __maybe_unused, __u32 *type)
+{
+	*type = 0;
+	return 0;
+}
+
+static void pmu_read_sysfs(void)
+{
+}
+
+static struct cpu_map *pmu_cpumask(const char *name __maybe_unused)
+{
+	return NULL;
+}
+#endif /* HAVE_PMU_EVENTS_SUPPORT */
+
 struct perf_event_attr * __weak
 perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
