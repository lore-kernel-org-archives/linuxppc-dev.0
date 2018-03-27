Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409FXh4K8CzF27K
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 13:37:24 +1100 (AEDT)
Received: by mail-qk0-x243.google.com with SMTP id z184so22393030qkc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 19:37:24 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 fweimer@redhat.com, msuchanek@suse.com
Subject: [PATCH] powerpc/mm: Fix thread_pkey_regs_init()
Date: Mon, 26 Mar 2018 19:36:54 -0700
Message-Id: <1522118214-7040-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

thread_pkey_regs_init() initializes the pkey related registers
instead of initializing the fields in the task structures.  Fortunately
those key related registers are re-set to zero when the task
gets scheduled on the cpu. However its good to fix this glaringly
visible error.

cc: Michael Ellermen <mpe@ellerman.id.au>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pkeys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 58bbb55..61dba4e 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -338,9 +338,9 @@ void thread_pkey_regs_init(struct thread_struct *thread)
 	if (static_branch_likely(&pkey_disabled))
 		return;
 
-	write_amr(read_amr() & pkey_amr_uamor_mask);
-	write_iamr(read_iamr() & pkey_iamr_mask);
-	write_uamor(read_uamor() & pkey_amr_uamor_mask);
+	thread->amr = read_amr() & pkey_amr_uamor_mask;
+	thread->iamr = read_iamr() & pkey_iamr_mask;
+	thread->uamor = read_uamor() & pkey_amr_uamor_mask;
 }
 
 static inline bool pkey_allows_readwrite(int pkey)
-- 
1.8.3.1
