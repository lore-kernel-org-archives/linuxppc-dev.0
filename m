Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpssC66nWzDrcr
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 08:47:27 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id q8so2360567qtb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 15:47:27 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: [PATCH 25/25] powerpc: Enable pkey subsystem
Date: Fri,  8 Sep 2017 15:45:13 -0700
Message-Id: <1504910713-7094-34-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
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
keys. Though this hints that keys  can  be  either data access
or instruction access only,that is not the case in reality.Any
key can be of any kind.  This patch adds all the keys and uses
that as the total number of keys available to us.

Non PAPR platforms do not define this property   in the device
tree yet. Here, we   hardcode   CPUs   that   support  pkey by
consulting PowerISA3.0

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/cputable.h    |   15 ++++++++++-----
 arch/powerpc/include/asm/mmu_context.h |    1 +
 arch/powerpc/include/asm/pkeys.h       |   21 +++++++++++++++++++++
 arch/powerpc/kernel/prom.c             |   19 +++++++++++++++++++
 arch/powerpc/mm/pkeys.c                |   19 ++++++++++++++-----
 5 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index a9bf921..31ed1d2 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -214,7 +214,9 @@ enum {
 #define CPU_FTR_DAWR			LONG_ASM_CONST(0x0400000000000000)
 #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
 #define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
+#define CPU_FTR_PKEY			LONG_ASM_CONST(0x2000000000000000)
 #define CPU_FTR_POWER9_DD1		LONG_ASM_CONST(0x4000000000000000)
+#define CPU_FTR_PKEY_EXECUTE		LONG_ASM_CONST(0x8000000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -435,7 +437,8 @@ enum {
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_PURR | \
-	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_DABRX)
+	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_DABRX | \
+	    CPU_FTR_PKEY)
 #define CPU_FTRS_POWER6 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
@@ -443,7 +446,7 @@ enum {
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_UNALIGNED_LD_STD | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_CFAR | \
-	    CPU_FTR_DABRX)
+	    CPU_FTR_DABRX | CPU_FTR_PKEY)
 #define CPU_FTRS_POWER7 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_206 |\
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
@@ -452,7 +455,7 @@ enum {
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | \
-	    CPU_FTR_VMX_COPY | CPU_FTR_HAS_PPR | CPU_FTR_DABRX)
+	    CPU_FTR_VMX_COPY | CPU_FTR_HAS_PPR | CPU_FTR_DABRX | CPU_FTR_PKEY)
 #define CPU_FTRS_POWER8 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_206 |\
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
@@ -462,7 +465,8 @@ enum {
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
-	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP)
+	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_PKEY |\
+	    CPU_FTR_PKEY_EXECUTE)
 #define CPU_FTRS_POWER8E (CPU_FTRS_POWER8 | CPU_FTR_PMAO_BUG)
 #define CPU_FTRS_POWER8_DD1 (CPU_FTRS_POWER8 & ~CPU_FTR_DBELL)
 #define CPU_FTRS_POWER9 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
@@ -474,7 +478,8 @@ enum {
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
-	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_300)
+	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_300 | \
+	    CPU_FTR_PKEY | CPU_FTR_PKEY_EXECUTE)
 #define CPU_FTRS_POWER9_DD1 ((CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1) & \
 			     (~CPU_FTR_SAO))
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 9a56355..98ac713 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -148,6 +148,7 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 
 #define pkey_initialize()
 #define pkey_mm_init(mm)
+#define pkey_mmu_values(total_data, total_execute)
 
 static inline int vma_pkey(struct vm_area_struct *vma)
 {
diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index a0111de..baac435 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -1,9 +1,12 @@
 #ifndef _ASM_PPC64_PKEYS_H
 #define _ASM_PPC64_PKEYS_H
 
+#include <asm/firmware.h>
+
 extern bool pkey_inited;
 extern bool pkey_execute_disable_support;
 extern int pkeys_total; /* total pkeys as per device tree */
+extern int pkey_total_execute; /* total execute pkeys as per device tree */
 extern u32 initial_allocation_mask;/* bits set for reserved keys */
 
 /*
@@ -223,6 +226,24 @@ static inline void pkey_mm_init(struct mm_struct *mm)
 	mm->context.execute_only_pkey = -1;
 }
 
+static inline void pkey_mmu_values(int total_data, int total_execute)
+{
+	/*
+	 * since any pkey can be used for data or execute, we
+	 * will  just  treat all keys as equal and track them
+	 * as one entity.
+	 */
+	pkeys_total = total_data;
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
 extern void thread_pkey_regs_save(struct thread_struct *thread);
 extern void thread_pkey_regs_restore(struct thread_struct *new_thread,
 			struct thread_struct *old_thread);
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
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 21c3b42..c3ed473 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -37,15 +37,24 @@ void __init pkey_initialize(void)
 	 * line will enable it.
 	 */
 	pkey_inited = false;
+	if (pkey_mmu_enabled())
+		pkey_inited = !radix_enabled();
+	if (!pkey_inited)
+		return;
 
 	/*
-	 * disable execute_disable support for now.
-	 * A patch further down will enable it.
+	 * the device tree cannot be relied on for 
+	 * execute_disable support. Hence we depend
+	 * on CPU FTR.
 	 */
-	pkey_execute_disable_support = false;
+	pkey_execute_disable_support = cpu_has_feature(CPU_FTR_PKEY_EXECUTE);
 
-	/* Lets assume 32 keys */
-	pkeys_total = 32;
+	/*
+	 * Lets assume 32 keys if we are not told
+	 * the number of pkeys.
+	 */
+	if (!pkeys_total)
+		pkeys_total = 32;
 
 #ifdef CONFIG_PPC_4K_PAGES
 	/*
-- 
1.7.1
