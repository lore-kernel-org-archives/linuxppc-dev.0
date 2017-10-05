Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7NLl4hz3zDrLB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 06:36:47 +1100 (AEDT)
Subject: [PATCH 1/2] powerpc/platforms/cell: Delete an error message for a
 failed memory allocation in three functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jeremy Kerr <jk@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <db9efaf4-f3d7-d5dc-b0b2-f20e418fa3c8@users.sourceforge.net>
Message-ID: <62146108-5be0-c236-f404-4be122e162ac@users.sourceforge.net>
Date: Thu, 5 Oct 2017 21:36:26 +0200
MIME-Version: 1.0
In-Reply-To: <db9efaf4-f3d7-d5dc-b0b2-f20e418fa3c8@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 5 Oct 2017 21:04:30 +0200

Omit extra messages for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/platforms/cell/axon_msi.c   | 5 +----
 arch/powerpc/platforms/cell/spider-pci.c | 9 ++-------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 6ea3f248b155..513d13d779b3 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -343,11 +343,8 @@ static int axon_msi_probe(struct platform_device *device)
 	pr_devel("axon_msi: setting up dn %pOF\n", dn);
 
 	msic = kzalloc(sizeof(struct axon_msic), GFP_KERNEL);
-	if (!msic) {
-		printk(KERN_ERR "axon_msi: couldn't allocate msic for %pOF\n",
-		       dn);
+	if (!msic)
 		goto out;
-	}
 
 	dcr_base = dcr_resource_start(dn, 0);
 	dcr_len = dcr_resource_len(dn, 0);
diff --git a/arch/powerpc/platforms/cell/spider-pci.c b/arch/powerpc/platforms/cell/spider-pci.c
index d1e61e273e64..0a9f00563144 100644
--- a/arch/powerpc/platforms/cell/spider-pci.c
+++ b/arch/powerpc/platforms/cell/spider-pci.c
@@ -104,10 +104,8 @@ static int __init spiderpci_pci_setup_chip(struct pci_controller *phb,
 	 * Celleb does not have this problem, because it has only one XDR.
 	 */
 	dummy_page_va = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!dummy_page_va) {
-		pr_err("SPIDERPCI-IOWA:Alloc dummy_page_va failed.\n");
+	if (!dummy_page_va)
 		return -1;
-	}
 
 	dummy_page_da = dma_map_single(phb->parent, dummy_page_va,
 				       PAGE_SIZE, DMA_FROM_DEVICE);
@@ -134,11 +132,8 @@ int __init spiderpci_iowa_init(struct iowa_bus *bus, void *data)
 		 np);
 
 	priv = kzalloc(sizeof(struct spiderpci_iowa_private), GFP_KERNEL);
-	if (!priv) {
-		pr_err("SPIDERPCI-IOWA:"
-		       "Can't allocate struct spiderpci_iowa_private");
+	if (!priv)
 		return -1;
-	}
 
 	if (of_address_to_resource(np, 0, &r)) {
 		pr_err("SPIDERPCI-IOWA:Can't get resource.\n");
-- 
2.14.2
