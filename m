Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsxZh4bRqzF1mg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 15:46:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexander.Levin@microsoft.com
Cc: stable@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	npiggin@gmail.com
Subject: [PATCH v4.1 backport 15/15] powerpc/vdso64: Use double word compare
 on pointers
Date: Fri,  2 Mar 2018 15:45:49 +1100
Message-Id: <20180302044549.14930-16-mpe@ellerman.id.au>
In-Reply-To: <20180302044549.14930-1-mpe@ellerman.id.au>
References: <20180302044549.14930-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

commit 5045ea37377ce8cca6890d32b127ad6770e6dce5 upstream.

__kernel_get_syscall_map() and __kernel_clock_getres() use cmpli to
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

Fixes: a7f290dad32e ("[PATCH] powerpc: Merge vdso's and add vdso support to 32 bits kernel")
Cc: stable@vger.kernel.org # v2.6.15+
Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/vdso64/datapage.S     | 2 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vdso64/datapage.S b/arch/powerpc/kernel/vdso64/datapage.S
index 79796de11737..3263ee23170d 100644
--- a/arch/powerpc/kernel/vdso64/datapage.S
+++ b/arch/powerpc/kernel/vdso64/datapage.S
@@ -57,7 +57,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	bl	V_LOCAL_FUNC(__get_datapage)
 	mtlr	r12
 	addi	r3,r3,CFG_SYSCALL_MAP64
-	cmpli	cr0,r4,0
+	cmpldi	cr0,r4,0
 	crclr	cr0*4+so
 	beqlr
 	li	r0,__NR_syscalls
diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index a76b4af37ef2..382021324883 100644
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
2.14.1
