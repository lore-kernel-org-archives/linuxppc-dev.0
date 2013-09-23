Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 21/39] powerpc: Little endian fix for
 arch/powerpc/platforms/powernv/pci.c
Date: Mon, 23 Sep 2013 12:04:55 +1000
Message-Id: <1379901913-5945-22-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alistair Popple <alistair@popple.id.au>

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index a28d3b5..9122215 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -462,8 +462,8 @@ void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 static struct iommu_table *pnv_pci_setup_bml_iommu(struct pci_controller *hose)
 {
 	struct iommu_table *tbl;
-	const __be64 *basep, *swinvp;
-	const __be32 *sizep;
+	const __be64 *basep;
+	const __be32 *sizep, *swinvp;
 
 	basep = of_get_property(hose->dn, "linux,tce-base", NULL);
 	sizep = of_get_property(hose->dn, "linux,tce-size", NULL);
@@ -484,8 +484,9 @@ static struct iommu_table *pnv_pci_setup_bml_iommu(struct pci_controller *hose)
 	swinvp = of_get_property(hose->dn, "linux,tce-sw-invalidate-info",
 				 NULL);
 	if (swinvp) {
-		tbl->it_busno = swinvp[1];
-		tbl->it_index = (unsigned long)ioremap(swinvp[0], 8);
+		tbl->it_busno = of_read_ulong(&swinvp[1], 2);
+		tbl->it_index =
+			(unsigned long)ioremap(of_read_number(swinvp, 2), 8);
 		tbl->it_type = TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE;
 	}
 	return tbl;
-- 
1.8.1.2
