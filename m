Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06BB01A003D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 22:06:53 +1100 (AEDT)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 25 Mar 2015 11:06:50 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id C160E1B08067
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 11:07:13 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2PB6lDq10748278
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 11:06:47 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2PB6hx4021664
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 05:06:47 -0600
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Jeff Dike <jdike@addtoit.com>,
 Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 user-mode-linux-user@lists.sourceforge.net, linux-arch@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v2 1/2] mm: Introducing arch_remap hook
Date: Wed, 25 Mar 2015 12:06:35 +0100
Message-Id: <fe0cafd7f98ce8cdd4b695de55a8c22dd903e334.1427280806.git.ldufour@linux.vnet.ibm.com>
In-Reply-To: <cover.1427280806.git.ldufour@linux.vnet.ibm.com>
References: <cover.1427280806.git.ldufour@linux.vnet.ibm.com>
In-Reply-To: <cover.1427280806.git.ldufour@linux.vnet.ibm.com>
References: <20150323085209.GA28965@gmail.com>
 <cover.1427280806.git.ldufour@linux.vnet.ibm.com>
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
---
 mm/mremap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 57dadc025c64..bafc234db45c 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -25,6 +25,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/mmu_context.h>
 
 #include "internal.h"
 
@@ -286,8 +287,14 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		old_len = new_len;
 		old_addr = new_addr;
 		new_addr = -ENOMEM;
-	} else if (vma->vm_file && vma->vm_file->f_op->mremap)
-		vma->vm_file->f_op->mremap(vma->vm_file, new_vma);
+	} else {
+		if (vma->vm_file && vma->vm_file->f_op->mremap)
+			vma->vm_file->f_op->mremap(vma->vm_file, new_vma);
+#ifdef __HAVE_ARCH_REMAP
+		arch_remap(mm, old_addr, old_addr+old_len,
+			   new_addr, new_addr+new_len);
+#endif
+	}
 
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
 	if (vm_flags & VM_ACCOUNT) {
-- 
1.9.1
