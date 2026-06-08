Return-Path: <linuxppc-dev+bounces-22200-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C585CD8C9F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 13:40:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYtSy3dbkz2yv0;
	Mon, 08 Jun 2026 23:40:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780926002;
	cv=none; b=HtXswdTT7Wk+eXKSTU5a3CZLPwJ5UVHXSNBu+OReHxItrYAyqpJyKV3O1tjkGPKCgb+q4r5HyyQUh4KdrsUmimFkiMdDz94EhcHQJ39B2C8FMyBzQ5A3hblMPENTP1VbC7P0L5Jy+9uzKO2qb6iI3l+oWJHFtmNnREi5F46yEOH6staJuRqV5yALfRunW3oA2v/SOWi5sHH68Ur0jsSrTFOiBZDIqHSMfxO7HMiTxQlCve0TaHjA/3kvLLPP5iWsaXQ4/AxiTLBdNOFipGgDmTpBS0BFrJmd90qLSbfQYdp3AxwAZS/QtnqdrcbaScKHHHNPHxNHEpiiMzjzCdR0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780926002; c=relaxed/relaxed;
	bh=r+CdAGYIEklPCYPkGTaICLk240mHu6t2xegNP8dRyKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nmiv4KJEy4sqPSYDjiTlV+QRoBCeW9RPlaRgBOhDsqjZ8hqBTnYOOfIa0g3srjOANl2P+Lhjp93N63TGZ8inn1cGBfikK7csoF+vPstC4vgSAQ4ozFosBtD1IsdonS0OYVPrYG0eM6SxOYJfV/jlvCsPj4lUyMTOJ8/DO3qIM+W7mnLpC1P3snl5eAcH7Xh2zBaPoDxMzc2p31rGod6QCkFZEL9T0wMkhH1PJI8bW73ya/u96LHt8FyckeI0uUZaJbGag9Sb7NNA305CFwNov2zIcHVpJ5zigMAgfDCqFsPJFK8ksZs5gUiZxRrndDoc3YQfJPrvf6AW9dKEy7oEZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OsqR3tv3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OsqR3tv3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYtSx5hrfz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 23:40:01 +1000 (AEST)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-304ec41197bso3954370eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 06:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780926000; x=1781530800; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+CdAGYIEklPCYPkGTaICLk240mHu6t2xegNP8dRyKY=;
        b=OsqR3tv3o1sep0eLZJMAjgDwn0F3h1K8AqUP8nlH2txwfaiQH2miRvcbZdss4q9g3C
         4ga1EEphwExmhkKaKoA497ZLemK8plmewSkphhz3vRT2K/TIpdmJfOR85sLf0fKhRmWX
         PnYaqmuLecj9ef6fRiFGiACSv1v58fa3G6IVx22Yl+Om7xPZ8yy0CsCY3PslfNxoaRqo
         /Pcno+krnZKWE376GmvOYEI94zjl5BsGkew4zRLMFrbmCFkaOevKWilP6iEb+4/NLhQq
         suUGumuWNHHdz2Q8pXabYaNxsGihtTytNQHYOgooRvi0G/o8vf33SW0YPdqbviU+8e4R
         JzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926000; x=1781530800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r+CdAGYIEklPCYPkGTaICLk240mHu6t2xegNP8dRyKY=;
        b=Zc7NBp3WCsEezfR1Raq8ziocvNSHd6c25uSc8gtBQOknzgKl/4K+aeTAJZpzS77xRL
         67npWvG9kF4K6QTkayDScMvpMt659ETe8L7+N09cGyWdiPE7YtMeCdvIlWeBeAeoZZNM
         SDTxctggCnhgwcfKLOUMsYIQqj0WefVbFnQnapUEyQm6GLNtgCCOgg9MDw+vdPOeHGV0
         GrEupLrzJ85joFZs8Pvx3wyznN5bxD6j3uDsAGPO22H+dw4cxQiGL1W9sSRM6V41dK9R
         NSelKjafRYT6IT89uBSFbA+8DGLRdQCzUt1YXrUweG9i5AzLNpaICOW3NfnZRzjNuAFg
         Pkcw==
X-Forwarded-Encrypted: i=1; AFNElJ/aMbwq2HdT2Ue8gJnAIfvGfAxm7QG5K3ipDE65CMR00jGyOcrivIje4ot13XeOlc3SNoecw1DL4dk3h1c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwCMDvvEmgxeIi5dftrvLMkbZeJgJCI5iedf7LkMD7RcTMyOA+n
	xv9JCetGJGUnyf/w9V9ptYLcxG3NRiaS971z57psZIvBGPsBMGeF/KXy
