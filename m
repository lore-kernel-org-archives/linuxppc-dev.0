Return-Path: <afleming@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id A4EB367C32
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 10:13:18 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	kA6NR3C9004845
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 16:27:03 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id kA6NDFtM004562
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 17:13:16 -0600 (CST)
Received: from ld0175-tx32.am.freescale.net (ld0175-tx32 [10.82.19.125])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	kA6MwnBK026412
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 16:58:49 -0600 (CST)
Received: from ld0175-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0175-tx32.am.freescale.net (Postfix) with ESMTP id B5BF4AB028
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 17:13:14 -0600 (CST)
Received: from localhost (afleming@localhost)
	by ld0175-tx32.am.freescale.net (8.12.11/8.12.11/Submit) with ESMTP id
	kA6NDEQI010881
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 17:13:14 -0600
Date: Mon, 6 Nov 2006 17:13:13 -0600 (CST)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] of_irq_to_resource now returns the virq
Message-ID: <Pine.LNX.4.61.0611061711510.10818@ld0175-tx32.am.freescale.net>
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

Signed-off-by: Andrew Fleming <afleming@freescale.com>
---
For 2.6.20

 include/asm-powerpc/prom.h |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 933ba27..e9226e3 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -334,10 +334,17 @@ extern int of_irq_map_one(struct device_
 struct pci_dev;
 extern int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq);
 
-static inline void of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
+static inline int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 {
-	r->start = r->end = irq_of_parse_and_map(dev, index);
-	r->flags = IORESOURCE_IRQ;
+	int irq = irq_of_parse_and_map(dev, index);
+
+	/* Only dereference the resource if the irq is valid. */
+	if (irq != NO_IRQ) {
+		r->start = r->end = irq;
+		r->flags = IORESOURCE_IRQ;
+	}
+
+	return irq;
 }
 
 
-- 
1.4.2.3
