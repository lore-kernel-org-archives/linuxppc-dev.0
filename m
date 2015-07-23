Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DD391A02CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 20:21:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>, keescook@chromium.org, luto@amacapital.net,
 wad@chromium.org, strosake@linux.vnet.ibm.com,
 bogdan.purcareata@freescale.com
Subject: [PATCH 01/11] powerpc/kernel: Switch to using MAX_ERRNO
Date: Thu, 23 Jul 2015 20:21:01 +1000
Message-Id: <1437646871-3195-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently on powerpc we have our own #define for the highest (negative)
errno value, called _LAST_ERRNO. This is defined to be 516, for reasons
which are not clear.

The generic code, and x86, use MAX_ERRNO, which is defined to be 4095.

In particular seccomp uses MAX_ERRNO to restrict the value that a
seccomp filter can return.

Currently with the mismatch between _LAST_ERRNO and MAX_ERRNO, a seccomp
tracer wanting to return 600, expecting it to be seen as an error, would
instead find on powerpc that userspace sees a successful syscall with a
return value of 600.

To avoid this inconsistency, switch powerpc to use MAX_ERRNO.

We are somewhat confident that generic syscalls that can return a
non-error value above negative MAX_ERRNO have already been updated to
use force_successful_syscall_return().

I have also checked all the powerpc specific syscalls, and believe that
none of them expect to return a non-error value between -MAX_ERRNO and
-516. So this change should be safe ...

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/uapi/asm/errno.h | 2 --
 arch/powerpc/kernel/entry_32.S        | 3 ++-
 arch/powerpc/kernel/entry_64.S        | 5 +++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/errno.h b/arch/powerpc/include/uapi/asm/errno.h
index 8c145fd17d86..e8b6b5f7de7c 100644
--- a/arch/powerpc/include/uapi/asm/errno.h
+++ b/arch/powerpc/include/uapi/asm/errno.h
@@ -6,6 +6,4 @@
 #undef	EDEADLOCK
 #define	EDEADLOCK	58	/* File locking deadlock error */
 
-#define _LAST_ERRNO	516
-
 #endif	/* _ASM_POWERPC_ERRNO_H */
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 46fc0f4d8982..67ecdf61f4e3 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -20,6 +20,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/err.h>
 #include <linux/sys.h>
 #include <linux/threads.h>
 #include <asm/reg.h>
@@ -354,7 +355,7 @@ ret_from_syscall:
 	SYNC
 	MTMSRD(r10)
 	lwz	r9,TI_FLAGS(r12)
-	li	r8,-_LAST_ERRNO
+	li	r8,-MAX_ERRNO
 	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
 	bne-	syscall_exit_work
 	cmplw	0,r3,r8
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 579e0f9a2d57..ee15d3c62e26 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -19,6 +19,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/err.h>
 #include <asm/unistd.h>
 #include <asm/processor.h>
 #include <asm/page.h>
@@ -207,7 +208,7 @@ system_call:			/* label this so stack traces look sane */
 #endif /* CONFIG_PPC_BOOK3E */
 
 	ld	r9,TI_FLAGS(r12)
-	li	r11,-_LAST_ERRNO
+	li	r11,-MAX_ERRNO
 	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
 	bne-	syscall_exit_work
 	cmpld	r3,r11
@@ -277,7 +278,7 @@ syscall_exit_work:
 	beq+	0f
 	REST_NVGPRS(r1)
 	b	2f
-0:	cmpld	r3,r11		/* r10 is -LAST_ERRNO */
+0:	cmpld	r3,r11		/* r11 is -MAX_ERRNO */
 	blt+	1f
 	andi.	r0,r9,_TIF_NOERROR
 	bne-	1f
-- 
2.1.0
