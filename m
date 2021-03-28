Return-Path: <SRS0=Xl/Y=I3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EA2C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 00:09:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65196192E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 00:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65196192E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F7tH04hSFz3gBJ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 11:09:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=PIw7C1Bk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::82d;
 helo=mail-qt1-x82d.google.com; envelope-from=unixbhaskar@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=PIw7C1Bk; dkim-atps=neutral
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F7t2X4Kz0z30D5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Mar 2021 10:58:28 +1100 (AEDT)
Received: by mail-qt1-x82d.google.com with SMTP id 1so7586762qtb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Mar 2021 16:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pZY3iifrv8ClFucjg75wWqbWgmlD1U3QmF4uzbWxtyk=;
 b=PIw7C1Bk/eGWQKsGvWCr0S8TPn8QvRWOhl6hvWK4VjoMFupeY5/g8s7kzwhMScA5Yu
 3e7Rj/bjvS2b85U9+k88WGtsKgUTPvzzvdFJYC0k/RqLPZFS/3GhHjMqD5kK+e7jKM/6
 53Fvs6gxrbJFiC1u/dgFp8bxTyuVzLD/Tpou7SHHqSFadmyNPt3U4CU58tt95gASNQQ7
 xYX4ULcW05MCOpvlLfFnzFEUNX3Yp7+RhdNBet8s+BvsIMTWUkgy4Nq5pTpS8LNP/fAV
 /fA+htsmtHzgRatr0oZ5k5rLTOnxU0BoqA8YYmMtTbokFKvFZL0GLX13Zdgx+VbiqJTc
 ioTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pZY3iifrv8ClFucjg75wWqbWgmlD1U3QmF4uzbWxtyk=;
 b=APDAAw3S8q9l+im5HqVzDkX1gNwrrlN1lSO/WX/91AkRHblg3OLgrc/cG/fhzfJzwF
 S3tYEwoqK+UuB3CjkJiAPK7f2TjokdzbhSO9C2XZ6o2MgLZvZObE7AvDoROEfy+eBLDG
 zbXeZTu/pSHKRiIvwkkYInmUo6aJv9qntgqpOee9hT6lBo6WOs9bHW1VpJTzOrGKeTll
 yYAnWhhIKWcjHlMhdivjuqNh7HWapbto0z2cedzSHlLbjYCMZrC9FZN4z0Em1EigClP3
 ZiOFyKgLChCoifBjyndakkcfInumAXEXzP2EFj9NJkSEZx3cyLjJQVi1SXw6VboKWgBR
 VYhg==
X-Gm-Message-State: AOAM5322sQD/UuNqXCfdUbn5AX98ue4FKmrDf0CpZuDSlnn62JIKAJOv
 pU/Vo3ITN/XpZOjLjn85GUTHOX8Ns63qGAuJ
X-Google-Smtp-Source: ABdhPJzrXaJ3NFEfLw/ORFLnH6cpcNnBby0kvFM8FYj18PlBci3BiuYNuENXsp4hnCZmTj7qcXXSOw==
X-Received: by 2002:ac8:dcc:: with SMTP id t12mr13998503qti.219.1616975906780; 
 Sun, 28 Mar 2021 16:58:26 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:58:26 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 30/30] xilinx_dma.c: Fix a typo
Date: Mon, 29 Mar 2021 05:23:26 +0530
Message-Id: <4613951fd51572e8c152d07c402d30a13f19a917.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
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
Cc: rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

s/interace/interface/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 3aded7861fef..63d2f447ad79 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -483,7 +483,7 @@ struct xilinx_dma_config {
  * @ext_addr: Indicates 64 bit addressing is supported by dma device
  * @pdev: Platform device structure pointer
  * @dma_config: DMA config structure
- * @axi_clk: DMA Axi4-lite interace clock
+ * @axi_clk: DMA Axi4-lite interface clock
  * @tx_clk: DMA mm2s clock
  * @txs_clk: DMA mm2s stream clock
  * @rx_clk: DMA s2mm clock
--
2.26.3

