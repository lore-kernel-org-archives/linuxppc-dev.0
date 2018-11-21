Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08281C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 12:35:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57161214C4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 12:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+VCONlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57161214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430MVn5M59zF3bF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 23:35:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H+VCONlD";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=tiny.windzz@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="H+VCONlD"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430MQ857RtzF3Vt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 23:31:44 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id y6-v6so5368616plt.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 04:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=3WWMmxusDF5r9jzOUbyQU6ow39PRBSXzvrwTs4J0ls0=;
 b=H+VCONlDDqg+ewolkPxrQwitYhbB/M0akxo9L3zhaBp2los81hskcMUBY0l2hbpyMq
 7i0AhX/KA73mxw7cwDx/Ub40rXdbKo94k8IKRDk/XpGDCmtXlAJJX8OGLWqB0/cfcmS/
 6Tm+FUhyFvVzfRb1XzDi05xwElq+hq180zSirsCIf+Jy0UX8PVI1y6r/3rd/7FmwUM13
 UEdTK1KewsahdfWxJhU/R5k46nY7tA5YkC3x1QIlBjelsPiqdvQcZPCjv48irMj71YM9
 EWUDoJk5o0LnncdXvlBYkLhKu26XlfcGpV3JOaT/JvWHgRrAVfWbLYd+nnRcQLygNqW1
 m0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=3WWMmxusDF5r9jzOUbyQU6ow39PRBSXzvrwTs4J0ls0=;
 b=h0daT+9GBb3JYP/bNV02HaqfYcJqL3ecWO5we2h0w9Pt6yKgOQ94yyA19h3jha1zSp
 3ejne1Rgrncbm1wADwhZqZBfQNsyq5i/fQQl8N4tGE1UW0s0SfMr6MwJRaoXg0Tb9o+8
 h10mp4kcBPCBKfE+rROhHl7eMR5Igij2r65h6U1eqliHIsKmpsK4mYZC99PH4aitz0YV
 0fBsdniv3Pbf3wVypZcujqZxXEjIsxMtP4LtlTk8JBE+tVVt570g2Qn6A09nYSrERUPP
 t2CA1p1AzFbvmoKUgAskZ9ueDwSCcnlUyGCU9wWRZ+KbPuIkxUJkkA6NE/cv7qfJp/re
 Hx3Q==
X-Gm-Message-State: AA+aEWaP4Wb9xIfw6dQeGk8BYxfTUzu57N6nFtiQVzX/rEsFMde3ESIq
 T5zFm4qN0VAH+LeQlHDmDic=
X-Google-Smtp-Source: AFSGD/XqIKrsmCMf5Ux/YArs3/+WyC8tX5c96/+EGrRGJCE5pV9mQfoNj9cSpq3E+78n1p9pStZDyA==
X-Received: by 2002:a63:5b1f:: with SMTP id p31mr5793118pgb.56.1542803502625; 
 Wed, 21 Nov 2018 04:31:42 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id z62sm30136997pfl.33.2018.11.21.04.31.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 21 Nov 2018 04:31:41 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: jacek.anaszewski@gmail.com, pavel@ucw.cz, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH] leds: powernv: add of_node_put()
Date: Wed, 21 Nov 2018 07:31:38 -0500
Message-Id: <20181121123138.21870-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

of_find_node_by_path() acquires a reference to the node returned by
it and that reference needs to be dropped by its caller.bl_idle_init()
doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/leds/leds-powernv.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-powernv.c b/drivers/leds/leds-powernv.c
index b1adbd70ce2e..0b1540029034 100644
--- a/drivers/leds/leds-powernv.c
+++ b/drivers/leds/leds-powernv.c
@@ -285,6 +285,7 @@ static int powernv_led_probe(struct platform_device *pdev)
 	struct device_node *led_node;
 	struct powernv_led_common *powernv_led_common;
 	struct device *dev = &pdev->dev;
+	int rc;
 
 	led_node = of_find_node_by_path("/ibm,opal/leds");
 	if (!led_node) {
@@ -295,15 +296,20 @@ static int powernv_led_probe(struct platform_device *pdev)
 
 	powernv_led_common = devm_kzalloc(dev, sizeof(*powernv_led_common),
 					  GFP_KERNEL);
-	if (!powernv_led_common)
-		return -ENOMEM;
+	if (!powernv_led_common){
+		rc = -ENOMEM;
+		goto out;
+	}
 
 	mutex_init(&powernv_led_common->lock);
 	powernv_led_common->max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
 
 	platform_set_drvdata(pdev, powernv_led_common);
 
-	return powernv_led_classdev(pdev, led_node, powernv_led_common);
+	rc = powernv_led_classdev(pdev, led_node, powernv_led_common);
+out:
+	of_node_put(led_node);
+	return rc;
 }
 
 /* Platform driver remove */
-- 
2.17.0

