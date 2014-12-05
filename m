Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 8B4D31A0BBF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 22:20:28 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Subject: [PATCH] powerpc32: fix warning from include/linux/mm.h
Message-Id: <20141205112020.640FA1A5D4F@localhost.localdomain>
Date: Fri,  5 Dec 2014 12:20:20 +0100 (CET)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

include/linux/mm.h: In function 'is_vmalloc_addr':
include/linux/mm.h:367:14: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  return addr >= VMALLOC_START && addr < VMALLOC_END;
              ^

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 arch/powerpc/include/asm/pgtable-ppc32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index 234e07c..543bb8e 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -92,7 +92,7 @@ extern int icache_44x_need_flush;
  * system.  This really does become a problem for machines with good amounts
  * of RAM.  -- Cort
  */
-#define VMALLOC_OFFSET (0x1000000) /* 16M */
+#define VMALLOC_OFFSET (0x1000000U) /* 16M */
 #ifdef PPC_PIN_SIZE
 #define VMALLOC_START (((_ALIGN((long)high_memory, PPC_PIN_SIZE) + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
 #else
-- 
2.1.0
