Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 08 Jun 2012 21:36:05 +1000
Subject: [PATCH 3/15] powerpc: fix usage of register macros getting ready for
 %r0 change
In-Reply-To: <1339155365.316308.981577666228.qpush@ale>
Message-Id: <20120608113605.6A59CD43B25@localhost.localdomain>
Cc: mikey@neuling.org, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@samba.org>, Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anything that uses a constructed instruction (ie. from ppc-opcode.h),
need to use the new R0 macro, as %r0 is not going to work.

Also convert usages of macros where we are just determining an offset
(usually for a load/store), like:
	std	r14,STK_REG(r14)(r1)
Can't use STK_REG(r14) as %r14 doesn't work in the STK_REG macro since
it's just calculating an offset.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kernel/cpu_setup_a2.S             |    6 
 arch/powerpc/kernel/fpu.S                      |    4 
 arch/powerpc/kernel/misc_64.S                  |    4 
 arch/powerpc/kvm/book3s_hv_rmhandlers.S        |  218 ++++++++++++-------------
 arch/powerpc/lib/checksum_64.S                 |   24 +-
 arch/powerpc/lib/copyuser_64.S                 |    6 
 arch/powerpc/lib/copyuser_power7.S             |   84 ++++-----
 arch/powerpc/lib/hweight_64.S                  |   14 -
 arch/powerpc/lib/ldstfp.S                      |   12 -
 arch/powerpc/lib/mem_64.S                      |    6 
 arch/powerpc/lib/memcpy_64.S                   |    6 
 arch/powerpc/mm/hash_low_64.S                  |  148 ++++++++--------
 arch/powerpc/mm/tlb_low_64e.S                  |   10 -
 arch/powerpc/mm/tlb_nohash_low.S               |    6 
 arch/powerpc/platforms/cell/beat_hvCall.S      |   26 +-
 arch/powerpc/platforms/powernv/opal-takeover.S |    8 
 arch/powerpc/platforms/powernv/opal-wrappers.S |    2 
 arch/powerpc/platforms/pseries/hvCall.S        |   72 ++++----
 18 files changed, 328 insertions(+), 328 deletions(-)

Index: clone3/arch/powerpc/kernel/cpu_setup_a2.S
===================================================================
--- clone3.orig/arch/powerpc/kernel/cpu_setup_a2.S
+++ clone3/arch/powerpc/kernel/cpu_setup_a2.S
@@ -100,19 +100,19 @@ _icswx_skip_guest:
 	lis	r4,(MMUCR0_TLBSEL_I|MMUCR0_ECL)@h
 	mtspr	SPRN_MMUCR0, r4
 	li	r4,A2_IERAT_SIZE-1
-	PPC_ERATWE(r4,r4,3)
+	PPC_ERATWE(R4,R4,3)
 
 	/* Now set the D-ERAT watermark to 31 */
 	lis	r4,(MMUCR0_TLBSEL_D|MMUCR0_ECL)@h
 	mtspr	SPRN_MMUCR0, r4
 	li	r4,A2_DERAT_SIZE-1
-	PPC_ERATWE(r4,r4,3)
+	PPC_ERATWE(R4,R4,3)
 
 	/* And invalidate the beast just in case. That won't get rid of
 	 * a bolted entry though it will be in LRU and so will go away eventually
 	 * but let's not bother for now
 	 */
-	PPC_ERATILX(0,0,0)
+	PPC_ERATILX(0,R0,R0)
 1:
 	blr
 
Index: clone3/arch/powerpc/kernel/fpu.S
===================================================================
--- clone3.orig/arch/powerpc/kernel/fpu.S
+++ clone3/arch/powerpc/kernel/fpu.S
@@ -106,7 +106,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 #endif
 	lfd	fr0,THREAD_FPSCR(r5)
 	MTFSF_L(fr0)
-	REST_32FPVSRS(0, r4, r5)
+	REST_32FPVSRS(0, R4, R5)
 #ifndef CONFIG_SMP
 	subi	r4,r5,THREAD
 	fromreal(r4)
@@ -140,7 +140,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	addi	r3,r3,THREAD	        /* want THREAD of task */
 	PPC_LL	r5,PT_REGS(r3)
 	PPC_LCMPI	0,r5,0
-	SAVE_32FPVSRS(0, r4 ,r3)
+	SAVE_32FPVSRS(0, R4 ,R3)
 	mffs	fr0
 	stfd	fr0,THREAD_FPSCR(r3)
 	beq	1f
Index: clone3/arch/powerpc/kernel/misc_64.S
===================================================================
--- clone3.orig/arch/powerpc/kernel/misc_64.S
+++ clone3/arch/powerpc/kernel/misc_64.S
@@ -314,7 +314,7 @@ _GLOBAL(real_205_readb)
 	mtmsrd	r0
 	sync
 	isync
-	LBZCIX(r3,0,r3)
+	LBZCIX(R3,0,R3)
 	isync
 	mtmsrd	r7
 	sync
@@ -329,7 +329,7 @@ _GLOBAL(real_205_writeb)
 	mtmsrd	r0
 	sync
 	isync
-	STBCIX(r3,0,r4)
+	STBCIX(R3,0,R4)
 	isync
 	mtmsrd	r7
 	sync
Index: clone3/arch/powerpc/kvm/book3s_hv_rmhandlers.S
===================================================================
--- clone3.orig/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ clone3/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -206,24 +206,24 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 	/* Load up FP, VMX and VSX registers */
 	bl	kvmppc_load_fp
 
-	ld	r14, VCPU_GPR(r14)(r4)
-	ld	r15, VCPU_GPR(r15)(r4)
-	ld	r16, VCPU_GPR(r16)(r4)
-	ld	r17, VCPU_GPR(r17)(r4)
-	ld	r18, VCPU_GPR(r18)(r4)
-	ld	r19, VCPU_GPR(r19)(r4)
-	ld	r20, VCPU_GPR(r20)(r4)
-	ld	r21, VCPU_GPR(r21)(r4)
-	ld	r22, VCPU_GPR(r22)(r4)
-	ld	r23, VCPU_GPR(r23)(r4)
-	ld	r24, VCPU_GPR(r24)(r4)
-	ld	r25, VCPU_GPR(r25)(r4)
-	ld	r26, VCPU_GPR(r26)(r4)
-	ld	r27, VCPU_GPR(r27)(r4)
-	ld	r28, VCPU_GPR(r28)(r4)
-	ld	r29, VCPU_GPR(r29)(r4)
-	ld	r30, VCPU_GPR(r30)(r4)
-	ld	r31, VCPU_GPR(r31)(r4)
+	ld	r14, VCPU_GPR(R14)(r4)
+	ld	r15, VCPU_GPR(R15)(r4)
+	ld	r16, VCPU_GPR(R16)(r4)
+	ld	r17, VCPU_GPR(R17)(r4)
+	ld	r18, VCPU_GPR(R18)(r4)
+	ld	r19, VCPU_GPR(R19)(r4)
+	ld	r20, VCPU_GPR(R20)(r4)
+	ld	r21, VCPU_GPR(R21)(r4)
+	ld	r22, VCPU_GPR(R22)(r4)
+	ld	r23, VCPU_GPR(R23)(r4)
+	ld	r24, VCPU_GPR(R24)(r4)
+	ld	r25, VCPU_GPR(R25)(r4)
+	ld	r26, VCPU_GPR(R26)(r4)
+	ld	r27, VCPU_GPR(R27)(r4)
+	ld	r28, VCPU_GPR(R28)(r4)
+	ld	r29, VCPU_GPR(R29)(r4)
+	ld	r30, VCPU_GPR(R30)(r4)
+	ld	r31, VCPU_GPR(R31)(r4)
 
 BEGIN_FTR_SECTION
 	/* Switch DSCR to guest value */
@@ -547,21 +547,21 @@ fast_guest_return:
 	mtlr	r5
 	mtcr	r6
 
-	ld	r0, VCPU_GPR(r0)(r4)
-	ld	r1, VCPU_GPR(r1)(r4)
-	ld	r2, VCPU_GPR(r2)(r4)
-	ld	r3, VCPU_GPR(r3)(r4)
-	ld	r5, VCPU_GPR(r5)(r4)
-	ld	r6, VCPU_GPR(r6)(r4)
-	ld	r7, VCPU_GPR(r7)(r4)
-	ld	r8, VCPU_GPR(r8)(r4)
-	ld	r9, VCPU_GPR(r9)(r4)
-	ld	r10, VCPU_GPR(r10)(r4)
-	ld	r11, VCPU_GPR(r11)(r4)
-	ld	r12, VCPU_GPR(r12)(r4)
-	ld	r13, VCPU_GPR(r13)(r4)
+	ld	r0, VCPU_GPR(R0)(r4)
+	ld	r1, VCPU_GPR(R1)(r4)
+	ld	r2, VCPU_GPR(R2)(r4)
+	ld	r3, VCPU_GPR(R3)(r4)
+	ld	r5, VCPU_GPR(R5)(r4)
+	ld	r6, VCPU_GPR(R6)(r4)
+	ld	r7, VCPU_GPR(R7)(r4)
+	ld	r8, VCPU_GPR(R8)(r4)
+	ld	r9, VCPU_GPR(R9)(r4)
+	ld	r10, VCPU_GPR(R10)(r4)
+	ld	r11, VCPU_GPR(R11)(r4)
+	ld	r12, VCPU_GPR(R12)(r4)
+	ld	r13, VCPU_GPR(R13)(r4)
 
