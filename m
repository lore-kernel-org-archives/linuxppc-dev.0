Return-Path: <linuxppc-dev+bounces-25896-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0F6C5DF66
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2026 00:45:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNYyY4g5Zz2xd5;
	Mon, 17 Aug 2026 10:45:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786927509;
	cv=none; b=CFqkSlttG4z4gFMqoHydcESQtUS6Bp+2XrQUsd70dxtqYGvdbzw+5RL27AicjQh4lC/os6+LmnFeYOd4JR4iCSjOQTzqzTrqQAiWKvU/M3jBKkXozCfTPR3xsup9yYyvvXEmdEuBnhQoiUZbS8HOMwf2RT+OWhTwprwuCDwGw4ch81Me54zqnXeDY6xdCmRQ0OJh0H10UboSy+7YgPigoBx4hz1a3ntu0HZEoSCs0kw91aPEHEbNChohhXv4gY/ulixDkDq3vyBQ7exAHXnSr49YIYILLhLfw5FvgL2f7RcV2URID5yRmzWbmXu3B+2zbnrbzlDVuq3rqs5Ze7WvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786927509; c=relaxed/relaxed;
	bh=virBiSedo0RsjgNtDHeYNu9b5zOw0VcBr57wB4SYviw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WmdIo9rGVNqocYxrGYo8kVPgRRgs2KMmfWjtIo1sIkiS5r/q+TTDbFqpCzBEsZ/pfvFQ4r+M/3gRTMEihSlXSlkukaFiinVNQW2AC3wdrdbv4n25KukzFwy5Dm1ET/zNVbNjQ9ZIs1sZcQn/TPY1ghX4gMMsgGr5Jxug5osWTHeJfWwp5FQTreAKqhzuSrUCeJhfj0S9DZ1SU2TBjpBvBydd3AwXZKq3QXEiHvOBrK0HSUVU59D6bICtOYDfPGgdHFtF8HQFZGEI1oqbgF+/BiHKT4aeqiBXMp9riN4htwmhZSRm+95fiCaL4vZcUtDIsYDTfoVPHn7YO5ldwQT4UA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q2DtD2Zu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q2DtD2Zu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNYyX0WbPz2xW5
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2026 10:45:07 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso1468685a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Aug 2026 17:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786927504; x=1787532304; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=virBiSedo0RsjgNtDHeYNu9b5zOw0VcBr57wB4SYviw=;
        b=q2DtD2ZuUDWia++X0szISK+m0K3xmZ1m64MnE/0V69GzoZluNSg9fptDQ2umirRK8V
         hHpHmgy0JtXQUFMsBo80yauLybodbK/Ulh5RAxiM3pX79z8Pp5G0V1oAKFDoX1575aF7
         YOYV6Lpj+O3iczqldHOIWfPBP3PIxlgZnEpW3b+Ifv9bmNNrgzKG7e8M3fIP1CORdHte
         k2cre/Yi5/DtbvT/bQPfuX9BZDxGvKxk6DTxkPbuvEpK32yIx35InJtSRMEmNZA029VR
         l4kU61Er29xHQcJ0lSbmIauLo2LqAbrdRc9ccH2v9yLy1U0/hrD7Lrda+blqjw20gNyX
         lRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786927504; x=1787532304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=virBiSedo0RsjgNtDHeYNu9b5zOw0VcBr57wB4SYviw=;
        b=DJG272HmNI14cZJBWMuKXegYIecytZ7l9u3AccoXgzj4fGw0n7aNFUEWDiNVi1exlf
         2mdWX/e8m25n7OreNxLbCa5evR6KJ9iZ4UYc6EK8jnwHTMIKXOoxMVNiutVNJNmOuiGc
         Pn6UKA3V9Jn9LsmqwyXXFUqCk44tA6Ujw40Tis8bVq5rqHFaKtXAN1mG7MslxuFJo5KT
         S3hjy+WtrzSJE+vGdmqZo6dSj12m3YXx3G3G8reo2DVw5NMxBmthzqcF+ujVLizUlbyp
         +gz/9ma7eEzS3PCfOtgJN6YGzaAWH2DGD1gPl5Jn65oZzks8Edl9OmIVPltz7cwL89zM
         EsTQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0x0vTXETehHPkNSJwcrq4lDpV6IUHXHcp8KDOe3yf+jTdPJs+pac/UYE3xm0DCgtdb/6ShOudm4CcR+w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyVyio4yoJEXd1nwQcV7rzrIEtFdgb5YN7Vwb3POCxbxnsXv85C
	pzngkXdJp9+k1CBjNVPJZFgFyoVE85u0lMM9eiirgutvlN4K3GkN0sES
