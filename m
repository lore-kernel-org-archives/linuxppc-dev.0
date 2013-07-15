Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 03E692C0176
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 13:03:28 +1000 (EST)
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r6F33KdI013377
 for <linuxppc-dev@ozlabs.org>; Sun, 14 Jul 2013 22:03:25 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/8] powerpc/powernv: Add helper to get ibm,chip-id of a node
Date: Mon, 15 Jul 2013 13:03:10 +1000
Message-Id: <1373857395-2084-3-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1373857395-2084-1-git-send-email-benh@kernel.crashing.org>
References: <1373857395-2084-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This includes walking the parent nodes if necessary.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/prom.h |  2 ++
 arch/powerpc/kernel/prom.c      | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index bc2da15..3bac73e 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -58,6 +58,8 @@ static inline int of_node_to_nid(struct device_node *device) { return 0; }
 
 extern void of_instantiate_rtc(void);
 
+extern int of_get_ibm_chip_id(struct device_node *np);
+
 /* The of_drconf_cell struct defines the layout of the LMB array
  * specified in the device tree property
  * ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index eb23ac9..2de07e5 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -795,6 +795,32 @@ struct device_node *of_find_next_cache_node(struct device_node *np)
 	return NULL;
 }
 
+/**
+ * of_get_ibm_chip_id - Returns the IBM "chip-id" of a device
+ * @np: device node of the device
+ *
+ * This looks for a property "ibm,chip-id" in the node or any
+ * of its parents and returns its content, or -1 if it cannot
+ * be found.
+ */
+int of_get_ibm_chip_id(struct device_node *np)
+{
+	of_node_get(np);
+	while(np) {
+		struct device_node *old = np;
+		const __be32 *prop;
+
+		prop = of_get_property(np, "ibm,chip-id", NULL);
+		if (prop) {
+			of_node_put(np);
+			return be32_to_cpup(prop);
+		}
+		np = of_get_parent(np);
+		of_node_put(old);
+	}
+	return -1;
+}
+
 #ifdef CONFIG_PPC_PSERIES
 /*
  * Fix up the uninitialized fields in a new device node:
-- 
1.8.1.2
