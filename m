Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPZXG3pzPzDqx4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 14:02:38 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rPZXF3zTqz9sxS
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2016 14:02:37 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u583x0H4090961
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jun 2016 00:02:35 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9m3scas-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 08 Jun 2016 00:02:35 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 8 Jun 2016 14:02:32 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 54D083578056
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2016 14:02:07 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5841wNm4587610
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jun 2016 14:01:59 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5841rKi013951
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jun 2016 14:01:53 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [PATCH 5/5] powerpc: Remove do_load_up_transact_{fpu,altivec}
Date: Wed,  8 Jun 2016 14:00:36 +1000
In-Reply-To: <20160608040036.13064-1-cyrilbur@gmail.com>
References: <20160608040036.13064-1-cyrilbur@gmail.com>
Message-Id: <20160608040036.13064-6-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previous rework of TM code leaves these functions unused

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/include/asm/tm.h |  5 -----
 arch/powerpc/kernel/fpu.S     | 26 --------------------------
 arch/powerpc/kernel/vector.S  | 25 -------------------------
 3 files changed, 56 deletions(-)

diff --git a/arch/powerpc/include/asm/tm.h b/arch/powerpc/include/asm/tm.h
index c22d704..82e06ca 100644
--- a/arch/powerpc/include/asm/tm.h
+++ b/arch/powerpc/include/asm/tm.h
@@ -9,11 +9,6 @@
 
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-extern void do_load_up_transact_fpu(struct thread_struct *thread);
-extern void do_load_up_transact_altivec(struct thread_struct *thread);
-#endif
-
 extern void tm_enable(void);
 extern void tm_reclaim(struct thread_struct *thread,
 		       unsigned long orig_msr, uint8_t cause);
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index 181c187..08d14b0 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -50,32 +50,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
 #define REST_32FPVSRS(n,c,base) __REST_32FPVSRS(n,__REG_##c,__REG_##base)
 #define SAVE_32FPVSRS(n,c,base) __SAVE_32FPVSRS(n,__REG_##c,__REG_##base)
 
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-/* void do_load_up_transact_fpu(struct thread_struct *thread)
- *
- * This is similar to load_up_fpu but for the transactional version of the FP
- * register set.  It doesn't mess with the task MSR or valid flags.
- * Furthermore, we don't do lazy FP with TM currently.
- */
-_GLOBAL(do_load_up_transact_fpu)
-	mfmsr	r6
-	ori	r5,r6,MSR_FP
-#ifdef CONFIG_VSX
-BEGIN_FTR_SECTION
-	oris	r5,r5,MSR_VSX@h
-END_FTR_SECTION_IFSET(CPU_FTR_VSX)
-#endif
-	SYNC
-	MTMSRD(r5)
-
-	addi	r7,r3,THREAD_CKFPSTATE
-	lfd	fr0,FPSTATE_FPSCR(r7)
-	MTFSF_L(fr0)
-	REST_32FPVSRS(0, R4, R7)
-
-	blr
-#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
-
 /*
  * Load state from memory into FP registers including FPSCR.
  * Assumes the caller has enabled FP in the MSR.
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index b5d5025..84b19ab 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -7,31 +7,6 @@
 #include <asm/page.h>
 #include <asm/ptrace.h>
 
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-/* void do_load_up_transact_altivec(struct thread_struct *thread)
- *
- * This is similar to load_up_altivec but for the transactional version of the
- * vector regs.  It doesn't mess with the task MSR or valid flags.
- * Furthermore, VEC laziness is not supported with TM currently.
- */
-_GLOBAL(do_load_up_transact_altivec)
-	mfmsr	r6
-	oris	r5,r6,MSR_VEC@h
-	MTMSRD(r5)
-	isync
-
-	li	r4,1
-	stw	r4,THREAD_USED_VR(r3)
-
-	li	r10,THREAD_CKVRSTATE+VRSTATE_VSCR
-	lvx	v0,r10,r3
-	mtvscr	v0
-	addi	r10,r3,THREAD_CKVRSTATE
-	REST_32VRS(0,r4,r10)
-
-	blr
-#endif
-
 /*
  * Load state from memory into VMX registers including VSCR.
  * Assumes the caller has enabled VMX in the MSR.
-- 
2.8.3
