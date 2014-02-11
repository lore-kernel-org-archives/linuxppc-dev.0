Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6A6EB2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 21:35:14 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 11 Feb 2014 16:05:09 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 227B5125805A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 16:07:01 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1BAZ3WE60489746
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 16:05:03 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1BAZ6ow031397
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 16:05:07 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, riel@redhat.com,
 mgorman@suse.de, mpe@ellerman.id.au
Subject: [PATCH 2/3] mm: dirty accountable change only apply to non prot numa
 case
Date: Tue, 11 Feb 2014 16:04:54 +0530
Message-Id: <1392114895-14997-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1392114895-14997-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1392114895-14997-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
