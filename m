Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 71007B6F67
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Aug 2011 16:04:13 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p75648dq028173
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Aug 2011 01:04:09 -0500
Subject: [PATCH 2/2] powerpc: Fix build without CONFIG_PCI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 05 Aug 2011 16:04:07 +1000
Message-ID: <1312524247.8598.25.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit fea80311a939a746533a6d7e7c3183729d6a3faf
"iomap: make IOPORT/PCI mapping functions conditional"

Broke powerpc build without CONFIG_PCI as we would still define
pci_iomap(), which overlaps with the new empty inline in the headers.

Make our implementation conditional on CONFIG_PCI

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/iomap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/iomap.c b/arch/powerpc/kernel/iomap.c
index 1577434..faca64a 100644
--- a/arch/powerpc/kernel/iomap.c
+++ b/arch/powerpc/kernel/iomap.c
@@ -117,6 +117,7 @@ void ioport_unmap(void __iomem *addr)
 EXPORT_SYMBOL(ioport_map);
 EXPORT_SYMBOL(ioport_unmap);
 
+#ifdef CONFIG_PCI
 void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max)
 {
 	resource_size_t start = pci_resource_start(dev, bar);
@@ -143,6 +144,7 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 		return;
 	iounmap(addr);
 }
+#endif /* CONFIG_PCI */
 
 EXPORT_SYMBOL(pci_iomap);
 EXPORT_SYMBOL(pci_iounmap);
