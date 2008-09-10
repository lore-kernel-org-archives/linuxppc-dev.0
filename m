Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id F1161DE1F2
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 02:00:02 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by comm-neu.esd (Postfix) with ESMTP id 5393D108046
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 17:56:01 +0200 (CEST)
Received: from comm-neu.esd ([127.0.0.1])
	by localhost (comm [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 30612-03-2 for <linuxppc-dev@ozlabs.org>;
	Wed, 10 Sep 2008 17:55:52 +0200 (CEST)
Received: from debby.esd (debby.esd [10.0.0.190])
	by comm-neu.esd (Postfix) with ESMTP id 21A8110801C
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 17:55:52 +0200 (CEST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc4xx: Allow 4xx PCI bridge to be disabled via device tree
Date: Wed, 10 Sep 2008 17:55:46 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809101755.46883.matthias.fuchs@esd-electronics.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch allows the 4xx (conventional) PCI bridge to be disabled
via the device tree. This is needed for 4xx PCI adapter hardware.

Use the PCI node's status property to disable the PCI bridge.

Signed-off-by: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
---
 arch/powerpc/sysdev/ppc4xx_pci.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index fb368df..8c13d4f 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -277,9 +277,16 @@ static void __init ppc4xx_probe_pci_bridge(struct device_node *np)
 	const int *bus_range;
 	int primary = 0;
 
+	/* Check if device is enabled */
+	if (!of_device_is_available(np)) {
+		printk(KERN_INFO "%s: Port disabled via device-tree\n",
+		       np->full_name);
+		return;
+	}
+
 	/* Fetch config space registers address */
 	if (of_address_to_resource(np, 0, &rsrc_cfg)) {
-		printk(KERN_ERR "%s:Can't get PCI config register base !",
+		printk(KERN_ERR "%s: Can't get PCI config register base !",
 		       np->full_name);
 		return;
 	}
-- 
1.5.3
