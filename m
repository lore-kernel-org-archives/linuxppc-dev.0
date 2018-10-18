Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAD2C67863
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 22:51:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B23204FD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 22:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHlJy2yd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B23204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bknM50l0zF3J1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 09:51:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jHlJy2yd";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="jHlJy2yd"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bkj361hrzF3FK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 09:48:07 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id 23-v6so14856123pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 15:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=C494CovzuO9b6he1A/aT23EiOpnTLXoKmWoxMPV+2cw=;
 b=jHlJy2ydgM4w3zMfbOoS08MLFHPU2KCicOENypQxHZut1p4CcI0pIbY2sIV49DI4D9
 D2LEfeGo5Cz2rfyPT44K+bgKYU6dQurgTXVgm6HgW317e1GT5ZMFYUSjMLyea+mSnsdQ
 FKSlprtBNvIPl41SWxubfbX2GV5osUtq2R3V3fQ+OGGCgl4LwLB21KjDWYYNNgeHDD/8
 W2spEeLyK7YFiEes7tIFSm08y3geYKJEYm3nrI5NlDeQGWkDcJHrxSn+GhL4KbQMhSNP
 wXcMv1zd5SnNxoo4x+po0msPiIapmQlVedJWXV9HQAsDFQmsFCczaw1JK84oeJpb1hAB
 6EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=C494CovzuO9b6he1A/aT23EiOpnTLXoKmWoxMPV+2cw=;
 b=bJK2Cb+WH5VmbAee16BbheaY1K+tAI4/Xf7lHxmvbhIv6CxTlUU9h6ZAT8mTrq7yvI
 aaq0JzHzMnwN6Mi/u/xThmUUVPC5bgDflJVa9Xzd4BJR/4QVAEIjOhnqs3wQX/mUKkpa
 HioalxSdBsy5qmsdXiml0G66IpTMfRx4lzf7yB58D5ulnspWtfrG9F86NhA8TMWWMktg
 vDmgaA/Rlcf4k2M/gOunN5cw21DtH4f7R67qKR2GT+2EwNyRn0Yzca5ugElsylqVWTEi
 7xIunMKip/hTa7NspRRvrH40aFc2zs6zCznvhXbjABf4R4ssZIbwdjxx5fqV6Db2P+kA
 jruw==
X-Gm-Message-State: ABuFfogoagIIitsthqDCoEdWEyXajje+sJVgK+9WNp/MNlF+Wugp+GAm
 wARPvV8tTQ+pe9mBZ/Ybjd0=
X-Google-Smtp-Source: ACcGV60e/uDOxckhIIT7OK2wqEa+HS7phFOjj3n6MwOKyR+PsYv21b4DJ9kqXE3V1iiVOG+P9Vba5A==
X-Received: by 2002:a63:4454:: with SMTP id
 t20-v6mr29636393pgk.102.1539902885772; 
 Thu, 18 Oct 2018 15:48:05 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id v81-v6sm38129268pfj.25.2018.10.18.15.48.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 18 Oct 2018 15:48:05 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v5 01/18] of: overlay: add tests to validate kfrees from
 overlay removal
Date: Thu, 18 Oct 2018 15:46:19 -0700
Message-Id: <1539902796-8382-2-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
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

  OF: ERROR: of_node_release(), unexpected properties in /testcase-data/overlay-node/test-bus/test-unittest11
  OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy cset entry: attach overlay node /testcase-data-2/substation@100/
  hvac-medium-2

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

Changes since v4:
  - make error message format consistent, error first, path last

 drivers/of/dynamic.c | 29 +++++++++++++++++++++++++++++
 drivers/of/overlay.c |  1 +
 include/linux/of.h   | 15 ++++++++++-----
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index f4f8ed9b5454..12c3f9a15e94 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -330,6 +330,25 @@ void of_node_release(struct kobject *kobj)
 	if (!of_node_check_flag(node, OF_DYNAMIC))
 		return;
 
+	if (of_node_check_flag(node, OF_OVERLAY)) {
+
+		if (!of_node_check_flag(node, OF_OVERLAY_FREE_CSET)) {
+			/* premature refcount of zero, do not free memory */
+			pr_err("ERROR: memory leak before free overlay changeset,  %pOF\n",
+			       node);
+			return;
+		}
+
+		/*
+		 * If node->properties non-empty then properties were added
+		 * to this node either by different overlay that has not
+		 * yet been removed, or by a non-overlay mechanism.
+		 */
+		if (node->properties)
+			pr_err("ERROR: %s(), unexpected properties in %pOF\n",
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
+			pr_err("ERROR: memory leak, expected refcount 1 instead of %d, of_node_get()/of_node_put() unbalanced - destroy cset entry: attach overlay node %pOF\n",
+			       kref_read(&ce->np->kobj.kref), ce->np);
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

