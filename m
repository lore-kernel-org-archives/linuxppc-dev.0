Return-Path: <linuxppc-dev+bounces-27442-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD36C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 18:12:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkqqw3g9Sz2y8F;
	Wed, 16 Sep 2026 04:12:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:33::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789495964;
	cv=none; b=GWcHaET4ET11zofWcDHDzcK6vdb8QG1U5gfjOaJ5UCkmxprHmqH2uQLU26jXmzfDqbENOsYkNfgmNhBbObpPaZd7A2Aidnlb9pJADu7tgCvVSUoNpSh1/UpGd/7lSyP4CN/uiIN5m6X3Vh4yz19a3I9eNfXP1/diD2uG1Qv3U3Ni+TMpQftSLZRN1U1rBsHRgrDuVUoD2vUO8JCZxWxyj1qGblC5Ea5WbDWiIzFuJ6fLxmCiRzdNmnQvj24NUhA23umCNWd49mC7tR481ZzLSDAEXQXQx4vjpeoPpB6+sTbecmFjsbhI42zkvIsOQo2r5P0Rny6kqPSPHKyAgh87KA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789495964; c=relaxed/relaxed;
	bh=6fvPaWKuH74Rj66uteSOuQL+AbF/NoYDvfe8MEEc324=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDRF4oQo1cOhU39qnlXCPvcVN5we2pQ3yQDHvwZwTBxIVs45wF2vQHNWyQAIb3Ust4jLF6pdEFjYc9BF/JVM6V0M2Zir10fbGEVABZRZL9LkzfH0AQosnveWXkUeByFEhitp1WrJf4cOvAAdXSxtlvs8wwqHtTYeClSeDCkLDsY0MZ0zI1jA6dQS5hOfhJaE7tU6iCVoAtDiKOzq6cu/O2bGxv7KMOJ0D0UIRMDxf0u40nB3yn5O6IgFueUERIh4LJDXJsHhtE8JYXmUTp3DQVGJ6D6soIPw1II7Sg3pOuKKGop/OHUpxiUVZ9qUqrOGNz+G6Ia9+i3F3IrqE2OysQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hyzzEpFC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:33::10; helo=mail-qv2-x10.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hyzzEpFC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:33::10; helo=mail-qv2-x10.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv2-x10.google.com (mail-qv2-x10.google.com [IPv6:2607:f8b0:4864:33::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkqqt0s8gz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 04:12:40 +1000 (AEST)
Received: by mail-qv2-x10.google.com with SMTP id 6a1803df08f44-90cdfe5a07cso718166d6.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 11:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789495958; x=1790100758; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6fvPaWKuH74Rj66uteSOuQL+AbF/NoYDvfe8MEEc324=;
        b=hyzzEpFCQ23ywwN+yVMiejw2I8FySjZnhZpdh5LiF9MD8jRSThK0W0apX9o9daSSLo
         H1RrQk+IWWvCQwMJP38OmLh0plPSjDot1HVFTHycu2kVXn13tEvSWmvvZYhN7tHYegWs
         g5SEcvIwh4WjtEZhtv7XTpJMy5pF75S0JGIsJdKH/Xdc+rSJpZBGHFJdqXRcipA6suQb
         cel4o8FtxzQa3pyDAWsx0mtpm29rpZdHNNmc2aRIOYV/zRO1vUY9DiLrldwB9a7wYI2v
         1S9VZIf67OgVBq4UpEsv91OWiI79E2pAsqlNSfWmM5/p+q8mkzJWsiIFrvSXcvEkQdmG
         I57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789495958; x=1790100758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6fvPaWKuH74Rj66uteSOuQL+AbF/NoYDvfe8MEEc324=;
        b=qt3UeKUCuQR0hinrJc/OD0iKdo9rC0L8znB8ZLamZ/bDsE65pBWzOu0eesxTfDRvK3
         xW6UljdonO6aXFpOIuqfqu9kZlcrFkQv40SeaN6eYXKv7pDYMxoN8OHvP7TZsu9mKGMB
         hZ3+rQEQrpMXV9rOOOJGDfzWuBl1amGRhHHpVEzcDMVCaqpdku+Ij+y+felwWNEQMFwK
         +1eNDGA7lcTFgzvbdIiaUd4rwler5EDs3Bn/VX768Idh+xbFcQy3dghsVWZT1o6UhX8A
         aTud+G/ScJJqdzr00TEzY6CFC53FzAwbi9AB4C26DWl/UxL/o40Fxd/u6Z/btUenuWpt
         vfRQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmMYUvNfdSb86feEygUFXoIn/D6CNFNoGtbAU8EMvgcbbAXosK2OO8rul55POscv+BreK8zvrDlhhQU9Q=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mFEg9nvSqGep119fQvEOU5sEwVTeymTXcdjV2SyMZC4D3ymd5x
	yLbJ+l3oNQwXuv2gVUUgnS3ef6zSsVzlLKLY57uO7PM4lDsrpa3iHVV0
X-Gm-Gg: AYBFou3lr6atcDzejrZEqjLfFX+2iEWAA3fKvWRLQFhLaY0vdXKmUDUFSLpmphlwnbO
	G+nz1rxBTma8ARxytOwrUE7Yh8cK5nNLDzxeiUNSnUacj5EGn5wMn0bEn6fQeOqxrvuwJpl6J9z
	+wOWTpTNomVk7BVassLX5ewBcVpCO4aOX+qGBlnXDtaR8wlWueNjKXUl/KjV86hT6GoHyeXPyrb
	2P/OK5BQwZRRlFReNwO1iIYzhig5Zs5ZaKwdgYYEbAvhroq/h0ZGSsyAlo9QlzgSil2D421jnH9
	ULR2yLkBO8GmTcJeL9kB3HFpIlKhg8UvGsyq/evUHJXANbNdoXtvcjIn+S/wdVBIOxWD6zeXSsl
	L3Z3YTzy1wic5elzR6VuQyeC2h5UUANhFaGQurd8eXR2TAL5erwsjtHGV1ByjzFZZRcp0a5SxbO
	I6jYtrAMHKKgOxZDVvUtMPUG/2Et03MAwoqx81lrAbEZfxDlhAE6GvSghBwujDl+/rzwpW3oMjV
	1ckyvi6MQfmjeC+ebpAbXK7iPuKOyGCd3AHzL+YbHGdmryBZUlt78mHJgSHVp2jMqnOKRcLB2+q
	OuCiPKcM+glgd0mW8wXx1sThrA5385tHxV5DflriML5AwCMh
X-Received: by 2002:a05:6214:2128:b0:911:2a79:cf11 with SMTP id 6a1803df08f44-9123a526c78mr33549316d6.22.1789495957590;
        Tue, 15 Sep 2026 11:12:37 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123bed6f76sm4250996d6.43.2026.09.15.11.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 11:12:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:FREESCALE SOC DRIVERS)
Subject: [PATCH] dmaengine: bestcomm: use platform machinery to get irq
Date: Tue, 15 Sep 2026 11:12:34 -0700
Message-ID: <20260915181234.9839-1-rosenp@gmail.com>
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
 drivers/dma/bestcomm/bestcomm.c            | 47 ++++++++--------------
 include/linux/fsl/bestcomm/bestcomm_priv.h |  2 +-
 2 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bestcomm.c
index 241a91936fe8..1006030ff167 100644
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
@@ -99,17 +102,12 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
 
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
-
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(bcom_task_alloc);
@@ -125,7 +123,6 @@ bcom_task_free(struct bcom_task *tsk)
 	bcom_eng->tdt[tsk->tasknum].stop  = 0;
 
 	/* Free everything */
-	irq_dispose_mapping(tsk->irq);
 	bcom_sram_free(tsk->bd);
 	kfree(tsk->cookie);
 	kfree(tsk);
@@ -377,16 +374,12 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
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
@@ -394,7 +387,7 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
 	if (rv) {
 		printk(KERN_ERR DRIVER_NAME ": "
 			"Error in SRAM init\n");
-		goto error_ofput;
+		return rv;
 	}
 
 	/* Get a clean struct */
@@ -405,8 +398,7 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
 	}
 
 	/* Save the node */
-	bcom_eng->ofnode = op->dev.of_node;
-
+	bcom_eng->pdev = op;
 	bcom_eng->regs = regs;
 	bcom_eng->regs_base = res_bcom->start;
 
@@ -426,8 +418,6 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
 	kfree(bcom_eng);
 	bcom_eng = NULL;
 	bcom_sram_cleanup();
-error_ofput:
-	of_node_put(op->dev.of_node);
 
 	printk(KERN_ERR "DMA: MPC52xx BestComm init failed !\n");
 
@@ -443,9 +433,6 @@ static void mpc52xx_bcom_remove(struct platform_device *op)
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


