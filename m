Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C35A81A0567
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 11:54:45 +1000 (AEST)
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B5DEE14007D
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 11:54:42 +1000 (AEST)
Received: by pacyx8 with SMTP id yx8so112599375pac.1
 for <linuxppc-dev@ozlabs.org>; Sun, 26 Apr 2015 18:54:40 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: Fix early pci_controller_ops loading.
Date: Mon, 27 Apr 2015 11:54:26 +1000
Message-Id: <1430099666-9159-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Load the PowerNV platform pci controller ops into pci controllers
after all the operations are loaded into the platform ops struct, not
before.

Fixes: c88c2a188905cb3077c3c38dc498e7e9f8eebeee
Reported-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 920c252..f8bc950 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2693,7 +2693,6 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 		hose->last_busno = 0xff;
 	}
 	hose->private_data = phb;
-	hose->controller_ops = pnv_pci_controller_ops;
 	phb->hub_id = hub_id;
 	phb->opal_id = phb_id;
 	phb->type = ioda_type;
@@ -2812,6 +2811,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	pnv_pci_controller_ops.enable_device_hook = pnv_pci_enable_device_hook;
 	pnv_pci_controller_ops.window_alignment = pnv_pci_window_alignment;
 	pnv_pci_controller_ops.reset_secondary_bus = pnv_pci_reset_secondary_bus;
+	hose->controller_ops = pnv_pci_controller_ops;
 
 #ifdef CONFIG_PCI_IOV
 	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_iov_resources;
-- 
2.1.4
