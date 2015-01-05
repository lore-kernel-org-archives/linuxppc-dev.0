Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 35BB81A09D3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jan 2015 21:54:26 +1100 (AEDT)
From: Mel Gorman <mgorman@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 08/10] x86: mm: Restore original pte_special check
Date: Mon,  5 Jan 2015 10:54:09 +0000
Message-Id: <1420455251-13644-9-git-send-email-mgorman@suse.de>
In-Reply-To: <1420455251-13644-1-git-send-email-mgorman@suse.de>
References: <1420455251-13644-1-git-send-email-mgorman@suse.de>
Cc: Rik van Riel <riel@redhat.com>, Hugh Dickins <hughd@google.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 Ingo Molnar <mingo@redhat.com>, Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Sasha Levin <sasha.levin@oracle.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 Mel Gorman <mgorman@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit b38af4721f59 ("x86,mm: fix pte_special versus pte_numa") adjusted
the pte_special check to take into account that a special pte had SPECIAL
and neither PRESENT nor PROTNONE. Now that NUMA hinting PTEs are no
longer modifying _PAGE_PRESENT it should be safe to restore the original
pte_special behaviour.

Signed-off-by: Mel Gorman <mgorman@suse.de>
---
 arch/x86/include/asm/pgtable.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index b9a13e9..4673d6e 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -137,13 +137,7 @@ static inline int pte_exec(pte_t pte)
 
 static inline int pte_special(pte_t pte)
 {
-	/*
-	 * See CONFIG_NUMA_BALANCING pte_numa in include/asm-generic/pgtable.h.
-	 * On x86 we have _PAGE_BIT_NUMA == _PAGE_BIT_GLOBAL+1 ==
-	 * __PAGE_BIT_SOFTW1 == _PAGE_BIT_SPECIAL.
-	 */
-	return (pte_flags(pte) & _PAGE_SPECIAL) &&
-		(pte_flags(pte) & (_PAGE_PRESENT|_PAGE_PROTNONE));
+	return pte_flags(pte) & _PAGE_SPECIAL;
 }
 
 static inline unsigned long pte_pfn(pte_t pte)
-- 
2.1.2
