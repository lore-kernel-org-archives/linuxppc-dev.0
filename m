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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDD4C070C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 00:31:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7EE320652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 00:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYBKWYXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EE320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YKBB0CnGzF0yl
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 11:31:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OYBKWYXt";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OYBKWYXt"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YK3t4PvZzDrq6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 11:26:02 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id u12-v6so8742711pfn.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 17:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lPoDioj489a2/oR5DkZXnv7vgj2sX9AQIbb7kmBjERc=;
 b=OYBKWYXtaP2d8/q3dAQOCiXzFRReqKvSNXY2p8bFxVaO3kNRaETkbkqVoLhNmWpzEM
 um/Q5m9Evqg5D2JIr3yAixtCv+VXks800bSiFdu+XCOJPa1lqdg0CMc+ZRu7hP+sr7Z7
 cbDH5amgTS226LJr5aWhUgpy+wwoyUdayHIwfdBAtFznHgtq0h4IdoLJkX9YMfwwJndl
 6AF88DNCi/JoXfJSV0p4GCq4/28Kb2+qKcKLBoT7OU6AP7Abz7mSAsH/JGMRq4PYnsxp
 zBxnuz6ErH9nN3dCTLBeqVi2DSeKB0qesYpELGAamb3io4ss/7iw6mkpxXtucF0XDzc5
 DmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lPoDioj489a2/oR5DkZXnv7vgj2sX9AQIbb7kmBjERc=;
 b=SxLM3pOEw8KlrZDOucMxvoJvP4AT673D3860pErDR8odAuQtf9paMi7i/omzMyhj7j
 Wx4i51oTOyIg9rr6/IVqJNgDjahzDSs0av9St5n67n6GbqWucDm/mPEVyLD8oBFuDfl3
 7jtCqDv5f9P218xUFiI361mNdT/vj1EX26HjbkLT61WWK0iepVIwZ1tkcn8FUAFazQsw
 tYYwG2tC81JJE0XbEP1f+Sm+c+YyB4vt6WDr5oyxC2kkLr7b3Eu3PbnMuLYTgfQ0tnNk
 wzOYkjkgMn6Ay1QwGotSV4l6kJyW9ECYqX+3LplteuUjU38TpdANZ46LPaKDAC4j0We1
 NFiQ==
X-Gm-Message-State: ABuFfoiBp/Dh3F3s0CDPIO9QrbVP+l2ME5FZ1LghtexbWbadPPTXujJ0
 uf3khB58JO6N1hl8V4R19sw=
X-Google-Smtp-Source: ACcGV60pao8i5uAW7LjOqXI/qvGVnpTKieOfyQn6zutUSEh0PbDKDaIgFvQhCDixLYEHKQrupLCoDQ==
X-Received: by 2002:a63:d14a:: with SMTP id
 c10-v6mr14073372pgj.384.1539563160724; 
 Sun, 14 Oct 2018 17:26:00 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id j14-v6sm11387110pgh.52.2018.10.14.17.25.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Oct 2018 17:26:00 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v3 01/18] of: overlay: add tests to validate kfrees from
 overlay removal
Date: Sun, 14 Oct 2018 17:24:13 -0700
Message-Id: <1539563070-12969-2-git-send-email-frowand.list@gmail.com>
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

Add checks:
  - attempted kfree due to refcount reaching zero before overlay
    is removed
  - properties linked to an overlay node when the node is removed
  - node refcount > one during node removal in a changeset destroy,
    if the node was created by the changeset

After applying this patch, several validation warnings will be
reported from the devicetree unittest during boot due to
pre-existing devicetree bugs. The warnings will be similar to:

  OF: ERROR: of_node_release() overlay node /testcase-data/overlay-node/test-bus/test-unittest11/test-unittest111 contains unexpected properties
  OF: ERROR: memory leak - destroy cset entry: attach overlay node /testcase-data-2/substation@100/hvac-medium-2 with refcount 2

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/dynamic.c | 29 +++++++++++++++++++++++++++++
 drivers/of/overlay.c |  1 +
 include/linux/of.h   | 15 ++++++++++-----
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index f4f8ed9b5454..b04ee021a891 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -330,6 +330,25 @@ void of_node_release(struct kobject *kobj)
 	if (!of_node_check_flag(node, OF_DYNAMIC))
 		return;
 
+	if (of_node_check_flag(node, OF_OVERLAY)) {
+
+		if (!of_node_check_flag(node, OF_OVERLAY_FREE_CSET)) {
+			/* premature refcount of zero, do not free memory */
+			pr_err("ERROR: memory leak %s() overlay node %pOF before free overlay changeset\n",
+			       __func__, node);
+			return;
+		}
+
+		/*
+		 * If node->properties non-empty then properties were added
+		 * to this node either by different overlay that has not
+		 * yet been removed, or by a non-overlay mechanism.
+		 */
+		if (node->properties)
+			pr_err("ERROR: %s() overlay node %pOF contains unexpected properties\n",
+			       __func__, node);
+	}
+
 	property_list_free(node->properties);
 	property_list_free(node->deadprops);
 
@@ -434,6 +453,16 @@ struct device_node *__of_node_dup(const struct device_node *np,
 
 static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
 {
+	if (ce->action == OF_RECONFIG_ATTACH_NODE &&
+	    of_node_check_flag(ce->np, OF_OVERLAY)) {
+		if (kref_read(&ce->np->kobj.kref) > 1) {
+			pr_err("ERROR: memory leak - destroy cset entry: attach overlay node %pOF with refcount %d\n",
+			       ce->np, kref_read(&ce->np->kobj.kref));
+		} else {
+			of_node_set_flag(ce->np, OF_OVERLAY_FREE_CSET);
+		}
+	}
+
 	of_node_put(ce->np);
 	list_del(&ce->node);
 	kfree(ce);
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index eda57ef12fd0..1176cb4b6e4e 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -373,6 +373,7 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 			return -ENOMEM;
 
 		tchild->parent = target_node;
+		of_node_set_flag(tchild, OF_OVERLAY);
 
 		ret = of_changeset_attach_node(&ovcs->cset, tchild);
 		if (ret)
diff --git a/include/linux/of.h b/include/linux/of.h
index 4d25e4f952d9..aa1dafaec6ae 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -138,11 +138,16 @@ static inline void of_node_put(struct device_node *node) { }
 extern struct device_node *of_stdout;
 extern raw_spinlock_t devtree_lock;
 
-/* flag descriptions (need to be visible even when !CONFIG_OF) */
-#define OF_DYNAMIC	1 /* node and properties were allocated via kmalloc */
-#define OF_DETACHED	2 /* node has been detached from the device tree */
-#define OF_POPULATED	3 /* device already created for the node */
-#define OF_POPULATED_BUS	4 /* of_platform_populate recursed to children of this node */
+/*
+ * struct device_node flag descriptions
+ * (need to be visible even when !CONFIG_OF)
+ */
+#define OF_DYNAMIC		1 /* (and properties) allocated via kmalloc */
+#define OF_DETACHED		2 /* detached from the device tree */
+#define OF_POPULATED		3 /* device already created */
+#define OF_POPULATED_BUS	4 /* platform bus created for children */
+#define OF_OVERLAY		5 /* allocated for an overlay */
+#define OF_OVERLAY_FREE_CSET	6 /* in overlay cset being freed */
 
 #define OF_BAD_ADDR	((u64)-1)
 
-- 
Frank Rowand <frank.rowand@sony.com>