-	ld	r4, VCPU_GPR(r4)(r4)
+	ld	r4, VCPU_GPR(R4)(r4)
 
 	hrfid
 	b	.
@@ -590,22 +590,22 @@ kvmppc_interrupt:
 
 	/* Save registers */
 
-	std	r0, VCPU_GPR(r0)(r9)
-	std	r1, VCPU_GPR(r1)(r9)
-	std	r2, VCPU_GPR(r2)(r9)
-	std	r3, VCPU_GPR(r3)(r9)
-	std	r4, VCPU_GPR(r4)(r9)
-	std	r5, VCPU_GPR(r5)(r9)
-	std	r6, VCPU_GPR(r6)(r9)
-	std	r7, VCPU_GPR(r7)(r9)
-	std	r8, VCPU_GPR(r8)(r9)
+	std	r0, VCPU_GPR(R0)(r9)
+	std	r1, VCPU_GPR(R1)(r9)
+	std	r2, VCPU_GPR(R2)(r9)
+	std	r3, VCPU_GPR(R3)(r9)
+	std	r4, VCPU_GPR(R4)(r9)
+	std	r5, VCPU_GPR(R5)(r9)
+	std	r6, VCPU_GPR(R6)(r9)
+	std	r7, VCPU_GPR(R7)(r9)
+	std	r8, VCPU_GPR(R8)(r9)
 	ld	r0, HSTATE_HOST_R2(r13)
-	std	r0, VCPU_GPR(r9)(r9)
-	std	r10, VCPU_GPR(r10)(r9)
-	std	r11, VCPU_GPR(r11)(r9)
+	std	r0, VCPU_GPR(R9)(r9)
+	std	r10, VCPU_GPR(R10)(r9)
+	std	r11, VCPU_GPR(R11)(r9)
 	ld	r3, HSTATE_SCRATCH0(r13)
 	lwz	r4, HSTATE_SCRATCH1(r13)
-	std	r3, VCPU_GPR(r12)(r9)
+	std	r3, VCPU_GPR(R12)(r9)
 	stw	r4, VCPU_CR(r9)
 
 	/* Restore R1/R2 so we can handle faults */
@@ -626,7 +626,7 @@ kvmppc_interrupt:
 
 	GET_SCRATCH0(r3)
 	mflr	r4
-	std	r3, VCPU_GPR(r13)(r9)
+	std	r3, VCPU_GPR(R13)(r9)
 	std	r4, VCPU_LR(r9)
 
 	/* Unset guest mode */
@@ -968,24 +968,24 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 
 	/* Save non-volatile GPRs */
-	std	r14, VCPU_GPR(r14)(r9)
-	std	r15, VCPU_GPR(r15)(r9)
-	std	r16, VCPU_GPR(r16)(r9)
-	std	r17, VCPU_GPR(r17)(r9)
-	std	r18, VCPU_GPR(r18)(r9)
-	std	r19, VCPU_GPR(r19)(r9)
-	std	r20, VCPU_GPR(r20)(r9)
-	std	r21, VCPU_GPR(r21)(r9)
-	std	r22, VCPU_GPR(r22)(r9)
-	std	r23, VCPU_GPR(r23)(r9)
-	std	r24, VCPU_GPR(r24)(r9)
-	std	r25, VCPU_GPR(r25)(r9)
-	std	r26, VCPU_GPR(r26)(r9)
-	std	r27, VCPU_GPR(r27)(r9)
-	std	r28, VCPU_GPR(r28)(r9)
-	std	r29, VCPU_GPR(r29)(r9)
-	std	r30, VCPU_GPR(r30)(r9)
-	std	r31, VCPU_GPR(r31)(r9)
+	std	r14, VCPU_GPR(R14)(r9)
+	std	r15, VCPU_GPR(R15)(r9)
+	std	r16, VCPU_GPR(R16)(r9)
+	std	r17, VCPU_GPR(R17)(r9)
+	std	r18, VCPU_GPR(R18)(r9)
+	std	r19, VCPU_GPR(R19)(r9)
+	std	r20, VCPU_GPR(R20)(r9)
+	std	r21, VCPU_GPR(R21)(r9)
+	std	r22, VCPU_GPR(R22)(r9)
+	std	r23, VCPU_GPR(R23)(r9)
+	std	r24, VCPU_GPR(R24)(r9)
+	std	r25, VCPU_GPR(R25)(r9)
+	std	r26, VCPU_GPR(R26)(r9)
+	std	r27, VCPU_GPR(R27)(r9)
+	std	r28, VCPU_GPR(R28)(r9)
+	std	r29, VCPU_GPR(R29)(r9)
+	std	r30, VCPU_GPR(R30)(r9)
+	std	r31, VCPU_GPR(R31)(r9)
 
 	/* Save SPRGs */
 	mfspr	r3, SPRN_SPRG0
@@ -1160,7 +1160,7 @@ kvmppc_hdsi:
 	andi.	r0, r11, MSR_DR		/* data relocation enabled? */
 	beq	3f
 	clrrdi	r0, r4, 28
-	PPC_SLBFEE_DOT(r5, r0)		/* if so, look up SLB */
+	PPC_SLBFEE_DOT(R5, R0)		/* if so, look up SLB */
 	bne	1f			/* if no SLB entry found */
 4:	std	r4, VCPU_FAULT_DAR(r9)
 	stw	r6, VCPU_FAULT_DSISR(r9)
@@ -1234,7 +1234,7 @@ kvmppc_hisi:
 	andi.	r0, r11, MSR_IR		/* instruction relocation enabled? */
 	beq	3f
 	clrrdi	r0, r10, 28
-	PPC_SLBFEE_DOT(r5, r0)		/* if so, look up SLB */
+	PPC_SLBFEE_DOT(R5, R0)		/* if so, look up SLB */
 	bne	1f			/* if no SLB entry found */
 4:
 	/* Search the hash table. */
@@ -1278,7 +1278,7 @@ kvmppc_hisi:
  */
 	.globl	hcall_try_real_mode
 hcall_try_real_mode:
-	ld	r3,VCPU_GPR(r3)(r9)
+	ld	r3,VCPU_GPR(R3)(r9)
 	andi.	r0,r11,MSR_PR
 	bne	hcall_real_cont
 	clrrdi	r3,r3,2
@@ -1291,12 +1291,12 @@ hcall_try_real_mode:
 	add	r3,r3,r4
 	mtctr	r3
 	mr	r3,r9		/* get vcpu pointer */
-	ld	r4,VCPU_GPR(r4)(r9)
+	ld	r4,VCPU_GPR(R4)(r9)
 	bctrl
 	cmpdi	r3,H_TOO_HARD
 	beq	hcall_real_fallback
 	ld	r4,HSTATE_KVM_VCPU(r13)
-	std	r3,VCPU_GPR(r3)(r4)
+	std	r3,VCPU_GPR(R3)(r4)
 	ld	r10,VCPU_PC(r4)
 	ld	r11,VCPU_MSR(r4)
 	b	fast_guest_return
@@ -1424,7 +1424,7 @@ _GLOBAL(kvmppc_h_cede)
 	li	r0,0		/* set trap to 0 to say hcall is handled */
 	stw	r0,VCPU_TRAP(r3)
 	li	r0,H_SUCCESS
-	std	r0,VCPU_GPR(r3)(r3)
+	std	r0,VCPU_GPR(R3)(r3)
 BEGIN_FTR_SECTION
 	b	2f		/* just send it up to host on 970 */
 END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_206)
@@ -1443,7 +1443,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_206)
 	addi	r6,r5,VCORE_NAPPING_THREADS
 31:	lwarx	r4,0,r6
 	or	r4,r4,r0
-	PPC_POPCNTW(r7,r4)
+	PPC_POPCNTW(R7,R4)
 	cmpw	r7,r8
 	bge	2f
 	stwcx.	r4,0,r6
@@ -1464,24 +1464,24 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_206)
  * DAR, DSISR, DABR, DABRX, DSCR, PMCx, MMCRx, SIAR, SDAR.
  */
 	/* Save non-volatile GPRs */
-	std	r14, VCPU_GPR(r14)(r3)
-	std	r15, VCPU_GPR(r15)(r3)
-	std	r16, VCPU_GPR(r16)(r3)
-	std	r17, VCPU_GPR(r17)(r3)
-	std	r18, VCPU_GPR(r18)(r3)
-	std	r19, VCPU_GPR(r19)(r3)
-	std	r20, VCPU_GPR(r20)(r3)
-	std	r21, VCPU_GPR(r21)(r3)
-	std	r22, VCPU_GPR(r22)(r3)
-	std	r23, VCPU_GPR(r23)(r3)
-	std	r24, VCPU_GPR(r24)(r3)
-	std	r25, VCPU_GPR(r25)(r3)
-	std	r26, VCPU_GPR(r26)(r3)
-	std	r27, VCPU_GPR(r27)(r3)
-	std	r28, VCPU_GPR(r28)(r3)
-	std	r29, VCPU_GPR(r29)(r3)
-	std	r30, VCPU_GPR(r30)(r3)
-	std	r31, VCPU_GPR(r31)(r3)
+	std	r14, VCPU_GPR(R14)(r3)
+	std	r15, VCPU_GPR(R15)(r3)
+	std	r16, VCPU_GPR(R16)(r3)
+	std	r17, VCPU_GPR(R17)(r3)
+	std	r18, VCPU_GPR(R18)(r3)
+	std	r19, VCPU_GPR(R19)(r3)
+	std	r20, VCPU_GPR(R20)(r3)
+	std	r21, VCPU_GPR(R21)(r3)
+	std	r22, VCPU_GPR(R22)(r3)
+	std	r23, VCPU_GPR(R23)(r3)
+	std	r24, VCPU_GPR(R24)(r3)
+	std	r25, VCPU_GPR(R25)(r3)
+	std	r26, VCPU_GPR(R26)(r3)
+	std	r27, VCPU_GPR(R27)(r3)
+	std	r28, VCPU_GPR(R28)(r3)
+	std	r29, VCPU_GPR(R29)(r3)
+	std	r30, VCPU_GPR(R30)(r3)
+	std	r31, VCPU_GPR(R31)(r3)
 
 	/* save FP state */
 	bl	.kvmppc_save_fp
