Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by ozlabs.org (Postfix) with ESMTP id A4A0E68A78
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 17:18:07 +1100 (EST)
Message-ID: <43E98D7B.2000401@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 15:19:39 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] unify pfn_to_page take 2 [17/25] ppc funcs
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

ppc can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-ppc/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-ppc/page.h
+++ test-layout-free-zone/include/asm-ppc/page.h
@@ -148,9 +148,7 @@ extern int page_is_ram(unsigned long pfn

  #define __pa(x) ___pa((unsigned long)(x))
  #define __va(x) ((void *)(___va((unsigned long)(x))))
-
-#define pfn_to_page(pfn)	(mem_map + ((pfn) - PPC_PGSTART))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map) + PPC_PGSTART)
+#define ARCH_PFN_OFFSET		PPC_PGSTART
  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
  #define page_to_virt(page)	__va(page_to_pfn(page) << PAGE_SHIFT)
