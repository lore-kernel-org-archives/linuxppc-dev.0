Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 640B51009D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:40 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <769cd6c6775a7a85ddc758619783ef7c0ba49e1b.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:29:49 -0500
Subject: [PATCH 22/37] powerpc: xics: cleanup xics_host_map and ipi
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since we already have a special case in map to set the ipi handler, use
the desired flow.

If we don't find an ics to handle the interrupt complain instead of
returning 0 without having set a chip or handler.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
 arch/powerpc/sysdev/xics/xics-common.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index a31a710..43b2a79 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -135,9 +135,8 @@ static void xics_request_ipi(void)
 
 	/*
 	 * IPIs are marked IRQF_DISABLED as they must run with irqs
-	 * disabled
+	 * disabled, and PERCPU.  The handler was set in map.
 	 */
-	irq_set_handler(ipi, handle_percpu_irq);
 	BUG_ON(request_irq(ipi, icp_ops->ipi_action,
 			   IRQF_DISABLED|IRQF_PERCPU, "IPI", NULL));
 }
@@ -341,15 +340,16 @@ static int xics_host_map(struct irq_host *h, unsigned int virq,
 	/* Don't call into ICS for IPIs */
 	if (hw == XICS_IPI) {
 		irq_set_chip_and_handler(virq, &xics_ipi_chip,
-					 handle_fasteoi_irq);
+					 handle_percpu_irq);
 		return 0;
 	}
 
 	/* Let the ICS setup the chip data */
 	list_for_each_entry(ics, &ics_list, link)
 		if (ics->map(ics, virq) == 0)
-			break;
-	return 0;
+			return 0;
+
+	return -EINVAL;
 }
 
 static int xics_host_xlate(struct irq_host *h, struct device_node *ct,
-- 
1.7.0.4