@@ -1513,24 +1513,24 @@ kvm_end_cede:
 	bl	kvmppc_load_fp
 
 	/* Load NV GPRS */
-	ld	r14, VCPU_GPR(r14)(r4)
-	ld	r15, VCPU_GPR(r15)(r4)
-	ld	r16, VCPU_GPR(r16)(r4)
-	ld	r17, VCPU_GPR(r17)(r4)
-	ld	r18, VCPU_GPR(r18)(r4)
-	ld	r19, VCPU_GPR(r19)(r4)
-	ld	r20, VCPU_GPR(r20)(r4)
-	ld	r21, VCPU_GPR(r21)(r4)
-	ld	r22, VCPU_GPR(r22)(r4)
-	ld	r23, VCPU_GPR(r23)(r4)
-	ld	r24, VCPU_GPR(r24)(r4)
-	ld	r25, VCPU_GPR(r25)(r4)
-	ld	r26, VCPU_GPR(r26)(r4)
-	ld	r27, VCPU_GPR(r27)(r4)
-	ld	r28, VCPU_GPR(r28)(r4)
-	ld	r29, VCPU_GPR(r29)(r4)
-	ld	r30, VCPU_GPR(r30)(r4)
-	ld	r31, VCPU_GPR(r31)(r4)
+	ld	r14, VCPU_GPR(R14)(r4)
+	ld	r15, VCPU_GPR(R15)(r4)
+	ld	r16, VCPU_GPR(R16)(r4)
+	ld	r17, VCPU_GPR(R17)(r4)
+	ld	r18, VCPU_GPR(R18)(r4)
+	ld	r19, VCPU_GPR(R19)(r4)
+	ld	r20, VCPU_GPR(R20)(r4)
+	ld	r21, VCPU_GPR(R21)(r4)
+	ld	r22, VCPU_GPR(R22)(r4)
+	ld	r23, VCPU_GPR(R23)(r4)
+	ld	r24, VCPU_GPR(R24)(r4)
+	ld	r25, VCPU_GPR(R25)(r4)
+	ld	r26, VCPU_GPR(R26)(r4)
+	ld	r27, VCPU_GPR(R27)(r4)
+	ld	r28, VCPU_GPR(R28)(r4)
+	ld	r29, VCPU_GPR(R29)(r4)
+	ld	r30, VCPU_GPR(R30)(r4)
+	ld	r31, VCPU_GPR(R31)(r4)
 
 	/* clear our bit in vcore->napping_threads */
 33:	ld	r5,HSTATE_KVM_VCORE(r13)
@@ -1649,7 +1649,7 @@ BEGIN_FTR_SECTION
 	reg = 0
 	.rept	32
 	li	r6,reg*16+VCPU_VSRS
-	STXVD2X(reg,r6,r3)
+	STXVD2X(reg,R6,R3)
 	reg = reg + 1
 	.endr
 FTR_SECTION_ELSE
@@ -1711,7 +1711,7 @@ BEGIN_FTR_SECTION
 	reg = 0
 	.rept	32
 	li	r7,reg*16+VCPU_VSRS
-	LXVD2X(reg,r7,r4)
+	LXVD2X(reg,R7,R4)
 	reg = reg + 1
 	.endr
 FTR_SECTION_ELSE
Index: clone3/arch/powerpc/lib/checksum_64.S
===================================================================
--- clone3.orig/arch/powerpc/lib/checksum_64.S
+++ clone3/arch/powerpc/lib/checksum_64.S
@@ -114,9 +114,9 @@ _GLOBAL(csum_partial)
 	mtctr	r6
 
 	stdu	r1,-STACKFRAMESIZE(r1)
-	std	r14,STK_REG(r14)(r1)
-	std	r15,STK_REG(r15)(r1)
-	std	r16,STK_REG(r16)(r1)
+	std	r14,STK_REG(R14)(r1)
+	std	r15,STK_REG(R15)(r1)
+	std	r16,STK_REG(R16)(r1)
 
 	ld	r6,0(r3)
 	ld	r9,8(r3)
@@ -175,9 +175,9 @@ _GLOBAL(csum_partial)
 	adde	r0,r0,r15
 	adde	r0,r0,r16
 
-	ld	r14,STK_REG(r14)(r1)
-	ld	r15,STK_REG(r15)(r1)
-	ld	r16,STK_REG(r16)(r1)
+	ld	r14,STK_REG(R14)(r1)
+	ld	r15,STK_REG(R15)(r1)
+	ld	r16,STK_REG(R16)(r1)
 	addi	r1,r1,STACKFRAMESIZE
 
 	andi.	r4,r4,63
@@ -299,9 +299,9 @@ dest;	sth	r6,0(r4)
 	mtctr	r6
 
 	stdu	r1,-STACKFRAMESIZE(r1)
-	std	r14,STK_REG(r14)(r1)
-	std	r15,STK_REG(r15)(r1)
-	std	r16,STK_REG(r16)(r1)
+	std	r14,STK_REG(R14)(r1)
+	std	r15,STK_REG(R15)(r1)
+	std	r16,STK_REG(R16)(r1)
 
 source;	ld	r6,0(r3)
 source;	ld	r9,8(r3)
@@ -382,9 +382,9 @@ dest;	std	r16,56(r4)
 	adde	r0,r0,r15
 	adde	r0,r0,r16
 
-	ld	r14,STK_REG(r14)(r1)
-	ld	r15,STK_REG(r15)(r1)
-	ld	r16,STK_REG(r16)(r1)
+	ld	r14,STK_REG(R14)(r1)
+	ld	r15,STK_REG(R15)(r1)
+	ld	r16,STK_REG(R16)(r1)
 	addi	r1,r1,STACKFRAMESIZE
 
 	andi.	r5,r5,63
Index: clone3/arch/powerpc/lib/copyuser_64.S
===================================================================
--- clone3.orig/arch/powerpc/lib/copyuser_64.S
+++ clone3/arch/powerpc/lib/copyuser_64.S
@@ -30,7 +30,7 @@ _GLOBAL(__copy_tofrom_user_base)
 	dcbt	0,r4
 	beq	.Lcopy_page_4K
 	andi.	r6,r6,7
-	PPC_MTOCRF(0x01,r5)
+	PPC_MTOCRF(0x01,R5)
 	blt	cr1,.Lshort_copy
 /* Below we want to nop out the bne if we're on a CPU that has the
  * CPU_FTR_UNALIGNED_LD_STD bit set and the CPU_FTR_CP_USE_DCBTZ bit
@@ -186,7 +186,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 	blr
 
 .Ldst_unaligned:
-	PPC_MTOCRF(0x01,r6)		/* put #bytes to 8B bdry into cr7 */
+	PPC_MTOCRF(0x01,R6)		/* put #bytes to 8B bdry into cr7 */
 	subf	r5,r6,r5
 	li	r7,0
 	cmpldi	cr1,r5,16
@@ -201,7 +201,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 2:	bf	cr7*4+1,3f
 37:	lwzx	r0,r7,r4
 83:	stwx	r0,r7,r3
-3:	PPC_MTOCRF(0x01,r5)
+3:	PPC_MTOCRF(0x01,R5)
 	add	r4,r6,r4
 	add	r3,r6,r3
 	b	.Ldst_aligned
Index: clone3/arch/powerpc/lib/copyuser_power7.S
===================================================================
--- clone3.orig/arch/powerpc/lib/copyuser_power7.S
+++ clone3/arch/powerpc/lib/copyuser_power7.S
@@ -57,9 +57,9 @@
 
 
 .Ldo_err4:
-	ld	r16,STK_REG(r16)(r1)
-	ld	r15,STK_REG(r15)(r1)
-	ld	r14,STK_REG(r14)(r1)
+	ld	r16,STK_REG(R16)(r1)
+	ld	r15,STK_REG(R15)(r1)
+	ld	r14,STK_REG(R14)(r1)
 .Ldo_err3:
 	bl	.exit_vmx_copy
 	ld	r0,STACKFRAMESIZE+16(r1)
@@ -68,15 +68,15 @@
 #endif /* CONFIG_ALTIVEC */
 
 .Ldo_err2:
