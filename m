Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18098.60156.745431.675803@cargo.ozlabs.ibm.com>
Date: Fri, 3 Aug 2007 18:44:44 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Expand RPN field to 34 bits when using 64k pages
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The real page number field in our PTEs when configured for 64kB pages
is currently 32 bits, which turns out to be not quite enough for the
resources that the eHCA driver wants to map.  This expands the RPN
field to include 2 adjacent, previously-unused bits.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/include/asm-powerpc/pgtable-64k.h b/include/asm-powerpc/pgtable-64k.h
index 31cbd3d..33ae901 100644
--- a/include/asm-powerpc/pgtable-64k.h
+++ b/include/asm-powerpc/pgtable-64k.h
@@ -49,12 +49,10 @@
 
 /* Shift to put page number into pte.
  *
- * That gives us a max RPN of 32 bits, which means a max of 48 bits
- * of addressable physical space.
- * We could get 3 more bits here by setting PTE_RPN_SHIFT to 29 but
- * 32 makes PTEs more readable for debugging for now :)
+ * That gives us a max RPN of 34 bits, which means a max of 50 bits
+ * of addressable physical space, or 46 bits for the special 4k PFNs.
  */
-#define PTE_RPN_SHIFT	(32)
+#define PTE_RPN_SHIFT	(30)
 #define PTE_RPN_MAX	(1UL << (64 - PTE_RPN_SHIFT))
 #define PTE_RPN_MASK	(~((1UL<<PTE_RPN_SHIFT)-1))
 
