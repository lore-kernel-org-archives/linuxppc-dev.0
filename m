Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43BAC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 08:04:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F21F204FD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 08:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsSxbB6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F21F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JDFp1x5NzDq63
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 19:04:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PsSxbB6w";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="PsSxbB6w"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JD560gwCzDqZQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 18:56:57 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id w7so5703180pgp.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Dec 2018 23:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=au8EiM8byvG0y1Hv7QLp0mVhGQvk710Vc9STgbc0N48=;
 b=PsSxbB6wTE0H5YQel8vnGmdkBREnOOdX8oEXQV5qc4BPK9ICS3ZUIkqSzgfXDJWA9g
 P7zC+UyxG+QZb1UZXKBYY6kvIHG+2VJZY1OOc1dGLe0ImXR4Dx/huuuFSdCTaZspGQ9u
 Otqq8R0osb9hgOmUdLad3l200yl25gE5KIWQPVz/Hdbtqlrogx2nYoXkRaVOJ9wjCEyl
 JkvDF17KCT8l4v+F7TDAe7qkHLA37awgSAUUslMdCKROfYlH8v7Vpf+eYBq9xy9U17Iv
 MCZMPUb+PDDg1TiTWOuLJvB3H5qotK6oj/Y245vK/u6kpxd+e/vk60Irnv3BfbPs78xl
 hwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=au8EiM8byvG0y1Hv7QLp0mVhGQvk710Vc9STgbc0N48=;
 b=JkaZzRubhbN2GXYa97MQFGYuFyFdq9xaI/fre17dQ/hAPgOjrlI0JB0wSWAFnxzBXU
 Xlqq6ndP8pf/KGsSDG0riqE1nOAqpTnul9zK17DEr3NKRfXcYLU/UQTnly7DKteZYkUg
 HxCUGZBgV0NXYqfXGk3YnRngOMUjC75aGiY9ebglqHK7jvzFYLH8cNMQvK2sQtcBlyfH
 4roYU//AGU3imCkdabIKlkWvP2zGkYPjVen0bbCsE1i9DH8tauSe7ww9oSmsg3M7wyvz
 cGMglNoqbMjGwaDI1liuZtL1YuzV85YsCrS/bCRpb9N0qo2ekox09fCifGfN8JoCE8oB
 A5eQ==
X-Gm-Message-State: AA+aEWbqApUzgFpQnvJ86m6hvMA8cTqNNgAoSCHrAaIcZjvv1PXhlfUc
 5z9KEoAt4L7Fl9T6lKOcmPQ=
X-Google-Smtp-Source: AFSGD/VITzx/iT2E843sYjhHKQvhXFgUaF/GLt0spXhxUmG9dVpChMUCC1mF6fbGF5mDYuwFW11zVA==
X-Received: by 2002:a62:220d:: with SMTP id i13mr11892705pfi.162.1545033415905; 
 Sun, 16 Dec 2018 23:56:55 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id r8sm14216610pgr.48.2018.12.16.23.56.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 16 Dec 2018 23:56:55 -0800 (PST)
From: frowand.list@gmail.com
To: robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/2] of: __of_detach_node() - remove node from phandle cache
Date: Sun, 16 Dec 2018 23:56:36 -0800
Message-Id: <1545033396-24485-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
References: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
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

Reported-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

changes since v1:
  - add WARN_ON(1) for unexpected condition in of_find_node_by_phandle()

 drivers/of/base.c       | 30 +++++++++++++++++++++++++++++-
 drivers/of/dynamic.c    |  3 +++
 drivers/of/of_private.h |  4 ++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 6c33d63361b8..ad71864cecf5 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -162,6 +162,27 @@ int of_free_phandle_cache(void)
 late_initcall_sync(of_free_phandle_cache);
 #endif
 
+/*
+ * Caller must hold devtree_lock.
+ */
+void __of_free_phandle_cache_entry(phandle handle)
+{
+	phandle masked_handle;
+
+	if (!handle)
+		return;
+
+	masked_handle = handle & phandle_cache_mask;
+
+	if (phandle_cache) {
+		if (phandle_cache[masked_handle] &&
+		    handle == phandle_cache[masked_handle]->phandle) {
+			of_node_put(phandle_cache[masked_handle]);
+			phandle_cache[masked_handle] = NULL;
+		}
+	}
+}
+
 void of_populate_phandle_cache(void)
 {
 	unsigned long flags;
@@ -1209,11 +1230,18 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 		if (phandle_cache[masked_handle] &&
 		    handle == phandle_cache[masked_handle]->phandle)
 			np = phandle_cache[masked_handle];
+		if (np && of_node_check_flag(np, OF_DETACHED)) {
+			WARN_ON(1);
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

