Return-Path: <linuxppc-dev+bounces-19245-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8F5CC6B1D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 00:51:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn0Y53YCjz2yVL;
	Fri, 03 Apr 2026 11:51:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775177513;
	cv=none; b=ZjdN5mFTgZ/EMPy1eP7vlu7LNx9ZMygUluZIFNXRYocOue/GgLCCm49eTQkHIjLtXVB+9O18VThxzv/isWcydIivZs+XXYCOGlcmAjcgZji6OoOM8evkRBL03m7TMjX4FxZxxK/vjlt983YNWb7mHhH8UxUZYQ29l89n1fKLGUHP8ZbTtqLASHKSQayI9k5xv3T5NELHVMt6GxZBPXbCCRmGi7vocePjDpkyyCRvUvTYJfZc5y5sj+Q3fWZknJ31j5hPKU7/sedwRrVcSS2iyQ3jhf41P124bbLEzfvgXs1vt5Z6fCO1ibD5fn0i3U9HoO8p5xc0/lNSfc1lcXeZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775177513; c=relaxed/relaxed;
	bh=lZiTiKY0xg6ysj9D1M7VJbCxfmHcK2OdGCIMJgNJnE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lo0phTY+UH8pAqpTsd11hBDJK5wvJS7fSxBt4x2E/lHc4/elKk9hBz1X0F4JIHthn9EwSaJkEgHdU4icleaBsKiZuxNNUVgaGQzYSKDsLVsCnLcZVzx5soECBKpkvBJCgpzH2GAVxFZb7Fd5RQQ4fGK3QSriMX1/+h46ihJbwa8YzqIGxIWQS1BnbeH4YxhAPREzDkt29bWEnRigThs20jMZyiTm2NhsU0KDivgi9VmcHYumzCA6AfKXEO0h/s/RI8cPhCA+I6S2o08pKczLG7+KcS6Zy4jjNBnXPvCYtpN/WlNS/Rm2GNHQeO2ndtFhVZ49u84pxmc0J9svZ/aszw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cykLDNip; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=dianders@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cykLDNip;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=dianders@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn0Y465CVz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 11:51:52 +1100 (AEDT)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-2c1632faeb9so2914274eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 17:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775177511; x=1775782311; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZiTiKY0xg6ysj9D1M7VJbCxfmHcK2OdGCIMJgNJnE8=;
        b=cykLDNipXra21PihGUd7qXWJ74WDXmGyKFqnpajIiiCkiLM7StJqQWo5pG3fcp02Rb
         yRCIt8kJRda5UpvtSXToa8Na1+4DJ9TtFjak1DlZNuTzZfv2M6WIZNbqYFAG7HSRT+Ma
         S3EiMzMujt2Iuib7YMw78ZambeWRlV3EEFLDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775177511; x=1775782311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lZiTiKY0xg6ysj9D1M7VJbCxfmHcK2OdGCIMJgNJnE8=;
        b=U0hFHC1XeEMANMlNc8e34q6jH+VSFB5Lic3sRkEAcaVYAp7d70rawN2cnF1gCJOqx/
         rcEbFk2VvsKQM8EMJ9NjvRIh3Kai/dwz9hwuw6/l7JhaYVSFO1XfDlA1xBvDjvaHsWZI
         nzluUvrF1qcFmaWFZZxDpk4tvVjAYcsg+Z5ntpzGeremv42fL14gwOkhq0aqn8lcACjx
         biZo1Kjjkilmp+Q9oO7DKcp97PLUTIg6MRXqBCvuRxizR5JC43e+liHAyK9NddAGBrD2
         ZN9aqpGjHiaZuDzSYD0vnkFELmRvpY3bPlX1yVjQN94Ue8e1DiCEIDPTFOfxZUKb32VW
         bndw==
X-Forwarded-Encrypted: i=1; AJvYcCVZL0WKWWAs20v0rkvrY6hCOCjd8u8sPwDze9WD4u5QMk48O3ud9dVX4uAaAZXaTTeJip/1ZAu34dyo51c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxHt3OwIoKXZ3yA95JUhRsw9clwmQ6RRMJ4gbtMw38tt77sV729
	fZbNuXf8HVdx0Q5R0lm6Tq0nstDIoG092039uCiW7hsx2uFxAaYzCodpQ6L408VIMQ==
