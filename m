Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhmYt1sQSzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 10:28:02 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id a2so3275150pfj.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 17:28:02 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH 2/2] powerpc/xmon: revisit SPR support
Date: Wed, 30 Aug 2017 10:27:45 +1000
Message-Id: <20170830002745.29526-2-bsingharora@gmail.com>
In-Reply-To: <20170830002745.29526-1-bsingharora@gmail.com>
References: <20170830002745.29526-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch readjusts the SPR's adds support for IAMR/AMR
UAMOR/AMOR based on their supported ISA revisions.

There is also support for printing the PIDR/TIDR for
ISA 300 and PSSCR and PTCR in ISA 300 hypervisor mode.
SPRN_PSSCR_PR is the privileged mode access and is used
when we are not in hypervisor mode.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/reg.h |  1 +
 arch/powerpc/xmon/xmon.c       | 34 ++++++++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index c36823d..2c4366a 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -356,6 +356,7 @@
 #define SPRN_PMSR	0x355   /* Power Management Status Reg */
 #define SPRN_PMMAR	0x356	/* Power Management Memory Activity Register */
 #define SPRN_PSSCR	0x357	/* Processor Stop Status and Control Register (ISA 3.0) */
+#define SPRN_PSSCR_PR	0x337	/* PSSCR ISA 3.0, privileged mode access */
 #define SPRN_PMCR	0x374	/* Power Management Control Register */
 
 /* HFSCR and FSCR bit numbers are the same */
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 1b26d53..33351c6 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1743,18 +1743,20 @@ static void dump_206_sprs(void)
 		mfspr(SPRN_SRR0), mfspr(SPRN_SRR1), mfspr(SPRN_DSISR));
 	printf("dscr   = %.16lx  ppr   = %.16lx pir    = %.8x\n",
 		mfspr(SPRN_DSCR), mfspr(SPRN_PPR), mfspr(SPRN_PIR));
+	printf("amr    = %.16lx  uamor = %.16lx\n",
+		mfspr(SPRN_AMR), mfspr(SPRN_UAMOR));
 
 	if (!(mfmsr() & MSR_HV))
 		return;
 
 	printf("sdr1   = %.16lx  hdar  = %.16lx hdsisr = %.8x\n",
 		mfspr(SPRN_SDR1), mfspr(SPRN_HDAR), mfspr(SPRN_HDSISR));
-	printf("hsrr0  = %.16lx hsrr1  = %.16lx hdec = %.16lx\n",
+	printf("hsrr0  = %.16lx hsrr1  = %.16lx hdec   = %.16lx\n",
 		mfspr(SPRN_HSRR0), mfspr(SPRN_HSRR1), mfspr(SPRN_HDEC));
-	printf("lpcr   = %.16lx  pcr   = %.16lx lpidr = %.8x\n",
+	printf("lpcr   = %.16lx  pcr   = %.16lx lpidr  = %.8x\n",
 		mfspr(SPRN_LPCR), mfspr(SPRN_PCR), mfspr(SPRN_LPID));
-	printf("hsprg0 = %.16lx hsprg1 = %.16lx\n",
-		mfspr(SPRN_HSPRG0), mfspr(SPRN_HSPRG1));
+	printf("hsprg0 = %.16lx hsprg1 = %.16lx amor   = %.16lx\n",
+		mfspr(SPRN_HSPRG0), mfspr(SPRN_HSPRG1), mfspr(SPRN_AMOR));
 	printf("dabr   = %.16lx dabrx  = %.16lx\n",
 		mfspr(SPRN_DABR), mfspr(SPRN_DABRX));
 #endif
@@ -1793,6 +1795,7 @@ static void dump_207_sprs(void)
 		mfspr(SPRN_SDAR), mfspr(SPRN_SIER), mfspr(SPRN_PMC6));
 	printf("ebbhr  = %.16lx  ebbrr = %.16lx bescr  = %.16lx\n",
 		mfspr(SPRN_EBBHR), mfspr(SPRN_EBBRR), mfspr(SPRN_BESCR));
+	printf("iamr   = %.16lx\n", mfspr(SPRN_IAMR));
 
 	if (!(msr & MSR_HV))
 		return;
@@ -1804,6 +1807,28 @@ static void dump_207_sprs(void)
 #endif
 }
 
+static void dump_300_sprs(void)
+{
+#ifdef CONFIG_PPC64
+	bool hv = mfmsr() & MSR_HV;
+
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		return;
+
+	printf("pidr   = %.16lx  tidr  = %.16lx\n",
+		mfspr(SPRN_PID), mfspr(SPRN_TIDR));
+	printf("asdr   = %.16lx  psscr = %.16lx\n",
+		mfspr(SPRN_ASDR), hv ? mfspr(SPRN_PSSCR)
+					: mfspr(SPRN_PSSCR_PR));
+
+	if (!hv)
+		return;
+
+	printf("ptcr   = %.16lx\n",
+		mfspr(SPRN_PTCR));
+#endif
+}
+
 static void dump_one_spr(int spr, bool show_unimplemented)
 {
 	unsigned long val;
@@ -1857,6 +1882,7 @@ static void super_regs(void)
 
 		dump_206_sprs();
 		dump_207_sprs();
+		dump_300_sprs();
 
 		return;
 	}
-- 
2.9.4
