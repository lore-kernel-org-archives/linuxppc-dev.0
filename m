Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6323DDF9E
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 08:19:31 +1000 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Allow mem=x cmdline to work with 4G+
Date: Fri,  8 May 2009 17:19:27 -0500
Message-Id: <1241821167-13069-1-git-send-email-beckyb@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We're currently choking on mem=4g (and above) due to memory_limit
being specified as an unsigned long. Make memory_limit
phys_addr_t to fix this.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
Ben,

This is a fix for something I missed in the earlier large physical patches.
I've tested it on MPC8641 both with and without PHYS_64BIT; I've build
tested on ppc64_defconfig as well.

Cheers,
B

 arch/powerpc/include/asm/system.h   |    2 +-
 arch/powerpc/kernel/machine_kexec.c |    4 ++--
 arch/powerpc/kernel/prom.c          |    8 ++++----
 arch/powerpc/mm/mem.c               |    2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/system.h b/arch/powerpc/include/asm/system.h
index f612798..2b2420a 100644
--- a/arch/powerpc/include/asm/system.h
+++ b/arch/powerpc/include/asm/system.h
@@ -212,7 +212,7 @@ extern struct task_struct *_switch(struct thread_struct *prev,
 extern unsigned int rtas_data;
 extern int mem_init_done;	/* set on boot once kmalloc can be called */
 extern int init_bootmem_done;	/* set on !NUMA once bootmem is available */
-extern unsigned long memory_limit;
+extern phys_addr_t memory_limit;
 extern unsigned long klimit;
 
 extern void *alloc_maybe_bootmem(size_t size, gfp_t mask);
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index d59e2b1..bb3d893 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -125,8 +125,8 @@ void __init reserve_crashkernel(void)
 	/* Crash kernel trumps memory limit */
 	if (memory_limit && memory_limit <= crashk_res.end) {
 		memory_limit = crashk_res.end + 1;
-		printk("Adjusted memory limit for crashkernel, now 0x%lx\n",
-				memory_limit);
+		printk("Adjusted memory limit for crashkernel, now 0x%llx\n",
+		       (unsigned long long)memory_limit);
 	}
 
 	printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 5ec6a9e..ce01ff2 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -426,7 +426,7 @@ static int __init early_parse_mem(char *p)
 		return 1;
 
 	memory_limit = PAGE_ALIGN(memparse(p, &p));
-	DBG("memory limit = 0x%lx\n", memory_limit);
+	DBG("memory limit = 0x%llx\n", (unsigned long long)memory_limit);
 
 	return 0;
 }
@@ -1160,7 +1160,7 @@ static inline void __init phyp_dump_reserve_mem(void) {}
 
 void __init early_init_devtree(void *params)
 {
-	unsigned long limit;
+	phys_addr_t limit;
 
 	DBG(" -> early_init_devtree(%p)\n", params);
 
@@ -1204,7 +1204,7 @@ void __init early_init_devtree(void *params)
 
 	limit = memory_limit;
 	if (! limit) {
-		unsigned long memsize;
+		phys_addr_t memsize;
 
 		/* Ensure that total memory size is page-aligned, because
 		 * otherwise mark_bootmem() gets upset. */
@@ -1218,7 +1218,7 @@ void __init early_init_devtree(void *params)
 	lmb_analyze();
 	lmb_dump_all();
 
-	DBG("Phys. mem: %lx\n", lmb_phys_mem_size());
+	DBG("Phys. mem: %llx\n", lmb_phys_mem_size());
 
 	/* We may need to relocate the flat tree, do it now.
 	 * FIXME .. and the initrd too? */
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index f668fa9..d0602a7 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -57,7 +57,7 @@
 
 int init_bootmem_done;
 int mem_init_done;
-unsigned long memory_limit;
+phys_addr_t memory_limit;
 
 #ifdef CONFIG_HIGHMEM
 pte_t *kmap_pte;
-- 
1.6.0.6
