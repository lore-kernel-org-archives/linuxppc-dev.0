Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bsp10D4TzF0f7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 23:07:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	anton@samba.org,
	paulus@samba.org
Subject: [PATCH 08/16] powerpc/64s: Remove PSERIES from the NORI macros
Date: Thu, 26 Jul 2018 23:07:09 +1000
Message-Id: <20180726130717.18761-9-mpe@ellerman.id.au>
In-Reply-To: <20180726130717.18761-1-mpe@ellerman.id.au>
References: <20180726130717.18761-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h | 10 +++++-----
 arch/powerpc/kernel/exceptions-64s.S     | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 82d137778cb1..445134f3a227 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -329,7 +329,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	__EXCEPTION_PROLOG_2(label, h)
 
 /* _NORI variant keeps MSR_RI clear */
-#define __EXCEPTION_PROLOG_PSERIES_1_NORI(label, h)			\
+#define __EXCEPTION_PROLOG_2_NORI(label, h)				\
 	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
 	xori	r10,r10,MSR_RI;		/* Clear MSR_RI */		\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
@@ -340,8 +340,8 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	h##RFI_TO_KERNEL;						\
 	b	.	/* prevent speculative execution */
 
-#define EXCEPTION_PROLOG_PSERIES_1_NORI(label, h)			\
-	__EXCEPTION_PROLOG_PSERIES_1_NORI(label, h)
+#define EXCEPTION_PROLOG_2_NORI(label, h)				\
+	__EXCEPTION_PROLOG_2_NORI(label, h)
 
 #define EXCEPTION_PROLOG_PSERIES(area, label, h, extra, vec)		\
 	SET_SCRATCH0(r13);		/* save r13 */			\
@@ -418,10 +418,10 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #endif
 
 /* Do not enable RI */
-#define EXCEPTION_PROLOG_PSERIES_NORI(area, label, h, extra, vec)	\
+#define EXCEPTION_PROLOG_NORI(area, label, h, extra, vec)		\
 	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_PSERIES_1_NORI(label, h);
+	EXCEPTION_PROLOG_2_NORI(label, h);
 
 
 #define __KVM_HANDLER(area, h, n)					\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d1a189f296f3..a5cef69d54b4 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -126,8 +126,8 @@ EXC_REAL_BEGIN(system_reset, 0x100, 0x100)
 	 * MSR_RI is not enabled, because PACA_EXNMI and nmi stack is
 	 * being used, so a nested NMI exception would corrupt it.
 	 */
-	EXCEPTION_PROLOG_PSERIES_NORI(PACA_EXNMI, system_reset_common, EXC_STD,
-				 IDLETEST, 0x100)
+	EXCEPTION_PROLOG_NORI(PACA_EXNMI, system_reset_common, EXC_STD,
+			      IDLETEST, 0x100)
 
 EXC_REAL_END(system_reset, 0x100, 0x100)
 EXC_VIRT_NONE(0x4100, 0x100)
@@ -230,8 +230,8 @@ EXC_COMMON_BEGIN(system_reset_common)
 TRAMP_REAL_BEGIN(system_reset_fwnmi)
 	SET_SCRATCH0(r13)		/* save r13 */
 	/* See comment at system_reset exception */
-	EXCEPTION_PROLOG_PSERIES_NORI(PACA_EXNMI, system_reset_common,
-						EXC_STD, NOTEST, 0x100)
+	EXCEPTION_PROLOG_NORI(PACA_EXNMI, system_reset_common, EXC_STD,
+			      NOTEST, 0x100)
 #endif /* CONFIG_PPC_PSERIES */
 
 
@@ -337,7 +337,7 @@ machine_check_pSeries_0:
 	 * nested machine check corrupts it. machine_check_common enables
 	 * MSR_RI.
 	 */
-	EXCEPTION_PROLOG_PSERIES_1_NORI(machine_check_common, EXC_STD)
+	EXCEPTION_PROLOG_2_NORI(machine_check_common, EXC_STD)
 
 TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
 
-- 
2.14.1
