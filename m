Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zN3jg1ZzGzF0nJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 12:52:23 +1100 (AEDT)
Received: by mail-qt0-x244.google.com with SMTP id m59so420052qte.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 17:52:23 -0800 (PST)
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
Subject: [PATCH v10 13/27] powerpc: implementation for
 arch_override_mprotect_pkey()
Date: Thu, 18 Jan 2018 17:50:34 -0800
Message-Id: <1516326648-22775-14-git-send-email-linuxram@us.ibm.com>
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

arch independent code calls arch_override_mprotect_pkey()
to return a pkey that best matches the requested protection.

This patch provides the implementation.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/mmu_context.h |    5 ++++
 arch/powerpc/include/asm/pkeys.h       |   21 +++++++++++++++++-
 arch/powerpc/mm/pkeys.c                |   36 ++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 4d69223..3ba571d 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -198,6 +198,11 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 #define thread_pkey_regs_save(thread)
 #define thread_pkey_regs_restore(new_thread, old_thread)
 #define thread_pkey_regs_init(thread)
+
+static inline int vma_pkey(struct vm_area_struct *vma)
+{
+	return 0;
+}
 #endif /* CONFIG_PPC_MEM_KEYS */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index c7cc433..0a643b8 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -52,6 +52,13 @@ static inline u64 pkey_to_vmflag_bits(u16 pkey)
 	return (((u64)pkey << VM_PKEY_SHIFT) & ARCH_VM_PKEY_FLAGS);
 }
 
+static inline int vma_pkey(struct vm_area_struct *vma)
+{
+	if (static_branch_likely(&pkey_disabled))
+		return 0;
+	return (vma->vm_flags & ARCH_VM_PKEY_FLAGS) >> VM_PKEY_SHIFT;
+}
+
 #define arch_max_pkey() pkeys_total
 
 #define pkey_alloc_mask(pkey) (0x1 << pkey)
@@ -148,10 +155,22 @@ static inline int execute_only_pkey(struct mm_struct *mm)
 	return __execute_only_pkey(mm);
 }
 
+extern int __arch_override_mprotect_pkey(struct vm_area_struct *vma,
+					 int prot, int pkey);
 static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
 					      int prot, int pkey)
 {
-	return 0;
+	if (static_branch_likely(&pkey_disabled))
+		return 0;
+
+	/*
+	 * Is this an mprotect_pkey() call? If so, never override the value that
+	 * came from the user.
+	 */
+	if (pkey != -1)
+		return pkey;
+
+	return __arch_override_mprotect_pkey(vma, prot, pkey);
 }
 
 extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index ee31ab5..7630c2f 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -326,3 +326,39 @@ int __execute_only_pkey(struct mm_struct *mm)
 		mm->context.execute_only_pkey = execute_only_pkey;
 	return execute_only_pkey;
 }
+
+static inline bool vma_is_pkey_exec_only(struct vm_area_struct *vma)
+{
+	/* Do this check first since the vm_flags should be hot */
+	if ((vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC)) != VM_EXEC)
+		return false;
+
+	return (vma_pkey(vma) == vma->vm_mm->context.execute_only_pkey);
+}
+
+/*
+ * This should only be called for *plain* mprotect calls.
+ */
+int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot,
+				  int pkey)
+{
+	/*
+	 * If the currently associated pkey is execute-only, but the requested
+	 * protection requires read or write, move it back to the default pkey.
+	 */
+	if (vma_is_pkey_exec_only(vma) && (prot & (PROT_READ | PROT_WRITE)))
+		return 0;
+
+	/*
+	 * The requested protection is execute-only. Hence let's use an
+	 * execute-only pkey.
+	 */
+	if (prot == PROT_EXEC) {
+		pkey = execute_only_pkey(vma->vm_mm);
+		if (pkey > 0)
+			return pkey;
+	}
+
+	/* Nothing to override. */
+	return vma_pkey(vma);
+}
-- 
1.7.1
