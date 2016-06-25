Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rcDB92xQWzDqlb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jun 2016 21:53:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: <linuxppc-dev@ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix build break in fork.c when THREAD_SIZE < PAGE_SIZE
Date: Sat, 25 Jun 2016 21:53:30 +1000
Message-Id: <1466855610-20657-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit b235beea9e99 ("Clarify naming of thread info/stack allocators")
breaks the build on some powerpc configs, where THREAD_SIZE < PAGE_SIZE:

  kernel/fork.c:235:2: error: implicit declaration of function 'free_thread_stack'
  kernel/fork.c:355:8: error: assignment from incompatible pointer type
    stack = alloc_thread_stack_node(tsk, node);
    ^

Fix it by renaming free_stack() to free_thread_stack(), and updating the
return type of alloc_thread_stack_node().

Fixes: b235beea9e99 ("Clarify naming of thread info/stack allocators")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 kernel/fork.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Hi Linus,

I saw this after I'd sent my latest fixes pull request. So rather than
retracting that pull request etc. I thought I'd just send this directly. I can
put it in a branch on Monday if you prefer.

cheers

diff --git a/kernel/fork.c b/kernel/fork.c
index 37b9439b8c07..4a7ec0c6c88c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -183,13 +183,13 @@ static inline void free_thread_stack(unsigned long *stack)
 # else
 static struct kmem_cache *thread_stack_cache;
 
-static struct thread_info *alloc_thread_stack_node(struct task_struct *tsk,
+static unsigned long *alloc_thread_stack_node(struct task_struct *tsk,
 						  int node)
 {
 	return kmem_cache_alloc_node(thread_stack_cache, THREADINFO_GFP, node);
 }
 
-static void free_stack(unsigned long *stack)
+static void free_thread_stack(unsigned long *stack)
 {
 	kmem_cache_free(thread_stack_cache, stack);
 }
-- 
2.5.0
