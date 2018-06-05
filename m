Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410FdL6scMzF1RG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 12:10:30 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id p23-v6so841365qtn.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jun 2018 19:10:30 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, luto@kernel.org
Subject: [PATCH  4/5] powerpc/pkeys: Preallocate execute-only key
Date: Mon,  4 Jun 2018 19:09:53 -0700
Message-Id: <1528164594-23823-5-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1528164594-23823-1-git-send-email-linuxram@us.ibm.com>
References: <1528164594-23823-1-git-send-email-linuxram@us.ibm.com>
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

CC: Andy Lutomirski <luto@kernel.org>
CC: Florian Weimer <fweimer@redhat.com>
CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
CC: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/pkeys.c |   53 +++++++---------------------------------------
 1 files changed, 8 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 90ab793..0b98db6 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -25,6 +25,7 @@
 #define IAMR_EX_BIT 0x1UL
 #define PKEY_REG_BITS (sizeof(u64)*8)
 #define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey+1) * AMR_BITS_PER_PKEY))
+#define EXECUTE_ONLY_KEY 2
 
 static void scan_pkey_feature(void)
 {
@@ -120,7 +121,8 @@ int pkey_initialize(void)
 #else
 	os_reserved = 0;
 #endif
-	initial_allocation_mask  = (0x1 << 0) | (0x1 << 1);
+	initial_allocation_mask  = (0x1 << 0) | (0x1 << 1) |
+					(0x1 << EXECUTE_ONLY_KEY);
 
 	/* register mask is in BE format */
 	pkey_amr_mask = ~0x0ul;
@@ -130,6 +132,7 @@ int pkey_initialize(void)
 		pkey_amr_mask &= ~(0x3ul << pkeyshift(i));
 		pkey_iamr_mask &= ~(0x1ul << pkeyshift(i));
 	}
+	pkey_amr_mask |= (AMR_RD_BIT|AMR_WR_BIT) << pkeyshift(EXECUTE_ONLY_KEY);
 
 	pkey_uamor_mask = ~0x0ul;
 	pkey_uamor_mask &= ~(0x3ul << pkeyshift(0));
@@ -140,6 +143,8 @@ int pkey_initialize(void)
 	 * pseries kernel running on powerVM.
 	 */
 	pkey_uamor_mask &= ~(0x3ul << pkeyshift(1));
+	pkey_uamor_mask &= ~(0x3ul << pkeyshift(EXECUTE_ONLY_KEY));
+
 	for (i = (pkeys_total - os_reserved); i < pkeys_total; i++)
 		pkey_uamor_mask &= ~(0x3ul << pkeyshift(i));
 
@@ -153,8 +158,7 @@ void pkey_mm_init(struct mm_struct *mm)
 	if (static_branch_likely(&pkey_disabled))
 		return;
 	mm_pkey_allocation_map(mm) = initial_allocation_mask;
-	/* -1 means unallocated or invalid */
-	mm->context.execute_only_pkey = -1;
+	mm->context.execute_only_pkey = EXECUTE_ONLY_KEY;
 }
 
 static inline u64 read_amr(void)
@@ -333,48 +337,7 @@ static inline bool pkey_allows_readwrite(int pkey)
 
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
