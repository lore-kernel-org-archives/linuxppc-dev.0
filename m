Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C78CEDE2E0
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 08:11:51 +1100 (EST)
Date: Thu, 31 Jan 2008 14:11:41 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20080131211141.GA11658@farnsworth.org>
MIME-Version: 1.0
Subject: [PATCH] [POWERPC] Remove dead code at KernelAltiVec
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---
This code doesn't seem to be referenced anywhere.

 arch/powerpc/kernel/head_32.S |   17 -----------------
 arch/ppc/kernel/head.S        |   17 -----------------
 2 files changed, 0 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 0f4fac5..c16d135 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -763,23 +763,6 @@ load_up_altivec:
 	b	fast_exception_return
 
 /*
- * AltiVec unavailable trap from kernel - print a message, but let
- * the task use AltiVec in the kernel until it returns to user mode.
- */
-KernelAltiVec:
-	lwz	r3,_MSR(r1)
-	oris	r3,r3,MSR_VEC@h
-	stw	r3,_MSR(r1)	/* enable use of AltiVec after return */
-	lis	r3,87f@h
-	ori	r3,r3,87f@l
-	mr	r4,r2		/* current */
-	lwz	r5,_NIP(r1)
-	bl	printk
-	b	ret_from_except
-87:	.string	"AltiVec used in kernel  (task=%p, pc=%x)  \n"
-	.align	4,0
-
-/*
  * giveup_altivec(tsk)
  * Disable AltiVec for the task given as the argument,
  * and save the AltiVec registers in its thread_struct.
diff --git a/arch/ppc/kernel/head.S b/arch/ppc/kernel/head.S
index 1b0ec72..e7e642b 100644
--- a/arch/ppc/kernel/head.S
+++ b/arch/ppc/kernel/head.S
@@ -701,23 +701,6 @@ load_up_altivec:
 	b	fast_exception_return
 
 /*
- * AltiVec unavailable trap from kernel - print a message, but let
- * the task use AltiVec in the kernel until it returns to user mode.
- */
-KernelAltiVec:
-	lwz	r3,_MSR(r1)
-	oris	r3,r3,MSR_VEC@h
-	stw	r3,_MSR(r1)	/* enable use of AltiVec after return */
-	lis	r3,87f@h
-	ori	r3,r3,87f@l
-	mr	r4,r2		/* current */
-	lwz	r5,_NIP(r1)
-	bl	printk
-	b	ret_from_except
-87:	.string	"AltiVec used in kernel  (task=%p, pc=%x)  \n"
-	.align	4,0
-
-/*
  * giveup_altivec(tsk)
  * Disable AltiVec for the task given as the argument,
  * and save the AltiVec registers in its thread_struct.
