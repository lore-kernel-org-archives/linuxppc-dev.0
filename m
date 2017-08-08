Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRPpJ1F5xzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 16:37:28 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: Fix boot failure on non 6xx platforms
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170808063724.B755C653E1@po15668-vm-win7.idsi0.si.c-s.fr>
Date: Tue,  8 Aug 2017 08:37:24 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit d300627c6a536 ("powerpc/6xx: Handle DABR match before
calling do_page_fault") breaks non 6xx platforms.

[    6.029556] Failed to execute /init (error -14)
[    6.034623] Starting init: /bin/sh exists but couldn't execute it
(error -14)
[    6.041489] Kernel panic - not syncing: No working init found.  Try
passing init= option to kernel. See Linux
Documentation/admin-guide/init.rst for guidance.
[    6.055518] CPU: 0 PID: 1 Comm: init Not tainted
4.13.0-rc3-s3k-dev-00143-g7aa62e972a56 #56
[    6.063745] Call Trace:
[    6.066224] [c60f1ed0] [c001a624] panic+0x108/0x250 (unreliable)
[    6.072140] [c60f1f30] [c0002640] rootfs_mount+0x0/0x58
[    6.077311] [c60f1f40] [c000cb80] ret_from_kernel_thread+0x5c/0x64
[    6.083405] Rebooting in 180 seconds..

This is because in handle_page_fault(), the call to do_page_fault()
has been mistakenly enclosed inside an #ifdef CONFIG_6xx

Fixes: d300627c6a536 ("powerpc/6xx: Handle DABR match before
calling do_page_fault")

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_32.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index dff51ea52e49..b14bf7def2e2 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -586,11 +586,11 @@ ppc_swapcontext:
 handle_page_fault:
 	stw	r4,_DAR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	andis.  r0,r5,DSISR_DABRMATCH@h
 #ifdef CONFIG_6xx
+	andis.  r0,r5,DSISR_DABRMATCH@h
 	bne-    handle_dabr_fault
-	bl	do_page_fault
 #endif
+	bl	do_page_fault
 	cmpwi	r3,0
 	beq+	ret_from_except
 	SAVE_NVGPRS(r1)
-- 
2.13.3
