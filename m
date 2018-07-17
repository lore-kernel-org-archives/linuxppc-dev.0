Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VMBx3JcrzF3Hd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 23:51:37 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id f18-v6so884769qtp.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 06:51:37 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, msuchanek@suse.de
Subject: [PATCH v3 5/9] powerpc/pkeys: fix calculation of total pkeys.
Date: Tue, 17 Jul 2018 06:51:06 -0700
Message-Id: <1531835470-32691-6-git-send-email-linuxram@us.ibm.com>
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

Total number of pkeys calculation is off by 1. Fix it.

Cc: Florian Weimer <fweimer@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Fixes: 4fb158f65ac5 ("powerpc: track allocation status of all pkeys")
Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/pkeys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index cd0e623..7db56d8 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -92,7 +92,7 @@ int pkey_initialize(void)
 	 * arch-neutral code.
 	 */
 	pkeys_total = min_t(int, pkeys_total,
-			(ARCH_VM_PKEY_FLAGS >> VM_PKEY_SHIFT));
+			((ARCH_VM_PKEY_FLAGS >> VM_PKEY_SHIFT)+1));
 
 	if (!pkey_mmu_enabled() || radix_enabled() || !pkeys_total)
 		static_branch_enable(&pkey_disabled);
-- 
1.7.1
