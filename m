Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 06/33] powerpc: Remove dot symbol usage in exception macros
Date: Tue, 25 Mar 2014 22:44:12 +1100
Message-Id: <1395747879-5948-7-git-send-email-anton@samba.org>
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

STD_EXCEPTION_COMMON, STD_EXCEPTION_COMMON_ASYNC and
MASKABLE_EXCEPTION branch to the handler, so we can remove
the explicit dot symbol and binutils will do the right thing.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/exceptions-64e.S |  8 +++----
 arch/powerpc/kernel/exceptions-64s.S | 46 ++++++++++++++++++------------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index c8ac8a0..771b4e9 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -591,7 +591,7 @@ interrupt_end_book3e:
 
 /* External Input Interrupt */
 	MASKABLE_EXCEPTION(0x500, BOOKE_INTERRUPT_EXTERNAL,
-			   external_input, .do_IRQ, ACK_NONE)
+			   external_input, do_IRQ, ACK_NONE)
 
 /* Alignment */
 	START_EXCEPTION(alignment);
@@ -676,11 +676,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 
 /* Decrementer Interrupt */
 	MASKABLE_EXCEPTION(0x900, BOOKE_INTERRUPT_DECREMENTER,
-			   decrementer, .timer_interrupt, ACK_DEC)
+			   decrementer, timer_interrupt, ACK_DEC)
 
 /* Fixed Interval Timer Interrupt */
 	MASKABLE_EXCEPTION(0x980, BOOKE_INTERRUPT_FIT,
-			   fixed_interval, .unknown_exception, ACK_FIT)
+			   fixed_interval, unknown_exception, ACK_FIT)
 
 /* Watchdog Timer Interrupt */
 	START_EXCEPTION(watchdog);
@@ -855,7 +855,7 @@ kernel_dbg_exc:
 
 /* Doorbell interrupt */
 	MASKABLE_EXCEPTION(0x280, BOOKE_INTERRUPT_DOORBELL,
-			   doorbell, .doorbell_exception, ACK_NONE)
+			   doorbell, doorbell_exception, ACK_NONE)
 
 /* Doorbell critical Interrupt */
 	START_EXCEPTION(doorbell_crit);
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a695a23..ce50e64 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -771,38 +771,38 @@ kvmppc_skip_Hinterrupt:
 
 /*** Common interrupt handlers ***/
 
-	STD_EXCEPTION_COMMON(0x100, system_reset, .system_reset_exception)
+	STD_EXCEPTION_COMMON(0x100, system_reset, system_reset_exception)
 
 	STD_EXCEPTION_COMMON_ASYNC(0x500, hardware_interrupt, do_IRQ)
-	STD_EXCEPTION_COMMON_ASYNC(0x900, decrementer, .timer_interrupt)
-	STD_EXCEPTION_COMMON(0x980, hdecrementer, .hdec_interrupt)
+	STD_EXCEPTION_COMMON_ASYNC(0x900, decrementer, timer_interrupt)
+	STD_EXCEPTION_COMMON(0x980, hdecrementer, hdec_interrupt)
 #ifdef CONFIG_PPC_DOORBELL
-	STD_EXCEPTION_COMMON_ASYNC(0xa00, doorbell_super, .doorbell_exception)
+	STD_EXCEPTION_COMMON_ASYNC(0xa00, doorbell_super, doorbell_exception)
 #else
-	STD_EXCEPTION_COMMON_ASYNC(0xa00, doorbell_super, .unknown_exception)
+	STD_EXCEPTION_COMMON_ASYNC(0xa00, doorbell_super, unknown_exception)
 #endif
