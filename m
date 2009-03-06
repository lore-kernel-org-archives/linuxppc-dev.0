Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <f15ac3f60d5b983c81dfc2e17039bddf2db63bad.1236300218.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/pseries: Reject discontiguous/non-zero based MSI-X
	requests
Date: Fri,  6 Mar 2009 11:44:26 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's no way for us to express to firmware that we want a
discontiguous, or non-zero based, range of MSI-X entries. So we
must reject such requests.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/msi.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 3e0d6ef..bf2e1ac 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -356,6 +356,27 @@ static int rtas_msi_check_device(struct pci_dev *pdev, int nvec, int type)
 	return 0;
 }
 
+static int check_msix_entries(struct pci_dev *pdev)
+{
+	struct msi_desc *entry;
+	int expected;
+
+	/* There's no way for us to express to firmware that we want
+	 * a discontiguous, or non-zero based, range of MSI-X entries.
+	 * So we must reject such requests. */
+
+	expected = 0;
+	list_for_each_entry(entry, &pdev->msi_list, list) {
+		if (entry->msi_attrib.entry_nr != expected) {
+			pr_debug("rtas_msi: bad MSI-X entries.\n");
+			return -EINVAL;
+		}
+		expected++;
+	}
+
+	return 0;
+}
+
 static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
 	struct pci_dn *pdn;
@@ -367,6 +388,9 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	if (!pdn)
 		return -ENODEV;
 
+	if (type == PCI_CAP_ID_MSIX && check_msix_entries(pdev))
+		return -EINVAL;
+
 	/*
 	 * Try the new more explicit firmware interface, if that fails fall
 	 * back to the old interface. The old interface is known to never
-- 
1.6.1.2
