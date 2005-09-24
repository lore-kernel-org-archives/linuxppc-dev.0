Return-Path: <zippel@linux-m68k.org>
Received: from scrub.xs4all.nl (scrub.xs4all.nl [194.109.195.176])
	by ozlabs.org (Postfix) with ESMTP id 2FB0C683DB
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Sep 2005 08:44:38 +1000 (EST)
Received: from roman (helo=localhost)
	by scrub.xs4all.nl with local-esmtp (Exim 3.36 #1 (Debian))
	id 1EJIl2-0004zR-00
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Sep 2005 00:44:36 +0200
Date: Sun, 25 Sep 2005 00:44:36 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.61.0509250044240.19184@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [PATCH 7/8] apus: use pfn_to_page() for pmd_page()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


pfn_to_page() does the same, but also takes care of the memory start if
necessary.

---

 include/asm-ppc/pgtable.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/include/asm-ppc/pgtable.h
===================================================================
--- linux.orig/include/asm-ppc/pgtable.h	2005-09-23 16:19:20.000000000 +0200
+++ linux/include/asm-ppc/pgtable.h	2005-09-23 16:20:31.000000000 +0200
@@ -723,7 +723,7 @@ extern pgprot_t phys_mem_access_prot(str
 #define pmd_page_kernel(pmd)	\
 	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 #define pmd_page(pmd)		\
-	(mem_map + (pmd_val(pmd) >> PAGE_SHIFT))
+	pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
 #else
 #define pmd_page_kernel(pmd)	\
 	((unsigned long) (pmd_val(pmd) & PAGE_MASK))
