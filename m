Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA7606A330
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 02:28:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK8W02gMkz2yDD;
	Wed, 04 Nov 2026 13:28:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793759292;
	cv=none; b=TSCNy+yCCp1fABIX8l6FE7XRxr6rccgdDymnBFS6PcSzihxp6chUOPoY33s6VOOtUd9ngP8M2df49J4sDtZyZpifPCciPxRvrjz6/X5qJ4hLtJqpcCml3rE/NAFpo+tXwnd9cVnPXdVjBEsNfesLl9tqnJxybQx6mJ7L5e+7GkTNpMvMuBENZevhZLfhsIolp53lrgqbpmFI70KFwfY7YUUW+cvJUli+rMik3YAxzEhymHx4EOtIhAaMYa/l+85VkdYmtePSwt9le+n4VoCk/g389fG875U4Yznz5dWgW3FJSlmzEViiHhXGBmQQDxUZKdogrtEurH+IoSkP5hJjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793759292; c=relaxed/relaxed;
	bh=i58akWjzUYm8bTHH/RbasE8Ou8t+HVevZjRVQ3Fujhg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TunB9mFBZlmHVC6Gh0UysGRPkkPJiwv0+vHSn3RFVbjjT3RHw3qi+yv57fCIpeJsoFRF78rfS0zFexc+Zm7Alb2Jp81Lb+1hkqYbYtRujs4TxXf1SFLfCtSwk9/wlpmnAZmA/FfRu+GoUhW4quLnTcAeJctLdg5nKptMvdytsfFkHHx/ogcU9bIl5935g+eOiVxDXT6A4Pj3Qb+k5wQB/cF3sJvYlDBC0/YNwp8PidlS//YDKBQW3b+OE+DrB8ps0nQNdJHvekwVzoRvda1FtCjbKrBcV2T//qAIfydPtmN/NEw8a+WfXNdt7Chjn2dKGUwd7oCubOeGYjgkuzktIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jK8Vz3VP8z2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 13:28:11 +1100 (AEDT)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABnVf82mOpq2Js+AA--.27325S2;
	Wed, 04 Nov 2026 10:28:06 +0800 (CST)
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
Subject: [PATCH] ASoC: fsl: imx-sgtl5000: drop codec device reference after probe
Date: Wed,  4 Nov 2026 02:28:15 +0000
Message-Id: <20261104022815.1484320-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:qwCowABnVf82mOpq2Js+AA--.27325S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw48Gw1furyUWw1kurW7Arb_yoWDGwbEk3
	48Wa4kZryrGr9rKF1DZr47Zrs7WFnrWFW7Jr4IyF4DW3s8tFWrXry5Gr45uF1DXw4rCrs5
	A3WUZFWFgr1S9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxYjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_ZF0_GryDMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267
	AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07bz5lnUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMBA2rqY-nHZQAAsg
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

imx_sgtl5000_probe() takes a reference on the codec i2c device, but the
successful probe path returns without releasing it. Only the error
paths drop the reference, so every successful probe leaks the i2c
client device.

Release the reference once the card has been registered.

Fixes: 81e8e4926167 ("ASoC: fsl: add sgtl5000 clock support for imx-sgtl5000")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/fsl/imx-sgtl5000.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 8bcf54ef709e..8ce333eb47fe 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -177,6 +177,8 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 		goto put_device;
 	}
 
+	put_device(&codec_dev->dev);
+
 	of_node_put(ssi_np);
 	of_node_put(codec_np);
 
-- 
2.34.1


