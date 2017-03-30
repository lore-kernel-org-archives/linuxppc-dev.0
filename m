Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv3G13c8pzDqLT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 23:04:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v6 08/19] powerpc/mm/hash: Pull hash constants into
 hash__alloc_context_id()
Date: Thu, 30 Mar 2017 23:03:56 +1100
Message-Id: <1490875447-4016-8-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
References: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The min and max context id values used in alloc_context_id() are
currently the right values for use on hash, and happen to also be safe
for use on radix.

But we need to change that in a subsequent patch, so make the min/max
ids parameters and pull the hash values into hsah__alloc_context_id().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/mmu_context_book3s64.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 650a498b1de9..981c3b02e46a 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -30,17 +30,16 @@
 static DEFINE_SPINLOCK(mmu_context_lock);
 static DEFINE_IDA(mmu_context_ida);
 
-static int __init_new_context(void)
+static int alloc_context_id(int min_id, int max_id)
 {
-	int index;
-	int err;
+	int index, err;
 
 again:
 	if (!ida_pre_get(&mmu_context_ida, GFP_KERNEL))
 		return -ENOMEM;
 
 	spin_lock(&mmu_context_lock);
-	err = ida_get_new_above(&mmu_context_ida, 1, &index);
+	err = ida_get_new_above(&mmu_context_ida, min_id, &index);
 	spin_unlock(&mmu_context_lock);
 
 	if (err == -EAGAIN)
@@ -48,7 +47,7 @@ static int __init_new_context(void)
 	else if (err)
 		return err;
 
-	if (index > MAX_USER_CONTEXT) {
+	if (index > max_id) {
 		spin_lock(&mmu_context_lock);
 		ida_remove(&mmu_context_ida, index);
 		spin_unlock(&mmu_context_lock);
@@ -60,7 +59,7 @@ static int __init_new_context(void)
 
 int hash__alloc_context_id(void)
 {
-	return __init_new_context();
+	return alloc_context_id(1, MAX_USER_CONTEXT);
 }
 EXPORT_SYMBOL_GPL(hash__alloc_context_id);
 
@@ -80,7 +79,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 	int index;
 
-	index = __init_new_context();
+	index = hash__alloc_context_id();
 	if (index < 0)
 		return index;
 
-- 
2.7.4
