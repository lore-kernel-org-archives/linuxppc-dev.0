Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40d2nv0RZ8zDr4K
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 05:56:18 +1000 (AEST)
Received: by mail-qk0-x243.google.com with SMTP id a202so17578432qkg.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 12:56:18 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 msuchanek@suse.com, Ulrich.Weigand@de.ibm.com
Subject: [PATCH v2] powerpc: do not allow userspace to modify execute-only pkey
Date: Fri,  4 May 2018 12:56:00 -0700
Message-Id: <1525463760-32333-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When mprotect(....,PROT_EXEC) is called, the kernel allocates a
execute-only pkey and associates the pkey with the given address space.
The permission of this key should not be modifiable from userspace.
However a bug in the current implementation lets the permissions on the
key modifiable from userspace.

Whenever a key is allocated through mm_pkey_alloc(), the kernel programs
the UAMOR register to allow userspace to change permissions on the key.
This is fine for keys explicitly allocated through the
sys_pkey_alloc(). But for execute-only pkey, it must be disallowed.
Restructured the code to fix the bug.

cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
cc: Michael Ellermen <mpe@ellerman.id.au>

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
History:

	v2: Thiago noticed a bug -- __execute_only_pkey() will always fail
	    since it calls is_pkey_enabled() which always returns false
	    for execute_only key. is_pkey_enabled() returns false
	    because UAMOR bit for the execute_only key is and never be set.
	    Fixed it.


 arch/powerpc/include/asm/pkeys.h |   24 ++++------------
 arch/powerpc/mm/pkeys.c          |   57 ++++++++++++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 31a6976..3a9b82b 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -113,6 +113,8 @@ static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 
 extern void __arch_activate_pkey(int pkey);
 extern void __arch_deactivate_pkey(int pkey);
+extern int __mm_pkey_alloc(struct mm_struct *mm);
+
 /*
  * Returns a positive, 5-bit key on success, or -1 on failure.
  * Relies on the mmap_sem to protect against concurrency in mm_pkey_alloc() and
@@ -120,29 +122,14 @@ static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
  */
 static inline int mm_pkey_alloc(struct mm_struct *mm)
 {
-	/*
-	 * Note: this is the one and only place we make sure that the pkey is
-	 * valid as far as the hardware is concerned. The rest of the kernel
-	 * trusts that only good, valid pkeys come out of here.
-	 */
-	u32 all_pkeys_mask = (u32)(~(0x0));
 	int ret;
 
 	if (static_branch_likely(&pkey_disabled))
 		return -1;
 
+	ret = __mm_pkey_alloc(mm);
 	/*
-	 * Are we out of pkeys? We must handle this specially because ffz()
-	 * behavior is undefined if there are no zeros.
-	 */
-	if (mm_pkey_allocation_map(mm) == all_pkeys_mask)
-		return -1;
-
-	ret = ffz((u32)mm_pkey_allocation_map(mm));
-	__mm_pkey_allocated(mm, ret);
-
-	/*
-	 * Enable the key in the hardware
+	 * Enable userspace to modify the key permissions.
 	 */
 	if (ret > 0)
 		__arch_activate_pkey(ret);
@@ -158,7 +145,8 @@ static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
 		return -EINVAL;
 
 	/*
-	 * Disable the key in the hardware
+	 * Reset the key and disable userspace
+	 * from modifying the key permissions.
 	 */
 	__arch_deactivate_pkey(pkey);
 	__mm_pkey_free(mm, pkey);
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index d6873b4..e81d59e 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -190,6 +190,9 @@ static inline void write_uamor(u64 value)
 	mtspr(SPRN_UAMOR, value);
 }
 
+/*
+ * return true if userspace can modify the pkey permissions.
+ */
 static bool is_pkey_enabled(int pkey)
 {
 	u64 uamor = read_uamor();
@@ -228,7 +231,10 @@ static void pkey_status_change(int pkey, bool enable)
 	init_amr(pkey, 0x0);
 	init_iamr(pkey, 0x0);
 
-	/* Enable/disable key */
+	/*
+	 * Enable/disable userspace to/from modifying the permissions
+	 * on the key
+	 */
 	old_uamor = read_uamor();
 	if (enable)
 		old_uamor |= (0x3ul << pkeyshift(pkey));
@@ -247,19 +253,35 @@ void __arch_deactivate_pkey(int pkey)
 	pkey_status_change(pkey, false);
 }
 
-/*
- * Set the access rights in AMR IAMR and UAMOR registers for @pkey to that
- * specified in @init_val.
- */
-int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
+int __mm_pkey_alloc(struct mm_struct *mm)
+{
+	/*
+	 * Note: this is the one and only place we make sure that the pkey is
+	 * valid as far as the hardware is concerned. The rest of the kernel
+	 * trusts that only good, valid pkeys come out of here.
+	 */
+	u32 all_pkeys_mask = (u32)(~(0x0));
+	int ret;
+
+	/*
+	 * Are we out of pkeys? We must handle this specially because ffz()
+	 * behavior is undefined if there are no zeros.
+	 */
+	if (mm_pkey_allocation_map(mm) == all_pkeys_mask)
+		return -1;
+
+	ret = ffz((u32)mm_pkey_allocation_map(mm));
+	__mm_pkey_allocated(mm, ret);
+
+	return ret;
+}
+
+static int set_user_pkey_access(struct task_struct *tsk, int pkey,
 				unsigned long init_val)
 {
 	u64 new_amr_bits = 0x0ul;
 	u64 new_iamr_bits = 0x0ul;
 
-	if (!is_pkey_enabled(pkey))
-		return -EINVAL;
-
 	if (init_val & PKEY_DISABLE_EXECUTE) {
 		if (!pkey_execute_disable_supported)
 			return -EINVAL;
@@ -277,6 +299,19 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	return 0;
 }
 
+/*
+ * Set the access rights in AMR IAMR and UAMOR registers for @pkey to that
+ * specified in @init_val.
+ */
+int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
+				unsigned long init_val)
+{
+	if (!is_pkey_enabled(pkey))
+		return -EINVAL;
+
+	return set_user_pkey_access(tsk, pkey, init_val);
+}
+
 void thread_pkey_regs_save(struct thread_struct *thread)
 {
 	if (static_branch_likely(&pkey_disabled))
@@ -336,7 +371,7 @@ int __execute_only_pkey(struct mm_struct *mm)
 	/* Do we need to assign a pkey for mm's execute-only maps? */
 	if (execute_only_pkey == -1) {
 		/* Go allocate one to use, which might fail */
-		execute_only_pkey = mm_pkey_alloc(mm);
+		execute_only_pkey = __mm_pkey_alloc(mm);
 		if (execute_only_pkey < 0)
 			return -1;
 		need_to_set_mm_pkey = true;
@@ -355,7 +390,7 @@ int __execute_only_pkey(struct mm_struct *mm)
 	 * Set up AMR so that it denies access for everything other than
 	 * execution.
 	 */
-	ret = __arch_set_user_pkey_access(current, execute_only_pkey,
+	ret = set_user_pkey_access(current, execute_only_pkey,
 					  PKEY_DISABLE_ACCESS |
 					  PKEY_DISABLE_WRITE);
 	/*
-- 
1.7.1
