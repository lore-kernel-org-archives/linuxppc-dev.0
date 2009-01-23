Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <0ad243517309b952d0d4bca15afd49da23dd31f3.1232693349.git.michael@ellerman.id.au>
In-Reply-To: <1859474fb4aabec9224df5ea2263180d504913fd.1232693349.git.michael@ellerman.id.au>
References: <1859474fb4aabec9224df5ea2263180d504913fd.1232693349.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/4] powerpc/pseries: Add support for ibm,req#msi-x
Date: Fri, 23 Jan 2009 17:54:31 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Firmware encodes the number of MSI-X requested by a device in a
different property than for MSI. Pull the property name out as a
parameter and share the logic for both cases.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/msi.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 4af7aa3..acf1070 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -132,7 +132,7 @@ static void rtas_teardown_msi_irqs(struct pci_dev *pdev)
 	rtas_disable_msi(pdev);
 }
 
-static int check_req_msi(struct pci_dev *pdev, int nvec)
+static int check_req(struct pci_dev *pdev, int nvec, char *prop_name)
 {
 	struct device_node *dn;
 	struct pci_dn *pdn;
@@ -144,24 +144,34 @@ static int check_req_msi(struct pci_dev *pdev, int nvec)
 
 	dn = pdn->node;
 
-	req_msi = of_get_property(dn, "ibm,req#msi", NULL);
+	req_msi = of_get_property(dn, prop_name, NULL);
 	if (!req_msi) {
-		pr_debug("rtas_msi: No ibm,req#msi on %s\n", dn->full_name);
+		pr_debug("rtas_msi: No %s on %s\n", prop_name, dn->full_name);
 		return -ENOENT;
 	}
 
 	if (*req_msi < nvec) {
-		pr_debug("rtas_msi: ibm,req#msi requests < %d MSIs\n", nvec);
+		pr_debug("rtas_msi: %s requests < %d MSIs\n", prop_name, nvec);
 		return -ENOSPC;
 	}
 
 	return 0;
 }
 
+static int check_req_msi(struct pci_dev *pdev, int nvec)
+{
+	return check_req(pdev, nvec, "ibm,req#msi");
+}
+
+static int check_req_msix(struct pci_dev *pdev, int nvec)
+{
+	return check_req(pdev, nvec, "ibm,req#msi-x");
+}
+
 static int rtas_msi_check_device(struct pci_dev *pdev, int nvec, int type)
 {
 	if (type == PCI_CAP_ID_MSIX)
-		pr_debug("rtas_msi: MSI-X untested, trying anyway.\n");
+		return check_req_msix(pdev, nvec);
 
 	return check_req_msi(pdev, nvec);
 }
-- 
1.5.3.7.1.g4e596e
