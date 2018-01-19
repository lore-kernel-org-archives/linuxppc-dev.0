Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zN3jQ1sh4zF0mm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 12:52:10 +1100 (AEDT)
Received: by mail-qt0-x243.google.com with SMTP id e2so465055qti.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 17:52:10 -0800 (PST)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Subject: [PATCH v10 10/27] powerpc: store and restore the pkey state across
 context switches
Date: Thu, 18 Jan 2018 17:50:31 -0800
Message-Id: <1516326648-22775-11-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
References: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
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
 arch/powerpc/include/asm/mmu_context.h |    3 ++
 arch/powerpc/include/asm/pkeys.h       |    4 ++
 arch/powerpc/include/asm/processor.h   |    5 +++
 arch/powerpc/kernel/process.c          |    7 ++++
 arch/powerpc/mm/pkeys.c                |   52 +++++++++++++++++++++++++++++++-
 5 files changed, 70 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 7d0f2d0..4d69223 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -195,6 +195,9 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 
 #ifndef CONFIG_PPC_MEM_KEYS
 #define pkey_mm_init(mm)
+#define thread_pkey_regs_save(thread)
+#define thread_pkey_regs_restore(new_thread, old_thread)
+#define thread_pkey_regs_init(thread)
 #endif /* CONFIG_PPC_MEM_KEYS */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 2500a90..3def5af 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -150,4 +150,8 @@ static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 }
 
 extern void pkey_mm_init(struct mm_struct *mm);
+extern void thread_pkey_regs_save(struct thread_struct *thread);
+extern void thread_pkey_regs_restore(struct thread_struct *new_thread,
+				     struct thread_struct *old_thread);
+extern void thread_pkey_regs_init(struct thread_struct *thread);
 #endif /*_ASM_POWERPC_KEYS_H */
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index bdab3b7..01299cd 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -309,6 +309,11 @@ struct thread_struct {
 	struct thread_vr_state ckvr_state; /* Checkpointed VR state */
 	unsigned long	ckvrsave; /* Checkpointed VRSAVE */
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+#ifdef CONFIG_PPC_MEM_KEYS
+	unsigned long	amr;
+	unsigned long	iamr;
+	unsigned long	uamor;
+#endif
 #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
 	void*		kvm_shadow_vcpu; /* KVM internal data */
 #endif /* CONFIG_KVM_BOOK3S_32_HANDLER */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 5acb5a1..6447f80 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -42,6 +42,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/uaccess.h>
 #include <linux/elf-randomize.h>
+#include <linux/pkeys.h>
 
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -1102,6 +1103,8 @@ static inline void save_sprs(struct thread_struct *t)
 		t->tar = mfspr(SPRN_TAR);
 	}
 #endif
+
+	thread_pkey_regs_save(t);
 }
 
 static inline void restore_sprs(struct thread_struct *old_thread,
@@ -1141,6 +1144,8 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 	    old_thread->tidr != new_thread->tidr)
 		mtspr(SPRN_TIDR, new_thread->tidr);
 #endif
+
+	thread_pkey_regs_restore(new_thread, old_thread);
 }
 
 #ifdef CONFIG_PPC_BOOK3S_64
@@ -1865,6 +1870,8 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	current->thread.tm_tfiar = 0;
 	current->thread.load_tm = 0;
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+
+	thread_pkey_regs_init(&current->thread);
 }
 EXPORT_SYMBOL(start_thread);
 
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 39e9814..7dfcf2d 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -16,6 +16,8 @@
 bool pkey_execute_disable_supported;
 int  pkeys_total;		/* Total pkeys as per device tree */
 u32  initial_allocation_mask;	/* Bits set for reserved keys */
+u64  pkey_amr_uamor_mask;	/* Bits in AMR/UMOR not to be touched */
+u64  pkey_iamr_mask;		/* Bits in AMR not to be touched */
 
 #define AMR_BITS_PER_PKEY 2
 #define AMR_RD_BIT 0x1UL
@@ -74,8 +76,16 @@ int pkey_initialize(void)
 	 * programming note.
 	 */
 	initial_allocation_mask = ~0x0;
-	for (i = 2; i < (pkeys_total - os_reserved); i++)
+
+	/* register mask is in BE format */
+	pkey_amr_uamor_mask = ~0x0ul;
+	pkey_iamr_mask = ~0x0ul;
+
+	for (i = 2; i < (pkeys_total - os_reserved); i++) {
 		initial_allocation_mask &= ~(0x1 << i);
+		pkey_amr_uamor_mask &= ~(0x3ul << pkeyshift(i));
+		pkey_iamr_mask &= ~(0x1ul << pkeyshift(i));
+	}
 	return 0;
 }
 
@@ -210,3 +220,43 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	init_amr(pkey, new_amr_bits);
 	return 0;
 }
+
+void thread_pkey_regs_save(struct thread_struct *thread)
+{
+	if (static_branch_likely(&pkey_disabled))
+		return;
+
+	/*
+	 * TODO: Skip saving registers if @thread hasn't used any keys yet.
+	 */
+	thread->amr = read_amr();
+	thread->iamr = read_iamr();
+	thread->uamor = read_uamor();
+}
+
+void thread_pkey_regs_restore(struct thread_struct *new_thread,
+			      struct thread_struct *old_thread)
+{
+	if (static_branch_likely(&pkey_disabled))
+		return;
+
+	/*
+	 * TODO: Just set UAMOR to zero if @new_thread hasn't used any keys yet.
+	 */
+	if (old_thread->amr != new_thread->amr)
+		write_amr(new_thread->amr);
+	if (old_thread->iamr != new_thread->iamr)
+		write_iamr(new_thread->iamr);
+	if (old_thread->uamor != new_thread->uamor)
+		write_uamor(new_thread->uamor);
+}
+
+void thread_pkey_regs_init(struct thread_struct *thread)
+{
+	if (static_branch_likely(&pkey_disabled))
+		return;
+
+	write_amr(read_amr() & pkey_amr_uamor_mask);
+	write_iamr(read_iamr() & pkey_iamr_mask);
+	write_uamor(read_uamor() & pkey_amr_uamor_mask);
+}
-- 
1.7.1
