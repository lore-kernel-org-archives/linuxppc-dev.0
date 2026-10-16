Return-Path: <linuxppc-dev+bounces-29586-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBAFCC6B38
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 04:11:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5Wj85LFsz2ygW;
	Fri, 16 Oct 2026 15:11:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792123900;
	cv=none; b=W2HovbxjbD0RrkZyOHoyBoDML97WC4OiK28Shnusmq+Xgd/BUxFyZbZ8+yHOFdYNx2d4scGZRmVttJG/EJPCe2QfugwygZ1hJp24O4654KiGeYhkmdpZRIM0sye3ie+Y5iW3nF8Yo8vEiYwyzouE/9VUVdqGBaqVC2yUQep3PkJOeWj4631wgPs7rUfnKr5CPghFXqJSoWjsRAzffZhlFkmtXfbPnHUB8lK0HN0KZA+hadhV8Py0QSjuvVhZVRkttqMlxgm+LhJEpTN1MsIboAaeG1K7puHFc6n7oTQHBws44Gw07wS5u6QqDLJYxAl+1lKKMej7rARASZHHQsnIsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792123900; c=relaxed/relaxed;
	bh=6AfJhOKZbdns69Qk3jxc+qI7b+rXXsiPaDqc4PQO3Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKah0gnnRi1FkDaAXwyjkJroabnjbF6+MQ+pO4Svroc1V5j39YArZFXunjklfKhDjAOPZof0eEvoWiBmJu+eOLPxowvKdKRw/suJZy/8QpGeUgyClxxC0F6CySCEABJ7CNdV5jjl4bMJni6UZKBaSO/sXYbgCn2Zp7Wvm6+nrUB9c7xSAKlc69++7HfKvZp4NGBVDsZA1IiDUqvlm+dug9geFUXjAewQv1kjyy0kbnmXAbdxFJkyojq0/miDzNgdz1CB1iZkjrypWVD5ACDOeVdYkrcihHbVC2jGJKbditb4u3gFWHKloXKhYvDe1mI4m5UHS9bXS9tneFKF45y5Tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZPEC8FMH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZPEC8FMH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5Wj80lHxz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 15:11:39 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2e7e742a2c7so5032155ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 21:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792123898; x=1792728698; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6AfJhOKZbdns69Qk3jxc+qI7b+rXXsiPaDqc4PQO3Hk=;
        b=ZPEC8FMHNQd6DPaApECizDV0+jwzlIDMpp4ZJ7A3gLpe1JZ8S+257HCgdC2ucAdkH/
         x6Un8LQZVltwiU4IBQvaX06KcAqjVueFL7xa5Xn7g9q/jgsUwAFDJFPujQbSWDn1uSwy
         WD1onKTHahdaD12QKBSvJyzkhJunfUhTub8Yzi02Ocl6yPhYi10XccQ+gkOtDGAfkwNs
         5casqLtSRgzhaYLOAfdENI+Hl029unTwywkDiFQr7A0pmy/YAlDr6NYyNlocyMInrwWl
         KuFpvklgBGwh2Qx5ZxZBCFrJz9Jny7BPrAQqyACre3VpQ9fX0WhgvkccDT3aVM56caLi
         joyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792123898; x=1792728698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6AfJhOKZbdns69Qk3jxc+qI7b+rXXsiPaDqc4PQO3Hk=;
        b=ODMvW7yolWf9Q6x7rhACM1VRj5mxX4dpQdXbkDEasYICXHpuOu0HMctpPStThyl8TN
         hz5bM9w4LvWSTe8c+4ffJsjH92nN046O00YBH5nC7zpaOsoRwbX2zniNpG27SJ9Kt7u6
         ZLYiZAgf0FUDCr7rBhqMA58tRHLua+Zuc61PFHLSlin0l9UeT7nj+KTt62FHOy7CdLqG
         QcOUWNxXVtjFH4mJSO7r3fO77O9NrBFqYLc3b+0oEmAW55Ape6I4StudhKumo1IqKSEb
         4li8G/kcHdGELv/e18B6lI1SvpAlGUCTOjjgBh+exTkSDHDcK+lUX/hFx0ptMHAE03jY
         SuSg==
