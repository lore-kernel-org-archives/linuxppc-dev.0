Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6163C1A021C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Oct 2014 20:21:24 +1100 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc: Add printk levels to setup_system output
Date: Mon, 13 Oct 2014 20:21:22 +1100
Message-Id: <1413192082-2475-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/setup_64.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index cd07d79..4f3cfe1 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -522,36 +522,36 @@ void __init setup_system(void)
 	smp_release_cpus();
 #endif
 
-	printk("Starting Linux PPC64 %s\n", init_utsname()->version);
+	pr_info("Starting Linux PPC64 %s\n", init_utsname()->version);
 
-	printk("-----------------------------------------------------\n");
-	printk("ppc64_pft_size    = 0x%llx\n", ppc64_pft_size);
-	printk("phys_mem_size     = 0x%llx\n", memblock_phys_mem_size());
+	pr_info("-----------------------------------------------------\n");
+	pr_info("ppc64_pft_size    = 0x%llx\n", ppc64_pft_size);
+	pr_info("phys_mem_size     = 0x%llx\n", memblock_phys_mem_size());
 
 	if (ppc64_caches.dline_size != 0x80)
-		printk("dcache_line_size  = 0x%x\n", ppc64_caches.dline_size);
+		pr_info("dcache_line_size  = 0x%x\n", ppc64_caches.dline_size);
 	if (ppc64_caches.iline_size != 0x80)
-		printk("icache_line_size  = 0x%x\n", ppc64_caches.iline_size);
+		pr_info("icache_line_size  = 0x%x\n", ppc64_caches.iline_size);
 
-	printk("cpu_features      = 0x%016lx\n", cur_cpu_spec->cpu_features);
-	printk("  possible        = 0x%016lx\n", CPU_FTRS_POSSIBLE);
-	printk("  always          = 0x%016lx\n", CPU_FTRS_ALWAYS);
-	printk("cpu_user_features = 0x%08x 0x%08x\n", cur_cpu_spec->cpu_user_features,
+	pr_info("cpu_features      = 0x%016lx\n", cur_cpu_spec->cpu_features);
+	pr_info("  possible        = 0x%016lx\n", CPU_FTRS_POSSIBLE);
+	pr_info("  always          = 0x%016lx\n", CPU_FTRS_ALWAYS);
+	pr_info("cpu_user_features = 0x%08x 0x%08x\n", cur_cpu_spec->cpu_user_features,
 		cur_cpu_spec->cpu_user_features2);
-	printk("mmu_features      = 0x%08x\n", cur_cpu_spec->mmu_features);
-	printk("firmware_features = 0x%016lx\n", powerpc_firmware_features);
+	pr_info("mmu_features      = 0x%08x\n", cur_cpu_spec->mmu_features);
+	pr_info("firmware_features = 0x%016lx\n", powerpc_firmware_features);
 
 #ifdef CONFIG_PPC_STD_MMU_64
 	if (htab_address)
-		printk("htab_address      = 0x%p\n", htab_address);
+		pr_info("htab_address      = 0x%p\n", htab_address);
 
-	printk("htab_hash_mask    = 0x%lx\n", htab_hash_mask);
+	pr_info("htab_hash_mask    = 0x%lx\n", htab_hash_mask);
 #endif
 
 	if (PHYSICAL_START > 0)
-		printk("physical_start    = 0x%llx\n",
+		pr_info("physical_start    = 0x%llx\n",
 		       (unsigned long long)PHYSICAL_START);
-	printk("-----------------------------------------------------\n");
+	pr_info("-----------------------------------------------------\n");
 
 	DBG(" <- setup_system()\n");
 }
-- 
1.9.1
