Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B471C2C036E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jul 2013 11:04:31 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/fsl-booke: Work around erratum A-006958
Date: Fri, 12 Jul 2013 20:03:32 -0500
Message-ID: <1373677412-24329-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Erratum A-006598 says that 64-bit mftb is not atomic -- it's subject
to the same race condition as doing mftbu/mftbl on 32-bit, thus we
need to use the same loop to safely read it.

This deals with kernel and vdso accesses, but other userspace accesses
will of course need to be fixed elsewhere.

This erratum exists on all current Freescale 64-bit cores (e5500 and
e6500).

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/exception-64s.h  |  2 +-
 arch/powerpc/include/asm/ppc_asm.h        | 25 +++++++++++++++++--------
 arch/powerpc/include/asm/reg.h            |  2 +-
 arch/powerpc/include/asm/time.h           |  4 ++--
 arch/powerpc/include/asm/timex.h          |  3 ++-
 arch/powerpc/kernel/entry_64.S            |  8 ++++----
 arch/powerpc/kernel/exceptions-64e.S      |  4 ++--
 arch/powerpc/kernel/time.c                |  2 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S |  2 +-
 arch/powerpc/platforms/Kconfig.cputype    | 11 +++++++++++
 10 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 07ca627..575c72e 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -279,7 +279,7 @@ do_kvm_##n:								\
 	std	r0,GPR0(r1);		/* save r0 in stackframe	*/ \
 	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
 	beq	4f;			/* if from kernel mode		*/ \
-	ACCOUNT_CPU_USER_ENTRY(r9, r10);				   \
+	ACCOUNT_CPU_USER_ENTRY(r9, r10, unused);			   \
 	SAVE_PPR(area, r9, r10);					   \
 4:	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
 	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe	*/ \
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 2f1b6c5..56a82e8 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -25,12 +25,13 @@
  */
 
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-#define ACCOUNT_CPU_USER_ENTRY(ra, rb)
-#define ACCOUNT_CPU_USER_EXIT(ra, rb)
+#define ACCOUNT_CPU_USER_ENTRY(ra, rb, scratch)
+#define ACCOUNT_CPU_USER_EXIT(ra, rb, scratch)
 #define ACCOUNT_STOLEN_TIME
 #else
-#define ACCOUNT_CPU_USER_ENTRY(ra, rb)					\
-	MFTB(ra);			/* get timebase */		\
+/* Note that MFTB can clobber CR0 as well as the scratch registers. */
+#define ACCOUNT_CPU_USER_ENTRY(ra, rb, scratch)				\
+	MFTB(ra, rb, scratch);		/* get timebase */		\
 	ld	rb,PACA_STARTTIME_USER(r13);				\
 	std	ra,PACA_STARTTIME(r13);					\
 	subf	rb,rb,ra;		/* subtract start value */	\
@@ -38,8 +39,8 @@
 	add	ra,ra,rb;		/* add on to user time */	\
 	std	ra,PACA_USER_TIME(r13);					\
 
-#define ACCOUNT_CPU_USER_EXIT(ra, rb)					\
-	MFTB(ra);			/* get timebase */		\
+#define ACCOUNT_CPU_USER_EXIT(ra, rb, scratch)				\
+	MFTB(ra, rb, scratch);		/* get timebase */		\
 	ld	rb,PACA_STARTTIME(r13);					\
 	std	ra,PACA_STARTTIME_USER(r13);				\
 	subf	rb,rb,ra;		/* subtract start value */	\
@@ -444,14 +445,22 @@ END_FTR_SECTION_IFSET(CPU_FTR_601)
 #endif
 
 #ifdef CONFIG_PPC_CELL
-#define MFTB(dest)			\
+#define MFTB(dest, scratch1, scratch2)	\
 90:	mftb  dest;			\
 BEGIN_FTR_SECTION_NESTED(96);		\
 	cmpwi dest,0;			\
 	beq-  90b;			\
 END_FTR_SECTION_NESTED(CPU_FTR_CELL_TB_BUG, CPU_FTR_CELL_TB_BUG, 96)
+#elif defined(CONFIG_FSL_ERRATUM_A_006958)
+#define MFTB(dest, scratch1, scratch2)	\
+90:	mftbu	scratch1;		\
+	mftbl	dest;			\
+	mftbu	scratch2;		\
+	cmpw	scratch1,scratch2;	\
+	bne	90b;			\
+	rldimi	dest,scratch1,32,0;
 #else
-#define MFTB(dest)			mftb dest
+#define MFTB(dest, scratch1, scratch2)	mftb dest
 #endif
 
 #ifndef CONFIG_SMP
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 5d7d9c2..82aae0d 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1115,7 +1115,7 @@
 				     : "r" ((unsigned long)(v)) \
 				     : "memory")
 
-#ifdef __powerpc64__
+#if defined(CONFIG_PPC64) && !defined(CONFIG_FSL_ERRATUM_A_006958)
 #ifdef CONFIG_PPC_CELL
 #define mftb()		({unsigned long rval;				\
 			asm volatile(					\
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index c1f2676..13340d2 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -52,7 +52,7 @@ struct div_result {
 #define __USE_RTC()	0
 #endif
 
-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC64) && !defined(CONFIG_FSL_ERRATUM_A_006958)
 
 /* For compatibility, get_tbl() is defined as get_tb() on ppc64 */
 #define get_tbl		get_tb
@@ -101,7 +101,7 @@ static inline u64 get_rtc(void)
 	return (u64)hi * 1000000000 + lo;
 }
 
