Return-Path: <ben@codiert.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E4CC8B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Aug 2009 23:52:56 +1000 (EST)
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7F366DDDA0
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Aug 2009 23:52:56 +1000 (EST)
Date: Tue, 25 Aug 2009 15:52:41 +0200
From: Benjamin Krill <ben@codiert.org>
To: Kumar Gala <galak@kernel.crashing.org>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-mtd@lists.infradead.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] MTD ofpart: Check availability of reg property instead of
	name property
Message-ID: <20090825135241.GA20036@codiert.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The previous implementation breaks the dts binding "mtd-physmap.txt". This
implementation fixes the issue by checking the availability of the reg
property instead of the name property.

Signed-off-by: Benjamin Krill <ben@codiert.org>
---
 drivers/mtd/ofpart.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
index 3e164f0..62d6a78 100644
--- a/drivers/mtd/ofpart.c
+++ b/drivers/mtd/ofpart.c
@@ -46,21 +46,12 @@ int __devinit of_mtd_parse_partitions(struct device *dev,
 		const u32 *reg;
 		int len;
 
-		/* check if this is a partition node */
-		partname = of_get_property(pp, "name", &len);
-		if (strcmp(partname, "partition") != 0) {
+		reg = of_get_property(pp, "reg", &len);
+		if (!reg) {
 			nr_parts--;
 			continue;
 		}
 
-		reg = of_get_property(pp, "reg", &len);
-		if (!reg || (len != 2 * sizeof(u32))) {
-			of_node_put(pp);
-			dev_err(dev, "Invalid 'reg' on %s\n", node->full_name);
-			kfree(*pparts);
-			*pparts = NULL;
-			return -EINVAL;
-		}
 		(*pparts)[i].offset = reg[0];
 		(*pparts)[i].size = reg[1];
 
@@ -75,6 +66,14 @@ int __devinit of_mtd_parse_partitions(struct device *dev,
 		i++;
 	}
 
+	if (!i) {
+		of_node_put(pp);
+		dev_err(dev, "No valid partition found on %s\n", node->full_name);
+		kfree(*pparts);
+		*pparts = NULL;
+		return -EINVAL;
+	}
+
 	return nr_parts;
 }
 EXPORT_SYMBOL(of_mtd_parse_partitions);
-- 
1.5.4.5
