Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86320686BB
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Nov 2005 16:27:46 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 16:25:28 +1100
Message-Id: <1131341128.11406.17.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ppc: Fix ppc32 build after 64K pages
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Oops, some last minute changes caused the 64K pages patch to break ppc32 build,
this fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/Kconfig	2005-11-07 15:10:26.000000000 +1100
+++ linux-work/arch/powerpc/Kconfig	2005-11-07 15:42:06.000000000 +1100
@@ -605,6 +605,7 @@
 
 config PPC_64K_PAGES
 	bool "64k page size"
+	depends on PPC64
 	help
 	  This option changes the kernel logical page size to 64k. On machines
           without processor support for 64k pages, the kernel will simulate
Index: linux-work/arch/powerpc/mm/ppc_mmu_32.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/ppc_mmu_32.c	2005-11-07 15:10:26.000000000 +1100
+++ linux-work/arch/powerpc/mm/ppc_mmu_32.c	2005-11-07 15:43:08.000000000 +1100
@@ -188,9 +188,9 @@
 
 	if (Hash == 0)
 		return;
-	pmd = pmd_offset(pgd_offset(vma->vm_mm, address), address);
+	pmd = pmd_offset(pgd_offset(mm, ea), ea);
 	if (!pmd_none(*pmd))
-		add_hash_page(vma->vm_mm->context, address, pmd_val(*pmd));
+		add_hash_page(mm->context, ea, pmd_val(*pmd));
 }
 
 /*
