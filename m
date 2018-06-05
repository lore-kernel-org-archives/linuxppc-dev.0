Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410FdK1H82zF1RG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 12:10:26 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id r66-v6so539171qkr.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jun 2018 19:10:25 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, luto@kernel.org
Subject: [PATCH 1/5] powerpc/pkeys: Enable all user-allocatable pkeys at init.
Date: Mon,  4 Jun 2018 19:09:50 -0700
Message-Id: <1528164594-23823-2-git-send-email-linuxram@us.ibm.com>
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

In a multithreaded application, a key allocated by one thread must
be activate and usable on all threads.

Currently this is not the case, because the UAMOR bits for all keys are
disabled by default. When a new key is allocated in one thread, though
the corresponding UAMOR bits for that thread get enabled, the UAMOR bits
for all other existing threads continue to have their bits disabled.
Other threads have no way to set permissions on the key, effectively
making the key useless.

Enable the UAMOR bits for all keys, at process creation. Since the
contents of UAMOR are inherited at fork, all threads are capable of
modifying the permissions on any key.

BTW: changing the permission on unallocated keys has no effect, till
those keys are not associated with any PTEs. The kernel will anyway
disallow to association of unallocated keys with PTEs.

CC: Andy Lutomirski <luto@kernel.org>
CC: Florian Weimer <fweimer@redhat.com>
CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
CC: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/pkeys.c |   47 +++++++++++++++++++++++++++++------------------
 1 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 0eafdf0..6fc56f4 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -15,8 +15,9 @@
 int  pkeys_total;		/* Total pkeys as per device tree */
 bool pkeys_devtree_defined;	/* pkey property exported by device tree */
 u32  initial_allocation_mask;	/* Bits set for reserved keys */
-u64  pkey_amr_uamor_mask;	/* Bits in AMR/UMOR not to be touched */
+u64  pkey_amr_mask;		/* Bits in AMR not to be touched */
 u64  pkey_iamr_mask;		/* Bits in AMR not to be touched */
+u64  pkey_uamor_mask;		/* Bits in UMOR not to be touched */
 
 #define AMR_BITS_PER_PKEY 2
 #define AMR_RD_BIT 0x1UL
@@ -119,20 +120,29 @@ int pkey_initialize(void)
 #else
 	os_reserved = 0;
 #endif
-	initial_allocation_mask = ~0x0;
-	pkey_amr_uamor_mask = ~0x0ul;
+	initial_allocation_mask  = (0x1 << 0) | (0x1 << 1);
+
+	/* register mask is in BE format */
+	pkey_amr_mask = ~0x0ul;
 	pkey_iamr_mask = ~0x0ul;
-	/*
-	 * key 0, 1 are reserved.
-	 * key 0 is the default key, which allows read/write/execute.
-	 * key 1 is recommended not to be used. PowerISA(3.0) page 1015,
-	 * programming note.
-	 */
-	for (i = 2; i < (pkeys_total - os_reserved); i++) {
-		initial_allocation_mask &= ~(0x1 << i);
-		pkey_amr_uamor_mask &= ~(0x3ul << pkeyshift(i));
+
+	for (i = 0; i < (pkeys_total - os_reserved); i++) {
+		pkey_amr_mask &= ~(0x3ul << pkeyshift(i));
 		pkey_iamr_mask &= ~(0x1ul << pkeyshift(i));
 	}
+
+	pkey_uamor_mask = ~0x0ul;
+	pkey_uamor_mask &= ~(0x3ul << pkeyshift(0));
+	/*
+	 * key 1 is recommended not to be used.
+	 * PowerISA(3.0) page 1015,
+	 * @TODO: Revisit this. This is only applicable on
+	 * pseries kernel running on powerVM.
+	 */
+	pkey_uamor_mask &= ~(0x3ul << pkeyshift(1));
+	for (i = (pkeys_total - os_reserved); i < pkeys_total; i++)
+		pkey_uamor_mask &= ~(0x3ul << pkeyshift(i));
+
 	return 0;
 }
 
@@ -289,9 +299,6 @@ void thread_pkey_regs_restore(struct thread_struct *new_thread,
 	if (static_branch_likely(&pkey_disabled))
 		return;
 
-	/*
-	 * TODO: Just set UAMOR to zero if @new_thread hasn't used any keys yet.
-	 */
 	if (old_thread->amr != new_thread->amr)
 		write_amr(new_thread->amr);
 	if (old_thread->iamr != new_thread->iamr)
@@ -305,9 +312,13 @@ void thread_pkey_regs_init(struct thread_struct *thread)
 	if (static_branch_likely(&pkey_disabled))
 		return;
 
-	thread->amr = read_amr() & pkey_amr_uamor_mask;
-	thread->iamr = read_iamr() & pkey_iamr_mask;
-	thread->uamor = read_uamor() & pkey_amr_uamor_mask;
+	thread->amr = pkey_amr_mask;
+	thread->iamr = pkey_iamr_mask;
+ 	thread->uamor = pkey_uamor_mask;
+
+	write_uamor(pkey_uamor_mask);
+	write_amr(pkey_amr_mask);
+	write_iamr(pkey_iamr_mask);
 }
 
 static inline bool pkey_allows_readwrite(int pkey)
-- 
1.7.1
