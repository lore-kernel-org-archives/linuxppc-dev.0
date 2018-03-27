Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409Cld3F8kzF27X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 12:16:44 +1100 (AEDT)
Received: by mail-qt0-x243.google.com with SMTP id w12so14050848qti.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 18:16:44 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 fweimer@redhat.com, msuchanek@suse.com
Subject: [PATCH] powerpc: do not allow userspace to modify execute-only pkey
Date: Mon, 26 Mar 2018 18:16:30 -0700
Message-Id: <1522113390-29240-1-git-send-email-linuxram@us.ibm.com>
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
This is fine for the keys explicitly allocated through the
sys_pkey_alloc(). But for execute-only pkey, this should not be allowed.
Restructured the code to fix the bug.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h | 24 ++++++------------------
 arch/powerpc/mm/pkeys.c          | 30 ++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index b598fa9..0d3c630 100644
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
index e7a9e34..58bbb55 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -228,7 +228,10 @@ static void pkey_status_change(int pkey, bool enable)
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
@@ -247,6 +250,29 @@ void __arch_deactivate_pkey(int pkey)
 	pkey_status_change(pkey, false);
 }
 
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
 /*
  * Set the access rights in AMR IAMR and UAMOR registers for @pkey to that
  * specified in @init_val.
@@ -336,7 +362,7 @@ int __execute_only_pkey(struct mm_struct *mm)
 	/* Do we need to assign a pkey for mm's execute-only maps? */
 	if (execute_only_pkey == -1) {
 		/* Go allocate one to use, which might fail */
-		execute_only_pkey = mm_pkey_alloc(mm);
+		execute_only_pkey = __mm_pkey_alloc(mm);
 		if (execute_only_pkey < 0)
 			return -1;
 		need_to_set_mm_pkey = true;
-- 
1.8.3.1
