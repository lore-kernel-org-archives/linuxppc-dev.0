Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E69C070C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 01:13:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8061E20652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 01:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWyRcxwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8061E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YL6g31YZzF1Q2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 12:13:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gWyRcxwj";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gWyRcxwj"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YK4F3s1tzDrqN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 11:26:21 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id v133-v6so8304938pgb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 17:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=M4dGHNWK9yvMCplN74sEUY4ZcqWQ+poGeb6zjVC5TlY=;
 b=gWyRcxwjcQIHmXE3ZziNd+GcsFcruZnlEBbPXRlGsVou9U8Iw0tlYr3VAR3cBksx9G
 N7tySGgEP/HFuxeC843p+3bnWGpTsgKPZ03NxEqjRm7gPsftSfRTCzU4G6eXXA8mG9IG
 zr4r8HyF9JyNyuWc52elnRofPsuMQYZKkZ3xBs+MBcN8+e49lHo0aXHnwqenZptAuVH5
 Fr0duPpaar6ht3gsyjM9U1eKgG3fX7JLhD4pit240ydQvLfc7hWQNxHlxNZDjqSPMfXP
 TscVakrTjOgukthrFt2MNfub0PK2ZsovcKCxPI3kt5e6DwO1BMdXfNwHH0pC8YObF7vy
 JWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=M4dGHNWK9yvMCplN74sEUY4ZcqWQ+poGeb6zjVC5TlY=;
 b=a2EddSvKS5Ap/5exV/Re0flZT4XLFpbF+q/qB/3QhO5Q7cgvBOU6i1FcUY14dnEfow
 Ap+Z6dMjLJ8e/npS+dT8D4b0inwTBOpXxeZLCuCeXQJe0ys8Ce93rRadexM6e7oaM/Fa
 WcvsMu01ZE6pyIO2WQJD5BYZ82+RtnpPrPdcPsGb1hp9FZvAexLbSEDrqtjMPVa3Gr9W
 HE8c515f/sQdTuq66VbvjheG8k/DBPB0ZH18RydYAKIoMFoeCswKEPlVvF0XVPqaERov
 3u3raUlrzBFT0hZLwF1LP/Nk9q3Wq49BnBWIU4ej5VL2eZVBWM2n+fAgmaOtPBwBiBi1
 Iqhg==
X-Gm-Message-State: ABuFfoiHFfCC8N3LZ+Fe4FDgmC3jUSU6xH/3Zeu+MdQFDSpZ1UEoOMYc
 kYzI7KU+K+ai96Xq8Gz2V2E=
X-Google-Smtp-Source: ACcGV61eeK3CD8b67f0r0rPDG7tY7h66TMSoIRK9LgsqCTBu5Q5Wiy3lma9WvBqS6q6scIZnfmt1/g==
X-Received: by 2002:a63:f5a:: with SMTP id
 26-v6mr14016650pgp.100.1539563179957; 
 Sun, 14 Oct 2018 17:26:19 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id j14-v6sm11387110pgh.52.2018.10.14.17.26.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Oct 2018 17:26:19 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v3 16/18] of: unittest: allow base devicetree to have symbol
 metadata
Date: Sun, 14 Oct 2018 17:24:28 -0700
Message-Id: <1539563070-12969-17-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
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

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 6d80f474c8f2..1c2bd8503095 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1057,20 +1057,44 @@ static void __init of_unittest_platform_populate(void)
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
@@ -1079,18 +1103,23 @@ static void update_node_properties(struct device_node *np,
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
@@ -1111,8 +1140,6 @@ static int attach_node_and_children(struct device_node *np)
 		attach_node_and_children(child);
 		child = next;
 	}
-
-	return 0;
 }
 
 /**
-- 
Frank Rowand <frank.rowand@sony.com>

