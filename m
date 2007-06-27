Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD9C7DDE10
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 11:16:45 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/15] [POWERPC] 52xx: Remove support for PCI bus_offset
Date: Tue, 26 Jun 2007 20:16:32 -0500
Message-Id: <11829070073637-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11829070063989-git-send-email-galak@kernel.crashing.org>
References: <11829070051484-git-send-email-galak@kernel.crashing.org>
	<11829070063989-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The hose->bus_offset is only used for PCI config cycles and the 52xx PCI
config code doesn't actually ever set bus_offset to a non-zero value.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/52xx/mpc52xx_pci.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index 51164c8..57ca2fe 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -117,13 +117,13 @@ mpc52xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 
 	out_be32(hose->cfg_addr,
 		(1 << 31) |
-		((bus->number - hose->bus_offset) << 16) |
+		(bus->number << 16) |
 		(devfn << 8) |
 		(offset & 0xfc));
 	mb();
 
 #if defined(CONFIG_PPC_MPC5200_BUGFIX)
-	if (bus->number != hose->bus_offset) {
+	if (bus->number) {
 		/* workaround for the bug 435 of the MPC5200 (L25R);
 		 * Don't do 32 bits config access during type-1 cycles */
 		switch (len) {
@@ -174,13 +174,13 @@ mpc52xx_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 
 	out_be32(hose->cfg_addr,
 		(1 << 31) |
-		((bus->number - hose->bus_offset) << 16) |
+		(bus->number << 16) |
 		(devfn << 8) |
 		(offset & 0xfc));
 	mb();
 
 #if defined(CONFIG_PPC_MPC5200_BUGFIX)
-	if (bus->number != hose->bus_offset) {
+	if (bus->number) {
 		/* workaround for the bug 435 of the MPC5200 (L25R);
 		 * Don't do 32 bits config access during type-1 cycles */
 		switch (len) {
@@ -394,7 +394,6 @@ mpc52xx_add_bridge(struct device_node *node)
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
-	hose->bus_offset = 0;
 	hose->ops = &mpc52xx_pci_ops;
 
 	pci_regs = ioremap(rsrc.start, rsrc.end - rsrc.start + 1);
-- 
1.5.2.1
