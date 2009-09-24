Return-Path: <yfrolov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id B52CDB7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Sep 2009 21:28:14 +1000 (EST)
Message-ID: <4ABB57CB.3000409@ru.mvista.com>
Date: Thu, 24 Sep 2009 15:28:11 +0400
From: Yuri Frolov <yfrolov@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [patch] powerpc: build modules outside the kernel tree fails, if
	it was built using O=
Content-Type: text/plain; charset=ISO-8859-1
Cc: rep.dot.nop@gmail.com, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

here is a corresponding bug: http://bugzilla.kernel.org/show_bug.cgi?id=11143
This patch should correctly export crtsavres.o in order to make O= option working.
Please, consider to apply.


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
Signed-off by:  Yuri Frolov <yfrolov@ru.mvista.com>

Makefile                 |    2 ++
arch/powerpc/Makefile    |    2 +-
scripts/Makefile.modpost |   12 ++++++++++--
3 files changed, 13 insertions(+), 3 deletions(-)

diff -urpN -X linux-2.6/Documentation/dontdiff linux-2.6/arch/powerpc/Makefile linux-2.6-powerpc-crtsavres/arch/powerpc/Makefile
--- linux-2.6/arch/powerpc/Makefile	2009-09-17 20:04:31.000000000 +0400
+++ linux-2.6-powerpc-crtsavres/arch/powerpc/Makefile	2009-09-23 22:08:03.000000000 +0400
@@ -93,7 +93,7 @@ else
 	KBUILD_CFLAGS += $(call cc-option,-mtune=power4)
 endif
 else
-LDFLAGS_MODULE	+= arch/powerpc/lib/crtsavres.o
+LDFLAGS_MODULE_PREREQ += arch/powerpc/lib/crtsavres.o
 endif
 
 ifeq ($(CONFIG_TUNE_CELL),y)
diff -urpN -X linux-2.6/Documentation/dontdiff linux-2.6/Makefile linux-2.6-powerpc-crtsavres/Makefile
--- linux-2.6/Makefile	2009-09-17 20:04:30.000000000 +0400
+++ linux-2.6-powerpc-crtsavres/Makefile	2009-09-23 21:41:16.000000000 +0400
@@ -326,6 +326,7 @@ MODFLAGS	= -DMODULE
 CFLAGS_MODULE   = $(MODFLAGS)
 AFLAGS_MODULE   = $(MODFLAGS)
 LDFLAGS_MODULE  = -T $(srctree)/scripts/module-common.lds
+LDFLAGS_MODULE_PREREQ  =
 CFLAGS_KERNEL	=
 AFLAGS_KERNEL	=
 CFLAGS_GCOV	= -fprofile-arcs -ftest-coverage
@@ -355,6 +356,7 @@ export VERSION PATCHLEVEL SUBLEVEL KERNE
 export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
 export CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE
 export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
+export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE LDFLAGS_MODULE_PREREQ CHECK CHECKFLAGS
 
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
 export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE CFLAGS_GCOV
diff -urpN -X linux-2.6/Documentation/dontdiff linux-2.6/scripts/Makefile.modpost linux-2.6-powerpc-crtsavres/scripts/Makefile.modpost
--- linux-2.6/scripts/Makefile.modpost	2009-09-17 20:04:42.000000000 +0400
+++ linux-2.6-powerpc-crtsavres/scripts/Makefile.modpost	2009-09-23 22:15:00.000000000 +0400
@@ -122,14 +122,22 @@ quiet_cmd_cc_o_c = CC      $@
       cmd_cc_o_c = $(CC) $(c_flags) $(CFLAGS_MODULE)	\
 		   -c -o $@ $<
 
-$(modules:.ko=.mod.o): %.mod.o: %.mod.c FORCE
+quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
+cmd_as_o_S       = $(CC) $(a_flags) $(AFLAGS_MODULE) -c -o $@ $<
+
+$(LDFLAGS_MODULE_PREREQ): %.o: %.S FORCE
+	$(Q)mkdir -p $(dir $@)
+	$(call if_changed_dep,as_o_S)
+
+$(modules:.ko=.mod.o): %.mod.o: %.mod.c $(LDFLAGS_MODULE_PREREQ) FORCE
 	$(call if_changed_dep,cc_o_c)
 
 targets += $(modules:.ko=.mod.o)
 
 # Step 6), final link of the modules
 quiet_cmd_ld_ko_o = LD [M]  $@
-      cmd_ld_ko_o = $(LD) -r $(LDFLAGS) $(LDFLAGS_MODULE) -o $@		\
+      cmd_ld_ko_o = $(LD) -r $(LDFLAGS) $(LDFLAGS_MODULE_PREREQ)	\
+			  $(LDFLAGS_MODULE) -o $@			\
 			  $(filter-out FORCE,$^)
 
 $(modules): %.ko :%.o %.mod.o FORCE
