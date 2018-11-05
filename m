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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E509C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 16:08:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C4A72081D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 16:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chaB4SgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4A72081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pczd644XzDsGJ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 03:08:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="chaB4SgB";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="chaB4SgB"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pc432dSpzDrL5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 02:27:15 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id s5-v6so4606367plq.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 07:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=B33kF9iV0Uu4RxMZKXEawnQNU8qd2/woHNjsUwzS9rE=;
 b=chaB4SgBqV4XDgnq+js/31L0WQhDOiYLeqvJWnKjccl0cwrkLzUedgDqFdGe8LYfof
 S3d8kVTDY1nLmRGYOT//XfnZNucDjb4zaqznZGK9vq+jOV3ytt4VIYxkANEg3tcy9Nv0
 aNICP77DCLf7wcbNUAnIAiftI/uYxTOT0Ms6RpXrxxIPkBuRp7wqJvyzt2x7tjRkGzo4
 naLoukzKihnEl8EP6uzu1Ch2FAHK+rRT8pmg/QW9OXDcSPIRywHI0mRJfpWwb4UXmaGp
 LoQIGp53VCy9bsYcCMGaHyJz9af8XmBhCrM3OEeo+6OYvGURzSljv6g01PbIvsYLW2dB
 i4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=B33kF9iV0Uu4RxMZKXEawnQNU8qd2/woHNjsUwzS9rE=;
 b=rHZcNNyMEt7UemAf/xJS0bj5SlhXeXI8pIrhwDsdLJZofj3wHiT/7oRWgX30aWHKtS
 kP5J/1IbcaoWKNtNJp5yfZCA3IUAEw/wMVeBA9+8Re5fvC0T5/rFunsEa1g8QcMGcmsA
 VkPJcjflMIh4p3IPxWP1TyrUnREJOt+AqGadhmFpPEMilWURqOhX8X/pKZBrwTADVzfJ
 GUM6skLX9C8G7tfrJRc/ShMoLy9/bHNEx7716RpZzx9T+95DnNVhxSbSfxSfFxqnW3hE
 gbv3lNahMswZzHlSWcnM7HOpiYjNP42xgKsBFBtkWIWtisa44GDDjswM06QxATXN7WT6
 CPrQ==
X-Gm-Message-State: AGRZ1gLTE0MriHmS6TffabzdsBWnERN/2f3O5oVSqDj0m6ot9YHQf0Ch
 9zIjlGwi1HcC8bD1xjEBrfo=
X-Google-Smtp-Source: AJdET5dgJ6+2JwcU64czZZIsi1hchGlTQLCO8Q91NS3rKQVLUvK0xIkb4Oj0y7riO1TrP2sZDAYaOw==
X-Received: by 2002:a17:902:9009:: with SMTP id
 a9-v6mr22717047plp.134.1541431633802; 
 Mon, 05 Nov 2018 07:27:13 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.27.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 05 Nov 2018 07:27:13 -0800 (PST)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v6 16/18] of: unittest: allow base devicetree to have symbol
 metadata
Date: Mon,  5 Nov 2018 07:25:13 -0800
Message-Id: <1541431515-25197-17-git-send-email-frowand.list@gmail.com>
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

The overlay metadata nodes in the FDT created from testcases.dts
are not handled properly.

The __fixups__ and __local_fixups__ node were added to the live
devicetree, but should not be.

Only the first property in the /__symbols__ node was added to the
live devicetree if the live devicetree already contained a
/__symbols node.  All of the node's properties must be added.

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 14838b21ec6a..d625a91a7f60 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1071,20 +1071,44 @@ static void __init of_unittest_platform_populate(void)
  *	of np into dup node (present in live tree) and
  *	updates parent of children of np to dup.
  *
- *	@np:	node already present in live tree
+ *	@np:	node whose properties are being added to the live tree
  *	@dup:	node present in live tree to be updated
  */
 static void update_node_properties(struct device_node *np,
 					struct device_node *dup)
 {
 	struct property *prop;
+	struct property *save_next;
 	struct device_node *child;
-
-	for_each_property_of_node(np, prop)
-		of_add_property(dup, prop);
+	int ret;
 
 	for_each_child_of_node(np, child)
 		child->parent = dup;
+
+	/*
+	 * "unittest internal error: unable to add testdata property"
+	 *
+	 *    If this message reports a property in node '/__symbols__' then
+	 *    the respective unittest overlay contains a label that has the
+	 *    same name as a label in the live devicetree.  The label will
+	 *    be in the live devicetree only if the devicetree source was
+	 *    compiled with the '-@' option.  If you encounter this error,
+	 *    please consider renaming __all__ of the labels in the unittest
+	 *    overlay dts files with an odd prefix that is unlikely to be
+	 *    used in a real devicetree.
+	 */
+
+	/*
+	 * open code for_each_property_of_node() because of_add_property()
+	 * sets prop->next to NULL
+	 */
+	for (prop = np->properties; prop != NULL; prop = save_next) {
+		save_next = prop->next;
+		ret = of_add_property(dup, prop);
+		if (ret)
+			pr_err("unittest internal error: unable to add testdata property %pOF/%s",
+			       np, prop->name);
+	}
 }
 
 /**
@@ -1093,18 +1117,23 @@ static void update_node_properties(struct device_node *np,
  *
  *	@np:	Node to attach to live tree
  */
-static int attach_node_and_children(struct device_node *np)
+static void attach_node_and_children(struct device_node *np)
 {
 	struct device_node *next, *dup, *child;
 	unsigned long flags;
 	const char *full_name;
 
 	full_name = kasprintf(GFP_KERNEL, "%pOF", np);
+
+	if (!strcmp(full_name, "/__local_fixups__") ||
+	    !strcmp(full_name, "/__fixups__"))
+		return;
+
 	dup = of_find_node_by_path(full_name);
 	kfree(full_name);
 	if (dup) {
 		update_node_properties(np, dup);
-		return 0;
+		return;
 	}
 
 	child = np->child;
@@ -1125,8 +1154,6 @@ static int attach_node_and_children(struct device_node *np)
 		attach_node_and_children(child);
 		child = next;
 	}
-
-	return 0;
 }
 
 /**
-- 
Frank Rowand <frank.rowand@sony.com>

