Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: Add second POWER8 PVR entry
Date: Thu, 18 Jul 2013 11:31:51 +1000
Message-ID: <16137.1374111111@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, miltonm@realtime.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER8 comes with two different PVRs.  This patch enables the additional
PVR in the cputable.

The existing entry (PVR=0x4b) is renamed to POWER8E and the new entry
(PVR=0x4d) is given POWER8.

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 5d7d9c2..a6840e4 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1088,7 +1088,8 @@
 #define PVR_970MP	0x0044
 #define PVR_970GX	0x0045
 #define PVR_POWER7p	0x004A
-#define PVR_POWER8	0x004B
+#define PVR_POWER8E	0x004B
+#define PVR_POWER8	0x004D
 #define PVR_BE		0x0070
 #define PVR_PA6T	0x0090
 
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 2a45d0f..22973a7 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -494,9 +494,27 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_restore		= __restore_cpu_power7,
 		.platform		= "power7+",
 	},
-	{	/* Power8 */
+	{	/* Power8E */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x004b0000,
+		.cpu_name		= "POWER8E (raw)",
+		.cpu_features		= CPU_FTRS_POWER8,
+		.cpu_user_features	= COMMON_USER_POWER8,
+		.cpu_user_features2	= COMMON_USER2_POWER8,
+		.mmu_features		= MMU_FTRS_POWER8,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_IBM,
+		.oprofile_cpu_type	= "ppc64/power8",
+		.oprofile_type		= PPC_OPROFILE_INVALID,
+		.cpu_setup		= __setup_cpu_power8,
+		.cpu_restore		= __restore_cpu_power8,
+		.platform		= "power8",
+	},
+	{	/* Power8 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x004d0000,
 		.cpu_name		= "POWER8 (raw)",
 		.cpu_features		= CPU_FTRS_POWER8,
 		.cpu_user_features	= COMMON_USER_POWER8,
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 5eccda9..6079024 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -644,7 +644,8 @@ unsigned char ibm_architecture_vec[] = {
 	W(0xfffe0000), W(0x003a0000),	/* POWER5/POWER5+ */
 	W(0xffff0000), W(0x003e0000),	/* POWER6 */
 	W(0xffff0000), W(0x003f0000),	/* POWER7 */
-	W(0xffff0000), W(0x004b0000),	/* POWER8 */
+	W(0xffff0000), W(0x004b0000),	/* POWER8E */
+	W(0xffff0000), W(0x004d0000),	/* POWER8 */
 	W(0xffffffff), W(0x0f000004),	/* all 2.07-compliant */
 	W(0xffffffff), W(0x0f000003),	/* all 2.06-compliant */
 	W(0xffffffff), W(0x0f000002),	/* all 2.05-compliant */
@@ -706,7 +707,7 @@ unsigned char ibm_architecture_vec[] = {
 	 * must match by the macro below. Update the definition if
 	 * the structure layout changes.
 	 */
-#define IBM_ARCH_VEC_NRCORES_OFFSET	117
+#define IBM_ARCH_VEC_NRCORES_OFFSET	125
 	W(NR_CPUS),			/* number of cores supported */
 	0,
 	0,
