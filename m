Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wW3N35tjwzDqLN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 00:00:34 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id u26so14563464pfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 07:00:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Anton Blanchard <anton@samba.org>
Subject: [RFC][PATCH] powerpc/64s: stop using r14 register
Date: Mon, 22 May 2017 00:00:11 +1000
Message-Id: <20170521140011.17548-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'd like to take over the r14 register for use as a per-cpu kernel
register similar to the way r13 is used for the paca.

r14 being the last non-volatile register gcc allocates, appears with
about 0.5% the frequency as r31 in (static) instructions. I haven't
counted dynamically how many extra spills and fills that removing it
causes, but I should. My guess is the memory ops saved by using
it as a per-cpu variable will significantly outweigh the cost of
losing it as a general use register.

This part of the patch is pretty mechanical. A couple of places (prom)
still have to use it, and I haven't quite understood the KVM code yet.

Question is whether this approach seems okay, and whether we should do
the same for 64e.

Thanks,
Nick

---
 arch/powerpc/Makefile                          |   1 +
 arch/powerpc/crypto/md5-asm.S                  |  40 +++----
 arch/powerpc/crypto/sha1-powerpc-asm.S         |  10 +-
 arch/powerpc/include/asm/ppc_asm.h             |  21 +++-
 arch/powerpc/kernel/asm-offsets.c              |   4 +-
 arch/powerpc/kernel/entry_32.S                 |   4 +-
 arch/powerpc/kernel/entry_64.S                 |  46 ++++----
 arch/powerpc/kernel/exceptions-64s.S           |   3 +-
 arch/powerpc/kernel/head_64.S                  |   8 +-
 arch/powerpc/kernel/idle_book3s.S              |  88 +++++++-------
 arch/powerpc/kernel/process.c                  |   4 +-
 arch/powerpc/kernel/tm.S                       |  30 ++---
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |   4 +-
 arch/powerpc/kvm/book3s_hv_interrupts.S        |   5 +-
 arch/powerpc/lib/checksum_64.S                 |  66 +++++------
 arch/powerpc/lib/copypage_power7.S             |  32 +++---
 arch/powerpc/lib/copyuser_power7.S             | 152 ++++++++++++-------------
 arch/powerpc/lib/crtsavres.S                   |   3 +
 arch/powerpc/lib/memcpy_power7.S               |  80 ++++++-------
 arch/powerpc/net/bpf_jit32.h                   |  12 +-
 arch/powerpc/net/bpf_jit_asm.S                 |   4 +-
 21 files changed, 321 insertions(+), 296 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index bc4791aecd03..4c3492851fab 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -137,6 +137,7 @@ endif
 
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,$(call cc-option,-mminimal-toc))
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
+CFLAGS-$(CONFIG_PPC64)	+= -ffixed-r13 -ffixed-r14
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
 
 ifeq ($(CONFIG_PPC_BOOK3S_64),y)
diff --git a/arch/powerpc/crypto/md5-asm.S b/arch/powerpc/crypto/md5-asm.S
index 10cdf5bceebb..99e41af88e19 100644
--- a/arch/powerpc/crypto/md5-asm.S
+++ b/arch/powerpc/crypto/md5-asm.S
@@ -25,31 +25,31 @@
 #define rW02	r10
 #define rW03	r11
 #define rW04	r12
-#define rW05	r14
-#define rW06	r15
-#define rW07	r16
-#define rW08	r17
-#define rW09	r18
-#define rW10	r19
-#define rW11	r20
-#define rW12	r21
-#define rW13	r22
-#define rW14	r23
-#define rW15	r24
-
-#define rT0	r25
-#define rT1	r26
+#define rW05	r15
+#define rW06	r16
+#define rW07	r17
+#define rW08	r18
+#define rW09	r19
+#define rW10	r20
+#define rW11	r21
+#define rW12	r22
+#define rW13	r23
+#define rW14	r24
+#define rW15	r25
+
+#define rT0	r26
+#define rT1	r27
 
 #define INITIALIZE \
 	PPC_STLU r1,-INT_FRAME_SIZE(r1); \
-	SAVE_8GPRS(14, r1);		/* push registers onto stack	*/ \
-	SAVE_4GPRS(22, r1);						   \
-	SAVE_GPR(26, r1)
+	SAVE_8GPRS(15, r1);		/* push registers onto stack	*/ \
+	SAVE_4GPRS(23, r1);						   \
+	SAVE_GPR(27, r1)
 
 #define FINALIZE \
-	REST_8GPRS(14, r1);		/* pop registers from stack	*/ \
-	REST_4GPRS(22, r1);						   \
-	REST_GPR(26, r1);						   \
+	REST_8GPRS(15, r1);		/* pop registers from stack	*/ \
+	REST_4GPRS(23, r1);						   \
+	REST_GPR(27, r1);						   \
 	addi	r1,r1,INT_FRAME_SIZE;
 
 #ifdef __BIG_ENDIAN__
diff --git a/arch/powerpc/crypto/sha1-powerpc-asm.S b/arch/powerpc/crypto/sha1-powerpc-asm.S
index 82ddc9bdfeb1..56bc6ac942c6 100644
--- a/arch/powerpc/crypto/sha1-powerpc-asm.S
+++ b/arch/powerpc/crypto/sha1-powerpc-asm.S
@@ -41,10 +41,10 @@
 	or	r6,r6,r0;			\
 	add	r0,RE(t),r15;			\
 	add	RT(t),RT(t),r6;		\
-	add	r14,r0,W(t);			\
+	add	r6,r0,W(t);			\
 	LWZ(W((t)+4),((t)+4)*4,r4);	\
 	rotlwi	RB(t),RB(t),30;			\
-	add	RT(t),RT(t),r14
+	add	RT(t),RT(t),r6
 
 #define STEPD0_UPDATE(t)			\
 	and	r6,RB(t),RC(t);		\
@@ -123,8 +123,7 @@
 
 _GLOBAL(powerpc_sha_transform)
 	PPC_STLU r1,-INT_FRAME_SIZE(r1)
-	SAVE_8GPRS(14, r1)
-	SAVE_10GPRS(22, r1)
+	SAVE_NVGPRS(r1)
 
 	/* Load up A - E */
 	lwz	RA(0),0(r3)	/* A */
@@ -182,7 +181,6 @@ _GLOBAL(powerpc_sha_transform)
 	stw	RD(0),12(r3)
 	stw	RE(0),16(r3)
 
-	REST_8GPRS(14, r1)
-	REST_10GPRS(22, r1)
+	REST_NVGPRS(r1)
 	addi	r1,r1,INT_FRAME_SIZE
 	blr
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 359c44341761..ed696de5888b 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -10,6 +10,16 @@
 #include <asm/ppc-opcode.h>
 #include <asm/firmware.h>
 
+#ifdef __powerpc64__
+#ifdef CONFIG_PPC_BOOK3S
+#define FIRST_NVGPR		15
+#else
+#define FIRST_NVGPR		14
+#endif
+#else
+#define FIRST_NVGPR		13
+#endif
+
 #ifdef __ASSEMBLY__
 
 #define SZL			(BITS_PER_LONG/8)
@@ -75,16 +85,21 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #ifdef __powerpc64__
 #define SAVE_GPR(n, base)	std	n,GPR0+8*(n)(base)
 #define REST_GPR(n, base)	ld	n,GPR0+8*(n)(base)
