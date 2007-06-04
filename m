Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 85A15DDFC1
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 08:30:12 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l54MU7KD009151
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 15:30:07 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l54MU6M1021876
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 17:30:07 -0500 (CDT)
Subject: [PATCH v2 4/9] Float the PCi bus number assignments on MPC8641HPCN
	board.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180996206.9632.72.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 04 Jun 2007 17:30:06 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Zhang Wei <wei.zhang@freescale.com>

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
