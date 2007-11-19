Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 02C29DDDF3
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 17:03:52 +1100 (EST)
Date: Mon, 19 Nov 2007 17:03:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] iSeries: mark two functions __init
Message-Id: <20071119170359.0947b921.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/pci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index da87162..a74d1e1 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -87,7 +87,7 @@ static DEFINE_SPINLOCK(iomm_table_lock);
  * - CurrentIndex is incremented to keep track of the last entry.
  * - Builds the resource entry for allocated BARs.
  */
-static void iomm_table_allocate_entry(struct pci_dev *dev, int bar_num)
+static void __init iomm_table_allocate_entry(struct pci_dev *dev, int bar_num)
 {
 	struct resource *bar_res = &dev->resource[bar_num];
 	long bar_size = pci_resource_len(dev, bar_num);
@@ -130,7 +130,7 @@ static void iomm_table_allocate_entry(struct pci_dev *dev, int bar_num)
  * - Loops through The Bar resources(0 - 5) including the ROM
  *   is resource(6).
  */
-static void allocate_device_bars(struct pci_dev *dev)
+static void __init allocate_device_bars(struct pci_dev *dev)
 {
 	int bar_num;
 
-- 
1.5.3.5
