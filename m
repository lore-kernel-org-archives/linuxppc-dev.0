Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhKpy0YldzDqTs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 17:22:50 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id r133so2147535pgr.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 00:22:49 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH] powerpc/xmon: convert 0.16x to 0.16lx
Date: Tue, 29 Aug 2017 17:22:36 +1000
Message-Id: <20170829072236.16948-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Otherwise we lose the top 8 nibbles and effectively print only
the last 32 bits.

Fixes: e0ddf7a ("powerpc/xmon: Dump ISA 2.07 SPRs")
Fixes: 1846193 ("powerpc/xmon: Dump ISA 2.06 SPRs")

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/xmon/xmon.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index d038e7d..9e68f1d 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1739,23 +1739,23 @@ static void dump_206_sprs(void)
 
 	/* Actually some of these pre-date 2.06, but whatevs */
 
-	printf("srr0   = %.16x  srr1  = %.16x dsisr  = %.8x\n",
+	printf("srr0   = %.16lx  srr1  = %.16lx dsisr  = %.8x\n",
 		mfspr(SPRN_SRR0), mfspr(SPRN_SRR1), mfspr(SPRN_DSISR));
-	printf("dscr   = %.16x  ppr   = %.16x pir    = %.8x\n",
+	printf("dscr   = %.16lx  ppr   = %.16lx pir    = %.8x\n",
 		mfspr(SPRN_DSCR), mfspr(SPRN_PPR), mfspr(SPRN_PIR));
 
 	if (!(mfmsr() & MSR_HV))
 		return;
 
-	printf("sdr1   = %.16x  hdar  = %.16x hdsisr = %.8x\n",
+	printf("sdr1   = %.16lx  hdar  = %.16lx hdsisr = %.8x\n",
 		mfspr(SPRN_SDR1), mfspr(SPRN_HDAR), mfspr(SPRN_HDSISR));
-	printf("hsrr0  = %.16x hsrr1  = %.16x hdec = %.8x\n",
+	printf("hsrr0  = %.16lx hsrr1  = %.16lx hdec = %.8x\n",
 		mfspr(SPRN_HSRR0), mfspr(SPRN_HSRR1), mfspr(SPRN_HDEC));
-	printf("lpcr   = %.16x  pcr   = %.16x lpidr = %.8x\n",
+	printf("lpcr   = %.16lx  pcr   = %.16lx lpidr = %.8x\n",
 		mfspr(SPRN_LPCR), mfspr(SPRN_PCR), mfspr(SPRN_LPID));
-	printf("hsprg0 = %.16x hsprg1 = %.16x\n",
+	printf("hsprg0 = %.16lx hsprg1 = %.16lx\n",
 		mfspr(SPRN_HSPRG0), mfspr(SPRN_HSPRG1));
-	printf("dabr   = %.16x dabrx  = %.16x\n",
+	printf("dabr   = %.16lx dabrx  = %.16lx\n",
 		mfspr(SPRN_DABR), mfspr(SPRN_DABRX));
 #endif
 }
@@ -1768,38 +1768,38 @@ static void dump_207_sprs(void)
 	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
 		return;
 
-	printf("dpdes  = %.16x  tir   = %.16x cir    = %.8x\n",
+	printf("dpdes  = %.16lx  tir   = %.16lx cir    = %.8x\n",
 		mfspr(SPRN_DPDES), mfspr(SPRN_TIR), mfspr(SPRN_CIR));
 
-	printf("fscr   = %.16x  tar   = %.16x pspb   = %.8x\n",
+	printf("fscr   = %.16lx  tar   = %.16lx pspb   = %.8x\n",
 		mfspr(SPRN_FSCR), mfspr(SPRN_TAR), mfspr(SPRN_PSPB));
 
 	msr = mfmsr();
 	if (msr & MSR_TM) {
 		/* Only if TM has been enabled in the kernel */
-		printf("tfhar  = %.16x  tfiar = %.16x texasr = %.16x\n",
+		printf("tfhar  = %.16lx  tfiar = %.16lx texasr = %.16lx\n",
 			mfspr(SPRN_TFHAR), mfspr(SPRN_TFIAR),
 			mfspr(SPRN_TEXASR));
 	}
 
-	printf("mmcr0  = %.16x  mmcr1 = %.16x mmcr2  = %.16x\n",
+	printf("mmcr0  = %.16lx  mmcr1 = %.16lx mmcr2  = %.16lx\n",
 		mfspr(SPRN_MMCR0), mfspr(SPRN_MMCR1), mfspr(SPRN_MMCR2));
 	printf("pmc1   = %.8x pmc2 = %.8x  pmc3 = %.8x  pmc4   = %.8x\n",
 		mfspr(SPRN_PMC1), mfspr(SPRN_PMC2),
 		mfspr(SPRN_PMC3), mfspr(SPRN_PMC4));
-	printf("mmcra  = %.16x   siar = %.16x pmc5   = %.8x\n",
+	printf("mmcra  = %.16lx   siar = %.16lx pmc5   = %.8x\n",
 		mfspr(SPRN_MMCRA), mfspr(SPRN_SIAR), mfspr(SPRN_PMC5));
-	printf("sdar   = %.16x   sier = %.16x pmc6   = %.8x\n",
+	printf("sdar   = %.16lx   sier = %.16lx pmc6   = %.8x\n",
 		mfspr(SPRN_SDAR), mfspr(SPRN_SIER), mfspr(SPRN_PMC6));
-	printf("ebbhr  = %.16x  ebbrr = %.16x bescr  = %.16x\n",
+	printf("ebbhr  = %.16lx  ebbrr = %.16lx bescr  = %.16lx\n",
 		mfspr(SPRN_EBBHR), mfspr(SPRN_EBBRR), mfspr(SPRN_BESCR));
 
 	if (!(msr & MSR_HV))
 		return;
 
-	printf("hfscr  = %.16x  dhdes = %.16x rpr    = %.16x\n",
+	printf("hfscr  = %.16lx  dhdes = %.16lx rpr    = %.16lx\n",
 		mfspr(SPRN_HFSCR), mfspr(SPRN_DHDES), mfspr(SPRN_RPR));
-	printf("dawr   = %.16x  dawrx = %.16x ciabr  = %.16x\n",
+	printf("dawr   = %.16lx  dawrx = %.16lx ciabr  = %.16lx\n",
 		mfspr(SPRN_DAWR), mfspr(SPRN_DAWRX), mfspr(SPRN_CIABR));
 #endif
 }
-- 
2.9.4
