Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbcjp5lz2zDrCc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 01:17:02 +1000 (AEST)
Received: by mail-oi0-f68.google.com with SMTP id j144so3841895oib.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 08:17:02 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, David Laight <David.Laight@aculab.com>
Subject: [PATCH v2 4/5] powerpc: pseries: only store the device node basename
 in full_name
Date: Mon, 21 Aug 2017 10:16:50 -0500
Message-Id: <20170821151651.25096-5-robh@kernel.org>
In-Reply-To: <20170821151651.25096-1-robh@kernel.org>
References: <20170821151651.25096-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With dependencies on full_name containing the entire device node path
removed, stop storing the full_name in nodes created by
dlpar_configure_connector() and pSeries_reconfig_add_node().

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
v2:
- Rework dlpar_parse_cc_node() to a single allocation and strcpy instead
  of kasprintf
  
 arch/powerpc/platforms/pseries/dlpar.c    | 30 +++++++-----------------------
 arch/powerpc/platforms/pseries/reconfig.c |  2 +-
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 783f36364690..31a0615aeea1 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -75,28 +75,17 @@ static struct property *dlpar_parse_cc_property(struct cc_workarea *ccwa)
 	return prop;
 }
 
-static struct device_node *dlpar_parse_cc_node(struct cc_workarea *ccwa,
-					       const char *path)
+static struct device_node *(dlpar_parse_cc_node)(struct cc_workarea *ccwa)
 {
 	struct device_node *dn;
-	char *name;
-
-	/* If parent node path is "/" advance path to NULL terminator to
-	 * prevent double leading slashs in full_name.
-	 */
-	if (!path[1])
-		path++;
+	const char *name = (const char *)ccwa + be32_to_cpu(ccwa->name_offset);
 
-	dn = kzalloc(sizeof(*dn), GFP_KERNEL);
+	dn = kzalloc(sizeof(*dn) + strlen(name) + 1, GFP_KERNEL);
 	if (!dn)
 		return NULL;
 
-	name = (char *)ccwa + be32_to_cpu(ccwa->name_offset);
-	dn->full_name = kasprintf(GFP_KERNEL, "%s/%s", path, name);
-	if (!dn->full_name) {
-		kfree(dn);
-		return NULL;
-	}
+	dn->full_name = (char *)(dn + 1);
+	strcpy((char *)dn->full_name, name);
 
 	of_node_set_flag(dn, OF_DYNAMIC);
 	of_node_init(dn);
@@ -148,7 +137,6 @@ struct device_node *dlpar_configure_connector(__be32 drc_index,
 	struct property *last_property = NULL;
 	struct cc_workarea *ccwa;
 	char *data_buf;
-	const char *parent_path = parent->full_name;
 	int cc_token;
 	int rc = -1;
 
@@ -182,7 +170,7 @@ struct device_node *dlpar_configure_connector(__be32 drc_index,
 			break;
 
 		case NEXT_SIBLING:
-			dn = dlpar_parse_cc_node(ccwa, parent_path);
+			dn = dlpar_parse_cc_node(ccwa);
 			if (!dn)
 				goto cc_error;
 
@@ -192,10 +180,7 @@ struct device_node *dlpar_configure_connector(__be32 drc_index,
 			break;
 
 		case NEXT_CHILD:
-			if (first_dn)
-				parent_path = last_dn->full_name;
-
-			dn = dlpar_parse_cc_node(ccwa, parent_path);
+			dn = dlpar_parse_cc_node(ccwa);
 			if (!dn)
 				goto cc_error;
 
@@ -226,7 +211,6 @@ struct device_node *dlpar_configure_connector(__be32 drc_index,
 
 		case PREV_PARENT:
 			last_dn = last_dn->parent;
-			parent_path = last_dn->parent->full_name;
 			break;
 
 		case CALL_AGAIN:
diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 296c188fd5ca..f24d8159c9e1 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -33,7 +33,7 @@ static int pSeries_reconfig_add_node(const char *path, struct property *proplist
 	if (!np)
 		goto out_err;
 
-	np->full_name = kstrdup(path, GFP_KERNEL);
+	np->full_name = kstrdup(kbasename(path), GFP_KERNEL);
 	if (!np->full_name)
 		goto out_err;
 
-- 
2.11.0
