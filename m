Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: Update ibm,
 architecture.vec for PAPR 2.7/POWER8
In-reply-to: <1351661656-6986-4-git-send-email-mikey@neuling.org>
References: <1351661656-6986-1-git-send-email-mikey@neuling.org>
 <1351661656-6986-4-git-send-email-mikey@neuling.org>
Date: Fri, 09 Nov 2012 17:23:11 +1100
Message-ID: <30008.1352442191@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update ibm,architecture.vec for POWER8 and allows us to support more
than one parition per core.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
v2: Missed some bits in the original post..

 arch/powerpc/kernel/prom_init.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index cb6c123..9ffb542 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -671,6 +671,7 @@ static void __init early_cmdline_parse(void)
 #define OV1_PPC_2_04		0x08	/* set if we support PowerPC 2.04 */
 #define OV1_PPC_2_05		0x04	/* set if we support PowerPC 2.05 */
 #define OV1_PPC_2_06		0x02	/* set if we support PowerPC 2.06 */
+#define OV1_PPC_2_07		0x01	/* set if we support PowerPC 2.07 */
 
 /* Option vector 2: Open Firmware options supported */
 #define OV2_REAL_MODE		0x20	/* set if we want OF in real mode */
@@ -707,6 +708,7 @@ static void __init early_cmdline_parse(void)
 #define OV5_PFO_HW_RNG		0x80	/* PFO Random Number Generator */
 #define OV5_PFO_HW_842		0x40	/* PFO Compression Accelerator */
 #define OV5_PFO_HW_ENCR		0x20	/* PFO Encryption Accelerator */
+#define OV5_SUB_PROCESSORS	0x01    /* 1,2,or 4 Sub-Processors supported */
 
 /* Option Vector 6: IBM PAPR hints */
 #define OV6_LINUX		0x02	/* Linux is our OS */
@@ -719,6 +721,8 @@ static unsigned char ibm_architecture_vec[] = {
 	W(0xfffe0000), W(0x003a0000),	/* POWER5/POWER5+ */
 	W(0xffff0000), W(0x003e0000),	/* POWER6 */
 	W(0xffff0000), W(0x003f0000),	/* POWER7 */
+	W(0xffff0000), W(0x004b0000),	/* POWER8 */
+	W(0xffffffff), W(0x0f000004),	/* all 2.07-compliant */
 	W(0xffffffff), W(0x0f000003),	/* all 2.06-compliant */
 	W(0xffffffff), W(0x0f000002),	/* all 2.05-compliant */
 	W(0xfffffffe), W(0x0f000001),	/* all 2.04-compliant and earlier */
@@ -728,7 +732,7 @@ static unsigned char ibm_architecture_vec[] = {
 	3 - 2,				/* length */
 	0,				/* don't ignore, don't halt */
 	OV1_PPC_2_00 | OV1_PPC_2_01 | OV1_PPC_2_02 | OV1_PPC_2_03 |
-	OV1_PPC_2_04 | OV1_PPC_2_05 | OV1_PPC_2_06,
+	OV1_PPC_2_04 | OV1_PPC_2_05 | OV1_PPC_2_06 | OV1_PPC_2_07,
 
 	/* option vector 2: Open Firmware options supported */
 	34 - 2,				/* length */
@@ -755,7 +759,7 @@ static unsigned char ibm_architecture_vec[] = {
 	OV4_MIN_ENT_CAP,		/* minimum VP entitled capacity */
 
 	/* option vector 5: PAPR/OF options */
-	18 - 2,				/* length */
+	19 - 2,				/* length */
 	0,				/* don't ignore, don't halt */
 	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_DRCONF_MEMORY |
 	OV5_DONATE_DEDICATE_CPU | OV5_MSI,
@@ -776,6 +780,7 @@ static unsigned char ibm_architecture_vec[] = {
 	0,
 	0,
 	OV5_PFO_HW_RNG | OV5_PFO_HW_ENCR | OV5_PFO_HW_842,
+	OV5_SUB_PROCESSORS,
 	/* option vector 6: IBM PAPR hints */
 	4 - 2,				/* length */
 	0,
-- 
1.7.9.5
