Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/4] powerpc/pseries: Update ibm,
 architecture.vec for PAPR 2.7/POWER8
Date: Wed, 31 Oct 2012 16:34:16 +1100
Message-Id: <1351661656-6986-4-git-send-email-mikey@neuling.org>
In-Reply-To: <1351661656-6986-1-git-send-email-mikey@neuling.org>
References: <1351661656-6986-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update ibm,architecture.vec for Sub-Processor Representation Level.
Allows us to support more than one parition per core.

This is untested so far as we don't have pHyp

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/prom_init.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index cb6c123..09b1c7c 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -707,6 +707,7 @@ static void __init early_cmdline_parse(void)
 #define OV5_PFO_HW_RNG		0x80	/* PFO Random Number Generator */
 #define OV5_PFO_HW_842		0x40	/* PFO Compression Accelerator */
 #define OV5_PFO_HW_ENCR		0x20	/* PFO Encryption Accelerator */
+#define OV5_SUB_PROCESSORS	0x01    /* 1,2,or 4 Sub-Processors supported */
 
 /* Option Vector 6: IBM PAPR hints */
 #define OV6_LINUX		0x02	/* Linux is our OS */
@@ -755,7 +756,7 @@ static unsigned char ibm_architecture_vec[] = {
 	OV4_MIN_ENT_CAP,		/* minimum VP entitled capacity */
 
 	/* option vector 5: PAPR/OF options */
-	18 - 2,				/* length */
+	19 - 2,				/* length */
 	0,				/* don't ignore, don't halt */
 	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_DRCONF_MEMORY |
 	OV5_DONATE_DEDICATE_CPU | OV5_MSI,
@@ -776,6 +777,7 @@ static unsigned char ibm_architecture_vec[] = {
 	0,
 	0,
 	OV5_PFO_HW_RNG | OV5_PFO_HW_ENCR | OV5_PFO_HW_842,
+	OV5_SUB_PROCESSORS,
 	/* option vector 6: IBM PAPR hints */
 	4 - 2,				/* length */
 	0,
-- 
1.7.9.5
