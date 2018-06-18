Return-Path: <danielwa@cisco.com>
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
 (using TLSv1.2 with cipher DHE-RSA-SEED-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418cx41N37zF0Pd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 03:08:07 +1000 (AEST)
From: Daniel Walker <danielwa@cisco.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: xe-kernel@external.cisco.com,
 "Guilherme G . Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] arch: powerpc: pci-common: fix wrong return value check on
 phd_id
Date: Mon, 18 Jun 2018 09:57:06 -0700
Message-Id: <20180618165706.42679-1-danielwa@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cisco has a couple platforms which depend on the domain values getting
set a certain way. We discovered our machines not detecting the pci
devices, and traced it back to this commit,

63a7228 powerpc/pci: Assign fixed PHB number based on device-tree
properties

It seems that the code is expecting the return value of of_property_read_u64()
to be the opposite of what it actually is.. It returns zero on success, and a
negative return value on error. So if you only check when it's non-zero your
going to set Opal for all platforms but Opal, which I assume is not what was
expected.

Fix is just to negate the ret value.

Cc: xe-kernel@external.cisco.com
Cc: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Fixes: 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on device-tree properties")
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 arch/powerpc/kernel/pci-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index fe9733f..0a1bcbe 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -89,7 +89,7 @@ static int get_phb_number(struct device_node *dn)
 	 * reading "ibm,opal-phbid", only present in OPAL environment.
 	 */
 	ret = of_property_read_u64(dn, "ibm,opal-phbid", &prop);
-	if (ret) {
+	if (!ret) {
 		ret = of_property_read_u32_index(dn, "reg", 1, &prop_32);
 		prop = prop_32;
 	}
-- 
2.10.3.dirty
