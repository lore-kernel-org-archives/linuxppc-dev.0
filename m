Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419YSL1nr9zF0vb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 15:34:58 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id q70-v6so1236537qke.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 22:34:57 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, msuchanek@suse.de
Subject: [PATCH] powerpc/pkeys: preallocate execute_only key only if the key
 is available.
Date: Tue, 19 Jun 2018 22:34:22 -0700
Message-Id: <1529472862-26506-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Key 2 is preallocated and reserved for execute-only key. In rare
cases if key-2 is unavailable, mprotect(PROT_EXEC) will behave
incorrectly. NOTE: mprotect(PROT_EXEC) uses execute-only key.

Ensure key 2 is available for preallocation before reserving it for
execute_only purpose.

CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/pkeys.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index cec990c..2013ef0 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -19,6 +19,7 @@
 u64  pkey_amr_mask;		/* Bits in AMR not to be touched */
 u64  pkey_iamr_mask;		/* Bits in AMR not to be touched */
 u64  pkey_uamor_mask;		/* Bits in UMOR not to be touched */
+u32  execute_only_key = 2;
 
 #define AMR_BITS_PER_PKEY 2
 #define AMR_RD_BIT 0x1UL
@@ -26,7 +27,6 @@
 #define IAMR_EX_BIT 0x1UL
 #define PKEY_REG_BITS (sizeof(u64)*8)
 #define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey+1) * AMR_BITS_PER_PKEY))
-#define EXECUTE_ONLY_KEY 2
 
 static void scan_pkey_feature(void)
 {
@@ -122,8 +122,12 @@ int pkey_initialize(void)
 #else
 	os_reserved = 0;
 #endif
+
+	if ((pkeys_total - os_reserved) <= execute_only_key)
+		execute_only_key = -1;
+
 	/* Bits are in LE format. */
-	reserved_allocation_mask = (0x1 << 1) | (0x1 << EXECUTE_ONLY_KEY);
+	reserved_allocation_mask = (0x1 << 1) | (0x1 << execute_only_key);
 	initial_allocation_mask  = reserved_allocation_mask | (0x1 << PKEY_0);
 
 	/* register mask is in BE format */
@@ -132,11 +136,11 @@ int pkey_initialize(void)
 
 	pkey_iamr_mask = ~0x0ul;
 	pkey_iamr_mask &= ~(0x3ul << pkeyshift(PKEY_0));
-	pkey_iamr_mask &= ~(0x3ul << pkeyshift(EXECUTE_ONLY_KEY));
+	pkey_iamr_mask &= ~(0x3ul << pkeyshift(execute_only_key));
 
 	pkey_uamor_mask = ~0x0ul;
 	pkey_uamor_mask &= ~(0x3ul << pkeyshift(PKEY_0));
-	pkey_uamor_mask &= ~(0x3ul << pkeyshift(EXECUTE_ONLY_KEY));
+	pkey_uamor_mask &= ~(0x3ul << pkeyshift(execute_only_key));
 
 	for (i = (pkeys_total - os_reserved); i < pkeys_total; i++)
 		pkey_uamor_mask &= ~(0x3ul << pkeyshift(i));
@@ -151,7 +155,7 @@ void pkey_mm_init(struct mm_struct *mm)
 	if (static_branch_likely(&pkey_disabled))
 		return;
 	mm_pkey_allocation_map(mm) = initial_allocation_mask;
-	mm->context.execute_only_pkey = EXECUTE_ONLY_KEY;
+	mm->context.execute_only_pkey = execute_only_key;
 }
 
 static inline u64 read_amr(void)
-- 
1.7.1
