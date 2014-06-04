Return-Path: <anton@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FD521A0837
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 17:50:51 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anton@au1.ibm.com>;
 Wed, 4 Jun 2014 17:50:51 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6C0A53578047
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 17:50:49 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s547Suqx60555354
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jun 2014 17:28:56 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s547olAG021480
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jun 2014 17:50:48 +1000
Date: Wed, 4 Jun 2014 17:50:47 +1000
From: Anton Blanchard <anton@au1.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH v2 1/2] powerpc: Allow ppc_md platform hook to override
 memory_block_size_bytes
Message-ID: <20140604175047.35b116b3@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pseries platform code unconditionally overrides
memory_block_size_bytes regardless of the running platform.

Create a ppc_md hook that so each platform can choose to
do what it wants.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/machdep.h              |  3 +++
 arch/powerpc/kernel/setup_64.c                  | 10 ++++++++++
 arch/powerpc/platforms/pseries/hotplug-memory.c | 17 +++--------------
 arch/powerpc/platforms/pseries/pseries.h        |  2 ++
 arch/powerpc/platforms/pseries/setup.c          |  3 +++
 5 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 374abc2..f92b0b5 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -98,6 +98,9 @@ struct machdep_calls {
 	void		(*iommu_save)(void);
 	void		(*iommu_restore)(void);
 #endif
+#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
+	unsigned long	(*memory_block_size)(void);
+#endif
 #endif /* CONFIG_PPC64 */
 
 	void		(*pci_dma_dev_setup)(struct pci_dev *dev);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 90b532a..ee082d7 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -36,6 +36,7 @@
 #include <linux/lockdep.h>
 #include <linux/memblock.h>
 #include <linux/hugetlb.h>
+#include <linux/memory.h>
 
 #include <asm/io.h>
 #include <asm/kdump.h>
@@ -780,6 +781,15 @@ void __init setup_per_cpu_areas(void)
 }
 #endif
 
+#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
+unsigned long memory_block_size_bytes(void)
+{
+	if (ppc_md.memory_block_size)
+		return ppc_md.memory_block_size();
+
+	return MIN_MEMORY_BLOCK_SIZE;
+}
+#endif
 
 #if defined(CONFIG_PPC_INDIRECT_PIO) || defined(CONFIG_PPC_INDIRECT_MMIO)
 struct ppc_pci_io ppc_pci_io;
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 7f75c94..7995135 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -21,7 +21,7 @@
 #include <asm/prom.h>
 #include <asm/sparsemem.h>
 
-static unsigned long get_memblock_size(void)
+unsigned long pseries_memory_block_size(void)
 {
 	struct device_node *np;
 	unsigned int memblock_size = MIN_MEMORY_BLOCK_SIZE;
@@ -64,17 +64,6 @@ static unsigned long get_memblock_size(void)
 	return memblock_size;
 }
 
-/* WARNING: This is going to override the generic definition whenever
- * pseries is built-in regardless of what platform is active at boot
- * time. This is fine for now as this is the only "option" and it
- * should work everywhere. If not, we'll have to turn this into a
- * ppc_md. callback
- */
-unsigned long memory_block_size_bytes(void)
-{
-	return get_memblock_size();
-}
-
 #ifdef CONFIG_MEMORY_HOTREMOVE
 static int pseries_remove_memory(u64 start, u64 size)
 {
@@ -105,7 +94,7 @@ static int pseries_remove_memblock(unsigned long base, unsigned int memblock_siz
 	if (!pfn_valid(start_pfn))
 		goto out;
 
-	block_sz = memory_block_size_bytes();
+	block_sz = pseries_memory_block_size();
 	sections_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
 	nid = memory_add_physaddr_to_nid(base);
 
@@ -201,7 +190,7 @@ static int pseries_update_drconf_memory(struct of_prop_reconfig *pr)
 	u32 *p;
 	int i, rc = -EINVAL;
 
-	memblock_size = get_memblock_size();
+	memblock_size = pseries_memory_block_size();
 	if (!memblock_size)
 		return -EINVAL;
 
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 9921953..361add6 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -64,4 +64,6 @@ extern int dlpar_detach_node(struct device_node *);
 struct pci_host_bridge;
 int pseries_root_bridge_prepare(struct pci_host_bridge *bridge);
 
+unsigned long pseries_memory_block_size(void);
+
 #endif /* _PSERIES_PSERIES_H */
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 215c3c2..adc21a0 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -810,4 +810,7 @@ define_machine(pseries) {
 #ifdef CONFIG_KEXEC
 	.machine_kexec          = pSeries_machine_kexec,
 #endif
+#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
+	.memory_block_size	= pseries_memory_block_size,
+#endif
 };
-- 
1.9.1
