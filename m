Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03A061A0BF5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2015 01:58:57 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 22 May 2015 11:58:54 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D1A57C90045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 11:49:58 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4MFwp0i51380474
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 15:58:51 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4MFwov9027552
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 11:58:51 -0400
Date: Fri, 22 May 2015 08:58:22 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Jiri Olsa <jolsa@redhat.com>
Cc: ak@linux.intel.com, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@redhat.com,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] perf: jevents: Program to convert JSON file to C
 style file
Message-ID: <20150522155822.GA15904@us.ibm.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150522145615.GA16473@krava.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150522145615.GA16473@krava.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jiri Olsa [jolsa@redhat.com] wrote:
| On Tue, May 19, 2015 at 05:02:08PM -0700, Sukadev Bhattiprolu wrote:
| 
| SNIP
| 
| > ---
| >  tools/perf/Build                   |    1 +
| >  tools/perf/Makefile.perf           |    4 +-
| >  tools/perf/pmu-events/Build        |   38 ++
| >  tools/perf/pmu-events/README       |   67 ++++
| >  tools/perf/pmu-events/jevents.c    |  700 ++++++++++++++++++++++++++++++++++++
| >  tools/perf/pmu-events/jevents.h    |   17 +
| >  tools/perf/pmu-events/pmu-events.h |   39 ++
| >  7 files changed, 865 insertions(+), 1 deletion(-)
| >  create mode 100644 tools/perf/pmu-events/Build
| >  create mode 100644 tools/perf/pmu-events/README
| >  create mode 100644 tools/perf/pmu-events/jevents.c
| >  create mode 100644 tools/perf/pmu-events/jevents.h
| >  create mode 100644 tools/perf/pmu-events/pmu-events.h
| > 
| > diff --git a/tools/perf/Build b/tools/perf/Build
| > index b77370e..40bffa0 100644
| > --- a/tools/perf/Build
| > +++ b/tools/perf/Build
| > @@ -36,6 +36,7 @@ CFLAGS_builtin-help.o      += $(paths)
| >  CFLAGS_builtin-timechart.o += $(paths)
| >  CFLAGS_perf.o              += -DPERF_HTML_PATH="BUILD_STR($(htmldir_SQ))" -include $(OUTPUT)PERF-VERSION-FILE
| >  
| > +libperf-y += pmu-events/
| 
| there's no concetion (yet) in the new build system to trigger
| another binery build as a dependency for object file.. I'd
| rather do this the framework way, please check attached patch
| 
| also currently the pmu-events.c is generated every time,
| so we need to add the event json data files as dependency

pmu-events.c depends only on JSON files relevant to the arch perf is
being built on and there could be several JSON files per arch. So it
would complicate the Makefiles.

Besides, didn't we conclude that the cost of generating pmu-events.c
during build is negligible ?

| 
| jirka
| 
| 
| ---
| diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
| index 10df57237a66..f6e7fd868892 100644
| --- a/tools/build/Makefile.build
| +++ b/tools/build/Makefile.build
| @@ -41,6 +41,7 @@ include $(build-file)
|  
|  quiet_cmd_flex  = FLEX     $@
|  quiet_cmd_bison = BISON    $@
| +quiet_cmd_gen   = GEN      $@
|  
|  # Create directory unless it exists
|  quiet_cmd_mkdir = MKDIR    $(dir $@)
| diff --git a/tools/perf/Build b/tools/perf/Build
| index 40bffa0b6ee1..b77370ef7005 100644
| --- a/tools/perf/Build
| +++ b/tools/perf/Build
| @@ -36,7 +36,6 @@ CFLAGS_builtin-help.o      += $(paths)
|  CFLAGS_builtin-timechart.o += $(paths)
|  CFLAGS_perf.o              += -DPERF_HTML_PATH="BUILD_STR($(htmldir_SQ))" -include $(OUTPUT)PERF-VERSION-FILE
|  
| -libperf-y += pmu-events/
|  libperf-y += util/
|  libperf-y += arch/
|  libperf-y += ui/
| diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
| index 57e46a541686..a4ba451cffa2 100644
| --- a/tools/perf/Makefile.perf
| +++ b/tools/perf/Makefile.perf
| @@ -272,14 +272,29 @@ strip: $(PROGRAMS) $(OUTPUT)perf
|  
|  PERF_IN := $(OUTPUT)perf-in.o
|  
| +JEVENTS       := $(OUTPUT)pmu-events/jevents
| +JEVENTS_IN    := $(OUTPUT)pmu-events/jevents-in.o
| +PMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o

