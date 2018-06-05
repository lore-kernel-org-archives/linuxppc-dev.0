Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x22a.google.com (mail-qt0-x22a.google.com
 [IPv6:2607:f8b0:400d:c0d::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410FdK40pfzF1SJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 12:10:29 +1000 (AEST)
Received: by mail-qt0-x22a.google.com with SMTP id i18-v6so817034qtp.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jun 2018 19:10:29 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, luto@kernel.org
Subject: [PATCH  3/5] powerpc/pkeys: fix calculation of total pkeys.
Date: Mon,  4 Jun 2018 19:09:52 -0700
Message-Id: <1528164594-23823-4-git-send-email-linuxram@us.ibm.com>
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

Total number of pkeys calculation is off by 1. Fix it.

CC: Florian Weimer <fweimer@redhat.com>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/pkeys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 6fc56f4..90ab793 100644
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
