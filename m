Return-Path: <lucaskt@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp03.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 59AE62C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 16:25:18 +1100 (EST)
Received: from /spool/local
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <lucaskt@linux.vnet.ibm.com>;
 Wed, 20 Mar 2013 02:25:13 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 8478B1DC0063
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 01:25:08 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2K5OOww20578442
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 02:24:24 -0300
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2K5P7Ns029778
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 02:25:08 -0300
From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCHv2 3/3] ppc64: implemented pcibios_get_speed_cap_mask
Date: Wed, 20 Mar 2013 02:24:39 -0300
Message-Id: <1363757079-23550-4-git-send-email-lucaskt@linux.vnet.ibm.com>
In-Reply-To: <1363757079-23550-1-git-send-email-lucaskt@linux.vnet.ibm.com>
References: <1363757079-23550-1-git-send-email-lucaskt@linux.vnet.ibm.com>
Cc: David Airlie <airlied@linux.ie>, Brian King <brking@linux.vnet.ibm.com>,
 Thadeu Cascardo <cascardo@linux.vnet.ibm.com>,
 Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Alex Deucher <alexander.deucher@amd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implementation of a architecture-specific pcibios_get_speed_cap_mask.
This implementation detects bus capabilities based on OF
ibm,pcie-link-speed-stats property.

Signed-off-by: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/pci.c |   35 ++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 0b580f4..4da8deb 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -24,6 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/string.h>
+#include <linux/device.h>
 
 #include <asm/eeh.h>
 #include <asm/pci-bridge.h>
@@ -108,3 +109,37 @@ static void fixup_winbond_82c105(struct pci_dev* dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
 			 fixup_winbond_82c105);
+
+int pcibios_get_speed_cap_mask(struct pci_dev *dev, u32 *mask)
+{
+	struct device_node *dn, *pdn;
+	const uint32_t *pcie_link_speed_stats = NULL;
+
+	*mask = 0;
+	dn = pci_bus_to_OF_node(dev->bus);
+
+	/* Find nearest ibm,pcie-link-speed-stats, walking up the device tree */
+	for (pdn = dn; pdn != NULL; pdn = pdn->parent) {
+		pcie_link_speed_stats = (const uint32_t *) of_get_property(pdn,
+			"ibm,pcie-link-speed-stats", NULL);
+		if (pcie_link_speed_stats != NULL)
+			break;
+	}
+
+	if (pcie_link_speed_stats == NULL) {
+		dev_info(&dev->dev, "no ibm,pcie-link-speed-stats property\n");
+		return -EINVAL;
+	}
+
+	switch (pcie_link_speed_stats[0]) {
+	case 0x02:
+		*mask |= PCIE_SPEED_50;
+	case 0x01:
+		*mask |= PCIE_SPEED_25;
+	case 0x00:
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
-- 
1.7.4.4
