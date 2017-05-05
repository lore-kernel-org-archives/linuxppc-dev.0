Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wKJBb27NPzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 May 2017 03:03:35 +1000 (AEST)
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net
Subject: [v3 7/9] x86: teach x86 not to zero struct pages memory
Date: Fri,  5 May 2017 13:03:14 -0400
Message-Id: <1494003796-748672-8-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
References: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we are using deferred struct page initialization feature, most of
"struct page"es are getting initialized after other CPUs are started, and
hence we are benefiting from doing this job in parallel. However, we are
still zeroing all the memory that is allocated for "struct pages" using the
boot CPU.  This patch solves this problem, by deferring zeroing "struct
pages" to only when they are initialized on x86 platforms.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/x86/mm/init_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 839e5d4..332a21e 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1276,7 +1276,7 @@ static int __meminit vmemmap_populate_hugepages(unsigned long start,
 			void *p;
 
 			p = __vmemmap_alloc_block_buf(PMD_SIZE, node, altmap,
-						      true);
+						      VMEMMAP_ZERO);
 			if (p) {
 				pte_t entry;
 
-- 
1.7.1
