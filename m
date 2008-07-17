Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8E5F2DDF5E
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 20:44:33 +1000 (EST)
Date: Thu, 17 Jul 2008 12:44:26 +0200
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [patch] powerpc: implement pte_special for 64K pages
Message-ID: <20080717104426.GA25083@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This can be folded into powerpc-implement-pte_special.patch

--
Ben has now freed up a pte bit on 64k pages. Use it for special pte bit.

Signed-off-by: Nick Piggin <npiggin@suse.de>
---

Index: linux-2.6/include/asm-powerpc/pgtable-64k.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/pgtable-64k.h	2008-07-17 18:53:03.000000000 +1000
+++ linux-2.6/include/asm-powerpc/pgtable-64k.h	2008-07-17 20:30:06.000000000 +1000
@@ -70,11 +70,12 @@
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
 /* Additional PTE bits (don't change without checking asm in hash_low.S) */
+#define __HAVE_ARCH_PTE_SPECIAL
+#define _PAGE_SPECIAL	0x00000400 /* software: special page */
 #define _PAGE_HPTE_SUB	0x0ffff000 /* combo only: sub pages HPTE bits */
 #define _PAGE_HPTE_SUB0	0x08000000 /* combo only: first sub page */
 #define _PAGE_COMBO	0x10000000 /* this is a combo 4k page */
 #define _PAGE_4K_PFN	0x20000000 /* PFN is for a single 4k page */
-#define _PAGE_SPECIAL	0x0	   /* don't have enough room for this yet */
 
 /* For 64K page, we don't have a separate _PAGE_HASHPTE bit. Instead,
  * we set that to be the whole sub-bits mask. The C code will only
