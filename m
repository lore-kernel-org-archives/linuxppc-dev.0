Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E64AEDE102
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 07:26:30 +1000 (EST)
Date: Wed, 9 Apr 2008 16:22:11 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC] Make Book-E debug handling SMP safe
Message-ID: <Pine.LNX.4.64.0804091621140.24556@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

global_dbcr0 needs to be a per cpu set of save areas instead of a single
global on all processors.

Also, we switch to using DBCR0_IDM to determine if the user space app is
being debugged as its a more consistent way.  In the future we should
support features like hardware breakpoint and watchpoints which will
have DBCR0_IDM set but not necessarily DBCR0_IC (single step).

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Paul, you wrote the original code here so please take a look at this.

- k

 arch/powerpc/kernel/entry_32.S |   30 +++++++++++++++++++++---------
 1 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 69a91bd..84c8686 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -110,9 +110,9 @@ transfer_to_handler:
 	stw	r11,PT_REGS(r12)
 #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
 	/* Check to see if the dbcr0 register is set up to debug.  Use the
-	   single-step bit to do this. */
+	   internal debug mode bit to do this. */
 	lwz	r12,THREAD_DBCR0(r12)
-	andis.	r12,r12,DBCR0_IC@h
+	andis.	r12,r12,DBCR0_IDM@h
 	beq+	3f
 	/* From user and task is ptraced - load up global dbcr0 */
 	li	r12,-1			/* clear all pending debug events */
@@ -120,6 +120,12 @@ transfer_to_handler:
 	lis	r11,global_dbcr0@ha
 	tophys(r11,r11)
 	addi	r11,r11,global_dbcr0@l
+#ifdef CONFIG_SMP
+	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
+	lwz	r9,TI_CPU(r9)
+	slwi	r9,r9,3
+	add	r11,r11,r9
+#endif
 	lwz	r12,0(r11)
 	mtspr	SPRN_DBCR0,r12
 	lwz	r12,4(r11)
@@ -238,10 +244,10 @@ ret_from_syscall:
 	stw	r11,_CCR(r1)
 syscall_exit_cont:
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
-	/* If the process has its own DBCR0 value, load it up.  The single
-	   step bit tells us that dbcr0 should be loaded. */
+	/* If the process has its own DBCR0 value, load it up.  The internal
+	   debug mode bit tells us that dbcr0 should be loaded. */
 	lwz	r0,THREAD+THREAD_DBCR0(r2)
-	andis.	r10,r0,DBCR0_IC@h
+	andis.	r10,r0,DBCR0_IDM@h
 	bnel-	load_dbcr0
 #endif
 #ifdef CONFIG_44x
@@ -666,10 +672,10 @@ user_exc_return:		/* r10 contains MSR_KERNEL here */

 restore_user:
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
-	/* Check whether this process has its own DBCR0 value.  The single
-	   step bit tells us that dbcr0 should be loaded. */
+	/* Check whether this process has its own DBCR0 value.  The internal
+	   debug mode bit tells us that dbcr0 should be loaded. */
 	lwz	r0,THREAD+THREAD_DBCR0(r2)
-	andis.	r10,r0,DBCR0_IC@h
+	andis.	r10,r0,DBCR0_IDM@h
 	bnel-	load_dbcr0
 #endif

@@ -879,6 +885,12 @@ load_dbcr0:
 	mfspr	r10,SPRN_DBCR0
 	lis	r11,global_dbcr0@ha
 	addi	r11,r11,global_dbcr0@l
+#ifdef CONFIG_SMP
+	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
+	lwz	r9,TI_CPU(r9)
+	slwi	r9,r9,3
+	add	r11,r11,r9
+#endif
 	stw	r10,0(r11)
 	mtspr	SPRN_DBCR0,r0
 	lwz	r10,4(r11)
@@ -891,7 +903,7 @@ load_dbcr0:
 	.section .bss
 	.align	4
 global_dbcr0:
-	.space	8
+	.space	8*NR_CPUS
 	.previous
 #endif /* !(CONFIG_4xx || CONFIG_BOOKE) */

-- 
1.5.4.1
