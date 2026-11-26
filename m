Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103E606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=P+O7Mgq3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jb7Vt5yX6z2y2h;
	Fri, 27 Nov 2026 07:31:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795725094;
	cv=none; b=nVKYBggJsRN8MT3g8YxvqB+zXefCNmZoqljRedkMpDYYfi0noMppBGqq2xrBaAukUsiIO9i7elcJTjtk0osNjo9DMs+i01YyuT24Pi7dzPQn8AQNSErzi9uY46dy9q94oZqB4y0hyoZd4PL1dazqlLtY36kXtnWOQV/Ljbyfp5JUmH2wJs2XfgeqTghAGVse5h6nBBAulswRcX4CJZi8czzEyE1d8jdFxk1qPw029H3vegf/4Zu6V3IYyuFv6jGyfbqnQf5BqoWCqh6pz/fNSv5u9wUys8ljDFhsvcyMiF0z7gm2YtN5c0kMxeuyCweWWFQ8+lM6m+9ZMAM9HFUv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795725094; c=relaxed/relaxed;
	bh=lL4D7R9KxDf+22sv9+j/sxEZCecScCAzSX1cEImABW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ki5egU8y1PEXbSzXM+nBkdbnnZI45M3BXS+JLFVxviogfbm2CdDNHNjRRYgQ246T/xauQwd3kQndLBaS4uBfX9RJ3zor0fpyO6NtM8s6pF/R7fLHg3PaYygQxIwSPfjz6FQRTMxIW9uchFLM/2NFpzw0Aej2Ujyz1Iaz9RqHJlRTeaZi/m1gLd4wrh9U2aciA/1BorFfNOj8op397wDxOD3Fo62zlLBkwBMM1HgygEJoZLw+8yTZ27JMiifP35wHsNWz5kZcuM4HZ/eWbLSF+MtNAGHgJom5nxjgAs15Gflo6qYBFSx+tW+qDhVpJYUa5yO9FOlfpt++vvdhgOIJbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=P+O7Mgq3; dkim-atps=neutral; spf=pass (client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org; envelope-from=manuelebnerli@mailbox.org; receiver=lists.ozlabs.org) smtp.mailfrom=mailbox.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=P+O7Mgq3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mailbox.org (client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org; envelope-from=manuelebnerli@mailbox.org; receiver=lists.ozlabs.org)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jb7Vq5c5bz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 07:31:30 +1100 (AEDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jb7Vb3zTGzMljx;
	Thu, 26 Nov 2026 21:31:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795725079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lL4D7R9KxDf+22sv9+j/sxEZCecScCAzSX1cEImABW8=;
	b=P+O7Mgq3XY/A52unPjO6kVgrXbL5V40AafZ2SGmfMKZYd1rMJVlmCMQTSLkgNHyeCWOkXG
	XJApf6uNOFSilZ6nuModLLKdjAFH1O8jQsb4rKmh9z/TWiywJTsk4oR+DtktjxD42HRXOd
	AZ8KVP0/dcn9VlIJqrb1yj20euv3vei3min2AutQnT4LnPZNXFY7aGpLUPMbw4Y9DGbply
	oym3hlxcij2OSpsRzb6ygSDIPo7Om2f4dwPKmTamsLsaa8PZQRh94K0UUjyIhzH8Jy4Id2
	WhI+3pRxfanUEtD2qzR9s/LMVUS/C+JdjGfK5VwNMvyAXKWk87J8949LZ0folQ==
From: Manuel Ebner <manuelebnerli@mailbox.org>
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
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: imx-pcm-rpmsg: fix kernel-doc
Date: Thu, 26 Nov 2026 21:30:39 +0100
Message-ID: <20261126203039.1777085-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.56.0
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
X-MBO-RS-ID: d782bbe52c75f34ceeb
X-MBO-RS-META: ohjh36gga4w6sbm5enryspnsho44jfi9
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Correct typo in kernel-doc, fixing:
  $ ./scripts/kernel-doc --none sound/soc/fsl/imx-pcm-rpmsg.h
  Warning: sound/soc/fsl/imx-pcm-rpmsg.h:419 expecting prototype for struct param_s. Prototype was for struct param_r instead

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 sound/soc/fsl/imx-pcm-rpmsg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-pcm-rpmsg.h b/sound/soc/fsl/imx-pcm-rpmsg.h
index 8286b55f00..52f2529724 100644
--- a/sound/soc/fsl/imx-pcm-rpmsg.h
+++ b/sound/soc/fsl/imx-pcm-rpmsg.h
@@ -397,7 +397,7 @@ struct param_s {
 } __packed;
 
 /**
- * struct param_s: send rpmsg parameter
+ * struct param_r: send rpmsg parameter
  *
  * @audioindex: audio instance index
  * @resp: response value
-- 
2.56.0


