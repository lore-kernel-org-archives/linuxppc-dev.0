Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <fed858580ab2ed8869c512f7ffd84a6bb4cf6854.1185366282.git.michael@ellerman.id.au>
In-Reply-To: <41400bb89c154723f795e998d5ac777345eb9ebc.1185366282.git.michael@ellerman.id.au>
References: <41400bb89c154723f795e998d5ac777345eb9ebc.1185366282.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/5] Invert null match behaviour for irq_hosts
Date: Wed, 25 Jul 2007 22:24:54 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently if you don't specify a match callback for your irq_host it's
assumed you match everything. This is a kind of opt-out approach, and
turns out to be the exception rather than the rule.

So change the semantics to be opt-in, ie. you don't match anything unless
you provide a match callback. This in itself isn't very useful, but will
allow us to provide a default match implementation in a subsequent patch.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c                 |    2 +-
 arch/powerpc/platforms/celleb/interrupt.c |    7 +++++++
 arch/powerpc/platforms/iseries/irq.c      |    7 +++++++
 arch/powerpc/platforms/ps3/interrupt.c    |    7 +++++++
 4 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 31d1de7..88e6b59 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -523,7 +523,7 @@ struct irq_host *irq_find_host(struct device_node *node)
 	 */
 	spin_lock_irqsave(&irq_big_lock, flags);
 	list_for_each_entry(h, &irq_hosts, link)
-		if (h->ops->match == NULL || h->ops->match(h, node)) {
+		if (h->ops->match != NULL && h->ops->match(h, node)) {
 			found = h;
 			break;
 		}
diff --git a/arch/powerpc/platforms/celleb/interrupt.c b/arch/powerpc/platforms/celleb/interrupt.c
index 4ecdf06..c7c68ca 100644
--- a/arch/powerpc/platforms/celleb/interrupt.c
+++ b/arch/powerpc/platforms/celleb/interrupt.c
@@ -175,11 +175,18 @@ static int beatic_pic_host_xlate(struct irq_host *h, struct device_node *ct,
 	return 0;
 }
 
+static int beatic_pic_host_match(struct irq_host *h, struct device_node *np)
+{
+	/* Match all */
+	return 1;
+}
+
 static struct irq_host_ops beatic_pic_host_ops = {
 	.map = beatic_pic_host_map,
 	.remap = beatic_pic_host_remap,
 	.unmap = beatic_pic_host_unmap,
 	.xlate = beatic_pic_host_xlate,
+	.match = beatic_pic_host_match,
 };
 
 /*
diff --git a/arch/powerpc/platforms/iseries/irq.c b/arch/powerpc/platforms/iseries/irq.c
index 3666746..701d929 100644
--- a/arch/powerpc/platforms/iseries/irq.c
+++ b/arch/powerpc/platforms/iseries/irq.c
@@ -346,8 +346,15 @@ static int iseries_irq_host_map(struct irq_host *h, unsigned int virq,
 	return 0;
 }
 
+static int iseries_irq_host_match(struct irq_host *h, struct device_node *np)
+{
+	/* Match all */
+	return 1;
+}
+
 static struct irq_host_ops iseries_irq_host_ops = {
 	.map = iseries_irq_host_map,
+	.match = iseries_irq_host_match,
 };
 
 /*
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index 30b9f4c..3a6db04 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -673,9 +673,16 @@ static int ps3_host_map(struct irq_host *h, unsigned int virq,
 	return 0;
 }
 
+static int ps3_host_match(struct irq_host *h, struct device_node *np)
+{
+	/* Match all */
+	return 1;
+}
+
 static struct irq_host_ops ps3_host_ops = {
 	.map = ps3_host_map,
 	.unmap = ps3_host_unmap,
+	.match = ps3_host_match,
 };
 
 void __init ps3_register_ipi_debug_brk(unsigned int cpu, unsigned int virq)
-- 
1.5.1.3.g7a33b
