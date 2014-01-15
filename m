Return-Path: <jmarchan@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 6755D2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 02:28:32 +1100 (EST)
From: Jerome Marchand <jmarchan@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: mm: fix mmap errno when MAP_FIXED is set and mapping
 exceeds the allowed address space
Date: Wed, 15 Jan 2014 16:27:11 +0100
Message-Id: <1389799631-3418-1-git-send-email-jmarchan@redhat.com>
Cc: Jerome Marchand <jmarchan@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

According to Posix, if MAP_FIXED is specified mmap shall set ENOMEM if
the requested mapping exceeds the allowed range for address space of
the process. The generic code set it right, but the specific powerpc
slice_get_unmapped_area() function currently returns -EINVAL in that
case.
This patch corrects it.

Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
---
 arch/powerpc/mm/slice.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 7ce9cf3..b0c75cc 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -408,7 +408,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	if (fixed && (addr & ((1ul << pshift) - 1)))
 		return -EINVAL;
 	if (fixed && addr > (mm->task_size - len))
-		return -EINVAL;
+		return -ENOMEM;
 
 	/* If hint, make sure it matches our alignment restrictions */
 	if (!fixed && addr) {
-- 
1.7.7.6
