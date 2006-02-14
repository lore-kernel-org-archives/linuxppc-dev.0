Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id 55A8D679F5
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Feb 2006 21:42:46 +1100 (EST)
Message-ID: <43F1B458.9040201@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:43:36 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] unify pfn_to_page take3 [14/23] ppc pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PPC can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-ppc/page.h
===================================================================
--- testtree.orig/include/asm-ppc/page.h
+++ testtree/include/asm-ppc/page.h
@@ -149,8 +149,7 @@ extern int page_is_ram(unsigned long pfn
  #define __pa(x) ___pa((unsigned long)(x))
  #define __va(x) ((void *)(___va((unsigned long)(x))))

-#define pfn_to_page(pfn)	(mem_map + ((pfn) - PPC_PGSTART))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map) + PPC_PGSTART)
+#define ARCH_PFN_OFFSET		(PPC_PGSTART)
  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
  #define page_to_virt(page)	__va(page_to_pfn(page) << PAGE_SHIFT)

@@ -175,5 +174,6 @@ extern __inline__ int get_order(unsigned
  /* We do define AT_SYSINFO_EHDR but don't use the gate mecanism */
  #define __HAVE_ARCH_GATE_AREA		1

+#include <asm-generic/memory_model.h>
  #endif /* __KERNEL__ */
  #endif /* _PPC_PAGE_H */
