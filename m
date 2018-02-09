Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zczqK4cs8zF18h
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 13:42:03 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH kernel v2] powerpc/pci: Fix broken INTx configuration via OF
Date: Fri,  9 Feb 2018 13:41:25 +1100
Message-Id: <20180209024125.38862-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 59f47eff03a0 ("powerpc/pci: Use of_irq_parse_and_map_pci() helper")
replaced of_irq_parse_pci() + irq_create_of_mapping() with
of_irq_parse_and_map_pci() but this change lost virq returned by
irq_create_of_mapping() so virq remained zero causing INTx
misconfiguration.

This fixes pci_read_irq_line() not to loose a virq returned by
of_irq_parse_and_map_pci().

Fixes: 59f47eff03a0 "powerpc/pci: Use of_irq_parse_and_map_pci() helper"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* changed the condition from <=0 to !=0 as by design
of_irq_parse_and_map_pci() can only return 0 for an error and virq>0.
---
 arch/powerpc/kernel/pci-common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index ae2ede4..33580a9 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -362,7 +362,7 @@ struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node)
  */
 static int pci_read_irq_line(struct pci_dev *pci_dev)
 {
-	unsigned int virq = 0;
+	unsigned int virq;
 
 	pr_debug("PCI: Try to map irq for %s...\n", pci_name(pci_dev));
 
@@ -370,7 +370,8 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
 	memset(&oirq, 0xff, sizeof(oirq));
 #endif
 	/* Try to get a mapping from the device-tree */
-	if (!of_irq_parse_and_map_pci(pci_dev, 0, 0)) {
+	virq = of_irq_parse_and_map_pci(pci_dev, 0, 0);
+	if (!virq) {
 		u8 line, pin;
 
 		/* If that fails, lets fallback to what is in the config
-- 
2.11.0
