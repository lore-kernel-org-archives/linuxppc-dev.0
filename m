Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sk2y42fP0zDrVX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 00:18:52 +1000 (AEST)
Date: Tue, 27 Sep 2016 16:18:46 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Andi Kleen <andi@firstfloor.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, peterz@infradead.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21 00/20] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20160927141846.GA6589@krava>
References: <20160919212017.GA11991@kernel.org>
 <20160919233113.GB11991@kernel.org>
 <20160919233753.GC11991@kernel.org>
 <20160920000258.GD11991@kernel.org>
 <20160920002820.GE11991@kernel.org> <20160922150022.GA20134@krava>
 <20160922162713.GA31617@krava> <20160926083533.GA15523@krava>
 <20160926150343.GJ5588@kernel.org>
 <20160926165954.GD5871@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160926165954.GD5871@two.firstfloor.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 26, 2016 at 09:59:54AM -0700, Andi Kleen wrote:
> On Mon, Sep 26, 2016 at 12:03:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Sep 26, 2016 at 10:35:33AM +0200, Jiri Olsa escreveu:
> > > ping.. is that working for you? IMO we can include this
> > > as additional patch to the set..
> > 
> > No, it doesn't fails to build on the first cross env I tried, fixing it
> > now, resulting patch:
> 
> Yes it shouldn't be difficult to fix cross building. I don't think
> there are any fundamental problems.

right, how about attached patch

Arnaldo,
could you please try it on cross build.. I still dont have setup for that :-\

thanks,
jirka


---
diff --git a/tools/build/Build b/tools/build/Build
index 63a6c34c0c88..76d1a4960973 100644
--- a/tools/build/Build
+++ b/tools/build/Build
@@ -1 +1,3 @@
+hostprogs := fixdep
+
 fixdep-y := fixdep.o
diff --git a/tools/build/Makefile b/tools/build/Makefile
index 0d5a0e3a8fa9..653faee2a055 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -14,6 +14,12 @@ endef
 $(call allow-override,CC,$(CROSS_COMPILE)gcc)
 $(call allow-override,LD,$(CROSS_COMPILE)ld)
 
+HOSTCC ?= gcc
+HOSTLD ?= ld
+HOSTAR ?= ar
+
+export HOSTCC HOSTLD HOSTAR
+
 ifeq ($(V),1)
   Q =
 else
diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index 27f3583193e6..031c5631cc21 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -58,6 +58,9 @@ quiet_cmd_mkdir = MKDIR    $(dir $@)
 quiet_cmd_cc_o_c = CC       $@
       cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
 
+quiet_cmd_host_cc_o_c = HOSTCC   $@
+      cmd_host_cc_o_c = $(HOSTCC) $(c_flags) -c -o $@ $<
+
 quiet_cmd_cpp_i_c = CPP      $@
       cmd_cpp_i_c = $(CC) $(c_flags) -E -o $@ $<
 
@@ -70,16 +73,24 @@ quiet_cmd_gen = GEN      $@
 # If there's nothing to link, create empty $@ object.
 quiet_cmd_ld_multi = LD       $@
       cmd_ld_multi = $(if $(strip $(obj-y)),\
-		       $(LD) -r -o $@  $(filter $(obj-y),$^),rm -f $@; $(AR) rcs $@)
+                     $(LD) -r -o $@  $(filter $(obj-y),$^),rm -f $@; $(AR) rcs $@)
+
+quiet_cmd_host_ld_multi = HOSTLD   $@
+      cmd_host_ld_multi = $(if $(strip $(obj-y)),\
+                          $(HOSTLD) -r -o $@  $(filter $(obj-y),$^),rm -f $@; $(HOSTAR) rcs $@)
+
+ifneq ($(filter $(obj),$(hostprogs)),)
+  host = host_
+endif
 
 # Build rules
 $(OUTPUT)%.o: %.c FORCE
 	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
+	$(call if_changed_dep,$(host)cc_o_c)
 
 $(OUTPUT)%.o: %.S FORCE
 	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
+	$(call if_changed_dep,$(host)cc_o_c)
 
 $(OUTPUT)%.i: %.c FORCE
 	$(call rule_mkdir)
@@ -119,7 +130,7 @@ $(sort $(subdir-obj-y)): $(subdir-y) ;
 
 $(in-target): $(obj-y) FORCE
 	$(call rule_mkdir)
-	$(call if_changed,ld_multi)
+	$(call if_changed,$(host)ld_multi)
 
 __build: $(in-target)
 	@:
diff --git a/tools/build/Makefile.include b/tools/build/Makefile.include
index be630bed66d2..ad22e4e7bc59 100644
--- a/tools/build/Makefile.include
+++ b/tools/build/Makefile.include
@@ -1,10 +1,6 @@
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 
-ifdef CROSS_COMPILE
-fixdep:
-else
 fixdep:
 	$(Q)$(MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= $(OUTPUT)fixdep
-endif
 
 .PHONY: fixdep
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 0abebcba849f..1347b5de3669 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -144,6 +144,10 @@ $(call allow-override,LD,$(CROSS_COMPILE)ld)
 
 LD += $(EXTRA_LDFLAGS)
 
+HOSTCC  ?= gcc
+HOSTLD  ?= ld
+HOSTAR  ?= ar
+
 PKG_CONFIG = $(CROSS_COMPILE)pkg-config
 
 RM      = rm -f
@@ -345,6 +349,7 @@ strip: $(PROGRAMS) $(OUTPUT)perf
 PERF_IN := $(OUTPUT)perf-in.o
 
 export srctree OUTPUT RM CC LD AR CFLAGS V BISON FLEX AWK
+export HOSTCC HOSTLD HOSTAR
 include $(srctree)/tools/build/Makefile.include
 
 JEVENTS       := $(OUTPUT)pmu-events/jevents
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index d2f34307ae79..9213a1273697 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,3 +1,5 @@
+hostprogs := jevents
+
 jevents-y	+= json.o jsmn.o jevents.o
 pmu-events-y	+= pmu-events.o
 JDIR		=  pmu-events/arch/$(ARCH)
