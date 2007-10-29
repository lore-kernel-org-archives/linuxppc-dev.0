Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BC445DE12E
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 06:32:07 +1100 (EST)
Date: Mon, 29 Oct 2007 23:29:02 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] MTD: small physmap_of partition parsing fixes
Message-ID: <20071029202902.GA2200@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use of_get_next_child for proper ref counting as suggested by Stephen Rothwell
and remove add_mtd_partitions from parse_partitions to avoid duplicate
mtd device registration for RedBoot partitions.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 drivers/mtd/maps/physmap_of.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff -pruN linux-2.6.orig/drivers/mtd/maps/physmap_of.c linux-2.6/drivers/mtd/maps/physmap_of.c
--- linux-2.6.orig/drivers/mtd/maps/physmap_of.c	2007-10-29 16:02:37.000000000 +0300
+++ linux-2.6/drivers/mtd/maps/physmap_of.c	2007-10-29 22:41:08.000000000 +0300
@@ -94,14 +94,13 @@ static int __devinit parse_partitions(st
 	 * line, these take precedence over device tree information */
 	nr_parts = parse_mtd_partitions(info->mtd, part_probe_types,
 					&info->parts, 0);
-	if (nr_parts > 0) {
-		add_mtd_partitions(info->mtd, info->parts, nr_parts);
-		return 0;
-	}
+	if (nr_parts > 0)
+		return nr_parts;
 
 	/* First count the subnodes */
 	nr_parts = 0;
-	for (pp = dp->child; pp; pp = pp->sibling)
+	for (pp = of_get_next_child(dp, NULL); pp;
+	     pp = of_get_next_child(dp, pp))
 		nr_parts++;
 
 	if (nr_parts == 0)
@@ -112,12 +111,14 @@ static int __devinit parse_partitions(st
 	if (!info->parts)
 		return -ENOMEM;
 
-	for (pp = dp->child, i = 0; pp; pp = pp->sibling, i++) {
+	for (pp = of_get_next_child(dp, NULL), i = 0; pp;
+	     pp = of_get_next_child(dp, pp), i++) {
 		const u32 *reg;
 		int len;
 
 		reg = of_get_property(pp, "reg", &len);
 		if (!reg || (len != 2*sizeof(u32))) {
+			of_node_put(pp);
 			dev_err(&dev->dev, "Invalid 'reg' on %s\n",
 				dp->full_name);
 			kfree(info->parts);