-	STD_EXCEPTION_COMMON(0xb00, trap_0b, .unknown_exception)
-	STD_EXCEPTION_COMMON(0xd00, single_step, .single_step_exception)
-	STD_EXCEPTION_COMMON(0xe00, trap_0e, .unknown_exception)
-	STD_EXCEPTION_COMMON(0xe40, emulation_assist, .emulation_assist_interrupt)
-	STD_EXCEPTION_COMMON(0xe60, hmi_exception, .unknown_exception)
+	STD_EXCEPTION_COMMON(0xb00, trap_0b, unknown_exception)
+	STD_EXCEPTION_COMMON(0xd00, single_step, single_step_exception)
+	STD_EXCEPTION_COMMON(0xe00, trap_0e, unknown_exception)
+	STD_EXCEPTION_COMMON(0xe40, emulation_assist, emulation_assist_interrupt)
+	STD_EXCEPTION_COMMON(0xe60, hmi_exception, unknown_exception)
 #ifdef CONFIG_PPC_DOORBELL
-	STD_EXCEPTION_COMMON_ASYNC(0xe80, h_doorbell, .doorbell_exception)
+	STD_EXCEPTION_COMMON_ASYNC(0xe80, h_doorbell, doorbell_exception)
 #else
-	STD_EXCEPTION_COMMON_ASYNC(0xe80, h_doorbell, .unknown_exception)
+	STD_EXCEPTION_COMMON_ASYNC(0xe80, h_doorbell, unknown_exception)
 #endif
-	STD_EXCEPTION_COMMON_ASYNC(0xf00, performance_monitor, .performance_monitor_exception)
-	STD_EXCEPTION_COMMON(0x1300, instruction_breakpoint, .instruction_breakpoint_exception)
-	STD_EXCEPTION_COMMON(0x1502, denorm, .unknown_exception)
+	STD_EXCEPTION_COMMON_ASYNC(0xf00, performance_monitor, performance_monitor_exception)
+	STD_EXCEPTION_COMMON(0x1300, instruction_breakpoint, instruction_breakpoint_exception)
+	STD_EXCEPTION_COMMON(0x1502, denorm, unknown_exception)
 #ifdef CONFIG_ALTIVEC
-	STD_EXCEPTION_COMMON(0x1700, altivec_assist, .altivec_assist_exception)
+	STD_EXCEPTION_COMMON(0x1700, altivec_assist, altivec_assist_exception)
 #else
-	STD_EXCEPTION_COMMON(0x1700, altivec_assist, .unknown_exception)
+	STD_EXCEPTION_COMMON(0x1700, altivec_assist, unknown_exception)
 #endif
 #ifdef CONFIG_CBE_RAS
-	STD_EXCEPTION_COMMON(0x1200, cbe_system_error, .cbe_system_error_exception)
-	STD_EXCEPTION_COMMON(0x1600, cbe_maintenance, .cbe_maintenance_exception)
-	STD_EXCEPTION_COMMON(0x1800, cbe_thermal, .cbe_thermal_exception)
+	STD_EXCEPTION_COMMON(0x1200, cbe_system_error, cbe_system_error_exception)
+	STD_EXCEPTION_COMMON(0x1600, cbe_maintenance, cbe_maintenance_exception)
+	STD_EXCEPTION_COMMON(0x1800, cbe_thermal, cbe_thermal_exception)
 #endif /* CONFIG_CBE_RAS */
 
 	/*
@@ -1075,7 +1075,7 @@ instruction_access_common:
 	li	r5,0x400
 	b	do_hash_page		/* Try to handle as hpte fault */
 
-	STD_EXCEPTION_COMMON(0xe20, h_instr_storage, .unknown_exception)
+	STD_EXCEPTION_COMMON(0xe20, h_instr_storage, unknown_exception)
 
 /*
  * Here is the common SLB miss user that is used when going to virtual
@@ -1292,8 +1292,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	bl	vsx_unavailable_exception
 	b	ret_from_except
 
-	STD_EXCEPTION_COMMON(0xf60, facility_unavailable, .facility_unavailable_exception)
-	STD_EXCEPTION_COMMON(0xf80, hv_facility_unavailable, .facility_unavailable_exception)
+	STD_EXCEPTION_COMMON(0xf60, facility_unavailable, facility_unavailable_exception)
+	STD_EXCEPTION_COMMON(0xf80, hv_facility_unavailable, facility_unavailable_exception)
 
 	.align	7
 	.globl	__end_handlers
-- 
1.8.3.2