-	ld	r22,STK_REG(r22)(r1)
-	ld	r21,STK_REG(r21)(r1)
-	ld	r20,STK_REG(r20)(r1)
-	ld	r19,STK_REG(r19)(r1)
-	ld	r18,STK_REG(r18)(r1)
-	ld	r17,STK_REG(r17)(r1)
-	ld	r16,STK_REG(r16)(r1)
-	ld	r15,STK_REG(r15)(r1)
-	ld	r14,STK_REG(r14)(r1)
+	ld	r22,STK_REG(R22)(r1)
+	ld	r21,STK_REG(R21)(r1)
+	ld	r20,STK_REG(R20)(r1)
+	ld	r19,STK_REG(R19)(r1)
+	ld	r18,STK_REG(R18)(r1)
+	ld	r17,STK_REG(R17)(r1)
+	ld	r16,STK_REG(R16)(r1)
+	ld	r15,STK_REG(R15)(r1)
+	ld	r14,STK_REG(R14)(r1)
 .Lexit:
 	addi	r1,r1,STACKFRAMESIZE
 .Ldo_err1:
@@ -137,15 +137,15 @@ err1;	stw	r0,0(r3)
 
 	mflr	r0
 	stdu	r1,-STACKFRAMESIZE(r1)
-	std	r14,STK_REG(r14)(r1)
-	std	r15,STK_REG(r15)(r1)
-	std	r16,STK_REG(r16)(r1)
-	std	r17,STK_REG(r17)(r1)
-	std	r18,STK_REG(r18)(r1)
-	std	r19,STK_REG(r19)(r1)
-	std	r20,STK_REG(r20)(r1)
-	std	r21,STK_REG(r21)(r1)
-	std	r22,STK_REG(r22)(r1)
+	std	r14,STK_REG(R14)(r1)
+	std	r15,STK_REG(R15)(r1)
+	std	r16,STK_REG(R16)(r1)
+	std	r17,STK_REG(R17)(r1)
+	std	r18,STK_REG(R18)(r1)
+	std	r19,STK_REG(R19)(r1)
+	std	r20,STK_REG(R20)(r1)
+	std	r21,STK_REG(R21)(r1)
+	std	r22,STK_REG(R22)(r1)
 	std	r0,STACKFRAMESIZE+16(r1)
 
 	srdi	r6,r5,7
@@ -192,15 +192,15 @@ err2;	std	r21,120(r3)
 
 	clrldi	r5,r5,(64-7)
 
-	ld	r14,STK_REG(r14)(r1)
-	ld	r15,STK_REG(r15)(r1)
-	ld	r16,STK_REG(r16)(r1)
-	ld	r17,STK_REG(r17)(r1)
-	ld	r18,STK_REG(r18)(r1)
-	ld	r19,STK_REG(r19)(r1)
-	ld	r20,STK_REG(r20)(r1)
-	ld	r21,STK_REG(r21)(r1)
-	ld	r22,STK_REG(r22)(r1)
+	ld	r14,STK_REG(R14)(r1)
+	ld	r15,STK_REG(R15)(r1)
+	ld	r16,STK_REG(R16)(r1)
+	ld	r17,STK_REG(R17)(r1)
+	ld	r18,STK_REG(R18)(r1)
+	ld	r19,STK_REG(R19)(r1)
+	ld	r20,STK_REG(R20)(r1)
+	ld	r21,STK_REG(R21)(r1)
+	ld	r22,STK_REG(R22)(r1)
 	addi	r1,r1,STACKFRAMESIZE
 
 	/* Up to 127B to go */
@@ -378,9 +378,9 @@ err3;	stvx	vr0,r3,r11
 7:	sub	r5,r5,r6
 	srdi	r6,r5,7
 
-	std	r14,STK_REG(r14)(r1)
-	std	r15,STK_REG(r15)(r1)
-	std	r16,STK_REG(r16)(r1)
+	std	r14,STK_REG(R14)(r1)
+	std	r15,STK_REG(R15)(r1)
+	std	r16,STK_REG(R16)(r1)
 
 	li	r12,64
 	li	r14,80
@@ -415,9 +415,9 @@ err4;	stvx	vr0,r3,r16
 	addi	r3,r3,128
 	bdnz	8b
 
-	ld	r14,STK_REG(r14)(r1)
-	ld	r15,STK_REG(r15)(r1)
-	ld	r16,STK_REG(r16)(r1)
+	ld	r14,STK_REG(R14)(r1)
+	ld	r15,STK_REG(R15)(r1)
+	ld	r16,STK_REG(R16)(r1)
 
 	/* Up to 127B to go */
 	clrldi	r5,r5,(64-7)
@@ -563,9 +563,9 @@ err3;	stvx	vr11,r3,r11
 7:	sub	r5,r5,r6
 	srdi	r6,r5,7
 
-	std	r14,STK_REG(r14)(r1)
-	std	r15,STK_REG(r15)(r1)
-	std	r16,STK_REG(r16)(r1)
+	std	r14,STK_REG(R14)(r1)
+	std	r15,STK_REG(R15)(r1)
+	std	r16,STK_REG(R16)(r1)
 
 	li	r12,64
 	li	r14,80
@@ -608,9 +608,9 @@ err4;	stvx	vr15,r3,r16
 	addi	r3,r3,128
 	bdnz	8b
 
-	ld	r14,STK_REG(r14)(r1)
-	ld	r15,STK_REG(r15)(r1)
-	ld	r16,STK_REG(r16)(r1)
+	ld	r14,STK_REG(R14)(r1)
+	ld	r15,STK_REG(R15)(r1)
+	ld	r16,STK_REG(R16)(r1)
 
 	/* Up to 127B to go */
 	clrldi	r5,r5,(64-7)
Index: clone3/arch/powerpc/lib/hweight_64.S
===================================================================
--- clone3.orig/arch/powerpc/lib/hweight_64.S
+++ clone3/arch/powerpc/lib/hweight_64.S
@@ -28,7 +28,7 @@ BEGIN_FTR_SECTION
 	nop
 	nop
 FTR_SECTION_ELSE
-	PPC_POPCNTB(r3,r3)
+	PPC_POPCNTB(R3,R3)
 	clrldi	r3,r3,64-8
 	blr
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
@@ -42,14 +42,14 @@ BEGIN_FTR_SECTION
 	nop
 FTR_SECTION_ELSE
   BEGIN_FTR_SECTION_NESTED(50)
-	PPC_POPCNTB(r3,r3)
+	PPC_POPCNTB(R3,R3)
 	srdi	r4,r3,8
 	add	r3,r4,r3
 	clrldi	r3,r3,64-8
 	blr
   FTR_SECTION_ELSE_NESTED(50)
 	clrlwi  r3,r3,16
-	PPC_POPCNTW(r3,r3)
+	PPC_POPCNTW(R3,R3)
 	clrldi	r3,r3,64-8
 	blr
   ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POPCNTD, 50)
@@ -66,7 +66,7 @@ BEGIN_FTR_SECTION
 	nop
 FTR_SECTION_ELSE
   BEGIN_FTR_SECTION_NESTED(51)
-	PPC_POPCNTB(r3,r3)
+	PPC_POPCNTB(R3,R3)
 	srdi	r4,r3,16
 	add	r3,r4,r3
 	srdi	r4,r3,8
@@ -74,7 +74,7 @@ FTR_SECTION_ELSE
 	clrldi	r3,r3,64-8
 	blr
   FTR_SECTION_ELSE_NESTED(51)
-	PPC_POPCNTW(r3,r3)
+	PPC_POPCNTW(R3,R3)
 	clrldi	r3,r3,64-8
 	blr
   ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POPCNTD, 51)
@@ -93,7 +93,7 @@ BEGIN_FTR_SECTION
 	nop
 FTR_SECTION_ELSE
   BEGIN_FTR_SECTION_NESTED(52)
-	PPC_POPCNTB(r3,r3)
+	PPC_POPCNTB(R3,R3)
 	srdi	r4,r3,32
 	add	r3,r4,r3
 	srdi	r4,r3,16
@@ -103,7 +103,7 @@ FTR_SECTION_ELSE
 	clrldi	r3,r3,64-8
 	blr
   FTR_SECTION_ELSE_NESTED(52)
-	PPC_POPCNTD(r3,r3)
+	PPC_POPCNTD(R3,R3)
 	clrldi	r3,r3,64-8
 	blr
   ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POPCNTD, 52)
Index: clone3/arch/powerpc/lib/ldstfp.S
===================================================================
--- clone3.orig/arch/powerpc/lib/ldstfp.S
+++ clone3/arch/powerpc/lib/ldstfp.S
@@ -330,13 +330,13 @@ _GLOBAL(do_lxvd2x)
 	MTMSRD(r7)
 	isync
 	beq	cr7,1f
-	STXVD2X(0,r1,r8)
+	STXVD2X(0,R1,R8)
 1:	li	r9,-EFAULT
-2:	LXVD2X(0,0,r4)
+2:	LXVD2X(0,0,R4)
 	li	r9,0
 3:	beq	cr7,4f
 	bl	put_vsr
-	LXVD2X(0,r1,r8)
+	LXVD2X(0,R1,R8)
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
 	MTMSRD(r6)
@@ -358,13 +358,13 @@ _GLOBAL(do_stxvd2x)
 	MTMSRD(r7)
 	isync
 	beq	cr7,1f
-	STXVD2X(0,r1,r8)
+	STXVD2X(0,R1,R8)
 	bl	get_vsr
 1:	li	r9,-EFAULT
-2:	STXVD2X(0,0,r4)
+2:	STXVD2X(0,0,R4)
 	li	r9,0
 3:	beq	cr7,4f
-	LXVD2X(0,r1,r8)
+	LXVD2X(0,R1,R8)
 4:	PPC_LL	r0,STKFRM+PPC_LR_STKOFF(r1)
 	mtlr	r0
 	MTMSRD(r6)
