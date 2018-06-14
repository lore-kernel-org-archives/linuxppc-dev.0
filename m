Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x22f.google.com (mail-qt0-x22f.google.com
 [IPv6:2607:f8b0:400d:c0d::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415kyY7091zDrqP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 10:29:25 +1000 (AEST)
Received: by mail-qt0-x22f.google.com with SMTP id l10-v6so4263320qtj.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 17:29:25 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, luto@kernel.org,
 msuchanek@suse.de
Subject: [PATCH v2 3/6] powerpc/pkeys: fix calculation of total pkeys.
Date: Wed, 13 Jun 2018 17:29:01 -0700
Message-Id: <1528936144-6696-4-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Total number of pkeys calculation is off by 1. Fix it.

CC: Florian Weimer <fweimer@redhat.com>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/pkeys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 6529f4e..b681bec 100644
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
