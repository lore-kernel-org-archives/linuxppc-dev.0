Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id EFB07100965
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:38 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <e8f6bf913e92bb715309118947384854f82429e5.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:30:26 -0500
Subject: [PATCH 32/37] powerpc: remove irq_host_ops->remap hook
Cc: Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It was called from irq_create_mapping if that was called for a host
and hwirq that was previously mapped, "to update the flags".  But the
only implementation was in beat_interrupt and all it did was repeat a
hypervisor call without error checking that was performed with error
checking at the beginning of the map hook.  In addition, the comment on
the beat remap hook says it will only called once for a given mapping,
which would apply to map not remap.

All flags should be known by the time the match hook is called, before
we call the map hook.  Removing this mostly unused hook will simpify
the requirements of irq_domain concept.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
 arch/powerpc/include/asm/irq.h               |    3 ---
 arch/powerpc/kernel/irq.c                    |    2 --
 arch/powerpc/platforms/cell/beat_interrupt.c |   11 -----------
 3 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index e1983d5..6f4a3ef 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -88,9 +88,6 @@ struct irq_host_ops {
 	/* Dispose of such a mapping */
 	void (*unmap)(struct irq_host *h, unsigned int virq);
 
-	/* Update of such a mapping  */
-	void (*remap)(struct irq_host *h, unsigned int virq, irq_hw_number_t hw);
-
 	/* Translate device-tree interrupt specifier from raw format coming
 	 * from the firmware to a irq_hw_number_t (interrupt line number) and
 	 * type (sense) that can be passed to set_irq_type(). In the absence
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 4a5aa8c..0715a09 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -732,8 +732,6 @@ unsigned int irq_create_mapping(struct irq_host *host,
 	 */
 	virq = irq_find_mapping(host, hwirq);
 	if (virq != NO_IRQ) {
-		if (host->ops->remap)
-			host->ops->remap(host, virq, hwirq);
 		pr_debug("irq: -> existing mapping on virq %d\n", virq);
 		return virq;
 	}
diff --git a/arch/powerpc/platforms/cell/beat_interrupt.c b/arch/powerpc/platforms/cell/beat_interrupt.c
index d46f7e4..55015e1 100644
--- a/arch/powerpc/platforms/cell/beat_interrupt.c
+++ b/arch/powerpc/platforms/cell/beat_interrupt.c
@@ -148,16 +148,6 @@ static int beatic_pic_host_map(struct irq_host *h, unsigned int virq,
 }
 
 /*
- * Update binding hardware IRQ number (hw) and Virtuql
- * IRQ number (virq). This is called only once for a given mapping.
- */
-static void beatic_pic_host_remap(struct irq_host *h, unsigned int virq,
-			       irq_hw_number_t hw)
-{
-	beat_construct_and_connect_irq_plug(virq, hw);
-}
-
-/*
  * Translate device-tree interrupt spec to irq_hw_number_t style (ulong),
  * to pass away to irq_create_mapping().
  *
@@ -184,7 +174,6 @@ static int beatic_pic_host_match(struct irq_host *h, struct device_node *np)
 
 static struct irq_host_ops beatic_pic_host_ops = {
 	.map = beatic_pic_host_map,
-	.remap = beatic_pic_host_remap,
 	.unmap = beatic_pic_host_unmap,
 	.xlate = beatic_pic_host_xlate,
 	.match = beatic_pic_host_match,
-- 
1.7.0.4
