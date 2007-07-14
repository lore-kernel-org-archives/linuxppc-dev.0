Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts36-srv.bellnexxia.net (tomts36.bellnexxia.net
	[209.226.175.93]) by ozlabs.org (Postfix) with ESMTP id 1E30CDDDD8
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 11:20:35 +1000 (EST)
Received: from krystal.dyndns.org ([76.65.106.98])
	by tomts36-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070714012033.KFAX1657.tomts36-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 21:20:33 -0400
Date: Fri, 13 Jul 2007 21:20:33 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Powerpc - Include pagemap.h in asm/powerpc/tlb.h
Message-ID: <20070714012033.GC31649@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Powerpc - Include pagemap.h in asm/powerpc/tlb.h

Fixes this powerpc build error in 2.6.22-rc6-mm1 for powerpc 64 :

In file included from include2/asm/tlb.h:60,
                 from /home/compudj/git/linux-2.6-lttng/arch/powerpc/mm/init_64.
c:56:
/home/compudj/git/linux-2.6-lttng/include/asm-generic/tlb.h: In function 'tlb_fl
ush_mmu':
/home/compudj/git/linux-2.6-lttng/include/asm-generic/tlb.h:76: error: implicit 
declaration of function 'release_pages'
/home/compudj/git/linux-2.6-lttng/include/asm-generic/tlb.h: In function 'tlb_re
move_page':
/home/compudj/git/linux-2.6-lttng/include/asm-generic/tlb.h:105: error: implicit
 declaration of function 'page_cache_release'
make[2]: *** [arch/powerpc/mm/init_64.o] Error 1

release_pages is declared in linux/pagemap.h, but cannot be included in
linux/swap.h because of a sparc related comment:

/* only sparc can not include linux/pagemap.h in this file
 * so leave page_cache_release and release_pages undeclared... */
#define free_page_and_swap_cache(page) \
        page_cache_release(page)
#define free_pages_and_swap_cache(pages, nr) \
        release_pages((pages), (nr), 0);

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: linuxppc-dev@ozlabs.org
CC: Paul Mackerras <paulus@samba.org>
---
 include/asm-powerpc/tlb.h |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6-lttng/include/asm-powerpc/tlb.h
===================================================================
--- linux-2.6-lttng.orig/include/asm-powerpc/tlb.h	2007-07-13 11:30:54.000000000 -0400
+++ linux-2.6-lttng/include/asm-powerpc/tlb.h	2007-07-13 11:31:22.000000000 -0400
@@ -23,6 +23,8 @@
 #include <asm/mmu.h>
 #endif
 
+#include <linux/pagemap.h>
+
 struct mmu_gather;
 
 #define tlb_start_vma(tlb, vma)	do { } while (0)
-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
