Return-Path: <anton@ozlabs.org>
Date: Mon, 8 Feb 2010 09:30:12 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Convert mmu context allocator from idr to ida
Message-ID: <20100207223012.GF32246@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We can use the much more lightweight ida allocator since we don't
need the pointer storage idr provides.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/mm/mmu_context_hash64.c
===================================================================
--- powerpc.git.orig/arch/powerpc/mm/mmu_context_hash64.c	2010-02-05 14:57:48.399712677 +1100
+++ powerpc.git/arch/powerpc/mm/mmu_context_hash64.c	2010-02-05 14:57:55.938461799 +1100
@@ -23,7 +23,7 @@
 #include <asm/mmu_context.h>
 
 static DEFINE_SPINLOCK(mmu_context_lock);
-static DEFINE_IDR(mmu_context_idr);
+static DEFINE_IDA(mmu_context_ida);
 
 /*
  * The proto-VSID space has 2^35 - 1 segments available for user mappings.
@@ -39,11 +39,11 @@ int __init_new_context(void)
 	int err;
 
 again:
-	if (!idr_pre_get(&mmu_context_idr, GFP_KERNEL))
+	if (!ida_pre_get(&mmu_context_ida, GFP_KERNEL))
 		return -ENOMEM;
 
 	spin_lock(&mmu_context_lock);
-	err = idr_get_new_above(&mmu_context_idr, NULL, 1, &index);
+	err = ida_get_new_above(&mmu_context_ida, 1, &index);
 	spin_unlock(&mmu_context_lock);
 
 	if (err == -EAGAIN)
@@ -53,7 +53,7 @@ again:
 
 	if (index > MAX_CONTEXT) {
 		spin_lock(&mmu_context_lock);
-		idr_remove(&mmu_context_idr, index);
+		ida_remove(&mmu_context_ida, index);
 		spin_unlock(&mmu_context_lock);
 		return -ENOMEM;
 	}
@@ -85,7 +85,7 @@ int init_new_context(struct task_struct 
 void __destroy_context(int context_id)
 {
 	spin_lock(&mmu_context_lock);
-	idr_remove(&mmu_context_idr, context_id);
+	ida_remove(&mmu_context_ida, context_id);
 	spin_unlock(&mmu_context_lock);
 }
 EXPORT_SYMBOL_GPL(__destroy_context);