Index: clone3/arch/powerpc/lib/mem_64.S
===================================================================
--- clone3.orig/arch/powerpc/lib/mem_64.S
+++ clone3/arch/powerpc/lib/mem_64.S
@@ -19,7 +19,7 @@ _GLOBAL(memset)
 	rlwimi	r4,r4,16,0,15
 	cmplw	cr1,r5,r0		/* do we get that far? */
 	rldimi	r4,r4,32,0
-	PPC_MTOCRF(1,r0)
+	PPC_MTOCRF(1,R0)
 	mr	r6,r3
 	blt	cr1,8f
 	beq+	3f			/* if already 8-byte aligned */
@@ -49,7 +49,7 @@ _GLOBAL(memset)
 	bdnz	4b
 5:	srwi.	r0,r5,3
 	clrlwi	r5,r5,29
-	PPC_MTOCRF(1,r0)
+	PPC_MTOCRF(1,R0)
 	beq	8f
 	bf	29,6f
 	std	r4,0(r6)
@@ -65,7 +65,7 @@ _GLOBAL(memset)
 	std	r4,0(r6)
 	addi	r6,r6,8
 8:	cmpwi	r5,0
-	PPC_MTOCRF(1,r5)
+	PPC_MTOCRF(1,R5)
 	beqlr+
 	bf	29,9f
 	stw	r4,0(r6)
Index: clone3/arch/powerpc/lib/memcpy_64.S
===================================================================
--- clone3.orig/arch/powerpc/lib/memcpy_64.S
+++ clone3/arch/powerpc/lib/memcpy_64.S
@@ -12,7 +12,7 @@
 	.align	7
 _GLOBAL(memcpy)
 	std	r3,48(r1)	/* save destination pointer for return value */
-	PPC_MTOCRF(0x01,r5)
+	PPC_MTOCRF(0x01,R5)
 	cmpldi	cr1,r5,16
 	neg	r6,r3		# LS 3 bits = # bytes to 8-byte dest bdry
 	andi.	r6,r6,7
@@ -154,7 +154,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 	blr
 
 .Ldst_unaligned:
-	PPC_MTOCRF(0x01,r6)		# put #bytes to 8B bdry into cr7
+	PPC_MTOCRF(0x01,R6)		# put #bytes to 8B bdry into cr7
 	subf	r5,r6,r5
 	li	r7,0
 	cmpldi	cr1,r5,16
@@ -169,7 +169,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 2:	bf	cr7*4+1,3f
 	lwzx	r0,r7,r4
 	stwx	r0,r7,r3
-3:	PPC_MTOCRF(0x01,r5)
+3:	PPC_MTOCRF(0x01,R5)
 	add	r4,r6,r4
 	add	r3,r6,r3
 	b	.Ldst_aligned
Index: clone3/arch/powerpc/mm/hash_low_64.S
===================================================================
--- clone3.orig/arch/powerpc/mm/hash_low_64.S
+++ clone3/arch/powerpc/mm/hash_low_64.S
@@ -64,9 +64,9 @@ _GLOBAL(__hash_page_4K)
 	std	r0,16(r1)
 	stdu	r1,-STACKFRAMESIZE(r1)
 	/* Save all params that we need after a function call */
-	std	r6,STK_PARM(r6)(r1)
-	std	r8,STK_PARM(r8)(r1)
-	std	r9,STK_PARM(r9)(r1)
+	std	r6,STK_PARM(R6)(r1)
+	std	r8,STK_PARM(R8)(r1)
+	std	r9,STK_PARM(R9)(r1)
 	
 	/* Save non-volatile registers.
 	 * r31 will hold "old PTE"
@@ -75,11 +75,11 @@ _GLOBAL(__hash_page_4K)
 	 * r28 is a hash value
 	 * r27 is hashtab mask (maybe dynamic patched instead ?)
 	 */
-	std	r27,STK_REG(r27)(r1)
-	std	r28,STK_REG(r28)(r1)
-	std	r29,STK_REG(r29)(r1)
-	std	r30,STK_REG(r30)(r1)
-	std	r31,STK_REG(r31)(r1)
+	std	r27,STK_REG(R27)(r1)
+	std	r28,STK_REG(R28)(r1)
+	std	r29,STK_REG(R29)(r1)
+	std	r30,STK_REG(R30)(r1)
+	std	r31,STK_REG(R31)(r1)
 	
 	/* Step 1:
 	 *
@@ -162,7 +162,7 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FT
 	/* At this point, r3 contains new PP bits, save them in
 	 * place of "access" in the param area (sic)
 	 */
-	std	r3,STK_PARM(r4)(r1)
+	std	r3,STK_PARM(R4)(r1)
 
 	/* Get htab_hash_mask */
 	ld	r4,htab_hash_mask@got(2)
@@ -192,11 +192,11 @@ htab_insert_pte:
 	rldicr	r3,r0,3,63-3		/* r3 = (hash & mask) << 3 */
 
 	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
+	ld	r6,STK_PARM(R4)(r1)	/* Retrieve new pp bits */
 	mr	r4,r29			/* Retrieve va */
 	li	r7,0			/* !bolted, !secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
-	ld	r9,STK_PARM(r9)(r1)	/* segment size */
+	ld	r9,STK_PARM(R9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert1)
 	bl	.			/* Patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -215,11 +215,11 @@ _GLOBAL(htab_call_hpte_insert1)
 	rldicr	r3,r0,3,63-3	/* r0 = (~hash & mask) << 3 */
 	
 	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
+	ld	r6,STK_PARM(R4)(r1)	/* Retrieve new pp bits */
 	mr	r4,r29			/* Retrieve va */
 	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
-	ld	r9,STK_PARM(r9)(r1)	/* segment size */
+	ld	r9,STK_PARM(R9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert2)
 	bl	.			/* Patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -255,15 +255,15 @@ htab_pte_insert_ok:
 	 * (maybe add eieio may be good still ?)
 	 */
 htab_write_out_pte:
-	ld	r6,STK_PARM(r6)(r1)
+	ld	r6,STK_PARM(R6)(r1)
 	std	r30,0(r6)
 	li	r3, 0
 htab_bail:
-	ld	r27,STK_REG(r27)(r1)
-	ld	r28,STK_REG(r28)(r1)
-	ld	r29,STK_REG(r29)(r1)
-	ld      r30,STK_REG(r30)(r1)
-	ld      r31,STK_REG(r31)(r1)
+	ld	r27,STK_REG(R27)(r1)
+	ld	r28,STK_REG(R28)(r1)
+	ld	r29,STK_REG(R29)(r1)
+	ld      r30,STK_REG(R30)(r1)
+	ld      r31,STK_REG(R31)(r1)
 	addi    r1,r1,STACKFRAMESIZE
 	ld      r0,16(r1)
 	mtlr    r0
@@ -288,8 +288,8 @@ htab_modify_pte:
 	/* Call ppc_md.hpte_updatepp */
 	mr	r5,r29			/* va */
 	li	r6,MMU_PAGE_4K		/* page size */
-	ld	r7,STK_PARM(r9)(r1)	/* segment size */
-	ld	r8,STK_PARM(r8)(r1)	/* get "local" param */
+	ld	r7,STK_PARM(R9)(r1)	/* segment size */
+	ld	r8,STK_PARM(R8)(r1)	/* get "local" param */
 _GLOBAL(htab_call_hpte_updatepp)
 	bl	.			/* Patched by htab_finish_init() */
 
@@ -312,7 +312,7 @@ htab_wrong_access:
 
 htab_pte_insert_failure:
 	/* Bail out restoring old PTE */
-	ld	r6,STK_PARM(r6)(r1)
+	ld	r6,STK_PARM(R6)(r1)
 	std	r31,0(r6)
 	li	r3,-1
 	b	htab_bail
@@ -340,9 +340,9 @@ _GLOBAL(__hash_page_4K)
 	std	r0,16(r1)
 	stdu	r1,-STACKFRAMESIZE(r1)
 	/* Save all params that we need after a function call */
-	std	r6,STK_PARM(r6)(r1)
-	std	r8,STK_PARM(r8)(r1)
-	std	r9,STK_PARM(r9)(r1)
+	std	r6,STK_PARM(R6)(r1)
+	std	r8,STK_PARM(R8)(r1)
+	std	r9,STK_PARM(R9)(r1)
 
 	/* Save non-volatile registers.
 	 * r31 will hold "old PTE"
@@ -353,13 +353,13 @@ _GLOBAL(__hash_page_4K)
 	 * r26 is the hidx mask
 	 * r25 is the index in combo page
 	 */
-	std	r25,STK_REG(r25)(r1)
-	std	r26,STK_REG(r26)(r1)
-	std	r27,STK_REG(r27)(r1)
-	std	r28,STK_REG(r28)(r1)
-	std	r29,STK_REG(r29)(r1)
-	std	r30,STK_REG(r30)(r1)
-	std	r31,STK_REG(r31)(r1)
+	std	r25,STK_REG(R25)(r1)
+	std	r26,STK_REG(R26)(r1)
+	std	r27,STK_REG(R27)(r1)
+	std	r28,STK_REG(R28)(r1)
+	std	r29,STK_REG(R29)(r1)
+	std	r30,STK_REG(R30)(r1)
+	std	r31,STK_REG(R31)(r1)
 
 	/* Step 1:
 	 *
@@ -452,7 +452,7 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FT
 	/* At this point, r3 contains new PP bits, save them in
 	 * place of "access" in the param area (sic)
 	 */
