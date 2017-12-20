Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1yRV4vbVzDql5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 01:52:21 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id k134so12007772pga.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 06:52:21 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 1/8] powerpc/64s: stop using r14 register
Date: Thu, 21 Dec 2017 00:51:59 +1000
Message-Id: <20171220145206.12234-2-npiggin@gmail.com>
In-Reply-To: <20171220145206.12234-1-npiggin@gmail.com>
References: <20171220145206.12234-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

---
 arch/powerpc/Makefile                          |   1 +
 arch/powerpc/crypto/md5-asm.S                  |  40 +++----
 arch/powerpc/crypto/sha1-powerpc-asm.S         |  10 +-
 arch/powerpc/include/asm/kvm_book3s_asm.h      |   2 +-
 arch/powerpc/include/asm/ppc_asm.h             |  21 +++-
 arch/powerpc/kernel/asm-offsets.c              |   4 +-
 arch/powerpc/kernel/entry_32.S                 |   4 +-
 arch/powerpc/kernel/entry_64.S                 |  45 ++++----
 arch/powerpc/kernel/exceptions-64s.S           |   3 +-
 arch/powerpc/kernel/head_64.S                  |   8 +-
 arch/powerpc/kernel/idle_book3s.S              |  79 +++++++------
 arch/powerpc/kernel/kgdb.c                     |   8 +-
 arch/powerpc/kernel/process.c                  |   4 +-
 arch/powerpc/kernel/tm.S                       |  40 ++++---
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  10 +-
 arch/powerpc/kvm/book3s_hv_interrupts.S        |   5 +-
 arch/powerpc/kvm/book3s_interrupts.S           |  93 +++++++++++----
 arch/powerpc/kvm/book3s_pr.c                   |   6 +
 arch/powerpc/lib/checksum_64.S                 |  66 +++++------
 arch/powerpc/lib/copypage_power7.S             |  32 +++---
 arch/powerpc/lib/copyuser_power7.S             | 152 ++++++++++++-------------
 arch/powerpc/lib/crtsavres.S                   |   3 +
 arch/powerpc/lib/memcpy_power7.S               |  80 ++++++-------
 23 files changed, 396 insertions(+), 320 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 1381693a4a51..8dd38facc5f2 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -140,6 +140,7 @@ AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
 endif
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
index c8951ce0dcc4..6c38de214c11 100644
--- a/arch/powerpc/crypto/sha1-powerpc-asm.S
+++ b/arch/powerpc/crypto/sha1-powerpc-asm.S
@@ -42,10 +42,10 @@
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
@@ -124,8 +124,7 @@
 
 _GLOBAL(powerpc_sha_transform)
 	PPC_STLU r1,-INT_FRAME_SIZE(r1)
-	SAVE_8GPRS(14, r1)
-	SAVE_10GPRS(22, r1)
+	SAVE_NVGPRS(r1)
 
 	/* Load up A - E */
 	lwz	RA(0),0(r3)	/* A */
@@ -183,7 +182,6 @@ _GLOBAL(powerpc_sha_transform)
 	stw	RD(0),12(r3)
 	stw	RE(0),16(r3)
 
-	REST_8GPRS(14, r1)
-	REST_10GPRS(22, r1)
+	REST_NVGPRS(r1)
 	addi	r1,r1,INT_FRAME_SIZE
 	blr
diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index ab386af2904f..fbbd2ca18866 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -143,7 +143,7 @@ struct kvmppc_host_state {
 
 struct kvmppc_book3s_shadow_vcpu {
 	bool in_use;
-	ulong gpr[14];
+	ulong gpr[15];
 	u32 cr;
 	ulong xer;
 	ulong ctr;
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index ae94b3626b6c..109f4dce8a79 100644
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
index 397681f43eed..db8407483c9e 100644
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
index e780e1fbf6c2..4b3cf4dc7d05 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -458,8 +458,8 @@ ret_from_fork:
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
index f2ffb9aa7ff4..b9bf44635b10 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -419,7 +419,7 @@ _ASM_NOKPROBE_SYMBOL(save_nvgprs);
  * The sigsuspend and rt_sigsuspend system calls can call do_signal
  * and thus put the process into the stopped state where we might
  * want to examine its user state with ptrace.  Therefore we need
- * to save all the nonvolatile registers (r14 - r31) before calling
+ * to save all the nonvolatile registers (r15 - r31) before calling
  * the C code.  Similarly, fork, vfork and clone need the full
  * register state on the stack so that it can be copied to the child.
  */
@@ -463,10 +463,10 @@ _GLOBAL(ret_from_fork)
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
@@ -495,9 +495,7 @@ _GLOBAL(_switch)
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
@@ -609,9 +607,8 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	ld	r6,_CCR(r1)
 	mtcrf	0xFF,r6
 
-	/* r3-r13 are destroyed -- Cort */
-	REST_8GPRS(14, r1)
-	REST_10GPRS(22, r1)
+	/* Volatile regs are destroyed */
+	REST_NVGPRS(r1)
 
 	/* convert old thread to its task_struct for return value */
 	addi	r3,r3,-THREAD
@@ -1011,12 +1008,14 @@ _GLOBAL(enter_rtas)
 
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
@@ -1118,8 +1117,10 @@ rtas_restore_regs:
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
 
@@ -1149,12 +1150,14 @@ _GLOBAL(enter_prom)
 
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
@@ -1198,8 +1201,10 @@ _GLOBAL(enter_prom)
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
index 60d9c68ef414..189c456450e2 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1656,8 +1656,7 @@ BEGIN_FTR_SECTION
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
index 56f9e112b98d..87b2c2264118 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -802,9 +802,9 @@ __secondary_start:
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
@@ -813,7 +813,7 @@ __secondary_start:
 	 * setup the new stack pointer, but *don't* use this until
 	 * translation is on.
 	 */
-	mr	r1, r14
+	mr	r1, r15
 
 	/* Clear backchain so we get nice backtraces */
 	li	r7,0
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 01e1c1997893..5065c4cb5f12 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -150,19 +150,19 @@ power9_restore_additional_sprs:
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
 
@@ -263,21 +263,21 @@ pnv_enter_arch207_idle_mode:
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
@@ -291,7 +291,7 @@ lwarx_loop1:
 pnv_fastsleep_workaround_at_entry:
 	beq	fastsleep_workaround_at_entry
 
-	stwcx.	r15,0,r14
+	stwcx.	r16,0,r15
 	bne-	lwarx_loop1
 	isync
 
@@ -300,8 +300,8 @@ common_enter: /* common code for all the threads entering sleep or winkle */
 	IDLE_STATE_ENTER_SEQ_NORET(PPC_SLEEP)
 
 fastsleep_workaround_at_entry:
-	oris	r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
-	stwcx.	r15,0,r14
+	oris	r16,r16,PNV_CORE_IDLE_LOCK_BIT@h
+	stwcx.	r16,0,r15
 	bne-	lwarx_loop1
 	isync
 
@@ -311,9 +311,9 @@ fastsleep_workaround_at_entry:
 	bl	opal_config_cpu_idle_state
 
 	/* Unlock */
-	xoris	r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
+	xoris	r16,r16,PNV_CORE_IDLE_LOCK_BIT@h
 	lwsync
-	stw	r15,0(r14)
+	stw	r16,0(r15)
 	b	common_enter
 
 enter_winkle:
@@ -381,15 +381,15 @@ END_FTR_SECTION_IFCLR(CPU_FTR_POWER9_DD2_1)
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
 
@@ -643,8 +643,7 @@ pnv_wakeup_tb_loss:
 	stb	r0,PACA_NAPSTATELOST(r13)
 
 	/*
-	 *
-	 * Save SRR1 and LR in NVGPRs as they might be clobbered in
+	 * Save SRR1 (r12) and LR in NVGPRs as they might be clobbered in
 	 * opal_call() (called in CHECK_HMI_INTERRUPT). SRR1 is required
 	 * to determine the wakeup reason if we branch to kvm_start_guest. LR
 	 * is required to return back to reset vector after hypervisor state
@@ -657,7 +656,7 @@ BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 
-	ld	r14,PACA_CORE_IDLE_STATE_PTR(r13)
+	ld	r15,PACA_CORE_IDLE_STATE_PTR(r13)
 	lbz	r7,PACA_THREAD_MASK(r13)
 
 	/*
@@ -671,15 +670,15 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
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
@@ -745,27 +744,27 @@ BEGIN_FTR_SECTION
 	 */
 	cmpwi	r18,PNV_THREAD_WINKLE
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
@@ -842,9 +841,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	mtspr	SPRN_WORC,r4
 
 clear_lock:
-	xoris	r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
+	xoris	r16,r16,PNV_CORE_IDLE_LOCK_BIT@h
 	lwsync
-	stw	r15,0(r14)
+	stw	r16,0(r15)
 
 common_exit:
 	/*
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 35e240a0a408..d593e381f34d 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -230,11 +230,11 @@ void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
 	for (reg = 0; reg < 3; reg++)
 		PACK64(ptr, regs->gpr[reg]);
 
-	/* Regs GPR3-13 are caller saved, not in regs->gpr[] */
-	ptr += 11;
+	/* Regs GPR3-13/14 are caller saved, not in regs->gpr[] */
+	ptr += FIRST_NVGPR - 2;
 
-	/* Regs GPR14-31 */
-	for (reg = 14; reg < 32; reg++)
+	/* Regs GPR14/15-31 */
+	for (reg = FIRST_NVGPR; reg < 32; reg++)
 		PACK64(ptr, regs->gpr[reg]);
 
 #ifdef CONFIG_FSL_BOOKE
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 2a63cc78257d..f56e42f06f24 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1672,12 +1672,12 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 		childregs->gpr[1] = sp + sizeof(struct pt_regs);
 		/* function */
 		if (usp)
-			childregs->gpr[14] = ppc_function_entry((void *)usp);
+			childregs->gpr[FIRST_NVGPR] = ppc_function_entry((void *)usp);
 #ifdef CONFIG_PPC64
 		clear_tsk_thread_flag(p, TIF_32BIT);
 		childregs->softe = IRQ_SOFT_MASK_NONE;
 #endif
-		childregs->gpr[15] = kthread_arg;
+		childregs->gpr[FIRST_NVGPR + 1] = kthread_arg;
 		p->thread.regs = NULL;	/* no user register state */
 		ti->flags |= _TIF_RESTOREALL;
 		f = ret_from_kernel_thread;
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index b92ac8e711db..3f62b8157aea 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -106,27 +106,28 @@ _GLOBAL(tm_reclaim)
 	/* We've a struct pt_regs at [r1+STACK_FRAME_OVERHEAD]. */
 
 	std	r3, STK_PARAM(R3)(r1)
+	SAVE_GPR(14, r1)
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
@@ -205,7 +206,8 @@ _GLOBAL(tm_reclaim)
 	std	r6, GPR12(r7)
 	std	r8, GPR13(r7)
 
-	SAVE_NVGPRS(r7)				/* user r14-r31 */
+	SAVE_GPR(14, r7)			/* user r14 */
+	SAVE_NVGPRS(r7)				/* user r15-r31 */
 
 	/* ******************** NIP ******************** */
 	mfspr	r3, SPRN_TFHAR
@@ -278,12 +280,13 @@ _GLOBAL(tm_reclaim)
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
 
+	REST_GPR(14, r1)
 	REST_NVGPRS(r1)
 
 	addi    r1, r1, TM_FRAME_SIZE
@@ -319,6 +322,7 @@ _GLOBAL(__tm_recheckpoint)
 	/* We've a struct pt_regs at [r1+STACK_FRAME_OVERHEAD].
 	 * This is used for backing up the NVGPRs:
 	 */
+	SAVE_GPR(14, r1)
 	SAVE_NVGPRS(r1)
 
 	/* Load complete register state from ts_ckpt* registers */
@@ -391,8 +395,9 @@ restore_gprs:
 	REST_GPR(4, r7)				/* GPR4 */
 	REST_4GPRS(8, r7)			/* GPR8-11 */
 	REST_2GPRS(12, r7)			/* GPR12-13 */
+	REST_GPR(14, r7)			/* GPR14 */
 
-	REST_NVGPRS(r7)				/* GPR14-31 */
+	REST_NVGPRS(r7)				/* GPR15-31 */
 
 	/* Load up PPR and DSCR here so we don't run with user values for long
 	 */
@@ -471,6 +476,7 @@ restore_gprs:
 	li	r4, MSR_RI
 	mtmsrd	r4, 1
 
+	REST_GPR(14, r1)
 	REST_NVGPRS(r1)
 
 	addi    r1, r1, TM_FRAME_SIZE
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 3f3e81852422..a0f62ff3442f 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -76,7 +76,7 @@ _GLOBAL(ftrace_caller)
 	ld	r5,0(r3)
 
 #ifdef CONFIG_LIVEPATCH
-	mr	r14,r7		/* remember old NIP */
+	mr	r15,r7		/* remember old NIP */
 #endif
 	/* Calculate ip from nip-4 into r3 for call below */
 	subi    r3, r7, MCOUNT_INSN_SIZE
@@ -100,10 +100,10 @@ ftrace_call:
 	nop
 
 	/* Load the possibly modified NIP */
-	ld	r15, _NIP(r1)
+	ld	r16, _NIP(r1)
 
 #ifdef CONFIG_LIVEPATCH
-	cmpd	r14, r15	/* has NIP been altered? */
+	cmpd	r15, r16	/* has NIP been altered? */
 #endif
 
 #if defined(CONFIG_LIVEPATCH) && defined(CONFIG_KPROBES_ON_FTRACE)
@@ -111,7 +111,7 @@ ftrace_call:
 	beq	1f
 
 	/* Check if there is an active jprobe on us */
-	subi	r3, r14, 4
+	subi	r3, r15, 4
 	bl	__is_active_jprobe
 	nop
 
@@ -130,7 +130,7 @@ ftrace_call:
 #endif
 
 	/* Load CTR with the possibly modified NIP */
-	mtctr	r15
+	mtctr	r16
 
 	/* Restore gprs */
 	REST_GPR(0,r1)
diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/book3s_hv_interrupts.S
index dc54373c8780..ef1c0c1e57ff 100644
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
@@ -149,9 +149,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	 * R3       = trap number on this thread
 	 * R12      = exit handler id
 	 * R13      = PACA
+	 * R14      = ? XXX
 	 */
 
-	/* Restore non-volatile host registers (r14 - r31) and CR */
+	/* Restore non-volatile host registers (r15 - r31) and CR */
 	REST_NVGPRS(r1)
 	ld	r4, _CCR(r1)
 	mtcr	r4
diff --git a/arch/powerpc/kvm/book3s_interrupts.S b/arch/powerpc/kvm/book3s_interrupts.S
index 901e6fe00c39..b275a544129e 100644
--- a/arch/powerpc/kvm/book3s_interrupts.S
+++ b/arch/powerpc/kvm/book3s_interrupts.S
@@ -38,6 +38,45 @@
 
 #endif /* CONFIG_PPC_BOOK3S_XX */
 
+#if defined(CONFIG_PPC_BOOK3S_64)
+#define VCPU_LOAD_NVGPRS(vcpu) \
+	PPC_LL	r15, VCPU_GPR(R15)(vcpu); \
+	PPC_LL	r16, VCPU_GPR(R16)(vcpu); \
+	PPC_LL	r17, VCPU_GPR(R17)(vcpu); \
+	PPC_LL	r18, VCPU_GPR(R18)(vcpu); \
+	PPC_LL	r19, VCPU_GPR(R19)(vcpu); \
+	PPC_LL	r20, VCPU_GPR(R20)(vcpu); \
+	PPC_LL	r21, VCPU_GPR(R21)(vcpu); \
+	PPC_LL	r22, VCPU_GPR(R22)(vcpu); \
+	PPC_LL	r23, VCPU_GPR(R23)(vcpu); \
+	PPC_LL	r24, VCPU_GPR(R24)(vcpu); \
+	PPC_LL	r25, VCPU_GPR(R25)(vcpu); \
+	PPC_LL	r26, VCPU_GPR(R26)(vcpu); \
+	PPC_LL	r27, VCPU_GPR(R27)(vcpu); \
+	PPC_LL	r28, VCPU_GPR(R28)(vcpu); \
+	PPC_LL	r29, VCPU_GPR(R29)(vcpu); \
+	PPC_LL	r30, VCPU_GPR(R30)(vcpu); \
+	PPC_LL	r31, VCPU_GPR(R31)(vcpu);
+
+#define VCPU_STORE_NVGPRS(vcpu) \
+	PPC_STL	r15, VCPU_GPR(R15)(vcpu); \
+	PPC_STL	r16, VCPU_GPR(R16)(vcpu); \
+	PPC_STL	r17, VCPU_GPR(R17)(vcpu); \
+	PPC_STL	r18, VCPU_GPR(R18)(vcpu); \
+	PPC_STL	r19, VCPU_GPR(R19)(vcpu); \
+	PPC_STL	r20, VCPU_GPR(R20)(vcpu); \
+	PPC_STL	r21, VCPU_GPR(R21)(vcpu); \
+	PPC_STL	r22, VCPU_GPR(R22)(vcpu); \
+	PPC_STL	r23, VCPU_GPR(R23)(vcpu); \
+	PPC_STL	r24, VCPU_GPR(R24)(vcpu); \
+	PPC_STL	r25, VCPU_GPR(R25)(vcpu); \
+	PPC_STL	r26, VCPU_GPR(R26)(vcpu); \
+	PPC_STL	r27, VCPU_GPR(R27)(vcpu); \
+	PPC_STL	r28, VCPU_GPR(R28)(vcpu); \
+	PPC_STL	r29, VCPU_GPR(R29)(vcpu); \
+	PPC_STL	r30, VCPU_GPR(R30)(vcpu); \
+	PPC_STL	r31, VCPU_GPR(R31)(vcpu);
+#else
 #define VCPU_LOAD_NVGPRS(vcpu) \
 	PPC_LL	r14, VCPU_GPR(R14)(vcpu); \
 	PPC_LL	r15, VCPU_GPR(R15)(vcpu); \
@@ -56,7 +95,28 @@
 	PPC_LL	r28, VCPU_GPR(R28)(vcpu); \
 	PPC_LL	r29, VCPU_GPR(R29)(vcpu); \
 	PPC_LL	r30, VCPU_GPR(R30)(vcpu); \
-	PPC_LL	r31, VCPU_GPR(R31)(vcpu); \
+	PPC_LL	r31, VCPU_GPR(R31)(vcpu);
+
+#define VCPU_STORE_NVGPRS(vcpu) \
+	PPC_STL	r14, VCPU_GPR(R14)(vcpu); \
+	PPC_STL	r15, VCPU_GPR(R15)(vcpu); \
+	PPC_STL	r16, VCPU_GPR(R16)(vcpu); \
+	PPC_STL	r17, VCPU_GPR(R17)(vcpu); \
+	PPC_STL	r18, VCPU_GPR(R18)(vcpu); \
+	PPC_STL	r19, VCPU_GPR(R19)(vcpu); \
+	PPC_STL	r20, VCPU_GPR(R20)(vcpu); \
+	PPC_STL	r21, VCPU_GPR(R21)(vcpu); \
+	PPC_STL	r22, VCPU_GPR(R22)(vcpu); \
+	PPC_STL	r23, VCPU_GPR(R23)(vcpu); \
+	PPC_STL	r24, VCPU_GPR(R24)(vcpu); \
+	PPC_STL	r25, VCPU_GPR(R25)(vcpu); \
+	PPC_STL	r26, VCPU_GPR(R26)(vcpu); \
+	PPC_STL	r27, VCPU_GPR(R27)(vcpu); \
+	PPC_STL	r28, VCPU_GPR(R28)(vcpu); \
+	PPC_STL	r29, VCPU_GPR(R29)(vcpu); \
+	PPC_STL	r30, VCPU_GPR(R30)(vcpu); \
+	PPC_STL	r31, VCPU_GPR(R31)(vcpu);
+#endif
 
 /*****************************************************************************
  *                                                                           *
@@ -81,12 +141,12 @@ kvm_start_entry:
 	/* Save r3 (kvm_run) and r4 (vcpu) */
 	SAVE_2GPRS(3, r1)
 
-	/* Save non-volatile registers (r14 - r31) */
+	/* Save non-volatile registers (r14/r15 - r31) */
 	SAVE_NVGPRS(r1)
 
 	/* Save CR */
-	mfcr	r14
-	stw	r14, _CCR(r1)
+	mfcr	r15
+	stw	r15, _CCR(r1)
 
 	/* Save LR */
 	PPC_STL	r0, _LINK(r1)
@@ -183,24 +243,7 @@ after_sprg3_load:
 	/* R7 = vcpu */
 	PPC_LL	r7, GPR4(r1)
 
-	PPC_STL	r14, VCPU_GPR(R14)(r7)
-	PPC_STL	r15, VCPU_GPR(R15)(r7)
-	PPC_STL	r16, VCPU_GPR(R16)(r7)
-	PPC_STL	r17, VCPU_GPR(R17)(r7)
-	PPC_STL	r18, VCPU_GPR(R18)(r7)
-	PPC_STL	r19, VCPU_GPR(R19)(r7)
-	PPC_STL	r20, VCPU_GPR(R20)(r7)
-	PPC_STL	r21, VCPU_GPR(R21)(r7)
-	PPC_STL	r22, VCPU_GPR(R22)(r7)
-	PPC_STL	r23, VCPU_GPR(R23)(r7)
-	PPC_STL	r24, VCPU_GPR(R24)(r7)
-	PPC_STL	r25, VCPU_GPR(R25)(r7)
-	PPC_STL	r26, VCPU_GPR(R26)(r7)
-	PPC_STL	r27, VCPU_GPR(R27)(r7)
-	PPC_STL	r28, VCPU_GPR(R28)(r7)
-	PPC_STL	r29, VCPU_GPR(R29)(r7)
-	PPC_STL	r30, VCPU_GPR(R30)(r7)
-	PPC_STL	r31, VCPU_GPR(R31)(r7)
+	VCPU_STORE_NVGPRS(r7)
 
 	/* Pass the exit number as 3rd argument to kvmppc_handle_exit */
 	lwz	r5, VCPU_TRAP(r7)
@@ -221,10 +264,10 @@ kvm_exit_loop:
 	PPC_LL	r4, _LINK(r1)
 	mtlr	r4
 
-	lwz	r14, _CCR(r1)
-	mtcr	r14
+	lwz	r15, _CCR(r1)
+	mtcr	r15
 
-	/* Restore non-volatile host registers (r14 - r31) */
+	/* Restore non-volatile host registers (r14/r15 - r31) */
 	REST_NVGPRS(r1)
 
 	addi    r1, r1, SWITCH_FRAME_SIZE
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index d0dc8624198f..b149d4fa4a45 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -159,6 +159,9 @@ void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
 	svcpu->gpr[11] = vcpu->arch.gpr[11];
 	svcpu->gpr[12] = vcpu->arch.gpr[12];
 	svcpu->gpr[13] = vcpu->arch.gpr[13];
+#ifdef CONFIG_PPC_BOOK3S_64
+	svcpu->gpr[14] = vcpu->arch.gpr[14];
+#endif
 	svcpu->cr  = vcpu->arch.cr;
 	svcpu->xer = vcpu->arch.xer;
 	svcpu->ctr = vcpu->arch.ctr;
@@ -209,6 +212,9 @@ void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
 	vcpu->arch.gpr[11] = svcpu->gpr[11];
 	vcpu->arch.gpr[12] = svcpu->gpr[12];
 	vcpu->arch.gpr[13] = svcpu->gpr[13];
+#ifdef CONFIG_PPC_BOOK3S_64
+	vcpu->arch.gpr[14] = svcpu->gpr[14];
+#endif
 	vcpu->arch.cr  = svcpu->cr;
 	vcpu->arch.xer = svcpu->xer;
 	vcpu->arch.ctr = svcpu->ctr;
diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
index d7f1a966136e..19b0fd549b24 100644
--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -64,9 +64,9 @@ _GLOBAL(__csum_partial)
 	mtctr	r6
 
 	stdu	r1,-STACKFRAMESIZE(r1)
-	std	r14,STK_REG(R14)(r1)
 	std	r15,STK_REG(R15)(r1)
 	std	r16,STK_REG(R16)(r1)
+	std	r17,STK_REG(R17)(r1)
 
 	ld	r6,0(r3)
 	ld	r9,8(r3)
@@ -84,11 +84,11 @@ _GLOBAL(__csum_partial)
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
@@ -97,13 +97,13 @@ _GLOBAL(__csum_partial)
 
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
@@ -111,23 +111,23 @@ _GLOBAL(__csum_partial)
 
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
@@ -258,9 +258,9 @@ dstnr;	sth	r6,0(r4)
 	mtctr	r6
 
 	stdu	r1,-STACKFRAMESIZE(r1)
-	std	r14,STK_REG(R14)(r1)
 	std	r15,STK_REG(R15)(r1)
 	std	r16,STK_REG(R16)(r1)
+	std	r17,STK_REG(R17)(r1)
 
 source;	ld	r6,0(r3)
 source;	ld	r9,8(r3)
@@ -278,11 +278,11 @@ source;	ld	r11,24(r3)
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
@@ -295,18 +295,18 @@ dest;	std	r11,24(r4)
 
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
@@ -314,11 +314,11 @@ source;	ld	r11,24(r3)
 
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
@@ -331,19 +331,19 @@ dest;	std	r11,24(r4)
 
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
@@ -406,9 +406,9 @@ dstnr;	stb	r6,0(r4)
 	blr
 
 .Lsrc_error:
-	ld	r14,STK_REG(R14)(r1)
 	ld	r15,STK_REG(R15)(r1)
 	ld	r16,STK_REG(R16)(r1)
+	ld	r17,STK_REG(R17)(r1)
 	addi	r1,r1,STACKFRAMESIZE
 .Lsrc_error_nr:
 	cmpdi	0,r7,0
@@ -418,9 +418,9 @@ dstnr;	stb	r6,0(r4)
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
index ca5fc8fa7efc..c65fc4a412f2 100644
--- a/arch/powerpc/lib/copypage_power7.S
+++ b/arch/powerpc/lib/copypage_power7.S
@@ -113,13 +113,13 @@ _GLOBAL(copypage_power7)
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
@@ -130,13 +130,13 @@ _GLOBAL(copypage_power7)
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
@@ -147,22 +147,22 @@ _GLOBAL(copypage_power7)
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
index d416a4a66578..9c137451149b 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -50,9 +50,9 @@
 
 
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
@@ -61,15 +61,15 @@
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
@@ -130,15 +130,15 @@ err1;	stw	r0,0(r3)
 
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
@@ -155,14 +155,14 @@ err2;	ld	r9,32(r4)
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
@@ -172,28 +172,28 @@ err2;	std	r9,32(r3)
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
@@ -404,14 +404,14 @@ err3;	stvx	v0,r3,r11
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
 
@@ -426,24 +426,24 @@ err4;	lvx	v6,r4,r9
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
 err4;	stvx	v7,0,r3
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
@@ -589,14 +589,14 @@ err3;	stvx	v11,r3,r11
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
 
@@ -616,11 +616,11 @@ err4;	lvx	v4,r4,r11
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
 err4;	stvx	v8,0,r3
@@ -628,15 +628,15 @@ err4;	stvx	v9,r3,r9
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
index 193909abd18b..dd679a0fa650 100644
--- a/arch/powerpc/lib/memcpy_power7.S
+++ b/arch/powerpc/lib/memcpy_power7.S
@@ -75,7 +75,6 @@ _GLOBAL(memcpy_power7)
 
 	mflr	r0
 	stdu	r1,-STACKFRAMESIZE(r1)
-	std	r14,STK_REG(R14)(r1)
 	std	r15,STK_REG(R15)(r1)
 	std	r16,STK_REG(R16)(r1)
 	std	r17,STK_REG(R17)(r1)
@@ -84,6 +83,7 @@ _GLOBAL(memcpy_power7)
 	std	r20,STK_REG(R20)(r1)
 	std	r21,STK_REG(R21)(r1)
 	std	r22,STK_REG(R22)(r1)
+	std	r23,STK_REG(R23)(r1)
 	std	r0,STACKFRAMESIZE+16(r1)
 
 	srdi	r6,r5,7
@@ -100,14 +100,14 @@ _GLOBAL(memcpy_power7)
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
@@ -117,20 +117,19 @@ _GLOBAL(memcpy_power7)
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
@@ -139,6 +138,7 @@ _GLOBAL(memcpy_power7)
 	ld	r20,STK_REG(R20)(r1)
 	ld	r21,STK_REG(R21)(r1)
 	ld	r22,STK_REG(R22)(r1)
+	ld	r23,STK_REG(R23)(r1)
 	addi	r1,r1,STACKFRAMESIZE
 
 	/* Up to 127B to go */
@@ -349,14 +349,14 @@ _GLOBAL(memcpy_power7)
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
 
@@ -371,24 +371,24 @@ _GLOBAL(memcpy_power7)
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
 	stvx	v7,0,r3
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
@@ -535,14 +535,14 @@ _GLOBAL(memcpy_power7)
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
 
@@ -562,11 +562,11 @@ _GLOBAL(memcpy_power7)
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
 	stvx	v8,0,r3
@@ -574,15 +574,15 @@ _GLOBAL(memcpy_power7)
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
-- 
2.15.0
