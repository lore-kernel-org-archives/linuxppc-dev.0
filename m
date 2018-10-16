Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DB7C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 02:45:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8713B20869
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 02:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuFBfJMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8713B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Z05m4XvrzF3W2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:45:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VuFBfJMM";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VuFBfJMM"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Yzz63dSKzF3Vy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 13:39:14 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id y18-v6so10094685pge.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 19:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JHz4eQu2QicbBVTkAKqK9aKvo2anD2RJn53w2YKB8e0=;
 b=VuFBfJMMk6qap6AVKX2Sa0pM5k7L/UmMs/xnds8HFlzeaKdsJeXdUwLD2/9HDsaiFW
 seUTu1j/+Jmg/V0TiRXDN4wlnkR1IhBWg0HE0LLVmRiZOktbYOWPhcTjC8iLMGXNZUoU
 vJRC4VIPI0l25gLyTwBMd88ETXtp7zaHREELU6ea5fGnYADBdJ5oHQxD4u3dS5/Adh3C
 xWwfP6bblrpgPVwKA0Dc8WmAMypiKsEkbI/yn0DLH8zz60jRGIOtEFXsTeb3BeFwebXk
 GwiL7n4Jjyqb/hHdRQjXlXHDbEfxBOCTQTZdFNx+duZTvaySIpzKDtPGGHM2synn1l0y
 uPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JHz4eQu2QicbBVTkAKqK9aKvo2anD2RJn53w2YKB8e0=;
 b=pA/vqT03rEz42/mZJDGD+3OwtYxKSULYc82lGO23+R13Rqsbf96nkG3iZpDX1IQltp
 IMUhBZy/yaCDEhpM+n2F8jukSNjJH51CTzT1Xknmi820A5PUfdZwzIvLRFuqnnYnJK5y
 Zx2IgnN8YGCUzBXCY9eDVAAR+iveG2C2EvetLj7tFn54qf4IT7YRYTf56/3KXwV6ZQAm
 wWnWtwYTuuJ/Rv9QeE2P6ml1xw3UPpW6XSp8StMjzJMewNbSrpqPitsvYAPVqfm4L++k
 65YipjKF8oSkl4ecyGbFyydKfZrWJOva4VYCewZojGCGZXrMPHTkrws8UlTsaHNhsOnQ
 6L8w==
X-Gm-Message-State: ABuFfoikBhiE4BvNhY58wLECM361VIkf/dWmI8ttcm7KvlNL1aFCb1VN
 jBVXPdE8QC1Wg3yoJ2XezpM=
X-Google-Smtp-Source: ACcGV639CBmDpGh7IxP36f5mNtBe8sg3FSECUCzIxDTxhGjWl2qLULnogvgzhlm+V2d/huyFocVcgg==
X-Received: by 2002:a62:1d16:: with SMTP id
 d22-v6mr1132680pfd.159.1539657552452; 
 Mon, 15 Oct 2018 19:39:12 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 15 Oct 2018 19:39:11 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v4 01/18] of: overlay: add tests to validate kfrees from
 overlay removal
Date: Mon, 15 Oct 2018 19:37:21 -0700
Message-Id: <1539657458-24401-2-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
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
  OF: ERROR: memory leak - destroy cset entry: attach overlay node /testcase-data-2/substation@100/hvac-medium-2 expected refcount 1 instead of 2.  of_node_get() / of_node_put() are unbalanced for this node.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
Changes since v3:
  - Add expected value of refcount for destroy cset entry error.  Also
    explain the cause of the error.

 drivers/of/dynamic.c | 29 +++++++++++++++++++++++++++++
 drivers/of/overlay.c |  1 +
 include/linux/of.h   | 15 ++++++++++-----
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index f4f8ed9b5454..24c97b7a050f 100644
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
+			pr_err("ERROR: memory leak - destroy cset entry: attach overlay node %pOF expected refcount 1 instead of %d.  of_node_get() / of_node_put() are unbalanced for this node.\n",
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

