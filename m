Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5HJG2LL0zDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 16:41:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: gpiccoli@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, chzigotzky@xenosoft.de
Subject: [PATCH] powerpc/pci: Only do fixed PHB numbering on powernv
Date: Fri,  5 Aug 2016 16:40:56 +1000
Message-Id: <1470379256-24266-1-git-send-email-mpe@ellerman.id.au>
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
it as the PHB id.

This exposed a second problem, which is that Xorg can't cope with a
domain number > 256.

So for now drop the fallback to reg, and only use "ibm,opal-phbid" for
PHB numbering.

Fixes: 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on device-tree properties")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/pci-common.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)


This is my bad. Guilherme limited the reg case to pseries only, but I made it
generic. I tested it on G5, Cell etc. which all booted - but that's not really
a good enough test.

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index f93942b4b6a6..f9c2ffaa1884 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -77,29 +77,23 @@ EXPORT_SYMBOL(get_pci_dma_ops);
  */
 static int get_phb_number(struct device_node *dn)
 {
-	int ret, phb_id = -1;
+	int ret, phb_id;
 	u64 prop;
 
 	/*
-	 * Try fixed PHB numbering first, by checking archs and reading
-	 * the respective device-tree properties. Firstly, try powernv by
-	 * reading "ibm,opal-phbid", only present in OPAL environment.
+	 * On powernv machines we should have the "ibm,opal-phbid" property, if
+	 * so use that so that PHB numbers are predictable.
 	 */
 	ret = of_property_read_u64(dn, "ibm,opal-phbid", &prop);
-	if (ret)
-		ret = of_property_read_u32_index(dn, "reg", 1, (u32 *)&prop);
-
-	if (!ret)
+	if (ret == 0) {
 		phb_id = (int)(prop & (MAX_PHBS - 1));
 
-	/* We need to be sure to not use the same PHB number twice. */
-	if ((phb_id >= 0) && !test_and_set_bit(phb_id, phb_bitmap))
-		return phb_id;
+		/* Make sure never to use the same PHB number twice. */
+		if (!test_and_set_bit(phb_id, phb_bitmap))
+			return phb_id;
+	}
 
-	/*
-	 * If not pseries nor powernv, or if fixed PHB numbering tried to add
-	 * the same PHB number twice, then fallback to dynamic PHB numbering.
-	 */
+	/* If fixed PHB numbering failed, fallback to dynamic PHB numbering. */
 	phb_id = find_first_zero_bit(phb_bitmap, MAX_PHBS);
 	BUG_ON(phb_id >= MAX_PHBS);
 	set_bit(phb_id, phb_bitmap);
-- 
2.7.4