+#ifdef CONFIG_PPC_BOOK3S
+#define SAVE_NVGPRS(base)	SAVE_GPR(15, base); SAVE_2GPRS(16, base); SAVE_4GPRS(18, base); SAVE_10GPRS(22, base)
+#define REST_NVGPRS(base)	REST_GPR(15, base); REST_2GPRS(16, base); REST_4GPRS(18, base); REST_10GPRS(22, base)
+#else /* CONFIG_PPC_BOOK3S */
 #define SAVE_NVGPRS(base)	SAVE_8GPRS(14, base); SAVE_10GPRS(22, base)
 #define REST_NVGPRS(base)	REST_8GPRS(14, base); REST_10GPRS(22, base)
-#else
+#endif /* CONFIG_PPC_BOOK3S */
+#else /* __powerpc64__ */
 #define SAVE_GPR(n, base)	stw	n,GPR0+4*(n)(base)
 #define REST_GPR(n, base)	lwz	n,GPR0+4*(n)(base)
 #define SAVE_NVGPRS(base)	SAVE_GPR(13, base); SAVE_8GPRS(14, base); \
 				SAVE_10GPRS(22, base)
 #define REST_NVGPRS(base)	REST_GPR(13, base); REST_8GPRS(14, base); \
 				REST_10GPRS(22, base)
-#endif
+#endif /* __powerpc64__ */
 
 #define SAVE_2GPRS(n, base)	SAVE_GPR(n, base); SAVE_GPR(n+1, base)
 #define SAVE_4GPRS(n, base)	SAVE_2GPRS(n, base); SAVE_2GPRS(n+2, base)
@@ -184,7 +199,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #ifdef CONFIG_PPC64
 
 #define STACKFRAMESIZE 256
-#define __STK_REG(i)   (112 + ((i)-14)*8)
+#define __STK_REG(i)   (112 + ((i)-15)*8)
 #define STK_REG(i)     __STK_REG(__REG_##i)
 
 #ifdef PPC64_ELF_ABI_v2
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 709e23425317..49e849990f9f 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -283,9 +283,9 @@ int main(void)
 	STACK_PT_REGS_OFFSET(GPR11, gpr[11]);
 	STACK_PT_REGS_OFFSET(GPR12, gpr[12]);
 	STACK_PT_REGS_OFFSET(GPR13, gpr[13]);
-#ifndef CONFIG_PPC64
+#ifndef CONFIG_PPC_BOOK3E_64
 	STACK_PT_REGS_OFFSET(GPR14, gpr[14]);
-#endif /* CONFIG_PPC64 */
+#endif
 	/*
 	 * Note: these symbols include _ because they overlap with special
 	 * register names
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 8587059ad848..9ffea7c7764f 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -451,8 +451,8 @@ ret_from_fork:
 ret_from_kernel_thread:
 	REST_NVGPRS(r1)
 	bl	schedule_tail
-	mtlr	r14
-	mr	r3,r15
+	mtlr	FIRST_NVGPR
+	mr	r3,FIRST_NVGPR+1
 	PPC440EP_ERR42
 	blrl
 	li	r3,0
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index b8b6069309da..8db0f378e8b0 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -38,6 +38,7 @@
 #include <asm/tm.h>
 #include <asm/ppc-opcode.h>
 #include <asm/export.h>
+#include <asm/exception-64s.h>
 
 /*
  * System calls.
@@ -405,7 +406,7 @@ _GLOBAL(save_nvgprs)
  * The sigsuspend and rt_sigsuspend system calls can call do_signal
  * and thus put the process into the stopped state where we might
  * want to examine its user state with ptrace.  Therefore we need
- * to save all the nonvolatile registers (r14 - r31) before calling
+ * to save all the nonvolatile registers (r15 - r31) before calling
  * the C code.  Similarly, fork, vfork and clone need the full
  * register state on the stack so that it can be copied to the child.
  */
@@ -449,10 +450,10 @@ _GLOBAL(ret_from_fork)
 _GLOBAL(ret_from_kernel_thread)
 	bl	schedule_tail
 	REST_NVGPRS(r1)
-	mtlr	r14
-	mr	r3,r15
+	mtlr	FIRST_NVGPR
+	mr	r3,FIRST_NVGPR+1
 #ifdef PPC64_ELF_ABI_v2
-	mr	r12,r14
+	mr	r12,FIRST_NVGPR
 #endif
 	blrl
 	li	r3,0
@@ -481,9 +482,7 @@ _GLOBAL(_switch)
 	mflr	r0
 	std	r0,16(r1)
 	stdu	r1,-SWITCH_FRAME_SIZE(r1)
-	/* r3-r13 are caller saved -- Cort */
-	SAVE_8GPRS(14, r1)
-	SAVE_10GPRS(22, r1)
+	SAVE_NVGPRS(r1)
 	std	r0,_NIP(r1)	/* Return to switch caller */
 	mfcr	r23
 	std	r23,_CCR(r1)
@@ -590,9 +589,8 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	ld	r6,_CCR(r1)
 	mtcrf	0xFF,r6
 
-	/* r3-r13 are destroyed -- Cort */
-	REST_8GPRS(14, r1)
-	REST_10GPRS(22, r1)
+	/* Volatile regs are destroyed */
+	REST_NVGPRS(r1)
 
 	/* convert old thread to its task_struct for return value */
 	addi	r3,r3,-THREAD
@@ -980,12 +978,14 @@ _GLOBAL(enter_rtas)
 
 	/* Because RTAS is running in 32b mode, it clobbers the high order half
 	 * of all registers that it saves.  We therefore save those registers
-	 * RTAS might touch to the stack.  (r0, r3-r13 are caller saved)
+	 * RTAS might touch to the stack.  (r0, r3-r12 are caller saved)
    	 */
 	SAVE_GPR(2, r1)			/* Save the TOC */
 	SAVE_GPR(13, r1)		/* Save paca */
-	SAVE_8GPRS(14, r1)		/* Save the non-volatiles */
-	SAVE_10GPRS(22, r1)		/* ditto */
+#ifdef CONFIG_PPC_BOOK3S
+	SAVE_GPR(14, r1)		/* Save r14 */
+#endif
+	SAVE_NVGPRS(r1)			/* Save the non-volatiles */
 
 	mfcr	r4
 	std	r4,_CCR(r1)
@@ -1083,8 +1083,10 @@ rtas_restore_regs:
 	/* relocation is on at this point */
 	REST_GPR(2, r1)			/* Restore the TOC */
 	REST_GPR(13, r1)		/* Restore paca */
-	REST_8GPRS(14, r1)		/* Restore the non-volatiles */
-	REST_10GPRS(22, r1)		/* ditto */
+#ifdef CONFIG_PPC_BOOK3S
+	REST_GPR(14, r1)		/* Restore r14 */
+#endif
+	REST_NVGPRS(r1)			/* Restore the non-volatiles */
 
 	GET_PACA(r13)
 
@@ -1114,12 +1116,14 @@ _GLOBAL(enter_prom)
 
 	/* Because PROM is running in 32b mode, it clobbers the high order half
 	 * of all registers that it saves.  We therefore save those registers
-	 * PROM might touch to the stack.  (r0, r3-r13 are caller saved)
+	 * PROM might touch to the stack.  (r0, r3-r14 are caller saved)
    	 */
 	SAVE_GPR(2, r1)
 	SAVE_GPR(13, r1)
-	SAVE_8GPRS(14, r1)
-	SAVE_10GPRS(22, r1)
+#ifdef CONFIG_PPC_BOOK3S
+	SAVE_GPR(14, r1)
+#endif
+	SAVE_NVGPRS(r1)
 	mfcr	r10
 	mfmsr	r11
 	std	r10,_CCR(r1)
