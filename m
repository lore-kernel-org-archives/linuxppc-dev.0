Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C21C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 15:41:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02902085A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 15:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/D/sEw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02902085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pcNm6HJYzF1p5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 02:41:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k/D/sEw4";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="k/D/sEw4"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pc3m6TgPzDrL6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 02:27:00 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id k1-v6so4388329pgq.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 07:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=D3FT5lRIYH6zQDYcowRpU+vLMnNgl8P6Y/UgX4wXgbo=;
 b=k/D/sEw4twBiPsmxDINj4PMFEOjySngc8xKsjFLUfqk3ALfGAMDgg1nf4q7FJdCzY4
 /NsLHx5vMBQlLRWHIFJg8ayRZhG4OzyezzmQGVasJbh2NqgiVRgNRwafxLbpLZFUFcDX
 G8Tgy4rj+HQF2dt0MVtGUgE0z9UU1nadAietye5uHWpBIkmZMIGVTb7A0uR/t75LeuQk
 rcnDZJcK4RPKniiV7Mt7iAsFRdkNAumfmT4t/4GuXgPJV1qJKOrUwOSQtjDlsbk2rvCp
 sQDRfo7YLL4wuFveLbjHCG4I3CBwC0Iukh0nY4J0r+2DNKDrtFzuFR9x5KIhZHk93yRq
 GOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=D3FT5lRIYH6zQDYcowRpU+vLMnNgl8P6Y/UgX4wXgbo=;
 b=thEnG4Vt5GvXhAcs6r7F9S82bpqVuKkYpNMXkFWm281T3Q2QrD657rYb8D5MsjsWJU
 OjBA5BlME03KDpEnlpxMholcmA7CNqL/xtccsXrDsOeeUS/nKvlAGmFflxzWpKG9BWYt
 pLYclOxSPi8ab5M9Pr/DdYJqWLcJyHXVhxnv/vrZUauU2V1WjcqLptJfZCMFuXzZhX43
 Yaj9k9pK71/S5xJvcYdZdNzfrzrXxXCgyxGGyaj7qC6J9CL96nOKFK1A3uhCEimo97/d
 m4LCqprZUKcQYcO/Fv/yi8vMC9O3DpypAyUZtlEBh06uLpnE88sUk0luCu5jTRMg2+Rj
 /GuA==
X-Gm-Message-State: AGRZ1gIhJiLEGdXXabz/m3frtUon7p4GEZd6XE3EFcIohruPYSBXxx/G
 8wtwJPMa43jDFJg5E0h6Qq4=
X-Google-Smtp-Source: AJdET5e1h9uWpWf4rKvWz5my5erxaEFv7Q6vg5UvbEQmAf6WpZ6bLLZEfjwY/AoqTByXqSb1qzDEpA==
X-Received: by 2002:a62:507:: with SMTP id 7-v6mr22540125pff.80.1541431618937; 
 Mon, 05 Nov 2018 07:26:58 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.26.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 05 Nov 2018 07:26:58 -0800 (PST)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v6 05/18] of: overlay: use prop add changeset entry for
 property in new nodes
Date: Mon,  5 Nov 2018 07:25:02 -0800
Message-Id: <1541431515-25197-6-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Frank Rowand <frank.rowand@sony.com>

The changeset entry 'update property' was used for new properties in
an overlay instead of 'add property'.

The decision of whether to use 'update property' was based on whether
the property already exists in the subtree where the node is being
spliced into.  At the top level of creating a changeset describing the
overlay, the target node is in the live devicetree, so checking whether
the property exists in the target node returns the correct result.
As soon as the changeset creation algorithm recurses into a new node,
the target is no longer in the live devicetree, but is instead in the
detached overlay tree, thus all properties are incorrectly found to
already exist in the target.

This fix will expose another devicetree bug that will be fixed
in the following patch in the series.

When this patch is applied the errors reported by the devictree
unittest will change, and the unittest results will change from:

   ### dt-test ### end of unittest - 210 passed, 0 failed

to

   ### dt-test ### end of unittest - 203 passed, 7 failed

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

