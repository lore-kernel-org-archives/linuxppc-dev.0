Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA3B01A023E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 18:16:00 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Use standard macros for sys_sigpending() &
 sys_old_getrlimit()
Date: Tue, 24 Jun 2014 18:15:57 +1000
Message-Id: <1403597757-5735-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we have sys_sigpending and sys_old_getrlimit defined to use
COMPAT_SYS() in systbl.h, but then both are #defined to sys_ni_syscall
in systbl.S.

This seems to have been done when ppc and ppc64 were merged, in commit
9994a33 "Introduce entry_{32,64}.S, misc_{32,64}.S, systbl.S".

AFAICS there's no longer (or never was) any need for this, we can just
use SYSX() for both and remove the #defines to sys_ni_syscall.

The expansion before was:

  #define COMPAT_SYS(func)	.llong	.sys_##func,.compat_sys_##func
  #define sys_old_getrlimit sys_ni_syscall
  COMPAT_SYS(old_getrlimit)
  =>
  .llong	.sys_old_getrlimit,.compat_sys_old_getrlimit
  =>
  .llong	.sys_ni_syscall,.compat_sys_old_getrlimit

After is:

  #define SYSX(f, f3264, f32)	.llong	.f,.f3264
  SYSX(sys_ni_syscall, compat_sys_old_getrlimit, sys_old_getrlimit)
  =>
  .llong	.sys_ni_syscall,.compat_sys_old_getrlimit

ie. they are equivalent.

Finally both COMPAT_SYS() and SYSX() evaluate to sys_ni_syscall in the
Cell SPU code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/systbl.h | 4 ++--
 arch/powerpc/kernel/systbl.S      | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index babbeca..542bc0f 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -77,10 +77,10 @@ SYSCALL_SPU(setreuid)
 SYSCALL_SPU(setregid)
 #define compat_sys_sigsuspend sys_sigsuspend
 SYS32ONLY(sigsuspend)
-COMPAT_SYS(sigpending)
+SYSX(sys_ni_syscall,compat_sys_sigpending,sys_sigpending)
 SYSCALL_SPU(sethostname)
 COMPAT_SYS_SPU(setrlimit)
-COMPAT_SYS(old_getrlimit)
+SYSX(sys_ni_syscall,compat_sys_old_getrlimit,sys_old_getrlimit)
 COMPAT_SYS_SPU(getrusage)
 COMPAT_SYS_SPU(gettimeofday)
 COMPAT_SYS_SPU(settimeofday)
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 895c50c..7ab5d43 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -39,9 +39,6 @@
 .section .rodata,"a"
 
 #ifdef CONFIG_PPC64
-#define sys_sigpending	sys_ni_syscall
-#define sys_old_getrlimit sys_ni_syscall
-
 	.p2align	3
 #endif
 
-- 
1.9.1
