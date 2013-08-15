Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 5/6] powerpc: Add more exception trampolines for hypervisor
 exceptions
Date: Thu, 15 Aug 2013 15:22:18 +1000
Message-Id: <1376544139-26783-5-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1376544139-26783-1-git-send-email-michael@ellerman.id.au>
References: <1376544139-26783-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes back traces and profiles easier to read.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index ae902cae..e41f066 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -293,27 +293,31 @@ system_call_pSeries:
 	 * out of line to handle them
 	 */
 	. = 0xe00
-hv_exception_trampoline:
+hv_data_storage_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	h_data_storage_hv
 
 	. = 0xe20
+hv_instr_storage_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	h_instr_storage_hv
 
 	. = 0xe40
+emulation_assist_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	emulation_assist_hv
 
 	. = 0xe60
+hv_exception_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	hmi_exception_hv
 
 	. = 0xe80
+hv_doorbell_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	h_doorbell_hv
@@ -808,6 +812,7 @@ system_call_relon_pSeries:
 	b	.	/* Can't happen, see v2.07 Book III-S section 6.5 */
 
 	. = 0x4e40
+emulation_assist_relon_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	emulation_assist_relon_hv
@@ -816,6 +821,7 @@ system_call_relon_pSeries:
 	b	.	/* Can't happen, see v2.07 Book III-S section 6.5 */
 
 	. = 0x4e80
+h_doorbell_relon_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	h_doorbell_relon_hv
-- 
1.8.1.2
