Return-Path: <SRS0=VWG1=CU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9890CC43461
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2020 17:27:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79C4221E5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2020 17:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfUuXHzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79C4221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bp2kw1JqwzDqwC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2020 03:27:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::743;
 helo=mail-qk1-x743.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=rfUuXHzW; dkim-atps=neutral
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bp2PN0TJPzDqrq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2020 03:12:24 +1000 (AEST)
Received: by mail-qk1-x743.google.com with SMTP id 16so10570763qkf.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2020 10:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0ne9GTGmUPQ9Wc3d+zW/IYxRZHQc7iSCrnsjOSABoB0=;
 b=rfUuXHzWh6VB9+tXhwXpvvkLv2AShtgMesd0Jh1XfVvh1ELrvr6wYD7QeleXrhck7F
 wj2x/gaHh44ivOcWHSeFwJ9tCHvj359YKNB+IoNwtN81laAPxgEUeknDY7o6+aC/VDbw
 xTG3QGlbS8npq8vcoMM0JjFXpzRRUaUmQxNlFo8/SceqFAQVmxZZHIY7K7QoBg2kAp/m
 VCdCnaH6dfV96xlaUuQeDKTUGHewtYKzctHPjLNsblkme+zPSYJeKao6Q8XZ0+f2ndH0
 SExezjAw2hdqWyjG3XXhpaHx2QZoZHyOygNIbshfIPkz2jZShVRSjxOlNGSaomJLibmX
 zUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0ne9GTGmUPQ9Wc3d+zW/IYxRZHQc7iSCrnsjOSABoB0=;
 b=PeeHLZh85A7JxzhRXgjsPkzraAhhWUmxIDKltWD4I/hP97O2wmt293MqcEDiKbyViT
 fGESpB1ycio/JmtBDjbT80AMNXfC/fA7dbTvbCUuJo86DcVHQrpeoDlFeLe8hPioelf7
 uzLeuE8jm3btvETjGrT8HWHENSXN31v30xp34nXsJim+xJykLMMRRxo92OkyUbDXA+pg
 ecYrtZ8F5j5HkNXk3l84s+KuDcOH1SI1FHPVZBTVY+o7txOlVRElYu1CI2nuO6xVfEEO
 KyOZQAR8c9HwNWBAeE9Juf8Xn+QmaHW8PIo07eAEgE/GgZAnJir5g5yTipX0BvqBHNpW
 0RQA==
X-Gm-Message-State: AOAM531mS54IczUWfWQCmmVs+TleuY/tEiMO4MXLPfWUHgX0LffXPJfg
 G56L3YZ3FE1DIkrehl8kxxA=
X-Google-Smtp-Source: ABdhPJyCNwo/yZUjogH7TNu4BlKl2eaos98l7eTVe7NjliL2GYRRLNt6lVpXN6w2PYtQtah5BjhJNg==
X-Received: by 2002:ae9:e84c:: with SMTP id a73mr2340491qkg.432.1599844341418; 
 Fri, 11 Sep 2020 10:12:21 -0700 (PDT)
Received: from LeoBras.ibmuc.com (179-125-254-96.dynamic.desktop.com.br.
 [179.125.254.96])
 by smtp.gmail.com with ESMTPSA id l5sm3533330qtc.28.2020.09.11.10.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 10:12:20 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Leonardo Bras <leobras.c@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Christophe Leroy <christophe.leroy@c-s.fr>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>, Brian King <brking@linux.vnet.ibm.com>,
 Murilo Fossa Vicentini <muvic@linux.ibm.com>,
 David Dai <zdai@linux.vnet.ibm.com>
Subject: [PATCH v2 07/14] powerpc/pseries/iommu: Add ddw_list_new_entry()
 helper
Date: Fri, 11 Sep 2020 14:07:32 -0300
Message-Id: <20200911170738.82818-8-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200911170738.82818-1-leobras.c@gmail.com>
References: <20200911170738.82818-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 

There are two functions creating direct_window_list entries in a
similar way, so create a ddw_list_new_entry() to avoid duplicity and
simplify those functions.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 32 +++++++++++++++++---------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 49008d2e217d..e4c17d27dcf3 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -869,6 +869,21 @@ static u64 find_existing_ddw(struct device_node *pdn)
 	return dma_addr;
 }
 
+static struct direct_window *ddw_list_new_entry(struct device_node *pdn,
+						const struct dynamic_dma_window_prop *dma64)
+{
+	struct direct_window *window;
+
+	window = kzalloc(sizeof(*window), GFP_KERNEL);
+	if (!window)
+		return NULL;
+
+	window->device = pdn;
+	window->prop = dma64;
+
+	return window;
+}
+
 static int find_existing_ddw_windows(void)
 {
 	int len;
@@ -881,18 +896,15 @@ static int find_existing_ddw_windows(void)
 
 	for_each_node_with_property(pdn, DIRECT64_PROPNAME) {
 		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
-		if (!direct64)
-			continue;
-
-		window = kzalloc(sizeof(*window), GFP_KERNEL);
-		if (!window || len < sizeof(struct dynamic_dma_window_prop)) {
-			kfree(window);
+		if (!direct64 || len < sizeof(*direct64)) {
 			remove_ddw(pdn, true);
 			continue;
 		}
 
-		window->device = pdn;
-		window->prop = direct64;
+		window = ddw_list_new_entry(pdn, direct64);
+		if (!window)
+			break;
+
 		spin_lock(&direct_window_list_lock);
 		list_add(&window->list, &direct_window_list);
 		spin_unlock(&direct_window_list_lock);
@@ -1261,7 +1273,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	dev_dbg(&dev->dev, "created tce table LIOBN 0x%x for %pOF\n",
 		  create.liobn, dn);
 
-	window = kzalloc(sizeof(*window), GFP_KERNEL);
+	window = ddw_list_new_entry(pdn, ddwprop);
 	if (!window)
 		goto out_clear_window;
 
@@ -1280,8 +1292,6 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		goto out_free_window;
 	}
 
-	window->device = pdn;
-	window->prop = ddwprop;
 	spin_lock(&direct_window_list_lock);
 	list_add(&window->list, &direct_window_list);
 	spin_unlock(&direct_window_list_lock);
-- 
2.25.4

