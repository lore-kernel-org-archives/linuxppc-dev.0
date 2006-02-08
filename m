Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
	by ozlabs.org (Postfix) with ESMTP id 22C1268A87
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 16:47:45 +1100 (EST)
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by fgwmail8.fujitsu.co.jp (Fujitsu Gateway)
	with ESMTP id k185lhrs017527 for <linuxppc-dev@ozlabs.org>;
	Wed, 8 Feb 2006 14:47:43 +0900
	(envelope-from kamezawa.hiroyu@jp.fujitsu.com)
Message-ID: <43E9863C.1080700@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 14:48:44 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH] unify pfn_to_page take 2 [4/25] powerpc funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It looks powerpc doesn't have DISCONTIGMEM config.
Just replace FLATMEM ver.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-powerpc/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-powerpc/page.h
+++ test-layout-free-zone/include/asm-powerpc/page.h
@@ -69,8 +69,6 @@
  #endif

  #ifdef CONFIG_FLATMEM
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < max_mapnr)
  #endif
