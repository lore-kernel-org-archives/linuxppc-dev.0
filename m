Return-Path: <anton@ozlabs.org>
Date: Sun, 14 Oct 2007 14:33:17 -0500
From: Anton Blanchard <anton@samba.org>
To: paulus@samba.org
Subject: [PATCH] Quieten cache information at boot
Message-ID: <20071014193317.GC26693@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


After 6 years the ppc64 kernel still thinks its important to tell me my
cache line size is 0x80 bytes. I think most people who care know that by
now. The rest probably cant even understand the hex output.

Since we might have misconfigured firmware or cpus that have a linesize
that isnt 128 bytes, I still print it out for those cases. If people
would prefer to remove it completely, lets do it.

Also for lpar remove the htab_address printout since its not used.

Anton
ppc64 boot log usability expert

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 008ab68..e413c49 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -426,11 +426,14 @@ void __init setup_system(void)
 	printk("-----------------------------------------------------\n");
 	printk("ppc64_pft_size                = 0x%lx\n", ppc64_pft_size);
 	printk("physicalMemorySize            = 0x%lx\n", lmb_phys_mem_size());
-	printk("ppc64_caches.dcache_line_size = 0x%x\n",
-	       ppc64_caches.dline_size);
-	printk("ppc64_caches.icache_line_size = 0x%x\n",
-	       ppc64_caches.iline_size);
-	printk("htab_address                  = 0x%p\n", htab_address);
+	if (ppc64_caches.dline_size != 0x80)
+		printk("ppc64_caches.dcache_line_size = 0x%x\n",
+		       ppc64_caches.dline_size);
+	if (ppc64_caches.iline_size != 0x80)
+		printk("ppc64_caches.icache_line_size = 0x%x\n",
+		       ppc64_caches.iline_size);
+	if (htab_address)
+		printk("htab_address                  = 0x%p\n", htab_address);
 	printk("htab_hash_mask                = 0x%lx\n", htab_hash_mask);
 #if PHYSICAL_START > 0
 	printk("physical_start                = 0x%x\n", PHYSICAL_START);
