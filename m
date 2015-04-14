Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A6EA1A0BD9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:28:33 +1000 (AEST)
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CA07D140281
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2015 14:28:32 +1000 (AEST)
Received: by paboj16 with SMTP id oj16so124968024pab.0
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Apr 2015 21:28:31 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [PATCH 05/10] powerpc/fsl_msi: Move MSI-related ops to
 pci_controller_ops
Date: Tue, 14 Apr 2015 14:27:58 +1000
Message-Id: <1428985683-24767-6-git-send-email-dja@axtens.net>
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

Move the fsl_msi subsystem to use the pci_controller_ops structure
rather than ppc_md for MSI related PCI controller operations.

Previously, MSI ops were added to ppc_md at the subsys level. However,
in fsl_pci.c, PCI controllers are created at the at arch level. So,
unlike in e.g. PowerNV/pSeries/Cell, we can't simply populate a
platform-level controller ops structure and have it copied into the
controllers when they are created.

Instead, walk every phb, and attempt to populate it with the MSI ops.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/sysdev/fsl_msi.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index f086c6f..5236e54 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -405,6 +405,7 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 	const struct fsl_msi_feature *features;
 	int len;
 	u32 offset;
+	struct pci_controller *phb;
 
 	match = of_match_device(fsl_of_msi_ids, &dev->dev);
 	if (!match)
@@ -541,14 +542,20 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 
 	list_add_tail(&msi->list, &msi_head);
 
-	/* The multiple setting ppc_md.setup_msi_irqs will not harm things */
-	if (!ppc_md.setup_msi_irqs) {
-		ppc_md.setup_msi_irqs = fsl_setup_msi_irqs;
-		ppc_md.teardown_msi_irqs = fsl_teardown_msi_irqs;
-	} else if (ppc_md.setup_msi_irqs != fsl_setup_msi_irqs) {
-		dev_err(&dev->dev, "Different MSI driver already installed!\n");
-		err = -ENODEV;
-		goto error_out;
+	/*
+	 * Apply the MSI ops to all the controllers.
+	 * It doesn't hurt to reassign the same ops,
+	 * but bail out if we find another MSI driver.
+	 */
+	list_for_each_entry(phb, &hose_list, list_node) {
+		if (!phb->controller_ops.setup_msi_irqs) {
+			phb->controller_ops.setup_msi_irqs = fsl_setup_msi_irqs;
+			phb->controller_ops.teardown_msi_irqs = fsl_teardown_msi_irqs;
+		} else if (phb->controller_ops.setup_msi_irqs != fsl_setup_msi_irqs) {
+			dev_err(&dev->dev, "Different MSI driver already installed!\n");
+			err = -ENODEV;
+			goto error_out;
+		}
 	}
 	return 0;
 error_out:
-- 
2.1.4
