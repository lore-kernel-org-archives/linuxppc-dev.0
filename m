Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDym6WTVzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 70/70] powerpc/mm/radix: Document software bits for radix
Date: Fri, 29 Apr 2016 23:26:33 +1000
Message-Id: <1461936393-10131-70-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Add #defines for Power ISA 3.0 software defined bits.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 898222ae7b82..48dc76c13094 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -20,12 +20,16 @@
 /*
  * Software bits
  */
+#define _RPAGE_SW0		0x2000000000000000UL
+#define _RPAGE_SW1		0x00800
+#define _RPAGE_SW2		0x00400
+#define _RPAGE_SW3		0x00200
 #ifdef CONFIG_MEM_SOFT_DIRTY
-#define _PAGE_SOFT_DIRTY	0x00200 /* software: software dirty tracking */
+#define _PAGE_SOFT_DIRTY	_RPAGE_SW3 /* software: software dirty tracking */
 #else
 #define _PAGE_SOFT_DIRTY	0x00000
 #endif
-#define _PAGE_SPECIAL		0x00400 /* software: special page */
+#define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
 
 
 #define _PAGE_PTE		(1ul << 62)	/* distinguishes PTEs from pointers */
-- 
2.5.0
