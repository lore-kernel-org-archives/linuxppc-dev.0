Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B72B61A0BE0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:28:36 +1000 (AEST)
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2DAA1140281
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2015 14:28:36 +1000 (AEST)
Received: by pabtp1 with SMTP id tp1so124806589pab.2
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Apr 2015 21:28:34 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [PATCH 06/10] powerpc/ppc4xx_msi: Move MSI-related ops to
 pci_controller_ops
Date: Tue, 14 Apr 2015 14:27:59 +1000
Message-Id: <1428985683-24767-7-git-send-email-dja@axtens.net>
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

Move the ppc4xx msi subsystem to use the pci_controller_ops structure
rather than ppc_md for MSI related PCI controller operations.

As with fsl_msi, operations are plugged in at the subsys level, after
controller creation. Again, we iterate over all controllers and
populate them with the MSI ops.
---
 arch/powerpc/sysdev/ppc4xx_msi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
index 6e2e6aa..6eb21f2 100644
--- a/arch/powerpc/sysdev/ppc4xx_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_msi.c
@@ -218,6 +218,7 @@ static int ppc4xx_msi_probe(struct platform_device *dev)
 	struct ppc4xx_msi *msi;
 	struct resource res;
 	int err = 0;
+	struct pci_controller *phb;
 
 	dev_dbg(&dev->dev, "PCIE-MSI: Setting up MSI support...\n");
 
@@ -250,8 +251,10 @@ static int ppc4xx_msi_probe(struct platform_device *dev)
 	}
 	ppc4xx_msi = *msi;
 
-	ppc_md.setup_msi_irqs = ppc4xx_setup_msi_irqs;
-	ppc_md.teardown_msi_irqs = ppc4xx_teardown_msi_irqs;
+	list_for_each_entry(phb, &hose_list, list_node) {
+		phb->controller_ops.setup_msi_irqs = ppc4xx_setup_msi_irqs;
+		phb->controller_ops.teardown_msi_irqs = ppc4xx_teardown_msi_irqs;
+	}
 	return err;
 
 error_out:
-- 
2.1.4
