Return-Path: <linuxppc-dev+bounces-27645-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819C0C982D0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 00:18:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmCsH0D73z2yb9;
	Fri, 18 Sep 2026 10:18:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789690723;
	cv=none; b=kemJQz+djEzzXReDSqM/HRmdAvnzd4gIdlVNVXQMIi3P0qTVt7OOLnmSHoMT428mabsvMnxbyEi95XyPQbqr79RCSp2DNW8+vvy0+XiIpkDLm8FIsjcN8DoRwNSaBbg0rXRb/mA1RjQYkjElo/Z7v9NFQN/qX50hWOwxL5HzFBmK7FjmMYwMTPfGMgvnv9Dz0V7krO4+AqX4Us1+Isw3nuUVuk509mOlvH3xbyGswU/21QjoiZVE+uN9bXcMsCxCaJhzBO+RPkURyog++eDQbmmToY/KNLVxEkjoqOpq8DXqy5pzJcjlqjxzrhuSQWOcFjoa1h07CQZWHZ8v/EimKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789690723; c=relaxed/relaxed;
	bh=ze9VNiKl6gpQF1dbQkXgpHisrGJOTGys22qHllYAsvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iz6R4zMIq38IvZhYPswX4ISczWjsKuBEkU1ikrfRDBihN0/jtzu9p4qSMAeSijvKhrGQsos7iPF8h6qBgi1MDvqgTmYB5ySaMFI31tgBBHubzgaPDMt9FMdQ3FrXfhWvkEzCd/2MK3dJrmU1SldZyGBrhCyWwa+iDutC8EfGSpMRikledAdAoT1U6nmdySEfNaKpZdpQRa2I2gawKyXXwN9fJhk7wYynN7cKqdeQsa7Rz40ebQZh8BdwFMgDc+Cn5Pv5Y003LKUYlXnklVps2e5gWqfblDCrNCBHtPFLpGMmZ0O8ZtoSNDcg9XwLqQ9T76aU0w/XEVjmS/YeYmtrCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HnmHJTTe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HnmHJTTe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmCsG22RQz2xSR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 10:18:42 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so47416a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 17:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789690720; x=1790295520; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ze9VNiKl6gpQF1dbQkXgpHisrGJOTGys22qHllYAsvk=;
        b=HnmHJTTepZzXaciyDtjllCsP0AAy3iqwQj2PdRB6aMJt7VNXFoPJ6fI2BtTKuK/x9u
         627etpgHSTZhlLJeEjPPEerFce6I1zw1qhOb6mIqAXaUtdtBB2qt36SlsgaSX4ZnjGsx
         Y51Y7abJOFRN//9RAJr3pupmB+c2K9cfIrYt186oTOWtZwFF88uRLjncGHwuDuAGnV97
         urBGju5JEGrF8Hc8uk1pD1VfREjNP8VfPI110uNge6rFF9qfuGGXJTzo8OnhTV+T33Wg
         Ufif8Bnb0oDc9zdGDqyGjTevgeFVsqWxQpahTZvhDO31+A+ejua620jbuV2WblU3IkUU
         ahrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789690720; x=1790295520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ze9VNiKl6gpQF1dbQkXgpHisrGJOTGys22qHllYAsvk=;
        b=RIyCt2wSMYC8WZ6wGxX/cNAQHl9WcVbgeECeMMrN6Ysf4iCvWOlZhEQXwbQBvdDuOn
         WaSmOGS5TTI5i8Rbh37nHTPf6QM99bC6yr9gThxnW3nIpUqtW2hnC5HMzHBk9E1UPsx8
         0bNnSB2osI7Ec8AP8fn1TD10Pq5xIpNuZSDV3AcMNWOA8IzFZS9LrNcssuWeln1Ok3bp
         q4vbwFuLysHQcB2cXhcKuFZKt6BU1fPrO9s1w35UtYlni5MV2ohqqnrjyUZqzxmU9iDW
         AXRV26iUeSNjFqJRI8H0ArOOqtJXjP4laHn/BPHsvTmisrftMQc5h6qekjEylCLuu6VQ
         r+RA==
X-Forwarded-Encrypted: i=1; AKwUvBwGNQsxlUy1aV6JK2Gxwm8aLSceFe6cDJP12mJN40TB0bba1LCmzjkrTDaOWPCDLbTSSurbJ79/35fMbgE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n41pAa3HCP0QLcnbj9MSp431WKnQmmDY/AusgQPrZGgnrKw1f9
	vh6C2suOUaQ3aaLhLFCDb655//LtoOe9vibkQGFkqnkQucRu85B9hOXx
X-Gm-Gg: AYBFou0WK+K9bW/nLKNIcNfxcu6tNZkgOI0tgMYQhWqMogRuWGNxiSTJsV3zh1MfGM1
	ABMJPaxEdYMIOeYTi6Ed/4/knzKRvzj2uZqD9QQp8xuHp8x9IdwrYEs5FoRq/R6+tqU//TeSz+A
	WgOxjc30wuRfk6mVyGaaP/NdotRygiyaiCJKw22FdHyHHSAx6hoee2G8fa/f75vC4K5hJZFx822
	AwYi3j2wagvdBheDO61kv1QZFqeIrN5rCxf1uqGhoGZZHSSJX+RhaSFx7DzJMR6ht3fgErFthzK
	n3CUrFSWmjn5B7o2w3Y119NoNxSqFUpZ8ozuC0vVnVERuqjLjnf5dRvivVVJn4CCEhcLaNLjNf4
	ujbwAW/1fV3prUl11KK9jDySU/LvO9rbpQFQo3eKDStqHCCVq1vL27LO+mgizUg+g5Cq+8DbqrD
	GmcVBlVLdftJL1UIICO0XMo7uPqgIWQeCXMeTOOQ69HeTwiz3K3pphj5WVQnk8FiwQA5gYnT83y
	I0YSgjjJtUW2pZMjnibJ1b8JNreyvngJGtoVYi4+fKrnOEqUj/igf2Ob9XShKCrWd8qoR3GKMq/
	a/5ryDqYDq9zuCQmASvkUjmf6OhgjD//tI+6NdRwr+eY9sXh
X-Received: by 2002:a17:90b:2886:b0:39e:25c2:b9e0 with SMTP id 98e67ed59e1d1-39e54d564ccmr1600831a91.25.1789690719570;
        Thu, 17 Sep 2026 17:18:39 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55a0e7e2sm337468a91.4.2026.09.17.17.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 17:18:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:FREESCALE SOC DRIVERS)
Subject: [PATCHv3] dmaengine: bestcomm: use platform machinery to get irq
Date: Thu, 17 Sep 2026 17:18:35 -0700
Message-ID: <20260918001835.154305-1-rosenp@gmail.com>
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
 v3: drop stale description
 v2: resend
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


