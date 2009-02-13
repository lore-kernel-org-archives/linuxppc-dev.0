Return-Path: <anton@ozlabs.org>
Date: Sat, 14 Feb 2009 08:57:30 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Reduce hashtable size when using 64kB pages
Message-ID: <20090213215730.GF23273@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


At the moment we size the hashtable based on 4kB pages / 2, even on a
64kB kernel. This results in a hashtable that is much larger than it
needs to be.

Grab the real page size and size the hashtable based on that. Note: this
only works on non hypervisor machines.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 8d5b475..f5bc1b2 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -516,7 +516,7 @@ static int __init htab_dt_scan_pftsize(unsigned long node,
 
 static unsigned long __init htab_get_table_size(void)
 {
-	unsigned long mem_size, rnd_mem_size, pteg_count;
+	unsigned long mem_size, rnd_mem_size, pteg_count, psize;
 
 	/* If hash size isn't already provided by the platform, we try to
 	 * retrieve it from the device-tree. If it's not there neither, we
@@ -534,7 +534,8 @@ static unsigned long __init htab_get_table_size(void)
 		rnd_mem_size <<= 1;
 
 	/* # pages / 2 */
-	pteg_count = max(rnd_mem_size >> (12 + 1), 1UL << 11);
+	psize = mmu_psize_defs[mmu_virtual_psize].shift;
+	pteg_count = max(rnd_mem_size >> (psize + 1), 1UL << 11);
 
 	return pteg_count << 7;
 }
