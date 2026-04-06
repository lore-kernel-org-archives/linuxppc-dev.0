Return-Path: <linuxppc-dev+bounces-19415-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E60FFB5179
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 23:25:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqQRl12MYz2ykf;
	Tue, 07 Apr 2026 09:25:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775517939;
	cv=none; b=B7yw2mSohgZL2HxpsGuPMbn4W6heJJiWOTpREXxBomoCAHneHBZzQH6eeor/tNJ2YMnQ2LJ1qkOzrAieBtDwiTC2AEUgnEwp4NuqRWtPhdob4RuB6D16yWl/gfWzERNyGl+xLgxax1hCTuKcItktAxQbMFeGe76BW4OD9QEJVOJcwO83ZRwCaMAm1nlgMz4k9M4x3glN7dckW4iZZd8l5s4/gQQW2uYTfwq3TXVkIdntRorf452tyToYKykI6KBH9oYZrjzSHmtpRhJWVYARPYeiNT7BcnauJgaFW5GwqqARCIfYD+WWIpFCfuXK2cNEPDxhsX7sQLUJdU1H6FrEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775517939; c=relaxed/relaxed;
	bh=QLh8ZGhB5dU98LppXST8xiQJL4Zgmni3hu9P++EXxzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyM6IRScJ6OMTL1NKUXUXdUCCDELCxYSvDOq4f74DPpkJRw8OnIznGgBBb5FLXT1F7HQqRzF90AcTtXk2bUmXzSqH72RNU1gNShkZgoRLiANYEFVWTZYZ4IeJmxx5U33vM76ynLmcpZ/f7upRL+tJRs0ASCnUSL0u4xq2TX8buybeHIiSy3T+5Ng+prTZ1J+2K+KPYfdwY77M8JOsyCz8ZTovNpZ5KF98OKVBW0+Xfkzhg155gQlkGGUCg2QTzDSDNFWFTVFI7rSyGMnFDCD1z1xSLjMEpsvYpwACId1vAYBr1sxQV0BdryTjL6TGzAyuGmlcNwg6ngCPdpTH2oHCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RlSZJSVY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=dianders@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RlSZJSVY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=dianders@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqQRk2v8sz2yfs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 09:25:38 +1000 (AEST)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-2cfd69b564dso2334878eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 16:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775517936; x=1776122736; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLh8ZGhB5dU98LppXST8xiQJL4Zgmni3hu9P++EXxzM=;
        b=RlSZJSVY8GyV+Ffqbfp6dZZMXthbTH5oHf4hZi2DgqYSr8N9soTzrIN073VB3NnFOp
         ldZzExBovyQbcNSie5edSS+bB+2D7BAf+/DpyUfkcprA3Iwl/y2rRJe42+8vNTpFvaun
         GiieIuZ8YiiMy67xeaW9NKVyRNoQ9c+ofJCOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775517936; x=1776122736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QLh8ZGhB5dU98LppXST8xiQJL4Zgmni3hu9P++EXxzM=;
        b=bc9drcdCryvipoF7ikQNoRQf/4WqBJmFHl0xnjsFCKWu0R2at62KiCt1mjhNzmAPSg
         WV7CaXXI03eh4YJiMaTRim4+hY0lyaB+GvbIVFFsY+2BAzESPS8UcIdZzCSjnDTCFzNl
         bEwa0fMdAU5fj8q7XEf5qfmr0xsZ8veoZmKW8twMybJHuc7+Euoex99xXJFRG4Ma/1Z5
         pwahvI/2TBGpCYoHrSYJJqOUYr8Ff7AYvdJho1f1SQf/fs+G8P3NEj/6HuJ68gLdDqvW
         GqswY+P3IWWBcwkLSiYiW8l3LYzP+WLTqOSiJIFPZ6dXeCHInkjpCwx/ipN8pBBzOUs/
         3pSw==
X-Forwarded-Encrypted: i=1; AJvYcCV1wq9zIwvSaO3x/0DT4P78s2DFnTjacZCkNAOwunXi/Nau7QyxPxsF+I1NHYwF48Rp9lSr3k/fA2x4sr0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyNsFc3NQ0pjXxvZrGCqmHSUHQu5S1Nf85PON6bqsbUr8Fn/OaS
	AqakRSwA5WBj42IrGCXsppUDrmVXs/Zmrj8dasGIhZpSqHq61UFtWFWOXxqz5Zm4fw==
X-Gm-Gg: AeBDietoszCuxiGPWIePyVMP7YmHom8yJdJsrVUfy+mskPpOb+qKXN5aS0pZfecX29j
	WCbNQrf75EtZxcNpP5ButHM03A/rYTDPbYVDbHaISGaIEWdWQUhFx62dfrj5nqXTtyWIXlUrlAL
	bFOGbaqYRqTIG/Re39+IBGYvXYeL94AO9e3Ni3husRoSZ6kya9s0CV46C9klRJ+BiVdFO8QL4I2
	E+MUEAdoeeawk10Phv9xOUhydmAc4yDcwiJ2kBaK1NozkSa5dfff2Pdvj6FolOh7FdyW11aBQ2+
	CUEvYshSsBS7wW59W63eh5uSNGoGE1goHnYLB5UR9iubs+37bZd5+lxi82YrjKEb2c/I3/oXRV0
	/RqAjEVH5Ew6brkZYsgLxLbhtzcL32d/eamEDhFtZXm7KPu0C73QUdAfuLLB61VfnhRAhWzcT8y
	2wwL/cEBdV9qv6dm483BugUNaD70ZtUDDvIce9zaJAe+OjMmpkPLGggs/RDhlwYCP26cP/17bD5
	Ohb6bhTvg==
X-Received: by 2002:a05:7300:f190:b0:2c4:ec89:be0 with SMTP id 5a478bee46e88-2cbf9fe1d36mr7655035eec.9.1775517936536;
        Mon, 06 Apr 2026 16:25:36 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:c071:3b78:5a5:824a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca760b0518sm14730975eec.0.2026.04.06.16.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:25:35 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	maz@kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
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
Subject: [PATCH v5 5/9] driver core: Replace dev->dma_ops_bypass with dev_dma_ops_bypass()
Date: Mon,  6 Apr 2026 16:22:58 -0700
Message-ID: <20260406162231.v5.5.If62b84471ef2c85e7ad250f0468867d6dba965ab@changeid>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260406232444.3117516-1-dianders@chromium.org>
References: <20260406232444.3117516-1-dianders@chromium.org>
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
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Not fixing any known bugs; problem is theoretical and found by code
inspection. Change is done somewhat manually and only lightly tested
(mostly compile-time tested).

NOTE: even though previously we only took up a bit if
CONFIG_DMA_OPS_BYPASS, in this change I reserve the bit
unconditionally.  While we could get the "dynamic" behavior by
changing the flags definition to be an unnumbered "enum", Greg has
requested that the numbers be stable. This also allows us to move one
"#ifdef" to an "if", getting better compile-time testing of both sides
of the "if".

(no changes since v4)

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
index c38593cf2583..1c43ff695e83 100644
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
 
 #undef __create_dev_flag_accessors
 
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