X-Gm-Gg: Acq92OFevyak0TIWjSqGHpCO5ZwUdRHQtb1XXpHyRTPW/TYVVg5kvoI16vRWdrNfqBU
	oneSTY9MZpzKs6gixWoDf5sLMVjplrhnwgEU/Rw6MZ+vr3qpt2geokhGhHkIYUiBs0fLXGVS9u2
	b2o0gYxse8ICcshAQyyg6c5REjbjJS/LY6EheEiOMax5x73TbS+n+pWZosSSH1dQJdKJhfi7+bz
	isa35+i0uaAPL55cnFjY3zCx+Q1V7Ap3UQwcT9eCbfdjtS/35W7CmWe2lGMqJ7cBh51Hhdgs7h7
	FbcWmx/QwIBYdjBUGkVjIObqNYq92ZoCt4C7AMOcXXu77dslbvlThldIhhFFPrRDrQp+Tz6XQup
	q3WlYeaihaO5GKMMn2aYGQw1WKyrTK9CfkyWIR9eAYUjHIiehrNuiL8QBXZ2ZJlgHhKH5IVDkS+
	T225RV1aYPTz4dhChxgEtv7lGmlDyVZa9sH0hN67JnDpeDTDw0zu/B+woUElnAZzGv1LMWMP5rP
	kBaXvMOnKvc
X-Received: by 2002:a05:693c:65d9:b0:307:91f5:8eee with SMTP id 5a478bee46e88-30791f5af59mr3853798eec.12.1780925999720;
        Mon, 08 Jun 2026 06:39:59 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-23.user3p.v-tal.net.br. [177.4.161.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db560d7sm23893449eec.5.2026.06.08.06.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:39:59 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Mon, 08 Jun 2026 10:39:13 -0300
Subject: [PATCH 3/3] ASoC: bcm: cygnus: use scoped child node loop
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-asoc-of-node-scoped-cleanup-v1-3-9e3ac518dc2e@gmail.com>
References: <20260608-asoc-of-node-scoped-cleanup-v1-0-9e3ac518dc2e@gmail.com>
In-Reply-To: <20260608-asoc-of-node-scoped-cleanup-v1-0-9e3ac518dc2e@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Herve Codina <herve.codina@bootlin.com>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, notify@kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1564;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=vyC7w6pskJBgaLu4nRRhMfqupYy0eXGTyLVkdxR3pJI=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDFlqxyRKLkZwS7AE2Tf2p92fUXVnr8gKwS6tnBXNy1btW
 jiJT2laRykLgxgXg6yYIsvqpEWWe7oeXK2PW+EBM4eVCWQIAxenAEzkchYjw/9Qn6uF35RTdtpk
 X+d4MWXhlgeaC3X+Lbn4/qig9NQvKk4M/+tcorM3x6i7Oc46NWO+9mLXuXL6M27kyvu1n9gTu1u
 MnRUA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83

cygnus_ssp_probe() manually puts the current child node before returning
from the child parsing loop on error.

Use for_each_available_child_of_node_scoped() so the current child node is
released automatically on early return and normal loop exit.

Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/soc/bcm/cygnus-ssp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index e0ce0232eb1e..47706ae0a31f 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -1298,7 +1298,6 @@ static int audio_clk_init(struct platform_device *pdev,
 static int cygnus_ssp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *child_node;
 	struct cygnus_audio *cygaud;
 	int err;
 	int node_count;
@@ -1331,16 +1330,15 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 
 	active_port_count = 0;
 
-	for_each_available_child_of_node(pdev->dev.of_node, child_node) {
+	for_each_available_child_of_node_scoped(pdev->dev.of_node, child_node) {
 		err = parse_ssp_child_node(pdev, child_node, cygaud,
 					&cygnus_ssp_dai[active_port_count]);
 
 		/* negative is err, 0 is active and good, 1 is disabled */
-		if (err < 0) {
-			of_node_put(child_node);
+		if (err < 0)
 			return err;
-		}
-		else if (!err) {
+
+		if (!err) {
 			dev_dbg(dev, "Activating DAI: %s\n",
 				cygnus_ssp_dai[active_port_count].name);
 			active_port_count++;

-- 
2.54.0


