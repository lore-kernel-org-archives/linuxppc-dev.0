Return-Path: <tony@bakeyournoodle.com>
Date: Tue, 5 Jul 2011 14:44:19 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] mm: Fix output of total_ram.
Message-ID: <20110705044419.GA20597@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 32bit platforms that support >= 4GB memory total_ram was truncated.
This creates a confusing printk:
	Top of RAM: 0x100000000, Total RAM: 0x0
Fix that:
	Top of RAM: 0x100000000, Total RAM: 0x100000000

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/mm/mem.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 29d4dde..ac1c3d3 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -249,7 +249,7 @@ static int __init mark_nonram_nosave(void)
  */
 void __init paging_init(void)
 {
-	unsigned long total_ram = memblock_phys_mem_size();
+	unsigned long long total_ram = memblock_phys_mem_size();
 	phys_addr_t top_of_ram = memblock_end_of_DRAM();
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
 
@@ -269,7 +269,7 @@ void __init paging_init(void)
 	kmap_prot = PAGE_KERNEL;
 #endif /* CONFIG_HIGHMEM */
 
-	printk(KERN_DEBUG "Top of RAM: 0x%llx, Total RAM: 0x%lx\n",
+	printk(KERN_DEBUG "Top of RAM: 0x%llx, Total RAM: 0x%llx\n",
 	       (unsigned long long)top_of_ram, total_ram);
 	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
 	       (long int)((top_of_ram - total_ram) >> 20));
-- 
1.7.4.4
