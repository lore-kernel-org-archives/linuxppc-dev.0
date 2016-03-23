Return-Path: <vaishali.thakkar@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVV5Y5sxpzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 23:59:45 +1100 (AEDT)
From: Vaishali Thakkar <vaishali.thakkar@oracle.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Vaishali Thakkar <vaishali.thakkar@oracle.com>,
 Hillf Danton <hillf.zj@alibaba-inc.com>, Michal Hocko <mhocko@suse.com>,
 Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
 Dominik Dingel <dingel@linux.vnet.ibm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 4/6] powerpc: mm: Use hugetlb_bad_size
Date: Wed, 23 Mar 2016 18:04:27 +0530
Message-Id: <1458736467-15995-1-git-send-email-vaishali.thakkar@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the setup_hugepagesz function to call the routine
hugetlb_bad_size when unsupported hugepage size is found.

Misc:
   - Silent checkpatch.pl's 80 characters and printk warning

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Hillf Danton <hillf.zj@alibaba-inc.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: Dominik Dingel <dingel@linux.vnet.ibm.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
Please note that the patch is tested for x86 only. But as this
is one line change I just changed them. So, it would be good if
the patch can be tested for other architectures before adding
this in to mainline.
Changes since v1:
        - Separate different arch specific changes in different
          patches instead of one
---
 arch/powerpc/mm/hugetlbpage.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 6dd272b..3e5e128 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -772,8 +772,10 @@ static int __init hugepage_setup_sz(char *str)
 
 	size = memparse(str, &str);
 
-	if (add_huge_page_size(size) != 0)
-		printk(KERN_WARNING "Invalid huge page size specified(%llu)\n", size);
+	if (add_huge_page_size(size) != 0) {
+		hugetlb_bad_size();
+		pr_err("Invalid huge page size specified(%llu)\n", size);
+	}
 
 	return 1;
 }
-- 
2.1.4
