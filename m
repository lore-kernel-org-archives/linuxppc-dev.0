Return-Path: <linuxppc-dev+bounces-19295-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8094CE88D73
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 00:07:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnbWX0c8fz2ynZ;
	Sat, 04 Apr 2026 11:07:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775261256;
	cv=none; b=FM3unKN0wySjrLrjztcmb6XHZrdNbXlAVGtg4gwunWqQRiZS1AQt53PqF4+DS5qKqFU8UV8kmT16CPI+zD/Khagq72DXDrcmyWwl0VT1XYEnFysBdEGfufswyub2p/T+L8Y6xwqtmbseRjXQ7mkZbwYkisOKNMDYXhMW/IyaRPrwaqWYA1iZ8jxycLR2v5HJorwYX/FiYmc1MTP8OUVORCPFslsSFEtlisbIhdLFP93NrTaorpKO2fTMPsJVib6151l8Ijyqvo63O8Lxg3IFuR4dUN5IW9O3Hm/lOZDaWF/98YhLHDbnblBLsnuc8LGgy8rEoFN++IwI3DP7FGMiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775261256; c=relaxed/relaxed;
	bh=Bet9w8b/blm24LZki1Y+b44Iyovbn2Yvd3IPo+HAgFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSAiZddWXkEXmas4QwHWzet20nQobnXLBR2BGenuRlROndazYAyZPRTAdSrxUpJQFFfCAxNAxkP8xiH663KQnjR+AB04UUVoT+WSJG8N5t8D0Y4xOxteXMkM6IGH655myyAIB5pBIk2ghzXC0xTXNSCNzq8TFr2CLsmidb9YMFB6vzDYEnZyfwLeORyezjld2uYTqkwlUFS+vH+cg1Zul89AWL7il+n/0DpAVrQfC/x85l2DnxbUQ6noO8XlMyrF+2Rf/3UdUPAhWakgCJ3MgBo3noewGvi0Pz9GLA3tYnft6OtJfQI5xUWhf/sxzBBdgmOG3bDhGXeuwyxpp63x2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oFnrg5W6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=dianders@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oFnrg5W6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=dianders@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com [IPv6:2607:f8b0:4864:20::1334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnbWW3dlQz2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 11:07:35 +1100 (AEDT)
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-2cd339aeab4so528243eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 17:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775261254; x=1775866054; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bet9w8b/blm24LZki1Y+b44Iyovbn2Yvd3IPo+HAgFA=;
        b=oFnrg5W6p4N4rah7D44/ShyMKGR14KzbrX61Iq4zMim7AhW5e//rrmWZdmPBV6cHva
         sSd8oWgy2sYLKHERsuhoVOnZ2VlUeqsngyn4bNewwC8OeeR4tFKOT/FsjcH/AcHFx0zC
         v6lSQIoqokKqKh+n6QuNFrXCmeW2WOV0UOFlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775261254; x=1775866054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bet9w8b/blm24LZki1Y+b44Iyovbn2Yvd3IPo+HAgFA=;
        b=UC0Clr+2qJ19kR3TYOHhstmynjy9eOAuigM98dff6fFuzsAYjYcxSkwwe7sveEUVvC
         q0Ea3u9isSgavh3PTdfs9QtpzcqyUi65qm2DTywqbmT/ZFpY2u1KSDQqPbD83nHSR4PC
         1h0qt4DXvsnGvfXaBrBHWvNeksoCABEUWbJ6cBHolsDVySlNHw15PM/nRLJl11wI6I7/
         m6a4/4vszEW2c93MQmoW+OLJ9SmUcR7uFVzfmAhedw+MGvpLc7rYj0E5Ke9IgNDHbjFV
         ovUDdXInDlzFHpS19j2PQ8f/lgcaClu//Qqmz0HBN6sASjjtawa5S1zKSKwggEBObIye
         x02w==
X-Forwarded-Encrypted: i=1; AJvYcCV16xNJctv/PpwDiJ5KE8Oo7uFUHvF8HqD2bCb+ISGF0SPru2oI3hbKaMyi3E8b1MOp0eWpSmlzH13kCLQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxpnztWIbLk7uvNwVD2nk0b29mXf6Cf0shR2L1qnKa4gg2FCnDk
	V7YtwnStVNyQjsYyaKVvyD7tFP3KdfdSNU79MKoZAfoT+9sWioYlm3WxjO3oCKn3tQ==
X-Gm-Gg: AeBDietiTMFexOHyONAkp01CaK/c9wwQwqLjizta4C6yczID2TH3fm/ej/GmbqFWqJg
	Ar18RaelhbTgz6tt/VkjiwUZPgwudadNZERCCuwg4dIwx3x7WeHlAlITncIK8bKMxGDNUlL3wul
	g9n1eiZHxDmQKAL+e3s84lswh2ULVfxWQQY3zsM859eph/vB0r6z2STK9ejCaXgraDkmo3K1jAJ
	NpyX6V6QfIA4oxj7bPb+p7mZGKOG/RBOBSUp2ipBzielqlgUkP0ZTDrNeDKiLhKTkoCR7fXr2Wx
	rg40YXVJ6RztG/fg4nAWfMZ7NF8w2npDmsMFz5kGdjROd/yjtWw+eFxVTelD6XfuMD/2UYIB0Ol
	Be1OxRjd6x+I4BjCkIarhVKtANdJK2gVhVYL0Ho4k3RSOQgFB92AYMxvKN+vBmeXQzBM3ky5/Zk
	kc1FRDZ9irk/1uto07u3r5O20S6KIGLiIHMbe06Ira70Sx3iC2yjWlQEYhjMVBqXZoDIOsJa6Zs
	jxkalsf0RZdLX/+uFVwUg==
X-Received: by 2002:a05:7300:d05:b0:2be:10a6:647e with SMTP id 5a478bee46e88-2cbfc16e113mr2496039eec.19.1775261253576;
        Fri, 03 Apr 2026 17:07:33 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:a8b6:55b2:3eb6:2c0e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca79e1d93bsm6520716eec.12.2026.04.03.17.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 17:07:31 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Saravana Kannan <saravanak@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Eric Dumazet <edumazet@google.com>,
	Johan Hovold <johan@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Robin Murphy <robin.murphy@arm.com>,
	Douglas Anderson <dianders@chromium.org>,
	chleroy@kernel.org,
	driver-core@lists.linux.dev,
	gbatra@linux.ibm.com,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	m.szyprowski@samsung.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com
Subject: [PATCH v4 5/9] driver core: Replace dev->dma_ops_bypass with dev_dma_ops_bypass()
Date: Fri,  3 Apr 2026 17:04:59 -0700
Message-ID: <20260403170432.v4.5.If62b84471ef2c85e7ad250f0468867d6dba965ab@changeid>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260404000644.522677-1-dianders@chromium.org>
References: <20260404000644.522677-1-dianders@chromium.org>
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

Changes in v4:
- Use accessor functions for flags

Changes in v3:
- New

 arch/powerpc/kernel/dma-iommu.c |  8 ++++----
 include/linux/device.h          | 15 +++++++--------
 kernel/dma/mapping.c            |  4 +---
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 73e10bd4d56d..6d1899b38c3d 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -67,7 +67,7 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
 }
 bool arch_dma_alloc_direct(struct device *dev)
 {
-	if (dev->dma_ops_bypass)
+	if (dev_dma_ops_bypass(dev))
 		return true;
 
 	return false;
@@ -75,7 +75,7 @@ bool arch_dma_alloc_direct(struct device *dev)
 
 bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
 {
-	if (!dev->dma_ops_bypass)
+	if (!dev_dma_ops_bypass(dev))
 		return false;
 
 	return is_direct_handle(dev, dma_handle);
@@ -164,7 +164,7 @@ int dma_iommu_dma_supported(struct device *dev, u64 mask)
 		 * fixed ops will be used for RAM. This is limited by
 		 * bus_dma_limit which is set when RAM is pre-mapped.
 		 */
-		dev->dma_ops_bypass = true;
+		dev_set_dma_ops_bypass(dev);
 		dev_info(dev, "iommu: 64-bit OK but direct DMA is limited by %llx\n",
 			 dev->bus_dma_limit);
 		return 1;
@@ -185,7 +185,7 @@ int dma_iommu_dma_supported(struct device *dev, u64 mask)
 	}
 
 	dev_dbg(dev, "iommu: not 64-bit, using default ops\n");
-	dev->dma_ops_bypass = false;
+	dev_clear_dma_ops_bypass(dev);
 	return 1;
 }
 
