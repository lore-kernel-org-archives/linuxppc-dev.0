Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0FdB5z4qzDqRm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 12:08:14 +1000 (AEST)
Date: Thu, 28 Jul 2016 12:08:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michal Marek <mmarek@suse.cz>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Masahiro
 Yamada <yamada.masahiro@socionext.com>
Subject: linux-next: build failure after merge of the kbuild tree
Message-ID: <20160728120814.59e42bc8@canb.auug.org.au>
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

Hi Michal,

After merging the kbuild tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from <command-line>:0:0:
arch/powerpc/mm/hash_utils_64.c: In function 'hash__early_init_mmu':
include/linux/kconfig.h:19:65: error: expected '(' before numeric constant
 #define ____or(arg1_or_junk, y)  __take_second_arg(arg1_or_junk 1, y)
                                                                 ^
include/linux/kconfig.h:7:48: note: in definition of macro '__take_second_arg'
 #define __take_second_arg(__ignored, val, ...) val
                                                ^
include/linux/kconfig.h:18:23: note: in expansion of macro '____or'
 #define ___or(x, y)   ____or(__ARG_PLACEHOLDER_##x, y)
                       ^
include/linux/kconfig.h:17:22: note: in expansion of macro '___or'
 #define __or(x, y)   ___or(x, y)   
                      ^
include/linux/kconfig.h:65:28: note: in expansion of macro '__or'
 #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
                            ^
arch/powerpc/mm/hash_utils_64.c:929:10: note: in expansion of macro 'IS_ENABLED'
  else if IS_ENABLED(CONFIG_PPC_NATIVE)
          ^
include/linux/kconfig.h:19:65: error: statement with no effect [-Werror=unused-value]
 #define ____or(arg1_or_junk, y)  __take_second_arg(arg1_or_junk 1, y)
                                                                 ^
include/linux/kconfig.h:7:48: note: in definition of macro '__take_second_arg'
 #define __take_second_arg(__ignored, val, ...) val
                                                ^
include/linux/kconfig.h:18:23: note: in expansion of macro '____or'
 #define ___or(x, y)   ____or(__ARG_PLACEHOLDER_##x, y)
                       ^
include/linux/kconfig.h:17:22: note: in expansion of macro '___or'
 #define __or(x, y)   ___or(x, y)   
                      ^
include/linux/kconfig.h:65:28: note: in expansion of macro '__or'
 #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
                            ^
arch/powerpc/mm/hash_utils_64.c:929:10: note: in expansion of macro 'IS_ENABLED'
  else if IS_ENABLED(CONFIG_PPC_NATIVE)
          ^
cc1: all warnings being treated as errors

Caused by commit

  7353644fa9df ("powerpc/mm: Fix build break when PPC_NATIVE=n")

from the powerpc tree interacting with commit

  5e8754fd80b0 ("kconfig.h: allow to use IS_{ENABLE,REACHABLE} in macro expansion")

from the kbuild tree.

I have applied the following fix patch (that should be applied to the
powerpc tree):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 28 Jul 2016 12:03:25 +1000
Subject: [PATCH] powerpc/mm: parenthesise the if condition

The breakage here used to be hidden by the macro expansion.

Fixes: 7353644fa9df ("powerpc/mm: Fix build break when PPC_NATIVE=n")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/mm/hash_utils_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 1ff11c1bb182..b78b5d211278 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -926,7 +926,7 @@ void __init hash__early_init_mmu(void)
 		ps3_early_mm_init();
 	else if (firmware_has_feature(FW_FEATURE_LPAR))
 		hpte_init_pseries();
-	else if IS_ENABLED(CONFIG_PPC_NATIVE)
+	else if (IS_ENABLED(CONFIG_PPC_NATIVE))
 		hpte_init_native();
 
 	if (!mmu_hash_ops.hpte_insert)
-- 
2.8.1

-- 
Cheers,
Stephen Rothwell
