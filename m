Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgWZw5TvgzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 15:38:00 +1000 (AEST)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 7 Apr 2016 11:07:57 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u375cDnA12059082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2016 11:08:13 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u375bjCv005983
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2016 11:07:53 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: hughd@google.com, kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 akpm@linux-foundation.org, mgorman@techsingularity.net,
 dave.hansen@intel.com, aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH 01/10] mm/mmap: Replace SHM_HUGE_MASK with MAP_HUGE_MASK
 inside mmap_pgoff
Date: Thu,  7 Apr 2016 11:07:35 +0530
Message-Id: <1460007464-26726-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1460007464-26726-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1460007464-26726-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The commit 091d0d55b286 ("shm: fix null pointer deref when userspace
specifies invalid hugepage size") had replaced MAP_HUGE_MASK with
SHM_HUGE_MASK. Though both of them contain the same numeric value of
0x3f, MAP_HUGE_MASK flag sounds more appropriate than the other one
in the context. Hence change it back.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index bd2e1a53..7d730a4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1315,7 +1315,7 @@ SYSCALL_DEFINE6(mmap_pgoff, unsigned long, addr, unsigned long, len,
 		struct user_struct *user = NULL;
 		struct hstate *hs;
 
-		hs = hstate_sizelog((flags >> MAP_HUGE_SHIFT) & SHM_HUGE_MASK);
+		hs = hstate_sizelog((flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
 		if (!hs)
 			return -EINVAL;
 
-- 
2.1.0
