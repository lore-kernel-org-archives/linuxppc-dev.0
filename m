Return-Path: <linuxppc-dev+bounces-16717-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD190EF06FC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Feb 2026 02:00:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8SZ74v0mz2yFm;
	Mon, 09 Feb 2026 12:59:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770602399;
	cv=none; b=V/oIznaAlGqv+kTwSS1CM+AEMeUSPrro84spThGwkCYVMaAdOLmWns3pTt6CCSRq71OUs/vbUMZ1nOGYeu44Xyi/x/qrJasRBuKB2qUAxoME2YpmCY1P+VSSfHg0kyJCS3FchyFe4om4SNj1DWr1UQM+aziX0PBgqmUo6fCRsPgkN0Q1vlXsfS9pEzwxSHtWSgktQgU/au2+rU3T+B2KImzPPtlaeY2Gc5A4v9n3Kl0ufkk+OtzSCqGd3np0URqOla0TdkfACqTq0u3TEZKU7aCogAq9Kwxd+FAZdQkbINkVXT216mJgqg32OutIxrpp/SjLo5FG8mZ6Ykigdezm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770602399; c=relaxed/relaxed;
	bh=++iN1TV5Opch23pgRphWkKkE4kuONCUY4uzUgTOLNLM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EJ45Zuipej/N9uSYvKD2K1VaeTFUk3BGp6sQIbVdo+5lmsYutZj6k65N66NbQJDizLrHmJKt+zlimaFb5HgvmH04lEWmLWqU37PzJegoUJbWawFI2Ws3qpztYsMPSXDH6OBQ9TBgzt6a1DcFidmDpREK4g0c9JOCZrkHehAw+lFy2OA5rR0e8t0CFoIKnJw/W/WbpXrVwkSRRmJh+qi2msDo/VOvip4dTaK0NjL7SU8DobG2/785/zLWkDz57wB+8Jc5PYXfXoB2QisSIhHhf9RAWQFpN5qfoVjcNhZsh7GOo1naLOCsRqT4FevLfyJq+VlMAVjQ7nMlothNOeZXzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=nichen@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=nichen@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8SZ60zt4z2xLv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Feb 2026 12:59:52 +1100 (AEDT)
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADHVQmLP4lpCfXYBw--.38725S2;
	Mon, 09 Feb 2026 09:59:39 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: herve.codina@bootlin.com,
	qiang.zhao@nxp.com,
	chleroy@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] soc: fsl: cpm1: qmc: Fix error check for devm_ioremap_resource() in qmc_qe_init_resources()
Date: Mon,  9 Feb 2026 09:59:04 +0800
Message-Id: <20260209015904.871269-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:zQCowADHVQmLP4lpCfXYBw--.38725S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyUtw1DGw43uF4fZr1DKFg_yoWDArX_Gw
	4UtF13Xry8WFyayFW5Kw45Zry093ZFgw4xG3yrta4rA3yUJw4xA3y5Zr93Xa1rXa18AF9r
	KrWUAFWYvw13ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
	W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUbaLvtUUUUU==
X-Originating-IP: [124.16.138.129]
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Fix wrong variable used for error checking after devm_ioremap_resource()
call. The function checks qmc->scc_pram instead of qmc->dpram, which
could lead to incorrect error handling.

Fixes: eb680d563089 ("soc: fsl: cpm1: qmc: Add support for QUICC Engine (QE) implementation")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/soc/fsl/qe/qmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index c4587b32a59b..672adff8e35f 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -1790,8 +1790,8 @@ static int qmc_qe_init_resources(struct qmc *qmc, struct platform_device *pdev)
 		return -EINVAL;
 	qmc->dpram_offset = res->start - qe_muram_dma(qe_muram_addr(0));
 	qmc->dpram = devm_ioremap_resource(qmc->dev, res);
-	if (IS_ERR(qmc->scc_pram))
-		return PTR_ERR(qmc->scc_pram);
+	if (IS_ERR(qmc->dpram))
+		return PTR_ERR(qmc->dpram);
 
 	return 0;
 }
-- 
2.25.1


