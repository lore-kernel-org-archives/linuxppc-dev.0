Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C6DA8DDF96
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 08:08:24 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/mpic: improve interrupt handling performance
Date: Fri,  8 May 2009 17:08:20 -0500
Message-Id: <1241820500-12545-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Before when we were setting up the irq host map for mpic we passed in
just isu_size for the size of the linear map.  However, for a number of
mpic implementations we have no isu (thus pass in 0) and will end up
with a no linear map (size = 0).  This causes us to always call
irq_find_mapping() from mpic_get_irq().

By moving the allocation of the host map to after we've determined the
number of sources we can actually benefit from having a linear map for
the non-isu users that covers all the interrupt sources.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
Ben,

I leave it up to you if you want to put this in for 2.6.30.  We see about a 1us
reduction in time spent in mpic_get_irq() based on ftrace.

- k

 arch/powerpc/sysdev/mpic.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 21b9567..0efc12d 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1057,13 +1057,6 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	memset(mpic, 0, sizeof(struct mpic));
 	mpic->name = name;
 
-	mpic->irqhost = irq_alloc_host(node, IRQ_HOST_MAP_LINEAR,
-				       isu_size, &mpic_host_ops,
-				       flags & MPIC_LARGE_VECTORS ? 2048 : 256);
-	if (mpic->irqhost == NULL)
-		return NULL;
-
-	mpic->irqhost->host_data = mpic;
 	mpic->hc_irq = mpic_irq_chip;
 	mpic->hc_irq.typename = name;
 	if (flags & MPIC_PRIMARY)
@@ -1213,6 +1206,15 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic->isu_shift = 1 + __ilog2(mpic->isu_size - 1);
 	mpic->isu_mask = (1 << mpic->isu_shift) - 1;
 
+	mpic->irqhost = irq_alloc_host(node, IRQ_HOST_MAP_LINEAR,
+				       isu_size ? isu_size : mpic->num_sources,
+				       &mpic_host_ops,
+				       flags & MPIC_LARGE_VECTORS ? 2048 : 256);
+	if (mpic->irqhost == NULL)
+		return NULL;
+
+	mpic->irqhost->host_data = mpic;
+
 	/* Display version */
 	switch (greg_feature & MPIC_GREG_FEATURE_VERSION_MASK) {
 	case 1:
-- 
1.6.0.6
