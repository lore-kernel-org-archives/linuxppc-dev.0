Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8702B1A0075
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2015 19:20:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aarcange@redhat.com
Subject: [PATCH] powerpc: Wire up sys_userfaultfd()
Date: Thu, 10 Sep 2015 19:20:54 +1000
Message-Id: <1441876854-9493-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The selftest passes on 64-bit LE and BE.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/systbl.h      | 1 +
 arch/powerpc/include/asm/unistd.h      | 2 +-
 arch/powerpc/include/uapi/asm/unistd.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 71f2b3f02cf8..4d65499ee1c1 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -368,3 +368,4 @@ SYSCALL_SPU(memfd_create)
 SYSCALL_SPU(bpf)
 COMPAT_SYS(execveat)
 PPC64ONLY(switch_endian)
+SYSCALL_SPU(userfaultfd)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index f4f8b667d75b..4a055b6c2a64 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define __NR_syscalls		364
+#define __NR_syscalls		365
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index e4aa173dae62..6ad58d4c879b 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -386,5 +386,6 @@
 #define __NR_bpf		361
 #define __NR_execveat		362
 #define __NR_switch_endian	363
+#define __NR_userfaultfd	364
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.1.4
