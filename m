Return-Path: <groeck7@gmail.com>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C92DB1400A0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 May 2014 10:08:12 +1000 (EST)
Received: by mail-pd0-f180.google.com with SMTP id y10so4318748pdj.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 May 2014 17:08:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Fix "attempt to move .org backwards" error (again)
Date: Fri,  9 May 2014 17:07:58 -0700
Message-Id: <1399680478-4970-1-git-send-email-linux@roeck-us.net>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 4e243b7 (powerpc: Fix "attempt to move .org backwards" error) fixes the
allyesconfig build by moving machine_check_common to a different location.
While this fixes most of the errors, both allmodconfig and allyesconfig still
fail as follows.

arch/powerpc/kernel/exceptions-64s.S:1315: Error: attempt to move .org backwards

Fix by moving machine_check_common after the offending address.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This fixes the build error, but unfortunately I don't have a system to test
the resulting image.

 arch/powerpc/kernel/exceptions-64s.S | 49 ++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 3afd391..25398be 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1138,31 +1138,6 @@ unrecov_user_slb:
 
 #endif /* __DISABLED__ */
 
-
-	/*
-	 * Machine check is different because we use a different
-	 * save area: PACA_EXMC instead of PACA_EXGEN.
-	 */
-	.align	7
-	.globl machine_check_common
-machine_check_common:
-
-	mfspr	r10,SPRN_DAR
-	std	r10,PACA_EXGEN+EX_DAR(r13)
-	mfspr	r10,SPRN_DSISR
-	stw	r10,PACA_EXGEN+EX_DSISR(r13)
-	EXCEPTION_PROLOG_COMMON(0x200, PACA_EXMC)
-	FINISH_NAP
-	DISABLE_INTS
-	ld	r3,PACA_EXGEN+EX_DAR(r13)
-	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
-	bl	.save_nvgprs
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	.machine_check_exception
-	b	.ret_from_except
-
 	.align	7
 	.globl alignment_common
 alignment_common:
@@ -1328,6 +1303,30 @@ fwnmi_data_area:
 initial_stab:
 	.space	4096
 
+	/*
+	 * Machine check is different because we use a different
+	 * save area: PACA_EXMC instead of PACA_EXGEN.
+	 */
+	.align	7
+	.globl machine_check_common
+machine_check_common:
+
+	mfspr	r10,SPRN_DAR
+	std	r10,PACA_EXGEN+EX_DAR(r13)
+	mfspr	r10,SPRN_DSISR
+	stw	r10,PACA_EXGEN+EX_DSISR(r13)
+	EXCEPTION_PROLOG_COMMON(0x200, PACA_EXMC)
+	FINISH_NAP
+	DISABLE_INTS
+	ld	r3,PACA_EXGEN+EX_DAR(r13)
+	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
+	std	r3,_DAR(r1)
+	std	r4,_DSISR(r1)
+	bl	.save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.machine_check_exception
+	b	.ret_from_except
+
 #ifdef CONFIG_PPC_POWERNV
 _GLOBAL(opal_mc_secondary_handler)
 	HMT_MEDIUM_PPR_DISCARD
-- 
1.9.1
