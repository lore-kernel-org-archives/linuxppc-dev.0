Date: Tue, 25 May 2004 02:29:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH 7/7] use pfn_to_page
Message-ID: <Pine.LNX.4.58.0405250229230.19052@scrub.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


pfn_to_page() does the same, but also takes care of the memory start
if necessary.

Index: 2.6/include/asm-ppc/pgtable.h
diff -u 2.6/include/asm-ppc/pgtable.h:1.1.1.3 2.6/include/asm-ppc/pgtable.h:1.4
--- 2.6/include/asm-ppc/pgtable.h:1.1.1.3	Sat Feb 21 12:45:22 2004
+++ 2.6/include/asm-ppc/pgtable.h	Sat Feb 21 13:42:00 2004
@@ -566,7 +566,7 @@
 #define pmd_page_kernel(pmd)	\
 	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 #define pmd_page(pmd)		\
-	(mem_map + (pmd_val(pmd) >> PAGE_SHIFT))
+	pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
 #else
 #define pmd_page_kernel(pmd)	\
 	((unsigned long) (pmd_val(pmd) & PAGE_MASK))

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
