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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1FFC433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 00:00:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64AC46192F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 00:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AC46192F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F7t4v6vQkz3c2B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 11:00:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=bGnHyBFV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2a;
 helo=mail-qv1-xf2a.google.com; envelope-from=unixbhaskar@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=bGnHyBFV; dkim-atps=neutral
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F7t0X5m3fz30Lt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Mar 2021 10:56:44 +1100 (AEDT)
Received: by mail-qv1-xf2a.google.com with SMTP id c3so4547171qvz.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Mar 2021 16:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rruIrfqaU4LV0f/3DETW92os/6jYETGIbvTMrRY/HO8=;
 b=bGnHyBFVOutt4P2ONnjyaSIeJvIRzETak6KwFJ7ir2Nn/GqZgVtFuQhT8cWFVCJCF4
 nOmS5/3lsk0F21Pui0C1nfch9n42xfmm27QVRq2RUbd469ITaO2YTyoT6yca1dt3kEIA
 WrrB+5zNMv5REpdJe2JR74UmZr5+PTYnt/XmXcfAg0fv6Fy7GCSeRicj7d/SVnq3Qu/D
 UKRgx0ggNDlvFtQyqwIWq00SNVHxRapkrohVs+rT8HcJE0cam15uS2VWEv/I+wPd8Sx3
 oxsNNTD4FAJ8DW0fVQi+ybJ+sHJ776F4pG4SBgFnsTZUI5HwctVd0uJCZQ7w/2oBe12l
 xa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rruIrfqaU4LV0f/3DETW92os/6jYETGIbvTMrRY/HO8=;
 b=MmRhpwtuOUl4OSpFWWs9VnT5bThf2ZurZfEHIyIt6R8Rh6f8vED9qc2Q8tMejCHqDW
 M3NFdwlgbyNzrb0ZoUz7OZZxlqOl11F4oWj+K8pUzHfJCDFKkhSYPh6zmYJXj0AGG1Xg
 fydVgc1p4m+PJizmHNtuO/6qNUquKS2zH65gdsC/EF0O7/7h9LAtM2lMbYnyNP0GzliO
 ISNkTHnrNHMeNkZB7wNa5jbk4Sq5uNLddEhSfFkDC1k9Hed95PEz+sC819jG+HkDpGfC
 RluYz7760UCvAqKHNbfj0Jqto85h0fpHXxriFjmXV/mg5Qu/yGCTKcKVt35f9HE5mxV7
 nmsw==
X-Gm-Message-State: AOAM533l+TexPV1zNPlCiyzaWyLwVYZfFgVpG0nchq7HMApz2flfqMsu
 CFiIPzSRkNNy9Zt7gdHTwsCm7LCF5FhpUQBo
X-Google-Smtp-Source: ABdhPJwGtK6xTmnuLSPnSFT/2CTh7pV1MaTzw54JyGs6QVwUBLmi4sfOAtAfjo+zm2N6Vm+LRKQfow==
X-Received: by 2002:ad4:5614:: with SMTP id ca20mr22679724qvb.37.1616975802324; 
 Sun, 28 Mar 2021 16:56:42 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:56:41 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 09/30] mv_xor.h: Fixed a typo
Date: Mon, 29 Mar 2021 05:23:05 +0530
Message-Id: <c7ff7a7dbd93aecfc5b97f55a3ccaf23fd8a7c6b.1616971780.git.unixbhaskar@gmail.com>
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

s/writen/written/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/mv_xor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index d86086b05b0e..c87cefd38a07 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -99,7 +99,7 @@ struct mv_xor_device {
  * @common: common dmaengine channel object members
  * @slots_allocated: records the actual size of the descriptor slot pool
  * @irq_tasklet: bottom half where mv_xor_slot_cleanup runs
- * @op_in_desc: new mode of driver, each op is writen to descriptor.
+ * @op_in_desc: new mode of driver, each op is written to descriptor.
  */
 struct mv_xor_chan {
 	int			pending;
--
2.26.3

