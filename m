Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 399C12C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 16:45:09 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 12:10:36 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4817D1258053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 12:14:01 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5J6jCcK13500472
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 12:15:12 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5J6j1UP024076
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 16:45:02 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc/THP: Wait for all hash_page calls to finish before
 invalidating HPTE entries
Date: Wed, 19 Jun 2013 12:14:54 +0530
Message-Id: <1371624294-19451-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

When we collapse normal pages to hugepage, we first clear the pmd, then invalidate all
the PTE entries. The assumption here is that any low level page fault will see pmd as
none and take the slow path that will wait on mmap_sem. But we could very well be in
a hash_page with local ptep pointer value. Such a hash page can result in adding new
HPTE entries for normal subpages/small page. That means we could be modifying the
page content as we copy them to a huge page. Fix this by waiting on hash_page to finish
after marking the pmd none and bfore invalidating HPTE entries. We use the heavy
kick_all_cpus_sync(). This should be ok as we do this in the background khugepaged
thread and not in application context. But we block page fault handling for this time.
Also if we find collapse slow we can ideally increase the scan rate.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index bbecac4..4bb44c3 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -543,6 +543,14 @@ pmd_t pmdp_clear_flush(struct vm_area_struct *vma, unsigned long address,
 		pmd = *pmdp;
 		pmd_clear(pmdp);
 		/*
+		 * Wait for all pending hash_page to finish
+		 * We can do this by waiting for a context switch to happen on
+		 * the cpus. Any new hash_page after this will see pmd none
+		 * and fallback to code that takes mmap_sem and hence will block
+		 * for collapse to finish.
+		 */
+		kick_all_cpus_sync();
+		/*
 		 * Now invalidate the hpte entries in the range
 		 * covered by pmd. This make sure we take a
 		 * fault and will find the pmd as none, which will
-- 
1.8.1.2
