Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlcym2H4QzDr07
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 22:54:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 5/5] powerpc/xmon: Dump ISA 2.07 SPRs
Date: Thu,  7 Jul 2016 22:54:30 +1000
Message-Id: <1467896070-15167-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1467896070-15167-1-git-send-email-mpe@ellerman.id.au>
References: <1467896070-15167-1-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/include/asm/reg.h |  1 +
 arch/powerpc/xmon/xmon.c       | 44 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 320136f5fe28..ac4be83f8fdc 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -268,6 +268,7 @@
 #define   DSISR_KEYFAULT	0x00200000	/* Key fault */
 #define SPRN_TBRL	0x10C	/* Time Base Read Lower Register (user, R/O) */
 #define SPRN_TBRU	0x10D	/* Time Base Read Upper Register (user, R/O) */
+#define SPRN_CIR	0x11B	/* Chip Information Register (hyper, R/0) */
 #define SPRN_TBWL	0x11C	/* Time Base Lower Register (super, R/W) */
 #define SPRN_TBWU	0x11D	/* Time Base Upper Register (super, R/W) */
 #define SPRN_TBU40	0x11E	/* Timebase upper 40 bits (hyper, R/W) */
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index ed6f73a74378..e6036b2da69a 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1711,6 +1711,49 @@ static void dump_206_sprs(void)
 #endif
 }
 
+static void dump_207_sprs(void)
+{
+#ifdef CONFIG_PPC64
+	unsigned long msr;
+
+	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
+		return;
+
+	printf("dpdes  = %.16x  tir   = %.16x cir    = %.8x\n",
+		mfspr(SPRN_DPDES), mfspr(SPRN_TIR), mfspr(SPRN_CIR));
+
+	printf("fscr   = %.16x  tar   = %.16x pspb   = %.8x\n",
+		mfspr(SPRN_FSCR), mfspr(SPRN_TAR), mfspr(SPRN_PSPB));
+
+	msr = mfmsr();
+	if (msr & MSR_TM) {
+		/* Only if TM has been enabled in the kernel */
+		printf("tfhar  = %.16x  tfiar = %.16x texasr = %.16x\n",
+			mfspr(SPRN_TFHAR), mfspr(SPRN_TFIAR),
+			mfspr(SPRN_TEXASR));
+	}
+
+	printf("mmcr0  = %.16x  mmcr1 = %.16x mmcr2  = %.16x\n",
+		mfspr(SPRN_MMCR0), mfspr(SPRN_MMCR1), mfspr(SPRN_MMCR2));
+	printf("pmc1   = %.8x pmc2 = %.8x  pmc3 = %.8x  pmc4   = %.8x\n",
+		mfspr(SPRN_PMC1), mfspr(SPRN_PMC2),
+		mfspr(SPRN_PMC3), mfspr(SPRN_PMC4));
+	printf("mmcra  = %.16x   siar = %.16x pmc5   = %.8x\n",
+		mfspr(SPRN_MMCRA), mfspr(SPRN_SIAR), mfspr(SPRN_PMC5));
+	printf("sdar   = %.16x   sier = %.16x pmc6   = %.8x\n",
+		mfspr(SPRN_SDAR), mfspr(SPRN_SIER), mfspr(SPRN_PMC6));
+	printf("ebbhr  = %.16x  ebbrr = %.16x bescr  = %.16x\n",
+		mfspr(SPRN_EBBHR), mfspr(SPRN_EBBRR), mfspr(SPRN_BESCR));
+
+	if (!(msr & MSR_HV))
+		return;
+
+	printf("hfscr  = %.16x  dhdes = %.16x rpr    = %.16x\n",
+		mfspr(SPRN_HFSCR), mfspr(SPRN_DHDES), mfspr(SPRN_RPR));
+	printf("dawr   = %.16x  dawrx = %.16x ciabr  = %.16x\n",
+		mfspr(SPRN_DAWR), mfspr(SPRN_DAWRX), mfspr(SPRN_CIABR));
+#endif
+}
 
 static void dump_one_spr(int spr, bool show_unimplemented)
 {
@@ -1764,6 +1807,7 @@ static void super_regs(void)
 		printf("toc    = "REG"  dar   = "REG"\n", toc, mfspr(SPRN_DAR));
 
 		dump_206_sprs();
+		dump_207_sprs();
 
 		return;
 	}
-- 
2.7.4
