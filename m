Return-Path: <paulus@ozlabs.org>
Date: Tue, 5 Feb 2013 15:09:40 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexander Graf <agraf@suse.de>
Subject: [PATCH 1/4] powerpc: Remove Cell-specific relocation-on interrupt
 vector code
Message-ID: <20130205040940.GB20303@drongo>
References: <20130205040902.GA20303@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130205040902.GA20303@drongo>
Cc: kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Cell processor doesn't support relocation-on interrupts, so we
don't need relocation-on versions of the interrupt vectors that are
purely Cell-specific.  This removes them.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/exceptions-64s.S |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 7a1c87c..dc64165 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -817,26 +817,16 @@ vsx_unavailable_relon_pSeries_1:
 	. = 0x4f40
 	b	vsx_unavailable_relon_pSeries
 
-#ifdef CONFIG_CBE_RAS
-	STD_RELON_EXCEPTION_HV(0x5200, 0x1202, cbe_system_error)
-#endif /* CONFIG_CBE_RAS */
 	STD_RELON_EXCEPTION_PSERIES(0x5300, 0x1300, instruction_breakpoint)
 #ifdef CONFIG_PPC_DENORMALISATION
 	. = 0x5500
 	b	denorm_exception_hv
 #endif
-#ifdef CONFIG_CBE_RAS
-	STD_RELON_EXCEPTION_HV(0x5600, 0x1602, cbe_maintenance)
-#else
 #ifdef CONFIG_HVC_SCOM
 	STD_RELON_EXCEPTION_HV(0x5600, 0x1600, maintence_interrupt)
 	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1600)
 #endif /* CONFIG_HVC_SCOM */
-#endif /* CONFIG_CBE_RAS */
 	STD_RELON_EXCEPTION_PSERIES(0x5700, 0x1700, altivec_assist)
-#ifdef CONFIG_CBE_RAS
-	STD_RELON_EXCEPTION_HV(0x5800, 0x1802, cbe_thermal)
-#endif /* CONFIG_CBE_RAS */
 
 	/* Other future vectors */
 	.align	7
-- 
1.7.10.4