-	std	r3,STK_PARM(r4)(r1)
+	std	r3,STK_PARM(R4)(r1)
 
 	/* Get htab_hash_mask */
 	ld	r4,htab_hash_mask@got(2)
@@ -473,7 +473,7 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FT
 	andis.	r0,r31,_PAGE_COMBO@h
 	beq	htab_inval_old_hpte
 
-	ld	r6,STK_PARM(r6)(r1)
+	ld	r6,STK_PARM(R6)(r1)
 	ori	r26,r6,0x8000		/* Load the hidx mask */
 	ld	r26,0(r26)
 	addi	r5,r25,36		/* Check actual HPTE_SUB bit, this */
@@ -495,11 +495,11 @@ htab_special_pfn:
 	rldicr	r3,r0,3,63-3		/* r0 = (hash & mask) << 3 */
 
 	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
+	ld	r6,STK_PARM(R4)(r1)	/* Retrieve new pp bits */
 	mr	r4,r29			/* Retrieve va */
 	li	r7,0			/* !bolted, !secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
-	ld	r9,STK_PARM(r9)(r1)	/* segment size */
+	ld	r9,STK_PARM(R9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert1)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -522,11 +522,11 @@ _GLOBAL(htab_call_hpte_insert1)
 	rldicr	r3,r0,3,63-3		/* r0 = (~hash & mask) << 3 */
 
 	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
+	ld	r6,STK_PARM(R4)(r1)	/* Retrieve new pp bits */
 	mr	r4,r29			/* Retrieve va */
 	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
-	ld	r9,STK_PARM(r9)(r1)	/* segment size */
+	ld	r9,STK_PARM(R9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert2)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -559,8 +559,8 @@ htab_inval_old_hpte:
 	mr	r4,r31			/* PTE.pte */
 	li	r5,0			/* PTE.hidx */
 	li	r6,MMU_PAGE_64K		/* psize */
-	ld	r7,STK_PARM(r9)(r1)	/* ssize */
-	ld	r8,STK_PARM(r8)(r1)	/* local */
+	ld	r7,STK_PARM(R9)(r1)	/* ssize */
+	ld	r8,STK_PARM(R8)(r1)	/* local */
 	bl	.flush_hash_page
 	/* Clear out _PAGE_HPTE_SUB bits in the new linux PTE */
 	lis	r0,_PAGE_HPTE_SUB@h
@@ -576,7 +576,7 @@ htab_pte_insert_ok:
 	/* Insert slot number & secondary bit in PTE second half,
 	 * clear _PAGE_BUSY and set approriate HPTE slot bit
 	 */
-	ld	r6,STK_PARM(r6)(r1)
+	ld	r6,STK_PARM(R6)(r1)
 	li	r0,_PAGE_BUSY
 	andc	r30,r30,r0
 	/* HPTE SUB bit */
@@ -597,13 +597,13 @@ htab_pte_insert_ok:
 	std	r30,0(r6)
 	li	r3, 0
 htab_bail:
-	ld	r25,STK_REG(r25)(r1)
-	ld	r26,STK_REG(r26)(r1)
-	ld	r27,STK_REG(r27)(r1)
-	ld	r28,STK_REG(r28)(r1)
-	ld	r29,STK_REG(r29)(r1)
-	ld      r30,STK_REG(r30)(r1)
-	ld      r31,STK_REG(r31)(r1)
+	ld	r25,STK_REG(R25)(r1)
+	ld	r26,STK_REG(R26)(r1)
+	ld	r27,STK_REG(R27)(r1)
+	ld	r28,STK_REG(R28)(r1)
+	ld	r29,STK_REG(R29)(r1)
+	ld      r30,STK_REG(R30)(r1)
+	ld      r31,STK_REG(R31)(r1)
 	addi    r1,r1,STACKFRAMESIZE
 	ld      r0,16(r1)
 	mtlr    r0
@@ -630,8 +630,8 @@ htab_modify_pte:
 	/* Call ppc_md.hpte_updatepp */
 	mr	r5,r29			/* va */
 	li	r6,MMU_PAGE_4K		/* page size */
-	ld	r7,STK_PARM(r9)(r1)	/* segment size */
-	ld	r8,STK_PARM(r8)(r1)	/* get "local" param */
+	ld	r7,STK_PARM(R9)(r1)	/* segment size */
+	ld	r8,STK_PARM(R8)(r1)	/* get "local" param */
 _GLOBAL(htab_call_hpte_updatepp)
 	bl	.			/* patched by htab_finish_init() */
 
@@ -644,7 +644,7 @@ _GLOBAL(htab_call_hpte_updatepp)
 	/* Clear the BUSY bit and Write out the PTE */
 	li	r0,_PAGE_BUSY
 	andc	r30,r30,r0
-	ld	r6,STK_PARM(r6)(r1)
+	ld	r6,STK_PARM(R6)(r1)
 	std	r30,0(r6)
 	li	r3,0
 	b	htab_bail
@@ -657,7 +657,7 @@ htab_wrong_access:
 
 htab_pte_insert_failure:
 	/* Bail out restoring old PTE */
-	ld	r6,STK_PARM(r6)(r1)
+	ld	r6,STK_PARM(R6)(r1)
 	std	r31,0(r6)
 	li	r3,-1
 	b	htab_bail
@@ -677,9 +677,9 @@ _GLOBAL(__hash_page_64K)
 	std	r0,16(r1)
 	stdu	r1,-STACKFRAMESIZE(r1)
 	/* Save all params that we need after a function call */
-	std	r6,STK_PARM(r6)(r1)
-	std	r8,STK_PARM(r8)(r1)
-	std	r9,STK_PARM(r9)(r1)
+	std	r6,STK_PARM(R6)(r1)
+	std	r8,STK_PARM(R8)(r1)
+	std	r9,STK_PARM(R9)(r1)
 
 	/* Save non-volatile registers.
 	 * r31 will hold "old PTE"
@@ -688,11 +688,11 @@ _GLOBAL(__hash_page_64K)
 	 * r28 is a hash value
 	 * r27 is hashtab mask (maybe dynamic patched instead ?)
 	 */
-	std	r27,STK_REG(r27)(r1)
-	std	r28,STK_REG(r28)(r1)
-	std	r29,STK_REG(r29)(r1)
-	std	r30,STK_REG(r30)(r1)
-	std	r31,STK_REG(r31)(r1)
+	std	r27,STK_REG(R27)(r1)
+	std	r28,STK_REG(R28)(r1)
+	std	r29,STK_REG(R29)(r1)
+	std	r30,STK_REG(R30)(r1)
+	std	r31,STK_REG(R31)(r1)
 
 	/* Step 1:
 	 *
@@ -780,7 +780,7 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FT
 	/* At this point, r3 contains new PP bits, save them in
 	 * place of "access" in the param area (sic)
 	 */
-	std	r3,STK_PARM(r4)(r1)
+	std	r3,STK_PARM(R4)(r1)
 
 	/* Get htab_hash_mask */
 	ld	r4,htab_hash_mask@got(2)
@@ -813,11 +813,11 @@ ht64_insert_pte:
 	rldicr	r3,r0,3,63-3	/* r0 = (hash & mask) << 3 */
 
 	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
+	ld	r6,STK_PARM(R4)(r1)	/* Retrieve new pp bits */
 	mr	r4,r29			/* Retrieve va */
 	li	r7,0			/* !bolted, !secondary */
 	li	r8,MMU_PAGE_64K
-	ld	r9,STK_PARM(r9)(r1)	/* segment size */
+	ld	r9,STK_PARM(R9)(r1)	/* segment size */
 _GLOBAL(ht64_call_hpte_insert1)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -836,11 +836,11 @@ _GLOBAL(ht64_call_hpte_insert1)
 	rldicr	r3,r0,3,63-3	/* r0 = (~hash & mask) << 3 */
 
 	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARM(r4)(r1)	/* Retrieve new pp bits */
+	ld	r6,STK_PARM(R4)(r1)	/* Retrieve new pp bits */
 	mr	r4,r29			/* Retrieve va */
 	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
 	li	r8,MMU_PAGE_64K
-	ld	r9,STK_PARM(r9)(r1)	/* segment size */
+	ld	r9,STK_PARM(R9)(r1)	/* segment size */
 _GLOBAL(ht64_call_hpte_insert2)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -876,15 +876,15 @@ ht64_pte_insert_ok:
 	 * (maybe add eieio may be good still ?)
 	 */
 ht64_write_out_pte:
-	ld	r6,STK_PARM(r6)(r1)
+	ld	r6,STK_PARM(R6)(r1)
 	std	r30,0(r6)
 	li	r3, 0
 ht64_bail:
-	ld	r27,STK_REG(r27)(r1)
-	ld	r28,STK_REG(r28)(r1)
-	ld	r29,STK_REG(r29)(r1)
-	ld      r30,STK_REG(r30)(r1)
-	ld      r31,STK_REG(r31)(r1)
+	ld	r27,STK_REG(R27)(r1)
+	ld	r28,STK_REG(R28)(r1)
+	ld	r29,STK_REG(R29)(r1)
+	ld      r30,STK_REG(R30)(r1)
+	ld      r31,STK_REG(R31)(r1)
 	addi    r1,r1,STACKFRAMESIZE
 	ld      r0,16(r1)
 	mtlr    r0
