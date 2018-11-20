Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF4AC04EBC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 13:10:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAAF620685
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 13:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocQJN3yO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAF620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zmJz1q8QzF3F9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 00:10:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ocQJN3yO";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=tiny.windzz@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ocQJN3yO"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zm8c2HxZzF3Wx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 00:02:56 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id z9so981277pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 05:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=qA2M3gyf7tWKriE7DGWPlyQR3HbBH/LFqU20I/0lZ7Y=;
 b=ocQJN3yOFfwfAM1tLaNVhHZmBaZjETYvg9ZlSUAB+CbJF5R1XzJK5BapiybDV6A10L
 6r8wTkG0sfRysnAhznW8DcmuMxspDT7AdVA2PDQGSZhoGLorqWvAWMK5j5ghzLxSFxBt
 wucSjnLLgo+Ljy3F5HaNt/nsDuAR1WcsdU9xXsPelpG7DynFf10u5VD/iCOooS07XMCO
 CuXkPDhTo+DLWBrmXjXWejPuSEKSHFIWuUJsO+Cy1SgoUkPWD+vxaes3PTBiMwHm9fx1
 wS2fZqEtacLiwpBiO4lt4Jh3H5+Ldtw2z+W2ax6zFBNPPOlMtG4aHnqx+VWQhMInfctb
 RqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=qA2M3gyf7tWKriE7DGWPlyQR3HbBH/LFqU20I/0lZ7Y=;
 b=PQeOeUkaXB723iUMXQbzj2quvSDeeKw7Xki2rM+sIdu3z6oDS4H67Ldnh5xPlDR2ZJ
 lhrv2rHu/DCAfyUfODIHfXAyhwIRWZ8cIbUfokt2qTqtwAz9OODq+z6B8jkbxsbZPWbh
 tJ4g40N4w6gXeganBIuRaaKWXFtYL3JWVYn5ByRGC9GEc6ksE3mypcesPdVfckVmpRV0
 MoImPUKe6UdGrOiov9GGcyjYOfm90s5aT3O2LGavkqq3Wq7qpPJyEaFAxohuqkvT2ATY
 drfZJHThPJKYrAf/8xF6Aaw5yyDycFQ+WKVJ3UQWJOF0HyrvXT1T9uByvanC1vyxGJwD
 f5fg==
X-Gm-Message-State: AA+aEWYtT0FSnBGljQFKqOYLjgeYojU8OuAQb/Lf2oZxFns7PA09Dtmf
 bFyIFxY0m4OehGx/lLXt5GA=
X-Google-Smtp-Source: AFSGD/VlrcFE7tKbovFzf8N2e2W6bQVF/n8iGcfWP/uKWTpZjlNssWFtWOF/cQz4icLx6y+Uyz3zxw==
X-Received: by 2002:a63:200e:: with SMTP id g14mr1809566pgg.235.1542718973563; 
 Tue, 20 Nov 2018 05:02:53 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id i189-v6sm70021706pfc.16.2018.11.20.05.02.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 20 Nov 2018 05:02:52 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: davem@davemloft.net, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Subject: [PATCH] ide: pmac: add of_node_put()
Date: Tue, 20 Nov 2018 08:02:49 -0500
Message-Id: <20181120130249.19525-1-tiny.windzz@gmail.com>
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, linux-ide@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/ide/pmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index c5b902b86b44..203ed4adc04a 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -920,6 +920,7 @@ static u8 pmac_ide_cable_detect(ide_hwif_t *hwif)
 	struct device_node *root = of_find_node_by_path("/");
 	const char *model = of_get_property(root, "model", NULL);
 
+	of_node_put(root);
 	/* Get cable type from device-tree. */
 	if (cable && !strncmp(cable, "80-", 3)) {
 		/* Some drives fail to detect 80c cable in PowerBook */
-- 
2.17.0

