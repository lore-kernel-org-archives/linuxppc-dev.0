Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VMBz0BprzF3HZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 23:51:39 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id b15-v6so883259qtp.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 06:51:38 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, msuchanek@suse.de
Subject: [PATCH v3 6/9] powerpc/pkeys: Preallocate execute-only key
Date: Tue, 17 Jul 2018 06:51:07 -0700
Message-Id: <1531835470-32691-7-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1531835470-32691-1-git-send-email-linuxram@us.ibm.com>
References: <1531835470-32691-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

execute-only key is allocated dynamically. This is a problem.  When a
thread implicitly creates a execute-only key, and resets UAMOR for that
key, the UAMOR value does not percolate to all the other threads.  Any
other thread may ignorantly change the permissions on the key.  This can
cause the key to be not execute-only for that thread.

Preallocate the execute-only key and ensure that no thread can change
the permission of the key, by resetting the corresponding bit in UAMOR.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Fixes: 5586cf61e108 ("powerpc: introduce execute-only pkey")
Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/pkeys.c |   63 +++++++++++++---------------------------------
 1 files changed, 18 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 7db56d8..5d39a10 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -18,6 +18,7 @@
 u64  pkey_amr_mask;		/* Bits in AMR not to be touched */
 u64  pkey_iamr_mask;		/* Bits in AMR not to be touched */
 u64  pkey_uamor_mask;		/* Bits in UMOR not to be touched */
+int  execute_only_key = 2;
 
 #define AMR_BITS_PER_PKEY 2
 #define AMR_RD_BIT 0x1UL
@@ -120,7 +121,8 @@ int pkey_initialize(void)
 #else
 	os_reserved = 0;
 #endif
-	initial_allocation_mask  = (0x1 << 0) | (0x1 << 1);
+	initial_allocation_mask  = (0x1 << 0) | (0x1 << 1) |
+					(0x1 << execute_only_key);
 
 	/* register mask is in BE format */
 	pkey_amr_mask = ~0x0ul;
@@ -128,9 +130,11 @@ int pkey_initialize(void)
 
 	pkey_iamr_mask = ~0x0ul;
 	pkey_iamr_mask &= ~(0x3ul << pkeyshift(0));
+	pkey_iamr_mask &= ~(0x3ul << pkeyshift(execute_only_key));
 
 	pkey_uamor_mask = ~0x0ul;
 	pkey_uamor_mask &= ~(0x3ul << pkeyshift(0));
+	pkey_uamor_mask &= ~(0x3ul << pkeyshift(execute_only_key));
 
 	/* mark the rest of the keys as reserved and hence unavailable */
 	for (i = (pkeys_total - os_reserved); i < pkeys_total; i++) {
@@ -138,6 +142,17 @@ int pkey_initialize(void)
 		pkey_uamor_mask &= ~(0x3ul << pkeyshift(i));
 	}
 
+	if (unlikely((pkeys_total - os_reserved) <= execute_only_key)) {
+		/*
+		 * Insufficient number of keys to support
+		 * execute only key. Mark it unavailable.
+		 * Any AMR, UAMOR, IAMR bit set for
+		 * this key is irrelevant since this key
+		 * can never be allocated.
+		 */
+		execute_only_key = -1;
+	}
+
 	return 0;
 }
 
@@ -148,8 +163,7 @@ void pkey_mm_init(struct mm_struct *mm)
 	if (static_branch_likely(&pkey_disabled))
 		return;
 	mm_pkey_allocation_map(mm) = initial_allocation_mask;
-	/* -1 means unallocated or invalid */
-	mm->context.execute_only_pkey = -1;
+	mm->context.execute_only_pkey = execute_only_key;
 }
 
 static inline u64 read_amr(void)
@@ -301,48 +315,7 @@ static inline bool pkey_allows_readwrite(int pkey)
 
 int __execute_only_pkey(struct mm_struct *mm)
 {
-	bool need_to_set_mm_pkey = false;
-	int execute_only_pkey = mm->context.execute_only_pkey;
-	int ret;
-
-	/* Do we need to assign a pkey for mm's execute-only maps? */
-	if (execute_only_pkey == -1) {
-		/* Go allocate one to use, which might fail */
-		execute_only_pkey = mm_pkey_alloc(mm);
-		if (execute_only_pkey < 0)
-			return -1;
-		need_to_set_mm_pkey = true;
-	}
-
-	/*
-	 * We do not want to go through the relatively costly dance to set AMR
-	 * if we do not need to. Check it first and assume that if the
-	 * execute-only pkey is readwrite-disabled than we do not have to set it
-	 * ourselves.
-	 */
-	if (!need_to_set_mm_pkey && !pkey_allows_readwrite(execute_only_pkey))
-		return execute_only_pkey;
-
-	/*
-	 * Set up AMR so that it denies access for everything other than
-	 * execution.
-	 */
-	ret = __arch_set_user_pkey_access(current, execute_only_pkey,
-					  PKEY_DISABLE_ACCESS |
-					  PKEY_DISABLE_WRITE);
-	/*
-	 * If the AMR-set operation failed somehow, just return 0 and
-	 * effectively disable execute-only support.
-	 */
-	if (ret) {
-		mm_pkey_free(mm, execute_only_pkey);
-		return -1;
-	}
-
-	/* We got one, store it and use it from here on out */
-	if (need_to_set_mm_pkey)
-		mm->context.execute_only_pkey = execute_only_pkey;
-	return execute_only_pkey;
+	return mm->context.execute_only_pkey;
 }
 
 static inline bool vma_is_pkey_exec_only(struct vm_area_struct *vma)
-- 
1.7.1
