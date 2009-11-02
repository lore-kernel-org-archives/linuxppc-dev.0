Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6EAAB1007FD
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 09:02:42 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm@vger.kernel.org
Subject: [PATCH 20/28] Split init_new_context and destroy_context
Date: Mon,  2 Nov 2009 23:02:30 +0100
Message-Id: <1257199351-2238-2-git-send-email-agraf@suse.de>
In-Reply-To: <1257199351-2238-1-git-send-email-agraf@suse.de>
References: <1257199351-2238-1-git-send-email-agraf@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, bphilips@suse.de,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For KVM we need to allocate a new context id, but don't really care about
all the mm context around it.

So let's split the alloc and destroy functions for the context id, so we can
grab one without allocating an mm context.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v6 -> v7:

  - don't #ifdef twice
---
 arch/powerpc/include/asm/mmu_context.h |    2 ++
 arch/powerpc/mm/mmu_context_hash64.c   |   24 +++++++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index b34e94d..26383e0 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -23,6 +23,8 @@ extern void switch_slb(struct task_struct *tsk, struct mm_struct *mm);
 extern void set_context(unsigned long id, pgd_t *pgd);
 
 #ifdef CONFIG_PPC_BOOK3S_64
+extern int __init_new_context(void);
+extern void __destroy_context(int context_id);
 static inline void mmu_context_init(void) { }
 #else
 extern void mmu_context_init(void);
diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
index dbeb86a..b9e4cc2 100644
--- a/arch/powerpc/mm/mmu_context_hash64.c
+++ b/arch/powerpc/mm/mmu_context_hash64.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/spinlock.h>
 #include <linux/idr.h>
+#include <linux/module.h>
 
 #include <asm/mmu_context.h>
 
@@ -32,7 +33,7 @@ static DEFINE_IDR(mmu_context_idr);
 #define NO_CONTEXT	0
 #define MAX_CONTEXT	((1UL << 19) - 1)
 
-int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+int __init_new_context(void)
 {
 	int index;
 	int err;
@@ -57,6 +58,18 @@ again:
 		return -ENOMEM;
 	}
 
+	return index;
+}
+EXPORT_SYMBOL_GPL(__init_new_context);
+
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	int index;
+
+	index = __init_new_context();
+	if (index < 0)
+		return index;
+
 	/* The old code would re-promote on fork, we don't do that
 	 * when using slices as it could cause problem promoting slices
 	 * that have been forced down to 4K
@@ -68,11 +81,16 @@ again:
 	return 0;
 }
 
-void destroy_context(struct mm_struct *mm)
+void __destroy_context(int context_id)
 {
 	spin_lock(&mmu_context_lock);
-	idr_remove(&mmu_context_idr, mm->context.id);
+	idr_remove(&mmu_context_idr, context_id);
 	spin_unlock(&mmu_context_lock);
+}
+EXPORT_SYMBOL_GPL(__destroy_context);
 
+void destroy_context(struct mm_struct *mm)
+{
+	__destroy_context(mm->context.id);
 	mm->context.id = NO_CONTEXT;
 }
-- 
1.6.0.2
