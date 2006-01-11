Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17348.35120.840409.283964@cargo.ozlabs.ibm.com>
Date: Wed, 11 Jan 2006 15:27:28 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org, sjmunroe@us.ibm.com
Subject: [PATCH] implement AT_PLATFORM for powerpc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch below makes powerpc kernels supply a value for the
AT_PLATFORM aux table entry which is intended to indicate what class
of processor the program is running on, so that glibc can optionally
choose shared library objects which are optimized for the processor.

The patch also adds a PPC_FEATURE_BOOKE bit to the AT_HWCAP value to
indicate processors which conform to the Book E specification (as far
as usermode is concerned), e.g. which have the isel, mbar and msync
instructions.

The set of AT_PLATFORM values is: "cell", "power3", "power4",
"power5", "power5+", "powerpc", "ppc403", "ppc405", "ppc440",
"ppc601", "ppc603", "ppc604", "ppc7400", "ppc7450", "ppc750",
"ppc823", "ppc8540", "ppc970", "rs64".

Note that the "powerpc" value is only used for the case where the PVR
value is unrecognized.

Comments?

Paul.

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 43c74a6..c37ed06 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -80,6 +80,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power3,
 		.oprofile_cpu_type	= "ppc64/power3",
 		.oprofile_type		= RS64,
+		.platform		= "power3",
 	},
 	{	/* Power3+ */
 		.pvr_mask		= 0xffff0000,
@@ -93,6 +94,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power3,
 		.oprofile_cpu_type	= "ppc64/power3",
 		.oprofile_type		= RS64,
+		.platform		= "power3",
 	},
 	{	/* Northstar */
 		.pvr_mask		= 0xffff0000,
@@ -106,6 +108,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power3,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= RS64,
+		.platform		= "rs64",
 	},
 	{	/* Pulsar */
 		.pvr_mask		= 0xffff0000,
@@ -119,6 +122,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power3,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= RS64,
+		.platform		= "rs64",
 	},
 	{	/* I-star */
 		.pvr_mask		= 0xffff0000,
@@ -132,6 +136,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power3,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= RS64,
+		.platform		= "rs64",
 	},
 	{	/* S-star */
 		.pvr_mask		= 0xffff0000,
@@ -145,6 +150,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power3,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= RS64,
+		.platform		= "rs64",
 	},
 	{	/* Power4 */
 		.pvr_mask		= 0xffff0000,
@@ -158,6 +164,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power4,
 		.oprofile_cpu_type	= "ppc64/power4",
 		.oprofile_type		= POWER4,
+		.platform		= "power4",
 	},
 	{	/* Power4+ */
 		.pvr_mask		= 0xffff0000,
@@ -171,6 +178,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power4,
 		.oprofile_cpu_type	= "ppc64/power4",
 		.oprofile_type		= POWER4,
+		.platform		= "power4",
 	},
 	{	/* PPC970 */
 		.pvr_mask		= 0xffff0000,
@@ -185,6 +193,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
 		.oprofile_type		= POWER4,
+		.platform		= "ppc970",
 	},
 #endif /* CONFIG_PPC64 */
 #if defined(CONFIG_PPC64) || defined(CONFIG_POWER4)
@@ -205,6 +214,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
 		.oprofile_type		= POWER4,
+		.platform		= "ppc970",
 	},
 #endif /* defined(CONFIG_PPC64) || defined(CONFIG_POWER4) */
 #ifdef CONFIG_PPC64
@@ -220,6 +230,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
 		.oprofile_type		= POWER4,
