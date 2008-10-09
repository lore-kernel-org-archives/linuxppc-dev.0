Return-Path: <rep.dot.nop@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id 6604BDE002
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 06:51:25 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so111827fga.39
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Oct 2008 12:51:16 -0700 (PDT)
Date: Thu, 9 Oct 2008 21:51:25 +0200
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: linuxppc-dev@ozlabs.org, paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH] Fix linking modules against crtsavres.o
Message-ID: <20081009195125.GG5178@mx.loc>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5QAgd0e35j3NYeGe"
Cc: sam@ravnborg.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

[ http://bugzilla.kernel.org/show_bug.cgi?id=11143 has it all]

targeting ppc(32), e.g. 405 (!fp), previously i got:
  CC      drivers/char/hw_random/rng-core.mod.o
  LD [M]  drivers/char/hw_random/rng-core.ko
/there/src/buildroot.git.ppc/build_powerpc_nofpu/staging_dir/usr/bin/powerpc-linux-uclibc-ld:
arch/powerpc/lib/crtsavres.o: No such file: No such file or directory

	* Makefile (LDFLAGS_MODULE_PREREQ): New variable to hold prerequisite
	files for modules.
	* arch/powerpc/Makefile: add crtsavres.o to LDFLAGS_MODULE_PREREQ.
	* scripts/Makefile.modpost (cmd_as_o_S): Copy from Makefile.build.
	(cmd_ld_ko_o): Also link LDFLAGS_MODULE_PREREQ.
	Provide rule to build objects from assembler.

The attached patch (same as attached to abovementioned bug) fixes this.
I'm asking the ppc maintainers or you, Sam, to consider something to
that effect for inclusing in the stable series.
thanks,

--5QAgd0e35j3NYeGe
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.26.5-powerpc-crtsavres_for_modules.patch"

Fix linking modules against crtsavres.o

Previously we got
  CC      drivers/char/hw_random/rng-core.mod.o
  LD [M]  drivers/char/hw_random/rng-core.ko
/there/src/buildroot.git.ppc/build_powerpc_nofpu/staging_dir/usr/bin/powerpc-linux-uclibc-ld: arch/powerpc/lib/crtsavres.o: No such file: No such file or directory

	* Makefile (LDFLAGS_MODULE_PREREQ): New variable to hold prerequisite
	files for modules.
	* arch/powerpc/Makefile: add crtsavres.o to LDFLAGS_MODULE_PREREQ.
	* scripts/Makefile.modpost (cmd_as_o_S): Copy from Makefile.build.
	(cmd_ld_ko_o): Also link LDFLAGS_MODULE_PREREQ.
	Provide rule to build objects from assembler.

Signed-off-by:  Bernhard Reutner-Fischer  <rep.dot.nop@gmail.com>

diff -rup ../../x/linux-2.6.26.5.old/arch/powerpc/Makefile linux-2.6.26.5/arch/powerpc/Makefile
--- ../../x/linux-2.6.26.5.old/arch/powerpc/Makefile	2008-09-08 19:40:20.000000000 +0200
+++ linux-2.6.26.5/arch/powerpc/Makefile	2008-10-07 14:28:08.000000000 +0200
@@ -97,7 +97,7 @@ else
 	KBUILD_CFLAGS += $(call cc-option,-mtune=power4)
 endif
 else
-LDFLAGS_MODULE	+= arch/powerpc/lib/crtsavres.o
+LDFLAGS_MODULE_PREREQ += arch/powerpc/lib/crtsavres.o
 endif
 
 ifeq ($(CONFIG_TUNE_CELL),y)
diff -rup ../../x/linux-2.6.26.5.old/Makefile linux-2.6.26.5/Makefile
--- ../../x/linux-2.6.26.5.old/Makefile	2008-09-08 19:40:20.000000000 +0200
+++ linux-2.6.26.5/Makefile	2008-10-07 14:15:59.000000000 +0200
@@ -318,6 +318,7 @@ MODFLAGS	= -DMODULE
 CFLAGS_MODULE   = $(MODFLAGS)
 AFLAGS_MODULE   = $(MODFLAGS)
 LDFLAGS_MODULE  =
+LDFLAGS_MODULE_PREREQ  =
 CFLAGS_KERNEL	=
 AFLAGS_KERNEL	=
 
@@ -342,7 +343,7 @@ KERNELVERSION = $(VERSION).$(PATCHLEVEL)
 export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
 export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
 export CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE
-export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
+export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE LDFLAGS_MODULE_PREREQ CHECK CHECKFLAGS
 
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
 export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
diff -rup ../../x/linux-2.6.26.5.old/scripts/Makefile.modpost linux-2.6.26.5/scripts/Makefile.modpost
--- ../../x/linux-2.6.26.5.old/scripts/Makefile.modpost	2008-09-08 19:40:20.000000000 +0200
+++ linux-2.6.26.5/scripts/Makefile.modpost	2008-10-07 14:24:34.000000000 +0200
@@ -122,14 +122,21 @@ quiet_cmd_cc_o_c = CC      $@
       cmd_cc_o_c = $(CC) $(c_flags) $(CFLAGS_MODULE)	\
 		   -c -o $@ $<
 
-$(modules:.ko=.mod.o): %.mod.o: %.mod.c FORCE
+quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
+cmd_as_o_S       = $(CC) $(a_flags) $(AFLAGS_MODULE) -c -o $@ $<
+
+$(LDFLAGS_MODULE_PREREQ): %.o: %.S FORCE
+	$(call if_changed_dep,as_o_S)
+
+$(modules:.ko=.mod.o): %.mod.o: %.mod.c $(LDFLAGS_MODULE_PREREQ) FORCE
 	$(call if_changed_dep,cc_o_c)
 
 targets += $(modules:.ko=.mod.o)
 
 # Step 6), final link of the modules
 quiet_cmd_ld_ko_o = LD [M]  $@
-      cmd_ld_ko_o = $(LD) -r $(LDFLAGS) $(LDFLAGS_MODULE) -o $@		\
+      cmd_ld_ko_o = $(LD) -r $(LDFLAGS) $(LDFLAGS_MODULE_PREREQ)	\
+			  $(LDFLAGS_MODULE) -o $@		\
 			  $(filter-out FORCE,$^)
 
 $(modules): %.ko :%.o %.mod.o FORCE

--5QAgd0e35j3NYeGe--
