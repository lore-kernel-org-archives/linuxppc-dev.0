Return-Path: <SRS0=h9PY=ZK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDB6C432C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 13:33:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C001E20748
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 13:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="LDBp0mtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C001E20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Gqdr3FJ7zDqPR
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 00:33:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::441;
 helo=mail-wr1-x441.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="LDBp0mtV"; dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Gmnb6MdKzDqV4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2019 22:24:35 +1100 (AEDT)
Received: by mail-wr1-x441.google.com with SMTP id z10so18960853wrs.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2019 03:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2QjvBFt/Ahp0rywmkIDhfkZ7dAuBAKpWua4zqIA54R0=;
 b=LDBp0mtVCFiTs61O5YXJ16LuAAFhH8wtaXvLbhwE4NXoRfaqYEp6FKGVT2vaF949Ky
 RkF8f68GGwII+OoL/pSznEKhBF6DiPtuZO54muk8b2IyFJErJznWjlXSECWho7drDhE7
 vQt3/hSjdU81hFkXQ6y+8FT4sHHg6s+d213/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2QjvBFt/Ahp0rywmkIDhfkZ7dAuBAKpWua4zqIA54R0=;
 b=B9iU7dAsOLOd+W6EOlGHrzdOWjFSXaIHcPQ683mOgXjQAWwzj3AbJ85BFd7W/SrVag
 VtDa0YrIhFVXpQRh6uAWkPw4AFoCz1iiajbZOHC6ap2lVvg/QGVCG5bQ2NolLfqeosqr
 ETkZdvE8wO5MA20TzHSnnmukj/iKjOx9XXUs4nmD7arIpF9/3mfL8SsTuIlsr3tAwUms
 9IG4wFtJpxWFhIdNygz+VvEDkwDhnT/rvtmR4tWheIvm/DdaCQdke5LOS7unUPYS/O+t
 G8u1KWOnzdUIxceVKToLUR/G7wYI26P5Q/xxflYUpNqE2xH58Ba9M9jITJqkRLWFM1f0
 vVRQ==
X-Gm-Message-State: APjAAAW2zrSyBrQ9pQYvXRKT/Y+/5iI6UqkFTHIVrQ34qpn1F5Dpa3X5
 9/bQM994mS2s93Wyz/Ko9JxZzw==
X-Google-Smtp-Source: APXvYqxZTtkYTYCWP+uZMSlkmiNhl2EyyuM0sCeafVOHfcCFMl5DEdLbaJ//DePb88UnZySftdivKQ==
X-Received: by 2002:adf:e5c5:: with SMTP id a5mr14810311wrn.103.1574076272138; 
 Mon, 18 Nov 2019 03:24:32 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk.
 [5.186.115.54])
 by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 03:24:31 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 46/48] net/wan/fsl_ucc_hdlc: reject muram offsets above 64K
Date: Mon, 18 Nov 2019 12:23:22 +0100
Message-Id: <20191118112324.22725-47-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
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
Cc: Timur Tabi <timur@kernel.org>, netdev@vger.kernel.org,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Qiang Zhao points out that these offsets get written to 16-bit
registers, and there are some QE platforms with more than 64K
muram. So it is possible that qe_muram_alloc() gives us an allocation
that can't actually be used by the hardware, so detect and reject
that.

Reported-by: Qiang Zhao <qiang.zhao@nxp.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 8d13586bb774..f029eaa7cfc0 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -245,6 +245,11 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 		ret = -ENOMEM;
 		goto free_riptr;
 	}
+	if (riptr != (u16)riptr || tiptr != (u16)tiptr) {
+		dev_err(priv->dev, "MURAM allocation out of addressable range\n");
+		ret = -ENOMEM;
+		goto free_tiptr;
+	}
 
 	/* Set RIPTR, TIPTR */
 	iowrite16be(riptr, &priv->ucc_pram->riptr);
-- 
2.23.0

