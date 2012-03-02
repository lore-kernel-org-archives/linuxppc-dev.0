Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E13831007DF
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Mar 2012 20:36:17 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Fri, 2 Mar 2012 09:32:29 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q229UbMQ2240740
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Mar 2012 20:30:37 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q229a6hN005303
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Mar 2012 20:36:07 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/12] powerpc: Replace mfmsr instructions with load from PACA
 kernel_msr field
Date: Fri,  2 Mar 2012 20:35:21 +1100
Message-Id: <1330680922-6894-12-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1330680922-6894-1-git-send-email-benh@kernel.crashing.org>
References: <1330680922-6894-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 64-bit, the mfmsr instruction can be quite slow, slower
than loading a field from the cache-hot PACA, which happens
to already contain the value we want in most cases.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/exception-64s.h |    2 +-
 arch/powerpc/include/asm/hw_irq.h        |    4 ++--
 arch/powerpc/kernel/entry_64.S           |   14 +++++---------
 arch/powerpc/kernel/exceptions-64s.S     |    5 ++---
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 7f4718c..70354af 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -298,7 +298,7 @@ label##_hv:								\
 
 /* Exception addition: Keep interrupt state */
 #define ENABLE_INTS				\
-	mfmsr	r11;				\
+	ld	r11,PACAKMSR(r13);		\
 	ld	r12,_MSR(r1);			\
 	rlwimi	r11,r12,0,MSR_EE;		\
 	mtmsrd	r11,1
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 531ba00..6c6fa95 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -68,8 +68,8 @@ static inline bool arch_irqs_disabled(void)
 #define __hard_irq_enable()	asm volatile("wrteei 1" : : : "memory");
 #define __hard_irq_disable()	asm volatile("wrteei 0" : : : "memory");
 #else
-#define __hard_irq_enable()	__mtmsrd(mfmsr() | MSR_EE, 1)
-#define __hard_irq_disable()	__mtmsrd(mfmsr() & ~MSR_EE, 1)
+#define __hard_irq_enable()	__mtmsrd(local_paca->kernel_msr | MSR_EE, 1)
+#define __hard_irq_disable()	__mtmsrd(local_paca->kernel_msr, 1)
 #endif
 
 #define  hard_irq_disable()			\
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index cc030b7..c513beb 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -557,10 +557,8 @@ _GLOBAL(ret_from_except_lite)
 #ifdef CONFIG_PPC_BOOK3E
 	wrteei	0
 #else
-	mfmsr	r10		/* Get current interrupt state */
-	rldicl	r9,r10,48,1	/* clear MSR_EE */
-	rotldi	r9,r9,16
-	mtmsrd	r9,1		/* Update machine state */
+	ld	r10,PACAKMSR(r13) /* Get kernel MSR without EE */
+	mtmsrd	r10,1		  /* Update machine state */
 #endif /* CONFIG_PPC_BOOK3E */
 
 #ifdef CONFIG_PREEMPT
@@ -625,8 +623,8 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 	 * userspace and we take an exception after restoring r13,
 	 * we end up corrupting the userspace r13 value.
 	 */
-	mfmsr	r4
-	andc	r4,r4,r0	/* r0 contains MSR_RI here */
+	ld	r4,PACAKMSR(r13) /* Get kernel MSR without EE */
+	andc	r4,r4,r0	 /* r0 contains MSR_RI here */
 	mtmsrd	r4,1
 
 	/*
@@ -686,9 +684,7 @@ do_work:
 #ifdef CONFIG_PPC_BOOK3E
 	wrteei	0
 #else
-	mfmsr	r10
-	rldicl	r10,r10,48,1
-	rotldi	r10,r10,16
+	ld	r10,PACAKMSR(r13) /* Get kernel MSR without EE */
 	mtmsrd	r10,1
 #endif /* CONFIG_PPC_BOOK3E */
 	li	r0,0
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index bd7130c..880f360 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -850,9 +850,8 @@ fast_exception_return:
 	REST_GPR(0, r1)
 	REST_8GPRS(2, r1)
 
-	mfmsr	r10
-	rldicl	r10,r10,48,1		/* clear EE */
-	rldicr	r10,r10,16,61		/* clear RI (LE is 0 already) */
+	ld	r10,PACAKMSR(r13)
+	clrrdi	r10,r10,2		/* clear RI */
 	mtmsrd	r10,1
 
 	mtspr	SPRN_SRR1,r12
-- 
1.7.9
