Return-Path: <B02008@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D09262C02B4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 01:36:01 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] powerpc/fsl-booke: Use common defines for SPE/FP
 interrupts numbers
Date: Mon, 1 Jul 2013 18:35:31 +0300
Message-ID: <1372692931-16324-2-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1372692931-16324-1-git-send-email-mihai.caraman@freescale.com>
References: <1372692931-16324-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Book3E some SPE/FP/AltiVec interrupts share the same number. Use
common defines to indentify these numbers.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kernel/head_fsl_booke.S |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index d10a7ca..f1dd4a9 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -555,28 +555,28 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 #ifdef CONFIG_SPE
 	/* SPE Unavailable */
 	START_EXCEPTION(SPEUnavailable)
-	NORMAL_EXCEPTION_PROLOG(SPE_UNAVAIL)
+	NORMAL_EXCEPTION_PROLOG(SPE_ALTIVEC_UNAVAIL)
 	beq	1f
 	bl	load_up_spe
 	b	fast_exception_return
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_EE_LITE(0x2010, KernelSPE)
 #else
-	EXCEPTION(0x2020, SPE_UNAVAIL, SPEUnavailable, \
+	EXCEPTION(0x2020, SPE_ALTIVEC_UNAVAIL, SPEUnavailable, \
 		  unknown_exception, EXC_XFER_EE)
 #endif /* CONFIG_SPE */
 
 	/* SPE Floating Point Data */
 #ifdef CONFIG_SPE
-	EXCEPTION(0x2030, SPE_FP_DATA, SPEFloatingPointData, \
-		  SPEFloatingPointException, EXC_XFER_EE);
+	EXCEPTION(0x2030, SPE_FP_DATA_ALTIVEC_ASSIST, SPEFloatingPointData,
+ 		  SPEFloatingPointException, EXC_XFER_EE)
 
 	/* SPE Floating Point Round */
 	EXCEPTION(0x2050, SPE_FP_ROUND, SPEFloatingPointRound, \
 		  SPEFloatingPointRoundException, EXC_XFER_EE)
 #else
-	EXCEPTION(0x2040, SPE_FP_DATA, SPEFloatingPointData, \
-		  unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2040, SPE_FP_DATA_ALTIVEC_ASSIST, SPEFloatingPointData,
+ 		  unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0x2050, SPE_FP_ROUND, SPEFloatingPointRound, \
 		  unknown_exception, EXC_XFER_EE)
 #endif /* CONFIG_SPE */
-- 
1.7.3.4
