Date: Fri, 11 Jul 2003 01:35:30 -0500 (CDT)
Message-Id: <200307110635.h6B6ZUWs095337@sullivan.realtime.net>
To: linuxppc-dev@lists.linuxppc.org
From: Milton Miller <miltonm@bga.com>
Subject: [PATCH] include for CONFIG_SWAP=n
Cc: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


With CONFIG_SWAP=n, I get

In file included from include/asm/tlb.h:28,
                 from arch/ppc/mm/tlb.c:32:
include/asm-generic/tlb.h: In function `tlb_flush_mmu':
include/asm-generic/tlb.h:76: warning: implicit declaration of function `release_pages'
include/asm-generic/tlb.h: In function `tlb_remove_page':
include/asm-generic/tlb.h:111: warning: implicit declaration of function `page_cache_release'

One can argue for putting this somewhere generic, but I took the easy approach.

===== arch/ppc/mm/tlb.c 1.8 vs edited =====
--- 1.8/arch/ppc/mm/tlb.c	Wed Jan  8 14:37:27 2003
+++ edited/arch/ppc/mm/tlb.c	Fri Jul 11 01:16:55 2003
@@ -28,6 +28,7 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
+#include <linux/pagemap.h>
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
