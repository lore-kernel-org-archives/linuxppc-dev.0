Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNyRV2hrmzDqMG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 01:57:26 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id a23so3726418pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 08:57:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 5/5] powerpc/64: Linker on-demand sfpr functions for modules
Date: Fri, 12 May 2017 01:56:52 +1000
Message-Id: <20170511155652.8287-6-npiggin@gmail.com>
In-Reply-To: <20170511155652.8287-1-npiggin@gmail.com>
References: <20170511155652.8287-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For final link, the powerpc64 linker generates fpr save/restore
functions on-demand, placing them in the .sfpr section. Starting with
binutils 2.25, these can be provided for non-final links with
--save-restore-funcs. Use that where possible for module links.

This saves about 200 bytes per module (~60kB) on powernv defconfig
build.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile     | 10 ++++++++++
 arch/powerpc/lib/Makefile | 13 ++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 3e0f0e1fadef..eaa1865e4a8d 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -189,7 +189,17 @@ else
 CHECKFLAGS	+= -D__LITTLE_ENDIAN__
 endif
 
+ifdef CONFIG_PPC32
 KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
+else
+ifeq ($(call ld-ifversion, -ge, 225000000, y),y)
+# Have the linker provide sfpr if possible.
+# There is a corresponding test in arch/powerpc/lib/Makefile
+KBUILD_LDFLAGS_MODULE += --save-restore-funcs
+else
+KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
+endif
+endif
 
 ifeq ($(CONFIG_476FPE_ERR46),y)
 	KBUILD_LDFLAGS_MODULE += --ppc476-workaround \
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 0ca405a27ac1..2c56f4636c2b 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -11,12 +11,15 @@ CFLAGS_REMOVE_feature-fixups.o = $(CC_FLAGS_FTRACE)
 
 obj-y += string.o alloc.o code-patching.o feature-fixups.o
 
-# 64-bit linker creates .sfpr on demand for final link (vmlinux),
-# so it is only needed for modules.
-obj-$(CONFIG_PPC32) += crtsavres.o
-extra-$(CONFIG_PPC64) += crtsavres.o
+obj-$(CONFIG_PPC32)	+= div64.o copy_32.o crtsavres.o
 
-obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
+# See corresponding test in arch/powerpc/Makefile
+# 64-bit linker creates .sfpr on demand for final link (vmlinux),
+# so it is only needed for modules, and only for older linkers which
+# do not support --save-restore-funcs
+ifeq ($(call ld-ifversion, -lt, 225000000, y),y)
+extra-$(CONFIG_PPC64)	+= crtsavres.o
+endif
 
 obj64-y	+= copypage_64.o copyuser_64.o mem_64.o hweight_64.o \
 	   copyuser_power7.o string_64.o copypage_power7.o memcpy_power7.o \
-- 
2.11.0
