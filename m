Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by ozlabs.org (Postfix) with ESMTP id BAAC2679EA
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Feb 2006 21:01:12 +1100 (EST)
Message-ID: <43F1AAB5.8050202@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:02:29 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] unify pfn_to_page take3 [4/23] powerpc pfn_to_page
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

PowerPC can use generic ones.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-powerpc/page.h
===================================================================
--- testtree.orig/include/asm-powerpc/page.h
+++ testtree/include/asm-powerpc/page.h
@@ -69,8 +69,6 @@
  #endif

  #ifdef CONFIG_FLATMEM
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < max_mapnr)
  #endif

@@ -200,6 +198,7 @@ extern void copy_user_page(void *to, voi
  		struct page *p);
  extern int page_is_ram(unsigned long pfn);

+#include <asm-generic/memory_model.h>
  #endif /* __ASSEMBLY__ */

  #endif /* __KERNEL__ */
