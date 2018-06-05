Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410FdN6NCkzF1c0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 12:10:32 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id q6-v6so841711qtn.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jun 2018 19:10:32 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, luto@kernel.org
Subject: [PATCH  5/5] powerpc/pkeys: make protection key 0 less special
Date: Mon,  4 Jun 2018 19:09:54 -0700
Message-Id: <1528164594-23823-6-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1528164594-23823-1-git-send-email-linuxram@us.ibm.com>
References: <1528164594-23823-1-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
(c) its permissions cannot be modified by userspace.

NOTE: (c) is specific to powerpc only. pkey-0 is associated by default
with all pages including kernel pages, and pkeys are also active in
kernel mode. If any permission is denied on pkey-0, the kernel running
in the context of the application will be unable to operate.

Tested on powerpc.

cc: Thomas Gleixner <tglx@linutronix.de>
cc: Dave Hansen <dave.hansen@intel.com>
cc: Michael Ellermen <mpe@ellerman.id.au>
cc: Ingo Molnar <mingo@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
cc: Michal Such谩nek <msuchanek@suse.de
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
-----------------------------------------------------------------------
History:
	v4: . introduced PKEY_0 macro.  No bug fixes. Code
		re-arrangement to save a few cycles.

	v3: . Corrected a comment in arch_set_user_pkey_access().  .
	Clarified the header, to capture the notion that pkey-0
	permissions cannot be modified by userspace on powerpc.
      		-- comment from Thiago

	v2: . mm_pkey_is_allocated() continued to treat pkey-0 special.
		fixed it.
---
 arch/powerpc/include/asm/pkeys.h |   29 +++++++++++++++++++++++------
 arch/powerpc/mm/pkeys.c          |   13 ++++++-------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 0409c80..d349e22 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -13,7 +13,10 @@
 
 DECLARE_STATIC_KEY_TRUE(pkey_disabled);
 extern int pkeys_total; /* total pkeys as per device tree */
-extern u32 initial_allocation_mask; /* bits set for reserved keys */
+extern u32 initial_allocation_mask; /*  bits set for the initially allocated keys */
+extern u32 reserved_allocation_mask; /* bits set for reserved keys */
+
+#define PKEY_0	0
 
 /*
  * Define these here temporarily so we're not dependent on patching linux/mm.h.
@@ -96,15 +99,19 @@ static inline u16 pte_to_pkey_bits(u64 pteflags)
 #define __mm_pkey_is_allocated(mm, pkey)	\
 	(mm_pkey_allocation_map(mm) & pkey_alloc_mask(pkey))
 
-#define __mm_pkey_is_reserved(pkey) (initial_allocation_mask & \
+#define __mm_pkey_is_reserved(pkey) (reserved_allocation_mask & \
 				       pkey_alloc_mask(pkey))
 
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
@@ -200,6 +207,16 @@ static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 {
 	if (static_branch_likely(&pkey_disabled))
 		return -EINVAL;
+
+	/*
+	 * userspace should not change pkey-0 permissions.
+	 * pkey-0 is associated with every page in the kernel.
+	 * If userspace denies any permission on pkey-0, the
+	 * kernel cannot operate.
+	 */
+	if (pkey == PKEY_0)
+		return init_val ? -EINVAL : 0;
+
 	return __arch_set_user_pkey_access(tsk, pkey, init_val);
 }
 
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 0b98db6..1ebb21b 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -14,7 +14,8 @@
 bool pkey_execute_disable_supported;
 int  pkeys_total;		/* Total pkeys as per device tree */
 bool pkeys_devtree_defined;	/* pkey property exported by device tree */
-u32  initial_allocation_mask;	/* Bits set for reserved keys */
+u32  initial_allocation_mask;   /* Bits set for the initially allocated keys */
+u32  reserved_allocation_mask;  /* Bits set for reserved keys */
 u64  pkey_amr_mask;		/* Bits in AMR not to be touched */
 u64  pkey_iamr_mask;		/* Bits in AMR not to be touched */
 u64  pkey_uamor_mask;		/* Bits in UMOR not to be touched */
@@ -121,8 +122,9 @@ int pkey_initialize(void)
 #else
 	os_reserved = 0;
 #endif
-	initial_allocation_mask  = (0x1 << 0) | (0x1 << 1) |
-					(0x1 << EXECUTE_ONLY_KEY);
+	/* Bits are in LE format. */
+	reserved_allocation_mask = (0x1 << 1) | (0x1 << EXECUTE_ONLY_KEY);
+	initial_allocation_mask  = reserved_allocation_mask | (0x1 << PKEY_0);
 
 	/* register mask is in BE format */
 	pkey_amr_mask = ~0x0ul;
@@ -135,7 +137,7 @@ int pkey_initialize(void)
 	pkey_amr_mask |= (AMR_RD_BIT|AMR_WR_BIT) << pkeyshift(EXECUTE_ONLY_KEY);
 
 	pkey_uamor_mask = ~0x0ul;
-	pkey_uamor_mask &= ~(0x3ul << pkeyshift(0));
+	pkey_uamor_mask &= ~(0x3ul << pkeyshift(PKEY_0));
 	/*
 	 * key 1 is recommended not to be used.
 	 * PowerISA(3.0) page 1015,
@@ -381,9 +383,6 @@ static bool pkey_access_permitted(int pkey, bool write, bool execute)
 	int pkey_shift;
 	u64 amr;
 
-	if (!pkey)
-		return true;
-
 	if (!is_pkey_enabled(pkey))
 		return true;
 
-- 
1.7.1
