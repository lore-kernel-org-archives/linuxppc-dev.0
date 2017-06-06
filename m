Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whYQl5VwMzDqKx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 11:05:51 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id x58so12876906qtc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jun 2017 18:05:51 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com
Subject: [RFC PATCH 3/7 v1]powerpc: store and restore the key state across
 context switches.
Date: Mon,  5 Jun 2017 18:05:05 -0700
Message-Id: <1496711109-4968-4-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
References: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/processor.h |  5 +++++
 arch/powerpc/kernel/process.c        | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index a2123f2..1f714df 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -310,6 +310,11 @@ struct thread_struct {
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
index baae104..37d001a 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1096,6 +1096,11 @@ static inline void save_sprs(struct thread_struct *t)
 		t->tar = mfspr(SPRN_TAR);
 	}
 #endif
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	t->amr = mfspr(SPRN_AMR);
+	t->iamr = mfspr(SPRN_IAMR);
+	t->uamor = mfspr(SPRN_UAMOR);
+#endif
 }
 
 static inline void restore_sprs(struct thread_struct *old_thread,
@@ -1131,6 +1136,14 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 			mtspr(SPRN_TAR, new_thread->tar);
 	}
 #endif
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	if (old_thread->amr != new_thread->amr)
+		mtspr(SPRN_AMR, new_thread->amr);
+	if (old_thread->iamr != new_thread->iamr)
+		mtspr(SPRN_IAMR, new_thread->iamr);
+	if (old_thread->uamor != new_thread->uamor)
+		mtspr(SPRN_UAMOR, new_thread->uamor);
+#endif
 }
 
 struct task_struct *__switch_to(struct task_struct *prev,
@@ -1686,6 +1699,11 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	current->thread.tm_texasr = 0;
 	current->thread.tm_tfiar = 0;
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	current->thread.amr   = 0x0ul;
+	current->thread.iamr  = 0x0ul;
+	current->thread.uamor = 0x0ul;
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 }
 EXPORT_SYMBOL(start_thread);
 
-- 
1.8.3.1