@@ -1163,8 +1167,10 @@ _GLOBAL(enter_prom)
 	/* Restore other registers */
 	REST_GPR(2, r1)
 	REST_GPR(13, r1)
-	REST_8GPRS(14, r1)
-	REST_10GPRS(22, r1)
+#ifdef CONFIG_PPC_BOOK3S
+	REST_GPR(14, r1)
+#endif
+	REST_NVGPRS(r1)
 	ld	r4,_CCR(r1)
 	mtcr	r4
 	
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index cf6dd08493cb..5c1d10c09c4e 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1536,8 +1536,7 @@ BEGIN_FTR_SECTION
 	ld	r10,EX_CFAR(r3)
 	std	r10,ORIG_GPR3(r1)
 END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
-	SAVE_8GPRS(14,r1)
-	SAVE_10GPRS(22,r1)
+	SAVE_NVGPRS(r1)
 	lhz	r12,PACA_TRAP_SAVE(r13)
 	std	r12,_TRAP(r1)
 	addi	r11,r1,INT_FRAME_SIZE
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index e43116237944..ffe46b5558e4 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -796,9 +796,9 @@ __secondary_start:
 	/* Initialize the kernel stack */
 	LOAD_REG_ADDR(r3, current_set)
 	sldi	r28,r24,3		/* get current_set[cpu#]	 */
-	ldx	r14,r3,r28
-	addi	r14,r14,THREAD_SIZE-STACK_FRAME_OVERHEAD
-	std	r14,PACAKSAVE(r13)
+	ldx	r15,r3,r28
+	addi	r15,r15,THREAD_SIZE-STACK_FRAME_OVERHEAD
+	std	r15,PACAKSAVE(r13)
 
 	/* Do early setup for that CPU (SLB and hash table pointer) */
 	bl	early_setup_secondary
@@ -807,7 +807,7 @@ __secondary_start:
 	 * setup the new stack pointer, but *don't* use this until
 	 * translation is on.
 	 */
-	mr	r1, r14
+	mr	r1, r15
 
 	/* Clear backchain so we get nice backtraces */
 	li	r7,0
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 07d4e0ad60db..8c84ab501236 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -87,19 +87,19 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 /*
  * Used by threads when the lock bit of core_idle_state is set.
  * Threads will spin in HMT_LOW until the lock bit is cleared.
- * r14 - pointer to core_idle_state
- * r15 - used to load contents of core_idle_state
+ * r15 - pointer to core_idle_state
+ * r16 - used to load contents of core_idle_state
  * r9  - used as a temporary variable
  */
 
 core_idle_lock_held:
 	HMT_LOW
-3:	lwz	r15,0(r14)
-	andis.	r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
+3:	lwz	r16,0(r15)
+	andis.	r16,r16,PNV_CORE_IDLE_LOCK_BIT@h
 	bne	3b
 	HMT_MEDIUM
-	lwarx	r15,0,r14
-	andis.	r9,r15,PNV_CORE_IDLE_LOCK_BIT@h
+	lwarx	r16,0,r15
+	andis.	r9,r16,PNV_CORE_IDLE_LOCK_BIT@h
 	bne-	core_idle_lock_held
 	blr
 
@@ -209,21 +209,21 @@ pnv_enter_arch207_idle_mode:
 2:
 	/* Sleep or winkle */
 	lbz	r7,PACA_THREAD_MASK(r13)
-	ld	r14,PACA_CORE_IDLE_STATE_PTR(r13)
+	ld	r15,PACA_CORE_IDLE_STATE_PTR(r13)
 	li	r5,0
 	beq	cr3,3f
 	lis	r5,PNV_CORE_IDLE_WINKLE_COUNT@h
 3:
 lwarx_loop1:
-	lwarx	r15,0,r14
+	lwarx	r16,0,r15
 
-	andis.	r9,r15,PNV_CORE_IDLE_LOCK_BIT@h
+	andis.	r9,r16,PNV_CORE_IDLE_LOCK_BIT@h
 	bnel-	core_idle_lock_held
 
-	add	r15,r15,r5			/* Add if winkle */
-	andc	r15,r15,r7			/* Clear thread bit */
+	add	r16,r16,r5			/* Add if winkle */
+	andc	r16,r16,r7			/* Clear thread bit */
 
-	andi.	r9,r15,PNV_CORE_IDLE_THREAD_BITS
+	andi.	r9,r16,PNV_CORE_IDLE_THREAD_BITS
 
 /*
  * If cr0 = 0, then current thread is the last thread of the core entering
@@ -237,7 +237,7 @@ lwarx_loop1:
 pnv_fastsleep_workaround_at_entry:
 	beq	fastsleep_workaround_at_entry
 
-	stwcx.	r15,0,r14
+	stwcx.	r16,0,r15
 	bne-	lwarx_loop1
 	isync
 
@@ -246,8 +246,8 @@ common_enter: /* common code for all the threads entering sleep or winkle */
 	IDLE_STATE_ENTER_SEQ_NORET(PPC_SLEEP)
 
 fastsleep_workaround_at_entry:
-	oris	r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
-	stwcx.	r15,0,r14
+	oris	r16,r16,PNV_CORE_IDLE_LOCK_BIT@h
+	stwcx.	r16,0,r15
 	bne-	lwarx_loop1
 	isync
 
@@ -257,9 +257,9 @@ fastsleep_workaround_at_entry:
 	bl	opal_config_cpu_idle_state
 
 	/* Unlock */
-	xoris	r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
+	xoris	r16,r16,PNV_CORE_IDLE_LOCK_BIT@h
 	lwsync
-	stw	r15,0(r14)
+	stw	r16,0(r15)
 	b	common_enter
 
 enter_winkle:
@@ -303,15 +303,15 @@ power_enter_stop:
  * stack and enter stop
  */
 	lbz     r7,PACA_THREAD_MASK(r13)
-	ld      r14,PACA_CORE_IDLE_STATE_PTR(r13)
+	ld      r15,PACA_CORE_IDLE_STATE_PTR(r13)
 
 lwarx_loop_stop:
-	lwarx   r15,0,r14
-	andis.	r9,r15,PNV_CORE_IDLE_LOCK_BIT@h
+	lwarx   r16,0,r15
+	andis.	r9,r16,PNV_CORE_IDLE_LOCK_BIT@h
 	bnel-	core_idle_lock_held
-	andc    r15,r15,r7                      /* Clear thread bit */
+	andc    r16,r16,r7                      /* Clear thread bit */
 
-	stwcx.  r15,0,r14
+	stwcx.  r16,0,r15
 	bne-    lwarx_loop_stop
 	isync
 
@@ -567,14 +567,14 @@ pnv_wakeup_tb_loss:
 	 * is required to return back to reset vector after hypervisor state
 	 * restore is complete.
 	 */
-	mr	r18,r4
-	mflr	r17
-	mfspr	r16,SPRN_SRR1
+	mr	r19,r4
+	mflr	r18
+	mfspr	r17,SPRN_SRR1
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 
-	ld	r14,PACA_CORE_IDLE_STATE_PTR(r13)
+	ld	r15,PACA_CORE_IDLE_STATE_PTR(r13)
 	lbz	r7,PACA_THREAD_MASK(r13)
 
 	/*
@@ -588,15 +588,15 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	 * In either case loop until the lock bit is cleared.
 	 */
 1:
-	lwarx	r15,0,r14
-	andis.	r9,r15,PNV_CORE_IDLE_LOCK_BIT@h
+	lwarx	r16,0,r15
+	andis.	r9,r16,PNV_CORE_IDLE_LOCK_BIT@h
 	bnel-	core_idle_lock_held
