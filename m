Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szHCX4STDzDt3K
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 14:16:24 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id i85so1092577pfa.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 20:16:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 2/7] powerpc: add arch/powerpc/tools directory
Date: Wed, 19 Oct 2016 14:15:55 +1100
Message-Id: <20161019031600.17933-3-npiggin@gmail.com>
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

Move a couple of existing scripts there, and remove scripts directory:
a script is a tool, a tool is not a script. I plan to add some tools
that require compilation (though not in this series), so this matches
other architectures more closely.

Signed-off-by: Nick Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile                                        | 2 +-
 arch/powerpc/Makefile.postlink                               | 2 +-
 arch/powerpc/{scripts => tools}/gcc-check-mprofile-kernel.sh | 0
 arch/powerpc/{ => tools}/relocs_check.sh                     | 0
 4 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/powerpc/{scripts => tools}/gcc-check-mprofile-kernel.sh (100%)
 rename arch/powerpc/{ => tools}/relocs_check.sh (100%)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 314dd77..0fcb47c 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -126,7 +126,7 @@ CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
 endif
 
 ifdef CONFIG_MPROFILE_KERNEL
-    ifeq ($(shell $(srctree)/arch/powerpc/scripts/gcc-check-mprofile-kernel.sh $(CC) -I$(srctree)/include -D__KERNEL__),OK)
+    ifeq ($(shell $(srctree)/arch/powerpc/tools/gcc-check-mprofile-kernel.sh $(CC) -I$(srctree)/include -D__KERNEL__),OK)
         CC_FLAGS_FTRACE := -pg -mprofile-kernel
         KBUILD_CPPFLAGS += -DCC_USING_MPROFILE_KERNEL
     else
diff --git a/arch/powerpc/Makefile.postlink b/arch/powerpc/Makefile.postlink
index f90bdc0..29c0a3a 100644
--- a/arch/powerpc/Makefile.postlink
+++ b/arch/powerpc/Makefile.postlink
@@ -11,7 +11,7 @@ include include/config/auto.conf
 include scripts/Kbuild.include
 
 quiet_cmd_relocs_check = CHKREL  $@
-      cmd_relocs_check = $(CONFIG_SHELL) $(srctree)/arch/powerpc/relocs_check.sh "$(OBJDUMP)" "$@"
+      cmd_relocs_check = $(CONFIG_SHELL) $(srctree)/arch/powerpc/tools/relocs_check.sh "$(OBJDUMP)" "$@"
 
 # `@true` prevents complaint when there is nothing to be done
 
diff --git a/arch/powerpc/scripts/gcc-check-mprofile-kernel.sh b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
similarity index 100%
rename from arch/powerpc/scripts/gcc-check-mprofile-kernel.sh
rename to arch/powerpc/tools/gcc-check-mprofile-kernel.sh
diff --git a/arch/powerpc/relocs_check.sh b/arch/powerpc/tools/relocs_check.sh
similarity index 100%
rename from arch/powerpc/relocs_check.sh
rename to arch/powerpc/tools/relocs_check.sh
-- 
2.9.3
