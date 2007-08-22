Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B04B3DDEBC
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 13:54:28 +1000 (EST)
Date: Wed, 22 Aug 2007 13:49:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Exception numbers are not relevent to iSeries
Message-Id: <20070822134941.f077b982.sfr@canb.auug.org.au>
In-Reply-To: <20070822134837.ec6501f9.sfr@canb.auug.org.au>
References: <20070822134458.ed7a89f9.sfr@canb.auug.org.au>
	<20070822134644.b3eeffa6.sfr@canb.auug.org.au>
	<20070822134724.f14053f5.sfr@canb.auug.org.au>
	<20070822134837.ec6501f9.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

so remove them from the macros.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/exception.S |   24 ++++++++++++------------
 arch/powerpc/platforms/iseries/exception.h |    4 ++--
 2 files changed, 14 insertions(+), 14 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/arch/powerpc/platforms/iseries/exception.S b/arch/powerpc/platforms/iseries/exception.S
index e9a3435..5381038 100644
--- a/arch/powerpc/platforms/iseries/exception.S
+++ b/arch/powerpc/platforms/iseries/exception.S
@@ -88,7 +88,7 @@ iSeries_secondary_smp_loop:
 
 /***  ISeries-LPAR interrupt handlers ***/
 
-	STD_EXCEPTION_ISERIES(0x200, machine_check, PACA_EXMC)
+	STD_EXCEPTION_ISERIES(machine_check, PACA_EXMC)
 
 	.globl data_access_iSeries
 data_access_iSeries:
@@ -137,7 +137,7 @@ data_access_slb_iSeries:
 	ld	r12,LPPACASRR1(r12)
 	b	.slb_miss_realmode
 
-	STD_EXCEPTION_ISERIES(0x400, instruction_access, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES(instruction_access, PACA_EXGEN)
 
 	.globl	instruction_access_slb_iSeries
 instruction_access_slb_iSeries:
@@ -176,13 +176,13 @@ slb_miss_user_iseries:
 	b	slb_miss_user_common
 #endif
 
-	MASKABLE_EXCEPTION_ISERIES(0x500, hardware_interrupt)
-	STD_EXCEPTION_ISERIES(0x600, alignment, PACA_EXGEN)
-	STD_EXCEPTION_ISERIES(0x700, program_check, PACA_EXGEN)
-	STD_EXCEPTION_ISERIES(0x800, fp_unavailable, PACA_EXGEN)
-	MASKABLE_EXCEPTION_ISERIES(0x900, decrementer)
-	STD_EXCEPTION_ISERIES(0xa00, trap_0a, PACA_EXGEN)
-	STD_EXCEPTION_ISERIES(0xb00, trap_0b, PACA_EXGEN)
+	MASKABLE_EXCEPTION_ISERIES(hardware_interrupt)
+	STD_EXCEPTION_ISERIES(alignment, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES(program_check, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES(fp_unavailable, PACA_EXGEN)
+	MASKABLE_EXCEPTION_ISERIES(decrementer)
+	STD_EXCEPTION_ISERIES(trap_0a, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES(trap_0b, PACA_EXGEN)
 
 	.globl	system_call_iSeries
 system_call_iSeries:
@@ -191,9 +191,9 @@ system_call_iSeries:
 	EXCEPTION_PROLOG_ISERIES_1
 	b	system_call_common
 
-	STD_EXCEPTION_ISERIES( 0xd00, single_step, PACA_EXGEN)
-	STD_EXCEPTION_ISERIES( 0xe00, trap_0e, PACA_EXGEN)
-	STD_EXCEPTION_ISERIES( 0xf00, performance_monitor, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES(single_step, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES(trap_0e, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES(performance_monitor, PACA_EXGEN)
 
 decrementer_iSeries_masked:
 	/* We may not have a valid TOC pointer in here. */
diff --git a/arch/powerpc/platforms/iseries/exception.h b/arch/powerpc/platforms/iseries/exception.h
index 5b3f285..ced45a8 100644
--- a/arch/powerpc/platforms/iseries/exception.h
+++ b/arch/powerpc/platforms/iseries/exception.h
@@ -34,7 +34,7 @@
 	ori	r10,r10,MSR_RI;						\
 	mtmsrd	r10,1
 
-#define STD_EXCEPTION_ISERIES(n, label, area)				\
+#define STD_EXCEPTION_ISERIES(label, area)				\
 	.globl label##_iSeries;						\
 label##_iSeries:							\
 	HMT_MEDIUM;							\
@@ -43,7 +43,7 @@ label##_iSeries:							\
 	EXCEPTION_PROLOG_ISERIES_1;					\
 	b	label##_common
 
-#define MASKABLE_EXCEPTION_ISERIES(n, label)				\
+#define MASKABLE_EXCEPTION_ISERIES(label)				\
 	.globl label##_iSeries;						\
 label##_iSeries:							\
 	HMT_MEDIUM;							\
-- 
1.5.2.4
