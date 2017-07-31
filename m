Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLKfL0bgmzDr5s
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 10:12:58 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id u19so14271431qtc.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 17:12:57 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, linuxram@us.ibm.com,
 bauerman@linux.vnet.ibm.com, mhocko@kernel.org
Subject: [RFC v7 10/25] powerpc: introduce execute-only pkey
Date: Sun, 30 Jul 2017 17:12:11 -0700
Message-Id: <1501459946-11619-11-git-send-email-linuxram@us.ibm.com>
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

This patch provides the implementation of execute-only pkey.
The architecture-independent  expects the ability to create
and manage a special key which has execute-only permission.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h |    1 +
 arch/powerpc/include/asm/pkeys.h         |    8 ++++-
 arch/powerpc/mm/pkeys.c                  |   57 ++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 104ad72..0c0a2a8 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -116,6 +116,7 @@ struct patb_entry {
 	 * bit unset -> key available for allocation
 	 */
 	u32 pkey_allocation_map;
+	s16 execute_only_pkey; /* key holding execute-only protection */
 #endif
 } mm_context_t;
 
diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index dac8751..5b17d93 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -126,11 +126,15 @@ static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
  * Try to dedicate one of the protection keys to be used as an
  * execute-only protection key.
  */
+extern int __execute_only_pkey(struct mm_struct *mm);
 static inline int execute_only_pkey(struct mm_struct *mm)
 {
-	return 0;
+	if (!pkey_inited)
+		return -1;
+	return __execute_only_pkey(mm);
 }
 
+
 static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
 		int prot, int pkey)
 {
@@ -157,6 +161,8 @@ static inline void pkey_mm_init(struct mm_struct *mm)
 	if (!pkey_inited)
 		return;
 	mm_pkey_allocation_map(mm) = initial_allocation_mask;
+	/* -1 means unallocated or invalid */
+	mm->context.execute_only_pkey = -1;
 }
 
 static inline void pkey_initialize(void)
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index c1c40c3..25749bf 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -97,3 +97,60 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	init_iamr(pkey, new_iamr_bits);
 	return 0;
 }
+
+static inline bool pkey_allows_readwrite(int pkey)
+{
+	int pkey_shift = pkeyshift(pkey);
+
+	if (!(read_uamor() & (0x3UL << pkey_shift)))
+		return true;
+
+	return !(read_amr() & ((AMR_RD_BIT|AMR_WR_BIT) << pkey_shift));
+}
+
+int __execute_only_pkey(struct mm_struct *mm)
+{
+	bool need_to_set_mm_pkey = false;
+	int execute_only_pkey = mm->context.execute_only_pkey;
+	int ret;
+
+	/* Do we need to assign a pkey for mm's execute-only maps? */
+	if (execute_only_pkey == -1) {
+		/* Go allocate one to use, which might fail */
+		execute_only_pkey = mm_pkey_alloc(mm);
+		if (execute_only_pkey < 0)
+			return -1;
+		need_to_set_mm_pkey = true;
+	}
+
+	/*
+	 * We do not want to go through the relatively costly
+	 * dance to set AMR if we do not need to.  Check it
+	 * first and assume that if the execute-only pkey is
+	 * readwrite-disabled than we do not have to set it
+	 * ourselves.
+	 */
+	if (!need_to_set_mm_pkey &&
+	    !pkey_allows_readwrite(execute_only_pkey))
+		return execute_only_pkey;
+
+	/*
+	 * Set up AMR so that it denies access for everything
+	 * other than execution.
+	 */
+	ret = __arch_set_user_pkey_access(current, execute_only_pkey,
+			(PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
+	/*
+	 * If the AMR-set operation failed somehow, just return
+	 * 0 and effectively disable execute-only support.
+	 */
+	if (ret) {
+		mm_set_pkey_free(mm, execute_only_pkey);
+		return -1;
+	}
+
+	/* We got one, store it and use it from here on out */
+	if (need_to_set_mm_pkey)
+		mm->context.execute_only_pkey = execute_only_pkey;
+	return execute_only_pkey;
+}
-- 
1.7.1
