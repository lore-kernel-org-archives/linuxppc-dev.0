Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/4] powerpc: Remove unreachable relocation on exception
 handlers
Date: Tue, 25 Jun 2013 17:47:54 +1000
Message-Id: <1372146477-4338-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have relocation on exception handlers defined for h_data_storage and
h_instr_storage. However we will never take relocation on exceptions for
these because they can only come from a guest, and we never take
relocation on exceptions when we transition from guest to host.

We also have a handler for hmi_exception (Hypervisor Maintenance) which
is defined in the architecture to never be delivered with relocation on,
see see v2.07 Book III-S section 6.5.

So remove the handlers, leaving a branch to self just to be double extra
paranoid.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S |   18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 40e4a17..0a9fdea 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -793,14 +793,10 @@ system_call_relon_pSeries:
 	STD_RELON_EXCEPTION_PSERIES(0x4d00, 0xd00, single_step)
 
 	. = 0x4e00
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	h_data_storage_relon_hv
+	b	.	/* Can't happen, see v2.07 Book III-S section 6.5 */
 
 	. = 0x4e20
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	h_instr_storage_relon_hv
+	b	.	/* Can't happen, see v2.07 Book III-S section 6.5 */
 
 	. = 0x4e40
 	SET_SCRATCH0(r13)
@@ -808,9 +804,7 @@ system_call_relon_pSeries:
 	b	emulation_assist_relon_hv
 
 	. = 0x4e60
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	hmi_exception_relon_hv
+	b	.	/* Can't happen, see v2.07 Book III-S section 6.5 */
 
 	. = 0x4e80
 	SET_SCRATCH0(r13)
@@ -1180,14 +1174,8 @@ tm_unavailable_common:
 __end_handlers:
 
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-	STD_RELON_EXCEPTION_HV_OOL(0xe00, h_data_storage)
-	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe00)
-	STD_RELON_EXCEPTION_HV_OOL(0xe20, h_instr_storage)
-	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe20)
 	STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe40)
-	STD_RELON_EXCEPTION_HV_OOL(0xe60, hmi_exception)
-	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe60)
 	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe80)
 
-- 
1.7.10.4
