Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <0b387331e009ac9f3bf5523bfe968a5621c9229f.1232693349.git.michael@ellerman.id.au>
In-Reply-To: <1859474fb4aabec9224df5ea2263180d504913fd.1232693349.git.michael@ellerman.id.au>
References: <1859474fb4aabec9224df5ea2263180d504913fd.1232693349.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/4] powerpc: pseries/msi: Return the number of MSIs we could
	allocate
Date: Fri, 23 Jan 2009 17:54:33 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If we can't allocate the requested number of MSIs, we can still tell the
generic code how many we were able to allocate. That can then be passed
onto the driver, allowing it to request that many in future, and
probably succeeed.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/msi.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index e6c80ac..073b518 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -71,11 +71,13 @@ static int rtas_change_msi(struct pci_dn *pdn, u32 func, u32 num_irqs)
 	} while (rtas_busy_delay(rc));
 
 	/*
-	 * If the RTAS call succeeded, check the number of irqs is actually
-	 * what we asked for. If not, return an error.
+	 * If the RTAS call succeeded, return the number of irqs allocated.
+	 * If not, make sure we return a negative error code.
 	 */
-	if (rc == 0 && rtas_ret[0] != num_irqs)
-		rc = -ENOSPC;
+	if (rc == 0)
+		rc = rtas_ret[0];
+	else if (rc > 0)
+		rc = -rc;
 
 	pr_debug("rtas_msi: ibm,change_msi(func=%d,num=%d), got %d rc = %d\n",
 		 func, num_irqs, rtas_ret[0], rc);
@@ -91,7 +93,7 @@ static void rtas_disable_msi(struct pci_dev *pdev)
 	if (!pdn)
 		return;
 
-	if (rtas_change_msi(pdn, RTAS_CHANGE_FN, 0))
+	if (rtas_change_msi(pdn, RTAS_CHANGE_FN, 0) != 0)
 		pr_debug("rtas_msi: Setting MSIs to 0 failed!\n");
 }
 
@@ -195,14 +197,14 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	if (type == PCI_CAP_ID_MSI) {
 		rc = rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, nvec);
 
-		if (rc) {
+		if (rc < 0) {
 			pr_debug("rtas_msi: trying the old firmware call.\n");
 			rc = rtas_change_msi(pdn, RTAS_CHANGE_FN, nvec);
 		}
 	} else
 		rc = rtas_change_msi(pdn, RTAS_CHANGE_MSIX_FN, nvec);
 
-	if (rc) {
+	if (rc != nvec) {
 		pr_debug("rtas_msi: rtas_change_msi() failed\n");
 		return rc;
 	}
-- 
1.5.3.7.1.g4e596e
