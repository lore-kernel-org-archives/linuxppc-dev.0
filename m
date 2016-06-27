Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdRb22lG0zDqpF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:31:10 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 31/38] powerpc/64: Move the boot time info banner to a
 separate function
Date: Mon, 27 Jun 2016 21:29:29 +1000
Message-Id: <1467026976-7974-32-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_64.c | 66 ++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index afb22a6..8c8f440 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -487,6 +487,37 @@ static void __init initialize_cache_info(void)
 	DBG(" <- initialize_cache_info()\n");
 }
 
+static __init void print_system_info(void)
+{
+	pr_info("-----------------------------------------------------\n");
+	pr_info("ppc64_pft_size    = 0x%llx\n", ppc64_pft_size);
+	pr_info("phys_mem_size     = 0x%llx\n", memblock_phys_mem_size());
+
+	if (ppc64_caches.dline_size != 0x80)
+		pr_info("dcache_line_size  = 0x%x\n", ppc64_caches.dline_size);
+	if (ppc64_caches.iline_size != 0x80)
+		pr_info("icache_line_size  = 0x%x\n", ppc64_caches.iline_size);
+
+	pr_info("cpu_features      = 0x%016lx\n", cur_cpu_spec->cpu_features);
+	pr_info("  possible        = 0x%016lx\n", CPU_FTRS_POSSIBLE);
+	pr_info("  always          = 0x%016lx\n", CPU_FTRS_ALWAYS);
+	pr_info("cpu_user_features = 0x%08x 0x%08x\n", cur_cpu_spec->cpu_user_features,
+		cur_cpu_spec->cpu_user_features2);
+	pr_info("mmu_features      = 0x%08x\n", cur_cpu_spec->mmu_features);
+	pr_info("firmware_features = 0x%016lx\n", powerpc_firmware_features);
+
+#ifdef CONFIG_PPC_STD_MMU_64
+	if (htab_address)
+		pr_info("htab_address      = 0x%p\n", htab_address);
+
+	pr_info("htab_hash_mask    = 0x%lx\n", htab_hash_mask);
+#endif
+
+	if (PHYSICAL_START > 0)
+		pr_info("physical_start    = 0x%llx\n",
+		       (unsigned long long)PHYSICAL_START);
+	pr_info("-----------------------------------------------------\n");
+}
 
 /*
  * Do some initial setup of the system.  The parameters are those which 
@@ -554,37 +585,10 @@ void __init setup_system(void)
 	smp_release_cpus();
 #endif
 
-	pr_info("Starting Linux %s %s\n", init_utsname()->machine,
-		 init_utsname()->version);
-
-	pr_info("-----------------------------------------------------\n");
-	pr_info("ppc64_pft_size    = 0x%llx\n", ppc64_pft_size);
-	pr_info("phys_mem_size     = 0x%llx\n", memblock_phys_mem_size());
-
-	if (ppc64_caches.dline_size != 0x80)
-		pr_info("dcache_line_size  = 0x%x\n", ppc64_caches.dline_size);
-	if (ppc64_caches.iline_size != 0x80)
-		pr_info("icache_line_size  = 0x%x\n", ppc64_caches.iline_size);
-
-	pr_info("cpu_features      = 0x%016lx\n", cur_cpu_spec->cpu_features);
-	pr_info("  possible        = 0x%016lx\n", CPU_FTRS_POSSIBLE);
-	pr_info("  always          = 0x%016lx\n", CPU_FTRS_ALWAYS);
-	pr_info("cpu_user_features = 0x%08x 0x%08x\n", cur_cpu_spec->cpu_user_features,
-		cur_cpu_spec->cpu_user_features2);
-	pr_info("mmu_features      = 0x%08x\n", cur_cpu_spec->mmu_features);
-	pr_info("firmware_features = 0x%016lx\n", powerpc_firmware_features);
-
-#ifdef CONFIG_PPC_STD_MMU_64
-	if (htab_address)
-		pr_info("htab_address      = 0x%p\n", htab_address);
-
-	pr_info("htab_hash_mask    = 0x%lx\n", htab_hash_mask);
-#endif
-
-	if (PHYSICAL_START > 0)
-		pr_info("physical_start    = 0x%llx\n",
-		       (unsigned long long)PHYSICAL_START);
-	pr_info("-----------------------------------------------------\n");
+	/* Print various info about the machine that gave been gathered
+	 * so far
+	 */
+	print_system_info();
 
 	DBG(" <- setup_system()\n");
 }
-- 
2.7.4