@@ -909,8 +909,8 @@ ht64_modify_pte:
 	/* Call ppc_md.hpte_updatepp */
 	mr	r5,r29			/* va */
 	li	r6,MMU_PAGE_64K
-	ld	r7,STK_PARM(r9)(r1)	/* segment size */
-	ld	r8,STK_PARM(r8)(r1)	/* get "local" param */
+	ld	r7,STK_PARM(R9)(r1)	/* segment size */
+	ld	r8,STK_PARM(R8)(r1)	/* get "local" param */
 _GLOBAL(ht64_call_hpte_updatepp)
 	bl	.			/* patched by htab_finish_init() */
 
@@ -933,7 +933,7 @@ ht64_wrong_access:
 
 ht64_pte_insert_failure:
 	/* Bail out restoring old PTE */
-	ld	r6,STK_PARM(r6)(r1)
+	ld	r6,STK_PARM(R6)(r1)
 	std	r31,0(r6)
 	li	r3,-1
 	b	ht64_bail
Index: clone3/arch/powerpc/mm/tlb_low_64e.S
===================================================================
--- clone3.orig/arch/powerpc/mm/tlb_low_64e.S
+++ clone3/arch/powerpc/mm/tlb_low_64e.S
@@ -126,7 +126,7 @@ BEGIN_MMU_FTR_SECTION
 	/* Set the TLB reservation and search for existing entry. Then load
 	 * the entry.
 	 */
-	PPC_TLBSRX_DOT(0,r16)
+	PPC_TLBSRX_DOT(R0,R16)
 	ldx	r14,r14,r15		/* grab pgd entry */
 	beq	normal_tlb_miss_done	/* tlb exists already, bail */
 MMU_FTR_SECTION_ELSE
@@ -395,7 +395,7 @@ BEGIN_MMU_FTR_SECTION
 	/* Set the TLB reservation and search for existing entry. Then load
 	 * the entry.
 	 */
-	PPC_TLBSRX_DOT(0,r16)
+	PPC_TLBSRX_DOT(R0,R16)
 	ld	r14,0(r10)
 	beq	normal_tlb_miss_done
 MMU_FTR_SECTION_ELSE
@@ -528,7 +528,7 @@ BEGIN_MMU_FTR_SECTION
 	/* Search if we already have a TLB entry for that virtual address, and
 	 * if we do, bail out.
 	 */
-	PPC_TLBSRX_DOT(0,r16)
+	PPC_TLBSRX_DOT(R0,R16)
 	beq	virt_page_table_tlb_miss_done
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_TLBRSRV)
 
@@ -779,7 +779,7 @@ htw_tlb_miss:
 	 *
 	 * MAS1:IND should be already set based on MAS4
 	 */
-	PPC_TLBSRX_DOT(0,r16)
+	PPC_TLBSRX_DOT(R0,R16)
 	beq	htw_tlb_miss_done
 
 	/* Now, we need to walk the page tables. First check if we are in
@@ -919,7 +919,7 @@ tlb_load_linear:
 	mtspr	SPRN_MAS1,r15
 
 	/* Already somebody there ? */
-	PPC_TLBSRX_DOT(0,r16)
+	PPC_TLBSRX_DOT(R0,R16)
 	beq	tlb_load_linear_done
 
 	/* Now we build the remaining MAS. MAS0 and 2 should be fine
Index: clone3/arch/powerpc/mm/tlb_nohash_low.S
===================================================================
--- clone3.orig/arch/powerpc/mm/tlb_nohash_low.S
+++ clone3/arch/powerpc/mm/tlb_nohash_low.S
@@ -313,7 +313,7 @@ BEGIN_MMU_FTR_SECTION
 	mtspr	SPRN_MAS1,r4
 	tlbwe
 MMU_FTR_SECTION_ELSE
-	PPC_TLBILX_VA(0,r3)
+	PPC_TLBILX_VA(R0,R3)
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_USE_TLBILX)
 	msync
 	isync
@@ -364,7 +364,7 @@ _GLOBAL(_tlbil_va)
 	beq	1f
 	rlwimi	r4,r6,MAS6_SIND_SHIFT,MAS6_SIND
 1:	mtspr	SPRN_MAS6,r4		/* assume AS=0 for now */
-	PPC_TLBILX_VA(0,r3)
+	PPC_TLBILX_VA(R0,R3)
 	msync
 	isync
 	wrtee	r10
@@ -379,7 +379,7 @@ _GLOBAL(_tlbivax_bcast)
 	beq	1f
 	rlwimi	r4,r6,MAS6_SIND_SHIFT,MAS6_SIND
 1:	mtspr	SPRN_MAS6,r4		/* assume AS=0 for now */
-	PPC_TLBIVAX(0,r3)
+	PPC_TLBIVAX(R0,R3)
 	eieio
 	tlbsync
 	sync
Index: clone3/arch/powerpc/platforms/cell/beat_hvCall.S
===================================================================
--- clone3.orig/arch/powerpc/platforms/cell/beat_hvCall.S
+++ clone3/arch/powerpc/platforms/cell/beat_hvCall.S
@@ -74,7 +74,7 @@ _GLOBAL(beat_hcall_norets8)
 	mr	r6,r7
 	mr	r7,r8
 	mr	r8,r9
-	ld	r10,STK_PARM(r10)(r1)
+	ld	r10,STK_PARM(R10)(r1)
 
 	HVSC				/* invoke the hypervisor */
 
@@ -94,7 +94,7 @@ _GLOBAL(beat_hcall1)
 
 	HCALL_INST_PRECALL
 
-	std	r4,STK_PARM(r4)(r1)	/* save ret buffer */
+	std	r4,STK_PARM(R4)(r1)	/* save ret buffer */
 
 	mr	r11,r3
 	mr	r3,r5
@@ -108,7 +108,7 @@ _GLOBAL(beat_hcall1)
 
 	HCALL_INST_POSTCALL
 
-	ld	r12,STK_PARM(r4)(r1)
+	ld	r12,STK_PARM(R4)(r1)
 	std	r4,  0(r12)
 
 	lwz	r0,8(r1)
@@ -125,7 +125,7 @@ _GLOBAL(beat_hcall2)
 
 	HCALL_INST_PRECALL
 
-	std	r4,STK_PARM(r4)(r1)	/* save ret buffer */
+	std	r4,STK_PARM(R4)(r1)	/* save ret buffer */
 
 	mr	r11,r3
 	mr	r3,r5
@@ -139,7 +139,7 @@ _GLOBAL(beat_hcall2)
 
 	HCALL_INST_POSTCALL
 
