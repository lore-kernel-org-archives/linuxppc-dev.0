Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bTgw0LVWzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 08:00:59 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Olof Johansson <olof@lixom.net>
Date: Wed, 25 Jul 2018 21:55:18 +0100 (BST)
Message-ID: <4c4cb2b4391.4d23d508@auth.smtp.1and1.co.uk>
Subject: [PATCH] powerpc/pasemi: Seach for PCI root bus by compatible property
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pasemi arch code finds the root of the PCI-e bus by searching the
device-tree for a node called 'pxp'. But the root bus has a 
compatible property of 'pasemi,rootbus' so search for that instead.

Signed-off-by: Darren Stevens <darren@stevens-zone.net>
---

This works on the Amigaone X1000, I don't know if this method of
finding the pci bus was there bcause of earlier firmwares.

diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index c7c8607..be62380 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -216,6 +216,7 @@ static int __init pas_add_bridge(struct device_node *dev)
 void __init pas_pci_init(void)
 {
    struct device_node *np, *root;
+   int res;
 
    root = of_find_node_by_path("/");
    if (!root) {
@@ -226,11 +227,11 @@ void __init pas_pci_init(void)
 
    pci_set_flags(PCI_SCAN_ALL_PCIE_DEVS);
 
-   for (np = NULL; (np = of_get_next_child(root, np)) != NULL;)
-       if (np->name && !strcmp(np->name, "pxp") && !pas_add_bridge(np))
-           of_node_get(np);
-
-   of_node_put(root);
+   np = of_find_compatible_node(root, NULL, "pasemi,rootbus");
+   if (np) {
+       res = pas_add_bridge(np);
+       of_node_put(np);
+   }
 }
 
 void __iomem *pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset)
