Return-Path: <sjitindarsingh@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTzs871vbzDqHW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 16:18:20 +1100 (AEDT)
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTzs81Q87z9s65
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 16:18:20 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 5so1718541pgj.0
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2017 21:18:20 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 ruscur@russell.cc, sam.bobroff@au1.ibm.com, mikey@neuling.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH V2 2/2] arch/powerpc/CAS: Update to new option-vector-5 format
 for CAS
Date: Fri, 24 Feb 2017 16:17:51 +1100
Message-Id: <1487913471-20959-2-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1487913471-20959-1-git-send-email-sjitindarsingh@gmail.com>
References: <1487913471-20959-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On POWER9 the ibm,client-architecture-support (CAS) negotiation process
has been updated to change how the host to guest negotiation is done for
the new hash/radix mmu as well as the nest mmu, process tables and guest
translation shootdown (GTSE).

The host tells the guest which options it supports in
ibm,arch-vec-5-platform-support. The guest then chooses a subset of these
to request in the CAS call and these are agreed to in the
ibm,architecture-vec-5 property of the chosen node.

Thus we read ibm,arch-vec-5-platform-support and make our selection before
calling CAS. We then parse the ibm,architecture-vec-5 property of the
chosen node to check whether we should run as hash or radix.

ibm,arch-vec-5-platform-support format:

index value pairs: <index, val> ... <index, val>

index: Option vector 5 byte number
val:   Some representation of supported values

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

---

V1 -> V2:
 - Fix error where whole byte was compared for mmu support instead of only the
   first two bytes
 - Break platform support parsing into multiple functions for clarity
 - Instead of printing WARNING: messages on old hypervisors change to a debug
   message
---
 arch/powerpc/include/asm/prom.h |  17 ++++--
 arch/powerpc/kernel/prom_init.c | 120 ++++++++++++++++++++++++++++++++++++++--
 arch/powerpc/mm/init_64.c       |  36 ++++++++++--
 3 files changed, 157 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 8af2546..d838b9d 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -158,12 +158,17 @@ struct of_drconf_cell {
 #define OV5_PFO_HW_ENCR		0x1120	/* PFO Encryption Accelerator */
 #define OV5_SUB_PROCESSORS	0x1501	/* 1,2,or 4 Sub-Processors supported */
 #define OV5_XIVE_EXPLOIT	0x1701	/* XIVE exploitation supported */
-#define OV5_MMU_RADIX_300	0x1880	/* ISA v3.00 radix MMU supported */
-#define OV5_MMU_HASH_300	0x1840	/* ISA v3.00 hash MMU supported */
-#define OV5_MMU_SEGM_RADIX	0x1820	/* radix mode (no segmentation) */
-#define OV5_MMU_PROC_TBL	0x1810	/* hcall selects SLB or proc table */
-#define OV5_MMU_SLB		0x1800	/* always use SLB */
-#define OV5_MMU_GTSE		0x1808	/* Guest translation shootdown */
+/* MMU Base Architecture */
+#define OV5_MMU_SUPPORT		0x18C0	/* MMU Mode Support Mask */
+#define OV5_MMU_HASH		0x00	/* Hash MMU Only */
+#define OV5_MMU_RADIX		0x40	/* Radix MMU Only */
+#define OV5_MMU_EITHER		0x80	/* Hash or Radix Supported */
+#define OV5_NMMU		0x1820	/* Nest MMU Available */
+/* Hash Table Extensions */
+#define OV5_HASH_SEG_TBL	0x1980	/* In Memory Segment Tables Available */
+#define OV5_HASH_GTSE		0x1940	/* Guest Translation Shoot Down Avail */
+/* Radix Table Extensions */
+#define OV5_RADIX_GTSE		0x1A40	/* Guest Translation Shoot Down Avail */
 
 /* Option Vector 6: IBM PAPR hints */
 #define OV6_LINUX		0x02	/* Linux is our OS */
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 37b5a29..08cd1b8 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -168,6 +168,14 @@ static unsigned long __initdata prom_tce_alloc_start;
 static unsigned long __initdata prom_tce_alloc_end;
 #endif
 
+static bool __initdata prom_radix_disable;
+
+struct platform_support {
+	bool hash_mmu;
+	bool radix_mmu;
+	bool radix_gtse;
+};
+
 /* Platforms codes are now obsolete in the kernel. Now only used within this
  * file and ultimately gone too. Feel free to change them if you need, they
  * are not shared with anything outside of this file anymore
@@ -626,6 +634,12 @@ static void __init early_cmdline_parse(void)
 		prom_memory_limit = ALIGN(prom_memory_limit, 0x1000000);
 #endif
 	}
+
+	opt = strstr(prom_cmd_line, "disable_radix");
+	if (opt) {
+		prom_debug("Radix disabled from cmdline\n");
+		prom_radix_disable = true;
+	}
 }
 
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
@@ -693,8 +707,10 @@ struct option_vector5 {
 	__be16 reserved3;
 	u8 subprocessors;
 	u8 byte22;
-	u8 intarch;
+	u8 xive;
 	u8 mmu;
+	u8 hash_ext;
+	u8 radix_ext;
 } __packed;
 
 struct option_vector6 {
@@ -849,9 +865,10 @@ struct ibm_arch_vec __cacheline_aligned ibm_architecture_vec = {
 		.reserved2 = 0,
 		.reserved3 = 0,
 		.subprocessors = 1,
-		.intarch = 0,
-		.mmu = OV5_FEAT(OV5_MMU_RADIX_300) | OV5_FEAT(OV5_MMU_HASH_300) |
-			OV5_FEAT(OV5_MMU_PROC_TBL) | OV5_FEAT(OV5_MMU_GTSE),
+		.xive = 0,
+		.mmu = 0,
+		.hash_ext = 0,
+		.radix_ext = 0,
 	},
 
 	/* option vector 6: IBM PAPR hints */
@@ -990,6 +1007,98 @@ static int __init prom_count_smt_threads(void)
 
 }
 
