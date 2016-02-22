Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C5CF41A03DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 13:41:30 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 7/9] powerpc/mm/book3s-64: Shuffle read, write,
 execute and user bits in PTE
Date: Mon, 22 Feb 2016 13:41:18 +1100
Message-Id: <1456108880-27464-8-git-send-email-paulus@ozlabs.org>
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

This moves the _PAGE_EXEC, _PAGE_RW and _PAGE_USER bits around in
the Linux PTE on 64-bit Book 3S systems to correspond with the bit
positions used in radix mode by PowerISA v3.0 CPUs.  This also adds
a _PAGE_READ bit corresponding to the read permission bit in the
radix PTE.  _PAGE_READ is currently unused but could possibly be used
in future to improve pte_protnone().

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/book3s/64/hash.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index a59cfae..cd4bf95 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -13,9 +13,12 @@
  * We could create separate kernel read-only if we used the 3 PP bits
  * combinations that newer processors provide but we currently don't.
  */
-#define _PAGE_BIT_SWAP_TYPE	2
-#define _PAGE_USER		0x00004 /* page may be accessed by userspace */
-#define _PAGE_EXEC		0x00008 /* execute permission */
+#define _PAGE_BIT_SWAP_TYPE	0
+
+#define _PAGE_EXEC		0x00001 /* execute permission */
+#define _PAGE_RW		0x00002 /* read & write access allowed */
+#define _PAGE_READ		0x00004	/* read access allowed */
+#define _PAGE_USER		0x00008 /* page may be accessed by userspace */
 #define _PAGE_GUARDED		0x00010 /* G: guarded (side-effect) page */
 /* M (memory coherence) is always set in the HPTE, so we don't need it here */
 #define _PAGE_COHERENT		0x0
@@ -23,7 +26,6 @@
 #define _PAGE_WRITETHRU		0x00040 /* W: cache write-through */
 #define _PAGE_DIRTY		0x00080 /* C: page changed */
 #define _PAGE_ACCESSED		0x00100 /* R: page referenced */
-#define _PAGE_RW		0x00200 /* software: user write access allowed */
 #define _PAGE_BUSY		0x00800 /* software: PTE & hash are busy */
 #define _PAGE_SPECIAL		0x10000 /* software: special page */
 
-- 
2.6.4
