Return-Path: <kas@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id 68C0B2C0499
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2012 23:52:43 +1000 (EST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: linux-mm@kvack.org
Subject: [PATCH v4 2/8] THP: Pass fault address to
 __do_huge_pmd_anonymous_page()
Date: Mon, 20 Aug 2012 16:52:31 +0300
Message-Id: <1345470757-12005-3-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
 Jan Beulich <jbeulich@novell.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>,
 Andi Kleen <ak@linux.intel.com>, Robert Richter <robert.richter@amd.com>,
 x86@kernel.org, Hugh Dickins <hughd@google.com>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Alex Shi <alex.shu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andi Kleen <ak@linux.intel.com>

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/huge_memory.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 70737ec..6f0825b611 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -633,7 +633,8 @@ static inline pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 
 static int __do_huge_pmd_anonymous_page(struct mm_struct *mm,
 					struct vm_area_struct *vma,
-					unsigned long haddr, pmd_t *pmd,
+					unsigned long haddr,
+					unsigned long address, pmd_t *pmd,
 					struct page *page)
 {
 	pgtable_t pgtable;
@@ -720,8 +721,8 @@ int do_huge_pmd_anonymous_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			put_page(page);
 			goto out;
 		}
-		if (unlikely(__do_huge_pmd_anonymous_page(mm, vma, haddr, pmd,
-							  page))) {
+		if (unlikely(__do_huge_pmd_anonymous_page(mm, vma, haddr,
+						address, pmd, page))) {
 			mem_cgroup_uncharge_page(page);
 			put_page(page);
 			goto out;
-- 
1.7.7.6
