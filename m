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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0984BC433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 00:03:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D07D61606
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 00:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D07D61606
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F7t8n2YPYz3f8d
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 11:03:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=nhwORjtT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f35;
 helo=mail-qv1-xf35.google.com; envelope-from=unixbhaskar@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=nhwORjtT; dkim-atps=neutral
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F7t1J3LVjz3c1F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Mar 2021 10:57:24 +1100 (AEDT)
Received: by mail-qv1-xf35.google.com with SMTP id t5so5701441qvs.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Mar 2021 16:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=88PkT7hzmP9uvlnh5Rsb8g3TAFEqqGGj/lMcm5Asd2s=;
 b=nhwORjtTIVMJ/bsMdgqNd8uoq6Cs7JgZ8YX00vhjlbEVgF9lqTcrqqFaLOyxT8TLmh
 j6eMqWWGzth2rPMVS5X9Py/JgSls2R8a2uGKjK3d5fC2UATp6PvzmH8o1b0Mwf8b65lN
 G7gn7A7icEPgpkHDfLnDY7hh3mIJWxLbFHLnxEqNn3Fu2pc/RESJ5ASbqfbzt/i7hEtx
 3vCsh8h26Ppie6GrkT09TmUYmLAv9ciFcoOuelozIQy08XsWgtc/dxh4NJROi75XMo0Z
 FyLuydql2Ggr5IOC0fjXSjXU0gxU7nIxd+O7/qC10kapvV2kBr9ZwJXc62om9niJbwtV
 rKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=88PkT7hzmP9uvlnh5Rsb8g3TAFEqqGGj/lMcm5Asd2s=;
 b=Namm0S4wQo+0zMJ7wKdPZ2t/iLJK4aNhjGO7xLB8/xpztmAi1rzdOBqSksiA33yhsj
 E5D5461LH7BF/vd0EcNm1Ph+14QgCdDULDn9M6FbqyR3aCoyk+NNmt1Cf09APQ6ZrKZ6
 332f/F6O4lRBVDgvzAGtyGe3n4az+hFTYKR4cdBOpuwfWjFJ19R5zy9ij7l4HOwtxH2t
 lQpS0KhMEL2i1IAP584Dp3GyuXZow3pb+BYDvMfKg6AdnAHIKKqNtar7P1pqVyxLIglf
 028htkELmqDLqtuEOlWeJgjUghjT8aFraGnzmO/Sj370B06qtDxh41OPZjxXYfunHuzp
 fbvg==
X-Gm-Message-State: AOAM533uHaxOYTmOZB5DRzkmkIpMbixPhlD/FlyJPA/D7segHGBHvEBD
 PHeKPLu8LSgDsB45uRp11G0=
X-Google-Smtp-Source: ABdhPJzeNlXwPF2gtbpUnH5nSpOqRgSvlEoS3IIvNxtfx5u/w6b4BkxwheKjinYT+tl9BHqoU9Rugg==
X-Received: by 2002:a0c:df02:: with SMTP id g2mr22814769qvl.40.1616975842037; 
 Sun, 28 Mar 2021 16:57:22 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:57:21 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 17/30] ste_dma40_ll.h: Fix a typo
Date: Mon, 29 Mar 2021 05:23:13 +0530
Message-Id: <90dd5516285c43fb91103905b72d522ae4bf7a58.1616971780.git.unixbhaskar@gmail.com>
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

s/directy/directly/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/ste_dma40_ll.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ste_dma40_ll.h b/drivers/dma/ste_dma40_ll.h
index c504e855eb02..2e30e9a94a1e 100644
--- a/drivers/dma/ste_dma40_ll.h
+++ b/drivers/dma/ste_dma40_ll.h
@@ -369,7 +369,7 @@ struct d40_phy_lli_bidir {
  * @lcsp02: Either maps to register lcsp0 if src or lcsp2 if dst.
  * @lcsp13: Either maps to register lcsp1 if src or lcsp3 if dst.
  *
- * This struct must be 8 bytes aligned since it will be accessed directy by
+ * This struct must be 8 bytes aligned since it will be accessed directly by
  * the DMA. Never add any none hw mapped registers to this struct.
  */

--
2.26.3

