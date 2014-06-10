Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A29E91A00CE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 16:46:28 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/perf: Ensure all EBB register state is cleared on
 fork()
Date: Tue, 10 Jun 2014 16:46:21 +1000
Message-Id: <1402382781-17618-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 330a1eb "Core EBB support for 64-bit book3s" I messed up
clear_task_ebb(). It clears some but not all of the task's Event Based
Branch (EBB) registers when we duplicate a task struct.

That allows a child task to observe the EBBHR & EBBRR of its parent,
which it should not be able to do.

Fix it by clearing EBBHR & EBBRR.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org
---
 arch/powerpc/include/asm/switch_to.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 0e83e7d..b5fad8a 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -84,6 +84,8 @@ static inline void clear_task_ebb(struct task_struct *t)
 {
 #ifdef CONFIG_PPC_BOOK3S_64
     /* EBB perf events are not inherited, so clear all EBB state. */
+    t->thread.ebbrr = 0;
+    t->thread.ebbhr = 0;
     t->thread.bescr = 0;
     t->thread.mmcr2 = 0;
     t->thread.mmcr0 = 0;
-- 
1.9.1
