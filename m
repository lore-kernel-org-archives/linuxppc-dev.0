Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBln96SZ3zDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 21:22:05 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 03/20] powerpc/64: Enable use of radix MMU under hypervisor
 on POWER9
Date: Mon, 30 Jan 2017 21:21:36 +1100
Message-Id: <1485771713-24801-4-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
References: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To use radix as a guest, we first need to tell the hypervisor via
the ibm,client-architecture call first that we support POWER9 and
architecture v3.00, and that we can do either radix or hash and
that we would like to choose later using an hcall (the
H_REGISTER_PROC_TBL hcall).

Then we need to check whether the hypervisor agreed to us using
radix.  We need to do this very early on in the kernel boot process
before any of the MMU initialization is done.  If the hypervisor
doesn't agree, we can't use radix and therefore clear the radix
MMU feature bit.

Later, when we have set up our process table, which points to the
radix tree for each process, we need to install that using the
H_REGISTER_PROC_TBL hcall.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/book3s/64/mmu.h |  2 ++
 arch/powerpc/include/asm/hvcall.h        | 11 +++++++++++
 arch/powerpc/include/asm/prom.h          |  9 +++++++++
 arch/powerpc/kernel/prom_init.c          | 18 +++++++++++++++++-
 arch/powerpc/mm/init_64.c                | 12 +++++++-----
 arch/powerpc/mm/pgtable-radix.c          |  2 ++
 arch/powerpc/platforms/pseries/lpar.c    | 29 +++++++++++++++++++++++++++++
 7 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 8afb0e0..e8cbdc0 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -138,5 +138,7 @@ static inline void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 extern int (*register_process_table)(unsigned long base, unsigned long page_size,
 				     unsigned long tbl_size);
 
+extern void radix_init_pseries(void);
+
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_MMU_H_ */
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 77ff1ba..54d11b3 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -276,6 +276,7 @@
 #define H_GET_MPP_X		0x314
 #define H_SET_MODE		0x31C
 #define H_CLEAR_HPT		0x358
+#define H_REGISTER_PROC_TBL	0x37C
 #define H_SIGNAL_SYS_RESET	0x380
 #define MAX_HCALL_OPCODE	H_SIGNAL_SYS_RESET
 
@@ -313,6 +314,16 @@
 #define H_SIGNAL_SYS_RESET_ALL_OTHERS		-2
 /* >= 0 values are CPU number */
 
+/* Flag values used in H_REGISTER_PROC_TBL hcall */
+#define PROC_TABLE_OP_MASK	0x18
+#define PROC_TABLE_DEREG	0x10
+#define PROC_TABLE_NEW		0x18
+#define PROC_TABLE_TYPE_MASK	0x06
+#define PROC_TABLE_HPT_SLB	0x00
+#define PROC_TABLE_HPT_PT	0x02
+#define PROC_TABLE_RADIX	0x04
+#define PROC_TABLE_GTSE		0x01
+
 #ifndef __ASSEMBLY__
 
 /**
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index e6d83d0..8af2546 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -121,6 +121,8 @@ struct of_drconf_cell {
 #define OV1_PPC_2_06		0x02	/* set if we support PowerPC 2.06 */
 #define OV1_PPC_2_07		0x01	/* set if we support PowerPC 2.07 */
 
+#define OV1_PPC_3_00		0x80	/* set if we support PowerPC 3.00 */
+
 /* Option vector 2: Open Firmware options supported */
 #define OV2_REAL_MODE		0x20	/* set if we want OF in real mode */
 
