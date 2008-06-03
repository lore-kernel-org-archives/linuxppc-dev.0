Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 21137DDEDB
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 13:36:13 +1000 (EST)
Date: Tue, 3 Jun 2008 13:36:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] use dev_set_name in pci_64.c
Message-Id: <20080603133611.cb298635.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Kay Sievers <kay.sievers@vrfy.org>,
	Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

During the next merge window, pci_name()'s return value will become
const, so use the new dev_set_name() instead to avoid the warning (from
linux-next):

arch/powerpc/kernel/pci_64.c: In function 'of_create_pci_dev':
arch/powerpc/kernel/pci_64.c:193: warning: passing argument 1 of 'sprintf' discards qualifiers from pointer target type

Cc: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

This is similar to a patch for sparc64 that is in linux-next.  It is
suitable for either 2.6.26 or 2.6.27.

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 5275074..30eedfc 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -189,7 +189,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 
 	dev->cfg_size = pci_cfg_space_size(dev);
 
-	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(bus),
+	dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(bus),
 		dev->bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn));
 	dev->class = get_int_prop(node, "class-code", 0);
 	dev->revision = get_int_prop(node, "revision-id", 0);
-- 
1.5.5.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