X-Forwarded-Encrypted: i=1; AKwUvBx7YyUY3zf2xHmG61cMhzb9WExJjM8yYMSus4fCCiwxVNbhzRh+LGHJnvQ+1TnRcKf+VwnyxxP6piSoVlA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIYwY7sP7nnczOdFmJZ9kKI1Wamq52kP3D/TVLDtHEpRQrGkDsJ
	sT+iH/U4VZJICvskvaVDJvqaN0ZTURzKwztWVp49kggNBiUgIBXScvUX
X-Gm-Gg: AYBFou27nDZp+8kCztyXuMTYxoXUK4MPb1og+ACS8IkxR5ijkamNLmSpAvGabLmg7C8
	Hx+secRrAc9Ofw39yiuLnj6oxecI162Ge9CLOn1mSbSsYCBIG6Q2nfEuzcqQMpVMJVLPGXJfCek
	ZgQJLLy39820WsKgqwVXliOBH5DAywuK9fBv96IO76jm4VwA3mwZx/e53kT/Kf1RF5xE5EBBT7l
	9KDEtNcWlfUnBCDU2BZsUDqQSYIWBWZFHPkeoF4zAKXk7iXB2AwvagaQLVobJJ5QPpjdD6pd041
	DiF1ldoU794CL6LPuJeJMG/ZOxnFmGF2Kzt4SvLo6jLF3gk0FENQ/r9bZs59mVKby36Nc/QiKCs
	3/QbXTNvdJMeCiVCzbwYz6FL7xD2ph4f6OkqvJn++PE8fkm3p1Nr5M8uGp4xyf+coIXWyjNVxz/
	bGCOWCjdOLi374Eu5STi6dLpV/tQJshanUN9Winp7/9RuwD8wkvNYon3PvL0gpJQZ8oBNQngDEV
	iwI94yloi4jbo4hO5XmmjhdAZ5OT3JHOrQt4R20cYT6bTDFme85V5J/HXs+ZHlwm2Ur9Y6SEcEB
	aPxis8kIJ4m4wA==
X-Received: by 2002:a17:902:e54e:b0:2e8:3b2d:c0e1 with SMTP id d9443c01a7336-2e977597291mr13010325ad.41.1792123897928;
        Thu, 15 Oct 2026 21:11:37 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8ab443sm3815785ad.65.2026.10.15.21.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:11:37 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	povik+lin@cutebit.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrei Simion <andrei.simion@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Kees Cook <kees@kernel.org>,
	Syed Saba Kareem <syed.sabakareem@amd.com>,
	wangdicheng <wangdicheng@kylinos.cn>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Neo Chang <YLCHANG2@nuvoton.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	u.kleine-koenig@baylibre.com,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Md Shofiqul Islam <shofiqtest@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Zain Aboobacker <zainaboobacker33@gmail.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Bo Shen <voice.shen@atmel.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-sound@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	patches@opensource.cirrus.com,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 07/11] ASoC: renesas: msiof: Explain component open return value handling
Date: Fri, 16 Oct 2026 11:09:42 +0700
Message-ID: <20261016040946.521195-8-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016040946.521195-1-phucduc.bui@gmail.com>
References: <20261016040946.521195-1-phucduc.bui@gmail.com>
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
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Add a comment explaining why .open() must return 0 on success
to ensure the component is correctly marked as opened and
prevent future changes from reintroducing the issue.

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/renesas/fsi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/renesas/fsi.c b/sound/soc/renesas/fsi.c
index 88618e4b052d..74e2ea002fbb 100644
--- a/sound/soc/renesas/fsi.c
+++ b/sound/soc/renesas/fsi.c
@@ -1820,6 +1820,11 @@ static int fsi_pcm_open(struct snd_soc_component *component,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure the component is correctly marked as opened.
+	 */
 	return 0;
 }
 
-- 
2.43.0


