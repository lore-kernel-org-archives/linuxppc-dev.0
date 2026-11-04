Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B49E606A32C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 02:40:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK8nP5d65z2yDD;
	Wed, 04 Nov 2026 13:40:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793760041;
	cv=none; b=Gba/CQ7+diKWuICVWhbjC92FTjF9Yqpcg8aP4JnfArWDrIw0ONZF+P+m7ivVS9jz5slqV6Hh9CYGmAQ958IvgzPQM7ev6QWSowHPE4zeO5rKZFEV5YX3/qLUP2iKG3YIdRlQp5u3Xe1UScHsoy05AsuXY4hUe6ZtPCVTMWjdwFCzunBa1RCk1r1nGyZuT9PjdHy9DjndLZ9vqJMbmAin0FUZhEP8uOux3M0nN2izPDV2Wg7Lkna3qVNx/wIexzBBshjvWQkj1lwxc35mt9u57b1wA03aNMIfvd5YcIu1HEV7+JMRG0rQz8GBLZP2V/ms87Cg59X1NEHch4T0l8zXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793760041; c=relaxed/relaxed;
	bh=mSFLW4vQystCHrRI4U2kQ/9vGU1vHtRsLrLCF6xYFj0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nG9bpimMIkrE50gUbI0vLZlUXa4UuAawEgjt67WSbPQrNRU7M60uJTRYu3Vat3jRf9JZxOaLswYq3RdYHPfX8MiMr5TfqiNiaKQ4U+dyqFVV1TvMsHCC2IssV25mEGelWe3cyboSoQO1FJsfiFiiBgq0/MW2fCrHo5BuM+krDCw8SKaEpsDzovPOhdfDBvWf9T7Z8wIamj8zBTfwCgYTKf0Syx3rdfKy+VWa04CKQbgxLVsOYMJnI1iJDrpfXnxqrSNawnYeB6C/lnHx46POONs+a342VidwKO6yyYq1gh2E1KmZImLnrXi1bX6IdSgrVlKbMC/Xuixc3CKzgCn0UA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jK8nN4wbYz2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 13:40:40 +1100 (AEDT)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABXhP4mm+pqQ7k+AA--.4864S2;
	Wed, 04 Nov 2026 10:40:38 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ASoC: fsl-asoc-card: drop the ASRC device reference on probe exit
Date: Wed,  4 Nov 2026 02:40:47 +0000
Message-Id: <20261104024047.1508601-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:qwCowABXhP4mm+pqQ7k+AA--.4864S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF47KF1ktrWkXr4UZrW8Zwb_yoWkJrb_K3
	48u3s5ZFy8Grn7CFW5Wr42kF4kXFnrWF47GwsrKF48J34YvFWfAa9Iyr93uF90qws7Jw1D
	Jw1DXrWYvrW2vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbf8YjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14
	v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU5SXd5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAABA2rqY+TXGwAEsB
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

of_find_device_by_node() takes a reference to the embedded struct device,
but fsl_asoc_card_probe() never drops it. The reference is leaked on the
successful path as well as on every error path taken after the lookup.

Release the reference at the asrc_fail label, which is reached on both
success and failure.

Fixes: 708b4351f08c ("ASoC: fsl: Add Freescale Generic ASoC Sound Card with ASRC support")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/fsl/fsl-asoc-card.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 310ee4c282a1..d361bb58fdb1 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -1378,6 +1378,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	}
 
 asrc_fail:
+	if (asrc_pdev)
+		put_device(&asrc_pdev->dev);
 	of_node_put(asrc_np);
 	of_node_put(codec_np[0]);
 	of_node_put(codec_np[1]);
-- 
2.34.1