I will try this out, but why not just add pmu-events.o to libperf?

| +
| +export JEVENTS
| +
|  export srctree OUTPUT RM CC LD AR CFLAGS V BISON FLEX
|  build := -f $(srctree)/tools/build/Makefile.build dir=. obj
|  
|  $(PERF_IN): $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h FORCE
|  	$(Q)$(MAKE) $(build)=perf
|  
| -$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN)
| -	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(PERF_IN) $(LIBS) -o $@
| +$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN)
| +	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
| +
| +$(JEVENTS_IN): FORCE
| +	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(OUTPUT)pmu-events obj=jevents
| +
| +$(JEVENTS): $(JEVENTS_IN)
| +	$(QUIET_LINK)$(CC) $(JEVENTS_IN) -o $@
| +
| +$(PMU_EVENTS_IN): $(JEVENTS) FORCE
| +	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(OUTPUT)pmu-events obj=pmu-events
|  
|  $(GTK_IN): FORCE
|  	$(Q)$(MAKE) $(build)=gtk
| @@ -538,7 +553,7 @@ clean: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean config-clean
|  	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
|  	$(Q)$(RM) .config-detected
|  	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 perf-read-vdsox32 $(OUTPUT)pmu-events/jevents
| -	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo $(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex*
| +	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo $(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* $(OUTPUT)pmu-events/pmu-events.c
|  	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
|  	$(python-clean)
|  
| diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
| index 7a2aaafa05e5..c35eeec2674c 100644
| --- a/tools/perf/pmu-events/Build
| +++ b/tools/perf/pmu-events/Build
| @@ -1,26 +1,13 @@
| -.SUFFIXES:
| -
| -libperf-y += pmu-events.o
| -
| -JEVENTS =	$(OUTPUT)pmu-events/jevents
| -JEVENTS_OBJS =	$(OUTPUT)pmu-events/json.o $(OUTPUT)pmu-events/jsmn.o \
| -		$(OUTPUT)pmu-events/jevents.o
| -
| -PMU_EVENTS =	$(srctree)/tools/perf/pmu-events/
| -
| -all: $(OUTPUT)pmu-events.o
| -
| -$(OUTPUT)pmu-events/jevents: $(JEVENTS_OBJS)
| -	$(call rule_mkdir)
| -	$(CC) -o $@ $(JEVENTS_OBJS)
| +jevents-y    += json.o jsmn.o jevents.o
| +pmu-events-y += pmu-events.o
|  
|  #
| -# Look for JSON files in $(PMU_EVENTS)/arch directory,
| -# process them and create tables in $(PMU_EVENTS)/pmu-events.c
| +# Look for JSON files in arch directory,
| +# process them and create tables in pmu-events.c
|  #
| -pmu-events/pmu-events.c: $(JEVENTS) FORCE
| -	$(JEVENTS) $(PMU_EVENTS)/arch $(PMU_EVENTS)/pmu-events.c
| - 
| +# TODO put event data files as dependencies instead of FORCE
| +pmu-events/pmu-events.c: FORCE
| +	$(Q)$(call echo-cmd,gen)$(JEVENTS) pmu-events/arch $(OUTPUT)pmu-events/pmu-events.c
|  
|  #
|  # If we fail to build pmu-events.o, it could very well be due to
| @@ -30,9 +17,3 @@ pmu-events/pmu-events.c: $(JEVENTS) FORCE
|  # so the build of perf can succeed even if we are not able to use
|  # the PMU event aliases.
|  #
| -
| -clean:
| -	rm -f $(JEVENTS_OBJS) $(JEVENTS) $(OUTPUT)pmu-events.o \
| -		$(PMU_EVENTS)pmu-events.c
| -
| -FORCE:
| _______________________________________________
| Linuxppc-dev mailing list
| Linuxppc-dev@lists.ozlabs.org
| https://lists.ozlabs.org/listinfo/linuxppc-dev
