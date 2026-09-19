Return-Path: <linuxppc-dev+bounces-27757-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B96C982D7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2026 00:19:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmqqz4QMyz3bnm;
	Sat, 19 Sep 2026 10:19:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789777183;
	cv=none; b=gYfpM09C9w7R+ufZPrbvHYSeu6mPgJRyAEo/E/oTCB0orOK60NGi9Lks/k5yIV7Bq98AGQ5HoXhb8EpsYQLQDtnpF9lu03T+lKycRcpIHnF8XzWW0wKqGdf4cxhD55EJXJglb4clNCBJLE1brCG8qXJNVxptnmC5nJLocHc8LFrUE3p+RCaZ7OIfTYvBribFIUH2iROVFLGMOWWFES+bIx3+gY8n8u04VzPc9Ffk3ooB0yOCg8fGEvHkiGr5r5cgcrcdn1t7UHSXZccnswxWZTgOIh+9mcPqgBjsY3QWbv0bhJWifr+GWJBkfiHY/F0cr77s+DQTyNd2ghkPcJ7+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789777183; c=relaxed/relaxed;
	bh=MHPfgHpVyaUa15qKDBAtKU0EMneYSzvSUcpDvb8HIw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nEK/eJzijrmN8+1yDoZ8bHu2a++lw8XOUhaL4ONErSnK5BqZTJ0GJeL5OvkCzwZbcBGmb7tsJrBqwT/DapjtHqHIlsPD8c0f/PPutBCfPDkH8d2oCWyz77EWygrm8REX81+dREWpUElHrbdCrWgqD8y3pWy6km/zDxHZzOzsxzoLDleIfZJzM4LIjttDv4AbLOK/r0l86YBVHzUZRnvB5C2Pcr9ClGvl9rWXEN+rdXSJBeZVRvAt7wL5N7EU6wwbA+TbqIzcK80wJZTWCsr4rbaFakSLXPYLqSdGN0iu33RY6djYh8omJY38+O2NmgRn+PUikEg1+5ux8j1JHVoDZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HJGEsR96; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::d; helo=mail-pz2-x0d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HJGEsR96;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::d; helo=mail-pz2-x0d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x0d.google.com (mail-pz2-x0d.google.com [IPv6:2607:f8b0:4864:3b::d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmqqx4bH2z2y2b
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 10:19:40 +1000 (AEST)
Received: by mail-pz2-x0d.google.com with SMTP id d2e1a72fcca58-85469d249c4so1238721b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 17:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789777173; x=1790381973; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MHPfgHpVyaUa15qKDBAtKU0EMneYSzvSUcpDvb8HIw0=;
        b=HJGEsR96+X28zULG2fFX6SMXPNvSse5DBfCh5XRjShkKoduHKgSRBcegpp6odGxAhn
         s6Fiie5a3UShiwESMLJk+l7fW5ybLMtlN5n7RvpbX97om/RL0OEru5RkKj68mv68mqpF
         rK9S5bE4jJ9Q3glpuvhvVt7eCz5HwYxLW/Jh0mtUAFRICF7Yrzz5qjih3VdLF23bhA6L
         hpGs76euX5qWlUxU6HpVqnuQenpMoTyAI0GyBeI5LgHvIz5hJPDUUL9JzebNuzrpC52a
         kmBVKPJk55ks8ZzdXbfXj4Q6DJ7w5U4SBznWGZh/c/kxdtSPlwl7ruy5U3wDqktKnP7a
         9j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789777173; x=1790381973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MHPfgHpVyaUa15qKDBAtKU0EMneYSzvSUcpDvb8HIw0=;
        b=0A/XPTNguwqh+lcGLDtVJNZCUwjIYKn3u5K7dv7jUyHTBfpMwIE8rHoJuZlVYJvmE3
         r73GHPdNaJDv9hrOrWAlvCToARrMGaCFvoVfN56O7b8e4LCccotUJjpgg1cfK9lsGCTr
         RaNHroYFfeGLi9EJc/c05r6gdekiIngNt0OQN7RaQAf/cXAMzCeL01olN1bc83OvPlpC
         zIpY3OhfvXRGE1li5/N0qBTLSAHj5PSRl8oJUU4V5T39vy9WD4g1GLfykjszIYjezBkx
         sOZRP/FM9J7nxmasGC9QHgwSfL5J7EOLwFXZ7nforZXilaRMGWHgM0qiA5mkA3n7oGYc
         j8aw==
X-Forwarded-Encrypted: i=1; AKwUvBycsbvkZ7iLa1f2BUsz+wJ9KVW4RLw2Dq6LLg1L1Z+wYt57yhnkS+WlDa1a68hKc0IKl/AeMIeYSJMES9M=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n/ICR3kdBDf0ruSgI2coWu9cFz9h2QDkKJrgYH5LdsNBaXxxHf
	ggCGyT6aMxShMEL/UNQF8VmKb5sXwjUK2mGsdBfuMCr8tXF42oEOxlpS
X-Gm-Gg: AYBFou0F8hR5zXUUrVtSWeTOSmNZykVaExwMi527PecIOd48koaT6Bb32mGBvw0YJ8k
	/84PxirMgGnPDUQbQc2g1q+LaYdZFPHorcvNvTKt03V8f7l0oj0iGkH+JgNP4vWicwmipx5sdKn
	cbh/3YCa57ulDpJhnEVXqlUj4kIJjTAqfyT91/jmstCMHMQp0oyPtIysUnruEv0Yr+UkV5MWNvA
	UeXjIQkQVDeOSrC9nlOb64AidwbY2UsQ4pxHSZKLHxEM/KsWgBdWKytO/sM2ToUziJXj50Yvzw6
	nnG/Jm0T9ikXSZvgAX6CAle2kBRzveRExOphy799xPT2m22Y3uUeeXeneaNWCRb4+VOnYBYWzow
	tsBgBH/LnJyIfMnFC2q7wXCNOI0YVUQfx5RBMOb73pWIJCHnlB1g9VrFHvBwYemdCjfMN4Soi4/
	3Tzw16u2xDIaCChNpJdnYs6WInKc6mZee4sOVPO7HA/F0+rJFcaQIdTdlYd0DppqwOTIdL9tsUl
	FqHJCOdcFgjEsXJD9ErHFffBRzkmrUY703Y/AFV3ehzKTG6hMarFOdjSRmVJpxI0MNKHqn9zEkG
	wLobmodJgR9E0zic+Fto1oMucQ1r6Yz4QI0oAmVT7I+CdP0wxjzAoeeMTps=
X-Received: by 2002:a05:6a00:148f:b0:870:c2db:da2c with SMTP id d2e1a72fcca58-874de2125femr7108980b3a.25.1789777173083;
        Fri, 18 Sep 2026 17:19:33 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a6bec90dsm391673b3a.8.2026.09.18.17.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 17:19:32 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:FREESCALE SOC DRIVERS)
Subject: [PATCHv4] dmaengine: bestcomm: use platform machinery to get irq
Date: Fri, 18 Sep 2026 17:19:31 -0700
Message-ID: <20260919001931.723402-1-rosenp@gmail.com>
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

platform_get_irq() avoids having to explicitly map and dispose of an irq
by having the platform_device machinery take care of it.

This requires replacing the device_node with a platform_device in the
bcom_eng struct so that platform_get_irq() can use it.

Conveniently, this also allows getting rid of of_node_get and
of_node_put as the platform_device machinery also handles that.

Adjust the goto labels in bcom_task_alloc to match what is being freed.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v4: drop whitespace change
 v3: drop stale description
 v2: resend
 drivers/dma/bestcomm/bestcomm.c            | 46 ++++++++--------------
 include/linux/fsl/bestcomm/bestcomm_priv.h |  2 +-
 2 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bestcomm.c
index 241a91936fe8..310792ccd748 100644
--- a/drivers/dma/bestcomm/bestcomm.c
+++ b/drivers/dma/bestcomm/bestcomm.c
@@ -47,6 +47,7 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
 {
 	int i, tasknum = -1;
 	struct bcom_task *tsk;
+	int irq;
 
 	/* Don't try to do anything if bestcomm init failed */
 	if (!bcom_eng)
@@ -67,30 +68,32 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
 	if (tasknum < 0)
 		return NULL;
 
+	irq = platform_get_irq(bcom_eng->pdev, tasknum);
+	if (irq < 0)
+		goto err1;
+
 	/* Allocate our structure */
 	tsk = kzalloc(sizeof(struct bcom_task) + priv_size, GFP_KERNEL);
 	if (!tsk)
-		goto error;
+		goto err1;
 
 	tsk->tasknum = tasknum;
 	if (priv_size)
 		tsk->priv = (void*)tsk + sizeof(struct bcom_task);
 
 	/* Get IRQ of that task */
-	tsk->irq = irq_of_parse_and_map(bcom_eng->ofnode, tsk->tasknum);
-	if (!tsk->irq)
-		goto error;
+	tsk->irq = irq;
 
 	/* Init the BDs, if needed */
 	if (bd_count) {
 		tsk->cookie = kmalloc_array(bd_count, sizeof(void *),
 					    GFP_KERNEL);
 		if (!tsk->cookie)
-			goto error;
+			goto err2;
 
 		tsk->bd = bcom_sram_alloc(bd_count * bd_size, 4, &tsk->bd_pa);
 		if (!tsk->bd)
-			goto error;
+			goto err3;
 		memset_io(tsk->bd, 0x00, bd_count * bd_size);
 
 		tsk->num_bd = bd_count;
@@ -99,15 +102,11 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
 
 	return tsk;
 
-error:
-	if (tsk) {
-		if (tsk->irq)
-			irq_dispose_mapping(tsk->irq);
-		bcom_sram_free(tsk->bd);
-		kfree(tsk->cookie);
-		kfree(tsk);
-	}
-
+err3:
+	kfree(tsk->cookie);
+err2:
+	kfree(tsk);
+err1:
 	bcom_eng->tdt[tasknum].stop = 0;
 
 	return NULL;
@@ -125,7 +124,6 @@ bcom_task_free(struct bcom_task *tsk)
 	bcom_eng->tdt[tsk->tasknum].stop  = 0;
 
 	/* Free everything */
-	irq_dispose_mapping(tsk->irq);
 	bcom_sram_free(tsk->bd);
 	kfree(tsk->cookie);
 	kfree(tsk);
@@ -377,16 +375,12 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	/* Get the bestcomm node */
-	of_node_get(op->dev.of_node);
-
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
@@ -394,7 +388,7 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
 	if (rv) {
 		printk(KERN_ERR DRIVER_NAME ": "
 			"Error in SRAM init\n");
-		goto error_ofput;
+		return rv;
 	}
 
 	/* Get a clean struct */
@@ -405,8 +399,7 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
 	}
 
 	/* Save the node */
-	bcom_eng->ofnode = op->dev.of_node;
-
+	bcom_eng->pdev = op;
 	bcom_eng->regs = regs;
 	bcom_eng->regs_base = res_bcom->start;
 
@@ -426,8 +419,6 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
 	kfree(bcom_eng);
 	bcom_eng = NULL;
 	bcom_sram_cleanup();
-error_ofput:
-	of_node_put(op->dev.of_node);
 
 	printk(KERN_ERR "DMA: MPC52xx BestComm init failed !\n");
 
@@ -443,9 +434,6 @@ static void mpc52xx_bcom_remove(struct platform_device *op)
 	/* Cleanup SRAM */
 	bcom_sram_cleanup();
 
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


