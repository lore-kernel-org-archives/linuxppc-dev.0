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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660B2C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 19:54:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B00FC2184C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 19:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMesuXgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00FC2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43K7yn71vqzDqLT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 06:54:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oMesuXgO";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="oMesuXgO"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43K7fL1MhNzDqPQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 06:40:25 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id g62so8586170pfd.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 11:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FFIR56EPPMtxpRI59NyRK3PwR1fe0YI9MbaLl494NEI=;
 b=oMesuXgOxh3rffuZdb2VG3kMN2EgZm0eenELSQ9/8FZLHdrikxwu3pPoGFWqqSN/Ne
 O4AfSIWfCfUxfQAq6De1Shrzkh74aUdEqGlFNEExVweVkbp+12LftWeOKEsdorQI/tVI
 94eMIt0dIyjhs4F4jIQ1GWGT55XeCupedkYFOLZTpFpvrXhq9G0Agj96LR62Wcx6fTFs
 xiVo2kTW1/ZgopJ1OfxUrkmmEThEud9IIp8KJjchWEJAV46INdfFZgqJhxJgMVn6qirT
 BPzoHYALpjGYQZXt4x17F1KQnaY8XXS2Vuen1KqfREZoPwTPsOArF7pecLnrJWctsPIl
 Oo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FFIR56EPPMtxpRI59NyRK3PwR1fe0YI9MbaLl494NEI=;
 b=ro1fOGzxfr61M45GHmRLhDJslcC5NyGUrszHKdN7u2qj/W/C/ZklKsclyNRlQYNV6f
 AFml/MihLGOZrSzryMRH9HDRLle/P/zjzq+tzh21ZMOFz0iCKFZu4TjhOBIiXZaH9uiY
 QlYFoYiyrSIrgIXPHLcmzTKQKwnbGgtdBLKMXC16shxQh5lIIbW5f/XsRmEo9OTYz2Ja
 jUb+SiUAzlTKDS1V0anxb75JJFkZ2hBLjrC13UiboQzBv1c2EkarRBENe/M2fMNEuxYu
 SJonlm472I7dV1OPWivKaS0TjtG5dvgTgpPLgEoSivKZ72ch9nS9XGu4c1u2OES3k9x8
 693w==
X-Gm-Message-State: AA+aEWZ6cVunHiFHeamtmOii/bhkA10buXoeEdhEPPH089GyoqFoelTA
 +4ujIILIK30AK8JnNWdA1Gg=
X-Google-Smtp-Source: AFSGD/XB5RxrA+Vo26Mis+VOsHyU9tLICH1XvHi0jMUo+CSL4elZ1+OfbPs5sTmWiZ1ddzmSKaS9ug==
X-Received: by 2002:a62:de06:: with SMTP id h6mr18383172pfg.158.1545162024350; 
 Tue, 18 Dec 2018 11:40:24 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id b202sm29493069pfb.88.2018.12.18.11.40.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 18 Dec 2018 11:40:23 -0800 (PST)
From: frowand.list@gmail.com
To: robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 1/2] of: of_node_get()/of_node_put() nodes held in phandle
 cache
Date: Tue, 18 Dec 2018 11:40:02 -0800
Message-Id: <1545162003-11577-2-git-send-email-frowand.list@gmail.com>
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

The phandle cache contains struct device_node pointers.  The refcount
of the pointers was not incremented while in the cache, allowing use
after free error after kfree() of the node.  Add the proper increment
and decrement of the use count.

Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

do not "cc: stable", unless the following commits are also in stable:

  commit e54192b48da7 ("of: fix phandle cache creation for DTs with no phandles")
  commit b9952b5218ad ("of: overlay: update phandle cache on overlay apply and remove")
  commit 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")


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

