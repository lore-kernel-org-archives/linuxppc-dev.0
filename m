Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id 5B89167E4A
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Aug 2005 08:45:09 +1000 (EST)
Date: Fri, 5 Aug 2005 15:45:05 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20050805154505.A10842@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: fix ppc440 pagetable attributes
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch fixes a bug in the PPC440 pagetable attributes that breaks  
swap support.  It also adds some notes on the PPC440 attribute fields.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

Index: linux-2.6.12-bhpm/include/asm-ppc/pgtable.h
===================================================================
--- linux-2.6.12-bhpm.orig/include/asm-ppc/pgtable.h	2005-06-02 15:09:24.000000000 -0700
+++ linux-2.6.12-bhpm/include/asm-ppc/pgtable.h	2005-06-02 15:47:53.000000000 -0700
@@ -202,18 +202,64 @@
  *
  * Note that these bits preclude future use of a page size
  * less than 4KB.
+ *
+ *
+ * PPC 440 core has following TLB attribute fields;
+ *
+ *   TLB1:
+ *   0  1  2  3  4  ... 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
+ *   RPN.................................  -  -  -  -  -  - ERPN.......
+ *
+ *   TLB2:
+ *   0  1  2  3  4  ... 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
+ *   -  -  -  -  -    - U0 U1 U2 U3 W  I  M  G  E   - UX UW UR SX SW SR
+ *
+ * There are some constrains and options, to decide mapping software bits
+ * into TLB entry.
+ *
+ *   - PRESENT *must* be in the bottom three bits because swap cache
+ *     entries use the top 29 bits for TLB2.
+ *
+ *   - FILE *must* be in the bottom three bits because swap cache
+ *     entries use the top 29 bits for TLB2.
+ *
+ *   - CACHE COHERENT bit (M) has no effect on PPC440 core, because it
+ *     doesn't support SMP. So we can use this as software bit, like
+ *     DIRTY.
+ *
+ * PPC Book-E Linux implementation uses PPC HW PTE bit field definition, 
+ * even it doesn't have HW PTE. 0-11th LSB of PTE stand for memory 
+ * protection-related function. (See PTE structure in include/asm-ppc/mmu.h) 
+ * Definition of _PAGE_XXX in "include/asm-ppc/pagetable.h" stands for 
+ * above bits. Note that those bits values are CPU dependent, not 
+ * architecture.
+ * 
+ * Kernel PTE entry holds arch-dependent swp_entry structure under certain 
+ * situation. In other words, in such situation, some portion of PTE bits 
+ * are used as swp_entry. In PPC implementation, 3-24th LSB are shared with 
+ * swp_entry, however 0-2nd three LSB still hold protection values. 
+ * That means three protection bits are reserved for both PTE and SWAP 
+ * entry at the most three LSBs.
+ *
+ * There are three protection bits available for SWAP entry;
+ *	_PAGE_PRESENT
+ *	_PAGE_FILE
+ *	_PAGE_HASHPTE (if HW has)
+ *
+ * So those three bits have to be inside of 0-2nd LSB of PTE.
+ *
  */
+
 #define _PAGE_PRESENT	0x00000001		/* S: PTE valid */
 #define	_PAGE_RW	0x00000002		/* S: Write permission */
-#define	_PAGE_DIRTY	0x00000004		/* S: Page dirty */
+#define _PAGE_FILE	0x00000004		/* S: nonlinear file mapping */
 #define _PAGE_ACCESSED	0x00000008		/* S: Page referenced */
 #define _PAGE_HWWRITE	0x00000010		/* H: Dirty & RW */
 #define _PAGE_HWEXEC	0x00000020		/* H: Execute permission */
 #define	_PAGE_USER	0x00000040		/* S: User page */
 #define	_PAGE_ENDIAN	0x00000080		/* H: E bit */
 #define	_PAGE_GUARDED	0x00000100		/* H: G bit */
-#define	_PAGE_COHERENT	0x00000200		/* H: M bit */
-#define _PAGE_FILE	0x00000400		/* S: nonlinear file mapping */
+#define	_PAGE_DIRTY	0x00000200		/* S: Page dirty */
 #define	_PAGE_NO_CACHE	0x00000400		/* H: I bit */
 #define	_PAGE_WRITETHRU	0x00000800		/* H: W bit */
