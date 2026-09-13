Return-Path: <linuxppc-dev+bounces-27193-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0BFC88E5C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Sep 2026 22:02:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjj2J2rNFz2xkr;
	Mon, 14 Sep 2026 08:02:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789304272;
	cv=none; b=e4B8dO2MKMZgIjf/Ko8wQzmRTFWJd+gcXSzLaWLZaOE4gnZAvuQJ5NTIzwhKvk2nm2vOpuW7/Xt+n27TedAX7fwMbSUGr49gBLsh99KL2K5bxW23zyluaN0NOKJc9P/8a2u79D5D5RODipo2C6fMv3OlPD3vj8oTFkFKFYZhEipA3q3pA4SSKjQhE80CKn0ww0L815KsNEyPixd1C3Do2LCHZtFUzyo8NLd5kf79SXMPT6KHcYJ8clmurosbb8to3gG2uUOZDzcMNd1NrTGGi9+R3CwDcf/z9Tp5CQ42lZOo0G7ou9PTZ1nhWJ9pXwVcR5pHrylWVqnQUHMZSKYZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789304272; c=relaxed/relaxed;
	bh=ZaG9JvtDZPtzu7/Su7H2CZKbMYzj3xJ6fua1r0x0Bsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i5cdnRV9DAk4T+V8Fqf8Imd1WsioYa2+SKJzFDT6naNdJ4n44iBuLdvlmm7QZuyaGBA6RpahbgrKClMiflHShwdNcdbvuF2Ly8kNZbs1tkpyBosffwmtrducdf2oT7aTV+Z7Ta56bmA/2HqEMaXqdN9FFqMI+5qVifpwHniTUXRbwNxMwFk7aJxgwcSSAHRamAq3lnsVB5McE/vFuDfxQ+87zbeewU9z1FYpkfg8ID/IOoargK/lrigw1dx6StQoZFl3k4Mhslnfh5B1mSp+5/gZHd0NmftIT6S1xqJejJpT8oTjt9SxgMn5mW34XgofFgzN0iSDVD8iDr4Fo4lnNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=IJGU6Iv2; dkim-atps=neutral; spf=pass (client-ip=101.71.155.101; helo=mail-m155101.qiye.163.com; envelope-from=bolin.liu@seu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=seu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=IJGU6Iv2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=seu.edu.cn (client-ip=101.71.155.101; helo=mail-m155101.qiye.163.com; envelope-from=bolin.liu@seu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 323 seconds by postgrey-1.37 at boromir; Sun, 13 Sep 2026 22:57:42 AEST
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjSxL3MdJz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 22:57:41 +1000 (AEST)
Received: from seu.edu.cn (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d907a3e3;
	Sun, 13 Sep 2026 20:51:49 +0800 (GMT+08:00)
From: Slavin Liu <bolin.liu@seu.edu.cn>
To: shengjiu.wang@gmail.com,
	xiubo.lee@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: festevam@gmail.com,
	nicoleotsuka@gmail.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	bolin.liu@seu.edu.cn
Subject: [PATCH] ASoC: fsl_asrc: check the second front-end DMA channel
Date: Sun, 13 Sep 2026 20:51:47 +0800
Message-Id: <20260913125147.109920-1-bolin.liu@seu.edu.cn>
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
X-HM-Tid: 0aa09ad2eb5603a1kunmc05ba738251195
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ05IVh1JHh9LQkpNT0pMSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=IJGU6Iv2fDiCoypE3ydVz26ysPVKCITlLQ2LgIxat9Vi3XD5bRfrMbQBxGBxMgLU0pxntXotkixwohL6gm1iz32g0XnjGsOFcPvSCtU5pgMcmF2oTNF2GKkz7fG32YrmqtHaf3m4evE1fRHifuK22+DtnRrXulHAiGdTVIrgt+o=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=ZaG9JvtDZPtzu7/Su7H2CZKbMYzj3xJ6fua1r0x0Bsk=;
	h=date:mime-version:subject:message-id:from;

The temporary Front-End DMA request can fail independently of the
persistent channel acquired earlier in fsl_asrc_dma_hw_params(). The
returned NULL pointer is immediately used to read its private data.

Check the temporary channel and release the previously acquired
persistent Front-End channel on failure. Clear its slot so a later
hw_free cannot release it twice. ASoC marks a component's hw_params
only after success and skips unmarked components during rollback, so
returning an error alone would leak the earlier channel.

Detected by static analysis and reviewed with AI-assisted source auditing.

Fixes: 3117bb3109dc ("ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and platform drivers")
Assisted-by: LLM
Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
---
 sound/soc/fsl/fsl_asrc_dma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 2f662bdf14d0..64f2b0612274 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -248,6 +248,11 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 
 		/* Get DMA request of Front-End */
 		tmp_chan = asrc->get_dma_channel(pair, dir);
+		if (!tmp_chan) {
+			dma_release_channel(pair->dma_chan[!dir]);
+			pair->dma_chan[!dir] = NULL;
+			return -EINVAL;
+		}
 		tmp_data = tmp_chan->private;
 		pair->dma_data.dma_request2 = tmp_data->dma_request;
 		pair->dma_data.peripheral_type = tmp_data->peripheral_type;

