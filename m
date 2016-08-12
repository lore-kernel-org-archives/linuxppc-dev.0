Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9kkr0mlLzDr1k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 22:31:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 2/2] powerpc/prom: Switch to using structs for
 ibm_architecture_vec
Date: Fri, 12 Aug 2016 22:30:55 +1000
Message-Id: <1471005055-3320-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1471005055-3320-1-git-send-email-mpe@ellerman.id.au>
References: <1471005055-3320-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we've defined structures to describe each of the client
architecture vectors, we can use those to construct the value we pass to
firmware.

This avoids the tricks we previously played with the W() macro, allows
us to properly endian annotate fields, and should help to avoid bugs
introduced by failing to have the correct number of zero pad bytes
between fields.

It also means we can avoid hard coding IBM_ARCH_VEC_NRCORES_OFFSET in
order to update the max_cpus value and instead just set it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/prom.h |   6 -
 arch/powerpc/kernel/prom_init.c | 274 ++++++++++++++++++++++------------------
 2 files changed, 154 insertions(+), 126 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 7f436ba1b56f..5e57705b4759 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -159,11 +159,5 @@ struct of_drconf_cell {
 /* Option Vector 6: IBM PAPR hints */
 #define OV6_LINUX		0x02	/* Linux is our OS */
 
-/*
- * The architecture vector has an array of PVR mask/value pairs,
- * followed by # option vectors - 1, followed by the option vectors.
- */
-extern unsigned char ibm_architecture_vec[];
-
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_PROM_H */
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 3b188899801e..b3629e7208a4 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -634,13 +634,7 @@ static void __init early_cmdline_parse(void)
  *
  * See prom.h for the definition of the bits specified in the
  * architecture vector.
- *
- * Because the description vector contains a mix of byte and word
- * values, we declare it as an unsigned char array, and use this
- * macro to put word values in.
  */
-#define W(x)	((x) >> 24) & 0xff, ((x) >> 16) & 0xff, \
-		((x) >> 8) & 0xff, (x) & 0xff
 
 /* Firmware expects the value to be n - 1, where n is the # of vectors */
 #define NUM_VECTORS(n)		((n) - 1)
@@ -651,94 +645,6 @@ static void __init early_cmdline_parse(void)
  */
 #define VECTOR_LENGTH(n)	(1 + (n) - 2)
 
-unsigned char ibm_architecture_vec[] = {
-	W(0xfffe0000), W(0x003a0000),	/* POWER5/POWER5+ */
-	W(0xffff0000), W(0x003e0000),	/* POWER6 */
-	W(0xffff0000), W(0x003f0000),	/* POWER7 */
-	W(0xffff0000), W(0x004b0000),	/* POWER8E */
-	W(0xffff0000), W(0x004c0000),   /* POWER8NVL */
-	W(0xffff0000), W(0x004d0000),	/* POWER8 */
-	W(0xffffffff), W(0x0f000004),	/* all 2.07-compliant */
-	W(0xffffffff), W(0x0f000003),	/* all 2.06-compliant */
-	W(0xffffffff), W(0x0f000002),	/* all 2.05-compliant */
-	W(0xfffffffe), W(0x0f000001),	/* all 2.04-compliant and earlier */
-	NUM_VECTORS(6),			/* 6 option vectors */
-
-	/* option vector 1: processor architectures supported */
-	VECTOR_LENGTH(2),		/* length */
-	0,				/* don't ignore, don't halt */
-	OV1_PPC_2_00 | OV1_PPC_2_01 | OV1_PPC_2_02 | OV1_PPC_2_03 |
-	OV1_PPC_2_04 | OV1_PPC_2_05 | OV1_PPC_2_06 | OV1_PPC_2_07,
-
-	/* option vector 2: Open Firmware options supported */
-	VECTOR_LENGTH(33),		/* length */
-	OV2_REAL_MODE,
-	0, 0,
-	W(0xffffffff),			/* real_base */
-	W(0xffffffff),			/* real_size */
-	W(0xffffffff),			/* virt_base */
-	W(0xffffffff),			/* virt_size */
-	W(0xffffffff),			/* load_base */
-	W(256),				/* 256MB min RMA */
-	W(0xffffffff),			/* full client load */
-	0,				/* min RMA percentage of total RAM */
-	48,				/* max log_2(hash table size) */
-
-	/* option vector 3: processor options supported */
-	VECTOR_LENGTH(2),		/* length */
-	0,				/* don't ignore, don't halt */
-	OV3_FP | OV3_VMX | OV3_DFP,
-
-	/* option vector 4: IBM PAPR implementation */
-	VECTOR_LENGTH(2),		/* length */
-	0,				/* don't halt */
-	OV4_MIN_ENT_CAP,		/* minimum VP entitled capacity */
-
-	/* option vector 5: PAPR/OF options */
-	VECTOR_LENGTH(21),		/* length */
-	0,				/* don't ignore, don't halt */
-	OV5_FEAT(OV5_LPAR) | OV5_FEAT(OV5_SPLPAR) | OV5_FEAT(OV5_LARGE_PAGES) |
-	OV5_FEAT(OV5_DRCONF_MEMORY) | OV5_FEAT(OV5_DONATE_DEDICATE_CPU) |
-#ifdef CONFIG_PCI_MSI
-	/* PCIe/MSI support.  Without MSI full PCIe is not supported */
-	OV5_FEAT(OV5_MSI),
-#else
-	0,
-#endif
-	0,
-#ifdef CONFIG_PPC_SMLPAR
-	OV5_FEAT(OV5_CMO) | OV5_FEAT(OV5_XCMO),
-#else
-	0,
-#endif
-	OV5_FEAT(OV5_TYPE1_AFFINITY) | OV5_FEAT(OV5_PRRN),
-	0,
-	0,
-	0,
-	/* WARNING: The offset of the "number of cores" field below
-	 * must match by the macro below. Update the definition if
-	 * the structure layout changes.
-	 */
-#define IBM_ARCH_VEC_NRCORES_OFFSET	133
-	W(NR_CPUS),			/* number of cores supported */
-	0,
-	0,
-	0,
-	0,
-	OV5_FEAT(OV5_PFO_HW_RNG) | OV5_FEAT(OV5_PFO_HW_ENCR) |
-	OV5_FEAT(OV5_PFO_HW_842),				/* Byte 17 */
-	0,							/* Byte 18 */
-	0,							/* Byte 19 */
-	0,							/* Byte 20 */
-	OV5_FEAT(OV5_SUB_PROCESSORS),				/* Byte 21 */
-
-	/* option vector 6: IBM PAPR hints */
-	VECTOR_LENGTH(3),		/* length */
-	0,
-	0,
-	OV6_LINUX,
-};
-
 struct option_vector1 {
 	u8 byte1;
 	u8 arch_versions;
@@ -792,6 +698,154 @@ struct option_vector6 {
 	u8 os_name;
 } __packed;
 
+struct ibm_arch_vec {
+	struct { u32 mask, val; } pvrs[10];
+
+	u8 num_vectors;
+
+	u8 vec1_len;
+	struct option_vector1 vec1;
+
+	u8 vec2_len;
+	struct option_vector2 vec2;
+
+	u8 vec3_len;
+	struct option_vector3 vec3;
+
+	u8 vec4_len;
+	struct option_vector4 vec4;
+
+	u8 vec5_len;
+	struct option_vector5 vec5;
+
+	u8 vec6_len;
+	struct option_vector6 vec6;
+} __packed;
+
+struct ibm_arch_vec __cacheline_aligned ibm_architecture_vec = {
+	.pvrs = {
+		{
+			.mask = cpu_to_be32(0xfffe0000), /* POWER5/POWER5+ */
+			.val  = cpu_to_be32(0x003a0000),
+		},
+		{
+			.mask = cpu_to_be32(0xffff0000), /* POWER6 */
+			.val  = cpu_to_be32(0x003e0000),
+		},
+		{
+			.mask = cpu_to_be32(0xffff0000), /* POWER7 */
+			.val  = cpu_to_be32(0x003f0000),
+		},
+		{
+			.mask = cpu_to_be32(0xffff0000), /* POWER8E */
+			.val  = cpu_to_be32(0x004b0000),
+		},
+		{
+			.mask = cpu_to_be32(0xffff0000), /* POWER8NVL */
+			.val  = cpu_to_be32(0x004c0000),
+		},
+		{
+			.mask = cpu_to_be32(0xffff0000), /* POWER8 */
+			.val  = cpu_to_be32(0x004d0000),
+		},
+		{
+			.mask = cpu_to_be32(0xffffffff), /* all 2.07-compliant */
+			.val  = cpu_to_be32(0x0f000004),
+		},
+		{
+			.mask = cpu_to_be32(0xffffffff), /* all 2.06-compliant */
+			.val  = cpu_to_be32(0x0f000003),
+		},
+		{
+			.mask = cpu_to_be32(0xffffffff), /* all 2.05-compliant */
+			.val  = cpu_to_be32(0x0f000002),
+		},
+		{
+			.mask = cpu_to_be32(0xfffffffe), /* all 2.04-compliant and earlier */
+			.val  = cpu_to_be32(0x0f000001),
+		},
+	},
+
+	.num_vectors = NUM_VECTORS(6),
+
+	.vec1_len = VECTOR_LENGTH(sizeof(struct option_vector1)),
+	.vec1 = {
+		.byte1 = 0,
+		.arch_versions = OV1_PPC_2_00 | OV1_PPC_2_01 | OV1_PPC_2_02 | OV1_PPC_2_03 |
+				 OV1_PPC_2_04 | OV1_PPC_2_05 | OV1_PPC_2_06 | OV1_PPC_2_07,
+	},
+
+	.vec2_len = VECTOR_LENGTH(sizeof(struct option_vector2)),
+	/* option vector 2: Open Firmware options supported */
+	.vec2 = {
+		.byte1 = OV2_REAL_MODE,
+		.reserved = 0,
+		.real_base = cpu_to_be32(0xffffffff),
+		.real_size = cpu_to_be32(0xffffffff),
+		.virt_base = cpu_to_be32(0xffffffff),
+		.virt_size = cpu_to_be32(0xffffffff),
+		.load_base = cpu_to_be32(0xffffffff),
+		.min_rma = cpu_to_be32(256),		/* 256MB min RMA */
+		.min_load = cpu_to_be32(0xffffffff),	/* full client load */
+		.min_rma_percent = 0,	/* min RMA percentage of total RAM */
+		.max_pft_size = 48,	/* max log_2(hash table size) */
+	},
+
+	.vec3_len = VECTOR_LENGTH(sizeof(struct option_vector3)),
+	/* option vector 3: processor options supported */
+	.vec3 = {
+		.byte1 = 0,			/* don't ignore, don't halt */
+		.byte2 = OV3_FP | OV3_VMX | OV3_DFP,
+	},
+
+	.vec4_len = VECTOR_LENGTH(sizeof(struct option_vector4)),
+	/* option vector 4: IBM PAPR implementation */
+	.vec4 = {
+		.byte1 = 0,			/* don't halt */
+		.min_vp_cap = OV4_MIN_ENT_CAP,	/* minimum VP entitled capacity */
+	},
+
+	.vec5_len = VECTOR_LENGTH(sizeof(struct option_vector5)),
+	/* option vector 5: PAPR/OF options */
+	.vec5 = {
+		.byte1 = 0,				/* don't ignore, don't halt */
+		.byte2 = OV5_FEAT(OV5_LPAR) | OV5_FEAT(OV5_SPLPAR) | OV5_FEAT(OV5_LARGE_PAGES) |
+		OV5_FEAT(OV5_DRCONF_MEMORY) | OV5_FEAT(OV5_DONATE_DEDICATE_CPU) |
+#ifdef CONFIG_PCI_MSI
+		/* PCIe/MSI support.  Without MSI full PCIe is not supported */
+		OV5_FEAT(OV5_MSI),
+#else
+		0,
+#endif
+		.byte3 = 0,
+		.cmo =
+#ifdef CONFIG_PPC_SMLPAR
+		OV5_FEAT(OV5_CMO) | OV5_FEAT(OV5_XCMO),
+#else
+		0,
+#endif
+		.associativity = OV5_FEAT(OV5_TYPE1_AFFINITY) | OV5_FEAT(OV5_PRRN),
+		.bin_opts = 0,
+		.micro_checkpoint = 0,
+		.reserved0 = 0,
+		.max_cpus = cpu_to_be32(NR_CPUS),	/* number of cores supported */
+		.papr_level = 0,
+		.reserved1 = 0,
+		.platform_facilities = OV5_FEAT(OV5_PFO_HW_RNG) | OV5_FEAT(OV5_PFO_HW_ENCR) | OV5_FEAT(OV5_PFO_HW_842),
+		.reserved2 = 0,
+		.reserved3 = 0,
+		.subprocessors = 1,
+	},
+
+	/* option vector 6: IBM PAPR hints */
+	.vec6_len = VECTOR_LENGTH(sizeof(struct option_vector6)),
+	.vec6 = {
+		.reserved = 0,
+		.secondary_pteg = 0,
+		.os_name = OV6_LINUX,
+	},
+};
+
 /* Old method - ELF header with PT_NOTE sections only works on BE */
 #ifdef __BIG_ENDIAN__
 static struct fake_elf {
@@ -925,7 +979,6 @@ static void __init prom_send_capabilities(void)
 	ihandle root;
 	prom_arg_t ret;
 	u32 cores;
-	unsigned char *ptcores;
 
 	root = call_prom("open", 1, 1, ADDR("/"));
 	if (root != 0) {
@@ -936,37 +989,18 @@ static void __init prom_send_capabilities(void)
 		 * divide NR_CPUS.
 		 */
 
-		/* The core value may start at an odd address. If such a word
-		 * access is made at a cache line boundary, this leads to an
-		 * exception which may not be handled at this time.
-		 * Forcing a per byte access to avoid exception.
-		 */
-		ptcores = &ibm_architecture_vec[IBM_ARCH_VEC_NRCORES_OFFSET];
-		cores = 0;
-		cores |= ptcores[0] << 24;
-		cores |= ptcores[1] << 16;
-		cores |= ptcores[2] << 8;
-		cores |= ptcores[3];
-		if (cores != NR_CPUS) {
-			prom_printf("WARNING ! "
-				    "ibm_architecture_vec structure inconsistent: %lu!\n",
-				    cores);
-		} else {
-			cores = DIV_ROUND_UP(NR_CPUS, prom_count_smt_threads());
-			prom_printf("Max number of cores passed to firmware: %lu (NR_CPUS = %lu)\n",
-				    cores, NR_CPUS);
-			ptcores[0] = (cores >> 24) & 0xff;
-			ptcores[1] = (cores >> 16) & 0xff;
-			ptcores[2] = (cores >> 8) & 0xff;
-			ptcores[3] = cores & 0xff;
-		}
+		cores = DIV_ROUND_UP(NR_CPUS, prom_count_smt_threads());
+		prom_printf("Max number of cores passed to firmware: %lu (NR_CPUS = %lu)\n",
+			    cores, NR_CPUS);
+
+		ibm_architecture_vec.vec5.max_cpus = cpu_to_be32(cores);
 
 		/* try calling the ibm,client-architecture-support method */
 		prom_printf("Calling ibm,client-architecture-support...");
 		if (call_prom_ret("call-method", 3, 2, &ret,
 				  ADDR("ibm,client-architecture-support"),
 				  root,
-				  ADDR(ibm_architecture_vec)) == 0) {
+				  ADDR(&ibm_architecture_vec)) == 0) {
 			/* the call exists... */
 			if (ret)
 				prom_printf("\nWARNING: ibm,client-architecture"
-- 
2.7.4
