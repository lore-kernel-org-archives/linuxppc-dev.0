Return-Path: <emunson@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6E6AEDEEF7
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 05:18:11 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6SJHd1p019045
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 15:17:39 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6SJHNr9164626
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 13:17:24 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6SJHNNl019838
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 13:17:23 -0600
From: Eric Munson <ebmunson@us.ibm.com>
To: linux-mm@kvack.org
Subject: [PATCH 1/5 V2] Align stack boundaries based on personality
Date: Mon, 28 Jul 2008 12:17:11 -0700
Message-Id: <6061445882ce9574999bf343eeb333be02a1afa6.1216928613.git.ebmunson@us.ibm.com>
In-Reply-To: <cover.1216928613.git.ebmunson@us.ibm.com>
References: <cover.1216928613.git.ebmunson@us.ibm.com>
In-Reply-To: <cover.1216928613.git.ebmunson@us.ibm.com>
References: <cover.1216928613.git.ebmunson@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, libhugetlbfs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Eric Munson <ebmunson@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a personality flag that requests hugetlb pages be used for
a processes stack.  It adds a helper function that chooses the proper ALIGN
macro based on tthe process personality and calls this function from
setup_arg_pages when aligning the stack address.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Eric Munson <ebmunson@us.ibm.com>

---
Based on 2.6.26-rc8-mm1

Changes from V1:
Rebase to 2.6.26-rc8-mm1

 fs/exec.c                   |   15 ++++++++++++++-
 include/linux/hugetlb.h     |    3 +++
 include/linux/personality.h |    3 +++
 3 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index af9b29c..c99ba24 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -49,6 +49,7 @@
 #include <linux/tsacct_kern.h>
 #include <linux/cn_proc.h>
 #include <linux/audit.h>
+#include <linux/hugetlb.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -155,6 +156,18 @@ exit:
 	goto out;
 }
 
+static unsigned long personality_page_align(unsigned long addr)
+{
+	if (current->personality & HUGETLB_STACK)
+#ifdef CONFIG_STACK_GROWSUP
+		return HPAGE_ALIGN(addr);
+#else
+		return addr & HPAGE_MASK;
+#endif
+
+	return PAGE_ALIGN(addr);
+}
+
 #ifdef CONFIG_MMU
 
 static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
@@ -596,7 +609,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	bprm->p = vma->vm_end - stack_shift;
 #else
 	stack_top = arch_align_stack(stack_top);
-	stack_top = PAGE_ALIGN(stack_top);
+	stack_top = personality_page_align(stack_top);
 	stack_shift = vma->vm_end - stack_top;
 
 	bprm->p -= stack_shift;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 9a71d4c..eed37d7 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -95,6 +95,9 @@ static inline unsigned long hugetlb_total_pages(void)
 #ifndef HPAGE_MASK
 #define HPAGE_MASK	PAGE_MASK		/* Keep the compiler happy */
 #define HPAGE_SIZE	PAGE_SIZE
+
+/* to align the pointer to the (next) huge page boundary */
+#define HPAGE_ALIGN(addr)	ALIGN(addr, HPAGE_SIZE)
 #endif
 
 #endif /* !CONFIG_HUGETLB_PAGE */
diff --git a/include/linux/personality.h b/include/linux/personality.h
index a84e9ff..2bb0f95 100644
--- a/include/linux/personality.h
+++ b/include/linux/personality.h
@@ -22,6 +22,9 @@ extern int		__set_personality(unsigned long);
  * These occupy the top three bytes.
  */
 enum {
+	HUGETLB_STACK =		0x0020000,	/* Attempt to use hugetlb pages
+						 * for the process stack
+						 */
 	ADDR_NO_RANDOMIZE = 	0x0040000,	/* disable randomization of VA space */
 	FDPIC_FUNCPTRS =	0x0080000,	/* userspace function ptrs point to descriptors
 						 * (signal handling)
-- 
1.5.6.1
