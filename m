Return-Path: <klebers@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5CEA02C0245
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 00:57:29 +1100 (EST)
Received: from /spool/local
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <klebers@linux.vnet.ibm.com>;
 Fri, 17 Jan 2014 11:57:22 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 4EAEA3520065
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 08:57:18 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0HDuns046399572
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 11:56:49 -0200
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0HDvJPO018006
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 11:57:19 -0200
From: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/pseries: fix regression on PCI link speed
Date: Fri, 17 Jan 2014 11:56:51 -0200
Message-Id: <1389967012-7774-2-git-send-email-klebers@linux.vnet.ibm.com>
In-Reply-To: <1389967012-7774-1-git-send-email-klebers@linux.vnet.ibm.com>
References: <1389967012-7774-1-git-send-email-klebers@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 5091f0c (powerpc/pseries: Fix PCIE link speed endian issue)
introduced a regression on the PCI link speed detection using the
device-tree property. The ibm,pcie-link-speed-stats property is composed
of two 32-bit integers, the first one being the maxinum link speed and
the second the current link speed. The changes introduced by the
aforementioned commit are considering just the first integer.

Fix this issue by changing how the property is accessed, using the
helper functions to properly access the array of values. The explicit
byte swapping is not needed anymore here, since it's done by the helper
functions.

Signed-off-by: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/pci.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 70670a2..a6f7a14 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -113,7 +113,8 @@ int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
 	struct device_node *dn, *pdn;
 	struct pci_bus *bus;
-	const __be32 *pcie_link_speed_stats;
+	u32 pcie_link_speed_stats[2];
+	int rc;
 
 	bus = bridge->bus;
 
@@ -122,20 +123,21 @@ int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
 		return 0;
 
 	for (pdn = dn; pdn != NULL; pdn = of_get_next_parent(pdn)) {
-		pcie_link_speed_stats = of_get_property(pdn,
-			"ibm,pcie-link-speed-stats", NULL);
-		if (pcie_link_speed_stats)
+		rc = of_property_read_u32_array(pdn,
+				"ibm,pcie-link-speed-stats",
+				&pcie_link_speed_stats[0], 2);
+		if (!rc)
 			break;
 	}
 
 	of_node_put(pdn);
 
-	if (!pcie_link_speed_stats) {
+	if (rc) {
 		pr_err("no ibm,pcie-link-speed-stats property\n");
 		return 0;
 	}
 
-	switch (be32_to_cpup(pcie_link_speed_stats)) {
+	switch (pcie_link_speed_stats[0]) {
 	case 0x01:
 		bus->max_bus_speed = PCIE_SPEED_2_5GT;
 		break;
@@ -147,7 +149,7 @@ int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
 		break;
 	}
 
-	switch (be32_to_cpup(pcie_link_speed_stats)) {
+	switch (pcie_link_speed_stats[1]) {
 	case 0x01:
 		bus->cur_bus_speed = PCIE_SPEED_2_5GT;
 		break;
-- 
1.7.1