-	ld	r12,STK_PARM(r4)(r1)
+	ld	r12,STK_PARM(R4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
 
@@ -157,7 +157,7 @@ _GLOBAL(beat_hcall3)
 
 	HCALL_INST_PRECALL
 
-	std	r4,STK_PARM(r4)(r1)	/* save ret buffer */
+	std	r4,STK_PARM(R4)(r1)	/* save ret buffer */
 
 	mr	r11,r3
 	mr	r3,r5
@@ -171,7 +171,7 @@ _GLOBAL(beat_hcall3)
 
 	HCALL_INST_POSTCALL
 
-	ld	r12,STK_PARM(r4)(r1)
+	ld	r12,STK_PARM(R4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
 	std	r6, 16(r12)
@@ -190,7 +190,7 @@ _GLOBAL(beat_hcall4)
 
 	HCALL_INST_PRECALL
 
-	std	r4,STK_PARM(r4)(r1)	/* save ret buffer */
+	std	r4,STK_PARM(R4)(r1)	/* save ret buffer */
 
 	mr	r11,r3
 	mr	r3,r5
@@ -204,7 +204,7 @@ _GLOBAL(beat_hcall4)
 
 	HCALL_INST_POSTCALL
 
-	ld	r12,STK_PARM(r4)(r1)
+	ld	r12,STK_PARM(R4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
 	std	r6, 16(r12)
@@ -224,7 +224,7 @@ _GLOBAL(beat_hcall5)
 
 	HCALL_INST_PRECALL
 
-	std	r4,STK_PARM(r4)(r1)	/* save ret buffer */
+	std	r4,STK_PARM(R4)(r1)	/* save ret buffer */
 
 	mr	r11,r3
 	mr	r3,r5
@@ -238,7 +238,7 @@ _GLOBAL(beat_hcall5)
 
 	HCALL_INST_POSTCALL
 
-	ld	r12,STK_PARM(r4)(r1)
+	ld	r12,STK_PARM(R4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
 	std	r6, 16(r12)
@@ -259,7 +259,7 @@ _GLOBAL(beat_hcall6)
 
 	HCALL_INST_PRECALL
 
-	std	r4,STK_PARM(r4)(r1)	/* save ret buffer */
+	std	r4,STK_PARM(R4)(r1)	/* save ret buffer */
 
 	mr	r11,r3
 	mr	r3,r5
@@ -273,7 +273,7 @@ _GLOBAL(beat_hcall6)
 
 	HCALL_INST_POSTCALL
 
-	ld	r12,STK_PARM(r4)(r1)
+	ld	r12,STK_PARM(R4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
 	std	r6, 16(r12)
Index: clone3/arch/powerpc/platforms/powernv/opal-takeover.S
===================================================================
--- clone3.orig/arch/powerpc/platforms/powernv/opal-takeover.S
+++ clone3/arch/powerpc/platforms/powernv/opal-takeover.S
@@ -23,14 +23,14 @@
 _GLOBAL(opal_query_takeover)
 	mfcr	r0
 	stw	r0,8(r1)
-	std	r3,STK_PARAM(r3)(r1)
-	std	r4,STK_PARAM(r4)(r1)
+	std	r3,STK_PARAM(R3)(r1)
+	std	r4,STK_PARAM(R4)(r1)
 	li	r3,H_HAL_TAKEOVER
 	li	r4,H_HAL_TAKEOVER_QUERY_MAGIC
 	HVSC
-	ld	r10,STK_PARAM(r3)(r1)
+	ld	r10,STK_PARAM(R3)(r1)
 	std	r4,0(r10)
-	ld	r10,STK_PARAM(r4)(r1)
+	ld	r10,STK_PARAM(R4)(r1)
 	std	r5,0(r10)
 	lwz	r0,8(r1)
 	mtcrf	0xff,r0
Index: clone3/arch/powerpc/platforms/powernv/opal-wrappers.S
===================================================================
--- clone3.orig/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ clone3/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -32,7 +32,7 @@
 	std	r12,PACASAVEDMSR(r13);	\
 	andc	r12,r12,r0;		\
 	mtmsrd	r12,1;			\
-	LOAD_REG_ADDR(r0,.opal_return);	\
+	LOAD_REG_ADDR(R0,.opal_return);	\
 	mtlr	r0;			\
 	li	r0,MSR_DR|MSR_IR;	\
 	andc	r12,r12,r0;		\
Index: clone3/arch/powerpc/platforms/pseries/hvCall.S
===================================================================
--- clone3.orig/arch/powerpc/platforms/pseries/hvCall.S
+++ clone3/arch/powerpc/platforms/pseries/hvCall.S
@@ -40,28 +40,28 @@ END_FTR_SECTION(0, 1);						\
 	cmpdi	r12,0;						\
 	beq+	1f;						\
 	mflr	r0;						\
-	std	r3,STK_PARM(r3)(r1);				\
-	std	r4,STK_PARM(r4)(r1);				\
-	std	r5,STK_PARM(r5)(r1);				\
-	std	r6,STK_PARM(r6)(r1);				\
-	std	r7,STK_PARM(r7)(r1);				\
-	std	r8,STK_PARM(r8)(r1);				\
-	std	r9,STK_PARM(r9)(r1);				\
-	std	r10,STK_PARM(r10)(r1);				\
+	std	r3,STK_PARM(R3)(r1);				\
+	std	r4,STK_PARM(R4)(r1);				\
+	std	r5,STK_PARM(R5)(r1);				\
+	std	r6,STK_PARM(R6)(r1);				\
+	std	r7,STK_PARM(R7)(r1);				\
+	std	r8,STK_PARM(R8)(r1);				\
+	std	r9,STK_PARM(R9)(r1);				\
+	std	r10,STK_PARM(R10)(r1);				\
 	std	r0,16(r1);					\
 	addi	r4,r1,STK_PARM(FIRST_REG);			\
 	stdu	r1,-STACK_FRAME_OVERHEAD(r1);			\
 	bl	.__trace_hcall_entry;				\
 	addi	r1,r1,STACK_FRAME_OVERHEAD;			\
 	ld	r0,16(r1);					\
-	ld	r3,STK_PARM(r3)(r1);				\
-	ld	r4,STK_PARM(r4)(r1);				\
-	ld	r5,STK_PARM(r5)(r1);				\
-	ld	r6,STK_PARM(r6)(r1);				\
-	ld	r7,STK_PARM(r7)(r1);				\
-	ld	r8,STK_PARM(r8)(r1);				\
-	ld	r9,STK_PARM(r9)(r1);				\
-	ld	r10,STK_PARM(r10)(r1);				\
+	ld	r3,STK_PARM(R3)(r1);				\
+	ld	r4,STK_PARM(R4)(r1);				\
+	ld	r5,STK_PARM(R5)(r1);				\
+	ld	r6,STK_PARM(R6)(r1);				\
+	ld	r7,STK_PARM(R7)(r1);				\
+	ld	r8,STK_PARM(R8)(r1);				\
+	ld	r9,STK_PARM(R9)(r1);				\
+	ld	r10,STK_PARM(R10)(r1);				\
 	mtlr	r0;						\
 1:
 
@@ -79,8 +79,8 @@ END_FTR_SECTION(0, 1);						\
 	cmpdi	r12,0;						\
 	beq+	1f;						\
 	mflr	r0;						\
-	ld	r6,STK_PARM(r3)(r1);				\
-	std	r3,STK_PARM(r3)(r1);				\
+	ld	r6,STK_PARM(R3)(r1);				\
+	std	r3,STK_PARM(R3)(r1);				\
 	mr	r4,r3;						\
 	mr	r3,r6;						\
 	std	r0,16(r1);					\
@@ -88,7 +88,7 @@ END_FTR_SECTION(0, 1);						\
 	bl	.__trace_hcall_exit;				\
 	addi	r1,r1,STACK_FRAME_OVERHEAD;			\
 	ld	r0,16(r1);					\
-	ld	r3,STK_PARM(r3)(r1);				\
+	ld	r3,STK_PARM(R3)(r1);				\
 	mtlr	r0;						\
 1:
 
@@ -114,7 +114,7 @@ _GLOBAL(plpar_hcall_norets)
 	mfcr	r0
 	stw	r0,8(r1)
 
-	HCALL_INST_PRECALL(r4)
+	HCALL_INST_PRECALL(R4)
 
 	HVSC				/* invoke the hypervisor */
 
@@ -130,9 +130,9 @@ _GLOBAL(plpar_hcall)
 	mfcr	r0
 	stw	r0,8(r1)
 
-	HCALL_INST_PRECALL(r5)
+	HCALL_INST_PRECALL(R5)
 
-	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */
+	std     r4,STK_PARM(R4)(r1)     /* Save ret buffer */
 
 	mr	r4,r5
 	mr	r5,r6
@@ -143,7 +143,7 @@ _GLOBAL(plpar_hcall)
 
 	HVSC				/* invoke the hypervisor */
 
-	ld	r12,STK_PARM(r4)(r1)
+	ld	r12,STK_PARM(R4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
 	std	r6, 16(r12)
@@ -168,7 +168,7 @@ _GLOBAL(plpar_hcall_raw)
 	mfcr	r0
 	stw	r0,8(r1)
 
-	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */
+	std     r4,STK_PARM(R4)(r1)     /* Save ret buffer */
 
 	mr	r4,r5
 	mr	r5,r6
@@ -179,7 +179,7 @@ _GLOBAL(plpar_hcall_raw)
 
 	HVSC				/* invoke the hypervisor */
 
-	ld	r12,STK_PARM(r4)(r1)
+	ld	r12,STK_PARM(R4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
 	std	r6, 16(r12)
@@ -196,9 +196,9 @@ _GLOBAL(plpar_hcall9)
 	mfcr	r0
 	stw	r0,8(r1)
 
-	HCALL_INST_PRECALL(r5)
+	HCALL_INST_PRECALL(R5)
 
-	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */
+	std     r4,STK_PARM(R4)(r1)     /* Save ret buffer */
 
 	mr	r4,r5
 	mr	r5,r6
@@ -206,14 +206,14 @@ _GLOBAL(plpar_hcall9)
 	mr	r7,r8
 	mr	r8,r9
 	mr	r9,r10
-	ld	r10,STK_PARM(r11)(r1)	 /* put arg7 in R10 */
-	ld	r11,STK_PARM(r12)(r1)	 /* put arg8 in R11 */
-	ld	r12,STK_PARM(r13)(r1)    /* put arg9 in R12 */
+	ld	r10,STK_PARM(R11)(r1)	 /* put arg7 in R10 */
+	ld	r11,STK_PARM(R12)(r1)	 /* put arg8 in R11 */
+	ld	r12,STK_PARM(R13)(r1)    /* put arg9 in R12 */
 
 	HVSC				/* invoke the hypervisor */
 
 	mr	r0,r12
-	ld	r12,STK_PARM(r4)(r1)
+	ld	r12,STK_PARM(R4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
 	std	r6, 16(r12)
@@ -238,7 +238,7 @@ _GLOBAL(plpar_hcall9_raw)
 	mfcr	r0
 	stw	r0,8(r1)
 
-	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */
+	std     r4,STK_PARM(R4)(r1)     /* Save ret buffer */
 
 	mr	r4,r5
 	mr	r5,r6
@@ -246,14 +246,14 @@ _GLOBAL(plpar_hcall9_raw)
 	mr	r7,r8
 	mr	r8,r9
 	mr	r9,r10
-	ld	r10,STK_PARM(r11)(r1)	 /* put arg7 in R10 */
-	ld	r11,STK_PARM(r12)(r1)	 /* put arg8 in R11 */
-	ld	r12,STK_PARM(r13)(r1)    /* put arg9 in R12 */
+	ld	r10,STK_PARM(R11)(r1)	 /* put arg7 in R10 */
+	ld	r11,STK_PARM(R12)(r1)	 /* put arg8 in R11 */
+	ld	r12,STK_PARM(R13)(r1)    /* put arg9 in R12 */
 
 	HVSC				/* invoke the hypervisor */
 
 	mr	r0,r12
-	ld	r12,STK_PARM(r4)(r1)
+	ld	r12,STK_PARM(R4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
 	std	r6, 16(r12)
