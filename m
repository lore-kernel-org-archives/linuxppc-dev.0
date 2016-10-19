Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szHCV3Mf7zDt2H
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 14:16:22 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 128so1092541pfz.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 20:16:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/7] powerpc: use the new post-link pass to check relocations
Date: Wed, 19 Oct 2016 14:15:54 +1100
Message-Id: <20161019031600.17933-2-npiggin@gmail.com>
In-Reply-To: <20161019031600.17933-1-npiggin@gmail.com>
References: <20161019031600.17933-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently powerpc has to introduce a dependency on its default build
target zImage in order to run a relocation check pass over the linked
vmlinux. This is deficient because the check is not run if the plain
vmlinux target is built, or if one of the other boot targets is built.

Switch to using the kbuild post-link pass in order to run this check.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile          | 11 -----------
 arch/powerpc/Makefile.postlink | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 11 deletions(-)
 create mode 100644 arch/powerpc/Makefile.postlink

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 617dece..314dd77 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -263,17 +263,6 @@ PHONY += $(BOOT_TARGETS1) $(BOOT_TARGETS2)
 
 boot := arch/$(ARCH)/boot
 
-ifeq ($(CONFIG_RELOCATABLE),y)
-quiet_cmd_relocs_check = CALL    $<
-      cmd_relocs_check = $(CONFIG_SHELL) $< "$(OBJDUMP)" "$(obj)/vmlinux"
-
-PHONY += relocs_check
-relocs_check: arch/powerpc/relocs_check.sh vmlinux
-	$(call cmd,relocs_check)
-
-zImage: relocs_check
-endif
-
 $(BOOT_TARGETS1): vmlinux
 	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 $(BOOT_TARGETS2): vmlinux
diff --git a/arch/powerpc/Makefile.postlink b/arch/powerpc/Makefile.postlink
new file mode 100644
index 0000000..f90bdc0
--- /dev/null
+++ b/arch/powerpc/Makefile.postlink
@@ -0,0 +1,34 @@
+# ===========================================================================
+# Post-link powerpc pass
+# ===========================================================================
+#
+# 1. Check that vmlinux relocations look sane
+
+PHONY := __archpost
+__archpost:
+
+include include/config/auto.conf
+include scripts/Kbuild.include
+
+quiet_cmd_relocs_check = CHKREL  $@
+      cmd_relocs_check = $(CONFIG_SHELL) $(srctree)/arch/powerpc/relocs_check.sh "$(OBJDUMP)" "$@"
+
+# `@true` prevents complaint when there is nothing to be done
+
+vmlinux: FORCE
+	@true
+ifeq ($(CONFIG_RELOCATABLE),y)
+	$(call if_changed,relocs_check)
+endif
+
+%.ko: FORCE
+	@true
+
+clean:
+	@true
+
+PHONY += FORCE clean
+
+FORCE:
+
+.PHONY: $(PHONY)
-- 
2.9.3
