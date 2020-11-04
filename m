Return-Path: <SRS0=IsZE=EK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4FAC4741F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2020 19:43:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9840A206F9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2020 19:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lBGC22hr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9840A206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CRHBL6kS2zDqhT
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2020 06:43:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::344;
 helo=mail-wm1-x344.google.com; envelope-from=lee.jones@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=lBGC22hr; dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CRH364PdzzDqdv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2020 06:36:50 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id c18so3512956wme.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2020 11:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zxBTDWs68qW2IKMyEc77XRI2Jnwwebqtmwz2IV/xXfE=;
 b=lBGC22hrQ40oIvqXRErxf0OYpYRByN+EoViOk/xvc/ZcFLq19660h8+8xXVsiu9vud
 +/CliTSp2aP8RZ+UvcpoXEY5DopYhvMr2BCPDjYw9pF6/ehngNnezDgWTPiCaGK105bv
 rGlbQkZVvkB7ujPAREYsSgjeYk7omOrHtr6mftUmSAYQJB/i6OIRHZrNiqGPB4gh90R/
 XGzS0cShqv30RMA3wQJeeugIKOe1F+nhFGAb9p2Y71kCD+yk/jpQ2LBCMLqnPxSeihKH
 RtOfR3/LIkVTYtur3KydW9GjMbmy6l46Tl6UvV4MTu+bj0+tVtHSsLhjGvQu/OOhLgGx
 fFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zxBTDWs68qW2IKMyEc77XRI2Jnwwebqtmwz2IV/xXfE=;
 b=QHCe2ZeQlk3vHxxiuSI5SWHwrFgnJSmLjqKWIBjDRbv7+0gtCYhrFa4G+UqL3obv/A
 kpW50ZGvsb/inaQgx1cs/YFvkj2ZLK5FQifgZgc8QrVcyqv4ngp8sgfMbnR9Fx3dvLNN
 7kfxV1b1zO31IRW5GqqRa8GYYShuKP0iNpJEuBVpMfdMNpoEZLDZ9NFi2HK2W4Xf6KHC
 W9QT3TVHWtvIT9Jus+9xrjWeFQaTT1C4z2wIPDCBI2HMZ2SdvdE0ESAst8Pq+I76//Q6
 oOZ4B2A2uX7V/kGNd5Sug7NpnWqyVQI5BQH5Sqz/xiVXSKc7cyIEvi59IQyO/ixnl1NY
 QtDA==
X-Gm-Message-State: AOAM532Nyc/Kwt4FCV2OTtcvEHRfbuLTAseP4hlf/712R5AmEC0ypxNt
 6pl+fgDAHEsobGt2zO9pOjGjWg==
X-Google-Smtp-Source: ABdhPJxXR1wM5qdy4HdVNYzdft1GlgyNDm7GFF04Vwdmpm24W7EfG3N0V4cq/CqyRxar/qGpno05eg==
X-Received: by 2002:a1c:1f91:: with SMTP id f139mr6057124wmf.187.1604518605931; 
 Wed, 04 Nov 2020 11:36:45 -0800 (PST)
Received: from dell.default ([91.110.221.242])
 by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 11:36:45 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 32/36] tty: hvc: hvc_vio: Staticify function invoked only by
 reference
Date: Wed,  4 Nov 2020 19:35:45 +0000
Message-Id: <20201104193549.4026187-33-lee.jones@linaro.org>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, Jiri Slaby <jirislaby@kernel.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fixes the following W=1 kernel build warning(s):

 drivers/tty/hvc/hvc_vio.c:181:6: warning: no previous prototype for ‘hvterm_hvsi_hangup’ [-Wmissing-prototypes]
 181 | void hvterm_hvsi_hangup(struct hvc_struct *hp, int data)
 | ^~~~~~~~~~~~~~~~~~

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/hvc/hvc_vio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_vio.c b/drivers/tty/hvc/hvc_vio.c
index 7af54d6ed5b84..798f27f40cc2d 100644
--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -178,7 +178,7 @@ static void hvterm_hvsi_close(struct hvc_struct *hp, int data)
 	notifier_del_irq(hp, data);
 }
 
-void hvterm_hvsi_hangup(struct hvc_struct *hp, int data)
+static void hvterm_hvsi_hangup(struct hvc_struct *hp, int data)
 {
 	struct hvterm_priv *pv = hvterm_privs[hp->vtermno];
 
-- 
2.25.1

