Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1F6672C0110
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 06:51:12 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 7 May 2013 02:15:48 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C5EF9E0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 02:23:23 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r46Koxi042139768
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 May 2013 02:20:59 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r46Kp5fh031137
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 May 2013 06:51:05 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Fix build errors STRICT_MM_TYPECHECKS
Date: Tue,  7 May 2013 02:21:00 +0530
Message-Id: <1367873460-12638-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pte-hash64-64k.h | 2 +-
 arch/powerpc/kernel/pci-common.c          | 5 ++---
 arch/powerpc/mm/init_64.c                 | 3 ++-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/pte-hash64-64k.h b/arch/powerpc/include/asm/pte-hash64-64k.h
index 7ad8ef1..98e27be 100644
--- a/arch/powerpc/include/asm/pte-hash64-64k.h
+++ b/arch/powerpc/include/asm/pte-hash64-64k.h
@@ -58,7 +58,7 @@
  * generic accessors and iterators here
  */
 #define __real_pte(e,p) 	((real_pte_t) { \
-			(e), ((e) & _PAGE_COMBO) ? \
+			(e), (pte_val(e) & _PAGE_COMBO) ? \
 				(pte_val(*((p) + PTRS_PER_PTE))) : 0 })
 #define __rpte_to_hidx(r,index)	((pte_val((r).pte) & _PAGE_COMBO) ? \
         (((r).hidx >> ((index)<<2)) & 0xf) : ((pte_val((r).pte) >> 12) & 0xf))
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index f325dc9..fd4b917 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -359,7 +359,6 @@ static pgprot_t __pci_mmap_set_pgprot(struct pci_dev *dev, struct resource *rp,
 				      enum pci_mmap_state mmap_state,
 				      int write_combine)
 {
-	unsigned long prot = pgprot_val(protection);
 
 	/* Write combine is always 0 on non-memory space mappings. On
 	 * memory space, if the user didn't pass 1, we check for a
@@ -376,9 +375,9 @@ static pgprot_t __pci_mmap_set_pgprot(struct pci_dev *dev, struct resource *rp,
 
 	/* XXX would be nice to have a way to ask for write-through */
 	if (write_combine)
-		return pgprot_noncached_wc(prot);
+		return pgprot_noncached_wc(protection);
 	else
-		return pgprot_noncached(prot);
+		return pgprot_noncached(protection);
 }
 
 /*
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index c9ec657..d0cd9e4 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -218,7 +218,8 @@ static void __meminit vmemmap_create_mapping(unsigned long start,
 					     unsigned long phys)
 {
 	int  mapped = htab_bolt_mapping(start, start + page_size, phys,
-					PAGE_KERNEL, mmu_vmemmap_psize,
+					pgprot_val(PAGE_KERNEL),
+					mmu_vmemmap_psize,
 					mmu_kernel_ssize);
 	BUG_ON(mapped < 0);
 }
-- 
1.8.1.2
