Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 994D6B71B1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 13:49:44 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF097DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 13:49:43 +1000 (EST)
Subject: mm: Move pgtable_cache_init() earlier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 17 Jun 2009 13:48:39 +1000
Message-Id: <1245210519.21602.16.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-mm <linux-mm@kvack.org>,
	"David S. Miller" <davem@davemloft.net>, Chris Zankel <chris@zankel.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some architectures need to initialize SLAB caches to be able
to allocate page tables. They do that from pgtable_cache_init()
so the later should be called earlier now, best is before
vmalloc_init().

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Note: Only powerpc, sparc and xtensa use this and only to
call kmem_cache_create() so with a bit of luck it should
just work... 

Index: linux-work/init/main.c
===================================================================
--- linux-work.orig/init/main.c	2009-06-17 13:41:33.000000000 +1000
+++ linux-work/init/main.c	2009-06-17 13:41:45.000000000 +1000
@@ -546,6 +546,7 @@ static void __init mm_init(void)
 	page_cgroup_init_flatmem();
 	mem_init();
 	kmem_cache_init();
+	pgtable_cache_init();
 	vmalloc_init();
 }
 
@@ -684,7 +685,6 @@ asmlinkage void __init start_kernel(void
 		late_time_init();
 	calibrate_delay();
 	pidmap_init();
-	pgtable_cache_init();
 	anon_vma_init();
 #ifdef CONFIG_X86
 	if (efi_enabled)
