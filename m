Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzhmB2sdLzDqJ9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 11:28:10 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 79so11674413pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Apr 2017 18:28:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/64s: Add SCV FSCR bit for ISA v3.0
Date: Fri,  7 Apr 2017 11:27:44 +1000
Message-Id: <20170407012744.21800-3-npiggin@gmail.com>
In-Reply-To: <20170407012744.21800-1-npiggin@gmail.com>
References: <20170407012744.21800-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/reg.h |  2 ++
 arch/powerpc/kernel/traps.c    | 19 ++++++++++---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index fc879fd6bdae..d9e52a1336a6 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -310,6 +310,7 @@
 #define SPRN_PMCR	0x374	/* Power Management Control Register */
 
 /* HFSCR and FSCR bit numbers are the same */
+#define FSCR_SCV_LG	12	/* Enable System Call Vectored */
 #define FSCR_MSGP_LG	10	/* Enable MSGP */
 #define FSCR_TAR_LG	8	/* Enable Target Address Register */
 #define FSCR_EBB_LG	7	/* Enable Event Based Branching */
@@ -320,6 +321,7 @@
 #define FSCR_VECVSX_LG	1	/* Enable VMX/VSX  */
 #define FSCR_FP_LG	0	/* Enable Floating Point */
 #define SPRN_FSCR	0x099	/* Facility Status & Control Register */
+#define   FSCR_SCV	__MASK(FSCR_SCV_LG)
 #define   FSCR_TAR	__MASK(FSCR_TAR_LG)
 #define   FSCR_EBB	__MASK(FSCR_EBB_LG)
 #define   FSCR_DSCR	__MASK(FSCR_DSCR_LG)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index a34d8bf3dbe4..5b307efed870 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1432,15 +1432,16 @@ static void tm_unavailable(struct pt_regs *regs)
 void facility_unavailable_exception(struct pt_regs *regs)
 {
 	static char *facility_strings[] = {
-		[FSCR_FP_LG] = "FPU",
-		[FSCR_VECVSX_LG] = "VMX/VSX",
-		[FSCR_DSCR_LG] = "DSCR",
-		[FSCR_PM_LG] = "PMU SPRs",
-		[FSCR_BHRB_LG] = "BHRB",
-		[FSCR_TM_LG] = "TM",
-		[FSCR_EBB_LG] = "EBB",
-		[FSCR_TAR_LG] = "TAR",
-		[FSCR_MSGP_LG] = "MSGP",
+		[FSCR_FP_LG]		= "FPU",
+		[FSCR_VECVSX_LG]	= "VMX/VSX",
+		[FSCR_DSCR_LG]		= "DSCR",
+		[FSCR_PM_LG]		= "PMU SPRs",
+		[FSCR_BHRB_LG]		= "BHRB",
+		[FSCR_TM_LG]		= "TM",
+		[FSCR_EBB_LG]		= "EBB",
+		[FSCR_TAR_LG]		= "TAR",
+		[FSCR_MSGP_LG]		= "MSGP",
+		[FSCR_SCV_LG]		= "SCV",
 	};
 	char *facility = "unknown";
 	u64 value;
-- 
2.11.0
