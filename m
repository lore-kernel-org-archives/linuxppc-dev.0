Return-Path: <klebers@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp05.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 201362C0188
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 08:44:05 +1000 (EST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <klebers@linux.vnet.ibm.com>;
 Fri, 3 May 2013 19:44:01 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id A34881DC006A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 18:43:59 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r43Mh3ou37748796
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 19:43:03 -0300
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r43Mhwhl007252
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 19:43:59 -0300
From: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Airlie <airlied@linux.ie>,
 Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCHv5 1/2] ppc64: perform proper max_bus_speed detection
Date: Fri,  3 May 2013 19:43:12 -0300
Message-Id: <1367620993-27037-2-git-send-email-klebers@linux.vnet.ibm.com>
In-Reply-To: <1367620993-27037-1-git-send-email-klebers@linux.vnet.ibm.com>
References: <1367620993-27037-1-git-send-email-klebers@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On pseries machines the detection for max_bus_speed should be done
through an OpenFirmware property. This patch adds a function to perform
this detection and a hook to perform dynamic adding of the function only
for pseries. This is done by overwriting the weak
pcibios_root_bridge_prepare function which is called by
pci_create_root_bus().

From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
Signed-off-by: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h       |    3 ++
 arch/powerpc/kernel/pci-common.c         |    8 ++++
 arch/powerpc/platforms/pseries/pci.c     |   53 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pseries.h |    4 ++
 arch/powerpc/platforms/pseries/setup.c   |    2 +
 5 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 3f3f691..92386fc 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -29,6 +29,7 @@ struct rtc_time;
 struct file;
 struct pci_controller;
 struct kimage;
+struct pci_host_bridge;
 
 struct machdep_calls {
 	char		*name;
@@ -108,6 +109,8 @@ struct machdep_calls {
 	void		(*pcibios_fixup)(void);
 	int		(*pci_probe_mode)(struct pci_bus *);
 	void		(*pci_irq_fixup)(struct pci_dev *dev);
+	int		(*pcibios_root_bridge_prepare)(struct pci_host_bridge
+				*bridge);
 
 	/* To setup PHBs when using automatic OF platform driver for PCI */
 	int		(*pci_setup_phb)(struct pci_controller *host);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index f325dc9..d5811d8 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -845,6 +845,14 @@ int pci_proc_domain(struct pci_bus *bus)
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
index 0b580f4..5f93856 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -108,3 +108,56 @@ static void fixup_winbond_82c105(struct pci_dev* dev)
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
+	for (pdn = dn; pdn != NULL; pdn = of_get_next_parent(pdn)) {
+		pcie_link_speed_stats = (const uint32_t *) of_get_property(pdn,
+			"ibm,pcie-link-speed-stats", NULL);
+		if (pcie_link_speed_stats)
+			break;
+	}
+
+	of_node_put(pdn);
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
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 8af71e4..c2a3a25 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -63,4 +63,8 @@ extern int dlpar_detach_node(struct device_node *);
 /* Snooze Delay, pseries_idle */
 DECLARE_PER_CPU(long, smt_snooze_delay);
 
+/* PCI root bridge prepare function override for pseries */
+struct pci_host_bridge;
+int pseries_root_bridge_prepare(struct pci_host_bridge *bridge);
+
 #endif /* _PSERIES_PSERIES_H */
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index ac932a9..c11c823 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -466,6 +466,8 @@ static void __init pSeries_setup_arch(void)
 	else
 		ppc_md.enable_pmcs = power4_enable_pmcs;
 
+	ppc_md.pcibios_root_bridge_prepare = pseries_root_bridge_prepare;
+
 	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
 		long rc;
 		if ((rc = pSeries_enable_reloc_on_exc()) != H_SUCCESS) {
-- 
1.7.1
