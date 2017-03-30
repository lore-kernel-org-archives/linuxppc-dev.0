Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv3G06p64zDqLM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 23:04:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v6 07/19] powerpc/mm/hash: Abstract context id allocation for
 KVM
Date: Thu, 30 Mar 2017 23:03:55 +1100
Message-Id: <1490875447-4016-7-git-send-email-mpe@ellerman.id.au>
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

KVM wants to be able to allocate an MMU context id, which it does
currently by calling __init_new_context().

We're about to rework that code, so provide a wrapper for KVM so it
can not worry about the details.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/mmu_context.h |  2 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c  |  2 +-
 arch/powerpc/mm/mmu_context_book3s64.c | 10 ++++++++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index b9e3f0aca261..7d721101ec78 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -51,7 +51,7 @@ static inline void switch_mmu_context(struct mm_struct *prev,
 	return switch_slb(tsk, next);
 }
 
-extern int __init_new_context(void);
+extern int hash__alloc_context_id(void);
 extern void __destroy_context(int context_id);
 static inline void mmu_context_init(void) { }
 #else
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index a587e8f4fd26..b35f44c98d1f 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -390,7 +390,7 @@ int kvmppc_mmu_init(struct kvm_vcpu *vcpu)
 	struct kvmppc_vcpu_book3s *vcpu3s = to_book3s(vcpu);
 	int err;
 
-	err = __init_new_context();
+	err = hash__alloc_context_id();
 	if (err < 0)
 		return -1;
 	vcpu3s->context_id[0] = err;
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 73bf6e14c3aa..650a498b1de9 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -30,7 +30,7 @@
 static DEFINE_SPINLOCK(mmu_context_lock);
 static DEFINE_IDA(mmu_context_ida);
 
-int __init_new_context(void)
+static int __init_new_context(void)
 {
 	int index;
 	int err;
@@ -57,7 +57,13 @@ int __init_new_context(void)
 
 	return index;
 }
-EXPORT_SYMBOL_GPL(__init_new_context);
+
+int hash__alloc_context_id(void)
+{
+	return __init_new_context();
+}
+EXPORT_SYMBOL_GPL(hash__alloc_context_id);
+
 static int radix__init_new_context(struct mm_struct *mm, int index)
 {
 	unsigned long rts_field;
-- 
2.7.4
