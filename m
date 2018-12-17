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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFB6C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 08:02:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C111A204FD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 08:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqHNmOrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C111A204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JDBz6tbmzDqHS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 19:02:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KqHNmOrv";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KqHNmOrv"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JD545b2HzDqZl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 18:56:56 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id z23so5749553plo.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Dec 2018 23:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IjwDbTS/z4KBFIXquKZ/wO5Kv02klbSOetli+9vOaNc=;
 b=KqHNmOrvGwcJtyxcs+bLRIXLWzVX36HkNJGLRrfUR3CEKBqXsklbYR8C/KA3IZlnWc
 FhT2iZq68uXcJra2JRQaCR/mofFsGze1c2WyGlMnVsWOYCo4Wcs1px01cXn7jc65rK0r
 vUUkqslHiEp2qW0jnK3exTlgppFkm+6Ef8gjP2dlsWvh7PtMAdgKML5jRGUFQ1+AAQiY
 qX64KCYho5j38we+2uf1hPVAo+CrPmCGBC49ZG4I28MFDJ4IMGOUiXB+tjZS4gABlODB
 TleAV3VEoo5GNiyJ8W7bTz/JLFcBuXoM3L0YgfaH8DRx1qOno+A9wSYov+WbgxISo3Yu
 97nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IjwDbTS/z4KBFIXquKZ/wO5Kv02klbSOetli+9vOaNc=;
 b=OG6HKZGJsjod4SVz6Z3m0T/E16d1hY/razdd2Fev9kZekmLxJzHPEgQAEUlhpHtyiL
 UDP7rTe3C937m0Lwut6OVYijRSKBGM0FwEW1Dyb/27kvStnk40d6+LPO+Ect64pULjCT
 /uUTEsHsDrIhjcoDTozYr3nn+HioxYTVGILpuLQFi0/F8BY+1bL32BfvC3CCj0jFNkn8
 YKoN9skSLuLuwpOIPUNJ2ivNCsgcxgFXS8D5rywbJAISklPAiJi0F8zB7OvKeRsDPQP/
 GKHWa+kCdn3Zws7XnrjxFaENSguxbKFWp2BTWPKa/F+gHc3YnWpyuSgH4CMtWZ+FYCEk
 z+Jw==
X-Gm-Message-State: AA+aEWbv2+i66VlzP3VOsibsR29espxj97ajqSMQ0Pt2WGiPsrQQRaRK
 /JZKa0yssvl1wF+lXmSNlJ0=
X-Google-Smtp-Source: AFSGD/VzadQ7KllZWniZ0SFntweMpX+J7hhizCMBCQ81Z8FIwynVKUz+AnTwbjeju7NabFGK7OQK1g==
X-Received: by 2002:a17:902:724a:: with SMTP id
 c10mr12061675pll.51.1545033414561; 
 Sun, 16 Dec 2018 23:56:54 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id r8sm14216610pgr.48.2018.12.16.23.56.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 16 Dec 2018 23:56:54 -0800 (PST)
From: frowand.list@gmail.com
To: robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] of: of_node_get()/of_node_put() nodes held in phandle
 cache
Date: Sun, 16 Dec 2018 23:56:35 -0800
Message-Id: <1545033396-24485-2-git-send-email-frowand.list@gmail.com>
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

The phandle cache contains struct device_node pointers.  The refcount
of the pointers was not incremented while in the cache, allowing use
after free error after kfree() of the node.  Add the proper increment
and decrement of the use count.

Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

changes since v1
  - make __of_free_phandle_cache() static

 drivers/of/base.c | 70 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 24 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 09692c9b32a7..6c33d63361b8 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -116,9 +116,6 @@ int __weak of_node_to_nid(struct device_node *np)
 }
 #endif
 
-static struct device_node **phandle_cache;
-static u32 phandle_cache_mask;
-
 /*
  * Assumptions behind phandle_cache implementation:
  *   - phandle property values are in a contiguous range of 1..n
@@ -127,6 +124,44 @@ int __weak of_node_to_nid(struct device_node *np)
  *   - the phandle lookup overhead reduction provided by the cache
  *     will likely be less
  */
+
+static struct device_node **phandle_cache;
+static u32 phandle_cache_mask;
+
+/*
+ * Caller must hold devtree_lock.
+ */
+static void __of_free_phandle_cache(void)
+{
+	u32 cache_entries = phandle_cache_mask + 1;
+	u32 k;
+
+	if (!phandle_cache)
+		return;
+
+	for (k = 0; k < cache_entries; k++)
+		of_node_put(phandle_cache[k]);
+
+	kfree(phandle_cache);
+	phandle_cache = NULL;
+}
+
+int of_free_phandle_cache(void)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
+
+	__of_free_phandle_cache();
+
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+
+	return 0;
+}
+#if !defined(CONFIG_MODULES)
+late_initcall_sync(of_free_phandle_cache);
+#endif
+
 void of_populate_phandle_cache(void)
 {
 	unsigned long flags;
@@ -136,8 +171,7 @@ void of_populate_phandle_cache(void)
 
 	raw_spin_lock_irqsave(&devtree_lock, flags);
 
-	kfree(phandle_cache);
-	phandle_cache = NULL;
+	__of_free_phandle_cache();
 
 	for_each_of_allnodes(np)
 		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
@@ -155,30 +189,15 @@ void of_populate_phandle_cache(void)
 		goto out;
 
 	for_each_of_allnodes(np)
-		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
+		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL) {
+			of_node_get(np);
 			phandle_cache[np->phandle & phandle_cache_mask] = np;
+		}
 
 out:
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 }
 
-int of_free_phandle_cache(void)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&devtree_lock, flags);
-
-	kfree(phandle_cache);
-	phandle_cache = NULL;
-
-	raw_spin_unlock_irqrestore(&devtree_lock, flags);
-
-	return 0;
-}
-#if !defined(CONFIG_MODULES)
-late_initcall_sync(of_free_phandle_cache);
-#endif
-
 void __init of_core_init(void)
 {
 	struct device_node *np;
@@ -1195,8 +1214,11 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 	if (!np) {
 		for_each_of_allnodes(np)
 			if (np->phandle == handle) {
-				if (phandle_cache)
+				if (phandle_cache) {
+					/* will put when removed from cache */
+					of_node_get(np);
 					phandle_cache[masked_handle] = np;
+				}
 				break;
 			}
 	}
-- 
Frank Rowand <frank.rowand@sony.com>