-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC64) && !defined(CONFIG_FSL_ERRATUM_A_006958)
 static inline u64 get_tb(void)
 {
 	return mftb();
diff --git a/arch/powerpc/include/asm/timex.h b/arch/powerpc/include/asm/timex.h
index c55e14f..101c03e 100644
--- a/arch/powerpc/include/asm/timex.h
+++ b/arch/powerpc/include/asm/timex.h
@@ -9,6 +9,7 @@
 
 #include <asm/cputable.h>
 #include <asm/reg.h>
+#include <asm/time.h>
 
 #define CLOCK_TICK_RATE	1024000 /* Underlying HZ */
 
@@ -17,7 +18,7 @@ typedef unsigned long cycles_t;
 static inline cycles_t get_cycles(void)
 {
 #ifdef __powerpc64__
-	return mftb();
+	return get_tb();
 #else
 	cycles_t ret;
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index ab15b8d..ccfd894 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -64,7 +64,7 @@ system_call_common:
 	std	r0,GPR0(r1)
 	std	r10,GPR1(r1)
 	beq	2f			/* if from kernel mode */
-	ACCOUNT_CPU_USER_ENTRY(r10, r11)
+	ACCOUNT_CPU_USER_ENTRY(r10, r11, r12)
 2:	std	r2,GPR2(r1)
 	std	r3,GPR3(r1)
 	mfcr	r2
@@ -227,7 +227,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 	ld	r4,_LINK(r1)
 
 	beq-	1f
-	ACCOUNT_CPU_USER_EXIT(r11, r12)
+	ACCOUNT_CPU_USER_EXIT(r11, r12, r2)
 	HMT_MEDIUM_LOW_HAS_PPR
 	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
 1:	ld	r2,GPR2(r1)
@@ -840,7 +840,7 @@ fast_exception_return:
 	 */
 	andi.	r0,r3,MSR_PR
 	beq	1f
-	ACCOUNT_CPU_USER_EXIT(r2, r4)
+	ACCOUNT_CPU_USER_EXIT(r2, r4, unused)
 	RESTORE_PPR(r2, r4)
 	REST_GPR(13, r1)
 1:
@@ -860,7 +860,7 @@ fast_exception_return:
 	rfid
 	b	.	/* prevent speculative execution */
 
-#endif /* CONFIG_PPC_BOOK3E */
+#endif /* !CONFIG_PPC_BOOK3E */
 
 	/*
 	 * We are returning to a context with interrupts soft disabled.
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 645170a..2b5c114 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -160,7 +160,7 @@ exc_##n##_common:							    \
 	std	r10,_NIP(r1);		/* save SRR0 to stackframe */	    \
 	std	r11,_MSR(r1);		/* save SRR1 to stackframe */	    \
 	beq	2f;			/* if from kernel mode */	    \
-	ACCOUNT_CPU_USER_ENTRY(r10,r11);/* accounting (uses cr0+eq) */	    \
+	ACCOUNT_CPU_USER_ENTRY(r10,r11,r3); /* accounting (uses cr0+eq) */  \
 2:	ld	r3,excf+EX_R10(r13);	/* get back r10 */		    \
 	ld	r4,excf+EX_R11(r13);	/* get back r11 */		    \
 	mfspr	r5,SPRN_SPRG_GEN_SCRATCH;/* get back r13 */		    \
@@ -806,7 +806,7 @@ fast_exception_return:
 	andi.	r6,r10,MSR_PR
 	REST_2GPRS(6, r1)
 	beq	1f
-	ACCOUNT_CPU_USER_EXIT(r10, r11)
+	ACCOUNT_CPU_USER_EXIT(r10, r11, r8)
 	ld	r0,GPR13(r1)
 
 1:	stdcx.	r0,0,r1		/* to clear the reservation */
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 65ab9e9..6255c85 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -299,7 +299,7 @@ static u64 vtime_delta(struct task_struct *tsk,
 
 	WARN_ON_ONCE(!irqs_disabled());
 
-	now = mftb();
+	now = get_tb();
 	nowscaled = read_spurr(now);
 	get_paca()->system_time += now - get_paca()->starttime;
 	get_paca()->starttime = now;
diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index a76b4af..c6bf8bf 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -213,7 +213,7 @@ V_FUNCTION_BEGIN(__do_get_tspec)
 	/* Get TB & offset it. We use the MFTB macro which will generate
 	 * workaround code for Cell.
 	 */
-	MFTB(r6)
+	MFTB(r6,r9,r5)
 	ld	r9,CFG_TB_ORIG_STAMP(r3)
 	subf	r6,r9,r6
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index ae0aaea..7f0e2e5 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -165,6 +165,17 @@ config PPC_E500MC
 	  such as e5500/e6500), and must be disabled for running on
 	  e500v1 or e500v2.
 
+config FSL_ERRATUM_A_006958
+	bool
+	depends on PPC_E500MC && PPC64
+	default y
+	help
+	  Workaround for erratum A-006958, which says that 64-bit
+	  timebase reads are not atomic.  The workaround is to fall back
+	  to the 32-bit method of reading timebase.  Note that timebase
+	  is readable by userspace, so any non-vdso userspace accesses
+	  will need to have the workaround applied separately.
+
 config PPC_FPU
 	bool
 	default y if PPC64
-- 
1.8.1.2
