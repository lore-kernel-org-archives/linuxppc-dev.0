Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Wed, 25 Jun 2008 14:07:18 +1000
Subject: [PATCH 3/9] powerpc: Move altivec_unavailable
In-Reply-To: <1214366837.623950.515350956858.qpush@coopers>
Message-Id: <20080625040718.0BA6070298@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move the altivec_unavailable code, to make room at 0xf40 where the
vsx_unavailable exception will be.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kernel/head_64.S |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/head_64.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/head_64.S
@@ -275,7 +275,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	. = 0xf00
 	b	performance_monitor_pSeries
 
-	STD_EXCEPTION_PSERIES(0xf20, altivec_unavailable)
+	. = 0xf20
+	b	altivec_unavailable_pSeries
 
 #ifdef CONFIG_CBE_RAS
 	HSTD_EXCEPTION_PSERIES(0x1200, cbe_system_error)
@@ -295,6 +296,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 
 	/* moved from 0xf00 */
 	STD_EXCEPTION_PSERIES(., performance_monitor)
+	STD_EXCEPTION_PSERIES(., altivec_unavailable)
 
 /*
  * An interrupt came in while soft-disabled; clear EE in SRR1,