diff --git a/include/linux/device.h b/include/linux/device.h
index fde0c72c3159..2ce89e3cfab9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -473,12 +473,18 @@ struct device_physical_location {
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
 	DEV_FLAG_READY_TO_PROBE = 0,
 	DEV_FLAG_CAN_MATCH = 1,
 	DEV_FLAG_DMA_IOMMU = 2,
 	DEV_FLAG_DMA_SKIP_SYNC = 3,
+	DEV_FLAG_DMA_OPS_BYPASS = 4,
 
 	DEV_FLAG_COUNT
 };
@@ -567,11 +573,6 @@ enum struct_device_flags {
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
@@ -685,9 +686,6 @@ struct device {
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 	bool			dma_coherent:1;
 #endif
-#ifdef CONFIG_DMA_OPS_BYPASS
-	bool			dma_ops_bypass : 1;
-#endif
 
 	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
 };
@@ -718,6 +716,7 @@ __create_dev_flag_accessors(ready_to_probe, DEV_FLAG_READY_TO_PROBE);
 __create_dev_flag_accessors(can_match, DEV_FLAG_CAN_MATCH);
 __create_dev_flag_accessors(dma_iommu, DEV_FLAG_DMA_IOMMU);
 __create_dev_flag_accessors(dma_skip_sync, DEV_FLAG_DMA_SKIP_SYNC);
+__create_dev_flag_accessors(dma_ops_bypass, DEV_FLAG_DMA_OPS_BYPASS);
 
 /**
  * struct device_link - Device link representation.
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 76fc65d1a8a4..30bf8455730a 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -126,11 +126,9 @@ static bool dma_go_direct(struct device *dev, dma_addr_t mask,
 	if (likely(!ops))
 		return true;
 
-#ifdef CONFIG_DMA_OPS_BYPASS
-	if (dev->dma_ops_bypass)
+	if (IS_ENABLED(CONFIG_DMA_OPS_BYPASS) && dev_dma_ops_bypass(dev))
 		return min_not_zero(mask, dev->bus_dma_limit) >=
 			    dma_direct_get_required_mask(dev);
-#endif
 	return false;
 }
 
-- 
2.53.0.1213.gd9a14994de-goog


