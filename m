Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2J44mXzDrMq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 23/42] powerpc/64s: Consolidate Hypervisor Emulation
 Assistance 0xe40 interrupt
Date: Wed,  5 Oct 2016 11:22:45 +1100
Message-Id: <1475626984-18770-24-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
References: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 5b2afa5ef919..128b21b42f8b 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -937,6 +937,12 @@ EXC_COMMON(h_instr_storage_common, 0xe20, unknown_exception)
 
 
 __EXC_REAL_OOL_HV(emulation_assist, 0xe40, 0xe60)
+__TRAMP_REAL_REAL_OOL_HV(emulation_assist, 0xe40)
+__EXC_VIRT_OOL_HV(emulation_assist, 0x4e40, 0x4e60)
+__TRAMP_REAL_VIRT_OOL_HV(emulation_assist, 0xe40)
+TRAMP_KVM_HV(PACA_EXGEN, 0xe40)
+EXC_COMMON(emulation_assist_common, 0xe40, emulation_assist_interrupt)
+
 
 __EXC_REAL_OOL_HV_DIRECT(hmi_exception, 0xe60, 0xe80, hmi_exception_early)
 
@@ -1082,9 +1088,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 #endif
 
 	/* moved from 0xe00 */
-__TRAMP_REAL_REAL_OOL_HV(emulation_assist, 0xe40)
-TRAMP_KVM_HV(PACA_EXGEN, 0xe40)
-
 __TRAMP_REAL_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
 
@@ -1230,7 +1233,6 @@ TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-EXC_COMMON(emulation_assist_common, 0xe40, emulation_assist_interrupt)
 EXC_COMMON_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
 #ifdef CONFIG_PPC_DOORBELL
 EXC_COMMON_ASYNC(h_doorbell_common, 0xe80, doorbell_exception)
@@ -1263,8 +1265,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-__EXC_VIRT_OOL_HV(emulation_assist, 0x4e40, 0x4e60)
-
 EXC_VIRT_BEGIN(unused, 0x4e60, 0x4e80)
 	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
 EXC_VIRT_END(unused, 0x4e60, 0x4e80)
@@ -1374,7 +1374,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	b	ret_from_except
 
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-__TRAMP_REAL_VIRT_OOL_HV(emulation_assist, 0xe40)
 __TRAMP_REAL_VIRT_OOL_MASKABLE_HV(h_doorbell, 0xe80)
 __TRAMP_REAL_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0xea0)
 __TRAMP_REAL_VIRT_OOL(performance_monitor, 0xf00)
-- 
2.7.4
