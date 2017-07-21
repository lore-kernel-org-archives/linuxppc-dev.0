Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDK2M3mCczDqs5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 15:24:27 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id q85so3996689pfq.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 22:24:27 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Subject: [PATCH 2/2] powerpc/xmon: revisit SPR support
Date: Fri, 21 Jul 2017 15:24:06 +1000
Message-Id: <20170721052406.28960-2-bsingharora@gmail.com>
In-Reply-To: <20170721052406.28960-1-bsingharora@gmail.com>
References: <20170721052406.28960-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch readjusts the SPR's adds support for IAMR/AMR
UAMOR/AMOR based on their supported ISA revisions. The
HDEC SPR is now printed with 16 hex digits instead of 8,
so that we can see the expanded values on ISA 300.
There is also support for printing the PIDR/TIDR for
ISA 300 and PSSCR and PTCR in ISA 300 hypervisor mode.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/xmon/xmon.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 8aedfff..e025a16 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1738,13 +1738,15 @@ static void dump_206_sprs(void)
 		mfspr(SPRN_SRR0), mfspr(SPRN_SRR1), mfspr(SPRN_DSISR));
 	printf("dscr   = %.16x  ppr   = %.16x pir    = %.8x\n",
 		mfspr(SPRN_DSCR), mfspr(SPRN_PPR), mfspr(SPRN_PIR));
+	printf("amr    = %.16x  uamor = %.16x\n",
+		mfspr(SPRN_AMR), mfspr(SPRN_UAMOR));
 
 	if (!(mfmsr() & MSR_HV))
 		return;
 
 	printf("sdr1   = %.16x  hdar  = %.16x hdsisr = %.8x\n",
 		mfspr(SPRN_SDR1), mfspr(SPRN_HDAR), mfspr(SPRN_HDSISR));
-	printf("hsrr0  = %.16x hsrr1  = %.16x hdec = %.8x\n",
+	printf("hsrr0  = %.16x hsrr1  = %.16x hdec = %.16x\n",
 		mfspr(SPRN_HSRR0), mfspr(SPRN_HSRR1), mfspr(SPRN_HDEC));
 	printf("lpcr   = %.16x  pcr   = %.16x lpidr = %.8x\n",
 		mfspr(SPRN_LPCR), mfspr(SPRN_PCR), mfspr(SPRN_LPID));
@@ -1788,6 +1790,7 @@ static void dump_207_sprs(void)
 		mfspr(SPRN_SDAR), mfspr(SPRN_SIER), mfspr(SPRN_PMC6));
 	printf("ebbhr  = %.16x  ebbrr = %.16x bescr  = %.16x\n",
 		mfspr(SPRN_EBBHR), mfspr(SPRN_EBBRR), mfspr(SPRN_BESCR));
+	printf("iamr   = %.16x\n", mfspr(SPRN_IAMR));
 
 	if (!(msr & MSR_HV))
 		return;
@@ -1796,6 +1799,28 @@ static void dump_207_sprs(void)
 		mfspr(SPRN_HFSCR), mfspr(SPRN_DHDES), mfspr(SPRN_RPR));
 	printf("dawr   = %.16x  dawrx = %.16x ciabr  = %.16x\n",
 		mfspr(SPRN_DAWR), mfspr(SPRN_DAWRX), mfspr(SPRN_CIABR));
+	printf("amor   = %.16x\n", mfspr(SPRN_AMOR));
+#endif
+}
+
+static void dump_300_sprs(void)
+{
+#ifdef CONFIG_PPC64
+	unsigned long msr;
+
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		return;
+
+	printf("pidr   = %.16x  tidr  = %.16x asdr   = %.16x\n",
+		mfspr(SPRN_PID), mfspr(SPRN_TIDR), mfspr(SPRN_ASDR));
+
+	msr = mfmsr();
+
+	if (!(msr & MSR_HV))
+		return;
+
+	printf("ptcr   = %.16x  psscr = %.16x\n",
+		mfspr(SPRN_PTCR), mfspr(SPRN_PSSCR));
 #endif
 }
 
@@ -1852,6 +1877,7 @@ static void super_regs(void)
 
 		dump_206_sprs();
 		dump_207_sprs();
+		dump_300_sprs();
 
 		return;
 	}
-- 
2.9.4
