Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C54FC1A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 13:06:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>,
 luto@kernel.org
Subject: [PATCH] powerpc/vdso: Emit GNU & SysV hashes
Date: Fri,  7 Aug 2015 13:05:42 +1000
Message-Id: <1438916742-31924-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andy Lutomirski says:

  Some dynamic loaders may be slightly faster if a GNU hash is
  available.

  This is unlikely to have any measurable effect on the time it takes
  to resolve vdso symbols (since there are so few of them).  In some
  contexts, it can be a win for a different reason: if every DSO has a
  GNU hash section, then libc can avoid calculating SysV hashes at
  all. Both musl and glibc appear to have this optimization.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/vdso32/Makefile | 2 +-
 arch/powerpc/kernel/vdso64/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
index 53e6c9b979ec..6abffb7a8cd9 100644
--- a/arch/powerpc/kernel/vdso32/Makefile
+++ b/arch/powerpc/kernel/vdso32/Makefile
@@ -18,7 +18,7 @@ GCOV_PROFILE := n
 
 ccflags-y := -shared -fno-common -fno-builtin
 ccflags-y += -nostdlib -Wl,-soname=linux-vdso32.so.1 \
-		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
+		$(call cc-ldoption, -Wl$(comma)--hash-style=both)
 asflags-y := -D__VDSO32__ -s
 
 obj-y += vdso32_wrapper.o
diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
index effca9404b17..8c8f2ae43935 100644
--- a/arch/powerpc/kernel/vdso64/Makefile
+++ b/arch/powerpc/kernel/vdso64/Makefile
@@ -11,7 +11,7 @@ GCOV_PROFILE := n
 
 ccflags-y := -shared -fno-common -fno-builtin
 ccflags-y += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
-		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
+		$(call cc-ldoption, -Wl$(comma)--hash-style=both)
 asflags-y := -D__VDSO64__ -s
 
 obj-y += vdso64_wrapper.o
-- 
2.1.4
