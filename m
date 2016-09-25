Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shdh76XJKzDrPd
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 17:16:55 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/vdso64: Use double word compare on pointers
Date: Sun, 25 Sep 2016 17:16:53 +1000
Message-Id: <1474787813-22587-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

__kernel_get_syscall_map and __kernel_clock_getres use cmpli to
check if the passed in pointer is non zero. cmpli maps to a 32 bit
compare on binutils, so we ignore the top 32 bits.

A simple test case can be created by passing in a bogus pointer with
the bottom 32 bits clear. Using a clk_id that is handled by the VDSO,
then one that is handled by the kernel shows the problem:

        printf("%d\n", clock_getres(CLOCK_REALTIME, (void *)0x100000000));
        printf("%d\n", clock_getres(CLOCK_BOOTTIME, (void *)0x100000000));

And we get:

0
-1

The bigger issue is if we pass a valid pointer with the bottom 32 bits
clear, in this case we will return success but won't write any data
to the pointer.

I stumbled across this issue because the LLVM integrated assembler
doesn't accept cmpli with 3 arguments. Fix this by converting them to
cmpldi.

Cc: stable@vger.kernel.org
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/vdso64/datapage.S     | 2 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vdso64/datapage.S b/arch/powerpc/kernel/vdso64/datapage.S
index 184a6ba..abf17fe 100644
--- a/arch/powerpc/kernel/vdso64/datapage.S
+++ b/arch/powerpc/kernel/vdso64/datapage.S
@@ -59,7 +59,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	bl	V_LOCAL_FUNC(__get_datapage)
 	mtlr	r12
 	addi	r3,r3,CFG_SYSCALL_MAP64
-	cmpli	cr0,r4,0
+	cmpldi	cr0,r4,0
 	crclr	cr0*4+so
 	beqlr
 	li	r0,NR_syscalls
diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index a76b4af..3820213 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -145,7 +145,7 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 	bne	cr0,99f
 
 	li	r3,0
-	cmpli	cr0,r4,0
+	cmpldi	cr0,r4,0
 	crclr	cr0*4+so
 	beqlr
 	lis	r5,CLOCK_REALTIME_RES@h
-- 
2.7.4
