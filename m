Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BC1E1A0BF3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:28:30 +1000 (AEST)
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BF242140281
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2015 14:28:29 +1000 (AEST)
Received: by pabsx10 with SMTP id sx10so124797650pab.3
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Apr 2015 21:28:28 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [PATCH 04/10] powerpc/pseries: Move MSI-related ops to
 pci_controller_ops
Date: Tue, 14 Apr 2015 14:27:57 +1000
Message-Id: <1428985683-24767-5-git-send-email-dja@axtens.net>
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

Move the pseries platform to use the pci_controller_ops structure
rather than ppc_md for MSI related PCI controller operations
---
 arch/powerpc/platforms/pseries/msi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index c8d24f9..a70806e 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -18,6 +18,8 @@
 #include <asm/ppc-pci.h>
 #include <asm/machdep.h>
 
+#include "pseries.h"
+
 static int query_token, change_token;
 
 #define RTAS_QUERY_FN		0
@@ -516,9 +518,9 @@ static int rtas_msi_init(void)
 
 	pr_debug("rtas_msi: Registering RTAS MSI callbacks.\n");
 
-	WARN_ON(ppc_md.setup_msi_irqs);
-	ppc_md.setup_msi_irqs = rtas_setup_msi_irqs;
-	ppc_md.teardown_msi_irqs = rtas_teardown_msi_irqs;
+	WARN_ON(pseries_pci_controller_ops.setup_msi_irqs);
+	pseries_pci_controller_ops.setup_msi_irqs = rtas_setup_msi_irqs;
+	pseries_pci_controller_ops.teardown_msi_irqs = rtas_teardown_msi_irqs;
 
 	WARN_ON(ppc_md.pci_irq_fixup);
 	ppc_md.pci_irq_fixup = rtas_msi_pci_irq_fixup;
-- 
2.1.4
