Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 54E232C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 14:43:55 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 12 Feb 2014 09:13:52 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 19BE03940060
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 09:13:51 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1C3hqHu52232436
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 09:13:52 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1C3hn4a020078
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 09:13:50 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, riel@redhat.com,
 mgorman@suse.de, mpe@ellerman.id.au
Subject: [PATCH V2 2/3] mm: dirty accountable change only apply to non prot
 numa case
Date: Wed, 12 Feb 2014 09:13:37 +0530
Message-Id: <1392176618-23667-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1392176618-23667-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1392176618-23667-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
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

So move it within the if loop

Acked-by: Mel Gorman <mgorman@suse.de>
Reviewed-by: Rik van Riel <riel@redhat.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 mm/mprotect.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 7332c1785744..33eab902f10e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -58,6 +58,13 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				if (pte_numa(ptent))
 					ptent = pte_mknonnuma(ptent);
 				ptent = pte_modify(ptent, newprot);
+				/*
+				 * Avoid taking write faults for pages we
+				 * know to be dirty.
+				 */
+				if (dirty_accountable && pte_dirty(ptent))
+					ptent = pte_mkwrite(ptent);
+				ptep_modify_prot_commit(mm, addr, pte, ptent);
 				updated = true;
 			} else {
 				struct page *page;
@@ -72,22 +79,8 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 					}
 				}
 			}
-
-			/*
-			 * Avoid taking write faults for pages we know to be
-			 * dirty.
-			 */
-			if (dirty_accountable && pte_dirty(ptent)) {
-				ptent = pte_mkwrite(ptent);
-				updated = true;
-			}
-
 			if (updated)
 				pages++;
-
-			/* Only !prot_numa always clears the pte */
-			if (!prot_numa)
-				ptep_modify_prot_commit(mm, addr, pte, ptent);
 		} else if (IS_ENABLED(CONFIG_MIGRATION) && !pte_file(oldpte)) {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
 
-- 
1.8.3.2
