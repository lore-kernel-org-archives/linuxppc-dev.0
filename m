Return-Path: <nacc@us.ibm.com>
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH 11/15] ppc/cell: beat dma ops cleanup
Date: Wed, 15 Sep 2010 11:05:54 -0700
Message-Id: <1284573958-8397-12-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
Cc: cbe-oss-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	Milton Miller <miltonm@bga.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

direct_dma_ops is the default pci dma ops.

No need to call a function to get the pci dma ops, we know they are the
dma_direct_ops.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/platforms/cell/beat_iommu.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/beat_iommu.c b/arch/powerpc/platforms/cell/beat_iommu.c
index beec405..3ce6855 100644
--- a/arch/powerpc/platforms/cell/beat_iommu.c
+++ b/arch/powerpc/platforms/cell/beat_iommu.c
@@ -76,7 +76,7 @@ static void __init celleb_init_direct_mapping(void)
 
 static void celleb_dma_dev_setup(struct device *dev)
 {
-	dev->archdata.dma_ops = get_pci_dma_ops();
+	set_dma_ops(dev, &dma_direct_ops);
 	set_dma_offset(dev, celleb_dma_direct_offset);
 }
 
@@ -106,7 +106,6 @@ static struct notifier_block celleb_of_bus_notifier = {
 static int __init celleb_init_iommu(void)
 {
 	celleb_init_direct_mapping();
-	set_pci_dma_ops(&dma_direct_ops);
 	ppc_md.pci_dma_dev_setup = celleb_pci_dma_dev_setup;
 	bus_register_notifier(&platform_bus_type, &celleb_of_bus_notifier);
 
-- 
1.7.0.4