X-Gm-Gg: AeBDieuhTXhPyOY1r/SdpNq/whpuDidifJLc4rIy6uNt/u0PRZkm7kX0nyMmam5yfmr
	N2fWpwQrQcovIlCqgprZVtFmCBb03l7WW7trao05GDLkCdO4sDcl7gx77b5etuou57E1p+RlusE
	vE/NIZGxK78W9q5nPtBUf3WsYalqk6fmx+C9Zq8Emesx45sO2eOD/k1p2dc44N+IDJgckWCBIo2
	gG8lLuKrenSQrqq/5kvs4IrA/xLw6SiWK0MYmZeH0P9peNlPa9Y+SLtRdNZsfaP+VnjX9K+WRWJ
	+LLKvj0N/INlpGp753nKsgzvde4ycL57vfRWVy5a8nJlLVp3upCGdhP0lO+LQc6npyPyQVYiedu
	tZSm1JKCv93ziSgGYbGImaclJ6f/WOFFA119Pm/ZJObOkPbqnZpA5wStEd+i89FLUPZRZJKs8Vk
	+RclOakx4dCWNRgK+DROH70T+OnNP2kZHBsmI97UtiIl75hpXxfn+Jcicm18OrssiPP1Q379Aay
	61apN0HbeA=
X-Received: by 2002:a05:7300:371f:b0:2c5:b23e:48a6 with SMTP id 5a478bee46e88-2cbfc268d12mr658562eec.23.1775177510944;
        Thu, 02 Apr 2026 17:51:50 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:5db3:7542:a530:f43a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df3b84sm3630074eec.5.2026.04.02.17.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:51:49 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Paul Burton <paul.burton@mips.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Christoph Hellwig <hch@lst.de>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	chleroy@kernel.org,
	driver-core@lists.linux.dev,
	gbatra@linux.ibm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	m.szyprowski@samsung.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com
Subject: [PATCH v3 5/9] driver core: Replace dev->dma_ops_bypass with DEV_FLAG_DMA_OPS_BYPASS
Date: Thu,  2 Apr 2026 17:49:51 -0700
Message-ID: <20260402174925.v3.5.If62b84471ef2c85e7ad250f0468867d6dba965ab@changeid>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260403005005.30424-1-dianders@chromium.org>
References: <20260403005005.30424-1-dianders@chromium.org>
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

In C, bitfields are not necessarily safe to modify from multiple
threads without locking. Switch "dma_ops_bypass" over to the "flags"
field so modifications are safe.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Not fixing any known bugs; problem is theoretical and found by code
inspection. Change is done somewhat manually and only lightly tested
(mostly compile-time tested).

NOTE: even though previously we only took up a bit if
CONFIG_DMA_OPS_BYPASS, in this change I reserve the bit
unconditionally.  While we could get the "dynamic" behavior by
changing the flags definition to be an "enum", it doesn't seem worth
it at this point. This also allows us to move one "#ifdef" to an "if",
getting better compile-time testing of both sides of the "if".

