Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8025A1A011E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 14:09:06 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv2 02/25] powerpc/mm: Handle removing maybe-present bolted HPTEs
Date: Tue,  8 Mar 2016 14:08:39 +1100
Message-Id: <1457406542-6210-3-git-send-email-david@gibson.dropbear.id.au>
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

At the moment the hpte_removebolted callback in ppc_md returns void and
will BUG_ON() if the hpte it's asked to remove doesn't exist in the first
place.  This is awkward for the case of cleaning up a mapping which was
partially made before failing.

So, we add a return value to hpte_removebolted, and have it return ENOENT
in the case that the HPTE to remove didn't exist in the first place.

In the (sole) caller, we propagate errors in hpte_removebolted to its
caller to handle.  However, we handle ENOENT specially, continuing to
complete the unmapping over the specified range before returning the error
to the caller.

This means that htab_remove_mapping() will work sanely on a partially
present mapping, removing any HPTEs which are present, while also returning
ENOENT to its caller in case it's important there.

There are two callers of htab_remove_mapping():
   - In remove_section_mapping() we already WARN_ON() any error return,
     which is reasonable - in this case the mapping should be fully
     present
   - In vmemmap_remove_mapping() we BUG_ON() any error.  We change that to
     just a WARN_ON() in the case of ENOENT, since failing to remove a
     mapping that wasn't there in the first place probably shouldn't be
     fatal.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/machdep.h    |  2 +-
 arch/powerpc/mm/hash_utils_64.c       | 15 ++++++++++++---
 arch/powerpc/mm/init_64.c             |  9 +++++----
 arch/powerpc/platforms/pseries/lpar.c |  9 ++++++---
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 3f191f5..fa25643 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -54,7 +54,7 @@ struct machdep_calls {
 				       int psize, int apsize,
 				       int ssize);
 	long		(*hpte_remove)(unsigned long hpte_group);
-	void            (*hpte_removebolted)(unsigned long ea,
+	int             (*hpte_removebolted)(unsigned long ea,
 					     int psize, int ssize);
 	void		(*flush_hash_range)(unsigned long number, int local);
 	void		(*hugepage_invalidate)(unsigned long vsid,
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 9f7d727..99fbee0 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -269,6 +269,8 @@ int htab_remove_mapping(unsigned long vstart, unsigned long vend,
 {
 	unsigned long vaddr;
 	unsigned int step, shift;
+	int rc;
+	int ret = 0;
 
 	shift = mmu_psize_defs[psize].shift;
 	step = 1 << shift;
@@ -276,10 +278,17 @@ int htab_remove_mapping(unsigned long vstart, unsigned long vend,
 	if (!ppc_md.hpte_removebolted)
 		return -ENODEV;
 
-	for (vaddr = vstart; vaddr < vend; vaddr += step)
-		ppc_md.hpte_removebolted(vaddr, psize, ssize);
+	for (vaddr = vstart; vaddr < vend; vaddr += step) {
+		rc = ppc_md.hpte_removebolted(vaddr, psize, ssize);
+		if (rc == -ENOENT) {
+			ret = -ENOENT;
+			continue;
+		}
+		if (rc < 0)
+			return rc;
+	}
 
-	return 0;
+	return ret;
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 379a6a9..baa1a23 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -232,10 +232,11 @@ static void __meminit vmemmap_create_mapping(unsigned long start,
 static void vmemmap_remove_mapping(unsigned long start,
 				   unsigned long page_size)
 {
-	int mapped = htab_remove_mapping(start, start + page_size,
-					 mmu_vmemmap_psize,
-					 mmu_kernel_ssize);
-	BUG_ON(mapped < 0);
+	int rc = htab_remove_mapping(start, start + page_size,
+				     mmu_vmemmap_psize,
+				     mmu_kernel_ssize);
+	BUG_ON((rc < 0) && (rc != -ENOENT));
+	WARN_ON(rc == -ENOENT);
 }
 #endif
 
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 477290a..2415a0d 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -505,8 +505,8 @@ static void pSeries_lpar_hugepage_invalidate(unsigned long vsid,
 }
 #endif
 
-static void pSeries_lpar_hpte_removebolted(unsigned long ea,
-					   int psize, int ssize)
+static int pSeries_lpar_hpte_removebolted(unsigned long ea,
+					  int psize, int ssize)
 {
 	unsigned long vpn;
 	unsigned long slot, vsid;
@@ -515,11 +515,14 @@ static void pSeries_lpar_hpte_removebolted(unsigned long ea,
 	vpn = hpt_vpn(ea, vsid, ssize);
 
 	slot = pSeries_lpar_hpte_find(vpn, psize, ssize);
-	BUG_ON(slot == -1);
+	if (slot == -1)
+		return -ENOENT;
+
 	/*
 	 * lpar doesn't use the passed actual page size
 	 */
 	pSeries_lpar_hpte_invalidate(slot, vpn, psize, 0, ssize, 0);
+	return 0;
 }
 
 /*
-- 
2.5.0
