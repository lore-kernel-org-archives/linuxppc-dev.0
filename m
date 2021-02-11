Return-Path: <SRS0=2rmQ=HN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DACC433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 22:30:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9112564E38
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 22:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9112564E38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DcBCk4Q03zDwsH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 09:30:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.54; helo=mail-ot1-f54.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DcB6851nDzDwqG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2021 09:25:36 +1100 (AEDT)
Received: by mail-ot1-f54.google.com with SMTP id 100so6714417otg.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2021 14:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=59hf+6O4K21P81t02yR2JJsizjTVRLh6ZVSrQljA/sc=;
 b=QtzUOeJ0mtto9mopoLywLtRa81QH5TgmAGKdi2KXxi7i+VJwM+jxzWfTvjZ4YsuuDX
 QzhPxxRAzZTP7/78BSS1fIIyj5lgKNvWVCPlaxO8+1iphUqP6UKXyPQS6PcP/pl9bk8b
 1thlXTz1UjGP2YMEgdKpzLP0cIAJ9nLkARSq7BpnXXtUYv4DIzBim0iSl53JndW6AQIU
 FwYw22rtiF7SKzA2NnoNDsXDsVtBopLDJg7X58gqUh8teWtFqqsQvmvReS/pPx/uYw9g
 yfcSa/G2iB+8amxpo+klxjLLBYL2UNJaRDImpI/3FlCNDtmifdNUa0zYIaXT/KOfPorW
 24tg==
X-Gm-Message-State: AOAM532QfbFrgW8tgj3U0ewUtQIolf1M6ph+JhhGaX6QIlaNIyRAqrMc
 1PxqwBKfYRWkMdTFq6rQEg==
X-Google-Smtp-Source: ABdhPJyoVcKGRF5I+pIki+Oo8A5jCC9o1Ifs/C5d7kBMPZRLIA+fMwLf/LFw7mtzzAZNV7Q3EHU3YQ==
X-Received: by 2002:a9d:605a:: with SMTP id v26mr136880otj.275.1613082333675; 
 Thu, 11 Feb 2021 14:25:33 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id j25sm978030otn.55.2021.02.11.14.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 14:25:32 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Subject: [PATCH 2/2] driver core: platform: Drop of_device_node_put() wrapper
Date: Thu, 11 Feb 2021 16:25:26 -0600
Message-Id: <20210211222526.1318236-3-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210211222526.1318236-1-robh@kernel.org>
References: <20210211222526.1318236-1-robh@kernel.org>
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
Cc: Felipe Balbi <balbi@kernel.org>, Michal Marek <michal.lkml@markovi.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>,
 Patrice Chotard <patrice.chotard@st.com>, linux-kernel@vger.kernel.org,
 Julia Lawall <Julia.Lawall@inria.fr>, Gilles Muller <Gilles.Muller@inria.fr>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

of_device_node_put() is just a wrapper for of_node_put(). The platform
driver core is already polluted with of_node pointers and the only 'get'
already uses of_node_get() (though typically the get would happen in
of_device_alloc()).

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/base/platform.c   | 2 +-
 include/linux/of_device.h | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 95fd1549f87d..c31bc9e92dd1 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -571,7 +571,7 @@ static void platform_device_release(struct device *dev)
 	struct platform_object *pa = container_of(dev, struct platform_object,
 						  pdev.dev);
 
-	of_device_node_put(&pa->pdev.dev);
+	of_node_put(&pa->pdev.dev->of_node);
 	kfree(pa->pdev.dev.platform_data);
 	kfree(pa->pdev.mfd_cell);
 	kfree(pa->pdev.resource);
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index d7a407dfeecb..1d7992a02e36 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -38,11 +38,6 @@ extern int of_device_request_module(struct device *dev);
 extern void of_device_uevent(struct device *dev, struct kobj_uevent_env *env);
 extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env);
 
-static inline void of_device_node_put(struct device *dev)
-{
-	of_node_put(dev->of_node);
-}
-
 static inline struct device_node *of_cpu_device_node_get(int cpu)
 {
 	struct device *cpu_dev;
@@ -94,8 +89,6 @@ static inline int of_device_uevent_modalias(struct device *dev,
 	return -ENODEV;
 }
 
-static inline void of_device_node_put(struct device *dev) { }
-
 static inline const struct of_device_id *of_match_device(
 		const struct of_device_id *matches, const struct device *dev)
 {
-- 
2.27.0

