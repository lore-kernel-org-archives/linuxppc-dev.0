Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 02D58DDD01
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 13:38:06 +1000 (EST)
Date: Tue, 2 Oct 2007 13:37:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Limit range of __init_ref_ok somewhat
Message-Id: <20071002133753.662397db.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch introduces zalloc_maybe_bootmem and uses it so that we don;t
have to mark a whole (largish) routine as __init_ref_ok.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/irq.c    |   10 ++--------
 arch/powerpc/lib/alloc.c     |   15 +++++++++++++++
 include/asm-powerpc/system.h |    1 +
 3 files changed, 18 insertions(+), 8 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 0e47c8c..151b131 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -424,7 +424,7 @@ static int default_irq_host_match(struct irq_host *h, struct device_node *np)
 	return h->of_node != NULL && h->of_node == np;
 }
 
-__init_refok struct irq_host *irq_alloc_host(struct device_node *of_node,
+struct irq_host *irq_alloc_host(struct device_node *of_node,
 				unsigned int revmap_type,
 				unsigned int revmap_arg,
 				struct irq_host_ops *ops,
@@ -439,13 +439,7 @@ __init_refok struct irq_host *irq_alloc_host(struct device_node *of_node,
 	/* Allocate structure and revmap table if using linear mapping */
 	if (revmap_type == IRQ_HOST_MAP_LINEAR)
 		size += revmap_arg * sizeof(unsigned int);
-	if (mem_init_done)
-		host = kzalloc(size, GFP_KERNEL);
-	else {
-		host = alloc_bootmem(size);
-		if (host)
-			memset(host, 0, size);
-	}
+	host = zalloc_maybe_bootmem(size, GFP_KERNEL);
 	if (host == NULL)
 		return NULL;
 
diff --git a/arch/powerpc/lib/alloc.c b/arch/powerpc/lib/alloc.c
index e58c805..f53e09c 100644
--- a/arch/powerpc/lib/alloc.c
+++ b/arch/powerpc/lib/alloc.c
@@ -2,6 +2,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/bootmem.h>
+#include <linux/string.h>
 
 #include <asm/system.h>
 
@@ -12,3 +13,17 @@ void * __init_refok alloc_maybe_bootmem(size_t size, gfp_t mask)
 	else
 		return alloc_bootmem(size);
 }
+
+void * __init_refok zalloc_maybe_bootmem(size_t size, gfp_t mask)
+{
+	void *p;
+
+	if (mem_init_done)
+		p = kzalloc(size, mask);
+	else {
+		p = alloc_bootmem(size);
+		if (p)
+			memset(p, 0, size);
+	}
+	return p;
+}
diff --git a/include/asm-powerpc/system.h b/include/asm-powerpc/system.h
index f7879fc..d10e99b 100644
--- a/include/asm-powerpc/system.h
+++ b/include/asm-powerpc/system.h
@@ -190,6 +190,7 @@ extern unsigned long memory_limit;
 extern unsigned long klimit;
 
 extern void *alloc_maybe_bootmem(size_t size, gfp_t mask);
+extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 
-- 
1.5.3.2
