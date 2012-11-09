Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 02/14] powerpc: Whitespace changes in exception64s.S
Date: Fri,  9 Nov 2012 17:19:00 +1100
Message-Id: <1352441953-29096-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1352441953-29096-1-git-send-email-mikey@neuling.org>
References: <1352441953-29096-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove redundancy spaces and make tab usage consistent.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/exceptions-64s.S |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 5663018..29cf7b1 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -613,8 +613,8 @@ machine_check_common:
 	STD_EXCEPTION_COMMON(0xb00, trap_0b, .unknown_exception)
 	STD_EXCEPTION_COMMON(0xd00, single_step, .single_step_exception)
 	STD_EXCEPTION_COMMON(0xe00, trap_0e, .unknown_exception)
-        STD_EXCEPTION_COMMON(0xe40, emulation_assist, .program_check_exception)
-        STD_EXCEPTION_COMMON(0xe60, hmi_exception, .unknown_exception)
+	STD_EXCEPTION_COMMON(0xe40, emulation_assist, .program_check_exception)
+	STD_EXCEPTION_COMMON(0xe60, hmi_exception, .unknown_exception)
 	STD_EXCEPTION_COMMON_ASYNC(0xf00, performance_monitor, .performance_monitor_exception)
 	STD_EXCEPTION_COMMON(0x1300, instruction_breakpoint, .instruction_breakpoint_exception)
 	STD_EXCEPTION_COMMON(0x1502, denorm, .unknown_exception)
@@ -714,21 +714,21 @@ data_access_common:
 	ld	r3,PACA_EXGEN+EX_DAR(r13)
 	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
 	li	r5,0x300
-	b	.do_hash_page	 	/* Try to handle as hpte fault */
+	b	.do_hash_page		/* Try to handle as hpte fault */
 
 	.align  7
-        .globl  h_data_storage_common
+	.globl  h_data_storage_common
 h_data_storage_common:
-        mfspr   r10,SPRN_HDAR
-        std     r10,PACA_EXGEN+EX_DAR(r13)
-        mfspr   r10,SPRN_HDSISR
-        stw     r10,PACA_EXGEN+EX_DSISR(r13)
-        EXCEPTION_PROLOG_COMMON(0xe00, PACA_EXGEN)
-        bl      .save_nvgprs
+	mfspr   r10,SPRN_HDAR
+	std     r10,PACA_EXGEN+EX_DAR(r13)
+	mfspr   r10,SPRN_HDSISR
+	stw     r10,PACA_EXGEN+EX_DSISR(r13)
+	EXCEPTION_PROLOG_COMMON(0xe00, PACA_EXGEN)
+	bl      .save_nvgprs
 	DISABLE_INTS
-        addi    r3,r1,STACK_FRAME_OVERHEAD
-        bl      .unknown_exception
-        b       .ret_from_except
+	addi    r3,r1,STACK_FRAME_OVERHEAD
+	bl      .unknown_exception
+	b       .ret_from_except
 
 	.align	7
 	.globl instruction_access_common
@@ -741,7 +741,7 @@ instruction_access_common:
 	li	r5,0x400
 	b	.do_hash_page		/* Try to handle as hpte fault */
 
-        STD_EXCEPTION_COMMON(0xe20, h_instr_storage, .unknown_exception)
+	STD_EXCEPTION_COMMON(0xe20, h_instr_storage, .unknown_exception)
 
 /*
  * Here is the common SLB miss user that is used when going to virtual
@@ -1164,7 +1164,7 @@ fwnmi_data_area:
 	/* pseries and powernv need to keep the whole page from
 	 * 0x7000 to 0x8000 free for use by the firmware
 	 */
-        . = 0x8000
+	. = 0x8000
 #endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
 
 /* Space for CPU0's segment table */
-- 
1.7.9.5
