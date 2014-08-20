Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0190.outbound.protection.outlook.com [207.46.163.190])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1488F1A001A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 23:09:30 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 2/2] powerpc/booke: Revert SPE/AltiVec common defines for
 interrupt numbers
Date: Wed, 20 Aug 2014 16:09:04 +0300
Message-ID: <1408540144-24436-2-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1408540144-24436-1-git-send-email-mihai.caraman@freescale.com>
References: <1408540144-24436-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Mihai Caraman <mihai.caraman@freescale.com>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Book3E specification defines shared interrupt numbers for SPE and AltiVec
units. Still SPE is present in e200/e500v2 cores while AltiVec is present in
e6500 core. So we can currently decide at compile-time which unit to support
exclusively. As Alexander Graf suggested, this will improve code readability
especially in KVM.

Use distinct defines to identify SPE/AltiVec interrupt numbers, reverting
c58ce397 and 6b310fc5 patches that added common defines.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>
Cc: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/exceptions-64e.S | 4 ++--
 arch/powerpc/kernel/head_fsl_booke.S | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index bb9cac6..3e68d1c 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -635,7 +635,7 @@ interrupt_end_book3e:
 
 /* Altivec Unavailable Interrupt */
 	START_EXCEPTION(altivec_unavailable);
-	NORMAL_EXCEPTION_PROLOG(0x200, BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL,
+	NORMAL_EXCEPTION_PROLOG(0x200, BOOKE_INTERRUPT_ALTIVEC_UNAVAIL,
 				PROLOG_ADDITION_NONE)
 	/* we can probably do a shorter exception entry for that one... */
 	EXCEPTION_COMMON(0x200)
@@ -658,7 +658,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 /* AltiVec Assist */
 	START_EXCEPTION(altivec_assist);
 	NORMAL_EXCEPTION_PROLOG(0x220,
-				BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST,
+				BOOKE_INTERRUPT_ALTIVEC_ASSIST,
 				PROLOG_ADDITION_NONE)
 	EXCEPTION_COMMON(0x220)
 	INTS_DISABLE
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 90f487f..fffd1f9 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -617,27 +617,27 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 #ifdef CONFIG_SPE
 	/* SPE Unavailable */
 	START_EXCEPTION(SPEUnavailable)
-	NORMAL_EXCEPTION_PROLOG(SPE_ALTIVEC_UNAVAIL)
+	NORMAL_EXCEPTION_PROLOG(SPE_UNAVAIL)
 	beq	1f
 	bl	load_up_spe
 	b	fast_exception_return
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_EE_LITE(0x2010, KernelSPE)
 #elif defined(CONFIG_SPE_POSSIBLE)
-	EXCEPTION(0x2020, SPE_ALTIVEC_UNAVAIL, SPEUnavailable, \
+	EXCEPTION(0x2020, SPE_UNAVAIL, SPEUnavailable, \
 		  unknown_exception, EXC_XFER_EE)
 #endif /* CONFIG_SPE_POSSIBLE */
 
 	/* SPE Floating Point Data */
 #ifdef CONFIG_SPE
-	EXCEPTION(0x2030, SPE_FP_DATA_ALTIVEC_ASSIST, SPEFloatingPointData,
+	EXCEPTION(0x2030, SPE_FP_DATA, SPEFloatingPointData,
 		  SPEFloatingPointException, EXC_XFER_EE)
 
 	/* SPE Floating Point Round */
 	EXCEPTION(0x2050, SPE_FP_ROUND, SPEFloatingPointRound, \
 		  SPEFloatingPointRoundException, EXC_XFER_EE)
 #elif defined(CONFIG_SPE_POSSIBLE)
-	EXCEPTION(0x2040, SPE_FP_DATA_ALTIVEC_ASSIST, SPEFloatingPointData,
+	EXCEPTION(0x2040, SPE_FP_DATA, SPEFloatingPointData,
 		  unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0x2050, SPE_FP_ROUND, SPEFloatingPointRound, \
 		  unknown_exception, EXC_XFER_EE)
-- 
1.7.11.7
