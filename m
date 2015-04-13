Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C38591A01A7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 19:56:44 +1000 (AEST)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 13 Apr 2015 10:56:41 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0FA772190066
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 10:56:23 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3D9ub9T58917108
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 09:56:37 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3D9uXdM005084
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 03:56:37 -0600
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
Subject: [RESEND PATCH v3 1/2] mm: Introducing arch_remap hook
Date: Mon, 13 Apr 2015 11:56:27 +0200
Message-Id: <9d827fc618a718830b2c47aa87e8be546914c897.1428916945.git.ldufour@linux.vnet.ibm.com>
In-Reply-To: <cover.1428916945.git.ldufour@linux.vnet.ibm.com>
References: <cover.1428916945.git.ldufour@linux.vnet.ibm.com>
In-Reply-To: <cover.1428916945.git.ldufour@linux.vnet.ibm.com>
References: <cover.1428916945.git.ldufour@linux.vnet.ibm.com>
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

The architectures which need to call this hook should define
__HAVE_ARCH_REMAP in their asm/mmu_context.h and provide the arch_remap
service with the following prototype:
void arch_remap(struct mm_struct *mm,
                unsigned long old_start, unsigned long old_end,
                unsigned long new_start, unsigned long new_end);

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 mm/mremap.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 2dc44b1cb1df..009db5565893 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -25,6 +25,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/mmu_context.h>
 
 #include "internal.h"
 
@@ -286,13 +287,19 @@ static unsigned long move_vma(struct vm_area_struct *vma,
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
+						  old_addr, moved_len, true);
+				return err;
+			}
 		}
+#ifdef __HAVE_ARCH_REMAP
+		arch_remap(mm, old_addr, old_addr+old_len,
+			   new_addr, new_addr+new_len);
+#endif
 	}
 
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
-- 
1.9.1
