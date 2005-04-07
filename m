Return-Path: <galak@freescale.com>
Date: Thu, 7 Apr 2005 14:07:48 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0504071341260.5277@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix pte_update for 64-bit PTEs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew,

(this should probably go in for 2.6.12)

While the existing pte_update code handled atomically modifying a 64-bit 
PTE, it did not return all 64-bits of the PTE before it was modified.  
This causes problems in some places that expect the full PTE to be 
returned, like ptep_get_and_clear().

Created a new pte_update function that is conditional on CONFIG_PTE_64BIT. 
It atomically reads the low PTE word which all PTE flags are required to 
be in and returns a premodified full 64-bit PTE.

Since we now have an explicit 64-bit PTE version of pte_update we can also 
remove the hack that existed to get the low PTE word regardless of size.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
--- a/include/asm-ppc/pgtable.h	2005-04-07 14:01:09 -05:00
+++ b/include/asm-ppc/pgtable.h	2005-04-07 14:01:09 -05:00
@@ -526,10 +526,10 @@
  * Atomic PTE updates.
  *
  * pte_update clears and sets bit atomically, and returns
- * the old pte value.
- * The ((unsigned long)(p+1) - 4) hack is to get to the least-significant
- * 32 bits of the PTE regardless of whether PTEs are 32 or 64 bits.
+ * the old pte value.  In the 64-bit PTE case we lock around the
+ * low PTE word since we expect ALL flag bits to be there
  */
+#ifndef CONFIG_PTE_64BIT
 static inline unsigned long pte_update(pte_t *p, unsigned long clr,
 				       unsigned long set)
 {
@@ -543,10 +543,31 @@
 "	stwcx.	%1,0,%3\n\
 	bne-	1b"
 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
-	: "r" ((unsigned long)(p+1) - 4), "r" (clr), "r" (set), "m" (*p)
+	: "r" (p), "r" (clr), "r" (set), "m" (*p)
 	: "cc" );
 	return old;
 }
+#else
+static inline unsigned long long pte_update(pte_t *p, unsigned long clr,
+				       unsigned long set)
+{
+	unsigned long long old;
+	unsigned long tmp;
+
+	__asm__ __volatile__("\
+1:	lwarx	%L0,0,%4\n\
+	lwzx	%0,0,%3\n\
+	andc	%1,%L0,%5\n\
+	or	%1,%1,%6\n"
+	PPC405_ERR77(0,%3)
+"	stwcx.	%1,0,%4\n\
+	bne-	1b"
+	: "=&r" (old), "=&r" (tmp), "=m" (*p)
+	: "r" (p), "r" ((unsigned long)(p) + 4), "r" (clr), "r" (set), "m" (*p)
+	: "cc" );
+	return old;
+}
+#endif
 
 /*
  * set_pte stores a linux PTE into the linux page table.
