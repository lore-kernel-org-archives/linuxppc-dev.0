Return-Path: <b25806@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B1CC5B70DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Dec 2010 21:46:10 +1100 (EST)
Received: from mail141-tx2 (localhost.localdomain [127.0.0.1])	by
	mail141-tx2-R.bigfish.com (Postfix) with ESMTP id 34EF4639B63	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 10 Dec 2010 10:46:00 +0000 (UTC)
Received: from TX2EHSMHS026.bigfish.com (unknown [10.9.14.252])	by
	mail141-tx2.bigfish.com (Postfix) with ESMTP id D7A801150052	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 10 Dec 2010 10:45:59 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	oBAAjwt6013185	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 10 Dec 2010 03:45:58 -0700 (MST)
Received: from zch01exm28.fsl.freescale.net ([10.192.129.225])	by
	de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id oBAB4FiP010996	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 10 Dec 2010 05:04:16 -0600 (CST)
From: Lan Chunhe <b25806@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/3 v2] of/device: Register children with a compatible value
	in of_platform_bus_probe()
Date: Fri, 10 Dec 2010 18:52:20 +0800
Message-ID: <1291978340-15933-1-git-send-email-b25806@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Lan Chunhe <b25806@freescale.com>, akpm@linux-foundation.org,
	dougthompson@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, of_platform_bus_probe() completely skips nodes which do not
explicitly match the 'matches' table passed in.  Or, if the root node
matches, then it registers all the children unconditionally.  However,
there are situations, such as registering devices from the root node,
when it is desirable to register child nodes, but only if they actually
represent devices.  For example, the root node may contain both a local
bus and a PCI device, but it also contains the chosen, aliases and cpus
nodes which don't represent real devices.

This patch changes of_platform_bus_probe() to register all nodes at the
top level if they either match the matches table (the current behaviour),
or if they have a 'compatible' value (indicating it represents a device).

Signed-off-by: Lan Chunhe <b25806@freescale.com>
---
 drivers/of/platform.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 5b4a07f..02755ab 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -714,6 +714,8 @@ int of_platform_bus_probe(struct device_node *root,
 	struct device_node *child;
 	struct platform_device *dev;
 	int rc = 0;
+	const void *compat;
+	const struct of_device_id *match;
 
 	if (WARN_ON(!matches || matches == OF_NO_DEEP_PROBE))
 		return -EINVAL;
@@ -741,16 +743,32 @@ int of_platform_bus_probe(struct device_node *root,
 		rc = of_platform_bus_create(root, matches, &dev->dev);
 		goto bail;
 	}
+
+	/*
+	 * Register each child node if either:
+	 *  a) it has a 'compatible' value indicating they are a device, or
+	 *  b) it is specified by the 'matches' table (by name or device_type)
+	 * If a node is specified in the matches table, then all its children
+	 * also get registered.
+	 */
 	for_each_child_of_node(root, child) {
-		if (!of_match_node(matches, child))
+		compat = of_get_property(child, "compatible", NULL);
+		match = of_match_node(matches, child);
+		if (!compat && !match)
 			continue;
 
-		pr_debug("  match: %s\n", child->full_name);
+		pr_debug("  register device: %s\n", child->full_name);
 		dev = of_platform_device_create(child, NULL, parent);
-		if (dev == NULL)
+		if (!dev) {
 			rc = -ENOMEM;
-		else
-			rc = of_platform_bus_create(child, matches, &dev->dev);
+			of_node_put(child);
+			break;
+		}
+		if (!match)
+			continue;
+
+		pr_debug("  register children of: %s\n", child->full_name);
+		rc = of_platform_bus_create(child, matches, &dev->dev);
 		if (rc) {
 			of_node_put(child);
 			break;
-- 
1.5.4.5
