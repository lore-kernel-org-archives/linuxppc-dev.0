Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2J0cFpzDrMq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 22/42] powerpc/64s: Consolidate Hypervisor Instruction
 Storage 0xe20 interrupt
Date: Wed,  5 Oct 2016 11:22:44 +1100
Message-Id: <1475626984-18770-23-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 10cf57eb2e77..5b2afa5ef919 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -928,6 +928,13 @@ EXC_COMMON(trap_0e_common, 0xe00, unknown_exception)
 
 
 __EXC_REAL_OOL_HV(h_instr_storage, 0xe20, 0xe40)
+__TRAMP_REAL_REAL_OOL_HV(h_instr_storage, 0xe20)
+EXC_VIRT_BEGIN(unused, 0x4e20, 0x4e40)
+	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
+EXC_VIRT_END(unused, 0x4e20, 0x4e40)
+TRAMP_KVM_HV(PACA_EXGEN, 0xe20)
+EXC_COMMON(h_instr_storage_common, 0xe20, unknown_exception)
+
 
 __EXC_REAL_OOL_HV(emulation_assist, 0xe40, 0xe60)
 
@@ -1075,9 +1082,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 #endif
 
 	/* moved from 0xe00 */
-__TRAMP_REAL_REAL_OOL_HV(h_instr_storage, 0xe20)
-TRAMP_KVM_HV(PACA_EXGEN, 0xe20)
-
 __TRAMP_REAL_REAL_OOL_HV(emulation_assist, 0xe40)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe40)
 
@@ -1259,10 +1263,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT_BEGIN(unused, 0x4e20, 0x4e40)
-	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-EXC_VIRT_END(unused, 0x4e20, 0x4e40)
-
 __EXC_VIRT_OOL_HV(emulation_assist, 0x4e40, 0x4e60)
 
 EXC_VIRT_BEGIN(unused, 0x4e60, 0x4e80)
@@ -1308,8 +1308,6 @@ EXC_VIRT_NONE(0x5800, 0x5900)
 EXC_COMMON_BEGIN(ppc64_runlatch_on_trampoline)
 	b	__ppc64_runlatch_on
 
-EXC_COMMON(h_instr_storage_common, 0xe20, unknown_exception)
-
 EXC_COMMON_BEGIN(altivec_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
 #ifdef CONFIG_ALTIVEC
-- 
2.7.4
