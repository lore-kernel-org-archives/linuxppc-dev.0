Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA08606A33D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 02:40:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK8nR2dlrz2xM9;
	Wed, 04 Nov 2026 13:40:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793760043;
	cv=none; b=B2rDVwiLCmwgGLCN8rN35v18N5miBlsa/PwOlEYot0J6KA9/Civ3fFJGK78vDQ01CHhzXbp0GvSxhriGyE52iTu8zES8uBfAD6xBlpW3ZtcMFMLnLqujy+vB3ElNUMlmAggBHbAbjB96FoemcihUPgxaY+3xc1IpGU3e/yjdnGiEHXKdlBMWj5wI2f7JfueuqpbOCRDiH+vDS3i3lFFoXzpJtKPB3NTmbWLorNxvj38f6Qu8ed/6OjoJAUFY1WKR0yUSdu4JIaSdb/JhccQUadgQiFuDL26kAGYiJdwszXcnhP2aDsrJbA/ZH+2YnjzUmuTHRhyUV8OzAPsj9JOSAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793760043; c=relaxed/relaxed;
	bh=4su+3Bl8vVam/9rCmV8G+HuWhRUmzj07h5fXyjgVyto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PMPkZ2Yk+cYfB36lsZDgvPqCqnqMS8Fx1M/h1nzWOYPfgjKA7EkkZPqNgA2B7xqA2Hw7DJLcpQ3Zngu8GLDy979BbGVywxaP2qo7C/Uy8oL1AYjSzsIEqAMKLzIPC1GhiXtOM4ojhbl20DAW0rqzU5Zz5GtwvxC08hp12Qoj9+LjAbnAln9rsVk+m7apQrgCf9kDA21cublhHeJo68QpF/d1SIi/tHwdlBf1oZY33or1anY9ukc6ew4XSBTeQZzBtjdJIkJmrvkfI/Sbz3h+QUOQo5OH1+SRK5Xh+6bUoF1rDG6CM5MH6pHZWuo+OdmBxJTM+xB1OAIxzEY53SRsNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jK8nQ3pcfz2yQn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 13:40:42 +1100 (AEDT)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADXxf8km+pqJ7k+AA--.9867S2;
	Wed, 04 Nov 2026 10:40:36 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ASoC: fsl: imx-audio-rpmsg: unregister platform devices on probe failure
Date: Wed,  4 Nov 2026 02:40:45 +0000
Message-Id: <20261104024045.1508542-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXxf8km+pqJ7k+AA--.9867S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr18Zw47GF1rArW3KF1Utrb_yoW8Zr4xpw
	4DGa95Wry5K39FkF4UXr1xAas8Ca4xuw4rZw48Aw17Ka90gryku3yrXa4UJFW7trW8Ga15
	tr4UWrW5Cr4ayr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
	v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267
	AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07befHbUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAABA2rqY+TXGwABsE
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

imx_audio_rpmsg_probe() registers the rpmsg platform device and the card
platform device, but when a registration fails it only records the error
code and continues to the next step. The rpmsg core does not call remove
for a probe that failed, so a card device registered after the rpmsg
device registration failed stays registered forever. The reverse case is
just as bad: if the card registration fails, the already registered
rpmsg device is never unregistered.

Return immediately when the rpmsg device cannot be registered, and
unregister that device before returning when the card device cannot be
registered.

Fixes: c73524768e9e ("ASoC: fsl: Let imx-audio-rpmsg register platform device for card")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/fsl/imx-audio-rpmsg.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-audio-rpmsg.c b/sound/soc/fsl/imx-audio-rpmsg.c
index b55dfbdb4502..950bf9e5b648 100644
--- a/sound/soc/fsl/imx-audio-rpmsg.c
+++ b/sound/soc/fsl/imx-audio-rpmsg.c
@@ -92,7 +92,7 @@ static int imx_audio_rpmsg_probe(struct rpmsg_device *rpdev)
 							 NULL, 0);
 	if (IS_ERR(data->rpmsg_pdev)) {
 		dev_err(&rpdev->dev, "failed to register rpmsg platform.\n");
-		ret = PTR_ERR(data->rpmsg_pdev);
+		return PTR_ERR(data->rpmsg_pdev);
 	}
 
 	data->card_pdev = platform_device_register_data(&rpdev->dev,
@@ -103,9 +103,12 @@ static int imx_audio_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (IS_ERR(data->card_pdev)) {
 		dev_err(&rpdev->dev, "failed to register rpmsg card.\n");
 		ret = PTR_ERR(data->card_pdev);
+		platform_device_unregister(data->rpmsg_pdev);
+		data->rpmsg_pdev = NULL;
+		return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static void imx_audio_rpmsg_remove(struct rpmsg_device *rpdev)
-- 
2.34.1