+		.platform		= "ppc970",
 	},
 	{	/* Power5 GR */
 		.pvr_mask		= 0xffff0000,
@@ -233,6 +244,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power4,
 		.oprofile_cpu_type	= "ppc64/power5",
 		.oprofile_type		= POWER4,
+		.platform		= "power5",
 	},
 	{	/* Power5 GS */
 		.pvr_mask		= 0xffff0000,
@@ -246,6 +258,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power4,
 		.oprofile_cpu_type	= "ppc64/power5+",
 		.oprofile_type		= POWER4,
+		.platform		= "power5+",
 	},
 	{	/* Cell Broadband Engine */
 		.pvr_mask		= 0xffff0000,
@@ -257,6 +270,7 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.cpu_setup		= __setup_cpu_be,
+		.platform		= "cell",
 	},
 	{	/* default match */
 		.pvr_mask		= 0x00000000,
@@ -268,6 +282,7 @@ struct cpu_spec	cpu_specs[] = {
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
 		.cpu_setup		= __setup_cpu_power4,
+		.platform		= "power4",
 	}
 #endif	/* CONFIG_PPC64 */
 #ifdef CONFIG_PPC32
@@ -281,6 +296,7 @@ struct cpu_spec	cpu_specs[] = {
 			PPC_FEATURE_UNIFIED_CACHE | PPC_FEATURE_NO_TB,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc601",
 	},
 	{	/* 603 */
 		.pvr_mask		= 0xffff0000,
@@ -290,7 +306,8 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.cpu_setup		= __setup_cpu_603
+		.cpu_setup		= __setup_cpu_603,
+		.platform		= "ppc603",
 	},
 	{	/* 603e */
 		.pvr_mask		= 0xffff0000,
@@ -300,7 +317,8 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.cpu_setup		= __setup_cpu_603
+		.cpu_setup		= __setup_cpu_603,
+		.platform		= "ppc603",
 	},
 	{	/* 603ev */
 		.pvr_mask		= 0xffff0000,
@@ -310,7 +328,8 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.cpu_setup		= __setup_cpu_603
+		.cpu_setup		= __setup_cpu_603,
+		.platform		= "ppc603",
 	},
 	{	/* 604 */
 		.pvr_mask		= 0xffff0000,
@@ -321,7 +340,8 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 2,
-		.cpu_setup		= __setup_cpu_604
+		.cpu_setup		= __setup_cpu_604,
+		.platform		= "ppc604",
 	},
 	{	/* 604e */
 		.pvr_mask		= 0xfffff000,
@@ -332,7 +352,8 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_604
+		.cpu_setup		= __setup_cpu_604,
+		.platform		= "ppc604",
 	},
 	{	/* 604r */
 		.pvr_mask		= 0xffff0000,
@@ -343,7 +364,8 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_604
+		.cpu_setup		= __setup_cpu_604,
+		.platform		= "ppc604",
 	},
 	{	/* 604ev */
 		.pvr_mask		= 0xffff0000,
@@ -354,7 +376,8 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_604
+		.cpu_setup		= __setup_cpu_604,
+		.platform		= "ppc604",
 	},
 	{	/* 740/750 (0x4202, don't support TAU ?) */
 		.pvr_mask		= 0xffffffff,
@@ -365,7 +388,8 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_750
+		.cpu_setup		= __setup_cpu_750,
+		.platform		= "ppc750",
 	},
 	{	/* 750CX (80100 and 8010x?) */
 		.pvr_mask		= 0xfffffff0,
@@ -376,7 +400,8 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_750cx
+		.cpu_setup		= __setup_cpu_750cx,
+		.platform		= "ppc750",
 	},
 	{	/* 750CX (82201 and 82202) */
 		.pvr_mask		= 0xfffffff0,
@@ -387,7 +412,8 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_750cx
+		.cpu_setup		= __setup_cpu_750cx,
+		.platform		= "ppc750",
 	},
 	{	/* 750CXe (82214) */
 		.pvr_mask		= 0xfffffff0,
@@ -398,7 +424,8 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_750cx
+		.cpu_setup		= __setup_cpu_750cx,
+		.platform		= "ppc750",
 	},
 	{	/* 750CXe "Gekko" (83214) */
 		.pvr_mask		= 0xffffffff,
@@ -409,7 +436,8 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_750cx
+		.cpu_setup		= __setup_cpu_750cx,
+		.platform		= "ppc750",
 	},
 	{	/* 745/755 */
 		.pvr_mask		= 0xfffff000,
@@ -420,7 +448,8 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_750
+		.cpu_setup		= __setup_cpu_750,
+		.platform		= "ppc750",
 	},
 	{	/* 750FX rev 1.x */
 		.pvr_mask		= 0xffffff00,
@@ -431,7 +460,8 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_750
+		.cpu_setup		= __setup_cpu_750,
+		.platform		= "ppc750",
 	},
 	{	/* 750FX rev 2.0 must disable HID0[DPM] */
 		.pvr_mask		= 0xffffffff,
@@ -442,7 +472,8 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_750
+		.cpu_setup		= __setup_cpu_750,
+		.platform		= "ppc750",
 	},
 	{	/* 750FX (All revs except 2.0) */
 		.pvr_mask		= 0xffff0000,
@@ -453,7 +484,8 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_750fx
+		.cpu_setup		= __setup_cpu_750fx,
+		.platform		= "ppc750",
 	},
 	{	/* 750GX */
 		.pvr_mask		= 0xffff0000,
@@ -464,7 +496,8 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_750fx
+		.cpu_setup		= __setup_cpu_750fx,
+		.platform		= "ppc750",
 	},
 	{	/* 740/750 (L2CR bit need fixup for 740) */
 		.pvr_mask		= 0xffff0000,
@@ -475,7 +508,8 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_750
+		.cpu_setup		= __setup_cpu_750,
+		.platform		= "ppc750",
 	},
 	{	/* 7400 rev 1.1 ? (no TAU) */
 		.pvr_mask		= 0xffffffff,
@@ -486,7 +520,8 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_7400
+		.cpu_setup		= __setup_cpu_7400,
+		.platform		= "ppc7400",
 	},
 	{	/* 7400 */
 		.pvr_mask		= 0xffff0000,
@@ -497,7 +532,8 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_7400
+		.cpu_setup		= __setup_cpu_7400,
+		.platform		= "ppc7400",
 	},
 	{	/* 7410 */
 		.pvr_mask		= 0xffff0000,
@@ -508,7 +544,8 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_7410
+		.cpu_setup		= __setup_cpu_7410,
+		.platform		= "ppc7400",
 	},
 	{	/* 7450 2.0 - no doze/nap */
 		.pvr_mask		= 0xffffffff,
@@ -522,6 +559,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= G4,
+		.platform		= "ppc7450",
 	},
 	{	/* 7450 2.1 */
 		.pvr_mask		= 0xffffffff,
@@ -535,6 +573,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= G4,
+		.platform		= "ppc7450",
 	},
 	{	/* 7450 2.3 and newer */
 		.pvr_mask		= 0xffff0000,
@@ -548,6 +587,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= G4,
+		.platform		= "ppc7450",
 	},
 	{	/* 7455 rev 1.x */
 		.pvr_mask		= 0xffffff00,
@@ -561,6 +601,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= G4,
+		.platform		= "ppc7450",
 	},
 	{	/* 7455 rev 2.0 */
 		.pvr_mask		= 0xffffffff,
@@ -574,6 +615,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= G4,
+		.platform		= "ppc7450",
 	},
 	{	/* 7455 others */
 		.pvr_mask		= 0xffff0000,
@@ -587,6 +629,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= G4,
+		.platform		= "ppc7450",
 	},
 	{	/* 7447/7457 Rev 1.0 */
 		.pvr_mask		= 0xffffffff,
@@ -600,6 +643,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= G4,
+		.platform		= "ppc7450",
 	},
 	{	/* 7447/7457 Rev 1.1 */
 		.pvr_mask		= 0xffffffff,
@@ -613,6 +657,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= G4,
+		.platform		= "ppc7450",
 	},
 	{	/* 7447/7457 Rev 1.2 and later */
 		.pvr_mask		= 0xffff0000,
@@ -626,6 +671,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= G4,
+		.platform		= "ppc7450",
 	},
 	{	/* 7447A */
 		.pvr_mask		= 0xffff0000,
@@ -639,6 +685,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= G4,
+		.platform		= "ppc7450",
 	},
 	{	/* 7448 */
 		.pvr_mask		= 0xffff0000,
@@ -652,6 +699,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_745x,
 		.oprofile_cpu_type      = "ppc/7450",
 		.oprofile_type		= G4,
+		.platform		= "ppc7450",
 	},
 	{	/* 82xx (8240, 8245, 8260 are all 603e cores) */
 		.pvr_mask		= 0x7fff0000,
@@ -661,7 +709,8 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.cpu_setup		= __setup_cpu_603
+		.cpu_setup		= __setup_cpu_603,
+		.platform		= "ppc603",
 	},
 	{	/* All G2_LE (603e core, plus some) have the same pvr */
 		.pvr_mask		= 0x7fff0000,
@@ -671,7 +720,8 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.cpu_setup		= __setup_cpu_603
+		.cpu_setup		= __setup_cpu_603,
+		.platform		= "ppc603",
 	},
 	{	/* e300 (a 603e core, plus some) on 83xx */
 		.pvr_mask		= 0x7fff0000,
@@ -681,7 +731,8 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
-		.cpu_setup		= __setup_cpu_603
+		.cpu_setup		= __setup_cpu_603,
+		.platform		= "ppc603",
 	},
 	{	/* default match, we assume split I/D cache & TB (non-601)... */
 		.pvr_mask		= 0x00000000,
@@ -691,6 +742,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc603",
 	},
 #endif /* CLASSIC_PPC */
 #ifdef CONFIG_8xx
@@ -704,6 +756,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
+		.platform		= "ppc823",
 	},
 #endif /* CONFIG_8xx */
 #ifdef CONFIG_40x
