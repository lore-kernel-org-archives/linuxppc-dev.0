Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A3B321A01EA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 14:09:06 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv2 01/25] powerpc/mm: Clean up error handling for
 htab_remove_mapping
Date: Tue,  8 Mar 2016 14:08:38 +1100
Message-Id: <1457406542-6210-2-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1457406542-6210-1-git-send-email-david@gibson.dropbear.id.au>
References: <1457406542-6210-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the only error that htab_remove_mapping() can report is -EINVAL,
if removal of bolted HPTEs isn't implemeted for this platform.  We make
a few clean ups to the handling of this:

 * EINVAL isn't really the right code - there's nothing wrong with the
   function's arguments - use ENODEV instead
 * We were also printing a warning message, but that's a decision better
   left up to the callers, so remove it
 * One caller is vmemmap_remove_mapping(), which will just BUG_ON() on
   error, making the warning message redundant, so no change is needed
   there.
 * The other caller is remove_section_mapping().  This is called in the
   memory hot remove path at a point after vmemmap_remove_mapping() so
   if hpte_removebolted isn't implemented, we'd expect to have already
   BUG()ed anyway.  Put a WARN_ON() here, in lieu of a printk() since this
   really shouldn't be happening.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/mm/hash_utils_64.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index ba59d59..9f7d727 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -273,11 +273,8 @@ int htab_remove_mapping(unsigned long vstart, unsigned long vend,
 	shift = mmu_psize_defs[psize].shift;
 	step = 1 << shift;
 
-	if (!ppc_md.hpte_removebolted) {
-		printk(KERN_WARNING "Platform doesn't implement "
-				"hpte_removebolted\n");
-		return -EINVAL;
-	}
+	if (!ppc_md.hpte_removebolted)
+		return -ENODEV;
 
 	for (vaddr = vstart; vaddr < vend; vaddr += step)
 		ppc_md.hpte_removebolted(vaddr, psize, ssize);
@@ -641,8 +638,10 @@ int create_section_mapping(unsigned long start, unsigned long end)
 
 int remove_section_mapping(unsigned long start, unsigned long end)
 {
-	return htab_remove_mapping(start, end, mmu_linear_psize,
-			mmu_kernel_ssize);
+	int rc = htab_remove_mapping(start, end, mmu_linear_psize,
+				     mmu_kernel_ssize);
+	WARN_ON(rc < 0);
+	return rc;
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
-- 
2.5.0
