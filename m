Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 281C8DE29D
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 03:48:47 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l51HmhGR019721
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 10:48:44 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l51HmhYC021432
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jun 2007 12:48:43 -0500 (CDT)
Subject: [PATCH 4/8] Float the PCi bus number assignments on MPC8641HPCN board.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180720123.14219.64.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 01 Jun 2007 12:48:43 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Zhang Wei <wei.zhang@freescale.com>

Admittedly this is a non-ideal solution, but fixing it
properly might require systemic PCI bus renumbering
changes that we are not prepared to do yet.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Acked-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    1 +
 arch/powerpc/platforms/86xx/pci.c          |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 1051702..9259788 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -363,6 +363,7 @@ mpc86xx_hpcn_setup_arch(void)
 	}
 
 #ifdef CONFIG_PCI
+	pci_assign_all_buses = 1;
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		add_bridge(np);
 
diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
index 07ff52c..c80d8f1 100644
--- a/arch/powerpc/platforms/86xx/pci.c
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -136,6 +136,18 @@ mpc86xx_setup_pcie(struct pci_controller *hose, u32 pcie_offset, u32 pcie_size)
 
 int mpc86xx_exclude_device(u_char bus, u_char devfn)
 {
+	struct pci_controller *hose;
+
+	hose = pci_bus_to_hose(bus);
+	if (unlikely(!hose))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/* Correcting the hose->bus_offset value. */
+	out_be32(hose->cfg_addr, 0x80000000 | ((hose->first_busno
+					- hose->bus_offset) << 16));
+	if (unlikely(in_le32(hose->cfg_data) == 0xffffffff))
+		hose->bus_offset = hose->bus_offset ? 0 : hose->first_busno;
+
 	return PCIBIOS_SUCCESSFUL;
 }
 
-- 
1.5.0.3
