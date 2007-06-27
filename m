Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B460DDF48
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 11:16:49 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/15] [POWERPC] Remove bus_offset in places its not really
	used
Date: Tue, 26 Jun 2007 20:16:35 -0500
Message-Id: <11829070111239-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11829070102887-git-send-email-galak@kernel.crashing.org>
References: <11829070051484-git-send-email-galak@kernel.crashing.org>
	<11829070063989-git-send-email-galak@kernel.crashing.org>
	<11829070073637-git-send-email-galak@kernel.crashing.org>
	<11829070091056-git-send-email-galak@kernel.crashing.org>
	<11829070102887-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The user of the fsl_pcie code doesn't set bus_offset and 82xx doesn't
require it either.  Remove the places in the code that reference it so
we can remove it all together.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/82xx/mpc82xx_ads.c |    1 -
 arch/powerpc/sysdev/fsl_pcie.c            |    8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/mpc82xx_ads.c b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
index 715107b..d1e0919 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -552,7 +552,6 @@ static void __init mpc82xx_add_bridge(struct device_node *np)
 
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
-	hose->bus_offset = 0;
 
 	setup_indirect_pci(hose,
 			   r.start + offsetof(pci_cpm2_t, pci_cfg_addr),
diff --git a/arch/powerpc/sysdev/fsl_pcie.c b/arch/powerpc/sysdev/fsl_pcie.c
index 6bbd7f8..ea3ec6b 100644
--- a/arch/powerpc/sysdev/fsl_pcie.c
+++ b/arch/powerpc/sysdev/fsl_pcie.c
@@ -50,12 +50,12 @@ indirect_read_config_pcie(struct pci_bus *bus, unsigned int devfn, int offset,
 	if (bus->number == 0xff) {
 		PCI_CFG_OUT(hose->cfg_addr,
 			    (0x80000000 | ((offset & 0xf00) << 16) |
-			     ((bus->number - hose->bus_offset) << 16)
+			     (bus->number<< 16)
 			     | (devfn << 8) | ((offset & 0xfc) )));
 	} else {
 		PCI_CFG_OUT(hose->cfg_addr,
 			    (0x80000001 | ((offset & 0xf00) << 16) |
-			     ((bus->number - hose->bus_offset) << 16)
+			     (bus->number<< 16)
 			     | (devfn << 8) | ((offset & 0xfc) )));
 	}
 
@@ -101,12 +101,12 @@ indirect_write_config_pcie(struct pci_bus *bus, unsigned int devfn, int offset,
 	if (bus->number == 0xff) {
 		PCI_CFG_OUT(hose->cfg_addr,
 			    (0x80000000 | ((offset & 0xf00) << 16) |
-			     ((bus->number - hose->bus_offset) << 16)
+			     (bus->number << 16)
 			     | (devfn << 8) | ((offset & 0xfc) )));
 	} else {
 		PCI_CFG_OUT(hose->cfg_addr,
 			    (0x80000001 | ((offset & 0xf00) << 16) |
-			     ((bus->number - hose->bus_offset) << 16)
+			     (bus->number << 16)
 			     | (devfn << 8) | ((offset & 0xfc) )));
         }
 
-- 
1.5.2.1
