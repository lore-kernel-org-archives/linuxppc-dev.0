Return-Path: <SRS0=NHc8=OL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B97BC433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Sep 2021 21:46:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67C060EFF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Sep 2021 21:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B67C060EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HDZkv3Htyz3f4r
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Sep 2021 07:46:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uOY15jDs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=uOY15jDs; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HDZX86xTrz3cGB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Sep 2021 07:37:28 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E151B61166;
 Tue, 21 Sep 2021 21:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632260247;
 bh=9kvioNqkIrsS8HBoj2GlyRdysXDxOgoRAuVJFCeoBUo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uOY15jDsrgthTaNir73Y6vzD7xl5fLU/cBHRothrPthVo3kcEbaanEOiu6zwK244p
 rCWXJ1ftWbyr5GvAVD95SAU5PXTbq7Hhxdygdifb2QiB7vkDZxzgddgpIrwQBvc8Su
 nrV2Hu8gqsXeugV4tzSLF3q8FC0eQoAEmaPbnUdKPxu2KuWom7Y0JJNNZcRDYoh3yj
 FP25k87HopjiKwPng96EJ+uKGN5AM2k+3FY1FTfCjCuZgszKniX2s2wIbiQOJ0bTXR
 qdPzXv7Pp23ji7jxuximnnaHpX+Fu+iwsOKVfVV7lyJk9Qc7cc9xht/xkgu/ZVFH5D
 j/1qsW/itMKcw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: [PATCH v2 16/16] ASoC: pl1022_rdk: Update to modern clocking
 terminology
Date: Tue, 21 Sep 2021 22:35:42 +0100
Message-Id: <20210921213542.31688-16-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210921213542.31688-1-broonie@kernel.org>
References: <20210921213542.31688-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=845; h=from:subject;
 bh=9kvioNqkIrsS8HBoj2GlyRdysXDxOgoRAuVJFCeoBUo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhSk8fnpCj8O6TDJnvU0wky8JPu5tjCBxYgZJvjL8x
 177U4GmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUpPHwAKCRAk1otyXVSH0FjVB/
 9Ywe58qXb8OE32uPIidA9JwEujm0oJhFQw8tiqvIafVUeAUJVYJIOl2/Gcu2NqU9DugY+iJuaSKWVk
 BwklppUTbyRSf0VWRLCbEM+znePYUfRzT4EOF66eqeivR5RIe31b38dmr/f6b/ESC8RC4hjbxrEbES
 OpoNPlQAZKwAEQAnUJ5jtqfxiWjwYhxZBh4/o3WK2pdpopx8OP3MlQhs8fFZ6mTDV9Dw0qZfUOCPV1
 pUglQ26p59M4zAaZPbiXCI8yS2ylnquFuAY6blUNIepvtEbJrPMFUoxaXHM53tFrBr/G9djypjbqQW
 0sFuSVgMgD7scU1ffSbRI/p1Lz/SF+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

As part of moving to remove the old style defines for the bus clocks update
the pl1022_rdk driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/p1022_rdk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/p1022_rdk.c b/sound/soc/fsl/p1022_rdk.c
index 714515b8081f..b395adabe823 100644
--- a/sound/soc/fsl/p1022_rdk.c
+++ b/sound/soc/fsl/p1022_rdk.c
@@ -265,7 +265,7 @@ static int p1022_rdk_probe(struct platform_device *pdev)
 	 * only one way to configure the SSI.
 	 */
 	mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
-		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM;
+		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBP_CFP;
 	mdata->codec_clk_direction = SND_SOC_CLOCK_OUT;
 	mdata->cpu_clk_direction = SND_SOC_CLOCK_IN;
 
-- 
2.20.1

