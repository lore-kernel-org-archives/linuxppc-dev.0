Return-Path: <chrisp@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wj7pz0c5nzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 09:55:22 +1000 (AEST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: bp@alien8.de,
	linux-edac@vger.kernel.org
Cc: mchehab@kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH v2 2/3] EDAC: altera: simplify calculation of total memory
Date: Wed,  7 Jun 2017 11:54:59 +1200
Message-Id: <20170606235500.22772-3-chris.packham@alliedtelesis.co.nz>
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

 drivers/edac/altera_edac.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 7717b094fabb..f8b623352627 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -214,24 +214,16 @@ static void altr_sdr_mc_create_debugfs_nodes(struct mem_ctl_info *mci)
 static unsigned long get_total_mem(void)
 {
 	struct device_node *np = NULL;
-	const unsigned int *reg, *reg_end;
-	int len, sw, aw;
-	unsigned long start, size, total_mem = 0;
+	struct resource res;
+	int ret;
+	unsigned long total_mem = 0;
 
 	for_each_node_by_type(np, "memory") {
-		aw = of_n_addr_cells(np);
-		sw = of_n_size_cells(np);
-		reg = (const unsigned int *)of_get_property(np, "reg", &len);
-		reg_end = reg + (len / sizeof(u32));
-
-		total_mem = 0;
-		do {
-			start = of_read_number(reg, aw);
-			reg += aw;
-			size = of_read_number(reg, sw);
-			reg += sw;
-			total_mem += size;
-		} while (reg < reg_end);
+		ret = of_address_to_resource(np, 0, &res);
+		if (ret)
+			continue;
+
+		total_mem += resource_size(&res);
 	}
 	edac_dbg(0, "total_mem 0x%lx\n", total_mem);
 	return total_mem;
-- 
2.13.0
