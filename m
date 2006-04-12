Return-Path: <olof@lixom.net>
Date: Wed, 12 Apr 2006 15:25:01 -0500
To: paulus@ozlabs.org
Subject: [6/10]: Less verbose mem configuration output
Message-ID: <20060412202501.GM19464@pb15.lixom.net>
References: <20060412201823.GG19464@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060412201823.GG19464@pb15.lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Quieten some of the debug ram config output. we already print out available
memory at KERN_INFO level.


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: 2.6/arch/powerpc/mm/mem.c
===================================================================
--- 2.6.orig/arch/powerpc/mm/mem.c
+++ 2.6/arch/powerpc/mm/mem.c
@@ -299,9 +299,9 @@ void __init paging_init(void)
 	kmap_prot = PAGE_KERNEL;
 #endif /* CONFIG_HIGHMEM */
 
-	printk(KERN_INFO "Top of RAM: 0x%lx, Total RAM: 0x%lx\n",
+	printk(KERN_DEBUG "Top of RAM: 0x%lx, Total RAM: 0x%lx\n",
 	       top_of_ram, total_ram);
-	printk(KERN_INFO "Memory hole size: %ldMB\n",
+	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
 	       (top_of_ram - total_ram) >> 20);
 	/*
 	 * All pages are DMA-able so we put them all in the DMA zone.
@@ -380,7 +380,7 @@ void __init mem_init(void)
 			totalhigh_pages++;
 		}
 		totalram_pages += totalhigh_pages;
-		printk(KERN_INFO "High memory: %luk\n",
+		printk(KERN_DEBUG "High memory: %luk\n",
 		       totalhigh_pages << (PAGE_SHIFT-10));
 	}
 #endif /* CONFIG_HIGHMEM */
Index: 2.6/arch/powerpc/mm/numa.c
===================================================================
--- 2.6.orig/arch/powerpc/mm/numa.c
+++ 2.6/arch/powerpc/mm/numa.c
@@ -465,9 +465,9 @@ static void __init setup_nonnuma(void)
 	unsigned long total_ram = lmb_phys_mem_size();
 	unsigned int i;
 
-	printk(KERN_INFO "Top of RAM: 0x%lx, Total RAM: 0x%lx\n",
+	printk(KERN_DEBUG "Top of RAM: 0x%lx, Total RAM: 0x%lx\n",
 	       top_of_ram, total_ram);
-	printk(KERN_INFO "Memory hole size: %ldMB\n",
+	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
 	       (top_of_ram - total_ram) >> 20);
 
 	for (i = 0; i < lmb.memory.cnt; ++i)
@@ -485,7 +485,7 @@ void __init dump_numa_cpu_topology(void)
 		return;
 
 	for_each_online_node(node) {
-		printk(KERN_INFO "Node %d CPUs:", node);
+		printk(KERN_DEBUG "Node %d CPUs:", node);
 
 		count = 0;
 		/*
@@ -521,7 +521,7 @@ static void __init dump_numa_memory_topo
 	for_each_online_node(node) {
 		unsigned long i;
 
-		printk(KERN_INFO "Node %d Memory:", node);
+		printk(KERN_DEBUG "Node %d Memory:", node);
 
 		count = 0;
 
