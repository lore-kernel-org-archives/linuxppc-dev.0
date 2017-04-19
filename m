Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MSv2l83zDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 22:56:31 +1000 (AEST)
Message-Id: <22c2ebcfe72f4f17be6d284d922895cec34e23fc.1492606297.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1492606297.git.christophe.leroy@c-s.fr>
References: <cover.1492606297.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/5] powerpc/mm: only call store_updates_sp() on stores in
 do_page_fault()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 19 Apr 2017 14:56:24 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Function store_updates_sp() checks whether the faulting
instruction is a store updating r1. Therefore we can limit its calls
to stores exceptions.

This patch is an improvement of commit a7a9dcd882a67 ("powerpc: Avoid
taking a data miss on every userspace instruction miss")

With the same microbenchmark app, run with 500 as argument, on an
MPC885 we get:

Before this patch: 152000 DTLB misses
After this patch:  147000 DTLB misses

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 3a7d580fdc59..67fefb59d40e 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -287,7 +287,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * can result in fault, which will cause a deadlock when called with
 	 * mmap_sem held
 	 */
-	if (!is_exec && user_mode(regs))
+	if (is_write && user_mode(regs))
 		store_update_sp = store_updates_sp(regs);
 
 	if (user_mode(regs))
-- 
2.12.0
