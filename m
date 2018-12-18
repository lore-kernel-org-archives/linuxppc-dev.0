Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37086C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 19:51:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 925DC21841
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 19:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvdIx7sW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925DC21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43K7tf3Dt6zDqQD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 06:51:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EvdIx7sW";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="EvdIx7sW"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43K7fN07sFzDqQW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 06:40:27 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id i12so8604327pfo.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 11:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QpdzDwSrsWE9LXF201TGBe/ML0bWOkO30Z8/kF7nPbI=;
 b=EvdIx7sWsnq7Qd2RW6u2Z4I/D44oPaP+GN0NKdh4xQu/pkczHfeotGbP3nFcVxvMsG
 OPcLpMUsddriRtjWdND7o4rcEx1DqEGmg0ILZRsfUAhC/nNiEustJdyjZjMb+aMkGIQU
 3U9g13bmUnCk1GmBZMZ3XLoMc4W1NT2Ck+P2R2NbV9BDbLLir4KtUzwyBAANz8QRk3+Y
 mZiPI4TZ497fQaSLNk9bNZWlkkigj6xXjwTcBy9dvxJAEtZ5k8a0GQ37UrTUhl/fXF4/
 /WPO1QykFrvQEAEY6qhkucoLrA3jQZk7zpU5KS42Afdm7PTRHHA1WTBGDBcilmlmxX8K
 slRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QpdzDwSrsWE9LXF201TGBe/ML0bWOkO30Z8/kF7nPbI=;
 b=WdFU+3zzbpr1h9QWhZK6ysO8YnQgN2uzCr8mObnQmQ4lngH0tt7fJpFMRPACnUdlWD
 81SuOKWQP0M34arK+kZi5qZwWlmyzoVW82SoNxy3Ywrfey3W9I8QMBukYcVD9cEyy4IO
 kQ0Oj3eZHKzLdb3pmreGhrBNQXQTS6iqqzYt2J3gM4nhEMU8NY3ovYxn0tOknInVlqLU
 hGDkL3xVU8kj0KhV+zFCd1wwBs41nacfUGRdzcbmpCGN9nKNovGXusE2Vj5wAq55R6Fs
 +eAnmP++gSib8zbMpXP2sUiQeS779U9S9EpOwqX6qVplNUGfodnNTbuWY1P6nzCXAobx
 +d5A==
X-Gm-Message-State: AA+aEWbjNppUPYo2CBVciAm/ASd6YB7AyluszTPJa7lUnnSMf3BXANmS
 dZy121P6tAr66Upk4bQH6Dg=
X-Google-Smtp-Source: AFSGD/X7r9rnl1lgUNF7y1OGGMPqwJhmkVLN4/TzO8AAq32RmiBacasxsRfARiAyiD939uyB5i3dhg==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr422078pgl.186.1545162025672; 
 Tue, 18 Dec 2018 11:40:25 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id b202sm29493069pfb.88.2018.12.18.11.40.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 18 Dec 2018 11:40:25 -0800 (PST)
From: frowand.list@gmail.com
To: robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/2] of: __of_detach_node() - remove node from phandle cache
Date: Tue, 18 Dec 2018 11:40:03 -0800
Message-Id: <1545162003-11577-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545162003-11577-1-git-send-email-frowand.list@gmail.com>
References: <1545162003-11577-1-git-send-email-frowand.list@gmail.com>
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
Cc: devicetree@vger.kernel.org, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Juliet Kim <minkim@us.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Frank Rowand <frank.rowand@sony.com>

Non-overlay dynamic devicetree node removal may leave the node in
the phandle cache.  Subsequent calls to of_find_node_by_phandle()
will incorrectly find the stale entry.  Remove the node from the
cache.

Add paranoia checks in of_find_node_by_phandle() as a second level
of defense (do not return cached node if detached, do not add node
to cache if detached).

Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
Reported-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

do not "cc: stable", unless the following commits are also in stable:

  commit e54192b48da7 ("of: fix phandle cache creation for DTs with no phandles")
  commit b9952b5218ad ("of: overlay: update phandle cache on overlay apply and remove")
  commit 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")


Changes since v2:
  - add temporary variable np in __of_free_phandle_cache_entry() to improve
    readability
  - explain reason for WARN_ON() in comment
  - add Fixes tag in patch comment

 drivers/of/base.c       | 31 ++++++++++++++++++++++++++++++-
 drivers/of/dynamic.c    |  3 +++
 drivers/of/of_private.h |  4 ++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 6c33d63361b8..6d20b6dcf034 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -162,6 +162,28 @@ int of_free_phandle_cache(void)
 late_initcall_sync(of_free_phandle_cache);
 #endif
 
+/*
+ * Caller must hold devtree_lock.
+ */
+void __of_free_phandle_cache_entry(phandle handle)
+{
+	phandle masked_handle;
+	struct device_node *np;
+
+	if (!handle)
+		return;
+
+	masked_handle = handle & phandle_cache_mask;
+
+	if (phandle_cache) {
+		np = phandle_cache[masked_handle];
+		if (np && handle == np->phandle) {
+			of_node_put(np);
+			phandle_cache[masked_handle] = NULL;
+		}
+	}
+}
+
 void of_populate_phandle_cache(void)
 {
 	unsigned long flags;
@@ -1209,11 +1231,18 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 		if (phandle_cache[masked_handle] &&
 		    handle == phandle_cache[masked_handle]->phandle)
 			np = phandle_cache[masked_handle];
+		if (np && of_node_check_flag(np, OF_DETACHED)) {
+			WARN_ON(1); /* did not uncache np on node removal */
+			of_node_put(np);
+			phandle_cache[masked_handle] = NULL;
+			np = NULL;
+		}
 	}
 
 	if (!np) {
 		for_each_of_allnodes(np)
-			if (np->phandle == handle) {
+			if (np->phandle == handle &&
+			    !of_node_check_flag(np, OF_DETACHED)) {
 				if (phandle_cache) {
 					/* will put when removed from cache */
 					of_node_get(np);
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index f4f8ed9b5454..ecea92f68c87 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -268,6 +268,9 @@ void __of_detach_node(struct device_node *np)
 	}
 
 	of_node_set_flag(np, OF_DETACHED);
+
+	/* race with of_find_node_by_phandle() prevented by devtree_lock */
+	__of_free_phandle_cache_entry(np->phandle);
 }
 
 /**
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 5d1567025358..24786818e32e 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -84,6 +84,10 @@ static inline void __of_detach_node_sysfs(struct device_node *np) {}
 int of_resolve_phandles(struct device_node *tree);
 #endif
 
+#if defined(CONFIG_OF_DYNAMIC)
+void __of_free_phandle_cache_entry(phandle handle);
+#endif
+
 #if defined(CONFIG_OF_OVERLAY)
 void of_overlay_mutex_lock(void);
 void of_overlay_mutex_unlock(void);
-- 
Frank Rowand <frank.rowand@sony.com>

