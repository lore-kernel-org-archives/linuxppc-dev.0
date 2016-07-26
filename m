Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz3kX1Y6BzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 13:38:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2 1/2] powerpc/mm: Fix build break when PPC_NATIVE=n
Date: Tue, 26 Jul 2016 13:38:37 +1000
Message-Id: <1469504318-9461-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent commit to rework the hash MMU setup broke the build when
CONFIG_PPC_NATIVE=n. Fix it by adding an IS_ENABLED() check before
calling hpte_init_native().

Removing the else clause opens the possibility that we don't set any
ops, which would probably lead to a strange crash later. So add a check
that we correctly initialised at least one member of the struct.

Fixes: 166dd7d3fbf2 ("powerpc/64: Move MMU backend selection out of platform code")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/hash_utils_64.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 341632471b9d..381b5894cc99 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -931,9 +931,12 @@ void __init hash__early_init_mmu(void)
 		ps3_early_mm_init();
 	else if (firmware_has_feature(FW_FEATURE_LPAR))
 		hpte_init_lpar();
-	else
+	else if IS_ENABLED(CONFIG_PPC_NATIVE)
 		hpte_init_native();
 
+	if (!mmu_hash_ops.hpte_insert)
+		panic("hash__early_init_mmu: No MMU hash ops defined!\n");
+
 	/* Initialize the MMU Hash table and create the linear mapping
 	 * of memory. Has to be done before SLB initialization as this is
 	 * currently where the page size encoding is obtained.
-- 
2.7.4
