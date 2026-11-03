Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284636077D98
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 10:42:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJlWt5pPHz2xMQ;
	Tue, 03 Nov 2026 21:42:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793702554;
	cv=none; b=DowIVSxpDfnJzLcHxWIuZTkNg3XzsJxDkKSZpOujLj+sjINagSD5vWfUpZcX1dR5Akj+I0c9c4ThtdFvObsTxrW5eABmEm9lTL77EEM02jgj1QLfAqRM/U7EGempXBShu2P+lqIQ6flI5pmFfID+QWoodF2TSdXsrVMjv/Rhepyb/O0rRYWdCApQTcMGm6dgRmvUc/Ie1HoB/mKINWUiSI3bsniWAWkERl/ET5Mr7mRyYVPxso6Yz9Yz4jGoJi6dBrIqJyPSt7EhWShjnWpXl5zFVhLq1p8ZBO4uohazHtV473w61z1JfEwYBqfLfeKeIpnGnz/xbqxGe6vmLWFv9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793702554; c=relaxed/relaxed;
	bh=tV6ejL3rU0JA4o/fxXSrCXYJNzFJ4reb1/Lg1zThkwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oOt0Nsas0YvXXr+14igAeIm3FOkRPIsAFgOSu9x0FTq3SizsIMsdgPoSAHtAtQcvv8r0+FvIzlVWr2LO5RVQ1urvtAEu+ZmybW0KWL30IBcP5AYnVlN4kJxNBtoUAlFv4A0G3qVV1rJlMfWrqkrOHfjx25AMb8EFKG8jNNGPDU1WvWYYoWIRtQFouCsrqjAfis5Mm7HGIiHP7hT6OCh4DbBobNcqONVHGmb+xI86WhJCCKuF4JlvEgbV6IAP5GfH8qsnYE2seMC/jV7TA4HMS9wdOQUSYIXtas12FEKlXRFOG4TX2Zpt3bEoTitqQAK2BWfbmmC6uIIkOlcMN+2U9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.81; helo=cstnet.cn; envelope-from=vulab@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJlWs4FPGz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 21:42:32 +1100 (AEDT)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADH0JGUuulqhcg7AA--.6656S2;
	Tue, 03 Nov 2026 18:42:28 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Zhao Qiang <qiang.zhao@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: wan: fsl_ucc_hdlc: release the net device on remove
Date: Tue,  3 Nov 2026 10:42:37 +0000
Message-Id: <20261103104237.1373675-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowADH0JGUuulqhcg7AA--.6656S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1rZF48CF4UJr1fKw45Wrg_yoW8Wr1rp3
	y5Ga40kF95Kr17ta1kGr1UuFyUWa18ta4Fka45Zr4furn8AFyUZ3yjgFy8CFW5AFW0gF4Y
	qr97Ka1xWFs8ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBEb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Cr1j6r
	xdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2
	zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43Mx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_
	Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07bOAw3UUUUU
	=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwAAA2rpnO54wAABsM
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ucc_hdlc_probe() allocates the net device with alloc_hdlcdev() and
registers it with register_hdlc_device(), but ucc_hdlc_remove() only
tears down the QE resources and frees the private data.  The net device
is never unregistered or freed, so after the platform device is removed
or the module is unloaded it stays registered, keeps its reference to
the module and is left pointing at the freed private data.

Unregister and free the net device in ucc_hdlc_remove(), before the
private data is released, as fsl_qmc_hdlc does.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 809f21fb93f5..f815cac82518 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1255,6 +1255,7 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 {
 	struct ucc_hdlc_private *priv = dev_get_drvdata(&pdev->dev);
 
+	unregister_hdlc_device(priv->ndev);
 	uhdlc_memclean(priv);
 
 	if (priv->utdm && priv->utdm->si_regs) {
@@ -1266,6 +1267,7 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 		iounmap(priv->utdm->siram);
 		priv->utdm->siram = NULL;
 	}
+	free_netdev(priv->ndev);
 	kfree(priv);
 
 	dev_info(&pdev->dev, "UCC based hdlc module removed\n");
-- 
2.34.1


