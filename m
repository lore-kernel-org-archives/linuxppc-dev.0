Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7lRQ5HMkzDqdv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 16:55:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: gpiccoli@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/pci: Fix endian bug in fixed PHB numbering
Date: Tue,  9 Aug 2016 16:55:41 +1000
Message-Id: <1470725741-26118-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent commit 63a72284b159 ("powerpc/pci: Assign fixed PHB number
based on device-tree properties"), added code to read a 64-bit property
from the device tree, and if not found read a 32-bit property (reg).

There was a bug in the 32-bit case, on big endian machines, due to the
use of the 64-bit value to read the 32-bit property. The cast of &prop
means we end up writing to the high 32-bit of prop, leaving the low
32-bits containing whatever junk was on the stack.

If that junk value was non-zero, and < MAX_PHBS, we would end up using
it as the PHB id. This results in users seeing what appear to be random
PHB ids.

Fix it by reading into a u32 property and then assigning that to the
u64 value, letting the CPU do the correct conversions for us.

Fixes: 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on device-tree properties")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/pci-common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index a5c0153ede37..7fdf324d5b51 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -78,6 +78,7 @@ EXPORT_SYMBOL(get_pci_dma_ops);
 static int get_phb_number(struct device_node *dn)
 {
 	int ret, phb_id = -1;
+	u32 prop_32;
 	u64 prop;
 
 	/*
@@ -86,8 +87,10 @@ static int get_phb_number(struct device_node *dn)
 	 * reading "ibm,opal-phbid", only present in OPAL environment.
 	 */
 	ret = of_property_read_u64(dn, "ibm,opal-phbid", &prop);
-	if (ret)
-		ret = of_property_read_u32_index(dn, "reg", 1, (u32 *)&prop);
+	if (ret) {
+		ret = of_property_read_u32_index(dn, "reg", 1, &prop_32);
+		prop = prop_32;
+	}
 
 	if (!ret)
 		phb_id = (int)(prop & (MAX_PHBS - 1));
-- 
2.7.4
