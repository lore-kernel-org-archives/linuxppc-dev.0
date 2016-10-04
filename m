Return-Path: <BATV+ef2f77d1cbf736fff7a8+4790+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp33h17rVzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 13:37:35 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux Weekly News <lwn@lwn.net>,
 Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/22] tools build: Add support for host programs format
Date: Mon,  3 Oct 2016 23:37:02 -0300
Message-Id: <1475548641-12182-4-git-send-email-acme@kernel.org>
In-Reply-To: <1475548641-12182-1-git-send-email-acme@kernel.org>
References: <1475548641-12182-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jiri Olsa <jolsa@redhat.com>

In some cases, like for fixdep and shortly for jevents, we need to build a tool
to run on the host that will be used in building a tool, such as perf, that is
being cross compiled, so do like the kernel and provide HOSTCC, HOSTLD and HOSTAR
to do that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Requested-by: Andi Kleen <andi@firstfloor.org>
Requested-and-Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20160927141846.GA6589@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Build.include  |  5 +++++
 tools/build/Makefile       |  6 ++++++
 tools/build/Makefile.build | 19 +++++++++++++++----
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/tools/build/Build.include b/tools/build/Build.include
index 4d000bc959b4..02489380d79b 100644
--- a/tools/build/Build.include
+++ b/tools/build/Build.include
@@ -90,3 +90,8 @@ if_changed = $(if $(strip $(any-prereq) $(arg-check)),             \
 # - per object C flags
 # - BUILD_STR macro to allow '-D"$(variable)"' constructs
 c_flags = -Wp,-MD,$(depfile),-MT,$@ $(CFLAGS) -D"BUILD_STR(s)=\#s" $(CFLAGS_$(basetarget).o) $(CFLAGS_$(obj))
+
+###
+## HOSTCC C flags
+
+host_c_flags = -Wp,-MD,$(depfile),-MT,$@ $(CHOSTFLAGS) -D"BUILD_STR(s)=\#s" $(CHOSTFLAGS_$(basetarget).o) $(CHOSTFLAGS_$(obj))
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
index 27f3583193e6..190519a94ce5 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -58,6 +58,9 @@ quiet_cmd_mkdir = MKDIR    $(dir $@)
 quiet_cmd_cc_o_c = CC       $@
       cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
 
+quiet_cmd_host_cc_o_c = HOSTCC   $@
+      cmd_host_cc_o_c = $(HOSTCC) $(host_c_flags) -c -o $@ $<
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
-- 
2.7.4