@@ -715,6 +768,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
+		.platform		= "ppc403",
 	},
 	{	/* 403GCX */
 		.pvr_mask		= 0xffffff00,
@@ -725,6 +779,7 @@ struct cpu_spec	cpu_specs[] = {
 		 	PPC_FEATURE_HAS_MMU | PPC_FEATURE_NO_TB,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
+		.platform		= "ppc403",
 	},
 	{	/* 403G ?? */
 		.pvr_mask		= 0xffff0000,
@@ -734,6 +789,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
+		.platform		= "ppc403",
 	},
 	{	/* 405GP */
 		.pvr_mask		= 0xffff0000,
@@ -744,6 +800,7 @@ struct cpu_spec	cpu_specs[] = {
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc405",
 	},
 	{	/* STB 03xxx */
 		.pvr_mask		= 0xffff0000,
@@ -754,6 +811,7 @@ struct cpu_spec	cpu_specs[] = {
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc405",
 	},
 	{	/* STB 04xxx */
 		.pvr_mask		= 0xffff0000,
@@ -764,6 +822,7 @@ struct cpu_spec	cpu_specs[] = {
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc405",
 	},
 	{	/* NP405L */
 		.pvr_mask		= 0xffff0000,
@@ -774,6 +833,7 @@ struct cpu_spec	cpu_specs[] = {
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc405",
 	},
 	{	/* NP4GS3 */
 		.pvr_mask		= 0xffff0000,
@@ -784,6 +844,7 @@ struct cpu_spec	cpu_specs[] = {
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc405",
 	},
 	{   /* NP405H */
 		.pvr_mask		= 0xffff0000,
@@ -794,6 +855,7 @@ struct cpu_spec	cpu_specs[] = {
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc405",
 	},
 	{	/* 405GPr */
 		.pvr_mask		= 0xffff0000,
@@ -804,6 +866,7 @@ struct cpu_spec	cpu_specs[] = {
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc405",
 	},
 	{   /* STBx25xx */
 		.pvr_mask		= 0xffff0000,
@@ -814,6 +877,7 @@ struct cpu_spec	cpu_specs[] = {
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc405",
 	},
 	{	/* 405LP */
 		.pvr_mask		= 0xffff0000,
@@ -823,6 +887,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc405",
 	},
 	{	/* Xilinx Virtex-II Pro  */
 		.pvr_mask		= 0xffff0000,
@@ -833,6 +898,7 @@ struct cpu_spec	cpu_specs[] = {
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc405",
 	},
 	{	/* 405EP */
 		.pvr_mask		= 0xffff0000,
@@ -843,6 +909,7 @@ struct cpu_spec	cpu_specs[] = {
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc405",
 	},
 
 #endif /* CONFIG_40x */
@@ -855,6 +922,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER, /* 440EP has an FPU */
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc440",
 	},
 	{
 		.pvr_mask		= 0xf0000fff,
@@ -864,6 +932,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER, /* 440EP has an FPU */
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc440",
 	},
 	{	/* 440GP Rev. B */
 		.pvr_mask		= 0xf0000fff,
@@ -873,6 +942,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc440",
 	},
 	{	/* 440GP Rev. C */
 		.pvr_mask		= 0xf0000fff,
@@ -882,6 +952,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc440",
 	},
 	{ /* 440GX Rev. A */
 		.pvr_mask		= 0xf0000fff,
@@ -891,6 +962,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc440",
 	},
 	{ /* 440GX Rev. B */
 		.pvr_mask		= 0xf0000fff,
@@ -900,6 +972,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc440",
 	},
 	{ /* 440GX Rev. C */
 		.pvr_mask		= 0xf0000fff,
@@ -909,6 +982,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc440",
 	},
 	{ /* 440GX Rev. F */
 		.pvr_mask		= 0xf0000fff,
@@ -918,6 +992,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc440",
 	},
 	{ /* 440SP Rev. A */
 		.pvr_mask		= 0xff000fff,
@@ -927,6 +1002,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc440",
 	},
 	{ /* 440SPe Rev. A */
 		.pvr_mask		= 0xff000fff,
@@ -937,6 +1013,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc440",
 	},
 #endif /* CONFIG_44x */
 #ifdef CONFIG_FSL_BOOKE
@@ -950,6 +1027,7 @@ struct cpu_spec	cpu_specs[] = {
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_EFP_SINGLE |
 			PPC_FEATURE_UNIFIED_CACHE,
 		.dcache_bsize		= 32,
+		.platform		= "ppc8540",
 	},
 	{	/* e200z6 */
 		.pvr_mask		= 0xfff00000,
@@ -962,6 +1040,7 @@ struct cpu_spec	cpu_specs[] = {
 			PPC_FEATURE_HAS_EFP_SINGLE |
 			PPC_FEATURE_UNIFIED_CACHE,
 		.dcache_bsize		= 32,
+		.platform		= "ppc8540",
 	},
 	{	/* e500 */
 		.pvr_mask		= 0xffff0000,
@@ -977,6 +1056,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 4,
 		.oprofile_cpu_type	= "ppc/e500",
 		.oprofile_type		= BOOKE,
+		.platform		= "ppc8540",
 	},
 	{	/* e500v2 */
 		.pvr_mask		= 0xffff0000,
@@ -992,6 +1072,7 @@ struct cpu_spec	cpu_specs[] = {
 		.num_pmcs		= 4,
 		.oprofile_cpu_type	= "ppc/e500",
 		.oprofile_type		= BOOKE,
+		.platform		= "ppc8540",
 	},
 #endif
 #if !CLASSIC_PPC
@@ -1003,6 +1084,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= PPC_FEATURE_32,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "powerpc",
 	}
 #endif /* !CLASSIC_PPC */
 #endif /* CONFIG_PPC32 */
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index ef6ead3..03017d9 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -19,6 +19,7 @@
 #define PPC_FEATURE_POWER5		0x00040000
 #define PPC_FEATURE_POWER5_PLUS		0x00020000
 #define PPC_FEATURE_CELL		0x00010000
+#define PPC_FEATURE_BOOKE		0x00008000
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
@@ -64,6 +65,9 @@ struct cpu_spec {
 
 	/* Processor specific oprofile operations */
 	enum powerpc_oprofile_type oprofile_type;
+
+	/* Name of processor class, for the ELF AT_PLATFORM entry */
+	char		*platform;
 };
 
 extern struct cpu_spec		*cur_cpu_spec;
diff --git a/include/asm-powerpc/elf.h b/include/asm-powerpc/elf.h
index c5a635d..a75e975 100644
--- a/include/asm-powerpc/elf.h
+++ b/include/asm-powerpc/elf.h
@@ -222,20 +222,18 @@ extern int dump_task_fpu(struct task_str
    instruction set this cpu supports.  This could be done in userspace,
    but it's not easy, and we've already done it here.  */
 # define ELF_HWCAP	(cur_cpu_spec->cpu_user_features)
-#ifdef __powerpc64__
-# define ELF_PLAT_INIT(_r, load_addr)	do {	\
-	_r->gpr[2] = load_addr; 		\
-} while (0)
-#endif /* __powerpc64__ */
 
 /* This yields a string that ld.so will use to load implementation
    specific libraries for optimization.  This is more specific in
-   intent than poking at uname or /proc/cpuinfo.
+   intent than poking at uname or /proc/cpuinfo.  */
 
-   For the moment, we have only optimizations for the Intel generations,
-   but that could change... */
+#define ELF_PLATFORM	(cur_cpu_spec->platform)
 
-#define ELF_PLATFORM	(NULL)
+#ifdef __powerpc64__
+# define ELF_PLAT_INIT(_r, load_addr)	do {	\
+	_r->gpr[2] = load_addr; 		\
+} while (0)
+#endif /* __powerpc64__ */
 
 #ifdef __KERNEL__
 
