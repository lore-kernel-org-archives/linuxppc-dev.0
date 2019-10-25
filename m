Return-Path: <SRS0=byMz=YS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DEDCA9EA0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 05:15:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F0820867
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 05:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MUki5QF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F0820867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46zslH3L82zDqYL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 16:15:55 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46zsj70KSzzDqYC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2019 16:14:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="MUki5QF2"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 46zsj63qW3z9sPf; Fri, 25 Oct 2019 16:14:02 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 46zsj62wkXz9sPh; Fri, 25 Oct 2019 16:14:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1571980442;
 bh=XUnk/aDzI0RoSsU6UPnlmFhYiY8BJtc3RoeNDTw86bM=;
 h=From:To:Cc:Subject:Date:From;
 b=MUki5QF2/NzyA9s6I4tsE0/RhIMRunvvcWUI/eur+Y3/IFtPPa5GAwPuoJQsX84HS
 mnIMlmHusHuUlAZMruibKVWTPQOQ+ej3SD/XamhJyeeWhKmSSM6Uj2JdFYm39w3olA
 xzqHC06myjj6dleKseudkjfXnyAYyneGY+QlR9yrvnQt31J4OKDyt0F620cncHR41v
 i2Y3cI3Ytx1xdjYQ4rDviFhu94UY5i0kwXliphOuklCXrKvmpIjNEoeXmbCjVtc1Em
 F7yArYWGpmOjSVnXff5xvKf/of+78I4EUxYdXTpFBgOSOIBK3CKrCkyO8Tdr+jLgGX
 Bykg0EcXt+WCA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: fsl: fsl_dma: fix build failure
Date: Fri, 25 Oct 2019 16:13:53 +1100
Message-Id: <20191025051353.2878-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: linuxppc-dev@ozlabs.org, broonie@kernel.org,
 kuninori.morimoto.gx@renesas.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit 4ac85de9977e ("ASoC: fsl: fsl_dma: remove snd_pcm_ops") removed
fsl_dma_ops but left a usage, leading to a build error for some
configs, eg. mpc85xx_defconfig:

  sound/soc/fsl/fsl_dma.c: In function ‘fsl_soc_dma_probe’:
  sound/soc/fsl/fsl_dma.c:905:18: error: ‘fsl_dma_ops’ undeclared (first use in this function)
    dma->dai.ops = &fsl_dma_ops;
                    ^~~~~~~~~~~

Remove the usage to fix the build.

Fixes: 4ac85de9977e ("ASoC: fsl: fsl_dma: remove snd_pcm_ops")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 sound/soc/fsl/fsl_dma.c | 1 -
 1 file changed, 1 deletion(-)

This breakage is only in linux-next.

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index a092726510d4..2868c4f97cb2 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -901,7 +901,6 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
 	}
 
 	dma->dai.name = DRV_NAME;
-	dma->dai.ops = &fsl_dma_ops;
 	dma->dai.open = fsl_dma_open;
 	dma->dai.close = fsl_dma_close;
 	dma->dai.ioctl = snd_soc_pcm_lib_ioctl;
-- 
2.21.0

