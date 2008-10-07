Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id B9812DDEFC
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 03:11:26 +1100 (EST)
Received: by gxk14 with SMTP id 14so9248248gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 07 Oct 2008 09:11:25 -0700 (PDT)
Date: Tue, 7 Oct 2008 12:10:03 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH] powerpc: Fix error path in kernel_thread function
Message-ID: <20081007161003.GA5727@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, jpoimboe@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Josh Poimboeuf <jpoimboe@us.ibm.com>

The powerpc 32-bit and 64-bit kernel_thread functions don't properly
propagate errors being returned by the clone syscall.  (In the case of
error, the syscall exit code returns a positive errno in r3 and sets
the CR0[SO] bit.)

This patch fixes that by negating r3 if CR0[SO] is set after the syscall.

Signed-off-by: Josh Poimboeuf <jpoimboe@us.ibm.com>
Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/misc_32.S |    8 +++++---
 arch/powerpc/kernel/misc_64.S |    8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 7a6dfbc..1fe9f62 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -846,8 +846,10 @@ _GLOBAL(kernel_thread)
 	li	r4,0		/* new sp (unused) */
 	li	r0,__NR_clone
 	sc
-	cmpwi	0,r3,0		/* parent or child? */
-	bne	1f		/* return if parent */
+	bns+	1f		/* did system call indicate error? */
+	neg	r3,r3		/* if so, make return code negative */
+1:	cmpwi	0,r3,0		/* parent or child? */
+	bne	2f		/* return if parent */
 	li	r0,0		/* make top-level stack frame */
 	stwu	r0,-16(r1)
 	mtlr	r30		/* fn addr in lr */
@@ -857,7 +859,7 @@ _GLOBAL(kernel_thread)
 	li	r0,__NR_exit	/* exit if function returns */
 	li	r3,0
 	sc
-1:	lwz	r30,8(r1)
+2:	lwz	r30,8(r1)
 	lwz	r31,12(r1)
 	addi	r1,r1,16
 	blr
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 4dd70cf..3053fe5 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -426,8 +426,10 @@ _GLOBAL(kernel_thread)
 	li	r4,0		/* new sp (unused) */
 	li	r0,__NR_clone
 	sc
-	cmpdi	0,r3,0		/* parent or child? */
-	bne	1f		/* return if parent */
+	bns+	1f		/* did system call indicate error? */
+	neg	r3,r3		/* if so, make return code negative */
+1:	cmpdi	0,r3,0		/* parent or child? */
+	bne	2f		/* return if parent */
 	li	r0,0
 	stdu	r0,-STACK_FRAME_OVERHEAD(r1)
 	ld	r2,8(r29)
@@ -438,7 +440,7 @@ _GLOBAL(kernel_thread)
 	li	r0,__NR_exit	/* exit after child exits */
         li	r3,0
 	sc
-1:	addi	r1,r1,STACK_FRAME_OVERHEAD	
+2:	addi	r1,r1,STACK_FRAME_OVERHEAD
 	ld	r29,-24(r1)
 	ld	r30,-16(r1)
 	blr
-- 
1.5.5.1
