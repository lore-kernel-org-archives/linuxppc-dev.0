Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410rw26cL1zF1xl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2018 11:40:18 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id z9-v6so2710785plk.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jun 2018 18:40:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/64s/radix: Fix missing ptesync in flush_cache_vmap
Date: Wed,  6 Jun 2018 11:40:08 +1000
Message-Id: <20180606014008.20363-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a typo in f1cb8f9beb ("powerpc/64s/radix: avoid ptesync after
set_pte and ptep_set_access_flags") config ifdef, which results in the
necessary ptesync not being issued after vmalloc.

This causes random kernel faults in module load, bpf load, anywhere
that vmalloc mappings are used.

After correcting the code, this survives a guest kernel booting
hundreds of times where previously there would be a crash every few
boots (I haven't noticed the crash on host, perhaps due to different
TLB and page table walking behaviour in hardware).

A memory clobber is also added to the flush, just to be sure it won't
be reordered with the pte set or the subsequent mapping access.

Fixes: f1cb8f9beb ("powerpc/64s/radix: avoid ptesync after set_pte and ptep_set_access_flags")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
This code obviously can't have been tested properly, I'm sorry about
that. I tested with the ptesync and then "tidied up" the patch by
putting it in ifdef, and didn't test the final patch sufficiently :(

 arch/powerpc/include/asm/cacheflush.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index e9662648e72d..0d72ec75da63 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -23,10 +23,9 @@
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
 #define flush_icache_page(vma, page)		do { } while (0)
-#define flush_cache_vmap(start, end)		do { } while (0)
 #define flush_cache_vunmap(start, end)		do { } while (0)
 
-#ifdef CONFIG_BOOK3S_64
+#ifdef CONFIG_PPC_BOOK3S_64
 /*
  * Book3s has no ptesync after setting a pte, so without this ptesync it's
  * possible for a kernel virtual mapping access to return a spurious fault
@@ -34,7 +33,7 @@
  * not expect this type of fault. flush_cache_vmap is not exactly the right
  * place to put this, but it seems to work well enough.
  */
-#define flush_cache_vmap(start, end)		do { asm volatile("ptesync"); } while (0)
+#define flush_cache_vmap(start, end)		do { asm volatile("ptesync" ::: "memory"); } while (0)
 #else
 #define flush_cache_vmap(start, end)		do { } while (0)
 #endif
-- 
2.17.0
