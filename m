Return-Path: <dtcarroll@gmail.com>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 854B0B6FF8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 19 Jun 2011 03:55:53 +1000 (EST)
Received: by pvg18 with SMTP id 18so1964866pvg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jun 2011 10:55:50 -0700 (PDT)
From: Dave Carroll <dtcarroll@gmail.com>
To: Milton Miller <miltonm@bga.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2][v2] powerpc: Move free_initmem to common code
Date: Sat, 18 Jun 2011 11:36:39 -0600
Message-Id: <1308418600-9167-1-git-send-email-dcarroll@astekcorp.com>
In-Reply-To: <1308350584.32158.58.camel@pasglop>
References: <1308350584.32158.58.camel@pasglop>
Cc: Dave Carroll <dcarroll@astekcorp.com>, LPPC <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dave Carroll <dcarroll@astekcorp.com>

The free_initmem function is basically duplicated in mm/init_32,
and init_64, and is moved to the common 32/64-bit mm/mem.c.

All other sections except init were removed in v2.6.15 by
6c45ab992e4299c869fb26427944a8f8ea177024 (powerpc: Remove section
free() and linker script bits), and therefore the bulk of the executed
code is identical.

This patch also removes updating ppc_md.progress to NULL in the powermac
late_initcall.

Suggested-by: Milton Miller <miltonm@bga.com>
Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Dave Carroll <dcarroll@astekcorp.com>
---
 [v2] This is a rebase of the original patch to Linus' current tree
 
 arch/powerpc/mm/init_32.c               |   32 -------------------------------
 arch/powerpc/mm/init_64.c               |   16 ---------------
 arch/powerpc/mm/mem.c                   |   19 ++++++++++++++++++
 arch/powerpc/platforms/powermac/setup.c |    3 --
 4 files changed, 19 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 5de0f25..c77fef5 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -191,38 +191,6 @@ void __init *early_get_page(void)
 		return __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
 }
 
-/* Free up now-unused memory */
-static void free_sec(unsigned long start, unsigned long end, const char *name)
-{
-	unsigned long cnt = 0;
-
-	while (start < end) {
-		ClearPageReserved(virt_to_page(start));
-		init_page_count(virt_to_page(start));
-		free_page(start);
-		cnt++;
-		start += PAGE_SIZE;
- 	}
-	if (cnt) {
-		printk(" %ldk %s", cnt << (PAGE_SHIFT - 10), name);
-		totalram_pages += cnt;
-	}
-}
-
-void free_initmem(void)
-{
-#define FREESEC(TYPE) \
-	free_sec((unsigned long)(&__ ## TYPE ## _begin), \
-		 (unsigned long)(&__ ## TYPE ## _end), \
-		 #TYPE);
-
-	printk ("Freeing unused kernel memory:");
-	FREESEC(init);
- 	printk("\n");
-	ppc_md.progress = NULL;
-#undef FREESEC
-}
-
 #ifdef CONFIG_8xx /* No 8xx specific .c file to put that in ... */
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				phys_addr_t first_memblock_size)
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index f6dbb4c..e94b57f 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -83,22 +83,6 @@ EXPORT_SYMBOL_GPL(memstart_addr);
 phys_addr_t kernstart_addr;
 EXPORT_SYMBOL_GPL(kernstart_addr);
 
-void free_initmem(void)
-{
-	unsigned long addr;
-
-	addr = (unsigned long)__init_begin;
-	for (; addr < (unsigned long)__init_end; addr += PAGE_SIZE) {
-		memset((void *)addr, POISON_FREE_INITMEM, PAGE_SIZE);
-		ClearPageReserved(virt_to_page(addr));
-		init_page_count(virt_to_page(addr));
-		free_page(addr);
-		totalram_pages++;
-	}
-	printk ("Freeing unused kernel memory: %luk freed\n",
-		((unsigned long)__init_end - (unsigned long)__init_begin) >> 10);
-}
-
 static void pgd_ctor(void *addr)
 {
 	memset(addr, 0, PGD_TABLE_SIZE);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 29d4dde..f4e6408 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -382,6 +382,25 @@ void __init mem_init(void)
 	mem_init_done = 1;
 }
 
+void free_initmem(void)
+{
+	unsigned long addr;
+
+	ppc_md.progress = NULL;
+
+	addr = (unsigned long)__init_begin;
+	for (; addr < (unsigned long)__init_end; addr += PAGE_SIZE) {
+		memset((void *)addr, POISON_FREE_INITMEM, PAGE_SIZE);
+		ClearPageReserved(virt_to_page(addr));
+		init_page_count(virt_to_page(addr));
+		free_page(addr);
+		totalram_pages++;
+	}
+	pr_info("Freeing unused kernel memory: %luk freed\n",
+		((unsigned long)__init_end -
+		(unsigned long)__init_begin) >> 10);
+}
+
 #ifdef CONFIG_BLK_DEV_INITRD
 void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index aa45281..a028f08 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -355,9 +355,6 @@ static int initializing = 1;
 static int pmac_late_init(void)
 {
 	initializing = 0;
-	/* this is udbg (which is __init) and we can later use it during
-	 * cpu hotplug (in smp_core99_kick_cpu) */
-	ppc_md.progress = NULL;
 	return 0;
 }
 machine_late_initcall(powermac, pmac_late_init);
-- 
1.7.5
