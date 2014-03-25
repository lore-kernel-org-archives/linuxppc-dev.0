Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 02/33] powerpc: Remove superflous function descriptors in
 assembly only code
Date: Tue, 25 Mar 2014 22:44:08 +1100
Message-Id: <1395747879-5948-3-git-send-email-anton@samba.org>
In-Reply-To: <1395747879-5948-1-git-send-email-anton@samba.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have a number of places where we load the text address of a local
function and indirectly branch to it in assembly. Since it is an
indirect branch binutils will not know to use the function text
address, so that trick wont work.

There is no need for these functions to have a function descriptor
so we can replace it with a label and remove the dot symbol.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/entry_64.S                 | 10 +++++-----
 arch/powerpc/kernel/exceptions-64s.S           | 18 +++++++++---------
 arch/powerpc/kernel/head_64.S                  |  9 +++++----
 arch/powerpc/platforms/powernv/opal-wrappers.S |  4 ++--
 4 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index b629198..2d92eeb 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1021,7 +1021,7 @@ _GLOBAL(enter_rtas)
         std	r6,PACASAVEDMSR(r13)
 
 	/* Setup our real return addr */	
-	LOAD_REG_ADDR(r4,.rtas_return_loc)
+	LOAD_REG_ADDR(r4,rtas_return_loc)
 	clrldi	r4,r4,2			/* convert to realmode address */
        	mtlr	r4
 
@@ -1045,7 +1045,7 @@ _GLOBAL(enter_rtas)
 	rfid
 	b	.	/* prevent speculative execution */
 
-_STATIC(rtas_return_loc)
+rtas_return_loc:
 	FIXUP_ENDIAN
 
 	/* relocation is off at this point */
@@ -1054,7 +1054,7 @@ _STATIC(rtas_return_loc)
 
 	bcl	20,31,$+4
 0:	mflr	r3
-	ld	r3,(1f-0b)(r3)		/* get &.rtas_restore_regs */
+	ld	r3,(1f-0b)(r3)		/* get &rtas_restore_regs */
 
 	mfmsr   r6
 	li	r0,MSR_RI
@@ -1071,9 +1071,9 @@ _STATIC(rtas_return_loc)
 	b	.	/* prevent speculative execution */
 
 	.align	3
-1:	.llong	.rtas_restore_regs
+1:	.llong	rtas_restore_regs
 
-_STATIC(rtas_restore_regs)
+rtas_restore_regs:
 	/* relocation is on at this point */
 	REST_GPR(2, r1)			/* Restore the TOC */
 	REST_GPR(13, r1)		/* Restore paca */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index f0e6c1b..7e87b64 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -216,13 +216,13 @@ data_access_slb_pSeries:
 	b	slb_miss_realmode
 #else
 	/*
-	 * We can't just use a direct branch to .slb_miss_realmode
+	 * We can't just use a direct branch to slb_miss_realmode
 	 * because the distance from here to there depends on where
 	 * the kernel ends up being put.
 	 */
 	mfctr	r11
 	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER(r10, .slb_miss_realmode)
+	LOAD_HANDLER(r10, slb_miss_realmode)
 	mtctr	r10
 	bctr
 #endif
@@ -249,7 +249,7 @@ instruction_access_slb_pSeries:
 #else
 	mfctr	r11
 	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER(r10, .slb_miss_realmode)
+	LOAD_HANDLER(r10, slb_miss_realmode)
 	mtctr	r10
 	bctr
 #endif
@@ -526,7 +526,7 @@ do_stab_bolted_pSeries:
 	std	r12,PACA_EXSLB+EX_R12(r13)
 	GET_SCRATCH0(r10)
 	std	r10,PACA_EXSLB+EX_R13(r13)
-	EXCEPTION_PROLOG_PSERIES_1(.do_stab_bolted, EXC_STD)
+	EXCEPTION_PROLOG_PSERIES_1(do_stab_bolted, EXC_STD)
 
 	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_STD, 0x300)
 	KVM_HANDLER_SKIP(PACA_EXSLB, EXC_STD, 0x380)
