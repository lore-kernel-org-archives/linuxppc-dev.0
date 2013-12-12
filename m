Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	Ulrich.Weigand@de.ibm.com
Subject: [PATCH 7/8] powerpc/pseries: Fix endian issues in MSI code
Date: Thu, 12 Dec 2013 15:59:40 +1100
Message-Id: <1386824381-14032-8-git-send-email-anton@samba.org>
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

The MSI code is miscalculating quotas in little endian mode.
Add required byteswaps to fix this.

Before we claimed a quota of 65536, after the patch we
see the correct value of 256.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/pseries/msi.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 6d2f0ab..0c882e8 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -130,7 +130,8 @@ static int check_req(struct pci_dev *pdev, int nvec, char *prop_name)
 {
 	struct device_node *dn;
 	struct pci_dn *pdn;
-	const u32 *req_msi;
+	const __be32 *p;
+	u32 req_msi;
 
 	pdn = pci_get_pdn(pdev);
 	if (!pdn)
@@ -138,19 +139,20 @@ static int check_req(struct pci_dev *pdev, int nvec, char *prop_name)
 
 	dn = pdn->node;
 
-	req_msi = of_get_property(dn, prop_name, NULL);
-	if (!req_msi) {
+	p = of_get_property(dn, prop_name, NULL);
+	if (!p) {
 		pr_debug("rtas_msi: No %s on %s\n", prop_name, dn->full_name);
 		return -ENOENT;
 	}
 
-	if (*req_msi < nvec) {
+	req_msi = be32_to_cpup(p);
+	if (req_msi < nvec) {
 		pr_debug("rtas_msi: %s requests < %d MSIs\n", prop_name, nvec);
 
-		if (*req_msi == 0) /* Be paranoid */
+		if (req_msi == 0) /* Be paranoid */
 			return -ENOSPC;
 
-		return *req_msi;
+		return req_msi;
 	}
 
 	return 0;
@@ -171,7 +173,7 @@ static int check_req_msix(struct pci_dev *pdev, int nvec)
 static struct device_node *find_pe_total_msi(struct pci_dev *dev, int *total)
 {
 	struct device_node *dn;
-	const u32 *p;
+	const __be32 *p;
 
 	dn = of_node_get(pci_device_to_OF_node(dev));
 	while (dn) {
@@ -179,7 +181,7 @@ static struct device_node *find_pe_total_msi(struct pci_dev *dev, int *total)
 		if (p) {
 			pr_debug("rtas_msi: found prop on dn %s\n",
 				dn->full_name);
-			*total = *p;
+			*total = be32_to_cpup(p);
 			return dn;
 		}
 
@@ -232,13 +234,13 @@ struct msi_counts {
 static void *count_non_bridge_devices(struct device_node *dn, void *data)
 {
 	struct msi_counts *counts = data;
-	const u32 *p;
+	const __be32 *p;
 	u32 class;
 
 	pr_debug("rtas_msi: counting %s\n", dn->full_name);
 
 	p = of_get_property(dn, "class-code", NULL);
-	class = p ? *p : 0;
+	class = p ? be32_to_cpup(p) : 0;
 
 	if ((class >> 8) != PCI_CLASS_BRIDGE_PCI)
 		counts->num_devices++;
@@ -249,7 +251,7 @@ static void *count_non_bridge_devices(struct device_node *dn, void *data)
 static void *count_spare_msis(struct device_node *dn, void *data)
 {
 	struct msi_counts *counts = data;
-	const u32 *p;
+	const __be32 *p;
 	int req;
 
 	if (dn == counts->requestor)
@@ -260,11 +262,11 @@ static void *count_spare_msis(struct device_node *dn, void *data)
 		req = 0;
 		p = of_get_property(dn, "ibm,req#msi", NULL);
 		if (p)
-			req = *p;
+			req = be32_to_cpup(p);
 
 		p = of_get_property(dn, "ibm,req#msi-x", NULL);
 		if (p)
-			req = max(req, (int)*p);
+			req = max(req, (int)be32_to_cpup(p));
 	}
 
 	if (req < counts->quota)
-- 
1.8.3.2