Changes in v3:
- New

 arch/powerpc/kernel/dma-iommu.c |  8 ++++----
 include/linux/device.h          | 14 ++++++--------
 kernel/dma/mapping.c            |  8 +++-----
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 73e10bd4d56d..6486417c8acb 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -67,7 +67,7 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
 }
 bool arch_dma_alloc_direct(struct device *dev)
 {
-	if (dev->dma_ops_bypass)
+	if (test_bit(DEV_FLAG_DMA_OPS_BYPASS, &dev->flags))
 		return true;
 
 	return false;
@@ -75,7 +75,7 @@ bool arch_dma_alloc_direct(struct device *dev)
 
 bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
 {
-	if (!dev->dma_ops_bypass)
+	if (!test_bit(DEV_FLAG_DMA_OPS_BYPASS, &dev->flags))
 		return false;
 
 	return is_direct_handle(dev, dma_handle);
@@ -164,7 +164,7 @@ int dma_iommu_dma_supported(struct device *dev, u64 mask)
 		 * fixed ops will be used for RAM. This is limited by
 		 * bus_dma_limit which is set when RAM is pre-mapped.
 		 */
-		dev->dma_ops_bypass = true;
+		set_bit(DEV_FLAG_DMA_OPS_BYPASS, &dev->flags);
 		dev_info(dev, "iommu: 64-bit OK but direct DMA is limited by %llx\n",
 			 dev->bus_dma_limit);
 		return 1;
@@ -185,7 +185,7 @@ int dma_iommu_dma_supported(struct device *dev, u64 mask)
 	}
 
 	dev_dbg(dev, "iommu: not 64-bit, using default ops\n");
-	dev->dma_ops_bypass = false;
+	clear_bit(DEV_FLAG_DMA_OPS_BYPASS, &dev->flags);
 	return 1;
 }
 
diff --git a/include/linux/device.h b/include/linux/device.h
index e900748d3038..f5845bd7c3e6 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -472,12 +472,18 @@ struct device_physical_location {
  *		doesn't rely on dma_ops structure.
  * @DEV_FLAG_DMA_SKIP_SYNC: DMA sync operations can be skipped for coherent
  *		buffers.
+ * @DEV_FLAG_DMA_OPS_BYPASS: If set then the dma_ops are bypassed for the
+ *		streaming DMA operations (->map_* / ->unmap_* / ->sync_*), and
+ *		optional (if the coherent mask is large enough) also for dma
+ *		allocations. This flag is managed by the dma ops instance from
+ *		->dma_supported.
  */
 enum struct_device_flags {
 	DEV_FLAG_READY_TO_PROBE,
 	DEV_FLAG_CAN_MATCH,
 	DEV_FLAG_DMA_IOMMU,
 	DEV_FLAG_DMA_SKIP_SYNC,
+	DEV_FLAG_DMA_OPS_BYPASS,
 };
 
 /**
@@ -564,11 +570,6 @@ enum struct_device_flags {
  *		  sync_state() callback.
  * @dma_coherent: this particular device is dma coherent, even if the
  *		architecture supports non-coherent devices.
- * @dma_ops_bypass: If set to %true then the dma_ops are bypassed for the
- *		streaming DMA operations (->map_* / ->unmap_* / ->sync_*),
- *		and optionall (if the coherent mask is large enough) also
- *		for dma allocations.  This flag is managed by the dma ops
- *		instance from ->dma_supported.
  * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
@@ -682,9 +683,6 @@ struct device {
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 	bool			dma_coherent:1;
 #endif
-#ifdef CONFIG_DMA_OPS_BYPASS
-	bool			dma_ops_bypass : 1;
-#endif
 
 	unsigned long		flags;
 };
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index f50b648ed460..44d4c319ffad 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -126,11 +126,9 @@ static bool dma_go_direct(struct device *dev, dma_addr_t mask,
 	if (likely(!ops))
 		return true;
 
-#ifdef CONFIG_DMA_OPS_BYPASS
-	if (dev->dma_ops_bypass)
+	if (IS_ENABLED(CONFIG_DMA_OPS_BYPASS) && test_bit(DEV_FLAG_DMA_OPS_BYPASS, &dev->flags))
 		return min_not_zero(mask, dev->bus_dma_limit) >=
 			    dma_direct_get_required_mask(dev);
-#endif
 	return false;
 }
 
@@ -895,8 +893,8 @@ bool dma_pci_p2pdma_supported(struct device *dev)
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	/*
-	 * Note: dma_ops_bypass is not checked here because P2PDMA should
-	 * not be used with dma mapping ops that do not have support even
+	 * Note: DEV_FLAG_DMA_OPS_BYPASS is not checked here because P2PDMA
+	 * should not be used with dma mapping ops that do not have support even
 	 * if the specific device is bypassing them.
 	 */
 
-- 
2.53.0.1213.gd9a14994de-goog


