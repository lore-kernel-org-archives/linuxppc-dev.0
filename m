Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNyRJ34fhzDqZb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 01:57:16 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id s62so4058044pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 08:57:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/5] powerpc/64: do not link crtsavres.o in vmlinux
Date: Fri, 12 May 2017 01:56:49 +1000
Message-Id: <20170511155652.8287-3-npiggin@gmail.com>
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

The 64-bit linker creates save/restore functions on demand with final
links, so vmlinux does not require crtsavres.o.

Make crtsavres.o extra-y on 64-bit (it is still required by modules).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/lib/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index ed7dfce331e0..0ca405a27ac1 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -9,8 +9,12 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 CFLAGS_REMOVE_code-patching.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_feature-fixups.o = $(CC_FLAGS_FTRACE)
 
-obj-y += string.o alloc.o crtsavres.o code-patching.o \
-	 feature-fixups.o
+obj-y += string.o alloc.o code-patching.o feature-fixups.o
+
+# 64-bit linker creates .sfpr on demand for final link (vmlinux),
+# so it is only needed for modules.
+obj-$(CONFIG_PPC32) += crtsavres.o
+extra-$(CONFIG_PPC64) += crtsavres.o
 
 obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
 
-- 
2.11.0
