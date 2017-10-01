Return-Path: <chunkeey@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y4npH0LT8zDqR8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Oct 2017 01:33:10 +1100 (AEDT)
Received: by mail-wm0-x244.google.com with SMTP id q124so6405946wmb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Oct 2017 07:33:10 -0700 (PDT)
From: Christian Lamparter <chunkeey@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3] powerpc: fix compile error on 64K pages on 40x, 44x
Date: Sun,  1 Oct 2017 16:33:03 +0200
Message-Id: <20171001143303.15671-1-chunkeey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mmu context on the 40x, 44x does not define pte_frag
entry. This causes gcc abort the compilation due to:

setup-common.c: In function ‘setup_arch’:
setup-common.c:908: error: ‘mm_context_t’ has no ‘pte_frag’

This patch fixes the issue by removing the pte_frag
initialization in setup-common.c.

This is possible, because the compiler will do the
initialization, since the mm_context is a sub struct of
init_mm. init_mm is declared in mm_types.h as external linkage.
according to C99 6.2.4.3:
"An object whose identifier is declared with external linkage
[...] has static storage duration."

C99 defines in 6.7.8.10 that: "
If an object that has static storage duration is not
initialized explicitly, then:
- if it has pointer type, it is initialized to a null pointer
[...]
"

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 arch/powerpc/kernel/setup-common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 0ac741fae90e..2e3bc16d02b2 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -904,9 +904,6 @@ void __init setup_arch(char **cmdline_p)
 #endif
 #endif
 
-#ifdef CONFIG_PPC_64K_PAGES
-	init_mm.context.pte_frag = NULL;
-#endif
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	mm_iommu_init(&init_mm);
 #endif
-- 
2.14.2