-	oris	r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
-	stwcx.	r15,0,r14
+	oris	r16,r16,PNV_CORE_IDLE_LOCK_BIT@h
+	stwcx.	r16,0,r15
 	bne-	1b
 	isync
 
-	andi.	r9,r15,PNV_CORE_IDLE_THREAD_BITS
+	andi.	r9,r16,PNV_CORE_IDLE_THREAD_BITS
 	cmpwi	cr2,r9,0
 
 	/*
@@ -660,29 +660,29 @@ BEGIN_FTR_SECTION
 	 * }
 	 *
 	 */
-	cmpwi	r18,PNV_THREAD_WINKLE
+	cmpwi	r19,PNV_THREAD_WINKLE
 	bne	2f
-	andis.	r9,r15,PNV_CORE_IDLE_WINKLE_COUNT_ALL_BIT@h
-	subis	r15,r15,PNV_CORE_IDLE_WINKLE_COUNT@h
+	andis.	r9,r16,PNV_CORE_IDLE_WINKLE_COUNT_ALL_BIT@h
+	subis	r16,r16,PNV_CORE_IDLE_WINKLE_COUNT@h
 	beq	2f
-	ori	r15,r15,PNV_CORE_IDLE_THREAD_WINKLE_BITS /* all were winkle */
+	ori	r16,r16,PNV_CORE_IDLE_THREAD_WINKLE_BITS /* all were winkle */
 2:
 	/* Shift thread bit to winkle mask, then test if this thread is set,
 	 * and remove it from the winkle bits */
 	slwi	r8,r7,8
-	and	r8,r8,r15
-	andc	r15,r15,r8
+	and	r8,r8,r16
+	andc	r16,r16,r8
 	cmpwi	cr4,r8,1 /* cr4 will be gt if our bit is set, lt if not */
 
 	lbz	r4,PACA_SUBCORE_SIBLING_MASK(r13)
-	and	r4,r4,r15
+	and	r4,r4,r16
 	cmpwi	r4,0	/* Check if first in subcore */
 
-	or	r15,r15,r7		/* Set thread bit */
+	or	r16,r16,r7		/* Set thread bit */
 	beq	first_thread_in_subcore
 END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 
-	or	r15,r15,r7		/* Set thread bit */
+	or	r16,r16,r7		/* Set thread bit */
 	beq	cr2,first_thread_in_core
 
 	/* Not first thread in core or subcore to wake up */
@@ -758,9 +758,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	mtspr	SPRN_WORC,r4
 
 clear_lock:
-	xoris	r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
+	xoris	r16,r16,PNV_CORE_IDLE_LOCK_BIT@h
 	lwsync
-	stw	r15,0(r14)
+	stw	r16,0(r15)
 
 common_exit:
 	/*
@@ -814,8 +814,8 @@ no_segments:
 
 hypervisor_state_restored:
 
-	mtspr	SPRN_SRR1,r16
-	mtlr	r17
+	mtspr	SPRN_SRR1,r17
+	mtlr	r18
 	blr		/* return to pnv_powersave_wakeup */
 
 fastsleep_workaround_at_exit:
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index d645da302bf2..868835bb64c3 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1478,12 +1478,12 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 		childregs->gpr[1] = sp + sizeof(struct pt_regs);
 		/* function */
 		if (usp)
-			childregs->gpr[14] = ppc_function_entry((void *)usp);
+			childregs->gpr[FIRST_NVGPR] = ppc_function_entry((void *)usp);
 #ifdef CONFIG_PPC64
 		clear_tsk_thread_flag(p, TIF_32BIT);
 		childregs->softe = 1;
 #endif
-		childregs->gpr[15] = kthread_arg;
+		childregs->gpr[FIRST_NVGPR + 1] = kthread_arg;
 		p->thread.regs = NULL;	/* no user register state */
 		ti->flags |= _TIF_RESTOREALL;
 		f = ret_from_kernel_thread;
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 3a2d04134da9..cc953bddeec4 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -112,24 +112,24 @@ _GLOBAL(tm_reclaim)
 	SAVE_NVGPRS(r1)
 
 	/* We need to setup MSR for VSX register save instructions. */
-	mfmsr	r14
-	mr	r15, r14
-	ori	r15, r15, MSR_FP
-	li	r16, 0
-	ori	r16, r16, MSR_EE /* IRQs hard off */
-	andc	r15, r15, r16
-	oris	r15, r15, MSR_VEC@h
+	mfmsr	r15
+	mr	r16, r15
+	ori	r16, r16, MSR_FP
+	li	r17, 0
+	ori	r17, r17, MSR_EE /* IRQs hard off */
+	andc	r16, r16, r17
+	oris	r16, r16, MSR_VEC@h
 #ifdef CONFIG_VSX
 	BEGIN_FTR_SECTION
-	oris	r15,r15, MSR_VSX@h
+	oris	r16,r16, MSR_VSX@h
 	END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 #endif
-	mtmsrd	r15
-	std	r14, TM_FRAME_L0(r1)
+	mtmsrd	r16
+	std	r15, TM_FRAME_L0(r1)
 
 	/* Do sanity check on MSR to make sure we are suspended */
 	li	r7, (MSR_TS_S)@higher
-	srdi	r6, r14, 32
+	srdi	r6, r15, 32
 	and	r6, r6, r7
 1:	tdeqi   r6, 0
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0
@@ -291,11 +291,11 @@ dont_backup_fp:
 	/* AMR is checkpointed too, but is unsupported by Linux. */
 
 	/* Restore original MSR/IRQ state & clear TM mode */
-	ld	r14, TM_FRAME_L0(r1)		/* Orig MSR */
+	ld	r15, TM_FRAME_L0(r1)		/* Orig MSR */
 
-	li	r15, 0
-	rldimi  r14, r15, MSR_TS_LG, (63-MSR_TS_LG)-1
-	mtmsrd  r14
+	li	r16, 0
+	rldimi  r15, r16, MSR_TS_LG, (63-MSR_TS_LG)-1
+	mtmsrd  r15
 
 	REST_NVGPRS(r1)
 
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 7c933a99f5d5..e1f7f4c6767a 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -72,7 +72,7 @@ _GLOBAL(ftrace_caller)
 	ld	r5,0(r3)
 
 #ifdef CONFIG_LIVEPATCH
-	mr	r14,r7		/* remember old NIP */
+	mr	r15,r7		/* remember old NIP */
 #endif
 	/* Calculate ip from nip-4 into r3 for call below */
 	subi    r3, r7, MCOUNT_INSN_SIZE
@@ -99,7 +99,7 @@ ftrace_call:
 	ld	r3, _NIP(r1)
 	mtctr	r3
 #ifdef CONFIG_LIVEPATCH
-	cmpd	r14,r3		/* has NIP been altered? */
+	cmpd	r15,r3		/* has NIP been altered? */
 #endif
 
 	/* Restore gprs */
diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/book3s_hv_interrupts.S
index 0fdc4a28970b..5d5a27c5c1ae 100644
--- a/arch/powerpc/kvm/book3s_hv_interrupts.S
+++ b/arch/powerpc/kvm/book3s_hv_interrupts.S
@@ -46,7 +46,7 @@ _GLOBAL(__kvmppc_vcore_entry)
 	/* Save host state to the stack */
 	stdu	r1, -SWITCH_FRAME_SIZE(r1)
 
-	/* Save non-volatile registers (r14 - r31) and CR */
+	/* Save non-volatile registers (r15 - r31) and CR */
 	SAVE_NVGPRS(r1)
 	mfcr	r3
 	std	r3, _CCR(r1)
