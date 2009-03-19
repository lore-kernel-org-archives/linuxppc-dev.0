Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 63D9EDDDA9
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 16:00:19 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so215150waf.9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 22:00:18 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/9] of: add of_parse_phandle() helper for parsing phandle
	properties
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, afleming@freescale.com,
	avorontsov@ru.mvista.com, davem@davemloft.net, galak@kernel.crashing.org
Date: Wed, 18 Mar 2009 23:00:15 -0600
Message-ID: <20090319050015.11320.61641.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

of_parse_phandle() is a helper function to read and parse a phandle
property and return a pointer to the resulting device_node.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/of/base.c  |   23 +++++++++++++++++++++++
 include/linux/of.h |    3 +++
 2 files changed, 26 insertions(+), 0 deletions(-)


diff --git a/drivers/of/base.c b/drivers/of/base.c
index cd17092..1eaada4 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -494,6 +494,29 @@ int of_modalias_node(struct device_node *node, char *modalias, int len)
 EXPORT_SYMBOL_GPL(of_modalias_node);
 
 /**
+ * of_parse_phandle - Resolve a phandle property to a device_node pointer
+ * @np: Pointer to device node holding phandle property
+ * @phandle_name: Name of property holding a phandle value
+ * @index: For properties holding a table of phandles, this is the index into
+ *         the table
+ *
+ * Returns the device_node pointer pointed to by the phandle, or NULL
+ */
+struct device_node *
+of_parse_phandle(struct device_node *np, const char *phandle_name, int index)
+{
+	const phandle *phandle;
+	int size;
+
+	phandle = of_get_property(np, phandle_name, &size);
+	if ((!phandle) || (size < sizeof(*phandle) * (index + 1)))
+		return NULL;
+
+	return of_find_node_by_phandle(phandle[index]);
+}
+EXPORT_SYMBOL(of_parse_phandle);
+
+/**
  * of_parse_phandles_with_args - Find a node pointed by phandle in a list
  * @np:		pointer to a device tree node containing a list
  * @list_name:	property name that contains a list
diff --git a/include/linux/of.h b/include/linux/of.h
index 6a7efa2..7be2d10 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -77,6 +77,9 @@ extern int of_n_size_cells(struct device_node *np);
 extern const struct of_device_id *of_match_node(
 	const struct of_device_id *matches, const struct device_node *node);
 extern int of_modalias_node(struct device_node *node, char *modalias, int len);
+extern struct device_node *of_parse_phandle(struct device_node *np,
+					    const char *phandle_name,
+					    int index);
 extern int of_parse_phandles_with_args(struct device_node *np,
 	const char *list_name, const char *cells_name, int index,
 	struct device_node **out_node, const void **out_args);
