Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8621C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 05:18:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A9920895
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 05:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZ4qXCA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A9920895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XCfX1HnhzF0PJ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 16:18:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XZ4qXCA6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="XZ4qXCA6"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XC7T4c4WzF3VC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 15:55:17 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id p25-v6so6810755pli.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 21:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BwKhWXvi9uObifIA2caG7KxBnrbJ0SRY7Oj5Ow4g1sM=;
 b=XZ4qXCA6jBwzs4BJQJHCEF4+8gTh9fFr52BmTGEckHBTT9Nra/WMAJ32F3wyt0umZg
 jZ/jQJJx5dBAt/rhoUf98Vv9w6ypT/t1mMO5oZH2qxL61LON4yddsoR/uRFTw5yHXkKj
 J5ZsNLbBRQ1gpU/EHhZoxab8VZViK0hPgMy6DtQa2+JdFaaOlUyQZ7zGguVWI42m/hD1
 ecgYiRoFLOlxQOSs+CS/d8KW3UttiD/brvms5FD/0Oq4jr9g6nlC+4bZKnBYM9xqHsLI
 TkdT4gIDUMvA0QLBxMnlyNgnLkhFjzy0FtV4Bm2stIZbhi08mQkJZOREl5RA9E9SFrMO
 2epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BwKhWXvi9uObifIA2caG7KxBnrbJ0SRY7Oj5Ow4g1sM=;
 b=FghWuoFBpY5MxZCHnlkm9Qb82aH7tW98YtlM3sbcCTaKkxyUdBAJ3FIhRQVHCfF6FC
 78CxZS0swhw8rtPPLVLc2UvbbWm6lHucl309Iki6CgKrmelnPXgiHxkUhHvz/hUuIqMt
 NLdcYJkiXIijwIwl9qtvp1KXA5D9MfAOv286/NatWJhyYjYeTCg1xQ9E0ad2h1f1gnDk
 MX7EGRIW8DM7MLRiCC1u075dzdcQSV3HFLYFeet7U+KSX+59kA+uy79cXixcGS1PeSvP
 t8ZJjTbBGnDnakhK2iOeM107ZPnfKP9FSSm5uwr4wVsL3EEBf3/0aBHdN0Fl/Nj8l/g/
 544g==
X-Gm-Message-State: ABuFfog0J7/tQQrm6VHb2PbHkMPs2Zq4nL9OvGQeMDvTuJC8mvnXetyo
 5fE6/5cOdF3mF45gF7L09N0=
X-Google-Smtp-Source: ACcGV62f3udKGPelQenyfTrmljSknUmfOiXF7LK4m9fe8WDAEAmXINJzXsckXVJCGBO/ZFK64aRSTA==
X-Received: by 2002:a17:902:2:: with SMTP id
 2-v6mr8743154pla.178.1539406516046; 
 Fri, 12 Oct 2018 21:55:16 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 12 Oct 2018 21:55:15 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 09/18] of: overlay: validate overlay properties
 #address-cells and #size-cells
Date: Fri, 12 Oct 2018 21:53:29 -0700
Message-Id: <1539406418-18162-10-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
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

If overlay properties #address-cells or #size-cells are already in
the live devicetree for any given node, then the values in the
overlay must match the values in the live tree.

If the properties are already in the live tree then there is no
need to create a changeset entry to add them since they must
have the same value.  This reduces the memory used by the
changeset and eliminates a possible memory leak.  This is
verified by 12 fewer warnings during the devicetree unittest,
as the possible memory leak warnings about #address-cells and

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 272a0d1a5e18..ee66651db553 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -287,7 +287,12 @@ static struct property *dup_and_fixup_symbol_prop(
  * @target may be either in the live devicetree or in a new subtree that
  * is contained in the changeset.
  *
- * Some special properties are not updated (no error returned).
+ * Some special properties are not added or updated (no error returned):
+ * "name", "phandle", "linux,phandle".
+ *
+ * Properties "#address-cells" and "#size-cells" are not updated if they
+ * are already in the live tree, but if present in the live tree, the values
+ * in the overlay must match the values in the live tree.
  *
  * Update of property in symbols node is not allowed.
  *
@@ -300,6 +305,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 {
 	struct property *new_prop = NULL, *prop;
 	int ret = 0;
+	bool check_for_non_overlay_node = false;
 
 	if (!of_prop_cmp(overlay_prop->name, "name") ||
 	    !of_prop_cmp(overlay_prop->name, "phandle") ||
@@ -322,13 +328,39 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 	if (!new_prop)
 		return -ENOMEM;
 
-	if (!prop)
+	if (!prop) {
+
+		check_for_non_overlay_node = true;
 		ret = of_changeset_add_property(&ovcs->cset, target->np,
 						new_prop);
-	else
+
+	} else if (!of_prop_cmp(prop->name, "#address-cells")) {
+
+		if (prop->length != 4 || new_prop->length != 4 ||
+		    *(u32 *)prop->value != *(u32 *)new_prop->value)
+			pr_err("ERROR: overlay and/or live tree #address-cells invalid in node %pOF\n",
+			       target->np);
+
+	} else if (!of_prop_cmp(prop->name, "#size-cells")) {
+
+		if (prop->length != 4 || new_prop->length != 4 ||
+		    *(u32 *)prop->value != *(u32 *)new_prop->value)
+			pr_err("ERROR: overlay and/or live tree #size-cells invalid in node %pOF\n",
+			       target->np);
+
+	} else {
+
+		check_for_non_overlay_node = true;
 		ret = of_changeset_update_property(&ovcs->cset, target->np,
 						   new_prop);
 
+	}
+
+	if (check_for_non_overlay_node &&
+	    !of_node_check_flag(target->np, OF_OVERLAY))
+		pr_err("WARNING: %s(), memory leak will occur if overlay removed.  Property: %pOF/%s\n",
+		       __func__, target->np, new_prop->name);
+
 	if (ret) {
 		kfree(new_prop->name);
 		kfree(new_prop->value);
-- 
Frank Rowand <frank.rowand@sony.com>

