Return-Path: <paulus@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3DB11A08CE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 17:13:15 +1100 (AEDT)
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [RFC PATCH 5/9] powerpc/mm/book3s-64: Move _PAGE_PTE to 2nd most
 significant bit
Date: Sat, 20 Feb 2016 17:12:36 +1100
Message-Id: <1455948760-24710-6-git-send-email-paulus@samba.org>
In-Reply-To: <1455948760-24710-1-git-send-email-paulus@samba.org>
References: <1455948760-24710-1-git-send-email-paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This changes _PAGE_PTE for 64-bit Book 3S processors from 0x1 to
0x4000_0000_0000_0000, because that bit is used as the L (leaf)
bit by PowerISA v3.0 CPUs in radix mode.  The "leaf" bit indicates
that the PTE points to a page directly rather than another radix
level, which is what the _PAGE_PTE bit means.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/book3s/64/hash.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 72ea557..8f077c1 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -13,7 +13,6 @@
  * We could create separate kernel read-only if we used the 3 PP bits
  * combinations that newer processors provide but we currently don't.
  */
-#define _PAGE_PTE		0x00001	/* distinguishes PTEs from pointers */
 #define _PAGE_BIT_SWAP_TYPE	2
 #define _PAGE_USER		0x00004 /* page may be accessed by userspace */
 #define _PAGE_EXEC		0x00008 /* execute permission */
@@ -38,6 +37,7 @@
 #define _PAGE_SOFT_DIRTY	0x00000
 #endif
 
+#define _PAGE_PTE		(1ul << 62)	/* distinguishes PTEs from pointers */
 #define _PAGE_PRESENT		(1ul << 63)	/* pte contains a translation */
 
 /*
-- 
2.5.0
