Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bf6v3QDyzF2T9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 23:21:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] powerpc/syscalls: kill ppc32_select()
Date: Wed,  2 May 2018 23:20:50 +1000
Message-Id: <20180502132051.28861-5-mpe@ellerman.id.au>
In-Reply-To: <20180502132051.28861-1-mpe@ellerman.id.au>
References: <20180502132051.28861-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Al Viro <viro@zeniv.linux.org.uk>

it had always been pointless - compat_sys_select() sign-extends
the first argument just fine on its own.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[mpe: Use COMPAT_SPU_NEW() to keep systbl_chk.sh happy]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/systbl.h | 2 +-
 arch/powerpc/kernel/sys_ppc32.c   | 9 ---------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index b91701c0711a..cdf528089a63 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -147,7 +147,7 @@ SYSCALL_SPU(setfsuid)
 SYSCALL_SPU(setfsgid)
 SYSCALL_SPU(llseek)
 COMPAT_SYS_SPU(getdents)
-SYSX_SPU(sys_select,ppc32_select,sys_select)
+COMPAT_SPU_NEW(select)
 SYSCALL_SPU(flock)
 SYSCALL_SPU(msync)
 COMPAT_SYS_SPU(readv)
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index c11c73373691..bdf58ba1a94b 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -52,15 +52,6 @@
 #include <asm/syscalls.h>
 #include <asm/switch_to.h>
 
-
-asmlinkage long ppc32_select(u32 n, compat_ulong_t __user *inp,
-		compat_ulong_t __user *outp, compat_ulong_t __user *exp,
-		compat_uptr_t tvp_x)
-{
-	/* sign extend n */
-	return compat_sys_select((int)n, inp, outp, exp, compat_ptr(tvp_x));
-}
-
 unsigned long compat_sys_mmap2(unsigned long addr, size_t len,
 			  unsigned long prot, unsigned long flags,
 			  unsigned long fd, unsigned long pgoff)
-- 
2.14.1
