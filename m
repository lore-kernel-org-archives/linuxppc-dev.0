Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSW766cFmzDwD3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:40:02 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 144so7527088pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 20:40:02 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] powerpc/64: do not link crtsavres routines into vmlinux
Date: Tue, 29 Nov 2016 15:39:40 +1100
Message-Id: <20161129043942.13848-3-npiggin@gmail.com>
In-Reply-To: <20161129043942.13848-1-npiggin@gmail.com>
References: <20161129043942.13848-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 64-bit linker creates save/restore functions on demand. crtsavres.o
is still required to link against modules (which do not get their
save/restore created automatically, due to not being a final link).

Make crtsavres.o extra-y on 64-bit, rather than obj-y.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/lib/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 309361e8..cb02027 100644
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
2.10.2