@@ -834,13 +834,13 @@ data_access_slb_relon_pSeries:
 	b	slb_miss_realmode
 #else
 	/*
-	 * We can't just use a direct branch to .slb_miss_realmode
+	 * We can't just use a direct branch to slb_miss_realmode
 	 * because the distance from here to there depends on where
 	 * the kernel ends up being put.
 	 */
 	mfctr	r11
 	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER(r10, .slb_miss_realmode)
+	LOAD_HANDLER(r10, slb_miss_realmode)
 	mtctr	r10
 	bctr
 #endif
@@ -860,7 +860,7 @@ instruction_access_slb_relon_pSeries:
 #else
 	mfctr	r11
 	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER(r10, .slb_miss_realmode)
+	LOAD_HANDLER(r10, slb_miss_realmode)
 	mtctr	r10
 	bctr
 #endif
@@ -1470,7 +1470,7 @@ machine_check_handle_early:
  * r3 is saved in paca->slb_r3
  * We assume we aren't going to take any exceptions during this procedure.
  */
-_GLOBAL(slb_miss_realmode)
+slb_miss_realmode:
 	mflr	r10
 #ifdef CONFIG_RELOCATABLE
 	mtctr	r11
@@ -1648,7 +1648,7 @@ do_ste_alloc:
  * We assume (DAR >> 60) == 0xc.
  */
 	.align	7
-_GLOBAL(do_stab_bolted)
+do_stab_bolted:
 	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
 	std	r11,PACA_EXSLB+EX_SRR0(r13)	/* save SRR0 in exc. frame */
 	mfspr	r11,SPRN_DAR			/* ea */
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index afcfd63..8d7c868 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -639,7 +639,7 @@ __secondary_start:
 	stb	r0,PACAIRQHAPPENED(r13)
 
 	/* enable MMU and jump to start_secondary */
-	LOAD_REG_ADDR(r3, .start_secondary_prolog)
+	LOAD_REG_ADDR(r3, start_secondary_prolog)
 	LOAD_REG_IMMEDIATE(r4, MSR_KERNEL)
 
 	mtspr	SPRN_SRR0,r3
@@ -652,7 +652,7 @@ __secondary_start:
  * zero the stack back-chain pointer and get the TOC virtual address
  * before going into C code.
  */
-_GLOBAL(start_secondary_prolog)
+start_secondary_prolog:
 	ld	r2,PACATOC(r13)
 	li	r3,0
 	std	r3,0(r1)		/* Zero the stack frame pointer	*/
@@ -778,7 +778,7 @@ _INIT_STATIC(start_here_multiplatform)
 	mr	r3,r31
 	bl	early_setup		/* also sets r13 and SPRG_PACA */
 
-	LOAD_REG_ADDR(r3, .start_here_common)
+	LOAD_REG_ADDR(r3, start_here_common)
 	ld	r4,PACAKMSR(r13)
 	mtspr	SPRN_SRR0,r3
 	mtspr	SPRN_SRR1,r4
@@ -786,7 +786,8 @@ _INIT_STATIC(start_here_multiplatform)
 	b	.	/* prevent speculative execution */
 	
 	/* This is where all platforms converge execution */
-_INIT_GLOBAL(start_here_common)
+
+start_here_common:
 	/* relocation is on at this point */
 	std	r1,PACAKSAVE(r13)
 
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 75c89df..d559122 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -32,7 +32,7 @@
 	std	r12,PACASAVEDMSR(r13);	\
 	andc	r12,r12,r0;		\
 	mtmsrd	r12,1;			\
-	LOAD_REG_ADDR(r0,.opal_return);	\
+	LOAD_REG_ADDR(r0,opal_return);	\
 	mtlr	r0;			\
 	li	r0,MSR_DR|MSR_IR|MSR_LE;\
 	andc	r12,r12,r0;		\
@@ -44,7 +44,7 @@
 	mtspr	SPRN_HSRR0,r12;		\
 	hrfid
 
-_STATIC(opal_return)
+opal_return:
 	/*
 	 * Fixup endian on OPAL return... we should be able to simplify
 	 * this by instead converting the below trampoline to a set of
-- 
1.8.3.2
