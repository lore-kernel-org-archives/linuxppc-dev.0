Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409CVR1vGMzF26n
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 12:05:19 +1100 (AEDT)
Received: by mail-qk0-x243.google.com with SMTP id o184so22201019qkd.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 18:05:19 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	mingo@redhat.com,
	akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 fweimer@redhat.com, msuchanek@suse.com, tglx@linutronix.de,
 shuah@kernel.org
Subject: [PATCH v2] powerpc, pkey: make protection key 0 less special
Date: Mon, 26 Mar 2018 18:05:02 -0700
Message-Id: <1522112702-27853-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Applications need the ability to associate an address-range with some
key and latter revert to its initial default key. Pkey-0 comes close to
providing this function but falls short, because the current
implementation disallows applications to explicitly associate pkey-0 to
the address range.

Lets make pkey-0 less special and treat it almost like any other key.
Thus it can be explicitly associated with any address range, and can be
freed. This gives the application more flexibility and power.  The
ability to free pkey-0 must be used responsibily, since pkey-0 is
associated with almost all address-range by default.

Even with this change pkey-0 continues to be slightly more special
from the following point of view.
(a) it is implicitly allocated.
(b) it is the default key assigned to any address-range.

Tested on powerpc.

cc: Thomas Gleixner <tglx@linutronix.de>
cc: Dave Hansen <dave.hansen@intel.com>
cc: Michael Ellermen <mpe@ellerman.id.au>
cc: Ingo Molnar <mingo@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
History:
	v2: mm_pkey_is_allocated() continued to treat pkey-0 special.
	    fixed it.

 arch/powerpc/include/asm/pkeys.h | 20 ++++++++++++++++----
 arch/powerpc/mm/pkeys.c          | 20 ++++++++++++--------
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 0409c80..b598fa9 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -101,10 +101,14 @@ static inline u16 pte_to_pkey_bits(u64 pteflags)
 
 static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 {
-	/* A reserved key is never considered as 'explicitly allocated' */
-	return ((pkey < arch_max_pkey()) &&
-		!__mm_pkey_is_reserved(pkey) &&
-		__mm_pkey_is_allocated(mm, pkey));
+	if (pkey < 0 || pkey >= arch_max_pkey())
+		return false;
+
+	/* Reserved keys are never allocated. */
+	if (__mm_pkey_is_reserved(pkey))
+		return false;
+
+	return __mm_pkey_is_allocated(mm, pkey);
 }
 
 extern void __arch_activate_pkey(int pkey);
@@ -200,6 +204,14 @@ static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 {
 	if (static_branch_likely(&pkey_disabled))
 		return -EINVAL;
+
+	/*
+	 * userspace is discouraged from changing permissions of
+	 * pkey-0. powerpc hardware does not support it anyway.
+	 */
+	if (!pkey)
+		return init_val ? -EINVAL : 0;
+
 	return __arch_set_user_pkey_access(tsk, pkey, init_val);
 }
 
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index ba71c54..e7a9e34 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -119,19 +119,21 @@ int pkey_initialize(void)
 #else
 	os_reserved = 0;
 #endif
-	/*
-	 * Bits are in LE format. NOTE: 1, 0 are reserved.
-	 * key 0 is the default key, which allows read/write/execute.
-	 * key 1 is recommended not to be used. PowerISA(3.0) page 1015,
-	 * programming note.
-	 */
+	/* Bits are in LE format. */
 	initial_allocation_mask = ~0x0;
 
 	/* register mask is in BE format */
 	pkey_amr_uamor_mask = ~0x0ul;
 	pkey_iamr_mask = ~0x0ul;
 
-	for (i = 2; i < (pkeys_total - os_reserved); i++) {
+	for (i = 0; i < (pkeys_total - os_reserved); i++) {
+	 	/*
+		 * key 1 is recommended not to be used.
+		 * PowerISA(3.0) page 1015,
+		 */
+		if (i == 1)
+			continue;
+
 		initial_allocation_mask &= ~(0x1 << i);
 		pkey_amr_uamor_mask &= ~(0x3ul << pkeyshift(i));
 		pkey_iamr_mask &= ~(0x1ul << pkeyshift(i));
@@ -145,7 +147,9 @@ void pkey_mm_init(struct mm_struct *mm)
 {
 	if (static_branch_likely(&pkey_disabled))
 		return;
-	mm_pkey_allocation_map(mm) = initial_allocation_mask;
+
+	/* allocate key-0 by default */
+	mm_pkey_allocation_map(mm) = initial_allocation_mask | 0x1;
 	/* -1 means unallocated or invalid */
 	mm->context.execute_only_pkey = -1;
 }
-- 
1.8.3.1
