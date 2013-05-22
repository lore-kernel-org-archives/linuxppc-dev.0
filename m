Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 12DBB2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 02:58:26 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 22 May 2013 22:22:07 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 069BBE004F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 22:30:52 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4MGwD3K8651124
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 22:28:13 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4MGwGO2020415
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 02:58:17 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, dwg@au1.ibm.com
Subject: [PATCH -V9 02/20] mm/THP: Use the right function when updating access
 flags
Date: Wed, 22 May 2013 22:27:34 +0530
Message-Id: <1369241872-15700-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1369241872-15700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1369241872-15700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We should use pmdp_set_access_flags to update access flags. Archs like powerpc
use extra checks(_PAGE_BUSY) when updating a hugepage PTE. A set_pmd_at doesn't
do those checks. We should use set_pmd_at only when updating a none hugepage PTE.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 mm/huge_memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 362c329..dab90fd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1265,7 +1265,9 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 		 * young bit, instead of the current set_pmd_at.
 		 */
 		_pmd = pmd_mkyoung(pmd_mkdirty(*pmd));
-		set_pmd_at(mm, addr & HPAGE_PMD_MASK, pmd, _pmd);
+		if (pmdp_set_access_flags(vma, addr & HPAGE_PMD_MASK,
+					  pmd, _pmd,  1))
+			update_mmu_cache_pmd(vma, addr, pmd);
 	}
 	if ((flags & FOLL_MLOCK) && (vma->vm_flags & VM_LOCKED)) {
 		if (page->mapping && trylock_page(page)) {
-- 
1.8.1.2
