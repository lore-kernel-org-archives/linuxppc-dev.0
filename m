Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <ee8cba6700ad2d6d0967e49ac5bfd2e4f01b5d84.1232693349.git.michael@ellerman.id.au>
In-Reply-To: <1859474fb4aabec9224df5ea2263180d504913fd.1232693349.git.michael@ellerman.id.au>
References: <1859474fb4aabec9224df5ea2263180d504913fd.1232693349.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/4] powerpc/pseries: Check for MSI-X also in
	rtas_msi_pci_irq_fixup()
Date: Fri, 23 Jan 2009 17:54:32 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We also need to check that the device isn't using MSI-X in the irq fixup
routine, otherwise we might leave MSI-Xs configured at boot.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/msi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index acf1070..e6c80ac 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -244,8 +244,8 @@ static void rtas_msi_pci_irq_fixup(struct pci_dev *pdev)
 	}
 
 	/* No MSI -> MSIs can't have been assigned by fw, leave LSI */
-	if (check_req_msi(pdev, 1)) {
-		dev_dbg(&pdev->dev, "rtas_msi: no req#msi, nothing to do.\n");
+	if (check_req_msi(pdev, 1) && check_req_msix(pdev, 1)) {
+		dev_dbg(&pdev->dev, "rtas_msi: no req#msi/x, nothing to do.\n");
 		return;
 	}
 
-- 
1.5.3.7.1.g4e596e
