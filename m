Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsPxH4b5MzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 08:58:27 +1000 (AEST)
Message-ID: <1468709905.20552.165.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/book64s: Move a few exception common handlers to
 make room
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Date: Sat, 16 Jul 2016 17:58:25 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves the CBE RAS and facility unavailable "common" handlers
down to after the FWNMI page.

This frees up some space in the very demanded spaces before the
relocation-on vectors and before the FWNMI page. They are still
within 64K of __start, so CONFIG_RELOCATABLE should still work.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Written in an airline lounge after about 30h spent in planes and
airports, so I apologize in advance if something is just plain
wrong here, but it seems to compile ;-)

 arch/powerpc/kernel/exceptions-64s.S | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4c94406..92bab94 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -762,11 +762,6 @@ kvmppc_skip_Hinterrupt:
 #else
 	STD_EXCEPTION_COMMON(0x1700, altivec_assist, unknown_exception)
 #endif
-#ifdef CONFIG_CBE_RAS
-	STD_EXCEPTION_COMMON(0x1200, cbe_system_error, cbe_system_error_exception)
-	STD_EXCEPTION_COMMON(0x1600, cbe_maintenance, cbe_maintenance_exception)
-	STD_EXCEPTION_COMMON(0x1800, cbe_thermal, cbe_thermal_exception)
-#endif /* CONFIG_CBE_RAS */
 
 	/*
 	 * Relocation-on interrupts: A subset of the interrupts can be delivered
@@ -1131,9 +1126,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	bl	vsx_unavailable_exception
 	b	ret_from_except
 
-	STD_EXCEPTION_COMMON(0xf60, facility_unavailable, facility_unavailable_exception)
-	STD_EXCEPTION_COMMON(0xf80, hv_facility_unavailable, facility_unavailable_exception)
-
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
 	STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
 	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell)
@@ -1170,6 +1162,15 @@ fwnmi_data_area:
 	. = 0x8000
 #endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
 
+	STD_EXCEPTION_COMMON(0xf60, facility_unavailable, facility_unavailable_exception)
+	STD_EXCEPTION_COMMON(0xf80, hv_facility_unavailable, facility_unavailable_exception)
+
+#ifdef CONFIG_CBE_RAS
+	STD_EXCEPTION_COMMON(0x1200, cbe_system_error, cbe_system_error_exception)
+	STD_EXCEPTION_COMMON(0x1600, cbe_maintenance, cbe_maintenance_exception)
+	STD_EXCEPTION_COMMON(0x1800, cbe_thermal, cbe_thermal_exception)
+#endif /* CONFIG_CBE_RAS */
+
 	.globl hmi_exception_early
 hmi_exception_early:
 	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0xe60)
