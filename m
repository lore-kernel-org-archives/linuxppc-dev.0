Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLKfr251kzDr9B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 10:13:24 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id p3so16973527qtg.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 17:13:24 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, linuxram@us.ibm.com,
 bauerman@linux.vnet.ibm.com, mhocko@kernel.org
Subject: [RFC v7 25/25] powerpc: Enable pkey subsystem
Date: Sun, 30 Jul 2017 17:12:26 -0700
Message-Id: <1501459946-11619-26-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PAPR defines 'ibm,processor-storage-keys' property. It exports
two values.The first value indicates the number of data-access
keys and the second indicates the number of instruction-access
keys. Though this alludes  that keys can be either data access
or instructon access only, that is not the case in reality.Any
key can be of any kind.  This patch adds all the keys and uses
that as the total number of keys available to us.

Non PAPR platforms do not define this property   in the device
tree yet. Here, we   hardcode   CPUs   that   support  pkey by
consulting PowerISA3.0

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/cputable.h    |    8 +++++---
 arch/powerpc/include/asm/mmu_context.h |    1 +
 arch/powerpc/include/asm/pkeys.h       |   32 ++++++++++++++++++++++++++++++--
 arch/powerpc/kernel/prom.c             |   19 +++++++++++++++++++
 4 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index d02ad93..1d9ed84 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -214,6 +214,7 @@ enum {
 #define CPU_FTR_DAWR			LONG_ASM_CONST(0x0400000000000000)
 #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
 #define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
+#define CPU_FTR_PKEY			LONG_ASM_CONST(0x2000000000000000)
 #define CPU_FTR_POWER9_DD1		LONG_ASM_CONST(0x4000000000000000)
 
 #ifndef __ASSEMBLY__
@@ -452,7 +453,7 @@ enum {
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | \
-	    CPU_FTR_VMX_COPY | CPU_FTR_HAS_PPR | CPU_FTR_DABRX)
+	    CPU_FTR_VMX_COPY | CPU_FTR_HAS_PPR | CPU_FTR_DABRX | CPU_FTR_PKEY)
 #define CPU_FTRS_POWER8 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_206 |\
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
@@ -462,7 +463,7 @@ enum {
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
-	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP)
+	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_PKEY)
 #define CPU_FTRS_POWER8E (CPU_FTRS_POWER8 | CPU_FTR_PMAO_BUG)
 #define CPU_FTRS_POWER8_DD1 (CPU_FTRS_POWER8 & ~CPU_FTR_DBELL)
 #define CPU_FTRS_POWER9 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
@@ -474,7 +475,8 @@ enum {
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
-	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_300)
+	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_300 | \
+	    CPU_FTR_PKEY)
 #define CPU_FTRS_POWER9_DD1 ((CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1) & \
 			     (~CPU_FTR_SAO))
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index a1cfcca..acd59d8 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -188,6 +188,7 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 
 #define pkey_initialize()
 #define pkey_mm_init(mm)
+#define pkey_mmu_values(total_data, total_execute)
 
 static inline int vma_pkey(struct vm_area_struct *vma)
 {
diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index ba7bff6..e61ed6c 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_PPC64_PKEYS_H
 #define _ASM_PPC64_PKEYS_H
 
+#include <asm/firmware.h>
+
 extern bool pkey_inited;
 extern int pkeys_total; /* total pkeys as per device tree */
 extern u32 initial_allocation_mask;/* bits set for reserved keys */
@@ -227,6 +229,24 @@ static inline void pkey_mm_init(struct mm_struct *mm)
 	mm->context.execute_only_pkey = -1;
 }
 
+static inline void pkey_mmu_values(int total_data, int total_execute)
+{
+	/*
+	 * since any pkey can be used for data or execute, we
+	 * will  just  treat all keys as equal and track them
+	 * as one entity.
+	 */
+	pkeys_total = total_data + total_execute;
+}
+
+static inline bool pkey_mmu_enabled(void)
+{
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		return pkeys_total;
+	else
+		return cpu_has_feature(CPU_FTR_PKEY);
+}
+
 static inline void pkey_initialize(void)
 {
 	int os_reserved, i;
@@ -236,9 +256,17 @@ static inline void pkey_initialize(void)
 	 * line will enable it.
 	 */
 	pkey_inited = false;
+	if (pkey_mmu_enabled())
+		pkey_inited = !radix_enabled();
+
+	if (!pkey_inited)
+		return;
 
-	/* Lets assume 32 keys */
-	pkeys_total = 32;
+	/* Lets assume 32 keys if we are not told
+	 * the number of pkeys.
+	 */
+	if (!pkeys_total)
+		pkeys_total = 32;
 
 #ifdef CONFIG_PPC_4K_PAGES
 	/*
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f830562..f61da26 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -35,6 +35,7 @@
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
 #include <linux/cpu.h>
+#include <linux/pkeys.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -228,6 +229,23 @@ static void __init check_cpu_pa_features(unsigned long node)
 		      ibm_pa_features, ARRAY_SIZE(ibm_pa_features));
 }
 
+static void __init check_cpu_pkey_feature(unsigned long node)
+{
+	const __be32 *ftrs;
+	int len, total_data, total_execute;
+
+	ftrs = of_get_flat_dt_prop(node,
+		"ibm,processor-storage-keys", &len);
+	if (ftrs == NULL)
+		return;
+
+	len /= sizeof(int);
+	total_execute = (len >= 2) ? be32_to_cpu(ftrs[1]) : 0;
+	total_data = (len >= 1) ? be32_to_cpu(ftrs[0]) : 0;
+	pkey_mmu_values(total_data, total_execute);
+}
+
+
 #ifdef CONFIG_PPC_STD_MMU_64
 static void __init init_mmu_slb_size(unsigned long node)
 {
@@ -391,6 +409,7 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 
 		check_cpu_feature_properties(node);
 		check_cpu_pa_features(node);
+		check_cpu_pkey_feature(node);
 	}
 
 	identical_pvr_fixup(node);
-- 
1.7.1
