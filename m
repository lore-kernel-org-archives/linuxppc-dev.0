Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLKfd50YyzDr4T
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 10:13:13 +1000 (AEST)
Received: by mail-qk0-x241.google.com with SMTP id q66so25292078qki.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 17:13:13 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, linuxram@us.ibm.com,
 bauerman@linux.vnet.ibm.com, mhocko@kernel.org
Subject: [RFC v7 19/25] powerpc: implementation for arch_vma_access_permitted()
Date: Sun, 30 Jul 2017 17:12:20 -0700
Message-Id: <1501459946-11619-20-git-send-email-linuxram@us.ibm.com>
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

This patch provides the implementation for
arch_vma_access_permitted(). Returns true if the
requested access is allowed by pkey associated with the
vma.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/mmu_context.h |    5 +++-
 arch/powerpc/mm/pkeys.c                |   43 ++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 2eb7f80..a1cfcca 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -175,6 +175,10 @@ static inline void arch_bprm_mm_init(struct mm_struct *mm,
 {
 }
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+bool arch_vma_access_permitted(struct vm_area_struct *vma,
+			bool write, bool execute, bool foreign);
+#else /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 		bool write, bool execute, bool foreign)
 {
@@ -182,7 +186,6 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 	return true;
 }
 
-#ifndef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
 #define pkey_initialize()
 #define pkey_mm_init(mm)
 
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 8d756ef..1424c79 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -229,3 +229,46 @@ bool arch_pte_access_permitted(u64 pte, bool write, bool execute)
 	return pkey_access_permitted(pte_to_pkey_bits(pte),
 			write, execute);
 }
+
+/*
+ * We only want to enforce protection keys on the current process
+ * because we effectively have no access to AMR/IAMR for other
+ * processes or any way to tell *which * AMR/IAMR in a threaded
+ * process we could use.
+ *
+ * So do not enforce things if the VMA is not from the current
+ * mm, or if we are in a kernel thread.
+ */
+static inline bool vma_is_foreign(struct vm_area_struct *vma)
+{
+	if (!current->mm)
+		return true;
+	/*
+	 * if the VMA is from another process, then AMR/IAMR has no
+	 * relevance and should not be enforced.
+	 */
+	if (current->mm != vma->vm_mm)
+		return true;
+
+	return false;
+}
+
+bool arch_vma_access_permitted(struct vm_area_struct *vma,
+		bool write, bool execute, bool foreign)
+{
+	int pkey;
+
+	if (!pkey_inited)
+		return true;
+
+	/* allow access if the VMA is not one from this process */
+	if (foreign || vma_is_foreign(vma))
+		return true;
+
+	pkey = vma_pkey(vma);
+
+	if (!pkey)
+		return true;
+
+	return pkey_access_permitted(pkey, write, execute);
+}
-- 
1.7.1
