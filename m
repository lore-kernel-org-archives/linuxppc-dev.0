Return-Path: <chunkeey@googlemail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1r2v2XY4zDsPK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 05:03:50 +1000 (AEST)
Received: by mail-wr0-x242.google.com with SMTP id p37so3019718wrb.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 12:03:50 -0700 (PDT)
From: Christian Lamparter <chunkeey@googlemail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: fix compile error on 64K pages on 40x, 44x
Date: Tue, 26 Sep 2017 21:03:45 +0200
Message-Id: <20170926190345.2341-1-chunkeey@googlemail.com>
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

This patch fixes the issue by adding additional guard
conditions, that limit the initialization to just
platforms that define the pte_frag variable in the
mmu context.

Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
 arch/powerpc/kernel/setup-common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 0ac741fae90e..436d42a7d761 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -904,7 +904,9 @@ void __init setup_arch(char **cmdline_p)
 #endif
 #endif
 
-#ifdef CONFIG_PPC_64K_PAGES
+#if defined(CONFIG_PPC_64K_PAGES) && \
+    defined(CONFIG_PPC_BOOK3S_64) && \
+    defined(CONFIG_PPC_BOOK3E_MMU)
 	init_mm.context.pte_frag = NULL;
 #endif
 #ifdef CONFIG_SPAPR_TCE_IOMMU
-- 
2.14.2
