Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F4511A0BED
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:28:40 +1000 (AEST)
Received: from mail-pd0-x235.google.com (mail-pd0-x235.google.com
 [IPv6:2607:f8b0:400e:c02::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ADD331402A8
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2015 14:28:39 +1000 (AEST)
Received: by pdea3 with SMTP id a3so130497603pde.3
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Apr 2015 21:28:38 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [PATCH 07/10] powerpc/ppc4xx_hsta_msi: Move MSI-related ops to
 pci_controller_ops
Date: Tue, 14 Apr 2015 14:28:00 +1000
Message-Id: <1428985683-24767-8-git-send-email-dja@axtens.net>
In-Reply-To: <1428985683-24767-1-git-send-email-dja@axtens.net>
References: <1428985683-24767-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the ppc4xx hsta msi subsystem to use the pci_controller_ops
structure rather than ppc_md for MSI related PCI controller
operations.

As with fsl_msi, operations are plugged in at the subsys level, after
controller creation. Again, we iterate over all controllers and
populate them with the MSI ops.
---
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
index f366d2d..2bc3367 100644
--- a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_hsta_msi.c
@@ -128,6 +128,7 @@ static int hsta_msi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct resource *mem;
 	int irq, ret, irq_count;
+	struct pci_controller *phb;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (IS_ERR(mem)) {
@@ -171,8 +172,10 @@ static int hsta_msi_probe(struct platform_device *pdev)
 		}
 	}
 
-	ppc_md.setup_msi_irqs = hsta_setup_msi_irqs;
-	ppc_md.teardown_msi_irqs = hsta_teardown_msi_irqs;
+	list_for_each_entry(phb, &hose_list, list_node) {
+		phb->controller_ops.setup_msi_irqs = hsta_setup_msi_irqs;
+		phb->controller_ops.teardown_msi_irqs = hsta_teardown_msi_irqs;
+	}
 	return 0;
 
 out2:
-- 
2.1.4
