Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlcyl3FPdzDqyn
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 22:54:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/5] powerpc/xmon: Dump ISA 2.06 SPRs
Date: Thu,  7 Jul 2016 22:54:29 +1000
Message-Id: <1467896070-15167-4-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/xmon/xmon.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index efe6f4ee4634..ed6f73a74378 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1682,6 +1682,35 @@ write_spr(int n, unsigned long val)
 	catch_spr_faults = 0;
 }
 
+static void dump_206_sprs(void)
+{
+#ifdef CONFIG_PPC64
+	if (!cpu_has_feature(CPU_FTR_ARCH_206))
+		return;
+
+	/* Actually some of these pre-date 2.06, but whatevs */
+
+	printf("srr0   = %.16x  srr1  = %.16x dsisr  = %.8x\n",
+		mfspr(SPRN_SRR0), mfspr(SPRN_SRR1), mfspr(SPRN_DSISR));
+	printf("dscr   = %.16x  ppr   = %.16x pir    = %.8x\n",
+		mfspr(SPRN_DSCR), mfspr(SPRN_PPR), mfspr(SPRN_PIR));
+
+	if (!(mfmsr() & MSR_HV))
+		return;
+
+	printf("sdr1   = %.16x  hdar  = %.16x hdsisr = %.8x\n",
+		mfspr(SPRN_SDR1), mfspr(SPRN_HDAR), mfspr(SPRN_HDSISR));
+	printf("hsrr0  = %.16x hsrr1  = %.16x hdec = %.8x\n",
+		mfspr(SPRN_HSRR0), mfspr(SPRN_HSRR1), mfspr(SPRN_HDEC));
+	printf("lpcr   = %.16x  pcr   = %.16x lpidr = %.8x\n",
+		mfspr(SPRN_LPCR), mfspr(SPRN_PCR), mfspr(SPRN_LPID));
+	printf("hsprg0 = %.16x hsprg1 = %.16x\n",
+		mfspr(SPRN_HSPRG0), mfspr(SPRN_HSPRG1));
+	printf("dabr   = %.16x dabrx  = %.16x\n",
+		mfspr(SPRN_DABR), mfspr(SPRN_DABRX));
+#endif
+}
+
 
 static void dump_one_spr(int spr, bool show_unimplemented)
 {
@@ -1734,6 +1763,8 @@ static void super_regs(void)
 		printf("sp     = "REG"  sprg3 = "REG"\n", sp, mfspr(SPRN_SPRG3));
 		printf("toc    = "REG"  dar   = "REG"\n", toc, mfspr(SPRN_DAR));
 
+		dump_206_sprs();
+
 		return;
 	}
 	case 'w': {
-- 
2.7.4
