Return-Path: <SRS0+0172f75cf8e7244956cd+1562+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7466EDDE41
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 13:57:06 +1100 (EST)
Received: from pmac.infradead.org ([2001:8b0:10b:1:20d:93ff:fe7a:3f2c])
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1Iz1UU-0006SE-5B
	for linuxppc-dev@ozlabs.org; Mon, 03 Dec 2007 02:57:02 +0000
Subject: [PPC BOOT] 'make bootwrapper_install'
From: David Woodhouse <dwmw2@infradead.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1196650325.13978.119.camel@pmac.infradead.org>
References: <1196650083.13978.113.camel@pmac.infradead.org>
	<1196650164.13978.115.camel@pmac.infradead.org>
	<1196650325.13978.119.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Mon, 03 Dec 2007 02:56:58 +0000
Message-Id: <1196650618.13978.125.camel@pmac.infradead.org>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a 'bootwrapper_install' make target for the powerpc
architecture, which installs the wrapper script, intermediate object
files and device-tree sources for later use.

This will then allow bootable zImages to be created other than in the
context of a kernel build.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 18e3271..acf3641 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -243,3 +243,51 @@ clean-kernel := vmlinux.strip vmlinux.bin
 clean-kernel += $(addsuffix .gz,$(clean-kernel))
 # If not absolute clean-files are relative to $(obj).
 clean-files += $(addprefix $(objtree)/, $(clean-kernel))
+
+WRAPPER_OBJDIR := /usr/lib/kernel-wrapper
+WRAPPER_DTSDIR := /usr/lib/kernel-wrapper/dts
+WRAPPER_BINDIR := /usr/sbin
+INSTALL := install
+
+extra-installed		:= $(patsubst $(obj)/%, $(DESTDIR)$(WRAPPER_OBJDIR)/%, $(extra-y))
+hostprogs-installed	:= $(patsubst %, $(DESTDIR)$(WRAPPER_BINDIR)/%, $(hostprogs-y))
+wrapper-installed	:= $(DESTDIR)$(WRAPPER_BINDIR)/wrapper
+dts-installed		:= $(patsubst $(obj)/dts/%, $(DESTDIR)$(WRAPPER_DTSDIR)/%, $(wildcard $(obj)/dts/*.dts))
+
+all-installed		:= $(extra-installed) $(hostprogs-installed) $(wrapper-installed) $(dts-installed)
+
+quiet_cmd_mkdir           = MKDIR   $(patsubst $(INSTALL_HDR_PATH)/%,%,$@)
+      cmd_mkdir           = mkdir -p $@
+
+quiet_cmd_install	  = INSTALL $(patsubst $(DESTDIR)$(WRAPPER_OBJDIR)/%,%,$@)
+      cmd_install	  = $(INSTALL)  -m0644 $(patsubst $(DESTDIR)$(WRAPPER_OBJDIR)/%,$(obj)/%,$@) $@ 
+
+quiet_cmd_install_dts	  = INSTALL $(patsubst $(DESTDIR)$(WRAPPER_DTSDIR)/%,dts/%,$@)
+      cmd_install_dts	  = $(INSTALL)  -m0644 $(patsubst $(DESTDIR)$(WRAPPER_DTSDIR)/%,$(srctree)/$(obj)/dts/%,$@) $@ 
+
+quiet_cmd_install_exe	  = INSTALL $(patsubst $(DESTDIR)$(WRAPPER_BINDIR)/%,%,$@)
+      cmd_install_exe	  = $(INSTALL)  -m0755 $(patsubst $(DESTDIR)$(WRAPPER_BINDIR)/%,$(obj)/%,$@) $@ 
+
+quiet_cmd_install_wrapper = INSTALL $(patsubst $(DESTDIR)$(WRAPPER_BINDIR)/%,%,$@)
+      cmd_install_wrapper = $(INSTALL)  -m0755 $(patsubst $(DESTDIR)$(WRAPPER_BINDIR)/%,$(srctree)/$(obj)/%,$@) $@ ;\
+				sed -i $@ -e 's%^object=.*%object=$(WRAPPER_OBJDIR)%' \
+					  -e 's%^objbin=.*%objbin=$(WRAPPER_BINDIR)%' \
+
+
+$(DESTDIR)$(WRAPPER_OBJDIR) $(DESTDIR)$(WRAPPER_DTSDIR) $(DESTDIR)$(WRAPPER_BINDIR):
+	$(call cmd,mkdir)
+
+$(extra-installed)	: $(DESTDIR)$(WRAPPER_OBJDIR)/% : $(obj)/% | $(DESTDIR)$(WRAPPER_OBJDIR)
+	$(call cmd,install)
+
+$(hostprogs-installed)  : $(DESTDIR)$(WRAPPER_BINDIR)/% : $(obj)/% | $(DESTDIR)$(WRAPPER_BINDIR)
+	$(call cmd,install_exe)
+
+$(dts-installed)	: $(DESTDIR)$(WRAPPER_DTSDIR)/% : $(srctree)/$(obj)/dts/% | $(DESTDIR)$(WRAPPER_DTSDIR)
+	$(call cmd,install_dts)
+
+$(wrapper-installed): $(DESTDIR)$(WRAPPER_BINDIR) $(srctree)/$(obj)/wrapper | $(DESTDIR)$(WRAPPER_BINDIR)
+	$(call cmd,install_wrapper)
+
+$(obj)/bootwrapper_install: $(all-installed)
+
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index bd87626..f70df9b 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -167,6 +167,9 @@ boot := arch/$(ARCH)/boot
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
+bootwrapper_install:
+	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
+
 define archhelp
   @echo '* zImage          - Compressed kernel image (arch/$(ARCH)/boot/zImage.*)'
   @echo '  install         - Install kernel using'

-- 
dwmw2
