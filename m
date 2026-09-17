Return-Path: <linuxppc-dev+bounces-27629-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BECC88E72
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:56:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm23Z03zYz2yYd;
	Fri, 18 Sep 2026 02:56:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789664217;
	cv=none; b=Bvvwe9Ec6xZ+mctrREjLj0odEq8w6qAhjML5QihI5r3MG5tDju+AvURDRYJRw2jOG+uBLS7EcYk2j7e+SEOUNwDqEqd+E+vu3U2tIeZwHvl8RX2bVFj0Qe7wB0o2gxkry/i2GpwlVRGfFZr/aABgn49yD/EyWHaIRto2u8zsjDAH+n2v0UD1wOpEY0Rm92z98NEcR1knWZUWB+M1pKJSxooxEwaKrRPwNPE695OJ4tfTw85+ZJmabVFeS3gyGpLp9F6RndXXa77+p+LP5YLvs43UIFCsHNMqr9Q6oBN0QNk2DyD8ajYMYfOsCaj8E6zB+t52kG8HJpfhFm9r89h+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789664217; c=relaxed/relaxed;
	bh=rz/Xp3vvmz2tEKlnwzV5t3hsnoIAF5UjFWkSOwSwnSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FRRgIlffh1WpAZT63U42kM2AIuQw852Xf30Pb9n2kpJt0DYLyxM6bNbDGcJvAOXFj8VPVeFZvCcKbVfQQl8HuUOnT4kOXjHz+zniKJnbqpz0lG2XZDQIxqdzokWghbZJQOuruad7OonHfJ3mrOBMfRGK68Dcmum+FYR6u5mG8TSLhhAPj6/c9amcEnWEG+sxw0d168kJCROtt3L8MT2KLCZjYRiCHnCC+R4ECP8jUnHO+5KlMKzdPI7n53Vpxz3ezbl29TMZvFPtgE4wUxgsyY3Xl1SvhmMUmao7tG1YObb7qo4efB1pkT87323IZNIF84INTH5xOx3PZ1GtyDwTww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm23Y0nhZz2xSR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 02:56:56 +1000 (AEST)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABHdkDWG6xqLeiECA--.946S2;
	Fri, 18 Sep 2026 00:56:54 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Xiubo.Lee@gmail.com
Cc: broonie@kernel.org,
	festevam@gmail.com,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	shengjiu.wang@gmail.com,
	tiwai@suse.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: fsl-asoc-card: Fix codec device leak in fsl_asoc_card_probe()
Date: Thu, 17 Sep 2026 16:56:54 +0000
Message-Id: <20260917165654.2163461-1-vulab@iscas.ac.cn>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHdkDWG6xqLeiECA--.946S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GFyfXF1kKryfJw4UZrW3trb_yoW8Jr1Upw
	nIga9xGFy5Gr129a1rXrW8Zay2kryjy393Jw4Fyw4xKr9xX34FvF9aqw1YqFWftrykK34D
	ur9rtrWrXr1rZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7Cj
	xVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr
	1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbUPEDUUUUU==
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQNA2qr9LZcAQABsM

The codec device reference taken by of_find_i2c_device_by_node() is kept
in codec_dev[] and never released, leaking the I2C client on both the
error paths and the successful registration path. The same slot also
holds the reference of_find_device_by_node() takes when the codec is a
platform device, which leaks in the same way.

Drop those references on the shared exit path.

Fixes: 708b4351f08c ("ASoC: fsl: Add Freescale Generic ASoC Sound Card with ASRC support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/fsl/fsl-asoc-card.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 3fdc77d5968b..04adb8e76e29 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -1069,6 +1069,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	of_node_put(asrc_np);
 	of_node_put(codec_np[0]);
 	of_node_put(codec_np[1]);
+	for (codec_idx = 0; codec_idx < 2; codec_idx++)
+		put_device(codec_dev[codec_idx]);
 	if (asrc_pdev)
 		put_device(&asrc_pdev->dev);
 	put_device(&cpu_pdev->dev);
-- 
2.34.1