@@ -145,9 +145,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	 * R2       = host R2
 	 * R12      = exit handler id
 	 * R13      = PACA
+	 * R14      = ? XXX
 	 */
 
-	/* Restore non-volatile host registers (r14 - r31) and CR */
+	/* Restore non-volatile host registers (r15 - r31) and CR */
 	REST_NVGPRS(r1)
 	ld	r4, _CCR(r1)
 	mtcr	r4
diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
index 47e06147c92c..4e1c4e560a3b 100644
--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -65,9 +65,9 @@ _GLOBAL(__csum_partial)
 	mtctr	r6
 
 	stdu	r1,-STACKFRAMESIZE(r1)
-	std	r14,STK_REG(R14)(r1)
 	std	r15,STK_REG(R15)(r1)
 	std	r16,STK_REG(R16)(r1)
+	std	r17,STK_REG(R17)(r1)
 
 	ld	r6,0(r3)
 	ld	r9,8(r3)
@@ -85,11 +85,11 @@ _GLOBAL(__csum_partial)
 2:
 	adde	r0,r0,r6
 	ld	r12,32(r3)
-	ld	r14,40(r3)
+	ld	r15,40(r3)
 
 	adde	r0,r0,r9
-	ld	r15,48(r3)
-	ld	r16,56(r3)
+	ld	r16,48(r3)
+	ld	r17,56(r3)
 	addi	r3,r3,64
 
 	adde	r0,r0,r10
@@ -98,13 +98,13 @@ _GLOBAL(__csum_partial)
 
 	adde	r0,r0,r12
 
-	adde	r0,r0,r14
-
 	adde	r0,r0,r15
+
+	adde	r0,r0,r16
 	ld	r6,0(r3)
 	ld	r9,8(r3)
 
-	adde	r0,r0,r16
+	adde	r0,r0,r17
 	ld	r10,16(r3)
 	ld	r11,24(r3)
 	bdnz	2b
@@ -112,23 +112,23 @@ _GLOBAL(__csum_partial)
 
 	adde	r0,r0,r6
 	ld	r12,32(r3)
-	ld	r14,40(r3)
+	ld	r15,40(r3)
 
 	adde	r0,r0,r9
-	ld	r15,48(r3)
-	ld	r16,56(r3)
+	ld	r16,48(r3)
+	ld	r17,56(r3)
 	addi	r3,r3,64
 
 	adde	r0,r0,r10
 	adde	r0,r0,r11
 	adde	r0,r0,r12
-	adde	r0,r0,r14
 	adde	r0,r0,r15
 	adde	r0,r0,r16
+	adde	r0,r0,r17
 
-	ld	r14,STK_REG(R14)(r1)
 	ld	r15,STK_REG(R15)(r1)
 	ld	r16,STK_REG(R16)(r1)
+	ld	r17,STK_REG(R17)(r1)
 	addi	r1,r1,STACKFRAMESIZE
 
 	andi.	r4,r4,63
@@ -259,9 +259,9 @@ dstnr;	sth	r6,0(r4)
 	mtctr	r6
 
 	stdu	r1,-STACKFRAMESIZE(r1)
-	std	r14,STK_REG(R14)(r1)
 	std	r15,STK_REG(R15)(r1)
 	std	r16,STK_REG(R16)(r1)
+	std	r17,STK_REG(R17)(r1)
 
 source;	ld	r6,0(r3)
 source;	ld	r9,8(r3)
@@ -279,11 +279,11 @@ source;	ld	r11,24(r3)
 2:
 	adde	r0,r0,r6
 source;	ld	r12,32(r3)
-source;	ld	r14,40(r3)
+source;	ld	r15,40(r3)
 
 	adde	r0,r0,r9
-source;	ld	r15,48(r3)
-source;	ld	r16,56(r3)
+source;	ld	r16,48(r3)
+source;	ld	r17,56(r3)
 	addi	r3,r3,64
 
 	adde	r0,r0,r10
@@ -296,18 +296,18 @@ dest;	std	r11,24(r4)
 
 	adde	r0,r0,r12
 dest;	std	r12,32(r4)
-dest;	std	r14,40(r4)
+dest;	std	r15,40(r4)
 
-	adde	r0,r0,r14
-dest;	std	r15,48(r4)
-dest;	std	r16,56(r4)
+	adde	r0,r0,r15
+dest;	std	r16,48(r4)
+dest;	std	r17,56(r4)
 	addi	r4,r4,64
 
-	adde	r0,r0,r15
+	adde	r0,r0,r16
 source;	ld	r6,0(r3)
 source;	ld	r9,8(r3)
 
-	adde	r0,r0,r16
+	adde	r0,r0,r17
 source;	ld	r10,16(r3)
 source;	ld	r11,24(r3)
 	bdnz	2b
@@ -315,11 +315,11 @@ source;	ld	r11,24(r3)
 
 	adde	r0,r0,r6
 source;	ld	r12,32(r3)
-source;	ld	r14,40(r3)
+source;	ld	r15,40(r3)
 
 	adde	r0,r0,r9
-source;	ld	r15,48(r3)
-source;	ld	r16,56(r3)
+source;	ld	r16,48(r3)
+source;	ld	r17,56(r3)
 	addi	r3,r3,64
 
 	adde	r0,r0,r10
@@ -332,19 +332,19 @@ dest;	std	r11,24(r4)
 
 	adde	r0,r0,r12
 dest;	std	r12,32(r4)
-dest;	std	r14,40(r4)
+dest;	std	r15,40(r4)
 
-	adde	r0,r0,r14
-dest;	std	r15,48(r4)
-dest;	std	r16,56(r4)
+	adde	r0,r0,r15
+dest;	std	r16,48(r4)
+dest;	std	r17,56(r4)
 	addi	r4,r4,64
 
-	adde	r0,r0,r15
 	adde	r0,r0,r16
+	adde	r0,r0,r17
 
-	ld	r14,STK_REG(R14)(r1)
 	ld	r15,STK_REG(R15)(r1)
 	ld	r16,STK_REG(R16)(r1)
+	ld	r17,STK_REG(R17)(r1)
 	addi	r1,r1,STACKFRAMESIZE
 
 	andi.	r5,r5,63
@@ -407,9 +407,9 @@ dstnr;	stb	r6,0(r4)
 	blr
 
 .Lsrc_error:
-	ld	r14,STK_REG(R14)(r1)
 	ld	r15,STK_REG(R15)(r1)
 	ld	r16,STK_REG(R16)(r1)
+	ld	r17,STK_REG(R17)(r1)
 	addi	r1,r1,STACKFRAMESIZE
 .Lsrc_error_nr:
 	cmpdi	0,r7,0
@@ -419,9 +419,9 @@ dstnr;	stb	r6,0(r4)
 	blr
 
 .Ldest_error:
-	ld	r14,STK_REG(R14)(r1)
 	ld	r15,STK_REG(R15)(r1)
 	ld	r16,STK_REG(R16)(r1)
+	ld	r17,STK_REG(R17)(r1)
 	addi	r1,r1,STACKFRAMESIZE
 .Ldest_error_nr:
 	cmpdi	0,r8,0
diff --git a/arch/powerpc/lib/copypage_power7.S b/arch/powerpc/lib/copypage_power7.S
index c517c27fe43c..8e65d4ea0ee4 100644
--- a/arch/powerpc/lib/copypage_power7.S
+++ b/arch/powerpc/lib/copypage_power7.S
@@ -114,13 +114,13 @@ _GLOBAL(copypage_power7)
 #endif
 
 .Lnonvmx_copy:
-	std	r14,STK_REG(R14)(r1)
 	std	r15,STK_REG(R15)(r1)
 	std	r16,STK_REG(R16)(r1)
 	std	r17,STK_REG(R17)(r1)
 	std	r18,STK_REG(R18)(r1)
 	std	r19,STK_REG(R19)(r1)
 	std	r20,STK_REG(R20)(r1)
+	std	r21,STK_REG(R21)(r1)
 
 1:	ld	r0,0(r4)
 	ld	r5,8(r4)
@@ -131,13 +131,13 @@ _GLOBAL(copypage_power7)
 	ld	r10,48(r4)
 	ld	r11,56(r4)
 	ld	r12,64(r4)
-	ld	r14,72(r4)
-	ld	r15,80(r4)
-	ld	r16,88(r4)
-	ld	r17,96(r4)
-	ld	r18,104(r4)
-	ld	r19,112(r4)
-	ld	r20,120(r4)
+	ld	r15,72(r4)
+	ld	r16,80(r4)
+	ld	r17,88(r4)
+	ld	r18,96(r4)
+	ld	r19,104(r4)
+	ld	r20,112(r4)
+	ld	r21,120(r4)
 	addi	r4,r4,128
 	std	r0,0(r3)
 	std	r5,8(r3)
@@ -148,22 +148,22 @@ _GLOBAL(copypage_power7)
 	std	r10,48(r3)
 	std	r11,56(r3)
 	std	r12,64(r3)
-	std	r14,72(r3)
-	std	r15,80(r3)
-	std	r16,88(r3)
-	std	r17,96(r3)
-	std	r18,104(r3)
-	std	r19,112(r3)
-	std	r20,120(r3)
+	std	r15,72(r3)
+	std	r16,80(r3)
+	std	r17,88(r3)
+	std	r18,96(r3)
+	std	r19,104(r3)
+	std	r20,112(r3)
+	std	r21,120(r3)
 	addi	r3,r3,128
 	bdnz	1b
 
-	ld	r14,STK_REG(R14)(r1)
 	ld	r15,STK_REG(R15)(r1)
 	ld	r16,STK_REG(R16)(r1)
 	ld	r17,STK_REG(R17)(r1)
 	ld	r18,STK_REG(R18)(r1)
 	ld	r19,STK_REG(R19)(r1)
 	ld	r20,STK_REG(R20)(r1)
+	ld	r21,STK_REG(R21)(r1)
 	addi	r1,r1,STACKFRAMESIZE
 	blr
diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser_power7.S
index 5d6ccd75b433..8f17ad74da16 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -51,9 +51,9 @@
 
 
 .Ldo_err4:
-	ld	r16,STK_REG(R16)(r1)
-	ld	r15,STK_REG(R15)(r1)
-	ld	r14,STK_REG(R14)(r1)
+	ld	r17,STK_REG(R16)(r1)
+	ld	r16,STK_REG(R15)(r1)
+	ld	r15,STK_REG(R14)(r1)
 .Ldo_err3:
 	bl	exit_vmx_usercopy
 	ld	r0,STACKFRAMESIZE+16(r1)
@@ -62,15 +62,15 @@
 #endif /* CONFIG_ALTIVEC */
 
 .Ldo_err2:
-	ld	r22,STK_REG(R22)(r1)
-	ld	r21,STK_REG(R21)(r1)
-	ld	r20,STK_REG(R20)(r1)
-	ld	r19,STK_REG(R19)(r1)
-	ld	r18,STK_REG(R18)(r1)
-	ld	r17,STK_REG(R17)(r1)
-	ld	r16,STK_REG(R16)(r1)
-	ld	r15,STK_REG(R15)(r1)
-	ld	r14,STK_REG(R14)(r1)
+	ld	r23,STK_REG(R22)(r1)
+	ld	r22,STK_REG(R21)(r1)
+	ld	r21,STK_REG(R20)(r1)
+	ld	r20,STK_REG(R19)(r1)
+	ld	r19,STK_REG(R18)(r1)
+	ld	r18,STK_REG(R17)(r1)
+	ld	r17,STK_REG(R16)(r1)
+	ld	r16,STK_REG(R15)(r1)
+	ld	r15,STK_REG(R14)(r1)
 .Lexit:
 	addi	r1,r1,STACKFRAMESIZE
 .Ldo_err1:
@@ -131,15 +131,15 @@ err1;	stw	r0,0(r3)
 
 	mflr	r0
 	stdu	r1,-STACKFRAMESIZE(r1)
-	std	r14,STK_REG(R14)(r1)
-	std	r15,STK_REG(R15)(r1)
-	std	r16,STK_REG(R16)(r1)
-	std	r17,STK_REG(R17)(r1)
-	std	r18,STK_REG(R18)(r1)
-	std	r19,STK_REG(R19)(r1)
-	std	r20,STK_REG(R20)(r1)
-	std	r21,STK_REG(R21)(r1)
-	std	r22,STK_REG(R22)(r1)
+	std	r15,STK_REG(R14)(r1)
+	std	r16,STK_REG(R15)(r1)
+	std	r17,STK_REG(R16)(r1)
+	std	r18,STK_REG(R17)(r1)
+	std	r19,STK_REG(R18)(r1)
+	std	r20,STK_REG(R19)(r1)
+	std	r21,STK_REG(R20)(r1)
+	std	r22,STK_REG(R21)(r1)
+	std	r23,STK_REG(R22)(r1)
 	std	r0,STACKFRAMESIZE+16(r1)
 
 	srdi	r6,r5,7
@@ -156,14 +156,14 @@ err2;	ld	r9,32(r4)
 err2;	ld	r10,40(r4)
 err2;	ld	r11,48(r4)
 err2;	ld	r12,56(r4)
-err2;	ld	r14,64(r4)
-err2;	ld	r15,72(r4)
-err2;	ld	r16,80(r4)
-err2;	ld	r17,88(r4)
-err2;	ld	r18,96(r4)
-err2;	ld	r19,104(r4)
-err2;	ld	r20,112(r4)
-err2;	ld	r21,120(r4)
+err2;	ld	r15,64(r4)
+err2;	ld	r16,72(r4)
+err2;	ld	r17,80(r4)
+err2;	ld	r18,88(r4)
+err2;	ld	r19,96(r4)
+err2;	ld	r20,104(r4)
+err2;	ld	r21,112(r4)
+err2;	ld	r22,120(r4)
 	addi	r4,r4,128
 err2;	std	r0,0(r3)
 err2;	std	r6,8(r3)
@@ -173,28 +173,28 @@ err2;	std	r9,32(r3)
 err2;	std	r10,40(r3)
 err2;	std	r11,48(r3)
 err2;	std	r12,56(r3)
-err2;	std	r14,64(r3)
-err2;	std	r15,72(r3)
-err2;	std	r16,80(r3)
-err2;	std	r17,88(r3)
-err2;	std	r18,96(r3)
-err2;	std	r19,104(r3)
-err2;	std	r20,112(r3)
-err2;	std	r21,120(r3)
+err2;	std	r15,64(r3)
+err2;	std	r16,72(r3)
+err2;	std	r17,80(r3)
+err2;	std	r18,88(r3)
+err2;	std	r19,96(r3)
+err2;	std	r20,104(r3)
+err2;	std	r21,112(r3)
+err2;	std	r22,120(r3)
 	addi	r3,r3,128
 	bdnz	4b
 
 	clrldi	r5,r5,(64-7)
 
