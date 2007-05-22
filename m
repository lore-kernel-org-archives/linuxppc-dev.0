Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 03266DDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 16:25:57 +1000 (EST)
Subject: [PATCH] powerpc: Fix warning on 32 bits with CONFIG_HIGHMEM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 22 May 2007 16:25:51 +1000
Message-Id: <1179815151.32247.794.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some missing fixup for the removal of 4 level fixup header

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/mm/mem.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/mem.c	2007-05-22 16:00:57.000000000 +1000
+++ linux-work/arch/powerpc/mm/mem.c	2007-05-22 16:02:06.000000000 +1000
@@ -310,11 +310,12 @@ void __init paging_init(void)
 
 #ifdef CONFIG_HIGHMEM
 	map_page(PKMAP_BASE, 0, 0);	/* XXX gross */
-	pkmap_page_table = pte_offset_kernel(pmd_offset(pgd_offset_k
-			(PKMAP_BASE), PKMAP_BASE), PKMAP_BASE);
+	pkmap_page_table = pte_offset_kernel(pmd_offset(pud_offset(pgd_offset_k
+			(PKMAP_BASE), PKMAP_BASE), PKMAP_BASE), PKMAP_BASE);
 	map_page(KMAP_FIX_BEGIN, 0, 0);	/* XXX gross */
-	kmap_pte = pte_offset_kernel(pmd_offset(pgd_offset_k
-			(KMAP_FIX_BEGIN), KMAP_FIX_BEGIN), KMAP_FIX_BEGIN);
+	kmap_pte = pte_offset_kernel(pmd_offset(pud_offset(pgd_offset_k
+			(KMAP_FIX_BEGIN), KMAP_FIX_BEGIN), KMAP_FIX_BEGIN),
+			 KMAP_FIX_BEGIN);
 	kmap_prot = PAGE_KERNEL;
 #endif /* CONFIG_HIGHMEM */
 
