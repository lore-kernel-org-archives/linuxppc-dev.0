Return-Path: <lucaskt@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp02.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 068052C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 23:14:00 +1000 (EST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <lucaskt@linux.vnet.ibm.com>;
 Thu, 11 Apr 2013 10:13:54 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id B08521DC0072
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 09:13:50 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3BDBKrG2588806
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 10:11:20 -0300
Received: from d24av03.br.ibm.com (loopback [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3BBEBrk022654
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 08:14:12 -0300
From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Airlie <airlied@linux.ie>
Subject: [PATCHv3 1/2] ppc64: perform proper max_bus_speed detection
Date: Thu, 11 Apr 2013 10:13:13 -0300
Message-Id: <1365685994-32603-2-git-send-email-lucaskt@linux.vnet.ibm.com>
In-Reply-To: <1365685994-32603-1-git-send-email-lucaskt@linux.vnet.ibm.com>
References: <1365685994-32603-1-git-send-email-lucaskt@linux.vnet.ibm.com>
Cc: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On pseries machines the detection for max_bus_speed should be done
through an OpenFirmware property. This patch adds a function to perform this
detection and a hook to perform dynamic adding of the function only for
pseries.

Signed-off-by: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h     |    2 +
 arch/powerpc/kernel/pci-common.c       |    8 +++++
 arch/powerpc/platforms/pseries/pci.c   |   51 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c |    4 ++
 4 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 3d6b410..8f558bf 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -107,6 +107,8 @@ struct machdep_calls {
 	void		(*pcibios_fixup)(void);
 	int		(*pci_probe_mode)(struct pci_bus *);
 	void		(*pci_irq_fixup)(struct pci_dev *dev);
+	int		(*pcibios_root_bridge_prepare)(struct pci_host_bridge
+				*bridge);
 
 	/* To setup PHBs when using automatic OF platform driver for PCI */
 	int		(*pci_setup_phb)(struct pci_controller *host);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index fa12ae4..80986cf 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -844,6 +844,14 @@ int pci_proc_domain(struct pci_bus *bus)
 	return 1;
 }
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	if (ppc_md.pcibios_root_bridge_prepare)
+		return ppc_md.pcibios_root_bridge_prepare(bridge);
+
+	return 0;
+}
+
 /* This header fixup will do the resource fixup for all devices as they are
  * probed, but not for bridge ranges
  */
diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 0b580f4..7f9c956 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -108,3 +108,54 @@ static void fixup_winbond_82c105(struct pci_dev* dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
 			 fixup_winbond_82c105);
+
+int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	struct device_node *dn, *pdn;
+	struct pci_bus *bus;
+	const uint32_t *pcie_link_speed_stats;
+
+	bus = bridge->bus;
+
+	dn = pcibios_get_phb_of_node(bus);
+	if (!dn)
+		return 0;
+
+	for (pdn = dn; pdn != NULL; pdn = pdn->parent) {
+		pcie_link_speed_stats = (const uint32_t *) of_get_property(dn,
+			"ibm,pcie-link-speed-stats", NULL);
+		if (pcie_link_speed_stats)
+			break;
+	}
+
+	if (!pcie_link_speed_stats) {
+		pr_err("no ibm,pcie-link-speed-stats property\n");
+		return 0;
+	}
+
+	switch (pcie_link_speed_stats[0]) {
+	case 0x01:
+		bus->max_bus_speed = PCIE_SPEED_2_5GT;
+		break;
+	case 0x02:
+		bus->max_bus_speed = PCIE_SPEED_5_0GT;
+		break;
+	default:
+		bus->max_bus_speed = PCI_SPEED_UNKNOWN;
+		break;
+	}
+
+	switch (pcie_link_speed_stats[1]) {
+	case 0x01:
+		bus->cur_bus_speed = PCIE_SPEED_2_5GT;
+		break;
+	case 0x02:
+		bus->cur_bus_speed = PCIE_SPEED_5_0GT;
+		break;
+	default:
+		bus->cur_bus_speed = PCI_SPEED_UNKNOWN;
+		break;
+	}
+
+	return 0;
+}
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 8bcc9ca..15796b5 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -430,6 +430,8 @@ static void pSeries_machine_kexec(struct kimage *image)
 }
 #endif
 
+int pseries_root_bridge_prepare(struct pci_host_bridge *bridge);
+
 static void __init pSeries_setup_arch(void)
 {
 	panic_timeout = 10;
@@ -466,6 +468,8 @@ static void __init pSeries_setup_arch(void)
 	else
 		ppc_md.enable_pmcs = power4_enable_pmcs;
 
+	ppc_md.pcibios_root_bridge_prepare = pseries_root_bridge_prepare;
+
 	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
 		long rc;
 		if ((rc = pSeries_enable_reloc_on_exc()) != H_SUCCESS) {
-- 
1.7.4.4