-	ld	r14,STK_REG(R14)(r1)
-	ld	r15,STK_REG(R15)(r1)
-	ld	r16,STK_REG(R16)(r1)
-	ld	r17,STK_REG(R17)(r1)
-	ld	r18,STK_REG(R18)(r1)
-	ld	r19,STK_REG(R19)(r1)
-	ld	r20,STK_REG(R20)(r1)
-	ld	r21,STK_REG(R21)(r1)
-	ld	r22,STK_REG(R22)(r1)
+	ld	r15,STK_REG(R14)(r1)
+	ld	r16,STK_REG(R15)(r1)
+	ld	r17,STK_REG(R16)(r1)
+	ld	r18,STK_REG(R17)(r1)
+	ld	r19,STK_REG(R18)(r1)
+	ld	r20,STK_REG(R19)(r1)
+	ld	r21,STK_REG(R20)(r1)
+	ld	r22,STK_REG(R21)(r1)
+	ld	r23,STK_REG(R22)(r1)
 	addi	r1,r1,STACKFRAMESIZE
 
 	/* Up to 127B to go */
@@ -405,14 +405,14 @@ err3;	stvx	v0,r3,r11
 7:	sub	r5,r5,r6
 	srdi	r6,r5,7
 
-	std	r14,STK_REG(R14)(r1)
-	std	r15,STK_REG(R15)(r1)
-	std	r16,STK_REG(R16)(r1)
+	std	r15,STK_REG(R14)(r1)
+	std	r16,STK_REG(R15)(r1)
+	std	r17,STK_REG(R16)(r1)
 
 	li	r12,64
-	li	r14,80
-	li	r15,96
-	li	r16,112
+	li	r15,80
+	li	r16,96
+	li	r17,112
 
 	mtctr	r6
 
@@ -427,24 +427,24 @@ err4;	lvx	v6,r4,r9
 err4;	lvx	v5,r4,r10
 err4;	lvx	v4,r4,r11
 err4;	lvx	v3,r4,r12
-err4;	lvx	v2,r4,r14
-err4;	lvx	v1,r4,r15
-err4;	lvx	v0,r4,r16
+err4;	lvx	v2,r4,r15
+err4;	lvx	v1,r4,r16
+err4;	lvx	v0,r4,r17
 	addi	r4,r4,128
 err4;	stvx	v7,r0,r3
 err4;	stvx	v6,r3,r9
 err4;	stvx	v5,r3,r10
 err4;	stvx	v4,r3,r11
 err4;	stvx	v3,r3,r12
-err4;	stvx	v2,r3,r14
-err4;	stvx	v1,r3,r15
-err4;	stvx	v0,r3,r16
+err4;	stvx	v2,r3,r15
+err4;	stvx	v1,r3,r16
+err4;	stvx	v0,r3,r17
 	addi	r3,r3,128
 	bdnz	8b
 
-	ld	r14,STK_REG(R14)(r1)
-	ld	r15,STK_REG(R15)(r1)
-	ld	r16,STK_REG(R16)(r1)
+	ld	r15,STK_REG(R14)(r1)
+	ld	r16,STK_REG(R15)(r1)
+	ld	r17,STK_REG(R16)(r1)
 
 	/* Up to 127B to go */
 	clrldi	r5,r5,(64-7)
@@ -590,14 +590,14 @@ err3;	stvx	v11,r3,r11
 7:	sub	r5,r5,r6
 	srdi	r6,r5,7
 
-	std	r14,STK_REG(R14)(r1)
-	std	r15,STK_REG(R15)(r1)
-	std	r16,STK_REG(R16)(r1)
+	std	r15,STK_REG(R14)(r1)
+	std	r16,STK_REG(R15)(r1)
+	std	r17,STK_REG(R16)(r1)
 
 	li	r12,64
-	li	r14,80
-	li	r15,96
-	li	r16,112
+	li	r15,80
+	li	r16,96
+	li	r17,112
 
 	mtctr	r6
 
@@ -617,11 +617,11 @@ err4;	lvx	v4,r4,r11
 	VPERM(v11,v5,v4,v16)
 err4;	lvx	v3,r4,r12
 	VPERM(v12,v4,v3,v16)
-err4;	lvx	v2,r4,r14
+err4;	lvx	v2,r4,r15
 	VPERM(v13,v3,v2,v16)
-err4;	lvx	v1,r4,r15
+err4;	lvx	v1,r4,r16
 	VPERM(v14,v2,v1,v16)
-err4;	lvx	v0,r4,r16
+err4;	lvx	v0,r4,r17
 	VPERM(v15,v1,v0,v16)
 	addi	r4,r4,128
 err4;	stvx	v8,r0,r3
@@ -629,15 +629,15 @@ err4;	stvx	v9,r3,r9
 err4;	stvx	v10,r3,r10
 err4;	stvx	v11,r3,r11
 err4;	stvx	v12,r3,r12
-err4;	stvx	v13,r3,r14
-err4;	stvx	v14,r3,r15
-err4;	stvx	v15,r3,r16
+err4;	stvx	v13,r3,r15
+err4;	stvx	v14,r3,r16
+err4;	stvx	v15,r3,r17
 	addi	r3,r3,128
 	bdnz	8b
 
-	ld	r14,STK_REG(R14)(r1)
-	ld	r15,STK_REG(R15)(r1)
-	ld	r16,STK_REG(R16)(r1)
+	ld	r15,STK_REG(R14)(r1)
+	ld	r16,STK_REG(R15)(r1)
+	ld	r17,STK_REG(R16)(r1)
 
 	/* Up to 127B to go */
 	clrldi	r5,r5,(64-7)
diff --git a/arch/powerpc/lib/crtsavres.S b/arch/powerpc/lib/crtsavres.S
index 7e5e1c28e56a..c46ad2f0a718 100644
--- a/arch/powerpc/lib/crtsavres.S
+++ b/arch/powerpc/lib/crtsavres.S
@@ -314,9 +314,12 @@ _GLOBAL(_restvr_31)
 
 #else /* CONFIG_PPC64 */
 
+/* 64-bit has -ffixed-r13, Book3S also has -ffixed-r14 */
+#ifdef CONFIG_PPC_BOOK3E
 .globl	_savegpr0_14
 _savegpr0_14:
 	std	r14,-144(r1)
+#endif
 .globl	_savegpr0_15
 _savegpr0_15:
 	std	r15,-136(r1)
diff --git a/arch/powerpc/lib/memcpy_power7.S b/arch/powerpc/lib/memcpy_power7.S
index 95ca426637eb..6c0684e5e0d3 100644
--- a/arch/powerpc/lib/memcpy_power7.S
+++ b/arch/powerpc/lib/memcpy_power7.S
@@ -76,7 +76,6 @@ _GLOBAL(memcpy_power7)
 
 	mflr	r0
 	stdu	r1,-STACKFRAMESIZE(r1)
-	std	r14,STK_REG(R14)(r1)
 	std	r15,STK_REG(R15)(r1)
 	std	r16,STK_REG(R16)(r1)
 	std	r17,STK_REG(R17)(r1)
@@ -85,6 +84,7 @@ _GLOBAL(memcpy_power7)
 	std	r20,STK_REG(R20)(r1)
 	std	r21,STK_REG(R21)(r1)
 	std	r22,STK_REG(R22)(r1)
+	std	r23,STK_REG(R23)(r1)
 	std	r0,STACKFRAMESIZE+16(r1)
 
 	srdi	r6,r5,7
@@ -101,14 +101,14 @@ _GLOBAL(memcpy_power7)
 	ld	r10,40(r4)
 	ld	r11,48(r4)
 	ld	r12,56(r4)
