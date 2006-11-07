Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 1893567CED
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 09:57:46 +1100 (EST)
Date: Tue, 7 Nov 2006 16:57:22 -0600 (CST)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] of_irq_to_resource now returns the virq
Message-ID: <Pine.LNX.4.61.0611071505001.6936@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Mostly this is to allow for error checking (check the return for NO_IRQ)
Added a check that the resource is non-NULL, too

Signed-off-by: Andrew Fleming <afleming@freescale.com>
---
 include/asm-powerpc/prom.h |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 933ba27..0afee17 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -334,10 +334,18 @@ extern int of_irq_map_one(struct device_
 struct pci_dev;
 extern int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq);
 
-static inline void of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
+static inline int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 {
-	r->start = r->end = irq_of_parse_and_map(dev, index);
-	r->flags = IORESOURCE_IRQ;
+	int irq = irq_of_parse_and_map(dev, index);
+
+	/* Only dereference the resource if both the
+	 * resource and the irq are valid. */
+	if (r && irq != NO_IRQ) {
+		r->start = r->end = irq;
+		r->flags = IORESOURCE_IRQ;
+	}
+
+	return irq;
 }
 
 
-- 
1.4.2.3
