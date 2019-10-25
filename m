Return-Path: <SRS0=byMz=YS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA93ACA9EA0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 13:53:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587302084C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 13:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="e1DVB6RZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587302084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4705F05T4HzDqnx
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Oct 2019 00:53:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::243;
 helo=mail-lj1-x243.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="e1DVB6RZ"; dkim-atps=neutral
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4703dS2KNSzDqd3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2019 23:41:32 +1100 (AEDT)
Received: by mail-lj1-x243.google.com with SMTP id a22so2575686ljd.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2019 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hZ80kzn0Gvq+HATqtue47iWJ3txb4sckDQxEWou7YbE=;
 b=e1DVB6RZEIL83T6n/wBWlDoSAGhgc43PWtNmqC+8x8knw1OPJuHYkFi6EckaV0yl50
 3NosFnZQLJRuhrGVXGt9YAJsZfBzRMZwHn8bQXhFdHCQpU+CKevYxKU3bP6j/l2J0a5v
 7J4JQLigfgV2yB+YvMuOIhkA821Cd+cf8A0IM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hZ80kzn0Gvq+HATqtue47iWJ3txb4sckDQxEWou7YbE=;
 b=EI/qMn0EbqmBZMz79mdNz5W1ViODvfwAcxb47rUPwYoAvgSpAkQt1IkdF3ApIAq+91
 HVmL+3mtYt5HS3E9Yv/lDQpRQUW4GOnLGfjkg+LnsVUCUwVWWh28TWeAV1+YXRtaeLSb
 2ynoIh1NfEK+ErgthmKKKJLf9npwuv26crwklwkIAf7ht1YmhO2Fv2ri/ddfvytIrjFU
 4mG2NVAsYUxio9f3Cd2nF7aUEWXEWlDe3637erwix0D/ThkSaDJThlG2DaKd9H8wZYhz
 8Bbyry9A0tilZ83Il1BdQn/Hpm5SUDUXi59+Nq3KUo95oxf0E2T9pXqhVUC4FlPuwnUU
 ZnwQ==
X-Gm-Message-State: APjAAAXGEl369O///Ii0u4G1mcHzeduwpiXIMdsGGZisRkGFUmY3viU+
 PcYF3VCnJFhwo4+8+GVyEkb9zA==
X-Google-Smtp-Source: APXvYqzWrsLr+TldTrlwBZiQV+Lk357fJEtEmfSVzLgRlqUQdBGnYmw9pDFh/e+z/41+RxJtA1JaXQ==
X-Received: by 2002:a05:651c:120f:: with SMTP id
 i15mr2442422lja.144.1572007287647; 
 Fri, 25 Oct 2019 05:41:27 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 05:41:27 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 19/23] net: ethernet: freescale: make UCC_GETH explicitly
 depend on PPC32
Date: Fri, 25 Oct 2019 14:40:54 +0200
Message-Id: <20191025124058.22580-20-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
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
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>, netdev@vger.kernel.org,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently, QUICC_ENGINE depends on PPC32, so this in itself does not
change anything. In order to allow removing the PPC32 dependency from
QUICC_ENGINE and avoid allmodconfig build failures, add this explicit
dependency.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/net/ethernet/freescale/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index 6a7e8993119f..97d27c7740d4 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -75,6 +75,7 @@ config FSL_XGMAC_MDIO
 config UCC_GETH
 	tristate "Freescale QE Gigabit Ethernet"
 	depends on QUICC_ENGINE
+	depends on PPC32
 	select FSL_PQ_MDIO
 	select PHYLIB
 	---help---
-- 
2.23.0

