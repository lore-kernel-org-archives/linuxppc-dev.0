Date: Sat, 16 Aug 2003 09:49:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Hering <olh@suse.de>, Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc-2.5 CONFIG_BOOT_LOAD undefined
Message-ID: <20030816074947.GA4087@mars.ravnborg.org>
References: <20030813075108.GA25714@suse.de> <20030814160526.GS807@ip68-0-152-218.tc.ph.cox.net> <20030814164518.GA24671@suse.de> <20030814165403.GT807@ip68-0-152-218.tc.ph.cox.net> <20030814174406.GB5270@suse.de> <20030814184334.GU807@ip68-0-152-218.tc.ph.cox.net> <20030814193124.GA20672@mars.ravnborg.org> <20030814193430.GA27154@suse.de> <20030814210257.GA13004@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030814210257.GA13004@mars.ravnborg.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 14, 2003 at 11:02:57PM +0200, Sam Ravnborg wrote:
>
> I will try to fix it during the weekend.
Olaf - care to try the following patch.
It is on top of linus's tree, but I expect it to apply
to your ppc tree as well.

I was able to reprocduce the error here - and this fixed it for me.
But I may have overlooked a subtle combination of usage.

PS - Still needs to update a few comments in the patch.

	Sam


===== Makefile 1.420 vs edited =====
--- 1.420/Makefile	Sat Aug  9 06:09:32 2003
+++ edited/Makefile	Sat Aug 16 09:42:09 2003
@@ -243,17 +243,15 @@
 comma := ,
 depfile = $(subst $(comma),_,$(@D)/.$(@F).d)

-noconfig_targets := xconfig gconfig menuconfig config oldconfig randconfig \
-		    defconfig allyesconfig allnoconfig allmodconfig \
-		    clean mrproper distclean rpm \
-		    help tags TAGS cscope %docs \
-		    checkconfig checkhelp checkincludes
+# Files to ignore in find ... that searches all of the kernel src

 RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS \) -prune -o
 RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn --exclude CVS

+# ===========================================================================
+# Rules shared between *config targets and build targets
+
 # Helpers built in scripts/
-# ---------------------------------------------------------------------------

 scripts/docproc scripts/fixdep scripts/split-include : scripts ;

@@ -261,9 +259,49 @@
 scripts:
 	$(Q)$(MAKE) $(build)=scripts

-# Objects we will link into vmlinux / subdirs we need to visit
-# ---------------------------------------------------------------------------

+# To make sure we do not include .config for any of the *config targets
+# catch them early, and hand them over to scripts/kconfig/Makefile
+# It is allowed to specify more targets when calling make, including
+# mixing *config targets and build targets.
+# For example 'make oldconfig all'.
+# Detect this situation, and make a second invocation of make so
+# .config is not included in this case either.
+
+config-targets := 0
+mixed-targets  := 0
+ifneq ($(filter config %config,$(MAKECMDGOALS)),)
+	config-targets := 1
+	ifneq ($(filter-out config %config,$(MAKECMDGOALS)),)
+		mixed-targets := 1
+	endif
+endif
+
+ifeq ($(mixed-targets),1)
+# ===========================================================================
+# We're called with mixed targets (*config and build targets).
+# Handle them one after the other.
+
+%:: FORCE
+	$(Q)$(MAKE) $@
+
+else
+ifeq ($(config-targets),1)
+# ===========================================================================
+# *config targets only - make sure prerequisites are updated, and descend
+# in scripts/kconfig to make the *config target
+
+%config: scripts/fixdep FORCE
+	$(Q)$(MAKE) $(build)=scripts/kconfig $@
+config : scripts/fixdep FORCE
+	$(Q)$(MAKE) $(build)=scripts/kconfig $@
+
+else
+# ===========================================================================
+# Build targets only - this includes vmlinux, arch specific targets, clean
+# targets and others. In general all targets except *config targets.
+
+# Objects we will link into vmlinux / subdirs we need to visit
 init-y		:= init/
 drivers-y	:= drivers/ sound/
 net-y		:= net/
@@ -271,14 +309,8 @@
 core-y		:= usr/
 SUBDIRS		:=

