Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BBBD7679E2
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 22:06:55 +1000 (EST)
Message-ID: <42A0DA75.3020008@am.sony.com>
Date: Fri, 03 Jun 2005 15:32:21 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <b69ad095ef9d42a1e25079a3dcf28be8@freescale.com>
In-Reply-To: <b69ad095ef9d42a1e25079a3dcf28be8@freescale.com>
Content-Type: multipart/mixed; boundary="------------040401020902020503030707"
Cc: "Levand, Geoffrey" <Geoffrey.Levand@am.sony.com>,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Fix PPC440 pagetable attributes
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040401020902020503030707
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Kumar Gala wrote:
> On Jun 3, 2005, at 11:30 AM, Geoff Levand wrote:
>>* With the PPC Book-E Linux implementation, 0-11th LSB of PTE stand 
>>for memory
>>* protection-related function. (See PTE structure in 
>>include/asm-ppc/mmu.h)
>>* Definition of _PAGE_XXX here stands for above bits. Note that those 
>>bits
>>* values are CPU dependent, not architecture.
> 
> 
> That's more reasonable, however I would make it say PPC 44x ... instead 
> of Book-E, the e500 is also a Book-E processor and if you notice if we 
> use a 64-bit PTE we end up using more than the 12 LSBs for PTE flags.
> 

OK, attached is an updated patch.

-Geoff


--------------040401020902020503030707
Content-Type: text/x-patch;
 name="ppc440-page-attrib-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc440-page-attrib-fix.patch"

This patch fixes a bug in the PPC440 pagetable attributes that breaks  
swap support.  It also adds some notes on the PPC440 attribute fields.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF

--

Index: linux-2.6.12-bhpm/include/asm-ppc/pgtable.h
===================================================================
--- linux-2.6.12-bhpm.orig/include/asm-ppc/pgtable.h	2005-06-03 13:25:11.000000000 -0700
+++ linux-2.6.12-bhpm/include/asm-ppc/pgtable.h	2005-06-03 15:27:12.000000000 -0700
@@ -202,20 +202,65 @@
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
+ * With the PPC 44x Linux implementation the 0-11th LSBs of the PTE are used 
+ * for memory protection related functions (see PTE structure in 
+ * include/asm-ppc/mmu.h).  The _PAGE_XXX definitions in this file map to the 
+ * above bits.  Note that the bit values are CPU specific, not architecture 
+ * specific.
+ * 
+ * The kernel PTE entry holds arch-dependent swp_entry structure under certain 
+ * situation. In other words, in such situation, some portion of the PTE bits 
+ * are used as swp_entry. In PPC implementation, 3-24th LSBs are shared with 
+ * swp_entry, however 0-2nd LSBs still hold protection values. 
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
-#define	_PAGE_RW	0x00000002		/* S: Write permission */
-#define	_PAGE_DIRTY	0x00000004		/* S: Page dirty */
+#define _PAGE_RW	0x00000002		/* S: Write permission */
+#define _PAGE_FILE	0x00000004		/* S: nonlinear file mapping */
 #define _PAGE_ACCESSED	0x00000008		/* S: Page referenced */
 #define _PAGE_HWWRITE	0x00000010		/* H: Dirty & RW */
 #define _PAGE_HWEXEC	0x00000020		/* H: Execute permission */
-#define	_PAGE_USER	0x00000040		/* S: User page */
-#define	_PAGE_ENDIAN	0x00000080		/* H: E bit */
-#define	_PAGE_GUARDED	0x00000100		/* H: G bit */
-#define	_PAGE_COHERENT	0x00000200		/* H: M bit */
-#define _PAGE_FILE	0x00000400		/* S: nonlinear file mapping */
-#define	_PAGE_NO_CACHE	0x00000400		/* H: I bit */
-#define	_PAGE_WRITETHRU	0x00000800		/* H: W bit */
+#define _PAGE_USER	0x00000040		/* S: User page */
+#define _PAGE_ENDIAN	0x00000080		/* H: E bit */
+#define _PAGE_GUARDED	0x00000100		/* H: G bit */
+#define _PAGE_DIRTY	0x00000200		/* S: Page dirty */
+#define _PAGE_NO_CACHE	0x00000400		/* H: I bit */
+#define _PAGE_WRITETHRU	0x00000800		/* H: W bit */
 
 /* TODO: Add large page lowmem mapping support */
 #define _PMD_PRESENT	0


--------------040401020902020503030707--
