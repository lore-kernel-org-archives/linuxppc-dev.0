Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 104862C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 02:58:26 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 22 May 2013 22:22:06 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id CF767E0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 22:30:52 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4MGwEqx64159860
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 22:28:14 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4MGwIIj020509
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 02:58:19 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, dwg@au1.ibm.com
Subject: [PATCH -V9 06/20] mm/THP: deposit the transpare huge pgtable before
 set_pmd
Date: Wed, 22 May 2013 22:27:38 +0530
Message-Id: <1369241872-15700-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Architectures like powerpc use the deposited pgtable to store
hash index values. We need to make the deposted pgtable visible
to other cpus before we are ready to take a hash fault.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 mm/huge_memory.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5c4fac2..59d9384 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -729,8 +729,8 @@ static int __do_huge_pmd_anonymous_page(struct mm_struct *mm,
 		pmd_t entry;
 		entry = mk_huge_pmd(page, vma);
 		page_add_new_anon_rmap(page, vma, haddr);
-		set_pmd_at(mm, haddr, pmd, entry);
 		pgtable_trans_huge_deposit(mm, pmd, pgtable);
+		set_pmd_at(mm, haddr, pmd, entry);
 		add_mm_counter(mm, MM_ANONPAGES, HPAGE_PMD_NR);
 		mm->nr_ptes++;
 		spin_unlock(&mm->page_table_lock);
@@ -771,8 +771,8 @@ static bool set_huge_zero_page(pgtable_t pgtable, struct mm_struct *mm,
 	entry = mk_pmd(zero_page, vma->vm_page_prot);
 	entry = pmd_wrprotect(entry);
 	entry = pmd_mkhuge(entry);
-	set_pmd_at(mm, haddr, pmd, entry);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
+	set_pmd_at(mm, haddr, pmd, entry);
 	mm->nr_ptes++;
 	return true;
 }
@@ -916,8 +916,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 	pmdp_set_wrprotect(src_mm, addr, src_pmd);
 	pmd = pmd_mkold(pmd_wrprotect(pmd));
-	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 	dst_mm->nr_ptes++;
 
 	ret = 0;
@@ -2367,9 +2367,9 @@ static void collapse_huge_page(struct mm_struct *mm,
 	spin_lock(&mm->page_table_lock);
 	BUG_ON(!pmd_none(*pmd));
 	page_add_new_anon_rmap(new_page, vma, address);
+	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, address, pmd, _pmd);
 	update_mmu_cache_pmd(vma, address, pmd);
-	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	spin_unlock(&mm->page_table_lock);
 
 	*hpage = NULL;
-- 
1.8.1.2
