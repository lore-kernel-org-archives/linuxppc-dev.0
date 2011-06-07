Return-Path: <ericvh@gmail.com>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E6E98B6F90
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jun 2011 04:47:51 +1000 (EST)
Received: by pxi19 with SMTP id 19so3679360pxi.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 07 Jun 2011 11:47:48 -0700 (PDT)
From: Eric Van Hensbergen <ericvh@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC][V3] bluegene: add entry to cpu table
Date: Tue,  7 Jun 2011 13:47:27 -0500
Message-Id: <1307472447-1656-1-git-send-email-ericvh@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create an entry for the BG/P chips, include bits to accomodate
the double fp2 fpu and the special MMU considerations like L1
writethrough.

RFC Note: this patch fails scripts/checkpatch.pl because I
matched coding style of the surrounding existing code.  Would
you rather have something checkpatch.pl clean or something
which is consistent with the surrounding code style?

The three I got were:
ERROR: Macros with complex values should be enclosed in parenthesis
ERROR: "foo* bar" should be "foo *bar"
WARNING: externs should be avoided in .c files
and I got these by copying other code as an example.

Thanks for any feedback.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
---
 arch/powerpc/include/asm/cputable.h |    1 +
 arch/powerpc/include/asm/mmu.h      |    9 +++++++++
 arch/powerpc/kernel/cpu_setup_44x.S |    1 +
 arch/powerpc/kernel/cputable.c      |   16 ++++++++++++++++
 4 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index c0d842c..ce709b5 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -26,6 +26,7 @@
 #define PPC_FEATURE_POWER6_EXT		0x00000200
 #define PPC_FEATURE_ARCH_2_06		0x00000100
 #define PPC_FEATURE_HAS_VSX		0x00000080
+#define PPC_FEATURE_HAS_FPU_FP2		0x00000040
 
 #define PPC_FEATURE_PSERIES_PERFMON_COMPAT \
 					0x00000040
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 4138b21..97f9502 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -56,6 +56,13 @@
  */
 #define MMU_FTR_NEED_DTLB_SW_LRU	ASM_CONST(0x00200000)
 
+/* This indicates that the processor must using writethrough with
+ * the L1 in order to maintain SMP coherence on systems like the
+ * IBM BlueGene/L and IBM BlueGene/P.
+ */
+
+#define MMU_FTR_NEED_L1_WRITETHROUGH	ASM_CONST(0x00400000)
+
 /* Enable use of TLB reservation.  Processor should support tlbsrx.
  * instruction and MAS0[WQ].
  */
@@ -112,6 +119,8 @@
 				MMU_FTR_USE_PAIRED_MAS | \
 				MMU_FTR_TLBIEL | \
 				MMU_FTR_16M_PAGE
+#define MMU_FTRS_BGP		MMU_FTR_TYPE_44x | MMU_FTR_16M_PAGE | \
+				MMU_FTR_NEED_L1_WRITETHROUGH
 #ifndef __ASSEMBLY__
 #include <asm/cputable.h>
 
diff --git a/arch/powerpc/kernel/cpu_setup_44x.S b/arch/powerpc/kernel/cpu_setup_44x.S
index e32b4a9..920aed6 100644
--- a/arch/powerpc/kernel/cpu_setup_44x.S
+++ b/arch/powerpc/kernel/cpu_setup_44x.S
@@ -35,6 +35,7 @@ _GLOBAL(__setup_cpu_440grx)
 _GLOBAL(__setup_cpu_460ex)
 _GLOBAL(__setup_cpu_460gt)
 _GLOBAL(__setup_cpu_460sx)
+_GLOBAL(__setup_cpu_bgp)
 _GLOBAL(__setup_cpu_apm821xx)
 	mflr	r4
 	bl	__init_fpu_44x
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 34d2722..550a078 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -57,6 +57,7 @@ extern void __setup_cpu_750fx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_7400(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_7410(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_745x(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_bgp(unsigned long offset, struct cpu_spec* spec);
 #endif /* CONFIG_PPC32 */
 #ifdef CONFIG_PPC64
 extern void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec* spec);
@@ -1737,6 +1738,21 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
+	{ /* Blue Gene/P */
+		.pvr_mask		= 0xfffffff0,
+		.pvr_value		= 0x52131880,
+		.cpu_name		= "450 Blue Gene/P",
+		.cpu_features		= CPU_FTRS_440x6,
+		.cpu_user_features	= COMMON_USER_BOOKE |
+						PPC_FEATURE_HAS_FPU |
+						PPC_FEATURE_HAS_FPU_FP2,
+		.mmu_features		= MMU_FTRS_BGP,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_bgp,
+		.machine_check		= machine_check_440A,
+		.platform		= "ppc440",
+	},
 	{ /* 460EX */
 		.pvr_mask		= 0xffff0006,
 		.pvr_value		= 0x13020002,
-- 
1.7.4.1
