Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405sLk6jZ3zF1pg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 01:17:02 +1100 (AEDT)
Message-Id: <7c34db8eca67beefa7ec8243bc07135b4dff4440.1521641523.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 1/2] powerpc/mm: Add missing tracepoint for tlbie
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Balbir Singh <bsingharora@gmail.com>
Date: Wed, 21 Mar 2018 15:16:58 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 0428491cba927 ("powerpc/mm: Trace tlbie(l) instructions")
added tracepoints for tlbie calls, but _tlbil_va() was forgotten

Fixes: 0428491cba927 ("powerpc/mm: Trace tlbie(l) instructions")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/mmu_decl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 57fbc554c785..107033cc4dcf 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -23,6 +23,7 @@
 #include <asm/mmu.h>
 
 #ifdef CONFIG_PPC_MMU_NOHASH
+#include <asm/trace.h>
 
 /*
  * On 40x and 8xx, we directly inline tlbia and tlbivax
@@ -56,6 +57,7 @@ static inline void _tlbil_va(unsigned long address, unsigned int pid,
 			     unsigned int tsize, unsigned int ind)
 {
 	asm volatile ("tlbie %0; sync" : : "r" (address) : "memory");
+	trace_tlbie(0, 0, address, pid, 0, 0, 0);
 }
 #elif defined(CONFIG_PPC_BOOK3E)
 extern void _tlbil_va(unsigned long address, unsigned int pid,
-- 
2.13.3
