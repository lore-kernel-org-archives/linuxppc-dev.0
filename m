Return-Path: <Yanjiang.Jin@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D9941A006F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 19:07:37 +1100 (AEDT)
From: <yanjiang.jin@windriver.com>
To: <mpe@ellerman.id.au>
Subject: [PATCH] ppc: mm: free memory after creating kmem cache
Date: Fri, 27 Feb 2015 13:30:34 +0800
Message-ID: <1425015034-26419-1-git-send-email-yanjiang.jin@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: jinyanjiang@gmail.com, linuxppc-dev@lists.ozlabs.org,
 yanjiang.jin@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Yanjiang Jin <yanjiang.jin@windriver.com>

kmem_cache_create()->kmem_cache_create_memcg()->kstrdup() allocates new space
and copy name's content, so it is safe to free name memory after
calling kmem_cache_create(). Else kmemleak would report the below warning:

unreferenced object 0xc0000000f9002160 (size 16):
  comm "swapper/0", pid 0, jiffies 4294892296 (age 1386.640s)
  hex dump (first 16 bytes):
    70 67 74 61 62 6c 65 2d 32 5e 39 00 de ad be ef  pgtable-2^9.....
  backtrace:
    [<c0000000004e03ec>] .kvasprintf+0x5c/0xa0
    [<c0000000004e045c>] .kasprintf+0x2c/0x50
    [<c00000000002e36c>] .pgtable_cache_add+0xac/0x100
    [<c00000000002e3e4>] .pgtable_cache_init+0x24/0x80
    [<c000000000c6c67c>] .start_kernel+0x228/0x4c8
    [<c000000000000594>] .start_here_common+0x24/0x90

Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
---
 arch/powerpc/mm/init_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index a90b9c4..fe0631f 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -129,6 +129,7 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
 	align = max_t(unsigned long, align, minalign);
 	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
 	new = kmem_cache_create(name, table_size, align, 0, ctor);
+	kfree(name);
 	pgtable_cache[shift - 1] = new;
 	pr_debug("Allocated pgtable cache for order %d\n", shift);
 }
-- 
1.9.1
