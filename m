Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 11 Mar 2009 14:53:35 +1100
Subject: [PATCH 7/9] powerpc/mm: Fix printk type warning in mmu_context_nohash
In-Reply-To: <1236743604.932194.842849421348.qpush@grosgo>
Message-Id: <20090311035339.8DA96DDD04@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need to use %zu instead of %d when printing a sizeof()

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/mm/mmu_context_nohash.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/mm/mmu_context_nohash.c	2009-03-11 11:51:05.000000000 +1100
+++ linux-work/arch/powerpc/mm/mmu_context_nohash.c	2009-03-11 11:52:55.000000000 +1100
@@ -380,7 +380,7 @@ void __init mmu_context_init(void)
 #endif
 
 	printk(KERN_INFO
-	       "MMU: Allocated %d bytes of context maps for %d contexts\n",
+	       "MMU: Allocated %zu bytes of context maps for %d contexts\n",
 	       2 * CTX_MAP_SIZE + (sizeof(void *) * (last_context + 1)),
 	       last_context - first_context + 1);
 
