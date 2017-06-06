Return-Path: <chrisp@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wj7pz272BzDqCv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 09:55:22 +1000 (AEST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: bp@alien8.de,
	linux-edac@vger.kernel.org
Cc: mchehab@kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 3/3] EDAC: cpc925: simplify calculation of total memory
Date: Wed,  7 Jun 2017 11:55:00 +1200
Message-Id: <20170606235500.22772-4-chris.packham@alliedtelesis.co.nz>
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

Use of_address_to_resource() and resource_size() instead of manually
parsing the "reg" property from the "memory" node(s).

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- New

 drivers/edac/cpc925_edac.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
index 837b62c4993d..ea347cd7eb92 100644
--- a/drivers/edac/cpc925_edac.c
+++ b/drivers/edac/cpc925_edac.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/edac.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/gfp.h>
 
@@ -296,30 +297,17 @@ struct cpc925_dev_info {
 static void get_total_mem(struct cpc925_mc_pdata *pdata)
 {
 	struct device_node *np = NULL;
-	const unsigned int *reg, *reg_end;
-	int len, sw, aw;
-	unsigned long start, size;
+	struct resource res;
+	int ret;
 
-	np = of_find_node_by_type(NULL, "memory");
-	if (!np)
-		return;
+	for_each_node_by_type(np, "memory") {
+		ret = of_address_to_resource(np, 0, &res);
+		if (ret)
+			continue;
+
+		pdata->total_mem += resource_size(&res);
+	}
 
-	aw = of_n_addr_cells(np);
-	sw = of_n_size_cells(np);
-	reg = (const unsigned int *)of_get_property(np, "reg", &len);
-	reg_end = reg + len/4;
-
-	pdata->total_mem = 0;
-	do {
-		start = of_read_number(reg, aw);
-		reg += aw;
-		size = of_read_number(reg, sw);
-		reg += sw;
-		edac_dbg(1, "start 0x%lx, size 0x%lx\n", start, size);
-		pdata->total_mem += size;
-	} while (reg < reg_end);
-
-	of_node_put(np);
 	edac_dbg(0, "total_mem 0x%lx\n", pdata->total_mem);
 }
 
-- 
2.13.0
