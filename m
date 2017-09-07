Return-Path: <laurent.du4@free.fr>
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xp5RJ12D8zDrWN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 02:25:48 +1000 (AEST)
From: Laurent Dufour <laurent.du4@free.fr>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/mm: Fix missing mmap_sem release
Date: Thu,  7 Sep 2017 18:25:29 +0200
Message-Id: <1504801529-15113-1-git-send-email-laurent.du4@free.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The commit b5c8f0fd595d ("powerpc/mm: Rework mm_fault_error()") reviewed
the way the error path is managed in __do_page_fault() but it was a bit too
agressive when handling a case by returning without releasing the mmap_sem.

By the way, replacing current->mm->mmap_sem by mm->mmap_sem as mm is set to
current->mm.

Fixes: b5c8f0fd595d ("powerpc/mm: Rework mm_fault_error()")
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Laurent Dufour <laurent.du4@free.fr>
---
 arch/powerpc/mm/fault.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 4797d08581ce..f799ccf37d27 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -521,10 +521,11 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		 * User mode? Just return to handle the fatal exception otherwise
 		 * return to bad_page_fault
 		 */
+		up_read(&mm->mmap_sem);
 		return is_user ? 0 : SIGBUS;
 	}
 
-	up_read(&current->mm->mmap_sem);
+	up_read(&mm->mmap_sem);
 
 	if (unlikely(fault & VM_FAULT_ERROR))
 		return mm_fault_error(regs, address, fault);
-- 
2.7.4
