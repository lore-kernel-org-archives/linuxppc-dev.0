Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 470582C02EB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 16:56:22 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r7T6uH2E011142
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 01:56:18 -0500
Message-ID: <1377759376.4028.25.camel@pasglop>
Subject: [PATCH] powerpc/scom: Add support for "reg" property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 29 Aug 2013 16:56:16 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When devices are direct children of a scom controller node, they
should be able to use the normal "reg" property instead of "scom-reg".

In that case, they also use #address-cells rather than #scom-cells
to indicate the size of an entry.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/scom.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/scom.c b/arch/powerpc/sysdev/scom.c
index 10f1d9e..413622d 100644
--- a/arch/powerpc/sysdev/scom.c
+++ b/arch/powerpc/sysdev/scom.c
@@ -53,7 +53,7 @@ scom_map_t scom_map_device(struct device_node *dev, int index)
 {
 	struct device_node *parent;
 	unsigned int cells, size;
-	const u32 *prop;
+	const __be32 *prop, *sprop;
 	u64 reg, cnt;
 	scom_map_t ret;
 
@@ -62,12 +62,24 @@ scom_map_t scom_map_device(struct device_node *dev, int index)
 	if (parent == NULL)
 		return 0;
 
-	prop = of_get_property(parent, "#scom-cells", NULL);
-	cells = prop ? *prop : 1;
-
+	/*
+	 * We support "scom-reg" properties for adding scom registers
+	 * to a random device-tree node with an explicit scom-parent
+	 *
+	 * We also support the simple "reg" property if the device is
+	 * a direct child of a scom controller.
+	 *
+	 * In case both exist, "scom-reg" takes precedence.
+	 */
 	prop = of_get_property(dev, "scom-reg", &size);
+	sprop = of_get_property(parent, "#scom-cells", NULL);
+	if (!prop && parent == dev->parent) {
+		prop = of_get_property(dev, "reg", &size);
+		sprop = of_get_property(parent, "#address-cells", NULL);
+	}
 	if (!prop)
-		return 0;
+		return NULL;
+	cells = sprop ? be32_to_cpup(sprop) : 1;
 	size >>= 2;
 
 	if (index >= (size / (2*cells)))
