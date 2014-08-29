Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21FF71A0024
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Aug 2014 17:01:47 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Add macros for the ibm_architecture_vec[] lengths
Date: Fri, 29 Aug 2014 17:01:43 +1000
Message-Id: <1409295703-31174-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The encoding of the lengths in the ibm_architecture_vec array is
"interesting" to say the least. It's non-obvious how the number of bytes
we provide relates to the length value.

In fact we already got it wrong once, see 11e9ed43ca8a "Fix up
ibm_architecture_vec definition".

So add some macros to make it (hopefully) clearer. These at least have
the property that the integer present in the code is equal to the number
of bytes that follows it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom_init.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 1a85d8f96739..962ac852ce0b 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -642,6 +642,15 @@ static void __init early_cmdline_parse(void)
 #define W(x)	((x) >> 24) & 0xff, ((x) >> 16) & 0xff, \
 		((x) >> 8) & 0xff, (x) & 0xff
 
+/* Firmware expects the value to be n - 1, where n is the # of vectors */
+#define NUM_VECTORS(n)		((n) - 1)
+
+/*
+ * Firmware expects 1 + n - 2, where n is the length of the option vector in
+ * bytes. The 1 accounts for the length byte itself, the - 2 .. ?
+ */
+#define VECTOR_LENGTH(n)	(1 + (n) - 2)
+
 unsigned char ibm_architecture_vec[] = {
 	W(0xfffe0000), W(0x003a0000),	/* POWER5/POWER5+ */
 	W(0xffff0000), W(0x003e0000),	/* POWER6 */
@@ -652,16 +661,16 @@ unsigned char ibm_architecture_vec[] = {
 	W(0xffffffff), W(0x0f000003),	/* all 2.06-compliant */
 	W(0xffffffff), W(0x0f000002),	/* all 2.05-compliant */
 	W(0xfffffffe), W(0x0f000001),	/* all 2.04-compliant and earlier */
-	6 - 1,				/* 6 option vectors */
+	NUM_VECTORS(6),			/* 6 option vectors */
 
 	/* option vector 1: processor architectures supported */
-	3 - 2,				/* length */
+	VECTOR_LENGTH(2),		/* length */
 	0,				/* don't ignore, don't halt */
 	OV1_PPC_2_00 | OV1_PPC_2_01 | OV1_PPC_2_02 | OV1_PPC_2_03 |
 	OV1_PPC_2_04 | OV1_PPC_2_05 | OV1_PPC_2_06 | OV1_PPC_2_07,
 
 	/* option vector 2: Open Firmware options supported */
-	34 - 2,				/* length */
+	VECTOR_LENGTH(33),		/* length */
 	OV2_REAL_MODE,
 	0, 0,
 	W(0xffffffff),			/* real_base */
@@ -675,17 +684,17 @@ unsigned char ibm_architecture_vec[] = {
 	48,				/* max log_2(hash table size) */
 
 	/* option vector 3: processor options supported */
-	3 - 2,				/* length */
+	VECTOR_LENGTH(2),		/* length */
 	0,				/* don't ignore, don't halt */
 	OV3_FP | OV3_VMX | OV3_DFP,
 
 	/* option vector 4: IBM PAPR implementation */
-	3 - 2,				/* length */
+	VECTOR_LENGTH(2),		/* length */
 	0,				/* don't halt */
 	OV4_MIN_ENT_CAP,		/* minimum VP entitled capacity */
 
 	/* option vector 5: PAPR/OF options */
-	19 - 2,				/* length */
+	VECTOR_LENGTH(18),		/* length */
 	0,				/* don't ignore, don't halt */
 	OV5_FEAT(OV5_LPAR) | OV5_FEAT(OV5_SPLPAR) | OV5_FEAT(OV5_LARGE_PAGES) |
 	OV5_FEAT(OV5_DRCONF_MEMORY) | OV5_FEAT(OV5_DONATE_DEDICATE_CPU) |
@@ -718,12 +727,12 @@ unsigned char ibm_architecture_vec[] = {
 	OV5_FEAT(OV5_PFO_HW_RNG) | OV5_FEAT(OV5_PFO_HW_ENCR) |
 	OV5_FEAT(OV5_PFO_HW_842),
 	OV5_FEAT(OV5_SUB_PROCESSORS),
+
 	/* option vector 6: IBM PAPR hints */
-	4 - 2,				/* length */
+	VECTOR_LENGTH(3),		/* length */
 	0,
 	0,
 	OV6_LINUX,
-
 };
 
 /* Old method - ELF header with PT_NOTE sections only works on BE */
-- 
1.9.1