+static void __init prom_parse_mmu_model(u8 val,
+					struct platform_support *support)
+{
+	switch (val) {
+	case OV5_MMU_EITHER: /* Either Available */
+		prom_debug("MMU - either supported\n");
+		support->radix_mmu = !prom_radix_disable;
+		support->hash_mmu = true;
+		break;
+	case OV5_MMU_RADIX: /* Only Radix */
+		prom_debug("MMU - radix only\n");
+		if (prom_radix_disable) {
+			/*
+			 * If we __have__ to do radix, we're better off ignoring
+			 * the command line rather than not booting.
+			 */
+			prom_printf("WARNING: Ignoring cmdline option disable_radix\n");
+		}
+		support->radix_mmu = true;
+		break;
+	case OV5_MMU_HASH:
+		prom_debug("MMU - hash only\n");
+		support->hash_mmu = true;
+		break;
+	default:
+		prom_debug("Unknown mmu support option: 0x%x\n", val);
+		break;
+	}
+}
+
+static void __init prom_parse_platform_support(u8 index, u8 val,
+					       struct platform_support *support)
+{
+	switch (index) {
+	case OV5_INDX(OV5_XIVE_EXPLOIT): /* Unimplemented - Ignore */
+		break;
+	case OV5_INDX(OV5_MMU_SUPPORT): /* MMU Model */
+		prom_parse_mmu_model(val & OV5_FEAT(OV5_MMU_SUPPORT), support);
+		break;
+	case OV5_INDX(OV5_HASH_SEG_TBL): /* Unimplemented - Ignore */
+		break;
+	case OV5_INDX(OV5_RADIX_GTSE): /* Radix Extensions */
+		if (val & OV5_FEAT(OV5_RADIX_GTSE)) {
+			prom_debug("Radix - GTSE supported\n");
+			support->radix_gtse = true;
+		}
+		break;
+	default:
+		prom_debug("Unknown platform support option above\n");
+		break;
+	}
+}
+
+static void __init prom_check_platform_support(void)
+{
+	struct platform_support supported = {
+		.hash_mmu = false,
+		.radix_mmu = false,
+		.radix_gtse = false
+	};
+	int prop_len = prom_getproplen(prom.chosen,
+				       "ibm,arch-vec-5-platform-support");
+	if (prop_len > 1) {
+		int i;
+		u8 vec[prop_len];
+		prom_debug("Found ibm,arch-vec-5-platform-support, len: %d\n",
+			   prop_len);
+		prom_getprop(prom.chosen, "ibm,arch-vec-5-platform-support",
+			     &vec, sizeof(vec));
+		for (i = 0; i < prop_len; i += 2) {
+			prom_debug("%d: index = 0x%x val = 0x%x\n", i / 2
+								  , vec[i]
+								  , vec[i + 1]);
+			prom_parse_platform_support(vec[i], vec[i + 1],
+						    &supported);
+		}
+	}
+
+	if (supported.radix_mmu && supported.radix_gtse) {
+		/* Radix preferred - but we require GTSE for now */
+		prom_debug("Asking for radix with GTSE\n");
+		ibm_architecture_vec.vec5.mmu = OV5_FEAT(OV5_MMU_RADIX);
+		ibm_architecture_vec.vec5.radix_ext = OV5_FEAT(OV5_RADIX_GTSE);
+	} else if (supported.hash_mmu) {
+		/* Default to hash mmu (if we can) */
+		prom_debug("Asking for hash\n");
+		ibm_architecture_vec.vec5.mmu = OV5_FEAT(OV5_MMU_HASH);
+	} else {
+		/* We're probably on a legacy hypervisor */
+		prom_debug("Assuming legacy hash support\n");
+	}
+}
 
 static void __init prom_send_capabilities(void)
 {
@@ -997,6 +1106,9 @@ static void __init prom_send_capabilities(void)
 	prom_arg_t ret;
 	u32 cores;
 
+	/* Check ibm,arch-vec-5-platform-support and fixup vec5 if required */
+	prom_check_platform_support();
+
 	root = call_prom("open", 1, 1, ADDR("/"));
 	if (root != 0) {
 		/* We need to tell the FW about the number of cores we support.
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 6aa3b76..9be9920 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -356,18 +356,42 @@ static void early_check_vec5(void)
 	unsigned long root, chosen;
 	int size;
 	const u8 *vec5;
+	u8 mmu_supported;
 
 	root = of_get_flat_dt_root();
 	chosen = of_get_flat_dt_subnode_by_name(root, "chosen");
-	if (chosen == -FDT_ERR_NOTFOUND)
+	if (chosen == -FDT_ERR_NOTFOUND) {
+		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
 		return;
+	}
 	vec5 = of_get_flat_dt_prop(chosen, "ibm,architecture-vec-5", &size);
-	if (!vec5)
+	if (!vec5) {
+		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
 		return;
-	if (size <= OV5_INDX(OV5_MMU_RADIX_300) ||
-	    !(vec5[OV5_INDX(OV5_MMU_RADIX_300)] & OV5_FEAT(OV5_MMU_RADIX_300)))
-		/* Hypervisor doesn't support radix */
+	}
+	if (size <= OV5_INDX(OV5_MMU_SUPPORT)) {
 		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
+		return;
+	}
+
+	/* Check for supported configuration */
+	mmu_supported = vec5[OV5_INDX(OV5_MMU_SUPPORT)] &
+			OV5_FEAT(OV5_MMU_SUPPORT);
+	if (mmu_supported == OV5_FEAT(OV5_MMU_RADIX)) {
+		/* Hypervisor only supports radix - check enabled && GTSE */
+		if (!early_radix_enabled()) {
+			pr_warn("WARNING: Ignoring cmdline option disable_radix\n");
+		}
+		if (!(vec5[OV5_INDX(OV5_RADIX_GTSE)] &
+						OV5_FEAT(OV5_RADIX_GTSE))) {
+			pr_warn("WARNING: Hypervisor doesn't support RADIX with GTSE\n");
+		}
+		/* Do radix anyway - the hypervisor said we had to */
+		cur_cpu_spec->mmu_features |= MMU_FTR_TYPE_RADIX;
+	} else if (mmu_supported == OV5_FEAT(OV5_MMU_HASH)) {
+		/* Hypervisor only supports hash - disable radix */
+		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
+	}
 }
 
 void __init mmu_early_init_devtree(void)
@@ -383,7 +407,7 @@ void __init mmu_early_init_devtree(void)
 	 * even though the ibm,architecture-vec-5 property created by
 	 * skiboot doesn't have the necessary bits set.
 	 */
-	if (early_radix_enabled() && !(mfmsr() & MSR_HV))
+	if (!(mfmsr() & MSR_HV))
 		early_check_vec5();
 
 	if (early_radix_enabled())
-- 
2.5.5
