Return-Path: <linuxppc-dev+bounces-27957-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2789C982EA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 05:40:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqQmL1BNyz2xs1;
	Wed, 23 Sep 2026 15:40:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:34::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790142034;
	cv=none; b=GUoEv+t8xzqPtoU7ZR1olCcQmPqUklOJs8vTHdRNko7YT9XUdRAh/5sRDEC512jC+C6dOL17h/TdyQll5qvXQCeyKAfG1NXJYAcxiw5SPfbQ0Qt9hUoda8kljtm9PB1Duh0qFb3IfMPS1M2hP2X4bTECK0GgdhXyA+hpSfPPUfDTbEVYrJ4DT24+4WCH3SG22rjhwhyB5zd8EbNs52PR44NxwJ7J7tQ0IlK2/zsw/4XmNc8TQ7vsmlfbmlACAr6JGynfnbMt1SoKQD36SRHtBTcnm8SIUcHX29yWzJHJN17+RZXPdjT7SlbZ60nze0giwlbpTyfb0lWfntaHbGwT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790142034; c=relaxed/relaxed;
	bh=4t2QKwvgTvrUqgLrxmE0i6NBCj41D7R9VJyZdg6puRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSA7sgrEs1a0DdaLI82Ti0Rm87dLaYmDd5MZbc4JjrKaL2YHOGqRpIUXSd3+9Yqr+2VHc/dfUYKAC/Hl5DA6fLjynfYhh/ael70q+MXHdieswWm8+SKGt32Ibb81F2GIk4q/39rYB2TqH36w75kOTxjHkGSstq84+ulkgkyilott0zBgAKLuuVKaEY/j9MdHj0bOoiFheCp/rmpzr/b+ZYVrlPzzgBR/egZTyJFYcesG5aJSo7rFnAQlNkxqIAxMBl/q4jZ0T7GgOnVI6fh1N8h7wmck7u32qfsuxfsTlG0hc0DyoC2N50EwJjJoOzBgw+xYDIM1g0BIGrBsJK3Y9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j/xB8xxd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:34::f; helo=mail-qk2-x0f.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j/xB8xxd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:34::f; helo=mail-qk2-x0f.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk2-x0f.google.com (mail-qk2-x0f.google.com [IPv6:2607:f8b0:4864:34::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqQmJ2Bstz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 15:40:31 +1000 (AEST)
Received: by mail-qk2-x0f.google.com with SMTP id af79cd13be357-93910a0cb7cso50314685a.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 22:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790142023; x=1790746823; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4t2QKwvgTvrUqgLrxmE0i6NBCj41D7R9VJyZdg6puRQ=;
        b=j/xB8xxdOqU+WjJgW44qzS8LjJFlSYGPmG5Jzn43F3tLHHfB0q/2JGKpyTiuevC3cq
         lv3rIUuV35UJSIJqSq4xXgogERlTB5eJpgcMWw3LPdk8slD0LlaZEIe/ICP/LisJLKli
         ZddpRAAyu+kY1/t7SdUj2wHbIX2zkKt8z3xaf3Bjtdlp/tjNq96a33slpWMTYi/v8CQk
         w2XfLW/eLGE6bTY0V+By1hF1LOoCvbHX2reziZxfjOFUCwMZpJywqXghjDPoLGnyjac3
         GAqAZSVN6ZzRI5gZ3vFoK3yKVc1XRrvhs7aDQCNxCOwTAZ2t5OGLXUnE7UDfy04zFid0
         Aymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790142023; x=1790746823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4t2QKwvgTvrUqgLrxmE0i6NBCj41D7R9VJyZdg6puRQ=;
        b=wiIyqdbbsIYH375cPZK/nWVRNjV6Y+7rkJBT0pXBVybQ4HsfaWdX8AZ5gc76ZDSpgJ
         QVZhfieyrk74LeMhDUW8ucEy6AzWgjIuAeP0EfVcMmnHlMP3UsqUxg3VTf8ewKS8xyp4
         xPtjsHILRypyp+tLmjEHBlYhmtKLbYWca5fGceo25npAyZ2wkXKluLQ0hYgll5WhSRmb
         NNp7MjP4Fe0Qxkm0z8toTunwdb08RtTMQHOYsdgmw57LqQhBhQp18MvUY7zo/tiEIniI
         ErGTd71dVkT/bRakQbQy8OgCXgcDPLW8BXaD4QkEd7M4hPzmiOpyDgKrja584OaIrq6z
         7aEA==
X-Forwarded-Encrypted: i=1; AKwUvBw3IRHt/TS+my5YNiUJUplCEHOQBDaa1h1UVEE6OaqpknK1IfGaEi45sHXnJghazNui7/hiflqH+7Euato=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ms1lkAZe6TtT3lWvefJvyrrLhi+Mjwi1s9JCI1lD6aofC20rfT
	pb1F+C1rl51EypZXZESF4bjUT+TYpeLgQxGu1c1q8UnHjV84yQNQBDk=
X-Gm-Gg: AYBFou3Hr7v5IYC4Rsudns8i0S6n4VLj5I+OyJnOXBFXO6LZnUxw+lqm9EazJC+TSlG
	F+ZWRBMZ4zisQkBYvXCEu8LSMCzeuWN4KCz3m8mnC1+kDc1jbAtSCa/36M13lejp4BBDQGN1rrP
	XayVA8ivqg2TVRDkn9SqsDRf9OvIDtm3SjrsI6q5ZG/4KXq0psI47+dlJMsrS/mzFBxaXwZupBC
	7mi3ZiBue/JM4DsiBhDVk9c4dbhlccUo0Kaj/sQNxRNSl4zhKxYp9V9MToRSmWxMGL52ofuWeuC
	rcP/Tz13fIUJqy8jA7K/hyZ/SpxeIrisvhwRBPElOmB04WfXUg8x+T54GW+I19ZdzhuSp64yCY5
	SOzMBJAwA5B/knJvStiBB7q7EXuEDvYtzL2vXgrTudbor6PsSQyElxtaQ92ixtxNbxZbmQlu8hL
	BHQPb8hVqAVg+KIF3jBCm91nZfaotdr2NKd8F0nZWJQtB6CY0hBDHLWHnADA80r/MN37i99x87Q
	HvBGP3ZLOLye3fMsz1+GVckTXh0hBiQZS3PmG3hwkGY/FVPHpWF+n4lgCitSaN+7c4aWNBkFXAM
	OhZOOMaK8mwTrnDWWt9gOmaNHj8nnmyDkCHlpo99txibGoCd5aXB+FNkaGr1LTZCpESKrCZXP9r
	nzw==
X-Received: by 2002:a05:620a:6409:b0:939:1483:55c with SMTP id af79cd13be357-93c25118d3fmr276086185a.19.1790142023287;
        Tue, 22 Sep 2026 22:40:23 -0700 (PDT)
Received: from localhost.localdomain (h16.44.55.139.dynamic.ip.windstream.net. [139.55.44.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c277636e4sm88496685a.41.2026.09.22.22.40.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 22:40:20 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] ASoC: fsl_xcvr: free IRQ before canceling reset work
Date: Wed, 23 Sep 2026 01:40:17 -0400
Message-ID: <20260923054017.93553-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

irq0_isr() schedules work_rst on a preamble error, and reset_rx_work()
touches regmap.  remove() cancels that work while the IRQ is still
registered, so the handler can queue it again during teardown.  The IRQ
is also requested before INIT_WORK() and spin_lock_init().  Probe
failure does not call remove(), so freeing the IRQ leaves queued work
running, and an earlier interrupt schedules uninitialized work.

Initialize the lock and devm_work_autocancel() before the IRQ.  Failed
probe then frees the IRQ and cancels the work.  Unbind frees the IRQ
before cancel_work_sync() and pm_runtime_disable().

Fixes: 1e5d0f106164 ("ASoC: fsl_xcvr: reset RX dpath after wrong preamble")
Cc: stable@vger.kernel.org # 6.13+
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 sound/soc/fsl/fsl_xcvr.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 9828272..29929df 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -3,6 +3,7 @@
 
 #include <linux/bitrev.h>
 #include <linux/clk.h>
+#include <linux/devm-helpers.h>
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -57,6 +58,7 @@ struct fsl_xcvr {
 	struct snd_aes_iec958 tx_iec958;
 	u8 cap_ds[FSL_XCVR_CAPDS_SIZE];
 	struct work_struct work_rst;
+	int irq;
 	spinlock_t lock; /* Protect hw_reset and trigger */
 	struct snd_pcm_hw_constraint_list spdif_constr_rates;
 	u32 spdif_constr_rates_list[SPDIF_NUM_RATES];
@@ -1617,7 +1619,7 @@ static int fsl_xcvr_probe(struct platform_device *pdev)
 	struct fsl_xcvr *xcvr;
 	struct resource *rx_res, *tx_res;
 	void __iomem *regs;
-	int ret, irq;
+	int ret;
 
 	xcvr = devm_kzalloc(dev, sizeof(*xcvr), GFP_KERNEL);
 	if (!xcvr)
@@ -1705,12 +1707,22 @@ static int fsl_xcvr_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(xcvr->reset),
 				     "failed to get XCVR reset control\n");
 
+	/*
+	 * irq0_isr() schedules work_rst. Prepare the work and its lock
+	 * before the IRQ, and register the cancel action first so a failed
+	 * probe frees the IRQ and then cancels any queued work.
+	 */
+	spin_lock_init(&xcvr->lock);
+	ret = devm_work_autocancel(dev, &xcvr->work_rst, reset_rx_work);
+	if (ret)
+		return ret;
+
 	/* get IRQs */
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	xcvr->irq = platform_get_irq(pdev, 0);
+	if (xcvr->irq < 0)
+		return xcvr->irq;
 
-	ret = devm_request_irq(dev, irq, irq0_isr, 0, pdev->name, xcvr);
+	ret = devm_request_irq(dev, xcvr->irq, irq0_isr, 0, pdev->name, xcvr);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to claim IRQ0\n");
 
@@ -1751,8 +1763,6 @@ static int fsl_xcvr_probe(struct platform_device *pdev)
 			fsl_xcvr_comp.name);
 	}
 
-	INIT_WORK(&xcvr->work_rst, reset_rx_work);
-	spin_lock_init(&xcvr->lock);
 	return ret;
 }
 
@@ -1760,6 +1770,8 @@ static void fsl_xcvr_remove(struct platform_device *pdev)
 {
 	struct fsl_xcvr *xcvr = dev_get_drvdata(&pdev->dev);
 
+	/* Free the IRQ first so irq0_isr() cannot requeue work_rst. */
+	devm_free_irq(&pdev->dev, xcvr->irq, xcvr);
 	cancel_work_sync(&xcvr->work_rst);
 	pm_runtime_disable(&pdev->dev);
 }

