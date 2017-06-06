Return-Path: <chrisp@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wj7pz1JPbzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 09:55:22 +1000 (AEST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: bp@alien8.de,
	linux-edac@vger.kernel.org
Cc: mchehab@kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/3] EDAC: mv64x60: calculate memory size correctly
Date: Wed,  7 Jun 2017 11:54:58 +1200
Message-Id: <20170606235500.22772-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20170606235500.22772-1-chris.packham@alliedtelesis.co.nz>
References: <20170606235500.22772-1-chris.packham@alliedtelesis.co.nz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The #address-cells and #size-cells properties need to be accounted for
when dealing with the "memory" device tree node. Use
of_address_to_resource() and resource_size() to retrieve the size of the
memory node which will automatically take the #cells into account.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- Use of_address_to_resource() instead of manually parsing the reg property.

 drivers/edac/mv64x60_edac.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
index 3461db3723cb..93623e704623 100644
--- a/drivers/edac/mv64x60_edac.c
+++ b/drivers/edac/mv64x60_edac.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/edac.h>
 #include <linux/gfp.h>
+#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
 
@@ -644,15 +645,19 @@ static irqreturn_t mv64x60_mc_isr(int irq, void *dev_id)
 static void get_total_mem(struct mv64x60_mc_pdata *pdata)
 {
 	struct device_node *np = NULL;
-	const unsigned int *reg;
+	struct resource res;
+	int ret;
+	unsigned long total_mem = 0;
 
-	np = of_find_node_by_type(NULL, "memory");
-	if (!np)
-		return;
+	for_each_node_by_type(np, "memory") {
+		ret = of_address_to_resource(np, 0, &res);
+		if (ret)
+			continue;
 
-	reg = of_get_property(np, "reg", NULL);
+		total_mem += resource_size(&res);
+	}
 
-	pdata->total_mem = reg[1];
+	pdata->total_mem = total_mem;
 }
 
 static void mv64x60_init_csrows(struct mem_ctl_info *mci,
-- 
2.13.0
