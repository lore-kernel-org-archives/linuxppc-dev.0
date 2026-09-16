Return-Path: <linuxppc-dev+bounces-27509-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3821C982C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 22:42:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlYmH03wgz2yGT;
	Thu, 17 Sep 2026 08:42:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::2b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789598526;
	cv=none; b=AjhPuKsa5ud4kY5CjEe9zelu7uVMfKGkhUMVJnlmDdrD30vBz59cGEq7qaDob3gw2Q+TyNfV412Vsyv2j6xBPR4oSaafZ1w89AL8wRc7ATJv3lnDYwU8kkuO+fFA7jNmNm1BZH2cUPTPkmwsUsWd8GtlDly8ipO0DpRiTNxH924G2VkjvxqJa6K2XmitzYRTSdGISug0X0eQ1+y97hi+LVj4tvmVqr6QgNco7tQovUjc/Nf3iLrnN4woSJlfjuLAM7V94kqbN29SjIUFyJig5Qs0atoMFGhlJhBf/EfmFCZGHQoFlOxkIu9t+0iqSLz/Wavq/9f7vvgxH90MDhhgyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789598526; c=relaxed/relaxed;
	bh=wqgRj8Zu/oLhBcm8V6wCiIRsYY69FuThlNcNP+a4SnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ANQjdNPkzdlLOnLsXPbLdtNOozuCQe55uL4HPTFWS8rPkLKrUZfue1f9v0hFGK2z4DH19LVhst9lfqEVXmzttd0jtI0pR8o/dUvQtQUY2PP0Tj2MDVtgPD51otaSw94rUXQhKl4CnJjLNNnbTrD1kLMCaotv1QJO2MjqauJ3aBIvMjoNYjVYPLbjdx19nJQSlP/zq+i46JZObD3DfjGjXvM1rtzenKtKPbWni60auedcPzmqMnPGhUiCevWFqDdW6wrYsireEl939vD+y++ucAq+c+uHKch75o11ZQQpt6zwkRjkCIcHXejeVy/Kqx54En9VQ2bX4rBQwkSb0hDBMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SvyffVni; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::2b; helo=mail-pj2-x2b.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SvyffVni;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::2b; helo=mail-pj2-x2b.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x2b.google.com (mail-pj2-x2b.google.com [IPv6:2607:f8b0:4864:39::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlYmC6PkTz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 08:42:02 +1000 (AEST)
Received: by mail-pj2-x2b.google.com with SMTP id d9443c01a7336-2d8fe517774so2808285ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 15:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789598519; x=1790203319; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wqgRj8Zu/oLhBcm8V6wCiIRsYY69FuThlNcNP+a4SnE=;
        b=SvyffVni0bOooFA+/IxxqZgt9lQ4vxiYG2Vw7UagQwJxUS5mvTtUkUETW5GpNqnU7j
         UZQbN48fqiAP12kommNdPfxyFn0dXcAr6ee82VjF9sPyw2D152gOQS5gUjyOQOhTHtnH
         rPBYmysnwwpedMIHUgJmnhSH+Wvx3PxjLTVmYBfsVz6hTGaiCQmTxaCdmztGWGJ5+w/E
         NsQqP0Q21No6RDhB4IaO7iuFCIXOBrM6J57GIEMdFM+1Uos1Yz9cKp5bEtKCI2c+vAJo
         ZZ5oZIksyDBYgBZTV1k2LEWhaKKNevkiAdzoYa/4yTTs04pw5pqMWqub/hyjSeNYsvqd
         CUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789598519; x=1790203319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wqgRj8Zu/oLhBcm8V6wCiIRsYY69FuThlNcNP+a4SnE=;
        b=iCg6hdOy6hnHjCREgDxILMhRHhS8tumRCJvP0NLbHA7aDI1cyVOGahnTWbiv47prpc
         zRekcRjJOWXA0f2EgTWd2QBIX5RaIBoyVaCnupbfjPPt8BPJHVpyipGL2cw1g/+2sNhG
         R1oljlnvGi0ccKY07DVEH3Z615t+IEeKrOgN3H9hFMmpUHkE0gwNctLuAZ+5nQi/wJLv
         ZCLppFrnIuszWq1PpTW5JCz9ekVOvr3ufXhE8fQ/ArznnPZyleQW80Ago8bekXMqSFvv
         hBAWR0POehC3Evgi67zvz86RfEOkLdxfF0IClp11CWQ3IEZ61u4oCfhmA3k9d5DJa/g6
         81RQ==
X-Forwarded-Encrypted: i=1; AKwUvByqcrL14mwCax98WMnRFoQz026YnLw7n5zOUKcB7Q+yY8uOo1tW8V88tgx4tGg+Cnl69/Sgj1Qy6U2JjLU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ltN/obRF6/f7XimgqH7lmPS/ORCPCmy18O/x9GKEKvk1fL7R8I
	vNtS6Cpt6VoGX1TUi8mkqF3MYuHOuq1A8gzpkxUHXV/Ql09AvyX/0VBq
X-Gm-Gg: AYBFou0RjMASZlyRcyqDpWaAl9wrzAIKDOnZvIUob4ta6jkcM1sjh8YBfYCwWi05lt9
	fdD4G83BxiOqo0a8qNPTSrBxYKm1frgSF1Xskt4EJJanwz+CV2Ng+y34zITpzxn/SXX1c7rSTE/
	RpmvIvHLHNHP2KO5TG/1xXcVvNwPcj19ROFyu0LPGJ6N74lapPd3OfUcYYV5URTtJRjhnv3gd9E
	N+Am6p1m7Fk3QAUSeli6HsVd78p0o/p398OLrYDjjJcR3p3fmqnRM+k8A1xjdUFXoe5hBJrSCTI
	Ilzc3QND0MnqtVzrt9HIDzw8HLrTUY+91N0IrXb+TDeUjKBr1zT2ORPgluQId1GbitIHEoNKcGk
	LKe0cH86BskfsHry8WkmqAp4BaoUua9eNqeUbA9DFNEaXnLIVmQz9eWMX+f/S/4DbyO1oaFoUXM
	87qxH1LN3nzT1nSluNsmwF4C5YP2pGrSTb590rq6m2fAIjhm/DLmk7MYybdcr8QjIRKF2KS6MBx
	SDeDBQvAQChSTMl9+ZDwwZhePUEfnVRA3smfl0lu/hklHbCu5y2KM5wfGDfVRkA8lDcQVpESija
	nRorv4dHYChmxDLJf0m6HL6vFXMjyv9/tUVUAI048DBBeg50
X-Received: by 2002:a17:90b:560e:b0:39e:3bd2:8998 with SMTP id 98e67ed59e1d1-39e3bd28b84mr1304054a91.22.1789598519204;
        Wed, 16 Sep 2026 15:41:59 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395caccf1sm8260106c88.2.2026.09.16.15.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:41:58 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:FREESCALE SOC DRIVERS)
Subject: [PATCHv2] dmaengine: bestcomm: use platform machinery to get irq
Date: Wed, 16 Sep 2026 15:41:56 -0700
Message-ID: <20260916224156.276511-1-rosenp@gmail.com>
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

Replace the open-coded resource lookup, request_mem_region, ioremap and
the manual iounmap/release_mem_region cleanup in probe/remove with the
managed devm_platform_get_and_ioremap_resource() helper. This removes the
now-unused error-unmap/release paths and simplifies the driver.

Adjust the goto labels in bcom_task_alloc to match what is being freed.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: resend.
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