Changes since v5:
  - update for context change from a613b26a50136 "of: Convert to using
    %pOFn instead of device_node.name"

 drivers/of/overlay.c | 112 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 38 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 7613f7d680c7..6fd8e6145e10 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -24,6 +24,26 @@
 #include "of_private.h"
 
 /**
+ * struct target - info about current target node as recursing through overlay
+ * @np:			node where current level of overlay will be applied
+ * @in_livetree:	@np is a node in the live devicetree
+ *
+ * Used in the algorithm to create the portion of a changeset that describes
+ * an overlay fragment, which is a devicetree subtree.  Initially @np is a node
+ * in the live devicetree where the overlay subtree is targeted to be grafted
+ * into.  When recursing to the next level of the overlay subtree, the target
+ * also recurses to the next level of the live devicetree, as long as overlay
+ * subtree node also exists in the live devicetree.  When a node in the overlay
+ * subtree does not exist at the same level in the live devicetree, target->np
+ * points to a newly allocated node, and all subsequent targets in the subtree
+ * will be newly allocated nodes.
+ */
+struct target {
+	struct device_node *np;
+	bool in_livetree;
+};
+
+/**
  * struct fragment - info about fragment nodes in overlay expanded device tree
  * @target:	target of the overlay operation
  * @overlay:	pointer to the __overlay__ node
@@ -72,8 +92,7 @@ static int devicetree_corrupt(void)
 }
 
 static int build_changeset_next_level(struct overlay_changeset *ovcs,
-		struct device_node *target_node,
-		const struct device_node *overlay_node);
+		struct target *target, const struct device_node *overlay_node);
 
 /*
  * of_resolve_phandles() finds the largest phandle in the live tree.
@@ -257,14 +276,17 @@ static struct property *dup_and_fixup_symbol_prop(
 /**
  * add_changeset_property() - add @overlay_prop to overlay changeset
  * @ovcs:		overlay changeset
- * @target_node:	where to place @overlay_prop in live tree
+ * @target:		where @overlay_prop will be placed
  * @overlay_prop:	property to add or update, from overlay tree
  * @is_symbols_prop:	1 if @overlay_prop is from node "/__symbols__"
  *
- * If @overlay_prop does not already exist in @target_node, add changeset entry
- * to add @overlay_prop in @target_node, else add changeset entry to update
+ * If @overlay_prop does not already exist in live devicetree, add changeset
+ * entry to add @overlay_prop in @target, else add changeset entry to update
  * value of @overlay_prop.
  *
+ * @target may be either in the live devicetree or in a new subtree that
+ * is contained in the changeset.
+ *
  * Some special properties are not updated (no error returned).
  *
  * Update of property in symbols node is not allowed.
@@ -273,20 +295,22 @@ static struct property *dup_and_fixup_symbol_prop(
  * invalid @overlay.
  */
 static int add_changeset_property(struct overlay_changeset *ovcs,
-		struct device_node *target_node,
-		struct property *overlay_prop,
+		struct target *target, struct property *overlay_prop,
 		bool is_symbols_prop)
 {
 	struct property *new_prop = NULL, *prop;
 	int ret = 0;
 
-	prop = of_find_property(target_node, overlay_prop->name, NULL);
-
 	if (!of_prop_cmp(overlay_prop->name, "name") ||
 	    !of_prop_cmp(overlay_prop->name, "phandle") ||
 	    !of_prop_cmp(overlay_prop->name, "linux,phandle"))
 		return 0;
 
+	if (target->in_livetree)
+		prop = of_find_property(target->np, overlay_prop->name, NULL);
+	else
+		prop = NULL;
+
 	if (is_symbols_prop) {
 		if (prop)
 			return -EINVAL;
@@ -299,10 +323,10 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 		return -ENOMEM;
 
 	if (!prop)
-		ret = of_changeset_add_property(&ovcs->cset, target_node,
+		ret = of_changeset_add_property(&ovcs->cset, target->np,
 						new_prop);
 	else
-		ret = of_changeset_update_property(&ovcs->cset, target_node,
+		ret = of_changeset_update_property(&ovcs->cset, target->np,
 						   new_prop);
 
 	if (ret) {
@@ -315,14 +339,14 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 
 /**
  * add_changeset_node() - add @node (and children) to overlay changeset
- * @ovcs:		overlay changeset
- * @target_node:	where to place @node in live tree
- * @node:		node from within overlay device tree fragment
+ * @ovcs:	overlay changeset
+ * @target:	where @node will be placed in live tree or changeset
+ * @node:	node from within overlay device tree fragment
  *
- * If @node does not already exist in @target_node, add changeset entry
- * to add @node in @target_node.
+ * If @node does not already exist in @target, add changeset entry
+ * to add @node in @target.
  *
- * If @node already exists in @target_node, and the existing node has
+ * If @node already exists in @target, and the existing node has
  * a phandle, the overlay node is not allowed to have a phandle.
  *
  * If @node has child nodes, add the children recursively via
@@ -355,15 +379,16 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
  * invalid @overlay.
  */
 static int add_changeset_node(struct overlay_changeset *ovcs,
-		struct device_node *target_node, struct device_node *node)
+		struct target *target, struct device_node *node)
 {
 	const char *node_kbasename;
 	struct device_node *tchild;
+	struct target target_child;
 	int ret = 0;
 
 	node_kbasename = kbasename(node->full_name);
 
-	for_each_child_of_node(target_node, tchild)
+	for_each_child_of_node(target->np, tchild)
 		if (!of_node_cmp(node_kbasename, kbasename(tchild->full_name)))
 			break;
 
@@ -372,22 +397,28 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 		if (!tchild)
 			return -ENOMEM;
 
-		tchild->parent = target_node;
+		tchild->parent = target->np;
 		of_node_set_flag(tchild, OF_OVERLAY);
 
 		ret = of_changeset_attach_node(&ovcs->cset, tchild);
 		if (ret)
 			return ret;
 
-		ret = build_changeset_next_level(ovcs, tchild, node);
+		target_child.np = tchild;
+		target_child.in_livetree = false;
+
+		ret = build_changeset_next_level(ovcs, &target_child, node);
 		of_node_put(tchild);
 		return ret;
 	}
 
-	if (node->phandle && tchild->phandle)
+	if (node->phandle && tchild->phandle) {
 		ret = -EINVAL;
-	else
-		ret = build_changeset_next_level(ovcs, tchild, node);
+	} else {
+		target_child.np = tchild;
+		target_child.in_livetree = target->in_livetree;
+		ret = build_changeset_next_level(ovcs, &target_child, node);
+	}
 	of_node_put(tchild);
 
 	return ret;
@@ -396,7 +427,7 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 /**
  * build_changeset_next_level() - add level of overlay changeset
  * @ovcs:		overlay changeset
- * @target_node:	where to place @overlay_node in live tree
+ * @target:		where to place @overlay_node in live tree
  * @overlay_node:	node from within an overlay device tree fragment
  *
  * Add the properties (if any) and nodes (if any) from @overlay_node to the
@@ -409,27 +440,26 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
  * invalid @overlay_node.
  */
 static int build_changeset_next_level(struct overlay_changeset *ovcs,
-		struct device_node *target_node,
-		const struct device_node *overlay_node)
+		struct target *target, const struct device_node *overlay_node)
 {
 	struct device_node *child;
 	struct property *prop;
 	int ret;
 
 	for_each_property_of_node(overlay_node, prop) {
-		ret = add_changeset_property(ovcs, target_node, prop, 0);
+		ret = add_changeset_property(ovcs, target, prop, 0);
 		if (ret) {
 			pr_debug("Failed to apply prop @%pOF/%s, err=%d\n",
-				 target_node, prop->name, ret);
+				 target->np, prop->name, ret);
 			return ret;
 		}
 	}
 
 	for_each_child_of_node(overlay_node, child) {
-		ret = add_changeset_node(ovcs, target_node, child);
+		ret = add_changeset_node(ovcs, target, child);
 		if (ret) {
 			pr_debug("Failed to apply node @%pOF/%pOFn, err=%d\n",
-				 target_node, child, ret);
+				 target->np, child, ret);
 			of_node_put(child);
 			return ret;
 		}
@@ -442,17 +472,17 @@ static int build_changeset_next_level(struct overlay_changeset *ovcs,
  * Add the properties from __overlay__ node to the @ovcs->cset changeset.
  */
 static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
-		struct device_node *target_node,
+		struct target *target,
 		const struct device_node *overlay_symbols_node)
 {
 	struct property *prop;
 	int ret;
 
 	for_each_property_of_node(overlay_symbols_node, prop) {
-		ret = add_changeset_property(ovcs, target_node, prop, 1);
+		ret = add_changeset_property(ovcs, target, prop, 1);
 		if (ret) {
 			pr_debug("Failed to apply prop @%pOF/%s, err=%d\n",
-				 target_node, prop->name, ret);
+				 target->np, prop->name, ret);
 			return ret;
 		}
 	}
@@ -475,6 +505,7 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
 static int build_changeset(struct overlay_changeset *ovcs)
 {
 	struct fragment *fragment;
+	struct target target;
 	int fragments_count, i, ret;
 
 	/*
@@ -489,7 +520,9 @@ static int build_changeset(struct overlay_changeset *ovcs)
 	for (i = 0; i < fragments_count; i++) {
 		fragment = &ovcs->fragments[i];
 
-		ret = build_changeset_next_level(ovcs, fragment->target,
+		target.np = fragment->target;
+		target.in_livetree = true;
+		ret = build_changeset_next_level(ovcs, &target,
 						 fragment->overlay);
 		if (ret) {
 			pr_debug("apply failed '%pOF'\n", fragment->target);
@@ -499,7 +532,10 @@ static int build_changeset(struct overlay_changeset *ovcs)
 
 	if (ovcs->symbols_fragment) {
 		fragment = &ovcs->fragments[ovcs->count - 1];
-		ret = build_changeset_symbols_node(ovcs, fragment->target,
+
+		target.np = fragment->target;
+		target.in_livetree = true;
+		ret = build_changeset_symbols_node(ovcs, &target,
 						   fragment->overlay);
 		if (ret) {
 			pr_debug("apply failed '%pOF'\n", fragment->target);
@@ -517,7 +553,7 @@ static int build_changeset(struct overlay_changeset *ovcs)
  * 1) "target" property containing the phandle of the target
  * 2) "target-path" property containing the path of the target
  */
-static struct device_node *find_target_node(struct device_node *info_node)
+static struct device_node *find_target(struct device_node *info_node)
 {
 	struct device_node *node;
 	const char *path;
@@ -623,7 +659,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
 
 		fragment = &fragments[cnt];
 		fragment->overlay = overlay_node;
-		fragment->target = find_target_node(node);
+		fragment->target = find_target(node);
 		if (!fragment->target) {
 			of_node_put(fragment->overlay);
 			ret = -EINVAL;
-- 
Frank Rowand <frank.rowand@sony.com>

