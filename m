Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/6] powerpc: Fix location and rename exception trampolines
Date: Thu, 15 Aug 2013 15:22:17 +1000
Message-Id: <1376544139-26783-4-git-send-email-michael@ellerman.id.au>
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

The symbols that name some of our exception trampolines are ahead of the
location they name. In most cases this is OK because the code is tightly
packed, but in some cases it means the symbol floats ahead of the
correct location, eg:

  c000000000000ea0 <performance_monitor_pSeries_1>:
          ...
  c000000000000f00:       7d b2 43 a6     mtsprg  2,r13

Fix them all by moving the symbol after the set of the location.

While we're moving them anyway, rename them to loose the camelcase and
to make it clear that they are trampolines.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 902ca3c..ae902cae 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -323,32 +323,32 @@ hv_exception_trampoline:
 	 * prolog code of the PerformanceMonitor one. A little
 	 * trickery is thus necessary
 	 */
-performance_monitor_pSeries_1:
 	. = 0xf00
+performance_monitor_pseries_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	performance_monitor_pSeries
 
-altivec_unavailable_pSeries_1:
 	. = 0xf20
+altivec_unavailable_pseries_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	altivec_unavailable_pSeries
 
-vsx_unavailable_pSeries_1:
 	. = 0xf40
+vsx_unavailable_pseries_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	vsx_unavailable_pSeries
 
-facility_unavailable_trampoline:
 	. = 0xf60
+facility_unavailable_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	facility_unavailable_pSeries
 
-hv_facility_unavailable_trampoline:
 	. = 0xf80
+hv_facility_unavailable_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	facility_unavailable_hv
@@ -820,32 +820,32 @@ system_call_relon_pSeries:
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	h_doorbell_relon_hv
 
-performance_monitor_relon_pSeries_1:
 	. = 0x4f00
+performance_monitor_relon_pseries_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	performance_monitor_relon_pSeries
 
-altivec_unavailable_relon_pSeries_1:
 	. = 0x4f20
+altivec_unavailable_relon_pseries_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	altivec_unavailable_relon_pSeries
 
-vsx_unavailable_relon_pSeries_1:
 	. = 0x4f40
+vsx_unavailable_relon_pseries_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	vsx_unavailable_relon_pSeries
 
-facility_unavailable_relon_trampoline:
 	. = 0x4f60
+facility_unavailable_relon_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	facility_unavailable_relon_pSeries
 
-hv_facility_unavailable_relon_trampoline:
 	. = 0x4f80
+hv_facility_unavailable_relon_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	hv_facility_unavailable_relon_hv
-- 
1.8.1.2
