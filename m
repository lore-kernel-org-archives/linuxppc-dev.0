Return-Path: <SRS0=IsZE=EK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CE3C2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2020 19:46:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F0F206F9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2020 19:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uXVhNdK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F0F206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CRHG911pgzDqkf
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2020 06:46:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::343;
 helo=mail-wm1-x343.google.com; envelope-from=lee.jones@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=uXVhNdK2; dkim-atps=neutral
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CRH385bQWzDqdv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2020 06:36:51 +1100 (AEDT)
Received: by mail-wm1-x343.google.com with SMTP id p19so2557135wmg.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2020 11:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xSLrFShdIRGu2Z0l5VTYddY/Kvq8FZAdgHuY+BxUcAw=;
 b=uXVhNdK21Wddb2jNKS1C3MSNolc+cUuO83JkVAMzjCfcEK2rXqEZm/X1pgBv2scGnk
 +zTIi5I0E4UUj/SWhQfmDr4tTemUDgmD+vqMldqbc5VWlLHJw2VznOLL6cQQ2riRvOjG
 Oz3R1W52EjItgciKCtJDyJKyo05tCZUvncTXKz9jxULN2eOCWOXSpg/nn1SsPqc+TKi2
 XZwrXq8AJJjdtvwzfzghNkV7WmH/DZmphK+Ic4G2O2tM2X5o1FnlnsBABertwo8bI23y
 X6giOXaKIJ33PQGAg6tdVHGZfQVQhSn2ryN1HGPgk+bdVsnkAZG+Q6LnLqFwBGp34hPA
 vlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xSLrFShdIRGu2Z0l5VTYddY/Kvq8FZAdgHuY+BxUcAw=;
 b=prPS9NjgPIxIsOel+wZO8eHX39S00uZEzf2/co8PplhtF/FCdu9JyiNCP25PVJOcuJ
 SPpc1UOt9PcgHrOX2NOBdFmB3JxHCw+NjLzRpmZoswO2iSJl92fmEXthzfamW7Vgv5ZA
 t2+hPJCKEGs8tDj+/Y24MZjZmCeUSEXk6bsjQwzzSE9bMdigsjTYHFhayHcqGUx/0J1K
 GQmVlKAl+ygiwLY0y+XqAVvQiLuzE40HNIsxi2gac8nUjZDUJjgLD4uQDiPZrMML9r+I
 0N2FvVhLU6vlpTF+uGT9FLGJ0GVTC7mW5dLaIJmR042A0jEdGv6gybKGNmVtpC58Ogwu
 Ot8g==
X-Gm-Message-State: AOAM533HQWY9WIh64jrQG9HzU44HjbHNYTnXD8Sg3S5ercMWK9xqZL79
 kj+QP/VfQFzOtDZz3lc8UXW+ZA==
X-Google-Smtp-Source: ABdhPJxv4RJjIe6ZQcTMccVOlCyU/O+jKiSTg54znUrsoQWEPdWdSKIPcsjztIYwEOZvLvE96ySv+A==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr6307261wmq.30.1604518607199; 
 Wed, 04 Nov 2020 11:36:47 -0800 (PST)
Received: from dell.default ([91.110.221.242])
 by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 11:36:46 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 33/36] tty: hvc: hvc_opal: Staticify function invoked by
 reference
Date: Wed,  4 Nov 2020 19:35:46 +0000
Message-Id: <20201104193549.4026187-34-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fixes the following W=1 kernel build warning(s):

 drivers/tty/hvc/hvc_opal.c:106:6: warning: no previous prototype for ‘hvc_opal_hvsi_hangup’ [-Wmissing-prototypes]

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/hvc/hvc_opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index c66412566efce..056ae21a51214 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -103,7 +103,7 @@ static void hvc_opal_hvsi_close(struct hvc_struct *hp, int data)
 	notifier_del_irq(hp, data);
 }
 
-void hvc_opal_hvsi_hangup(struct hvc_struct *hp, int data)
+static void hvc_opal_hvsi_hangup(struct hvc_struct *hp, int data)
 {
 	struct hvc_opal_priv *pv = hvc_opal_privs[hp->vtermno];
 
-- 
2.25.1

