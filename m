Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBVp2Gp1zDsh7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:22 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id s3so576119pay.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 21/41] powerpc/64s: consolidate Hypervisor Instruction Storage
 0xe20 interrupt
Date: Wed, 21 Sep 2016 17:43:47 +1000
Message-Id: <20160921074407.4885-22-npiggin@gmail.com>
In-Reply-To: <20160921074407.4885-1-npiggin@gmail.com>
References: <20160921074407.4885-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 8dceb35..75dcc08 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -925,6 +925,13 @@ COMMON_HANDLER(trap_0e_common, 0xe00, unknown_exception)
 
 
 __VECTOR_HANDLER_REAL_OOL_HV(h_instr_storage, 0xe20, 0xe40)
+__TRAMP_HANDLER_REAL_OOL_HV(h_instr_storage, 0xe20)
+VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e20, 0x4e40)
+	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
+VECTOR_HANDLER_VIRT_END(unused, 0x4e20, 0x4e40)
+TRAMP_KVM_HV(PACA_EXGEN, 0xe20)
+COMMON_HANDLER(h_instr_storage_common, 0xe20, unknown_exception)
+
 
 __VECTOR_HANDLER_REAL_OOL_HV(emulation_assist, 0xe40, 0xe60)
 
@@ -1074,9 +1081,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 TRAMP_HANDLER_END(denorm_assist)
 
 	/* moved from 0xe00 */
-__TRAMP_HANDLER_REAL_OOL_HV(h_instr_storage, 0xe20)
-TRAMP_KVM_HV(PACA_EXGEN, 0xe20)
-
 __TRAMP_HANDLER_REAL_OOL_HV(emulation_assist, 0xe40)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe40)
 
@@ -1264,10 +1268,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e20, 0x4e40)
-	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
-VECTOR_HANDLER_VIRT_END(unused, 0x4e20, 0x4e40)
-
 __VECTOR_HANDLER_VIRT_OOL_HV(emulation_assist, 0x4e40, 0x4e60)
 
 VECTOR_HANDLER_VIRT_BEGIN(unused, 0x4e60, 0x4e80)
@@ -1314,8 +1314,6 @@ TRAMP_HANDLER_BEGIN(ppc64_runlatch_on_trampoline)
 	b	__ppc64_runlatch_on
 TRAMP_HANDLER_END(ppc64_runlatch_on_trampoline)
 
-COMMON_HANDLER(h_instr_storage_common, 0xe20, unknown_exception)
-
 COMMON_HANDLER_BEGIN(altivec_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
 #ifdef CONFIG_ALTIVEC
-- 
2.9.3