-ifeq ($(filter $(noconfig_targets),$(MAKECMDGOALS)),)
-
-export include_config := 1
-
 -include .config

-endif
-
 include arch/$(ARCH)/Makefile

 # Let architecture Makefiles change CPPFLAGS if needed
@@ -304,10 +336,8 @@
 libs-y2		:= $(patsubst %/, %/built-in.o, $(libs-y))
 libs-y		:= $(libs-y1) $(libs-y2)

-ifdef include_config
-
 # Here goes the main Makefile
-# ===========================================================================
+# ---------------------------------------------------------------------------
 #
 # If the user gave a *config target, it'll be handled in another
 # section below, since in this case we cannot include .config
@@ -608,72 +638,6 @@
 	 echo "#endif" )
 endef

-else # ifdef include_config
-
-ifeq ($(filter-out $(noconfig_targets),$(MAKECMDGOALS)),)
-
-# Targets which don't need .config
-# ===========================================================================
-#
-# These targets basically have their own Makefile - not quite, but at
-# least its own exclusive section in the same Makefile. The reason for
-# this is the following:
-# To know the configuration, the main Makefile has to include
-# .config. That's a obviously a problem when .config doesn't exist
-# yet, but that could be kludged around with only including it if it
-# exists.
-# However, the larger problem is: If you run make *config, make will
-# include the old .config, then execute your *config. It will then
-# notice that a piece it included (.config) did change and restart from
-# scratch. Which will cause execution of *config again. You get the
-# picture.
-# If we don't explicitly let the Makefile know that .config is changed
-# by *config (the old way), it won't reread .config after *config,
-# thus working with possibly stale values - we don't that either.
-#
-# So we divide things: This part here is for making *config targets,
-# and other targets which should work when no .config exists yet.
-# The main part above takes care of the rest after a .config exists.
-
-# Kernel configuration
-# ---------------------------------------------------------------------------
-
-.PHONY: oldconfig xconfig gconfig menuconfig config \
-	make_with_config rpm
-
-scripts/kconfig/conf scripts/kconfig/mconf scripts/kconfig/qconf scripts/kconfig/gconf: scripts/fixdep FORCE
-	$(Q)$(MAKE) $(build)=scripts/kconfig $@
-
-xconfig: scripts/kconfig/qconf
-	./scripts/kconfig/qconf arch/$(ARCH)/Kconfig
-
-gconfig: scripts/kconfig/gconf
-	./scripts/kconfig/gconf arch/$(ARCH)/Kconfig
-
-menuconfig: scripts/kconfig/mconf
-	$(Q)$(MAKE) $(build)=scripts/lxdialog
-	./scripts/kconfig/mconf arch/$(ARCH)/Kconfig
-
-config: scripts/kconfig/conf
-	./scripts/kconfig/conf arch/$(ARCH)/Kconfig
-
-oldconfig: scripts/kconfig/conf
-	./scripts/kconfig/conf -o arch/$(ARCH)/Kconfig
-
-randconfig: scripts/kconfig/conf
-	./scripts/kconfig/conf -r arch/$(ARCH)/Kconfig
-
-allyesconfig: scripts/kconfig/conf
-	./scripts/kconfig/conf -y arch/$(ARCH)/Kconfig
-
-allnoconfig: scripts/kconfig/conf
-	./scripts/kconfig/conf -n arch/$(ARCH)/Kconfig
-
-allmodconfig: scripts/kconfig/conf
-	./scripts/kconfig/conf -m arch/$(ARCH)/Kconfig
-
-defconfig: scripts/kconfig/conf
-	./scripts/kconfig/conf -d arch/$(ARCH)/Kconfig

 ###
 # Cleaning is done on three levels.
@@ -778,6 +742,8 @@
 # RPM target
 # ---------------------------------------------------------------------------

+.PHONY: rpm
+
 #	If you do a make spec before packing the tarball you can rpm -ta it

 spec:
@@ -864,17 +830,8 @@
 		-name '*.[hcS]' -type f -print | sort \
 		| xargs $(PERL) -w scripts/checkincludes.pl

