Return-Path: <dja@axtens.net>
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C4A7D1A088D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:37:05 +1100 (AEDT)
Received: by pdbni2 with SMTP id ni2so17092388pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:37:04 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 18/27] powerpc/maple: Move controller ops from ppc_md to
 controller_ops
Date: Wed, 25 Mar 2015 16:35:52 +1100
Message-Id: <1427261761-22952-19-git-send-email-dja@axtens.net>
In-Reply-To: <1427261761-22952-1-git-send-email-dja@axtens.net>
References: <1427261761-22952-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves the Maple platform to use the pci_controller_ops
structure rather than ppc_md for PCI controller operations.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/platforms/maple/maple.h | 2 ++
 arch/powerpc/platforms/maple/pci.c   | 4 ++++
 arch/powerpc/platforms/maple/setup.c | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/maple/maple.h b/arch/powerpc/platforms/maple/maple.h
index c6911dd..eecfa18 100644
--- a/arch/powerpc/platforms/maple/maple.h
+++ b/arch/powerpc/platforms/maple/maple.h
@@ -10,3 +10,5 @@ extern void maple_calibrate_decr(void);
 extern void maple_pci_init(void);
 extern void maple_pci_irq_fixup(struct pci_dev *dev);
 extern int maple_pci_get_legacy_ide_irq(struct pci_dev *dev, int channel);
+
+extern struct pci_controller_ops maple_pci_controller_ops;
diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index d3a1306..a923230 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -510,6 +510,7 @@ static int __init maple_add_bridge(struct device_node *dev)
 		return -ENOMEM;
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+	hose->controller_ops = maple_pci_controller_ops;
 
 	disp_name = NULL;
 	if (of_device_is_compatible(dev, "u3-agp")) {
@@ -660,3 +661,6 @@ static void quirk_ipr_msi(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_OBSIDIAN,
 			quirk_ipr_msi);
+
+struct pci_controller_ops maple_pci_controller_ops = {
+};
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 3bf2e03..a837188 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -203,7 +203,7 @@ static void __init maple_init_early(void)
 {
 	DBG(" -> maple_init_early\n");
 
-	iommu_init_early_dart(NULL);
+	iommu_init_early_dart(&maple_pci_controller_ops);
 
 	DBG(" <- maple_init_early\n");
 }
-- 
2.1.4
