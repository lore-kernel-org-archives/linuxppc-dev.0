Return-Path: <B07421@freescale.com>
Date: Tue, 17 Jul 2012 20:11:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: Thierry Reding <thierry.reding@avionic-design.de>, Rob Herring
 <rob.herring@calxeda.com>
Subject: [PATCH] of: require a match on all fields of of_device_id
Message-ID: <20120718011151.GA6119@tyr.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 107a84e61cdd3406c842a0e4be7efffd3a05dba6 ("of: match by compatible
property first") breaks the gianfar ethernet driver found on various
Freescale PPC chips.

There are, for unfortunate historical reasons, two nodes with a
compatible of "gianfar".  One has a device_type of "network" and the
other has device_type of "mdio".  The match entries look like this:

>         {
>                 .type = "mdio",
>                 .compatible = "gianfar",
>         },

and

>         {
>                 .type = "network",
>                 .compatible = "gianfar",
>         },

With the above patch, both nodes get probed by the first driver, because
nothing else in the match struct is looked at if there's a compatible
match.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/of/base.c |   44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index bc86ea2..4e707cc 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -511,14 +511,37 @@ out:
 }
 EXPORT_SYMBOL(of_find_node_with_property);
 
-static const struct of_device_id *of_match_compat(const struct of_device_id *matches,
-						  const char *compat)
+/*
+ * Tell if an device_node matches the non-compatible fields of
+ * a specific of_match element.
+ */
+static bool of_match_one_noncompat(const struct of_device_id *match,
+				   const struct device_node *node)
+{
+	bool is_match = true;
+
+	if (match->name[0])
+		is_match &= node->name && !strcmp(match->name, node->name);
+	if (match->type[0])
+		is_match &= node->type && !strcmp(match->type, node->type);
+
+	return is_match;
+}
+
+/*
+ * Find an OF match using the supplied compatible string, rather than
+ * the node's entire string list.
+ */
+static const struct of_device_id *of_match_compat(
+	const struct of_device_id *matches, const char *compat,
+	const struct device_node *node)
 {
 	while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
 		const char *cp = matches->compatible;
 		int len = strlen(cp);
 
-		if (len > 0 && of_compat_cmp(compat, cp, len) == 0)
+		if (len > 0 && of_compat_cmp(compat, cp, len) == 0 &&
+		    of_match_one_noncompat(matches, node))
 			return matches;
 
 		matches++;
@@ -544,23 +567,20 @@ const struct of_device_id *of_match_node(const struct of_device_id *matches,
 		return NULL;
 
 	of_property_for_each_string(node, "compatible", prop, cp) {
-		const struct of_device_id *match = of_match_compat(matches, cp);
+		const struct of_device_id *match =
+			of_match_compat(matches, cp, node);
 		if (match)
 			return match;
 	}
 
 	while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
-		int match = 1;
-		if (matches->name[0])
-			match &= node->name
-				&& !strcmp(matches->name, node->name);
-		if (matches->type[0])
-			match &= node->type
-				&& !strcmp(matches->type, node->type);
-		if (match && !matches->compatible[0])
+		if (of_match_one_noncompat(matches, node) &&
+		    !matches->compatible[0])
 			return matches;
+
 		matches++;
 	}
+
 	return NULL;
 }
 EXPORT_SYMBOL(of_match_node);
-- 
1.7.9.5
