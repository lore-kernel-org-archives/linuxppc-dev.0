Return-Path: <ben@codiert.org>
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5D80ADDED9
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jan 2009 03:18:01 +1100 (EST)
Date: Fri, 23 Jan 2009 17:18:05 +0100
From: Benjamin Krill <ben@codiert.org>
To: linux-mtd@lists.infradead.org, dwg@au1.ibm.com, linuxppc-dev@ozlabs.org,
	vwool@ru.mvista.com
Subject: [PATCH v2] Check name property to determine partition nodes.
Message-ID: <20090123161805.GA2598@codiert.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

SLOF has a further node which could not be evaluate
by the current routine. The current routine returns
because the node hasn't the required reg property. As
fix this patch adds a check to determine the partition
child nodes. If the node is not an partition the number
of total partitions will be decreased and loop continue
with the next nodes.

Signed-off-by: Benjamin Krill <ben@codiert.org>
---
 drivers/mtd/ofpart.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
index 9e45b3f..3e164f0 100644
--- a/drivers/mtd/ofpart.c
+++ b/drivers/mtd/ofpart.c
@@ -46,6 +46,13 @@ int __devinit of_mtd_parse_partitions(struct device *dev,
 		const u32 *reg;
 		int len;
 
+		/* check if this is a partition node */
+		partname = of_get_property(pp, "name", &len);
+		if (strcmp(partname, "partition") != 0) {
+			nr_parts--;
+			continue;
+		}
+
 		reg = of_get_property(pp, "reg", &len);
 		if (!reg || (len != 2 * sizeof(u32))) {
 			of_node_put(pp);
-- 
1.6.0.6
