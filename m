Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6117B1A045D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 18:49:51 +1100 (AEDT)
Date: Fri, 4 Mar 2016 18:49:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Ebru Akagunduz
 <ebru.akagunduz@gmail.com>
Subject: linux-next: manual merge of the akpm-current tree with the powerpc
 tree
Message-ID: <20160304184950.7aead922@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/huge_memory.c

between commit:

  ff20c2e0acc5 ("mm: Some arch may want to use HPAGE_PMD related values as variables")

from the powerpc tree and commit:

  82fdbe051e29 ("mm: make optimistic check for swapin readahead")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell

diff --cc mm/huge_memory.c
index 43b11a695113,5b38aa24566f..000000000000
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@@ -98,7 -100,8 +100,8 @@@ static DECLARE_WAIT_QUEUE_HEAD(khugepag
   * it would have happened if the vma was large enough during page
   * fault.
   */
 -static unsigned int khugepaged_max_ptes_none __read_mostly = HPAGE_PMD_NR-1;
 -static unsigned int khugepaged_max_ptes_swap __read_mostly = HPAGE_PMD_NR/8;
 +static unsigned int khugepaged_max_ptes_none __read_mostly;
++static unsigned int khugepaged_max_ptes_swap __read_mostly;
  
  static int khugepaged(void *none);
  static int khugepaged_slab_init(void);
@@@ -660,18 -691,6 +691,19 @@@ static int __init hugepage_init(void
  		return -EINVAL;
  	}
  
 +	khugepaged_pages_to_scan = HPAGE_PMD_NR * 8;
 +	khugepaged_max_ptes_none = HPAGE_PMD_NR - 1;
++	khugepaged_max_ptes_swap = HPAGE_PMD_NR / 8;
 +	/*
 +	 * hugepages can't be allocated by the buddy allocator
 +	 */
 +	MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER >= MAX_ORDER);
 +	/*
 +	 * we use page->mapping and page->index in second tail page
 +	 * as list_head: assuming THP order >= 2
 +	 */
 +	MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER < 2);
 +
  	err = hugepage_init_sysfs(&hugepage_kobj);
  	if (err)
  		goto err_sysfs;
