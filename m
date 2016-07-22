Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwgm33MgLzDrHZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 16:31:47 +1000 (AEST)
Date: Fri, 22 Jul 2016 16:31:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: linux-next: build failure after merge of the powerpc tree
Message-ID: <20160722163147.73579b85@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

After merging the powerpc tree, today's linux-next build (powerpc64
allnoconfig) failed like this:

arch/powerpc/mm/built-in.o: In function `.hash__early_init_mmu':
(.init.text+0x7d8): undefined reference to `.hpte_init_native'

Caused by commit

  166dd7d3fbf2 ("powerpc/64: Move MMU backend selection out of platform code")

hpte_init_native is in hash_native_64 which is only built for
CONFIG_PPC_NATIVE.  I added the following fix patch (which is probably
not correct).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 22 Jul 2016 16:28:00 +1000
Subject: [PATCH] powerpc: fix for "Move MMU backend selection out of platform
 code"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/mm/hash_utils_64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 341632471b9d..7c50b4b79c84 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -931,8 +931,10 @@ void __init hash__early_init_mmu(void)
 		ps3_early_mm_init();
 	else if (firmware_has_feature(FW_FEATURE_LPAR))
 		hpte_init_lpar();
+#ifdef CONFIG_PPC_NATIVE
 	else
 		hpte_init_native();
+#endif
 
 	/* Initialize the MMU Hash table and create the linear mapping
 	 * of memory. Has to be done before SLB initialization as this is
-- 
2.8.1

-- 
Cheers,
Stephen Rothwell
