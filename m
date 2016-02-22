Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D18B01A042E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 13:41:30 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 8/9] powerpc/mm/book3s-64: Move software-used bits in PTE
Date: Mon, 22 Feb 2016 13:41:19 +1100
Message-Id: <1456108880-27464-9-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1456108880-27464-1-git-send-email-paulus@ozlabs.org>
References: <1456108880-27464-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>

This moves the _PAGE_SPECIAL and _PAGE_SOFT_DIRTY bits in the Linux
PTE on 64-bit Book 3S systems to bit positions which are designated
for software use in the radix PTE format used by PowerISA v3.0 CPUs
in radix mode.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/book3s/64/hash.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index cd4bf95..ef9bd68 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -26,13 +26,13 @@
 #define _PAGE_WRITETHRU		0x00040 /* W: cache write-through */
 #define _PAGE_DIRTY		0x00080 /* C: page changed */
 #define _PAGE_ACCESSED		0x00100 /* R: page referenced */
+#define _PAGE_SPECIAL		0x00400 /* software: special page */
 #define _PAGE_BUSY		0x00800 /* software: PTE & hash are busy */
-#define _PAGE_SPECIAL		0x10000 /* software: special page */
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
-#define _PAGE_SOFT_DIRTY	0x20000 /* software: software dirty tracking */
+#define _PAGE_SOFT_DIRTY	0x200 /* software: software dirty tracking */
 #else
-#define _PAGE_SOFT_DIRTY	0x00000
+#define _PAGE_SOFT_DIRTY	0x000
 #endif
 
 #define _PAGE_F_GIX_SHIFT	57
-- 
2.6.4
