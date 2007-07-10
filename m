Return-Path: <wei.zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B8346DDEC8
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 16:26:27 +1000 (EST)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org, galak@kernel.crashing.org
Subject: [PATCH] Fix the PCI-Ex link training bug on MPC8641HPCN board.
Date: Tue, 10 Jul 2007 14:34:12 +0800
Message-Id: <11840492523488-git-send-email-wei.zhang@freescale.com>
Sender: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If the PCI-Ex hose link training is failed, the kernel will halt at the
PCI scan process on MPC8641HPCN board.

This patch will remove and free the hose from PCI host list if the
PCI hose link training is failed.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 arch/powerpc/platforms/86xx/pci.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
index 73cd5b0..0b7835c 100644
--- a/arch/powerpc/platforms/86xx/pci.c
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -210,8 +210,10 @@ int __init mpc86xx_add_bridge(struct device_node *dev)
 
 	/* Probe the hose link training status */
 	early_read_config_word(hose, 0, 0, PCIE_LTSSM, &val);
-	if (val < PCIE_LTSSM_L0)
+	if (val < PCIE_LTSSM_L0) {
+		pcibios_free_controller(hose);
 		return -ENXIO;
+	}
 
 	/* Setup the PCIE host controller. */
 	mpc86xx_setup_pcie(hose, rsrc.start, rsrc.end - rsrc.start + 1);
-- 
1.5.1
