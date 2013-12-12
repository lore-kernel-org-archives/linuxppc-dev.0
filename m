Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	Ulrich.Weigand@de.ibm.com
Subject: [PATCH 6/8] powerpc/pseries: Fix PCIE link speed endian issue
Date: Thu, 12 Dec 2013 15:59:39 +1100
Message-Id: <1386824381-14032-7-git-send-email-anton@samba.org>
In-Reply-To: <1386824381-14032-1-git-send-email-anton@samba.org>
References: <1386824381-14032-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to byteswap ibm,pcie-link-speed-stats.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/pseries/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 5f93856..70670a2 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -113,7 +113,7 @@ int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
 	struct device_node *dn, *pdn;
 	struct pci_bus *bus;
-	const uint32_t *pcie_link_speed_stats;
+	const __be32 *pcie_link_speed_stats;
 
 	bus = bridge->bus;
 
@@ -122,7 +122,7 @@ int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
 		return 0;
 
 	for (pdn = dn; pdn != NULL; pdn = of_get_next_parent(pdn)) {
-		pcie_link_speed_stats = (const uint32_t *) of_get_property(pdn,
+		pcie_link_speed_stats = of_get_property(pdn,
 			"ibm,pcie-link-speed-stats", NULL);
 		if (pcie_link_speed_stats)
 			break;
@@ -135,7 +135,7 @@ int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
 		return 0;
 	}
 
-	switch (pcie_link_speed_stats[0]) {
+	switch (be32_to_cpup(pcie_link_speed_stats)) {
 	case 0x01:
 		bus->max_bus_speed = PCIE_SPEED_2_5GT;
 		break;
@@ -147,7 +147,7 @@ int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
 		break;
 	}
 
-	switch (pcie_link_speed_stats[1]) {
+	switch (be32_to_cpup(pcie_link_speed_stats)) {
 	case 0x01:
 		bus->cur_bus_speed = PCIE_SPEED_2_5GT;
 		break;
-- 
1.8.3.2
