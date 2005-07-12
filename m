Return-Path: <gautran@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id 8A31667B9A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jul 2005 00:22:29 +1000 (EST)
Message-ID: <42D3D277.106@mrv.com>
Date: Tue, 12 Jul 2005 10:23:51 -0400
From: Guillaume Autran <gautran@mrv.com>
MIME-Version: 1.0
To: akpm@osdl.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: fix destroy_context() race condition
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fix for a race condition when a task gets preempted by another task
while executing the destroy_context(...) in a FEW_CONTEXTS environment.
mm->context == NO_CONTEXT but the context_map may indicate all contexts
are in use.
The solution to this problem is to disable kernel preemption while
destroying a MMU context.

Signed-off-by: Guillaume Autran <gautran@mrv.com>

---

diff -Nru a/include/asm-ppc/mmu_context.h b/include/asm-ppc/mmu_context.h
--- a/include/asm-ppc/mmu_context.h	2005-06-17 15:48:29.000000000 -0400
+++ b/include/asm-ppc/mmu_context.h	2005-07-05 08:58:46.000000000 -0400
@@ -149,6 +149,7 @@
 */
static inline void destroy_context(struct mm_struct *mm)
{
+	preempt_disable();
	if (mm->context != NO_CONTEXT) {
		clear_bit(mm->context, context_map);
		mm->context = NO_CONTEXT;
@@ -156,6 +157,7 @@
		atomic_inc(&nr_free_contexts);
#endif
	}
+	preempt_enable();
}

static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
