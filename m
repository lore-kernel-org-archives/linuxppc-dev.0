Return-Path: <minchan@kernel.org>
Received: from lgeamrelo04.lge.com (lgeamrelo04.lge.com [156.147.1.127])
 by lists.ozlabs.org (Postfix) with ESMTP id 0830C1A0044
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Sep 2014 17:19:39 +1000 (EST)
From: Minchan Kim <minchan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v16 4/7] powerpc: add pmd_[dirty|mkclean] for THP
Date: Mon,  1 Sep 2014 16:20:45 +0900
Message-Id: <1409556048-5045-5-git-send-email-minchan@kernel.org>
In-Reply-To: <1409556048-5045-1-git-send-email-minchan@kernel.org>
References: <1409556048-5045-1-git-send-email-minchan@kernel.org>
Cc: Jason Evans <je@fb.com>, Rik van Riel <riel@redhat.com>,
 Minchan Kim <minchan@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linux-api@vger.kernel.org, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, zhangyanfei@cn.fujitsu.com,
 Michael Kerrisk <mtk.manpages@gmail.com>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Mel Gorman <mgorman@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MADV_FREE needs pmd_dirty and pmd_mkclean for detecting recent
overwrite of the contents since MADV_FREE syscall is called for
THP page.

This patch adds pmd_dirty and pmd_mkclean for THP page MADV_FREE
support.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 arch/powerpc/include/asm/pgtable-ppc64.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 7b3d54fae46f..fb89d8eb96c8 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -468,9 +468,11 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
 
 #define pmd_pfn(pmd)		pte_pfn(pmd_pte(pmd))
 #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
+#define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
 #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
 #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
+#define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
 #define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
 
-- 
2.0.0
