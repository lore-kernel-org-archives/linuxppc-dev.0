Return-Path: <yinghai@kernel.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8Nwn6qgbzDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 15:05:45 +1000 (AEST)
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
 Khalid Aziz <khalid.aziz@oracle.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/13] powerpc/PCI: Keep resource idx order with bridge
 register number
Date: Thu, 20 Apr 2017 22:04:53 -0700
Message-Id: <20170421050500.13957-7-yinghai@kernel.org>
In-Reply-To: <20170421050500.13957-1-yinghai@kernel.org>
References: <20170421050500.13957-1-yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Same as sparc version.

Make resource with consistent sequence
like other arch or directly from pci_read_bridge_bases(),
even when non-pref mmio is missing, or out of ordering in firmware reporting.

Just hold i = 1 for non pref mmio, and i = 2 for pref mmio.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/pci_of_scan.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index ea3d981..9581e00 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -252,7 +252,7 @@ void of_scan_pci_bridge(struct pci_dev *dev)
 		bus->resource[i] = res;
 		++res;
 	}
-	i = 1;
+	i = 3;
 	for (; len >= 32; len -= 32, ranges += 8) {
 		flags = pci_parse_of_flags(of_read_number(ranges, 1), 1);
 		size = of_read_number(&ranges[6], 2);
@@ -265,6 +265,12 @@ void of_scan_pci_bridge(struct pci_dev *dev)
 				       " for bridge %s\n", node->full_name);
 				continue;
 			}
+		} else if ((flags & IORESOURCE_PREFETCH) &&
+			   !bus->resource[2]->flags) {
+			res = bus->resource[2];
+		} else if (((flags & (IORESOURCE_MEM | IORESOURCE_PREFETCH)) ==
+			    IORESOURCE_MEM) && !bus->resource[1]->flags) {
+			res = bus->resource[1];
 		} else {
 			if (i >= PCI_NUM_RESOURCES - PCI_BRIDGE_RESOURCES) {
 				printk(KERN_ERR "PCI: too many memory ranges"
-- 
2.9.3
