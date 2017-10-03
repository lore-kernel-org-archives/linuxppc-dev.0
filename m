Return-Path: <zi.yan@sent.com>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y61YH2zg5zDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 01:26:10 +1100 (AEDT)
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Zi Yan <zi.yan@cs.rutgers.edu>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] mm: remove unnecessary WARN_ONCE in page_vma_mapped_walk().
Date: Tue,  3 Oct 2017 10:26:06 -0400
Message-Id: <20171003142606.12324-1-zi.yan@sent.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Zi Yan <zi.yan@cs.rutgers.edu>

A non present pmd entry can appear after pmd_lock is taken in
page_vma_mapped_walk(), even if THP migration is not enabled.
The WARN_ONCE is unnecessary.

Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Signed-off-by: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/page_vma_mapped.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 6a03946469a9..eb462e7db0a9 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -167,8 +167,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 						return not_found(pvmw);
 					return true;
 				}
-			} else
-				WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
+			}
 			return not_found(pvmw);
 		} else {
 			/* THP pmd was split under us: handle on pte level */
-- 
2.14.1
