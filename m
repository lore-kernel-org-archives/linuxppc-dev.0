Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 25F371A0281
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 09:51:26 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org
Subject: [PATCH 1/2] powerpc: Change vrX register defines to vX to match gcc
 and glibc
Date: Tue, 10 Feb 2015 09:51:22 +1100
Message-Id: <1423522283-29397-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As our various loops (copy, string, crypto etc) get more complicated,
we want to share implementations between userspace (eg glibc) and
the kernel. We also want to write userspace test harnesses to put
in tools/testing/selftest.

One gratuitous difference between userspace and the kernel is the
VMX register definitions - the kernel uses vrX whereas both gcc and
glibc use vX.

Change the kernel to match userspace.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/ppc_asm.h                 |  64 +++---
 arch/powerpc/include/uapi/asm/ptrace.h             |   2 +-
 arch/powerpc/kernel/tm.S                           |   8 +-
 arch/powerpc/kernel/vector.S                       |  24 +--
 arch/powerpc/lib/copypage_power7.S                 |  32 +--
 arch/powerpc/lib/copyuser_power7.S                 | 226 ++++++++++-----------
 arch/powerpc/lib/crtsavres.S                       |  96 ++++-----
 arch/powerpc/lib/ldstfp.S                          |  26 +--
 arch/powerpc/lib/memcpy_power7.S                   | 226 ++++++++++-----------
 .../selftests/powerpc/copyloops/asm/ppc_asm.h      |  33 ---
 10 files changed, 352 insertions(+), 385 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 7e46125..c746103 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -637,38 +637,38 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,945)
 
 /* AltiVec Registers (VPRs) */
 
-#define	vr0	0
-#define	vr1	1
-#define	vr2	2
-#define	vr3	3
-#define	vr4	4
-#define	vr5	5
-#define	vr6	6
-#define	vr7	7
-#define	vr8	8
-#define	vr9	9
-#define	vr10	10
-#define	vr11	11
-#define	vr12	12
-#define	vr13	13
-#define	vr14	14
-#define	vr15	15
-#define	vr16	16
-#define	vr17	17
-#define	vr18	18
-#define	vr19	19
-#define	vr20	20
-#define	vr21	21
-#define	vr22	22
-#define	vr23	23
-#define	vr24	24
-#define	vr25	25
-#define	vr26	26
-#define	vr27	27
-#define	vr28	28
-#define	vr29	29
-#define	vr30	30
-#define	vr31	31
+#define	v0	0
+#define	v1	1
+#define	v2	2
+#define	v3	3
+#define	v4	4
+#define	v5	5
+#define	v6	6
+#define	v7	7
+#define	v8	8
+#define	v9	9
+#define	v10	10
+#define	v11	11
+#define	v12	12
+#define	v13	13
+#define	v14	14
+#define	v15	15
+#define	v16	16
+#define	v17	17
+#define	v18	18
+#define	v19	19
+#define	v20	20
+#define	v21	21
+#define	v22	22
+#define	v23	23
+#define	v24	24
+#define	v25	25
+#define	v26	26
+#define	v27	27
+#define	v28	28
+#define	v29	29
+#define	v30	30
+#define	v31	31
 
 /* VSX Registers (VSRs) */
 
diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index 77d2ed3..8036b38 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -136,7 +136,7 @@ struct pt_regs {
 #endif /* __powerpc64__ */
 
 /*
- * Get/set all the altivec registers vr0..vr31, vscr, vrsave, in one go.
+ * Get/set all the altivec registers v0..v31, vscr, vrsave, in one go.
  * The transfer totals 34 quadword.  Quadwords 0-31 contain the
  * corresponding vector registers.  Quadword 32 contains the vscr as the
  * last word (offset 12) within that quadword.  Quadword 33 contains the
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 2a324f4..5754b22 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -152,9 +152,9 @@ _GLOBAL(tm_reclaim)
 
 	addi	r7, r3, THREAD_TRANSACT_VRSTATE
 	SAVE_32VRS(0, r6, r7)	/* r6 scratch, r7 transact vr state */
-	mfvscr	vr0
+	mfvscr	v0
 	li	r6, VRSTATE_VSCR
-	stvx	vr0, r7, r6
+	stvx	v0, r7, r6
 dont_backup_vec:
 	mfspr	r0, SPRN_VRSAVE
 	std	r0, THREAD_TRANSACT_VRSAVE(r3)
@@ -359,8 +359,8 @@ _GLOBAL(__tm_recheckpoint)
 
 	addi	r8, r3, THREAD_VRSTATE
 	li	r5, VRSTATE_VSCR
-	lvx	vr0, r8, r5
-	mtvscr	vr0
+	lvx	v0, r8, r5
+	mtvscr	v0
 	REST_32VRS(0, r5, r8)			/* r5 scratch, r8 ptr */
 dont_restore_vec:
 	ld	r5, THREAD_VRSAVE(r3)
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index 74f8050..f5c80d5 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -24,8 +24,8 @@ _GLOBAL(do_load_up_transact_altivec)
 	stw	r4,THREAD_USED_VR(r3)
 
 	li	r10,THREAD_TRANSACT_VRSTATE+VRSTATE_VSCR
-	lvx	vr0,r10,r3
-	mtvscr	vr0
+	lvx	v0,r10,r3
+	mtvscr	v0
 	addi	r10,r3,THREAD_TRANSACT_VRSTATE
 	REST_32VRS(0,r4,r10)
 
@@ -52,8 +52,8 @@ _GLOBAL(vec_enable)
  */
 _GLOBAL(load_vr_state)
 	li	r4,VRSTATE_VSCR
-	lvx	vr0,r4,r3
-	mtvscr	vr0
+	lvx	v0,r4,r3
+	mtvscr	v0
 	REST_32VRS(0,r4,r3)
 	blr
 
@@ -63,9 +63,9 @@ _GLOBAL(load_vr_state)
  */
 _GLOBAL(store_vr_state)
 	SAVE_32VRS(0, r4, r3)
-	mfvscr	vr0
+	mfvscr	v0
 	li	r4, VRSTATE_VSCR
-	stvx	vr0, r4, r3
+	stvx	v0, r4, r3
 	blr
 
 /*
@@ -104,9 +104,9 @@ _GLOBAL(load_up_altivec)
 	addi	r4,r4,THREAD
 	addi	r6,r4,THREAD_VRSTATE
 	SAVE_32VRS(0,r5,r6)
-	mfvscr	vr0
+	mfvscr	v0
 	li	r10,VRSTATE_VSCR
-	stvx	vr0,r10,r6
+	stvx	v0,r10,r6
 	/* Disable VMX for last_task_used_altivec */
 	PPC_LL	r5,PT_REGS(r4)
 	toreal(r5)
@@ -142,8 +142,8 @@ _GLOBAL(load_up_altivec)
 	li	r4,1
 	li	r10,VRSTATE_VSCR
 	stw	r4,THREAD_USED_VR(r5)
-	lvx	vr0,r10,r6
-	mtvscr	vr0
+	lvx	v0,r10,r6
+	mtvscr	v0
 	REST_32VRS(0,r4,r6)
 #ifndef CONFIG_SMP
 	/* Update last_task_used_altivec to 'current' */
@@ -186,9 +186,9 @@ _GLOBAL(giveup_altivec)
 	addi	r7,r3,THREAD_VRSTATE
 2:	PPC_LCMPI	0,r5,0
 	SAVE_32VRS(0,r4,r7)
-	mfvscr	vr0
+	mfvscr	v0
 	li	r4,VRSTATE_VSCR
-	stvx	vr0,r4,r7
+	stvx	v0,r4,r7
 	beq	1f
 	PPC_LL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 #ifdef CONFIG_VSX
diff --git a/arch/powerpc/lib/copypage_power7.S b/arch/powerpc/lib/copypage_power7.S
index d7dafb3..a84d333 100644
--- a/arch/powerpc/lib/copypage_power7.S
+++ b/arch/powerpc/lib/copypage_power7.S
@@ -83,23 +83,23 @@ _GLOBAL(copypage_power7)
 	li	r12,112
 
 	.align	5
-1:	lvx	vr7,r0,r4
-	lvx	vr6,r4,r6
-	lvx	vr5,r4,r7
-	lvx	vr4,r4,r8
-	lvx	vr3,r4,r9
-	lvx	vr2,r4,r10
-	lvx	vr1,r4,r11
-	lvx	vr0,r4,r12
+1:	lvx	v7,r0,r4
+	lvx	v6,r4,r6
+	lvx	v5,r4,r7
+	lvx	v4,r4,r8
+	lvx	v3,r4,r9
+	lvx	v2,r4,r10
+	lvx	v1,r4,r11
+	lvx	v0,r4,r12
 	addi	r4,r4,128
-	stvx	vr7,r0,r3
-	stvx	vr6,r3,r6
-	stvx	vr5,r3,r7
-	stvx	vr4,r3,r8
-	stvx	vr3,r3,r9
-	stvx	vr2,r3,r10
-	stvx	vr1,r3,r11
-	stvx	vr0,r3,r12
+	stvx	v7,r0,r3
+	stvx	v6,r3,r6
+	stvx	v5,r3,r7
+	stvx	v4,r3,r8
+	stvx	v3,r3,r9
+	stvx	v2,r3,r10
+	stvx	v1,r3,r11
+	stvx	v0,r3,r12
 	addi	r3,r3,128
 	bdnz	1b
 
diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser_power7.S
index 92ee840..da0c568 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -388,29 +388,29 @@ err3;	std	r0,0(r3)
 	li	r11,48
 
 	bf	cr7*4+3,5f
-err3;	lvx	vr1,r0,r4
+err3;	lvx	v1,r0,r4
 	addi	r4,r4,16
-err3;	stvx	vr1,r0,r3
+err3;	stvx	v1,r0,r3
 	addi	r3,r3,16
 
 5:	bf	cr7*4+2,6f
-err3;	lvx	vr1,r0,r4
-err3;	lvx	vr0,r4,r9
+err3;	lvx	v1,r0,r4
+err3;	lvx	v0,r4,r9
 	addi	r4,r4,32
-err3;	stvx	vr1,r0,r3
-err3;	stvx	vr0,r3,r9
+err3;	stvx	v1,r0,r3
+err3;	stvx	v0,r3,r9
 	addi	r3,r3,32
 
 6:	bf	cr7*4+1,7f
-err3;	lvx	vr3,r0,r4
-err3;	lvx	vr2,r4,r9
-err3;	lvx	vr1,r4,r10
-err3;	lvx	vr0,r4,r11
+err3;	lvx	v3,r0,r4
+err3;	lvx	v2,r4,r9
+err3;	lvx	v1,r4,r10
+err3;	lvx	v0,r4,r11
 	addi	r4,r4,64
-err3;	stvx	vr3,r0,r3
-err3;	stvx	vr2,r3,r9
-err3;	stvx	vr1,r3,r10
-err3;	stvx	vr0,r3,r11
+err3;	stvx	v3,r0,r3
+err3;	stvx	v2,r3,r9
+err3;	stvx	v1,r3,r10
+err3;	stvx	v0,r3,r11
 	addi	r3,r3,64
 
 7:	sub	r5,r5,r6
@@ -433,23 +433,23 @@ err3;	stvx	vr0,r3,r11
 	 */
 	.align	5
 8:
-err4;	lvx	vr7,r0,r4
-err4;	lvx	vr6,r4,r9
-err4;	lvx	vr5,r4,r10
-err4;	lvx	vr4,r4,r11
-err4;	lvx	vr3,r4,r12
-err4;	lvx	vr2,r4,r14
-err4;	lvx	vr1,r4,r15
-err4;	lvx	vr0,r4,r16
+err4;	lvx	v7,r0,r4
+err4;	lvx	v6,r4,r9
+err4;	lvx	v5,r4,r10
+err4;	lvx	v4,r4,r11
+err4;	lvx	v3,r4,r12
+err4;	lvx	v2,r4,r14
+err4;	lvx	v1,r4,r15
+err4;	lvx	v0,r4,r16
 	addi	r4,r4,128
-err4;	stvx	vr7,r0,r3
-err4;	stvx	vr6,r3,r9
-err4;	stvx	vr5,r3,r10
-err4;	stvx	vr4,r3,r11
-err4;	stvx	vr3,r3,r12
-err4;	stvx	vr2,r3,r14
-err4;	stvx	vr1,r3,r15
-err4;	stvx	vr0,r3,r16
+err4;	stvx	v7,r0,r3
+err4;	stvx	v6,r3,r9
+err4;	stvx	v5,r3,r10
+err4;	stvx	v4,r3,r11
+err4;	stvx	v3,r3,r12
+err4;	stvx	v2,r3,r14
+err4;	stvx	v1,r3,r15
+err4;	stvx	v0,r3,r16
 	addi	r3,r3,128
 	bdnz	8b
 
@@ -463,29 +463,29 @@ err4;	stvx	vr0,r3,r16
 	mtocrf	0x01,r6
 
 	bf	cr7*4+1,9f
-err3;	lvx	vr3,r0,r4
-err3;	lvx	vr2,r4,r9
-err3;	lvx	vr1,r4,r10
-err3;	lvx	vr0,r4,r11
+err3;	lvx	v3,r0,r4
+err3;	lvx	v2,r4,r9
+err3;	lvx	v1,r4,r10
+err3;	lvx	v0,r4,r11
 	addi	r4,r4,64
-err3;	stvx	vr3,r0,r3
-err3;	stvx	vr2,r3,r9
-err3;	stvx	vr1,r3,r10
-err3;	stvx	vr0,r3,r11
+err3;	stvx	v3,r0,r3
+err3;	stvx	v2,r3,r9
+err3;	stvx	v1,r3,r10
+err3;	stvx	v0,r3,r11
 	addi	r3,r3,64
 
 9:	bf	cr7*4+2,10f
-err3;	lvx	vr1,r0,r4
-err3;	lvx	vr0,r4,r9
+err3;	lvx	v1,r0,r4
+err3;	lvx	v0,r4,r9
 	addi	r4,r4,32
-err3;	stvx	vr1,r0,r3
-err3;	stvx	vr0,r3,r9
+err3;	stvx	v1,r0,r3
+err3;	stvx	v0,r3,r9
 	addi	r3,r3,32
 
 10:	bf	cr7*4+3,11f
-err3;	lvx	vr1,r0,r4
+err3;	lvx	v1,r0,r4
 	addi	r4,r4,16
-err3;	stvx	vr1,r0,r3
+err3;	stvx	v1,r0,r3
 	addi	r3,r3,16
 
 	/* Up to 15B to go */
@@ -560,42 +560,42 @@ err3;	stw	r7,4(r3)
 	li	r10,32
 	li	r11,48
 
-	LVS(vr16,0,r4)		/* Setup permute control vector */
-err3;	lvx	vr0,0,r4
+	LVS(v16,0,r4)		/* Setup permute control vector */
+err3;	lvx	v0,0,r4
 	addi	r4,r4,16
 
 	bf	cr7*4+3,5f
-err3;	lvx	vr1,r0,r4
-	VPERM(vr8,vr0,vr1,vr16)
+err3;	lvx	v1,r0,r4
+	VPERM(v8,v0,v1,v16)
 	addi	r4,r4,16
-err3;	stvx	vr8,r0,r3
+err3;	stvx	v8,r0,r3
 	addi	r3,r3,16
-	vor	vr0,vr1,vr1
+	vor	v0,v1,v1
 
 5:	bf	cr7*4+2,6f
-err3;	lvx	vr1,r0,r4
-	VPERM(vr8,vr0,vr1,vr16)
-err3;	lvx	vr0,r4,r9
-	VPERM(vr9,vr1,vr0,vr16)
+err3;	lvx	v1,r0,r4
+	VPERM(v8,v0,v1,v16)
+err3;	lvx	v0,r4,r9
+	VPERM(v9,v1,v0,v16)
 	addi	r4,r4,32
-err3;	stvx	vr8,r0,r3
-err3;	stvx	vr9,r3,r9
+err3;	stvx	v8,r0,r3
+err3;	stvx	v9,r3,r9
 	addi	r3,r3,32
 
 6:	bf	cr7*4+1,7f
-err3;	lvx	vr3,r0,r4
-	VPERM(vr8,vr0,vr3,vr16)
-err3;	lvx	vr2,r4,r9
-	VPERM(vr9,vr3,vr2,vr16)
-err3;	lvx	vr1,r4,r10
-	VPERM(vr10,vr2,vr1,vr16)
-err3;	lvx	vr0,r4,r11
-	VPERM(vr11,vr1,vr0,vr16)
+err3;	lvx	v3,r0,r4
+	VPERM(v8,v0,v3,v16)
+err3;	lvx	v2,r4,r9
+	VPERM(v9,v3,v2,v16)
+err3;	lvx	v1,r4,r10
+	VPERM(v10,v2,v1,v16)
+err3;	lvx	v0,r4,r11
+	VPERM(v11,v1,v0,v16)
 	addi	r4,r4,64
-err3;	stvx	vr8,r0,r3
-err3;	stvx	vr9,r3,r9
-err3;	stvx	vr10,r3,r10
-err3;	stvx	vr11,r3,r11
+err3;	stvx	v8,r0,r3
+err3;	stvx	v9,r3,r9
+err3;	stvx	v10,r3,r10
+err3;	stvx	v11,r3,r11
 	addi	r3,r3,64
 
 7:	sub	r5,r5,r6
@@ -618,31 +618,31 @@ err3;	stvx	vr11,r3,r11
 	 */
 	.align	5
 8:
-err4;	lvx	vr7,r0,r4
-	VPERM(vr8,vr0,vr7,vr16)
-err4;	lvx	vr6,r4,r9
-	VPERM(vr9,vr7,vr6,vr16)
-err4;	lvx	vr5,r4,r10
-	VPERM(vr10,vr6,vr5,vr16)
-err4;	lvx	vr4,r4,r11
-	VPERM(vr11,vr5,vr4,vr16)
-err4;	lvx	vr3,r4,r12
-	VPERM(vr12,vr4,vr3,vr16)
-err4;	lvx	vr2,r4,r14
-	VPERM(vr13,vr3,vr2,vr16)
-err4;	lvx	vr1,r4,r15
-	VPERM(vr14,vr2,vr1,vr16)
-err4;	lvx	vr0,r4,r16
-	VPERM(vr15,vr1,vr0,vr16)
+err4;	lvx	v7,r0,r4
+	VPERM(v8,v0,v7,v16)
+err4;	lvx	v6,r4,r9
+	VPERM(v9,v7,v6,v16)
+err4;	lvx	v5,r4,r10
+	VPERM(v10,v6,v5,v16)
+err4;	lvx	v4,r4,r11
+	VPERM(v11,v5,v4,v16)
+err4;	lvx	v3,r4,r12
+	VPERM(v12,v4,v3,v16)
+err4;	lvx	v2,r4,r14
+	VPERM(v13,v3,v2,v16)
+err4;	lvx	v1,r4,r15
+	VPERM(v14,v2,v1,v16)
+err4;	lvx	v0,r4,r16
+	VPERM(v15,v1,v0,v16)
 	addi	r4,r4,128
-err4;	stvx	vr8,r0,r3
-err4;	stvx	vr9,r3,r9
-err4;	stvx	vr10,r3,r10
-err4;	stvx	vr11,r3,r11
-err4;	stvx	vr12,r3,r12
-err4;	stvx	vr13,r3,r14
-err4;	stvx	vr14,r3,r15
-err4;	stvx	vr15,r3,r16
+err4;	stvx	v8,r0,r3
+err4;	stvx	v9,r3,r9
+err4;	stvx	v10,r3,r10
+err4;	stvx	v11,r3,r11
+err4;	stvx	v12,r3,r12
+err4;	stvx	v13,r3,r14
+err4;	stvx	v14,r3,r15
+err4;	stvx	v15,r3,r16
 	addi	r3,r3,128
 	bdnz	8b
 
@@ -656,36 +656,36 @@ err4;	stvx	vr15,r3,r16
 	mtocrf	0x01,r6
 
 	bf	cr7*4+1,9f
-err3;	lvx	vr3,r0,r4
-	VPERM(vr8,vr0,vr3,vr16)
-err3;	lvx	vr2,r4,r9
-	VPERM(vr9,vr3,vr2,vr16)
-err3;	lvx	vr1,r4,r10
-	VPERM(vr10,vr2,vr1,vr16)
-err3;	lvx	vr0,r4,r11
-	VPERM(vr11,vr1,vr0,vr16)
+err3;	lvx	v3,r0,r4
+	VPERM(v8,v0,v3,v16)
+err3;	lvx	v2,r4,r9
+	VPERM(v9,v3,v2,v16)
+err3;	lvx	v1,r4,r10
+	VPERM(v10,v2,v1,v16)
+err3;	lvx	v0,r4,r11
+	VPERM(v11,v1,v0,v16)
 	addi	r4,r4,64
-err3;	stvx	vr8,r0,r3
-err3;	stvx	vr9,r3,r9
-err3;	stvx	vr10,r3,r10
-err3;	stvx	vr11,r3,r11
+err3;	stvx	v8,r0,r3
+err3;	stvx	v9,r3,r9
+err3;	stvx	v10,r3,r10
+err3;	stvx	v11,r3,r11
 	addi	r3,r3,64
 
 9:	bf	cr7*4+2,10f
-err3;	lvx	vr1,r0,r4
-	VPERM(vr8,vr0,vr1,vr16)
-err3;	lvx	vr0,r4,r9
-	VPERM(vr9,vr1,vr0,vr16)
+err3;	lvx	v1,r0,r4
+	VPERM(v8,v0,v1,v16)
+err3;	lvx	v0,r4,r9
+	VPERM(v9,v1,v0,v16)
 	addi	r4,r4,32
-err3;	stvx	vr8,r0,r3
-err3;	stvx	vr9,r3,r9
+err3;	stvx	v8,r0,r3
+err3;	stvx	v9,r3,r9
 	addi	r3,r3,32
 
 10:	bf	cr7*4+3,11f
-err3;	lvx	vr1,r0,r4
-	VPERM(vr8,vr0,vr1,vr16)
+err3;	lvx	v1,r0,r4
+	VPERM(v8,v0,v1,v16)
 	addi	r4,r4,16
-err3;	stvx	vr8,r0,r3
+err3;	stvx	v8,r0,r3
 	addi	r3,r3,16
 
 	/* Up to 15B to go */
diff --git a/arch/powerpc/lib/crtsavres.S b/arch/powerpc/lib/crtsavres.S
index a5b30c7..18af0b3 100644
--- a/arch/powerpc/lib/crtsavres.S
+++ b/arch/powerpc/lib/crtsavres.S
@@ -236,78 +236,78 @@ _GLOBAL(_rest32gpr_31_x)
 
 _GLOBAL(_savevr_20)
 	li	r11,-192
-	stvx	vr20,r11,r0
+	stvx	v20,r11,r0
 _GLOBAL(_savevr_21)
 	li	r11,-176
-	stvx	vr21,r11,r0
+	stvx	v21,r11,r0
 _GLOBAL(_savevr_22)
 	li	r11,-160
-	stvx	vr22,r11,r0
+	stvx	v22,r11,r0
 _GLOBAL(_savevr_23)
 	li	r11,-144
-	stvx	vr23,r11,r0
+	stvx	v23,r11,r0
 _GLOBAL(_savevr_24)
 	li	r11,-128
-	stvx	vr24,r11,r0
+	stvx	v24,r11,r0
 _GLOBAL(_savevr_25)
 	li	r11,-112
-	stvx	vr25,r11,r0
+	stvx	v25,r11,r0
 _GLOBAL(_savevr_26)
 	li	r11,-96
-	stvx	vr26,r11,r0
+	stvx	v26,r11,r0
 _GLOBAL(_savevr_27)
 	li	r11,-80
-	stvx	vr27,r11,r0
+	stvx	v27,r11,r0
 _GLOBAL(_savevr_28)
 	li	r11,-64
-	stvx	vr28,r11,r0
+	stvx	v28,r11,r0
 _GLOBAL(_savevr_29)
 	li	r11,-48
-	stvx	vr29,r11,r0
+	stvx	v29,r11,r0
 _GLOBAL(_savevr_30)
 	li	r11,-32
-	stvx	vr30,r11,r0
+	stvx	v30,r11,r0
 _GLOBAL(_savevr_31)
 	li	r11,-16
-	stvx	vr31,r11,r0
+	stvx	v31,r11,r0
 	blr
 
 _GLOBAL(_restvr_20)
 	li	r11,-192
-	lvx	vr20,r11,r0
+	lvx	v20,r11,r0
 _GLOBAL(_restvr_21)
 	li	r11,-176
-	lvx	vr21,r11,r0
+	lvx	v21,r11,r0
 _GLOBAL(_restvr_22)
 	li	r11,-160
-	lvx	vr22,r11,r0
+	lvx	v22,r11,r0
 _GLOBAL(_restvr_23)
 	li	r11,-144
-	lvx	vr23,r11,r0
+	lvx	v23,r11,r0
 _GLOBAL(_restvr_24)
 	li	r11,-128
-	lvx	vr24,r11,r0
+	lvx	v24,r11,r0
 _GLOBAL(_restvr_25)
 	li	r11,-112
-	lvx	vr25,r11,r0
+	lvx	v25,r11,r0
 _GLOBAL(_restvr_26)
 	li	r11,-96
-	lvx	vr26,r11,r0
+	lvx	v26,r11,r0
 _GLOBAL(_restvr_27)
 	li	r11,-80
-	lvx	vr27,r11,r0
+	lvx	v27,r11,r0
 _GLOBAL(_restvr_28)
 	li	r11,-64
-	lvx	vr28,r11,r0
+	lvx	v28,r11,r0
 _GLOBAL(_restvr_29)
 	li	r11,-48
-	lvx	vr29,r11,r0
+	lvx	v29,r11,r0
 _GLOBAL(_restvr_30)
 	li	r11,-32
-	lvx	vr30,r11,r0
+	lvx	v30,r11,r0
 _GLOBAL(_restvr_31)
 	li	r11,-16
-	lvx	vr31,r11,r0
+	lvx	v31,r11,r0
 	blr
 
 #endif /* CONFIG_ALTIVEC */
@@ -443,101 +443,101 @@ _restgpr0_31:
 .globl	_savevr_20
 _savevr_20:
 	li	r12,-192
-	stvx	vr20,r12,r0
+	stvx	v20,r12,r0
 .globl	_savevr_21
 _savevr_21:
 	li	r12,-176
-	stvx	vr21,r12,r0
+	stvx	v21,r12,r0
 .globl	_savevr_22
 _savevr_22:
 	li	r12,-160
-	stvx	vr22,r12,r0
+	stvx	v22,r12,r0
 .globl	_savevr_23
 _savevr_23:
 	li	r12,-144
-	stvx	vr23,r12,r0
+	stvx	v23,r12,r0
 .globl	_savevr_24
 _savevr_24:
 	li	r12,-128
-	stvx	vr24,r12,r0
+	stvx	v24,r12,r0
 .globl	_savevr_25
 _savevr_25:
 	li	r12,-112
-	stvx	vr25,r12,r0
+	stvx	v25,r12,r0
 .globl	_savevr_26
 _savevr_26:
 	li	r12,-96
-	stvx	vr26,r12,r0
+	stvx	v26,r12,r0
 .globl	_savevr_27
 _savevr_27:
 	li	r12,-80
-	stvx	vr27,r12,r0
+	stvx	v27,r12,r0
 .globl	_savevr_28
 _savevr_28:
 	li	r12,-64
-	stvx	vr28,r12,r0
+	stvx	v28,r12,r0
 .globl	_savevr_29
 _savevr_29:
 	li	r12,-48
-	stvx	vr29,r12,r0
+	stvx	v29,r12,r0
 .globl	_savevr_30
 _savevr_30:
 	li	r12,-32
-	stvx	vr30,r12,r0
+	stvx	v30,r12,r0
 .globl	_savevr_31
 _savevr_31:
 	li	r12,-16
-	stvx	vr31,r12,r0
+	stvx	v31,r12,r0
 	blr
 
 .globl	_restvr_20
 _restvr_20:
 	li	r12,-192
-	lvx	vr20,r12,r0
+	lvx	v20,r12,r0
 .globl	_restvr_21
 _restvr_21:
 	li	r12,-176
-	lvx	vr21,r12,r0
+	lvx	v21,r12,r0
 .globl	_restvr_22
 _restvr_22:
 	li	r12,-160
-	lvx	vr22,r12,r0
+	lvx	v22,r12,r0
 .globl	_restvr_23
 _restvr_23:
 	li	r12,-144
-	lvx	vr23,r12,r0
+	lvx	v23,r12,r0
 .globl	_restvr_24
 _restvr_24:
 	li	r12,-128
-	lvx	vr24,r12,r0
+	lvx	v24,r12,r0
 .globl	_restvr_25
 _restvr_25:
 	li	r12,-112
-	lvx	vr25,r12,r0
+	lvx	v25,r12,r0
 .globl	_restvr_26
 _restvr_26:
 	li	r12,-96
-	lvx	vr26,r12,r0
+	lvx	v26,r12,r0
 .globl	_restvr_27
 _restvr_27:
 	li	r12,-80
-	lvx	vr27,r12,r0
+	lvx	v27,r12,r0
 .globl	_restvr_28
 _restvr_28:
 	li	r12,-64
-	lvx	vr28,r12,r0
+	lvx	v28,r12,r0
 .globl	_restvr_29
 _restvr_29:
 	li	r12,-48
-	lvx	vr29,r12,r0
+	lvx	v29,r12,r0
 .globl	_restvr_30
 _restvr_30:
 	li	r12,-32
-	lvx	vr30,r12,r0
+	lvx	v30,r12,r0
 .globl	_restvr_31
 _restvr_31:
 	li	r12,-16
-	lvx	vr31,r12,r0
+	lvx	v31,r12,r0
 	blr
 
 #endif /* CONFIG_ALTIVEC */
diff --git a/arch/powerpc/lib/ldstfp.S b/arch/powerpc/lib/ldstfp.S
index 85aec08..659c7ca 100644
--- a/arch/powerpc/lib/ldstfp.S
+++ b/arch/powerpc/lib/ldstfp.S
@@ -184,16 +184,16 @@ _GLOBAL(do_stfd)
 	extab	2b,3b
 
 #ifdef CONFIG_ALTIVEC
-/* Get the contents of vrN into vr0; N is in r3. */
+/* Get the contents of vrN into v0; N is in r3. */
 _GLOBAL(get_vr)
 	mflr	r0
 	rlwinm	r3,r3,3,0xf8
 	bcl	20,31,1f
-	blr			/* vr0 is already in vr0 */
+	blr			/* v0 is already in v0 */
 	nop
 reg = 1
 	.rept	31
-	vor	vr0,reg,reg	/* assembler doesn't know vmr? */
+	vor	v0,reg,reg	/* assembler doesn't know vmr? */
 	blr
 reg = reg + 1
 	.endr
@@ -203,16 +203,16 @@ reg = reg + 1
 	mtlr	r0
 	bctr
 
-/* Put the contents of vr0 into vrN; N is in r3. */
+/* Put the contents of v0 into vrN; N is in r3. */
 _GLOBAL(put_vr)
 	mflr	r0
 	rlwinm	r3,r3,3,0xf8
 	bcl	20,31,1f
-	blr			/* vr0 is already in vr0 */
+	blr			/* v0 is already in v0 */
 	nop
 reg = 1
 	.rept	31
-	vor	reg,vr0,vr0
+	vor	reg,v0,v0
 	blr
 reg = reg + 1
 	.endr
@@ -234,13 +234,13 @@ _GLOBAL(do_lvx)
 	MTMSRD(r7)
 	isync
 	beq	cr7,1f
-	stvx	vr0,r1,r8
+	stvx	v0,r1,r8
 1:	li	r9,-EFAULT
-2:	lvx	vr0,0,r4
+2:	lvx	v0,0,r4
 	li	r9,0
 3:	beq	cr7,4f
 	bl	put_vr
-	lvx	vr0,r1,r8
+	lvx	v0,r1,r8
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
 	MTMSRD(r6)
@@ -262,13 +262,13 @@ _GLOBAL(do_stvx)
 	MTMSRD(r7)
 	isync
 	beq	cr7,1f
-	stvx	vr0,r1,r8
+	stvx	v0,r1,r8
 	bl	get_vr
 1:	li	r9,-EFAULT
-2:	stvx	vr0,0,r4
+2:	stvx	v0,0,r4
 	li	r9,0
 3:	beq	cr7,4f
-	lvx	vr0,r1,r8
+	lvx	v0,r1,r8
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
 	MTMSRD(r6)
@@ -304,7 +304,7 @@ _GLOBAL(put_vsr)
 	mflr	r0
 	rlwinm	r3,r3,3,0x1f8
 	bcl	20,31,1f
-	blr			/* vr0 is already in vr0 */
+	blr			/* v0 is already in v0 */
 	nop
 reg = 1
 	.rept	63
diff --git a/arch/powerpc/lib/memcpy_power7.S b/arch/powerpc/lib/memcpy_power7.S
index 0830587..786234f 100644
--- a/arch/powerpc/lib/memcpy_power7.S
+++ b/arch/powerpc/lib/memcpy_power7.S
@@ -321,29 +321,29 @@ _GLOBAL(memcpy_power7)
 	li	r11,48
 
 	bf	cr7*4+3,5f
-	lvx	vr1,r0,r4
+	lvx	v1,r0,r4
 	addi	r4,r4,16
-	stvx	vr1,r0,r3
+	stvx	v1,r0,r3
 	addi	r3,r3,16
 
 5:	bf	cr7*4+2,6f
-	lvx	vr1,r0,r4
-	lvx	vr0,r4,r9
+	lvx	v1,r0,r4
+	lvx	v0,r4,r9
 	addi	r4,r4,32
-	stvx	vr1,r0,r3
-	stvx	vr0,r3,r9
+	stvx	v1,r0,r3
+	stvx	v0,r3,r9
 	addi	r3,r3,32
 
 6:	bf	cr7*4+1,7f
-	lvx	vr3,r0,r4
-	lvx	vr2,r4,r9
-	lvx	vr1,r4,r10
-	lvx	vr0,r4,r11
+	lvx	v3,r0,r4
+	lvx	v2,r4,r9
+	lvx	v1,r4,r10
+	lvx	v0,r4,r11
 	addi	r4,r4,64
-	stvx	vr3,r0,r3
-	stvx	vr2,r3,r9
-	stvx	vr1,r3,r10
-	stvx	vr0,r3,r11
+	stvx	v3,r0,r3
+	stvx	v2,r3,r9
+	stvx	v1,r3,r10
+	stvx	v0,r3,r11
 	addi	r3,r3,64
 
 7:	sub	r5,r5,r6
@@ -366,23 +366,23 @@ _GLOBAL(memcpy_power7)
 	 */
 	.align	5
 8:
-	lvx	vr7,r0,r4
-	lvx	vr6,r4,r9
-	lvx	vr5,r4,r10
-	lvx	vr4,r4,r11
-	lvx	vr3,r4,r12
-	lvx	vr2,r4,r14
-	lvx	vr1,r4,r15
-	lvx	vr0,r4,r16
+	lvx	v7,r0,r4
+	lvx	v6,r4,r9
+	lvx	v5,r4,r10
+	lvx	v4,r4,r11
+	lvx	v3,r4,r12
+	lvx	v2,r4,r14
+	lvx	v1,r4,r15
+	lvx	v0,r4,r16
 	addi	r4,r4,128
-	stvx	vr7,r0,r3
-	stvx	vr6,r3,r9
-	stvx	vr5,r3,r10
-	stvx	vr4,r3,r11
-	stvx	vr3,r3,r12
-	stvx	vr2,r3,r14
-	stvx	vr1,r3,r15
-	stvx	vr0,r3,r16
+	stvx	v7,r0,r3
+	stvx	v6,r3,r9
+	stvx	v5,r3,r10
+	stvx	v4,r3,r11
+	stvx	v3,r3,r12
+	stvx	v2,r3,r14
+	stvx	v1,r3,r15
+	stvx	v0,r3,r16
 	addi	r3,r3,128
 	bdnz	8b
 
@@ -396,29 +396,29 @@ _GLOBAL(memcpy_power7)
 	mtocrf	0x01,r6
 
 	bf	cr7*4+1,9f
-	lvx	vr3,r0,r4
-	lvx	vr2,r4,r9
-	lvx	vr1,r4,r10
-	lvx	vr0,r4,r11
+	lvx	v3,r0,r4
+	lvx	v2,r4,r9
+	lvx	v1,r4,r10
+	lvx	v0,r4,r11
 	addi	r4,r4,64
-	stvx	vr3,r0,r3
-	stvx	vr2,r3,r9
-	stvx	vr1,r3,r10
-	stvx	vr0,r3,r11
+	stvx	v3,r0,r3
+	stvx	v2,r3,r9
+	stvx	v1,r3,r10
+	stvx	v0,r3,r11
 	addi	r3,r3,64
 
 9:	bf	cr7*4+2,10f
-	lvx	vr1,r0,r4
-	lvx	vr0,r4,r9
+	lvx	v1,r0,r4
+	lvx	v0,r4,r9
 	addi	r4,r4,32
-	stvx	vr1,r0,r3
-	stvx	vr0,r3,r9
+	stvx	v1,r0,r3
+	stvx	v0,r3,r9
 	addi	r3,r3,32
 
 10:	bf	cr7*4+3,11f
-	lvx	vr1,r0,r4
+	lvx	v1,r0,r4
 	addi	r4,r4,16
-	stvx	vr1,r0,r3
+	stvx	v1,r0,r3
 	addi	r3,r3,16
 
 	/* Up to 15B to go */
@@ -494,42 +494,42 @@ _GLOBAL(memcpy_power7)
 	li	r10,32
 	li	r11,48
 
-	LVS(vr16,0,r4)		/* Setup permute control vector */
-	lvx	vr0,0,r4
+	LVS(v16,0,r4)		/* Setup permute control vector */
+	lvx	v0,0,r4
 	addi	r4,r4,16
 
 	bf	cr7*4+3,5f
-	lvx	vr1,r0,r4
-	VPERM(vr8,vr0,vr1,vr16)
+	lvx	v1,r0,r4
+	VPERM(v8,v0,v1,v16)
 	addi	r4,r4,16
-	stvx	vr8,r0,r3
+	stvx	v8,r0,r3
 	addi	r3,r3,16
-	vor	vr0,vr1,vr1
+	vor	v0,v1,v1
 
 5:	bf	cr7*4+2,6f
-	lvx	vr1,r0,r4
-	VPERM(vr8,vr0,vr1,vr16)
-	lvx	vr0,r4,r9
-	VPERM(vr9,vr1,vr0,vr16)
+	lvx	v1,r0,r4
+	VPERM(v8,v0,v1,v16)
+	lvx	v0,r4,r9
+	VPERM(v9,v1,v0,v16)
 	addi	r4,r4,32
-	stvx	vr8,r0,r3
-	stvx	vr9,r3,r9
+	stvx	v8,r0,r3
+	stvx	v9,r3,r9
 	addi	r3,r3,32
 
 6:	bf	cr7*4+1,7f
-	lvx	vr3,r0,r4
-	VPERM(vr8,vr0,vr3,vr16)
-	lvx	vr2,r4,r9
-	VPERM(vr9,vr3,vr2,vr16)
-	lvx	vr1,r4,r10
-	VPERM(vr10,vr2,vr1,vr16)
-	lvx	vr0,r4,r11
-	VPERM(vr11,vr1,vr0,vr16)
+	lvx	v3,r0,r4
+	VPERM(v8,v0,v3,v16)
+	lvx	v2,r4,r9
+	VPERM(v9,v3,v2,v16)
+	lvx	v1,r4,r10
+	VPERM(v10,v2,v1,v16)
+	lvx	v0,r4,r11
+	VPERM(v11,v1,v0,v16)
 	addi	r4,r4,64
-	stvx	vr8,r0,r3
-	stvx	vr9,r3,r9
-	stvx	vr10,r3,r10
-	stvx	vr11,r3,r11
+	stvx	v8,r0,r3
+	stvx	v9,r3,r9
+	stvx	v10,r3,r10
+	stvx	v11,r3,r11
 	addi	r3,r3,64
 
 7:	sub	r5,r5,r6
@@ -552,31 +552,31 @@ _GLOBAL(memcpy_power7)
 	 */
 	.align	5
 8:
-	lvx	vr7,r0,r4
-	VPERM(vr8,vr0,vr7,vr16)
-	lvx	vr6,r4,r9
-	VPERM(vr9,vr7,vr6,vr16)
-	lvx	vr5,r4,r10
-	VPERM(vr10,vr6,vr5,vr16)
-	lvx	vr4,r4,r11
-	VPERM(vr11,vr5,vr4,vr16)
-	lvx	vr3,r4,r12
-	VPERM(vr12,vr4,vr3,vr16)
-	lvx	vr2,r4,r14
-	VPERM(vr13,vr3,vr2,vr16)
-	lvx	vr1,r4,r15
-	VPERM(vr14,vr2,vr1,vr16)
-	lvx	vr0,r4,r16
-	VPERM(vr15,vr1,vr0,vr16)
+	lvx	v7,r0,r4
+	VPERM(v8,v0,v7,v16)
+	lvx	v6,r4,r9
+	VPERM(v9,v7,v6,v16)
+	lvx	v5,r4,r10
+	VPERM(v10,v6,v5,v16)
+	lvx	v4,r4,r11
+	VPERM(v11,v5,v4,v16)
+	lvx	v3,r4,r12
+	VPERM(v12,v4,v3,v16)
+	lvx	v2,r4,r14
+	VPERM(v13,v3,v2,v16)
+	lvx	v1,r4,r15
+	VPERM(v14,v2,v1,v16)
+	lvx	v0,r4,r16
+	VPERM(v15,v1,v0,v16)
 	addi	r4,r4,128
-	stvx	vr8,r0,r3
-	stvx	vr9,r3,r9
-	stvx	vr10,r3,r10
-	stvx	vr11,r3,r11
-	stvx	vr12,r3,r12
-	stvx	vr13,r3,r14
-	stvx	vr14,r3,r15
-	stvx	vr15,r3,r16
+	stvx	v8,r0,r3
+	stvx	v9,r3,r9
+	stvx	v10,r3,r10
+	stvx	v11,r3,r11
+	stvx	v12,r3,r12
+	stvx	v13,r3,r14
+	stvx	v14,r3,r15
+	stvx	v15,r3,r16
 	addi	r3,r3,128
 	bdnz	8b
 
@@ -590,36 +590,36 @@ _GLOBAL(memcpy_power7)
 	mtocrf	0x01,r6
 
 	bf	cr7*4+1,9f
-	lvx	vr3,r0,r4
-	VPERM(vr8,vr0,vr3,vr16)
-	lvx	vr2,r4,r9
-	VPERM(vr9,vr3,vr2,vr16)
-	lvx	vr1,r4,r10
-	VPERM(vr10,vr2,vr1,vr16)
-	lvx	vr0,r4,r11
-	VPERM(vr11,vr1,vr0,vr16)
+	lvx	v3,r0,r4
+	VPERM(v8,v0,v3,v16)
+	lvx	v2,r4,r9
+	VPERM(v9,v3,v2,v16)
+	lvx	v1,r4,r10
+	VPERM(v10,v2,v1,v16)
+	lvx	v0,r4,r11
+	VPERM(v11,v1,v0,v16)
 	addi	r4,r4,64
-	stvx	vr8,r0,r3
-	stvx	vr9,r3,r9
-	stvx	vr10,r3,r10
-	stvx	vr11,r3,r11
+	stvx	v8,r0,r3
+	stvx	v9,r3,r9
+	stvx	v10,r3,r10
+	stvx	v11,r3,r11
 	addi	r3,r3,64
 
 9:	bf	cr7*4+2,10f
-	lvx	vr1,r0,r4
-	VPERM(vr8,vr0,vr1,vr16)
-	lvx	vr0,r4,r9
-	VPERM(vr9,vr1,vr0,vr16)
+	lvx	v1,r0,r4
+	VPERM(v8,v0,v1,v16)
+	lvx	v0,r4,r9
+	VPERM(v9,v1,v0,v16)
 	addi	r4,r4,32
-	stvx	vr8,r0,r3
-	stvx	vr9,r3,r9
+	stvx	v8,r0,r3
+	stvx	v9,r3,r9
 	addi	r3,r3,32
 
 10:	bf	cr7*4+3,11f
-	lvx	vr1,r0,r4
-	VPERM(vr8,vr0,vr1,vr16)
+	lvx	v1,r0,r4
+	VPERM(v8,v0,v1,v16)
 	addi	r4,r4,16
-	stvx	vr8,r0,r3
+	stvx	v8,r0,r3
 	addi	r3,r3,16
 
 	/* Up to 15B to go */
diff --git a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
index d1dc374..50ae7d2 100644
--- a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
@@ -4,39 +4,6 @@
 
 #define r1	1
 
-#define vr0     0
-#define vr1     1
-#define vr2     2
-#define vr3     3
-#define vr4     4
-#define vr5     5
-#define vr6     6
-#define vr7     7
-#define vr8     8
-#define vr9     9
-#define vr10    10
-#define vr11    11
-#define vr12    12
-#define vr13    13
-#define vr14    14
-#define vr15    15
-#define vr16    16
-#define vr17    17
-#define vr18    18
-#define vr19    19
-#define vr20    20
-#define vr21    21
-#define vr22    22
-#define vr23    23
-#define vr24    24
-#define vr25    25
-#define vr26    26
-#define vr27    27
-#define vr28    28
-#define vr29    29
-#define vr30    30
-#define vr31    31
-
 #define R14 r14
 #define R15 r15
 #define R16 r16
-- 
2.1.0
