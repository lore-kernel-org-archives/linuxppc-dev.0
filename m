Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27A911A0B87
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:28:27 +1000 (AEST)
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 936AF140281
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2015 14:28:26 +1000 (AEST)
Received: by pabsx10 with SMTP id sx10so124796332pab.3
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Apr 2015 21:28:25 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [PATCH 03/10] powerpc/cell: Move MSI-related ops to pci_controller_ops
Date: Tue, 14 Apr 2015 14:27:56 +1000
Message-Id: <1428985683-24767-4-git-send-email-dja@axtens.net>
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

Move the Cell platform to use the pci_controller_ops structure rather
than ppc_md for MSI related PCI controller operations.

We can be confident that the functions will be added to the platform's
ops struct before any PCI controller's ops struct is populated
because:

1) These ops are added to the struct in a subsys initcall.

We populate the ops in axon_msi_probe, which is the probe call for the
axon-msi driver. However the driver is registered in axon_msi_init,
which is a subsys initcall, so this will happen at the subsys level.

2) The controller recieves the struct later, in a device initcall.

Cell populates the controller in cell_setup_phb, which is hooked up to
ppc_md.pci_setup_phb. ppc_md.pci_setup_phb is only ever called in
of_platform.c, as part of the OpenFirmware PCI driver's probe
routine. That driver is registered in a device initcall, so it will
occur *after* the struct is properly populated.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/platforms/cell/axon_msi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 623bd96..d9b8a44 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -22,6 +22,7 @@
 #include <asm/machdep.h>
 #include <asm/prom.h>
 
+#include "cell.h"
 
 /*
  * MSIC registers, specified as offsets from dcr_base
@@ -406,8 +407,8 @@ static int axon_msi_probe(struct platform_device *device)
 
 	dev_set_drvdata(&device->dev, msic);
 
-	ppc_md.setup_msi_irqs = axon_msi_setup_msi_irqs;
-	ppc_md.teardown_msi_irqs = axon_msi_teardown_msi_irqs;
+	cell_pci_controller_ops.setup_msi_irqs = axon_msi_setup_msi_irqs;
+	cell_pci_controller_ops.teardown_msi_irqs = axon_msi_teardown_msi_irqs;
 
 	axon_msi_debug_setup(dn, msic);
 
-- 
2.1.4
