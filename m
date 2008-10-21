Return-Path: <dgibson@ozlabs.org>
Date: Tue, 21 Oct 2008 14:55:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Further compile fixup for STRICT_MM_TYPECHECKS
Message-ID: <20081021035529.GA4358@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A patch of mine was recently committed to fix up STRICT_MM_TYPECHECKS
behaviour on powerpc (f5ea64dcbad89875d130596df14c9b25d994a737).
However, something which breaks it again seems to have slipped in
afterwards.  So, here's another small fix.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/kernel/pci-common.c
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/pci-common.c	2008-10-21 13:53:29.000000000 +1100
+++ working-2.6/arch/powerpc/kernel/pci-common.c	2008-10-21 13:53:52.000000000 +1100
@@ -610,7 +610,8 @@ int pci_mmap_legacy_page_range(struct pc
 	pr_debug(" -> mapping phys %llx\n", (unsigned long long)offset);
 
 	vma->vm_pgoff = offset >> PAGE_SHIFT;
-	vma->vm_page_prot |= _PAGE_NO_CACHE | _PAGE_GUARDED;
+	vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
+				     | _PAGE_NO_CACHE | _PAGE_GUARDED);
 	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			       vma->vm_end - vma->vm_start,
 			       vma->vm_page_prot);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
