Return-Path: <scottwood@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DC8F52C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 11:26:55 +1100 (EST)
Received: from mail98-am1 (localhost [127.0.0.1])	by mail98-am1-R.bigfish.com
 (Postfix) with ESMTP id AAD45260150	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 22 Nov 2013 00:26:48 +0000 (UTC)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/booke: Only check for hugetlb in flush if vma != NULL
Date: Thu, 21 Nov 2013 18:26:42 -0600
Message-ID: <1385080002-16462-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

And in flush_hugetlb_page(), don't check whether vma is NULL after
we've already dereferenced it.

This was found by Dan using static analysis as described here:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-November/113161.html

We currently get away with this because the callers that currently pass
NULL for vma seem to be 32-bit-only (e.g. highmem, and
CONFIG_DEBUG_PGALLOC in pgtable_32.c)  Hugetlb is currently 64-bit only,
so we never saw a NULL vma here.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 arch/powerpc/mm/hugetlbpage-book3e.c | 3 +--
 arch/powerpc/mm/tlb_nohash.c         | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage-book3e.c b/arch/powerpc/mm/hugetlbpage-book3e.c
index 3bc7006..74551b5 100644
--- a/arch/powerpc/mm/hugetlbpage-book3e.c
+++ b/arch/powerpc/mm/hugetlbpage-book3e.c
@@ -117,6 +117,5 @@ void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 	struct hstate *hstate = hstate_file(vma->vm_file);
 	unsigned long tsize = huge_page_shift(hstate) - 10;
 
-	__flush_tlb_page(vma ? vma->vm_mm : NULL, vmaddr, tsize, 0);
-
+	__flush_tlb_page(vma->vm_mm, vmaddr, tsize, 0);
 }
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 41cd68d..358d743 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -305,7 +305,7 @@ void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 {
 #ifdef CONFIG_HUGETLB_PAGE
-	if (is_vm_hugetlb_page(vma))
+	if (vma && is_vm_hugetlb_page(vma))
 		flush_hugetlb_page(vma, vmaddr);
 #endif
 
-- 
1.8.1.2
