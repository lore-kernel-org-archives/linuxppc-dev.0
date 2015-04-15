Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6AF1A0B87
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 00:17:12 +1000 (AEST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 15 Apr 2015 15:17:08 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id B83DB1B0806B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 15:17:39 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3FEH5sF49938440
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 14:17:05 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3FEH3ku018205
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 08:17:05 -0600
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Hugh Dickins <hughd@google.com>, Rik van Riel <riel@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Pavel Emelyanov <xemul@parallels.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 2/3] mm: New arch_remap hook
Date: Wed, 15 Apr 2015 16:16:57 +0200
Message-Id: <906bea3fec14227486b155d79bd99e871c0c4b0c.1429104776.git.ldufour@linux.vnet.ibm.com>
In-Reply-To: <cover.1429104776.git.ldufour@linux.vnet.ibm.com>
References: <cover.1429104776.git.ldufour@linux.vnet.ibm.com>
In-Reply-To: <cover.1429104776.git.ldufour@linux.vnet.ibm.com>
References: <20150414123853.a3e61b7fa95b6c634e0fcce0@linux-foundation.org>
 <cover.1429104776.git.ldufour@linux.vnet.ibm.com>
Cc: criu@openvz.org, cov@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some architecture would like to be triggered when a memory area is moved
through the mremap system call.

This patch is introducing a new arch_remap mm hook which is placed in the
path of mremap, and is called before the old area is unmapped (and the
arch_unmap hook is called).

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 include/linux/mm-arch-hooks.h |  9 +++++++++
 mm/mremap.c                   | 17 +++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm-arch-hooks.h b/include/linux/mm-arch-hooks.h
index 63005e367abd..4efc3f56e6df 100644
--- a/include/linux/mm-arch-hooks.h
+++ b/include/linux/mm-arch-hooks.h
@@ -13,4 +13,13 @@
 
 #include <asm/mm-arch-hooks.h>
 
+#ifndef arch_remap
+static inline void arch_remap(struct mm_struct *mm,
+			      unsigned long old_start, unsigned long old_end,
+			      unsigned long new_start, unsigned long new_end)
+{
+}
+#define arch_remap arch_remap
+#endif
+
 #endif /* _LINUX_MM_ARCH_HOOKS_H */
diff --git a/mm/mremap.c b/mm/mremap.c
index 2dc44b1cb1df..7597af900d07 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -22,6 +22,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/sched/sysctl.h>
 #include <linux/uaccess.h>
+#include <linux/mm-arch-hooks.h>
 
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
@@ -286,13 +287,17 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		old_len = new_len;
 		old_addr = new_addr;
 		new_addr = -ENOMEM;
-	} else if (vma->vm_file && vma->vm_file->f_op->mremap) {
-		err = vma->vm_file->f_op->mremap(vma->vm_file, new_vma);
-		if (err < 0) {
-			move_page_tables(new_vma, new_addr, vma, old_addr,
-					 moved_len, true);
-			return err;
+	} else {
+		if (vma->vm_file && vma->vm_file->f_op->mremap) {
+			err = vma->vm_file->f_op->mremap(vma->vm_file, new_vma);
+			if (err < 0) {
+				move_page_tables(new_vma, new_addr, vma,
+						 old_addr, moved_len, true);
+				return err;
+			}
 		}
+		arch_remap(mm, old_addr, old_addr + old_len,
+			   new_addr, new_addr + new_len);
 	}
 
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
-- 
1.9.1
