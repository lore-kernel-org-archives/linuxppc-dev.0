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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C738C433C1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 00:01:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E6161949
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 00:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E6161949
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F7t6M4rsPz3dkL
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 11:01:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=lnZVGx88;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::833;
 helo=mail-qt1-x833.google.com; envelope-from=unixbhaskar@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=lnZVGx88; dkim-atps=neutral
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F7t0q4mPNz3bnJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Mar 2021 10:56:59 +1100 (AEDT)
Received: by mail-qt1-x833.google.com with SMTP id u8so8197356qtq.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Mar 2021 16:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V731M1ZjoMObeUPxmfQu760ZEmOVyQS5nvVKDsMpRYg=;
 b=lnZVGx88/Q4RgjL+3hIrxaeLUCknaQO529y1KHYklW+L+nkdj8gpcbnqm8dMc1/+l7
 f6zSHAW3lnPCPRE6I8Y7+qD6NhajFTxCnWDjvRqS+5YTVtxG9RfzFR2gppG6pd2KUONg
 x2Ypd6MdyYMDQxXuVr9h1defti29sytWbU8Ue/Li0RmO+WBaY8GzifXSi3Uzw8ctplXy
 6TXDeusuFr4d4znZtig85zoIyEx6i/oXnzfPQNVFdJWRikFvX9A33V/ZVXPGGkcr9CJy
 RJnXtSxeb6weKiUSJ+4jqKEIqqXxCR3aOs9fIwYirSfoCpnld2ZyldI5xWdSpa4LevUr
 PhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V731M1ZjoMObeUPxmfQu760ZEmOVyQS5nvVKDsMpRYg=;
 b=o4ljuXAx8/ZYIsw3vy/ie99cQkOo+IYknOE68N1jYozSpmJIjgjYWuOdQaVNNzdanN
 0G9y/GzU/HOLuR1Sn/oAH0IwGJkxOvkGVWUM9BciLVavHO6ZuiYT/BSYiy+7UtIz63mq
 tQIRf/ww3raGboMKwgPEMTptOfkOx9JmE4eebPaGotGWgkrrGbQCWqx1ZErfPNMlLCkd
 NCKrsatojMqlXuJ9O8fh1y1vh0dKYz9ujOxk0Dkf8MNVcriFXdlm0EaqTK2Et8+P3Jxa
 6kRPaOqFtVkZfuxscLM/oYPV//4OHZyH5ZYPP5VtfEa/CVGGnjzE7apTlb8uFqg6GcJI
 NZQQ==
X-Gm-Message-State: AOAM530mRRU9yznYhX4HMnv6OroZJaUJgEDDxGqm81hJKqMWbCZlUVhw
 BiAMtMzTjSDnmTucAlNT7Uw=
X-Google-Smtp-Source: ABdhPJwfkmcNQYJxn4S9wN8jOvwQsIXVBRg1ipQrCtKoJ4PNJU1NU5IafcNZI5PpJzjZHpA0d8+z4w==
X-Received: by 2002:ac8:1098:: with SMTP id a24mr20071293qtj.291.1616975817116; 
 Sun, 28 Mar 2021 16:56:57 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:56:56 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 12/30] of-dma.c: Fixed a typo
Date: Mon, 29 Mar 2021 05:23:08 +0530
Message-Id: <0c3e1bd83c63203a0aad27006fbd369090a69dce.1616971780.git.unixbhaskar@gmail.com>
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

s/propety/properly/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/of-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index ec00b20ae8e4..e028acff7fe8 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -337,7 +337,7 @@ EXPORT_SYMBOL_GPL(of_dma_simple_xlate);
  *
  * This function can be used as the of xlate callback for DMA driver which wants
  * to match the channel based on the channel id. When using this xlate function
- * the #dma-cells propety of the DMA controller dt node needs to be set to 1.
+ * the #dma-cells properly of the DMA controller dt node needs to be set to 1.
  * The data parameter of of_dma_controller_register must be a pointer to the
  * dma_device struct the function should match upon.
  *
--
2.26.3

