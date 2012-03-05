Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 81315B6FB9
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Mar 2012 13:52:43 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Mon, 5 Mar 2012 02:50:12 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q252kqlU3408098
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2012 13:46:54 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q252qQAb007476
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2012 13:52:26 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/13] powerpc: Improve 64-bit syscall entry/exit
Date: Mon,  5 Mar 2012 13:51:22 +1100
Message-Id: <1330915891-19523-5-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1330915891-19523-1-git-send-email-benh@kernel.crashing.org>
References: <1330915891-19523-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We unconditionally hard enable interrupts. This is unnecessary as
syscalls are expected to always be called with interrupts enabled.

While at it, we add a WARN_ON if that is not the case and
CONFIG_TRACE_IRQFLAGS is enabled (we don't want to add overhead
to the fast path when this is not set though).

Thus let's remove the enabling (and associated irq tracing) from
the syscall entry path. Also on Book3S, replace a few mfmsr
instructions with loads of PACAMSR from the PACA, which should be
faster & schedule better.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/entry_64.S |   43 +++++++++++++++++++++------------------
 1 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 0c3764b..cc030b7 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -115,28 +115,33 @@ BEGIN_FW_FTR_SECTION
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING && CONFIG_PPC_SPLPAR */
 
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	.trace_hardirqs_on
-	REST_GPR(0,r1)
-	REST_4GPRS(3,r1)
-	REST_2GPRS(7,r1)
-	addi	r9,r1,STACK_FRAME_OVERHEAD
-	ld	r12,_MSR(r1)
-#endif /* CONFIG_TRACE_IRQFLAGS */
-	li	r10,1
-	stb	r10,PACASOFTIRQEN(r13)
-	stb	r10,PACAHARDIRQEN(r13)
-	std	r10,SOFTE(r1)
+	/*
+	 * A syscall should always be called with interrupts enabled
+	 * so we just unconditionally hard-enable here. When some kind
+	 * of irq tracing is used, we additionally check that condition
+	 * is correct
+	 */
+#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_BUG)
+	lbz	r10,PACASOFTIRQEN(r13)
+	xori	r10,r10,1
+1:	tdnei	r10,0
+	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
+#endif
 
-	/* Hard enable interrupts */
 #ifdef CONFIG_PPC_BOOK3E
 	wrteei	1
 #else
-	mfmsr	r11
+	ld	r11,PACAKMSR(r13)
 	ori	r11,r11,MSR_EE
 	mtmsrd	r11,1
 #endif /* CONFIG_PPC_BOOK3E */
 
+	/* We do need to set SOFTE in the stack frame or the return
+	 * from interrupt will be painful
+	 */
+	li	r10,1
+	std	r10,SOFTE(r1)
+
 #ifdef SHOW_SYSCALLS
 	bl	.do_show_syscall
 	REST_GPR(0,r1)
@@ -187,16 +192,14 @@ syscall_exit:
 	andi.	r10,r8,MSR_RI
 	beq-	unrecov_restore
 #endif
-
-	/* Disable interrupts so current_thread_info()->flags can't change,
+	/*
+	 * Disable interrupts so current_thread_info()->flags can't change,
 	 * and so that we don't get interrupted after loading SRR0/1.
 	 */
 #ifdef CONFIG_PPC_BOOK3E
 	wrteei	0
 #else
-	mfmsr	r10
-	rldicl	r10,r10,48,1
-	rotldi	r10,r10,16
+	ld	r10,PACAKMSR(r13)
 	mtmsrd	r10,1
 #endif /* CONFIG_PPC_BOOK3E */
 
@@ -308,7 +311,7 @@ syscall_exit_work:
 #ifdef CONFIG_PPC_BOOK3E
 	wrteei	1
 #else
-	mfmsr	r10
+	ld	r10,PACAKMSR(r13)
 	ori	r10,r10,MSR_EE
 	mtmsrd	r10,1
 #endif /* CONFIG_PPC_BOOK3E */
-- 
1.7.9
