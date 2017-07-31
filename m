Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLKfJ28YBzDrCm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 10:12:56 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id i19so16859648qte.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 17:12:56 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, linuxram@us.ibm.com,
 bauerman@linux.vnet.ibm.com, mhocko@kernel.org
Subject: [RFC v7 09/25] powerpc: store and restore the pkey state across
 context switches
Date: Sun, 30 Jul 2017 17:12:10 -0700
Message-Id: <1501459946-11619-10-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Store and restore the AMR, IAMR and UAMOR register state of the task
before scheduling out and after scheduling in, respectively.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h     |    5 +++++
 arch/powerpc/include/asm/processor.h |    5 +++++
 arch/powerpc/kernel/process.c        |   25 +++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 9d59619..dac8751 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -147,6 +147,11 @@ static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	return __arch_set_user_pkey_access(tsk, pkey, init_val);
 }
 
+static inline bool arch_pkeys_enabled(void)
+{
+	return pkey_inited;
+}
+
 static inline void pkey_mm_init(struct mm_struct *mm)
 {
 	if (!pkey_inited)
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 1189d04..dcb1cf0 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -309,6 +309,11 @@ struct thread_struct {
 	struct thread_vr_state ckvr_state; /* Checkpointed VR state */
 	unsigned long	ckvrsave; /* Checkpointed VRSAVE */
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	unsigned long	amr;
+	unsigned long	iamr;
+	unsigned long	uamor;
+#endif
 #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
 	void*		kvm_shadow_vcpu; /* KVM internal data */
 #endif /* CONFIG_KVM_BOOK3S_32_HANDLER */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 2ad725e..af373f4 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -42,6 +42,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/uaccess.h>
 #include <linux/elf-randomize.h>
+#include <linux/pkeys.h>
 
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -1096,6 +1097,13 @@ static inline void save_sprs(struct thread_struct *t)
 		t->tar = mfspr(SPRN_TAR);
 	}
 #endif
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	if (arch_pkeys_enabled()) {
+		t->amr = mfspr(SPRN_AMR);
+		t->iamr = mfspr(SPRN_IAMR);
+		t->uamor = mfspr(SPRN_UAMOR);
+	}
+#endif
 }
 
 static inline void restore_sprs(struct thread_struct *old_thread,
@@ -1131,6 +1139,16 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 			mtspr(SPRN_TAR, new_thread->tar);
 	}
 #endif
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	if (arch_pkeys_enabled()) {
+		if (old_thread->amr != new_thread->amr)
+			mtspr(SPRN_AMR, new_thread->amr);
+		if (old_thread->iamr != new_thread->iamr)
+			mtspr(SPRN_IAMR, new_thread->iamr);
+		if (old_thread->uamor != new_thread->uamor)
+			mtspr(SPRN_UAMOR, new_thread->uamor);
+	}
+#endif
 }
 
 struct task_struct *__switch_to(struct task_struct *prev,
@@ -1689,6 +1707,13 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	current->thread.tm_tfiar = 0;
 	current->thread.load_tm = 0;
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	if (arch_pkeys_enabled()) {
+		current->thread.amr   = 0x0ul;
+		current->thread.iamr  = 0x0ul;
+		current->thread.uamor = 0x0ul;
+	}
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 }
 EXPORT_SYMBOL(start_thread);
 
-- 
1.7.1
