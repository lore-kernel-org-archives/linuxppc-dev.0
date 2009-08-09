Return-Path: <marcin.slusarz@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6FF2EB7B7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 10 Aug 2009 05:54:31 +1000 (EST)
Received: from mail-qy0-f189.google.com (mail-qy0-f189.google.com
	[209.85.221.189]) by ozlabs.org (Postfix) with ESMTP id 7E36EDDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2009 05:54:29 +1000 (EST)
Received: by qyk27 with SMTP id 27so2387698qyk.17
	for <linuxppc-dev@ozlabs.org>; Sun, 09 Aug 2009 12:54:27 -0700 (PDT)
From: Marcin Slusarz <marcin.slusarz@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/14] powerpc: use printk_once
Date: Sun,  9 Aug 2009 21:53:58 +0200
Message-Id: <1249847649-11631-4-git-send-email-marcin.slusarz@gmail.com>
In-Reply-To: <1249847649-11631-1-git-send-email-marcin.slusarz@gmail.com>
References: <1249847649-11631-1-git-send-email-marcin.slusarz@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/kernel/iommu.c      |    6 +-----
 arch/powerpc/kernel/irq.c        |    5 ++---
 arch/powerpc/sysdev/ppc4xx_pci.c |    9 ++-------
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index fd51578..c7fa258 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -502,7 +502,6 @@ static void iommu_table_clear(struct iommu_table *tbl)
 struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 {
 	unsigned long sz;
-	static int welcomed = 0;
 	struct page *page;
 
 	/* Set aside 1/4 of the table for large allocations. */
@@ -523,11 +522,8 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 
 	iommu_table_clear(tbl);
 
-	if (!welcomed) {
-		printk(KERN_INFO "IOMMU table initialized, virtual merging %s\n",
+	printk_once(KERN_INFO "IOMMU table initialized, virtual merging %s\n",
 		       novmerge ? "disabled" : "enabled");
-		welcomed = 1;
-	}
 
 	return tbl;
 }
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index f7f376e..05ebd21 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -231,7 +231,6 @@ skip:
 void fixup_irqs(cpumask_t map)
 {
 	unsigned int irq;
-	static int warned;
 
 	for_each_irq(irq) {
 		cpumask_t mask;
@@ -246,8 +245,8 @@ void fixup_irqs(cpumask_t map)
 		}
 		if (irq_desc[irq].chip->set_affinity)
 			irq_desc[irq].chip->set_affinity(irq, &mask);
-		else if (irq_desc[irq].action && !(warned++))
-			printk("Cannot set affinity for irq %i\n", irq);
+		else if (irq_desc[irq].action)
+			printk_once("Cannot set affinity for irq %i\n", irq);
 	}
 
 	local_irq_enable();
diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 6ff9d71..4282dff 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -1243,19 +1243,14 @@ static int ppc4xx_pciex_validate_bdf(struct ppc4xx_pciex_port *port,
 				     struct pci_bus *bus,
 				     unsigned int devfn)
 {
-	static int message;
-
 	/* Endpoint can not generate upstream(remote) config cycles */
 	if (port->endpoint && bus->number != port->hose->first_busno)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/* Check we are within the mapped range */
 	if (bus->number > port->hose->last_busno) {
-		if (!message) {
-			printk(KERN_WARNING "Warning! Probing bus %u"
-			       " out of range !\n", bus->number);
-			message++;
-		}
+		printk_once(KERN_WARNING
+			"Warning! Probing bus %u out of range!\n", bus->number);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-- 
1.6.3.3