X-Gm-Gg: AR+sD10ZyJwM1UanvfNLwvLNajvPyQ9k5ekPi7TFO7TYrNm7zIj2sLOZ3sReDvzjPZP
	tCI4rV3SPZHtUSZewcpyrBnOjJ0BSS7SNfY9DMonSp4N3+V+Z27YqW9CVIbbl9GvFBDd+lbIYbw
	mZg7KrFXDEozL6QLJBpxHUtuk3UK6q1lLSr6aW49nQQTvt6UAACNXaigCRYLjiOm145Q9JLNsut
	4arQQ7etmidIWAnmSg5PUHFE7qqXN2wxrznBjuOkvTXm3ZWxO9AoFWiqG7NHcUcA+ZTrMjgwL4d
	Ly7ZZUUocjBl0Ur9VjyMABKZqcMojpjWymHX+yhP/suJxPLmzwaVPJudvKL1D5sHWJx1ar+nCK0
	Kvkbd8ujTuWii45Nj1/rc5EG8dzsavSuci+1+ZfLpXo+j6Hf/3K3BxK3gHG5Bkrj+6mZqkbU7Lt
	xAwcI3R0lYvQLpvokxgYTQeHdkrt45oNjcEh5y4N5clYTs9BnAjp3x5nYMXQmQE9NAhamtruBk9
	pB+rLTSBYrl5VhrCYPmbHOhEXnW/tkuUWiIdn5FMJMCnWf4gPdyIpBvcOO12Hv5tBxlO7LzQ9PD
	e2XS/DH8vfORjKcXhRQuGZSmwLSpenGYhCOOXIbi3EOHXwmO
X-Received: by 2002:a05:6a00:179f:b0:842:2419:6bfe with SMTP id d2e1a72fcca58-84fde364c19mr20472853b3a.7.1786927504085;
        Sun, 16 Aug 2026 17:45:04 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d01c2e7sm2164077b3a.13.2026.08.16.17.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 17:45:02 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:FREESCALE SOC DRIVERS)
Subject: [PATCH] dmaengine: bestcomm: ioremap and get irq early
Date: Sun, 16 Aug 2026 17:45:00 -0700
Message-ID: <20260817004500.59251-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Doing so allows handling potential -EPROBE_DEFER before any work gets
done.

Replace the open-coded resource lookup, request_mem_region, ioremap and
the manual iounmap/release_mem_region cleanup in probe/remove with the
managed devm_platform_get_and_ioremap_resource() helper. This removes the
now-unused error-unmap/release paths and simplifies the driver.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>

dmaengine: bestcomm: get irq early

platform_get_irq can return -EPROBE_DEFER, which is useful to avoid
doing extra work in such a case

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/bestcomm/bestcomm.c            | 70 ++++++----------------
 include/linux/fsl/bestcomm/bestcomm_priv.h |  2 +-
 2 files changed, 18 insertions(+), 54 deletions(-)

diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bestcomm.c
index 432b43520ddc..55ad7bc34df7 100644
--- a/drivers/dma/bestcomm/bestcomm.c
+++ b/drivers/dma/bestcomm/bestcomm.c
@@ -48,6 +48,7 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
 {
 	int i, tasknum = -1;
 	struct bcom_task *tsk;
+	int irq;
 
 	/* Don't try to do anything if bestcomm init failed */
 	if (!bcom_eng)
@@ -68,6 +69,10 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
 	if (tasknum < 0)
 		return NULL;
 
+	irq = platform_get_irq(bcom_eng->pdev, tasknum);
+	if (irq < 0)
+		return irq;
+
 	/* Allocate our structure */
 	tsk = kzalloc(sizeof(struct bcom_task) + priv_size, GFP_KERNEL);
 	if (!tsk)
@@ -77,10 +82,7 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
 	if (priv_size)
 		tsk->priv = (void*)tsk + sizeof(struct bcom_task);
 
-	/* Get IRQ of that task */
-	tsk->irq = irq_of_parse_and_map(bcom_eng->ofnode, tsk->tasknum);
-	if (!tsk->irq)
-		goto error;
+	tsk->irq = irq;
 
 	/* Init the BDs, if needed */
 	if (bd_count) {
@@ -102,8 +104,6 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
 
 error:
 	if (tsk) {
-		if (tsk->irq)
-			irq_dispose_mapping(tsk->irq);
 		bcom_sram_free(tsk->bd);
 		kfree(tsk->cookie);
 		kfree(tsk);
@@ -126,7 +126,6 @@ bcom_task_free(struct bcom_task *tsk)
 	bcom_eng->tdt[tsk->tasknum].stop  = 0;
 
 	/* Free everything */
-	irq_dispose_mapping(tsk->irq);
 	bcom_sram_free(tsk->bd);
 	kfree(tsk->cookie);
 	kfree(tsk);
@@ -365,23 +364,24 @@ bcom_engine_cleanup(void)
 static int mpc52xx_bcom_probe(struct platform_device *op)
 {
 	struct device_node *ofn_sram;
-	struct resource res_bcom;
+	struct resource *res_bcom;
+	void __iomem *regs;
 
 	int rv;
 
 	/* Inform user we're ok so far */
 	printk(KERN_INFO "DMA: MPC52xx BestComm driver\n");
 
-	/* Get the bestcomm node */
-	of_node_get(op->dev.of_node);
+	regs = devm_platform_get_and_ioremap_resource(op, 0, &res_bcom);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	/* Prepare SRAM */
 	ofn_sram = of_find_matching_node(NULL, mpc52xx_sram_ids);
 	if (!ofn_sram) {
 		printk(KERN_ERR DRIVER_NAME ": "
 			"No SRAM found in device tree\n");
-		rv = -ENODEV;
-		goto error_ofput;
+		return -ENODEV;
 	}
 	rv = bcom_sram_init(ofn_sram, DRIVER_NAME);
 	of_node_put(ofn_sram);
@@ -389,7 +389,7 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
 	if (rv) {
 		printk(KERN_ERR DRIVER_NAME ": "
 			"Error in SRAM init\n");
-		goto error_ofput;
+		return rv;
 	}
 
 	/* Get a clean struct */
@@ -400,37 +400,14 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
 	}
 
 	/* Save the node */
-	bcom_eng->ofnode = op->dev.of_node;
-
-	/* Get, reserve & map io */
-	if (of_address_to_resource(op->dev.of_node, 0, &res_bcom)) {
-		printk(KERN_ERR DRIVER_NAME ": "
-			"Can't get resource\n");
-		rv = -EINVAL;
-		goto error_sramclean;
-	}
-
-	if (!request_mem_region(res_bcom.start, resource_size(&res_bcom),
-				DRIVER_NAME)) {
-		printk(KERN_ERR DRIVER_NAME ": "
-			"Can't request registers region\n");
-		rv = -EBUSY;
-		goto error_sramclean;
-	}
-
-	bcom_eng->regs_base = res_bcom.start;
-	bcom_eng->regs = ioremap(res_bcom.start, sizeof(struct mpc52xx_sdma));
-	if (!bcom_eng->regs) {
-		printk(KERN_ERR DRIVER_NAME ": "
-			"Can't map registers\n");
-		rv = -ENOMEM;
-		goto error_release;
-	}
+	bcom_eng->pdev = op;
+	bcom_eng->regs = regs;
+	bcom_eng->regs_base = res_bcom->start;
 
 	/* Now, do the real init */
 	rv = bcom_engine_init();
 	if (rv)
-		goto error_unmap;
+		goto error_sramclean;
 
 	/* Done ! */
 	printk(KERN_INFO "DMA: MPC52xx BestComm engine @%08lx ok !\n",
@@ -439,15 +416,9 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
 	return 0;
 
 	/* Error path */
-error_unmap:
-	iounmap(bcom_eng->regs);
-error_release:
-	release_mem_region(res_bcom.start, sizeof(struct mpc52xx_sdma));
 error_sramclean:
 	kfree(bcom_eng);
 	bcom_sram_cleanup();
-error_ofput:
-	of_node_put(op->dev.of_node);
 
 	printk(KERN_ERR "DMA: MPC52xx BestComm init failed !\n");
 
@@ -463,13 +434,6 @@ static void mpc52xx_bcom_remove(struct platform_device *op)
 	/* Cleanup SRAM */
 	bcom_sram_cleanup();
 
-	/* Release regs */
-	iounmap(bcom_eng->regs);
-	release_mem_region(bcom_eng->regs_base, sizeof(struct mpc52xx_sdma));
-
-	/* Release the node */
-	of_node_put(bcom_eng->ofnode);
-
 	/* Release memory */
 	kfree(bcom_eng);
 	bcom_eng = NULL;
diff --git a/include/linux/fsl/bestcomm/bestcomm_priv.h b/include/linux/fsl/bestcomm/bestcomm_priv.h
index 3b52f3ffbdf8..cddde7c74cb5 100644
--- a/include/linux/fsl/bestcomm/bestcomm_priv.h
+++ b/include/linux/fsl/bestcomm/bestcomm_priv.h
@@ -66,7 +66,7 @@ struct bcom_tdt {
  * This holds all info needed globaly to handle the engine
  */
 struct bcom_engine {
-	struct device_node		*ofnode;
+	struct platform_device		*pdev;
 	struct mpc52xx_sdma __iomem     *regs;
 	phys_addr_t                      regs_base;
 
-- 
2.55.0