-	ld	r14,64(r4)
-	ld	r15,72(r4)
-	ld	r16,80(r4)
-	ld	r17,88(r4)
-	ld	r18,96(r4)
-	ld	r19,104(r4)
-	ld	r20,112(r4)
-	ld	r21,120(r4)
+	ld	r15,64(r4)
+	ld	r16,72(r4)
+	ld	r17,80(r4)
+	ld	r18,88(r4)
+	ld	r19,96(r4)
+	ld	r20,104(r4)
+	ld	r21,112(r4)
+	ld	r22,120(r4)
 	addi	r4,r4,128
 	std	r0,0(r3)
 	std	r6,8(r3)
@@ -118,20 +118,19 @@ _GLOBAL(memcpy_power7)
 	std	r10,40(r3)
 	std	r11,48(r3)
 	std	r12,56(r3)
-	std	r14,64(r3)
-	std	r15,72(r3)
-	std	r16,80(r3)
-	std	r17,88(r3)
-	std	r18,96(r3)
-	std	r19,104(r3)
-	std	r20,112(r3)
-	std	r21,120(r3)
+	std	r15,64(r3)
+	std	r16,72(r3)
+	std	r17,80(r3)
+	std	r18,88(r3)
+	std	r19,96(r3)
+	std	r20,104(r3)
+	std	r21,112(r3)
+	std	r22,120(r3)
 	addi	r3,r3,128
 	bdnz	4b
 
 	clrldi	r5,r5,(64-7)
 
-	ld	r14,STK_REG(R14)(r1)
 	ld	r15,STK_REG(R15)(r1)
 	ld	r16,STK_REG(R16)(r1)
 	ld	r17,STK_REG(R17)(r1)
@@ -140,6 +139,7 @@ _GLOBAL(memcpy_power7)
 	ld	r20,STK_REG(R20)(r1)
 	ld	r21,STK_REG(R21)(r1)
 	ld	r22,STK_REG(R22)(r1)
+	ld	r23,STK_REG(R23)(r1)
 	addi	r1,r1,STACKFRAMESIZE
 
 	/* Up to 127B to go */
@@ -350,14 +350,14 @@ _GLOBAL(memcpy_power7)
 7:	sub	r5,r5,r6
 	srdi	r6,r5,7
 
-	std	r14,STK_REG(R14)(r1)
 	std	r15,STK_REG(R15)(r1)
 	std	r16,STK_REG(R16)(r1)
+	std	r17,STK_REG(R17)(r1)
 
 	li	r12,64
-	li	r14,80
-	li	r15,96
-	li	r16,112
+	li	r15,80
+	li	r16,96
+	li	r17,112
 
 	mtctr	r6
 
@@ -372,24 +372,24 @@ _GLOBAL(memcpy_power7)
 	lvx	v5,r4,r10
 	lvx	v4,r4,r11
 	lvx	v3,r4,r12
-	lvx	v2,r4,r14
-	lvx	v1,r4,r15
-	lvx	v0,r4,r16
+	lvx	v2,r4,r15
+	lvx	v1,r4,r16
+	lvx	v0,r4,r17
 	addi	r4,r4,128
 	stvx	v7,r0,r3
 	stvx	v6,r3,r9
 	stvx	v5,r3,r10
 	stvx	v4,r3,r11
 	stvx	v3,r3,r12
-	stvx	v2,r3,r14
-	stvx	v1,r3,r15
-	stvx	v0,r3,r16
+	stvx	v2,r3,r15
+	stvx	v1,r3,r16
+	stvx	v0,r3,r17
 	addi	r3,r3,128
 	bdnz	8b
 
-	ld	r14,STK_REG(R14)(r1)
 	ld	r15,STK_REG(R15)(r1)
 	ld	r16,STK_REG(R16)(r1)
+	ld	r17,STK_REG(R17)(r1)
 
 	/* Up to 127B to go */
 	clrldi	r5,r5,(64-7)
@@ -536,14 +536,14 @@ _GLOBAL(memcpy_power7)
 7:	sub	r5,r5,r6
 	srdi	r6,r5,7
 
-	std	r14,STK_REG(R14)(r1)
 	std	r15,STK_REG(R15)(r1)
 	std	r16,STK_REG(R16)(r1)
+	std	r17,STK_REG(R17)(r1)
 
 	li	r12,64
-	li	r14,80
-	li	r15,96
-	li	r16,112
+	li	r15,80
+	li	r16,96
+	li	r17,112
 
 	mtctr	r6
 
@@ -563,11 +563,11 @@ _GLOBAL(memcpy_power7)
 	VPERM(v11,v5,v4,v16)
 	lvx	v3,r4,r12
 	VPERM(v12,v4,v3,v16)
-	lvx	v2,r4,r14
+	lvx	v2,r4,r15
 	VPERM(v13,v3,v2,v16)
-	lvx	v1,r4,r15
+	lvx	v1,r4,r16
 	VPERM(v14,v2,v1,v16)
-	lvx	v0,r4,r16
+	lvx	v0,r4,r17
 	VPERM(v15,v1,v0,v16)
 	addi	r4,r4,128
 	stvx	v8,r0,r3
@@ -575,15 +575,15 @@ _GLOBAL(memcpy_power7)
 	stvx	v10,r3,r10
 	stvx	v11,r3,r11
 	stvx	v12,r3,r12
-	stvx	v13,r3,r14
-	stvx	v14,r3,r15
-	stvx	v15,r3,r16
+	stvx	v13,r3,r15
+	stvx	v14,r3,r16
+	stvx	v15,r3,r17
 	addi	r3,r3,128
 	bdnz	8b
 
-	ld	r14,STK_REG(R14)(r1)
 	ld	r15,STK_REG(R15)(r1)
 	ld	r16,STK_REG(R16)(r1)
+	ld	r17,STK_REG(R17)(r1)
 
 	/* Up to 127B to go */
 	clrldi	r5,r5,(64-7)
diff --git a/arch/powerpc/net/bpf_jit32.h b/arch/powerpc/net/bpf_jit32.h
index a8cd7e289ecd..52a30db033c1 100644
--- a/arch/powerpc/net/bpf_jit32.h
+++ b/arch/powerpc/net/bpf_jit32.h
@@ -44,9 +44,11 @@
  * A register	r4
  * X register	r5
  * addr param	r6
- * r7-r10	scratch
- * skb->data	r14
- * skb headlen	r15	(skb->len - skb->data_len)
+ * scratch	r7-r8
+ * skb headlen	r9	(skb->len - skb->data_len)
+ * skb->data	r10
+ * fixed regs	r13-r14
+ * unused	r15
  * m[0]		r16
  * m[...]	...
  * m[15]	r31
@@ -58,8 +60,8 @@
 #define r_addr		6
 #define r_scratch1	7
 #define r_scratch2	8
-#define r_D		14
-#define r_HL		15
+#define r_HL		9
+#define r_D		10
 #define r_M		16
 
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/net/bpf_jit_asm.S b/arch/powerpc/net/bpf_jit_asm.S
index 3dd9c43d40c9..5b06152052f6 100644
--- a/arch/powerpc/net/bpf_jit_asm.S
+++ b/arch/powerpc/net/bpf_jit_asm.S
@@ -19,8 +19,8 @@
  * r3		skb
  * r4,r5	A,X
  * r6		*** address parameter to helper ***
- * r7-r10	scratch
- * r14		skb->data
+ * r7-r9	scratch
+ * r10		skb->data
  * r15		skb headlen
  * r16-31	M[]
  */
-- 
2.11.0