@@ -155,6 +157,13 @@ struct of_drconf_cell {
 #define OV5_PFO_HW_842		0x1140	/* PFO Compression Accelerator */
 #define OV5_PFO_HW_ENCR		0x1120	/* PFO Encryption Accelerator */
 #define OV5_SUB_PROCESSORS	0x1501	/* 1,2,or 4 Sub-Processors supported */
+#define OV5_XIVE_EXPLOIT	0x1701	/* XIVE exploitation supported */
+#define OV5_MMU_RADIX_300	0x1880	/* ISA v3.00 radix MMU supported */
+#define OV5_MMU_HASH_300	0x1840	/* ISA v3.00 hash MMU supported */
+#define OV5_MMU_SEGM_RADIX	0x1820	/* radix mode (no segmentation) */
+#define OV5_MMU_PROC_TBL	0x1810	/* hcall selects SLB or proc table */
+#define OV5_MMU_SLB		0x1800	/* always use SLB */
+#define OV5_MMU_GTSE		0x1808	/* Guest translation shootdown */
 
 /* Option Vector 6: IBM PAPR hints */
 #define OV6_LINUX		0x02	/* Linux is our OS */
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index ec47a93..358d43f 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -649,6 +649,7 @@ static void __init early_cmdline_parse(void)
 struct option_vector1 {
 	u8 byte1;
 	u8 arch_versions;
+	u8 arch_versions3;
 } __packed;
 
 struct option_vector2 {
@@ -691,6 +692,9 @@ struct option_vector5 {
 	u8 reserved2;
 	__be16 reserved3;
 	u8 subprocessors;
+	u8 byte22;
+	u8 intarch;
+	u8 mmu;
 } __packed;
 
 struct option_vector6 {
@@ -700,7 +704,7 @@ struct option_vector6 {
 } __packed;
 
 struct ibm_arch_vec {
-	struct { u32 mask, val; } pvrs[10];
+	struct { u32 mask, val; } pvrs[12];
 
 	u8 num_vectors;
 
@@ -750,6 +754,14 @@ struct ibm_arch_vec __cacheline_aligned ibm_architecture_vec = {
 			.val  = cpu_to_be32(0x004d0000),
 		},
 		{
+			.mask = cpu_to_be32(0xffff0000), /* POWER9 */
+			.val  = cpu_to_be32(0x004e0000),
+		},
+		{
+			.mask = cpu_to_be32(0xffffffff), /* all 3.00-compliant */
+			.val  = cpu_to_be32(0x0f000005),
+		},
+		{
 			.mask = cpu_to_be32(0xffffffff), /* all 2.07-compliant */
 			.val  = cpu_to_be32(0x0f000004),
 		},
@@ -774,6 +786,7 @@ struct ibm_arch_vec __cacheline_aligned ibm_architecture_vec = {
 		.byte1 = 0,
 		.arch_versions = OV1_PPC_2_00 | OV1_PPC_2_01 | OV1_PPC_2_02 | OV1_PPC_2_03 |
 				 OV1_PPC_2_04 | OV1_PPC_2_05 | OV1_PPC_2_06 | OV1_PPC_2_07,
+		.arch_versions3 = OV1_PPC_3_00,
 	},
 
 	.vec2_len = VECTOR_LENGTH(sizeof(struct option_vector2)),
@@ -836,6 +849,9 @@ struct ibm_arch_vec __cacheline_aligned ibm_architecture_vec = {
 		.reserved2 = 0,
 		.reserved3 = 0,
 		.subprocessors = 1,
+		.intarch = 0,
+		.mmu = OV5_FEAT(OV5_MMU_RADIX_300) | OV5_FEAT(OV5_MMU_HASH_300) |
+			OV5_FEAT(OV5_MMU_PROC_TBL) | OV5_FEAT(OV5_MMU_GTSE),
 	},
 
 	/* option vector 6: IBM PAPR hints */
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 4d9481e..10c9a54 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -347,10 +347,9 @@ static int __init parse_disable_radix(char *p)
 early_param("disable_radix", parse_disable_radix);
 
 /*
- * If we're running under a hypervisor, we currently can't do radix
- * since we don't have the code to do the H_REGISTER_PROC_TBL hcall.
- * We tell that we're running under a hypervisor by looking for the
- * /chosen/ibm,architecture-vec-5 property.
+ * If we're running under a hypervisor, we need to check the contents of
+ * /chosen/ibm,architecture-vec-5 to see if the hypervisor is willing to do
+ * radix.  If not, we clear the radix feature bit so we fall back to hash.
  */
 static void early_check_vec5(void)
 {
@@ -365,7 +364,10 @@ static void early_check_vec5(void)
 	vec5 = of_get_flat_dt_prop(chosen, "ibm,architecture-vec-5", &size);
 	if (!vec5)
 		return;
-	cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
+	if (size <= OV5_INDX(OV5_MMU_RADIX_300) ||
+	    !(vec5[OV5_INDX(OV5_MMU_RADIX_300)] & OV5_FEAT(OV5_MMU_RADIX_300)))
+		/* Hypervisor doesn't support radix */
+		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
 }
 
 void __init mmu_early_init_devtree(void)
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index cfa53cc..94323c4 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -401,6 +401,8 @@ void __init radix__early_init_mmu(void)
 		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
 		radix_init_partition_table();
 		radix_init_amor();
+	} else {
+		radix_init_pseries();
 	}
 
 	memblock_set_current_limit(MEMBLOCK_ALLOC_ANYWHERE);
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 5dc1c3c..364429c 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -609,6 +609,29 @@ static int __init disable_bulk_remove(char *str)
 
 __setup("bulk_remove=", disable_bulk_remove);
 
+/* Actually only used for radix, so far */
+static int pSeries_lpar_register_process_table(unsigned long base,
+			unsigned long page_size, unsigned long table_size)
+{
+	long rc;
+	unsigned long flags = PROC_TABLE_NEW;
+
+	if (radix_enabled())
+		flags |= PROC_TABLE_RADIX | PROC_TABLE_GTSE;
+	for (;;) {
+		rc = plpar_hcall_norets(H_REGISTER_PROC_TBL, flags, base,
+					page_size, table_size);
+		if (!H_IS_LONG_BUSY(rc))
+			break;
+		mdelay(get_longbusy_msecs(rc));
+	}
+	if (rc != H_SUCCESS) {
+		pr_err("Failed to register process table (rc=%ld)\n", rc);
+		BUG();
+	}
+	return rc;
+}
+
 void __init hpte_init_pseries(void)
 {
 	mmu_hash_ops.hpte_invalidate	 = pSeries_lpar_hpte_invalidate;
@@ -622,6 +645,12 @@ void __init hpte_init_pseries(void)
 	mmu_hash_ops.hugepage_invalidate = pSeries_lpar_hugepage_invalidate;
 }
 
+void radix_init_pseries(void)
+{
+	pr_info("Using radix MMU under hypervisor\n");
+	register_process_table = pSeries_lpar_register_process_table;
+}
+
 #ifdef CONFIG_PPC_SMLPAR
 #define CMO_FREE_HINT_DEFAULT 1
 static int cmo_free_hint_flag = CMO_FREE_HINT_DEFAULT;
-- 
2.7.4
