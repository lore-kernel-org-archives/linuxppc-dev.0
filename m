Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	nfont@linux.vnet.ibm.com
Subject: [PATCH 1/2] powerpc: Allow ppc_md platform hook to override
 memory_block_size_bytes
Date: Fri, 25 Apr 2014 21:42:28 +1000
Message-Id: <1398426149-27359-1-git-send-email-anton@samba.org>
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
 arch/powerpc/include/asm/machdep.h              |  1 +
 arch/powerpc/kernel/setup_64.c                  |  8 ++++++++
 arch/powerpc/platforms/pseries/hotplug-memory.c | 17 +++--------------
 arch/powerpc/platforms/pseries/pseries.h        |  2 ++
 arch/powerpc/platforms/pseries/setup.c          |  1 +
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 5b6c03f..1f1c828 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -98,6 +98,7 @@ struct machdep_calls {
 	void		(*iommu_save)(void);
 	void		(*iommu_restore)(void);
 #endif
+	unsigned long	(*memory_block_size)(void);
 #endif /* CONFIG_PPC64 */
 
 	void		(*pci_dma_dev_setup)(struct pci_dev *dev);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index fbe2437..eaeb0e7 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -36,6 +36,7 @@
 #include <linux/lockdep.h>
 #include <linux/memblock.h>
 #include <linux/hugetlb.h>
+#include <linux/memory.h>
 
 #include <asm/io.h>
 #include <asm/kdump.h>
@@ -780,6 +781,13 @@ void __init setup_per_cpu_areas(void)
 }
 #endif
 
+unsigned long memory_block_size_bytes(void)
+{
+	if (ppc_md.memory_block_size)
+		return ppc_md.memory_block_size();
+
+	return MIN_MEMORY_BLOCK_SIZE;
+}
 
 #if defined(CONFIG_PPC_INDIRECT_PIO) || defined(CONFIG_PPC_INDIRECT_MMIO)
 struct ppc_pci_io ppc_pci_io;
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 573b488..b926fbb 100644
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
 		return 0;
 	}
 
-	block_sz = memory_block_size_bytes();
+	block_sz = pseries_memory_block_size();
 	sections_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
 	nid = memory_add_physaddr_to_nid(base);
 
@@ -199,7 +188,7 @@ static int pseries_update_drconf_memory(struct of_prop_reconfig *pr)
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
index 2db8cc6..6e01fba 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -806,4 +806,5 @@ define_machine(pseries) {
 #ifdef CONFIG_KEXEC
 	.machine_kexec          = pSeries_machine_kexec,
 #endif
+	.memory_block_size	= pseries_memory_block_size,
 };
-- 
1.8.3.2