-else # ifneq ($(filter-out $(noconfig_targets),$(MAKECMDGOALS)),)
-
-# We're called with both targets which do and do not need
-# .config included. Handle them one after the other.
-# ===========================================================================
-
-%:: FORCE
-	$(Q)$(MAKE) $@
-
-endif # ifeq ($(filter-out $(noconfig_targets),$(MAKECMDGOALS)),)
-endif # ifdef include_config
+endif #ifeq ($(config-targets),1)
+endif #ifeq ($(mixed-targets),1)

 # FIXME Should go into a make.lib or something
 # ===========================================================================
@@ -894,6 +851,7 @@
 cmd_files := $(wildcard .*.cmd $(foreach f,$(targets),$(dir $(f)).$(notdir $(f)).cmd))

 ifneq ($(cmd_files),)
+  $(cmd_files): ;	# Do not try to update dependency files
   include $(cmd_files)
 endif

===== scripts/Makefile.build 1.38 vs edited =====
--- 1.38/scripts/Makefile.build	Thu Jun 12 05:36:33 2003
+++ edited/scripts/Makefile.build	Fri Aug 15 20:50:14 2003
@@ -7,9 +7,8 @@
 .PHONY: __build
 __build:

-ifdef include_config
-include .config
-endif
+# Read .config if it exist, otherwise ignore
+-include .config

 include $(obj)/Makefile

===== scripts/kconfig/Makefile 1.6 vs edited =====
--- 1.6/scripts/kconfig/Makefile	Sat Mar 15 18:25:56 2003
+++ edited/scripts/kconfig/Makefile	Sat Aug 16 09:44:34 2003
@@ -11,6 +11,69 @@
 #
 #################

+# Targets which don't need .config
+# ===========================================================================
+#
+# These targets basically have their own Makefile - not quite, but at
+# least its own exclusive section in the same Makefile. The reason for
+# this is the following:
+# To know the configuration, the main Makefile has to include
+# .config. That's a obviously a problem when .config doesn't exist
+# yet, but that could be kludged around with only including it if it
+# exists.
+# However, the larger problem is: If you run make *config, make will
+# include the old .config, then execute your *config. It will then
+# notice that a piece it included (.config) did change and restart from
+# scratch. Which will cause execution of *config again. You get the
+# picture.
+# If we don't explicitly let the Makefile know that .config is changed
+# by *config (the old way), it won't reread .config after *config,
+# thus working with possibly stale values - we don't that either.
+#
+# So we divide things: This part here is for making *config targets,
+# and other targets which should work when no .config exists yet.
+# The main part above takes care of the rest after a .config exists.
+
+# Kernel configuration options
+# These targets are used from top-level makefile
+# ---------------------------------------------------------------------------
+
+.PHONY: oldconfig xconfig gconfig menuconfig config
+
+xconfig: scripts/kconfig/qconf
+	./scripts/kconfig/qconf arch/$(ARCH)/Kconfig
+
+gconfig: scripts/kconfig/gconf
+	./scripts/kconfig/gconf arch/$(ARCH)/Kconfig
+
+menuconfig: scripts/kconfig/mconf
+	$(Q)$(MAKE) $(build)=scripts/lxdialog
+	./scripts/kconfig/mconf arch/$(ARCH)/Kconfig
+
+config: scripts/kconfig/conf
+	./scripts/kconfig/conf arch/$(ARCH)/Kconfig
+
+oldconfig: scripts/kconfig/conf
+	./scripts/kconfig/conf -o arch/$(ARCH)/Kconfig
+
+.PHONY: randconfig allyesconfig allnoconfig allmodconfig defconfig
+
+randconfig: scripts/kconfig/conf
+	./scripts/kconfig/conf -r arch/$(ARCH)/Kconfig
+
+allyesconfig: scripts/kconfig/conf
+	./scripts/kconfig/conf -y arch/$(ARCH)/Kconfig
+
+allnoconfig: scripts/kconfig/conf
+	./scripts/kconfig/conf -n arch/$(ARCH)/Kconfig
+
+allmodconfig: scripts/kconfig/conf
+	./scripts/kconfig/conf -m arch/$(ARCH)/Kconfig
+
+defconfig: scripts/kconfig/conf
+	./scripts/kconfig/conf -d arch/$(ARCH)/Kconfig
+
+
 # object files used by all lkc flavours
 libkconfig-objs := zconf.tab.o


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
