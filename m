Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 2A3091A03AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 20:06:47 +1000 (AEST)
Message-Id: <c892c744ca721a773c3663ed1f0b2157a4f73aeb.1429696335.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1429696335.git.christophe.leroy@c-s.fr>
References: <cover.1429696335.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/3] powerpc/8xx: mark _PAGE_SHARED all types of kernel pages
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Wed, 22 Apr 2015 12:06:41 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All kernel pages have to be marked as shared in order to not perform
CASID verification.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/pte-8xx.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pte-8xx.h b/arch/powerpc/include/asm/pte-8xx.h
index eb6edb4..c8aacad 100644
--- a/arch/powerpc/include/asm/pte-8xx.h
+++ b/arch/powerpc/include/asm/pte-8xx.h
@@ -63,7 +63,12 @@
 
 /* We need to add _PAGE_SHARED to kernel pages */
 #define _PAGE_KERNEL_RO	(_PAGE_SHARED | _PAGE_RO | _PAGE_KNLRO)
-#define _PAGE_KERNEL_ROX	(_PAGE_EXEC | _PAGE_RO | _PAGE_KNLRO)
+#define _PAGE_KERNEL_ROX	(_PAGE_SHARED | _PAGE_RO | _PAGE_KNLRO | \
+				 _PAGE_EXEC)
+#define _PAGE_KERNEL_RW		(_PAGE_SHARED | _PAGE_DIRTY | _PAGE_RW | \
+				 _PAGE_HWWRITE)
+#define _PAGE_KERNEL_RWX	(_PAGE_SHARED | _PAGE_DIRTY | _PAGE_RW | \
+				 _PAGE_HWWRITE | _PAGE_EXEC)
 
 #endif /* __KERNEL__ */
 #endif /*  _ASM_POWERPC_PTE_8xx_H */
-- 
2.1.0
