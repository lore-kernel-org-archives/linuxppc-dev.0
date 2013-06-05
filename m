Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E808B2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 22:27:13 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/pci: check the bus address instead of resource
 address in pcibios_fixup_resources
Date: Wed, 5 Jun 2013 20:26:51 +0800
Message-ID: <1370435211-6929-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If a BAR has the value of 0, we would assume that it is unset yet and
then mark the resource as unset and would reassign it later. But after
commit 6c5705fe (powerpc/PCI: get rid of device resource fixups)
the pcibios_fixup_resources is invoked after the bus address was
translated to linux resource. So the value of res->start is resource
address. And since the resource and bus address may be different, we
should translate it to the bus address before doing the check.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/kernel/pci-common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 7f2273c..eabeec9 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -827,6 +827,7 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
 	}
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
 		struct resource *res = dev->resource + i;
+		struct pci_bus_region reg;
 		if (!res->flags)
 			continue;
 
@@ -835,8 +836,9 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
 		 * at 0 as unset as well, except if PCI_PROBE_ONLY is also set
 		 * since in that case, we don't want to re-assign anything
 		 */
+		pcibios_resource_to_bus(dev, &reg, res);
 		if (pci_has_flag(PCI_REASSIGN_ALL_RSRC) ||
-		    (res->start == 0 && !pci_has_flag(PCI_PROBE_ONLY))) {
+		    (reg.start == 0 && !pci_has_flag(PCI_PROBE_ONLY))) {
 			/* Only print message if not re-assigning */
 			if (!pci_has_flag(PCI_REASSIGN_ALL_RSRC))
 				pr_debug("PCI:%s Resource %d %016llx-%016llx [%x] "
-- 
1.8.1.4
