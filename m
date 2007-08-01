Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 479C6DDDF4
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 01:41:27 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix a compile warning in powermac/feature.c
Date: Wed,  1 Aug 2007 17:41:14 +0200
Message-Id: <11859828781513-git-send-email-segher@kernel.crashing.org>
In-Reply-To: <11859828761541-git-send-email-segher@kernel.crashing.org>
References: <11859828761541-git-send-email-segher@kernel.crashing.org>
Message-Id: <e774fa79388836788a57b8722999effa0392a536.1185982428.git.segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

...by using the pci_get API instead of the deprecated old stuff.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/powerpc/platforms/powermac/feature.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index f29705f..ba931be 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -826,13 +826,15 @@ core99_ata100_enable(struct device_node *node, long value)
 
 	if (value) {
 		if (pci_device_from_OF_node(node, &pbus, &pid) == 0)
-			pdev = pci_find_slot(pbus, pid);
+			pdev = pci_get_bus_and_slot(pbus, pid);
 		if (pdev == NULL)
 			return 0;
 		rc = pci_enable_device(pdev);
+		if (rc == 0)
+			pci_set_master(pdev);
+		pci_dev_put(pdev);
 		if (rc)
 			return rc;
-		pci_set_master(pdev);
 	}
 	return 0;
 }
-- 
1.5.2.1.144.gabc40-dirty
